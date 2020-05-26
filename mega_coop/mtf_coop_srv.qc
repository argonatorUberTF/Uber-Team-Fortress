#define SURVIVAL_NATIVE		1				// playing on a survival mode map
#define SURVIVAL_TOGGLE		2				// playing survival as an on-the-fly game mode
#define NUM_LIVING_PLAYERS					num_players
#define SF_AID_TRIGGERONLY					1			// activated only when triggered
#define SF_AID_RANDOMACTIVE					2			// randomly activate/deactivate this aidirector
#define SF_AID_TRIGGEREND					4			// waves only stop spawning when aidirector is triggered
float (entity mee) aid_findplayers =
{
	local entity te;
	local float foundyou;
	te = findradius(mee.origin, mee.distance);
	while (te)
	{
		if (te.classname == "player" && te.health > 0)
		{
			foundyou = 1;
			break;
		}
		te = te.chain;
	}
	if (foundyou)
		return 1;
	return 0;
};
void () aid_monsterspawn =
{
	local entity newmon, head;
	local float myspawns;
	local vector newang;
	self.owner = activator;
	head = nextent(world);
	while (head != world)
	{
		if (head.owner == self)
		{ 
			if (head.health > 0)
				myspawns++;
		}
		head = nextent(head); 
	}
	if (myspawns >= self.count)
		return;
	newang_x = self.angles_x;
	newang_y = self.angles_y;
	self.#npc_origangle = newang;
	newmon = spawn();
	newmon.monster_string = "on";
	total_monsters += 1;
	WriteByte (MSG_ALL, 38);
	WriteByte (MSG_ALL, 12);
	WriteLong (MSG_ALL, total_monsters);
	newmon.target = self.target;
	SetSpawnFunc( newmon, self.noise1 );
	newmon.#npc_spawndelay = 1;
	newmon.angles = self.#npc_origangle;
	newmon.#npc_origangle = self.#npc_origangle;
	newmon.is_monster = 1;
	newmon.nextthink = time + 1;
	newmon.think = respawn_think;
	newmon.lives = -1;	// so we auto-remove the dead bodies (check respawn_think()) and so no exp is awarded till game's end
	newmon.owner = self;
	setorigin( newmon, self.origin );
};
void () aidirector_monsterspawn =
{
	local entity m_precache;
	if (!self.targetname)
	{
		bprint(2, "aidirector_monsterspawn at ");
		bprint(2, vtos(self.origin));
		bprint(2, " has no targetname - FIXME\n");
		return;
	}
	if (!self.noise1)
{
		bprint(2, "aidirector_monsterspawn at ");
		bprint(2, vtos(self.origin));
		bprint(2, " has no monster class specified in noise1 property\n");
		return;
	}
	if (!self.count)
		self.count = 2;
	m_precache = spawn();
	SetSpawnFunc( m_precache, self.noise1 );
	SetupMonsterPrecache( m_precache );
	total_monsters -= 1;
	dremove(m_precache);
	self.use = aid_monsterspawn;
};
void () aid_end =
{
// wave complete
	if (self.owner.noise2)
	{		// trigger after wave ends
		self.target = self.owner.noise2;
		SUB_UseTargets();
	}
	dremove(self);		// gets rid of aidirector_monsterspawn ents that trigger this one
};
void () ai_director_think =
{
	local float next_t;
	next_t = random() * (self.owner.waitmax - self.owner.waitmin);
	if (!(self.owner.spawnflags & #SF_AID_TRIGGEREND))
	{
		if ( (time - self.health)  >= self.owner.pausetime )
		{
			self.think = aid_end;
		}
	}
	if (aid_findplayers(self) == 0)		// there have to be players around for the timer to progress (unless set otherwise ADDME)
	{
		self.health += (self.owner.waitmin + next_t);
	}
	else
		SUB_UseTargets ();
	self.nextthink = time + (self.owner.waitmin + next_t);
};
void () aid_activate =
{
	local entity ai_director;
	self.health = time;
	if (self.spawnflags & #SF_AID_TRIGGEREND)
		self.use = aid_end;
	if (!self.has_tesla)
	{
		ai_director = spawn();
		ai_director.owner = self;
		ai_director.target = self.target;
		ai_director.think = ai_director_think;
		ai_director.nextthink = time + 1;
		ai_director.health = self.health;
		ai_director.distance = self.distance;		// distance from the center of the trigger which a player needs to be in
		setorigin(ai_director, ((self.mins+self.maxs)*.5));			// only takes into account SOLID_BSP.. fix?
		self.has_tesla = #TRUE;
	}
	if (self.noise1)
	{		// trigger after wave ends
		self.target = self.noise1;
		SUB_UseTargets();
	}
	self.touch = SUB_Null;
};
void () aid_touch =
{	
	if (other.classname != "player" || other.health <= 0)
		return;
	aid_activate();
};
void () trigger_aidirector =
{
	if (!self.target)
	{
		bprint(2, "aidirector_monsterspawn with model ");
		bprint(2, self.model);
		bprint(2, " has no target - must target at least one aidirector_monsterspawn!\n");
		return;
	}
	if (self.spawnflags & #SF_AID_RANDOMACTIVE)
	{			// randomly enable/disable
		if (random() < .50)
			return;
	}
	if (!self.waitmin)
		self.waitmin = 3;
	if (!self.waitmax)
		self.waitmax = self.waitmin + 2;
	if (!self.pausetime)
		self.pausetime = 45;
	if (!(self.spawnflags & #SF_AID_TRIGGERONLY))
			InitTrigger();
	survival_mode = SURVIVAL_NATIVE;
	localcmd("localinfo srv_ips \"\"\n");
	self.use = aid_activate;
	if (!(self.spawnflags & #SF_AID_TRIGGERONLY))
		self.touch = aid_touch;
	if (!self.distance)
		self.distance = 800;
};
float () Survival_Fail =
{
	local entity te;
	local float survivors;
	if (self.classname == "player")
		if (self.monster_type != 0)
			return 0;
	if (!survival_mode)
	{
		bprint(2, "Survival_Fail: being called on non-survival game mode\n");
		return #FALSE;
	}
	if (survival_mode)
	{
		te = find(world, classname, "player");
		while (te)
		{
			if (te.health > 0 && te.current_menu != 2 && te.has_disconnected != #TRUE && te.monster_type == 0)
			{
				survivors++;
			}
			te = find(te, classname, "player");
		}
		if (!survivors)
{
			bprint(2,"No players left alive. Better luck next time!\n");
			execute_changelevel();
			return #TRUE;
		}
	}
	return #FALSE;
};
void () pdummy_think =
{
	local entity te, gte, oself, onewself;
#ifdef SRV_DEBUG
	local float found_player;
#endif
	local float fp;
	oself = self;
	if (self.health < 10)
		self.health = self.health - 1;
	if (self.health < 0)
		self.health = 0;
	if (self.monster_type == 1)
{			// awaiting disconnected player 
		if (self.real_owner != world)
			if (self.owner != self.real_owner)
			{
				// it's necessary.. stupid engine bug (?)
				self.owner = self.real_owner;
			}
		if (self.owner.has_tesla == 0)
		{
			self.nextthink = time + .5;			// we wait
			return;
		}
		else
{				// player has reconnected..
			onewself = self.owner;
			self.enemy = self.owner.real_owner;
		}
	}
	fp = 0;
	te = findradius(self.enemy.finaldest, 7000);
	while (te)
	{
		if (te.classname == "player" && te.health > 0)
		{
			fp = 1;
			break;
		}
		te = te.chain;
	}
	te = world;
	if (!fp && !intermission_running)
	{
		bprint(2, "********************** pdummy_think: player body fell out of map. d'oh\n");
		self.origin = self.enemy.finaldest;				// reset our origin to the last known spot where a player died
	}
	if (self.enemy == world)
	{
		bprint(2, "********************** pdummy_think: enemy is world\n");
		dremove(self);
		return;
	}
	if (self.monster_type == 0)
	{
		if (self.enemy.health != 1)
		{
//			bprint(2, "****************** pdummy_think: enemy health is not 1\n");
// This is a bad thing if it was a monster, however there are now teams 3 and 4 to account for
// So say nothing to alert people. carry on -arg
			dremove(self);  // remove the entity, it is most likely not a player? -arg
			return;
		}
	}
	if (self.origin_z < -4200)
{
		bprint(2, "pdummy_think: Body has fallen off map. TELL DEV\n");
		self.enemy.ammo_cells = 666;
		MTF_Resurrect_Player ( self.enemy );
		dremove(self);
		return;
	}
	te = findradius(self.origin, 325);
	while (te)
	{
		if (te.classname == "player" && te.health > 0)
		{
			self.health++;self.health++;
			if (te.playerclass == 5)
				self.health++;
			gte = te;
		}
		te = te.chain;
	}
	if (pointcontents(self.origin) == CONTENT_LAVA || pointcontents(self.origin) == CONTENT_SLIME || self.enemy.ammo_cells == 666)
{
		if (random() < .75)
			if (self.armorvalue > 28)
				sprint( self.enemy, 2, "Your body is disintegrating... you will respawn shortly...\n" );
			else
				sprint( self.enemy, 2, "Your body is disintegrating..\n" );
		self.armorvalue++;
		if (self.armorvalue > 45)
		{
			self.enemy.origin = self.origin + '0 0 1';
			te = self.enemy;
			self = gte;
			te.ammo_cells = 666; //Make extra sure that the flag to respawn at start is set. -arg
			MTF_Resurrect_Player ( te );
			self = oself;
			dremove(self);
			return;
		}
	}
	if (self.health > 9)
	{
		if (vlen(gte.origin - self.origin) <= 56)
{
			self.health = 10;
			sprint (gte, PRINT_HIGH, "You cannot stand on ");
			sprint (gte, PRINT_HIGH, self.enemy.netname);
			sprint (gte, PRINT_HIGH, " and resurrect him at the same time! Are you teabagging?\n");
			self.nextthink = time + .5;
			return;
// possibly add teabagging report when the enemy is standing on your corpse. no res'd for you!
		}
		centerprint(gte,"\n");
		if (self.enemy != world)
			centerprint(self.enemy, "\n");
		if (self.model == "progs/player.mdl")
			self.enemy.origin = self.origin + '0 0 1';
		else
if (self.model == "progs/h_player.mdl") 
			self.enemy.origin = self.origin + '0 0 24';
		te = self.enemy;
		self = gte;
	if (te.team_no == self.team_no)
		{
		MTF_Resurrect_Player ( te );
		self = oself;
		dremove(self);
		return;
		}
	}
	if (gte.classname == "player" && (te.team_no == self.team_no)) //Only res for same team_no -arg
	{
		centerprint(gte, "Resurrecting ", self.enemy.netname, ": ", ftos((self.health/10)*100), "%\n");
		centerprint(self.enemy, "You are being resurrected!\n\n", ftos((self.health/10)*100), "%\n");
	}
#ifdef SRV_DEBUG
	te = find(world, classname, "player");
	while (te)
	{
		if (vlen(te.origin - self.origin) < 4500)
		{
			found_player = 1;
		}
		te = find(te, classname, "player");
	}
	te = find(world, classname, "observer");
	while (te)
	{
		if (vlen(te.origin - self.origin) < 4500)
		{
			found_player = 1;
		}
		te = find(te, classname, "player");
	}
		
	if (!found_player)
	{
		self.enemy.origin = self.origin + '0 0 1';
		self.enemy.ammo_cells = 666;
		MTF_Resurrect_Player (self.enemy);
		dremove( self );
		return;
	}
#endif
	self.nextthink = time + .5;
};
//END
