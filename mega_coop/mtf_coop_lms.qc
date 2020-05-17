#define LMS_PREMATCH_TIME	20		// amount of time players have before the first wave of monsters
#define LMS_MATCH_TIME		60		// how long players have until the next wave spawns.
#define LMS_LAST_LEVEL		last_level
#define LMS_REST_TIME		15		// rest time in between levels
#define spawnfunc th_fireball
#define spawn_starttime		speed_time
#define spawn_active		speed_finished
#define lms_starttime		monster_items
#define lms_level			lives
#define lms_startteamlives	ammo_shells
#define lms_replenish_lives	monster_items
#define lms_startmatch_numplayers	lms_entity.misc_attr
#define lms_override_speed	super_damage_finished
#define lms_disactivated	crit_attr
#define spawn_tries		monsterflags
#define alamo_active		speed_finished
#define alamo_lose_time		ammo_shells
#define lms_readfile 		reload_attr
void ( float m_level ) LMS_GetTargets;
void () lms_goalie_think;
void () spawnwave;
void ( entity newmon, float m_level ) GetMonsterSpawn;
void ( entity newmon, string newmon_cln ) SetSpawnFunc;
void ( entity m_precache ) SetupMonsterPrecache =
{
	local entity oself;
	oself = self;
	self = m_precache;
	m_precache.#spawnfunc ();
	m_precache.nextthink = time + 666;
	self = oself;
};
// set up everything and spawn the goalie (depending on game mode)
void () pre_spawnwave =
{
	local entity head;
	local float use_goalie;
	use_goalie = #TRUE;
	bprint( 2, "Last Man Standing is beginning! Setting team lives to: " );
	bprint( 2, ftos( self.#lms_startteamlives/* + ceil( (#lms_startmatch_numplayers - 1) * 1.25) */) );
	bprint( 2, "\n" );
	if (self.#lms_useroundlives > 0)
	{
		bprint( 2, "Player lives (per round): " );
		bprint( 2, ftos( self.#lms_useroundlives ) );
		bprint( 2, "\n" );
	}
	else
	{
		bprint( 2, "Player lives (global): " );
		bprint( 2, ftos( self.#lms_usegloballives ) );
		bprint( 2, "\n" );
	}
	lms_team1lives = self.#lms_startteamlives;// + ceil( (#lms_startmatch_numplayers - 1) * 1.25);
	head = nextent(world);
	while (head != world)
	{
		if (head.classname == "func_alamo")
		{ 
			// Alamo game mode found!
			use_goalie = #FALSE;
			if (head.netname_broadcast)
				bprint(2, head.netname_broadcast);
			break;
		}
		head = nextent(head); 
	}
	if (use_goalie == #TRUE)
	{
		newmis = spawn ();	// new entity to keep track of player lives (game goalie)
		newmis.#lms_startteamlives = self.#lms_startteamlives;
		newmis.think = lms_goalie_think;
		newmis.classname = "lms_goalie";
		newmis.nextthink = time + 5;
	}
	self.think = spawnwave;
	self.#lms_game_begun = #TRUE;		// now players can't join if #lms_usegloballives > 0
	LMS_GetTargets ( 1 );
	spawnwave();
};
void () wait_for_players =
{
	if (num_players > 0)
	{
		bprint( 2, "Last Man Standing: Waiting for all players to join (" );		// this is actually a lie :(
		bprint( 2, ftos( #LMS_PREMATCH_TIME ) );									/// PS I should add this feature for real.
		bprint( 2, " seconds)\n" );
		self.nextthink = time + #LMS_PREMATCH_TIME;
		self.think = pre_spawnwave;
	}
	else
	{
		self.think = wait_for_players;
		self.nextthink = time + 1;
	}
};
void () info_lmsdetect =
{
	local entity m_precache;
	#LMS_LAST_LEVEL = 14;
	local string fname, a;
	local float file, default_spawn;
	fname = frik_strcat( "maps/", mapname, ".tfi" );
	file = open (fname, 0);
	if ( file == -1 )
	{
		bprint( 2, "No .tfi for " );
		bprint( 2, mapname );
		bprint( 2, " - using default monster info\n" );
		self.#lms_readfile = #FALSE;
	}
	else
	{
	self.#lms_readfile = #TRUE;
	a = "";
	do
	{
			a = read (file);
			if ( a == "//END" )
			{
				bprint (2, "info_lmsdetect: Game rules not found in .tfi - fix your files!!\n");
				self.#lms_readfile = #FALSE;
				break;
			}
			if ( a == "// GAME RULES" )
			{
				a = read (file);
				a = read (file);
				self.#lms_startteamlives = stof(a);
				a = read (file);
				a = read (file);
				self.#lms_useroundlives = stof(a);
				a = read (file);
				a = read (file);
				self.#lms_usegloballives = stof(a);
				a = read (file);
				a = read (file);
				#LMS_LAST_LEVEL = stof(a);
				a = read (file);
				a = read (file);
				if (a == "default")
					default_spawn = #TRUE;
				break;
			}
		} while (1);
		close (file);
	}
	if (lms_entity != world)
	{
		bprint( 2, "info_lmsdetect: too many info_lmsdetect entities in this map - you only need one.\n" );
		dremove(self);
	}
	lms_entity = self;
	survival_mode = #FALSE;
	m_precache = spawn();
	self.goalentity = m_precache;
	if (self.#lms_readfile == #TRUE && default_spawn == #FALSE)
	{
		file = open (fname, 0);
bprint(2,"NOT using def spawn!\n");
		// Get monster precache's
		a = "";
		do
		{
			a = read (file);
			if ( a == "precache_end" )
			{
				dprint ("info_lmsdetect: Monsters precache'd!\n");
				break;
			}
			if ( a == "//END" )
			{
				bprint (2, "info_lmsdetect: Missing precache_end in .tfi - fix your file!\n");
				self.#lms_readfile = #FALSE;
				break;
			}
			if ( a == "precache_set" )
			{
				a = read (file);
				while (a != "precache_end" && a != "//END")
				{
					SetSpawnFunc( m_precache, a );
					SetupMonsterPrecache( m_precache );
					total_monsters -= 1;
					a = read (file);
				}
				break;
			}
		} while (1);
		close(file);
	}
	if (self.#lms_readfile == #FALSE || default_spawn == #TRUE)
	{
//bprint(2,"using def spawn!\n");
	m_precache.#spawnfunc = monster_army;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_dog;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_enforcer;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_demon1;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_knight;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_hell_knight;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_ogre;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_shalrath;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_tarbaby;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_wizard;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_zombie;
	SetupMonsterPrecache( m_precache );
	m_precache.#spawnfunc = monster_shambler;
	SetupMonsterPrecache( m_precache );
	total_monsters -= 13;  
	}
	dremove(m_precache);	// k, we're done precache'ing - bai!
	if ( self.#lms_startteamlives == 0 )
		self.#lms_startteamlives = 10;
	lms_team1lives = self.#lms_startteamlives;
	if (self.#lms_useroundlives == 0)
		self.#lms_useroundlives = 5;		// set a default value for lives per round (replenishes every round)
	if (self.#lms_usegloballives > 0)
		self.#lms_useroundlives = 0;		// set global lives for players only (look in tforttm.qc)
	self.#lms_starttime = time;
	self.#lms_level = 1;
	wait_for_players ();
};
float () lms_checklose =
{
	local entity te;	
	#lms_startmatch_numplayers = 0;
	te = find ( world, classname, "player" );
	while (te)
	{
		if (te.playerclass != 0/* || te.#lms_replenish_lives == 1 */)
			#lms_startmatch_numplayers = #lms_startmatch_numplayers + 1;
		te = find (te, classname, "player");
	}
	if ( lms_team1lives <= 0 || #lms_startmatch_numplayers == 0 )
	{
		lms_team1lives = -1;
		bprint(2, "BLUE TEAM HAS NO MORE LIVES - MONSTERS WIN\n");
		te = find ( world, classname, "func_monsterspawn" );
		while (te)
		{
			te.#spawn_active = 0;
			te = find (te, classname, "func_monsterspawn");
		}
		te = find ( world, classname, "info_lmsdetect" );
		while (te)
		{
			te.nextthink = time + 99999999;
			te = find (te, classname, "info_lmsdetect");
		}
		execute_changelevel ();
		self.nextthink = time + 999999999;
		return 1;
	}
	return 0;
};
void () lms_goalie_think =
{
	local float p_scale;
	if (lms_checklose() == #TRUE)
		return;
	p_scale = ( 0.15 * (#lms_startmatch_numplayers - 1) ) + 1;				// allow more monsters if there are more players (cuz they spawn faster)
	if ( (total_monsters - killed_monsters) > ceil(p_scale * 10) )
	{
		bprint( 2, "MONSTERS ARE OVER-RUNNING BLUE OUTPOST (" );
		bprint( 2, ftos( ceil(p_scale * 10) ) );
		bprint( 2, ") - ONE LIFE IS LOST!\n" );
		lms_team1lives = lms_team1lives - 1;
		bprint( 2, "REMAINING TEAM LIVES: " );
		bprint( 2, ftos( lms_team1lives ) );
		bprint( 2, "\n" );
	}
	self.think = lms_goalie_think;
	self.nextthink = time + 5;
};
void () spawnwave_resttime =
{
	if (self.noise2 != string_null)
	{		// match is over, lets do our end trigger
		self.noise3 = self.target;
		self.target = self.noise2;
		SUB_UseTargets ();
		self.target = self.noise3;
	}
	LMS_GetTargets ( self.#lms_level );
	local entity te;
	te = find ( world, classname, "func_monsterspawn" );
	while (te)
	{
		te.#spawn_active = 0;
		te = find (te, classname, "func_monsterspawn");
	}
	if (self.#lms_useroundlives > 0)
	{
		self.#lms_game_begun = #FALSE;
		te = find ( world, classname, "player" );
		while (te)
		{
			if (te.playerclass != 0 || te.#lms_replenish_lives == 1 )
			{
				te.#lms_lives = self.#lms_useroundlives;
				te.lives = -1;	// we don't use these..
			}

			te = find (te, classname, "player");
		}
	}
	if ( lms_team1lives <= 0 )
		return;
	bprint( 2, "WAVE " );
	bprint( 2, ftos( self.#lms_level - 1 ) );
	bprint( 2, " COMPLETE, PREPARE FOR NEXT WAVE!\n" );
	self.think = spawnwave;
	self.nextthink = time + #LMS_REST_TIME;
};
void () spawnwave =
{
	local entity te;
	local float exptotal;
	if ( lms_team1lives <= 0 )
		return;
	if (self.#lms_level == 0)
	{
		bprint( 2, "spawnwave: invalid lms level\n" );
		return;
	}
	if (self.#lms_level > #LMS_LAST_LEVEL)
	{
		bprint( 2, "PLAYERS WIN!\n" );
		Achievements_Change( world, world, ACHIEVEMENTS_GLOBALADD, ACHIEVEMENT_LMS, 1 );
		exptotal = floor(killed_monsters * 1.5);
		te = find ( world, classname, "player" );
		while (te)
		{
			if (te.coop_exp != -1 && /*te != other && */te.has_disconnected != 1)
			{
				MTF_Coop_AddExperience(te, world, exptotal);
				MTF_Coop_PreWriteExperience( te, te.connect_name, te.coop_exp );
				stuffcmd(te, "cmd sayexp\n");
			}
			te = find (te, classname, "player");
		}
		execute_changelevel ();
		self.nextthink = time + 999999999;
		return;
	}
	if (self.noise1 != string_null)
	{
		self.noise3 = self.target;
		self.target = self.noise1;
		SUB_UseTargets ();
		self.target = self.noise3;
	}
	self.#lms_game_begun = #TRUE;
	bprint( 2, "PREPARE FOR WAVE " );
	bprint( 2, ftos( self.#lms_level ) );
	bprint( 2, " OF LMS!\n" );
	te = find ( world, classname, "func_monsterspawn" );
	while (te)
	{
		te.#spawn_starttime = time;
		te.#lms_level = self.#lms_level;
		te.#spawn_active = 1;
		te = find (te, classname, "func_monsterspawn");
	}
	self.#lms_level++;			// xav: maybe move this to spawnwave_resttime?
	self.think = spawnwave_resttime;
	self.nextthink = time + #LMS_MATCH_TIME;
};
float ( float m_level ) GetLevelTiming =
{
	if ( lms_entity.#lms_override_speed > 0 )
	{
		return lms_entity.#lms_override_speed;
	}
	if ( m_level == 8 ) // lots and lots of dogs :D
		return .5;
	else
	if ( m_level == 5 ) // lots of zombies and knights :D
		return 1;
	else
	if ( m_level == 10 ) // spaaaaaawwwwwnnnnsssss
		return .85;
	else
	if ( m_level == 2 || m_level == 3 || m_level == 4 )
		return 1.25;
	else
	if ( m_level == 1 )
		return 1;
	else
	{
		if ( m_level > 12 )
			return 1.1;
		else
			return 1.25;//m_level * .5;
	}
};
void() monsterspawn_use =
{
	if (self.#lms_disactivated == #FALSE)
		self.#lms_disactivated = #TRUE;
	else
		self.#lms_disactivated = #FALSE;
};
void () func_monsterspawn =
{
	local float rndthink, rndspawn, p_scale;
	local entity newmon;
	local vector newang;
	self.use = monsterspawn_use;
	if ( !self.target )
		dprint( "func_monsterspawn: no target - can't tell monsters where to go!\n" );
	if ( self.#spawn_active == 0 || self.#lms_level == 0 )
	{
		self.nextthink = time + 1;
		self.think = func_monsterspawn;
		return;
	}
	rndspawn = random();
	rndthink = rint(random() * 6 + 1);
	newang_x = self.angles_x;
	newang_y = self.angles_y;
	self.#npc_origangle = newang;
	if ( ( rndspawn < .5  || self.#spawn_tries == 3 ) && self.#lms_disactivated == #FALSE )
	{
		self.#spawn_tries = 0;
		newmon = spawn();
		newmon.monster_string = "on";
		total_monsters += 1;
			WriteByte (MSG_ALL, 38);
			WriteByte (MSG_ALL, 12);
			WriteLong (MSG_ALL, total_monsters);
		newmon.target = self.target;
		GetMonsterSpawn( newmon, self.#lms_level );
		newmon.#npc_spawndelay = 1;
		newmon.angles = self.#npc_origangle;
		newmon.#npc_origangle = self.#npc_origangle;
		newmon.is_monster = 1;
		newmon.nextthink = time + 1;
		newmon.think = respawn_think;
		newmon.lives = -1;	// so we auto-remove the dead bodies (check respawn_think()) and so no exp is awarded till game's end
		if (mapname == "lms_keep")	// hack
			setorigin( newmon, self.origin + '0 0 65' );
		else
			setorigin( newmon, self.origin );
	}
	else
		self.#spawn_tries = self.#spawn_tries + 1;
	rndthink = rndthink * GetLevelTiming( self.#lms_level );
	p_scale = ( 0.15 * (#lms_startmatch_numplayers - 1) ) + 1;			// if more players, make monsters spawn faster
	rndthink = rndthink / p_scale;
	self.think = func_monsterspawn;
	self.nextthink = time + rndthink;
};
void ( entity newmon, float m_level ) GetMonsterSpawn =
{
	local float rnd;
	local string m_cln;
	rnd = random();
	local string lname, fname, a, a1, a2, a3;
	local float file, c1, c2, c3, tfid;
	lname = strcat( "level_", ftos(lms_entity.#lms_level - 1) );
	if ( lms_entity.#lms_readfile == #TRUE )
	{
		tfid = #TRUE;
		fname = frik_strcat( "maps/", mapname, ".tfi" );
		file = open (fname, 0);
		a = "";
		do
		{
			a = read (file);
			if ( a == "//END" )
			{
				bprint (2, "info_lmsdetect: No monsters found - add some!\n");
				self.#lms_readfile = #FALSE;
				break;
			}
			if ( a == lname )
			{
				a = read (file);
				a = read (file);
				lms_entity.#lms_override_speed = stof(a);
				a = read (file);
				a1 = a;
				a1 = strzone(a1);
				a = read (file);
				c1 = stof(a);
				a = read (file);
				a2 = a;
				a2 = strzone(a2);
				a = read (file);
				c2 = stof(a);
				a = read (file);
				a3 = a;
				a3 = strzone(a3);
				a = read (file);
				c3 = stof(a);
				break;
			}
		} while (1);
		close (file);
		while ( 1 )
		{
			if (rnd > c1)
				m_cln = a1;
			else
			if (rnd > c2)
				m_cln = a2;
			else
			if (rnd > c3)
				m_cln = a3;
			rnd = random();
			if ( m_cln == "" )
				dprint( "No monster in the .tfi has a probability of 0 - fix this!\n" );
			if ( m_cln != "monster_none" && m_cln != "")
				break;
		}
#ifdef DEBUG
dprint(m_cln );
dprint(" is spawning\n");
#endif
	}
	else
	{
	if ( m_level == 1 )
	{
		if (rnd > .7)
			m_cln = "monster_army";
		else
			m_cln = "monster_dog";
	}
	else
	if ( m_level == 2 )
	{
		if (rnd > .4)
			m_cln = "monster_army";
		else
			m_cln = "monster_dog";
	}
	else
	if ( m_level == 3 )
	{
		if (rnd > .4)
			m_cln = "monster_army";
		else
			m_cln = "monster_enforcer";
	}
	else
	if ( m_level == 4 )
	{
			m_cln = "monster_enforcer";
	}
	else
	if ( m_level == 5 )
	{
		if (rnd > .6)
			m_cln = "monster_zombie";
		else
			m_cln = "monster_knight";
	}
	else
	if ( m_level == 6 )
	{
		if (rnd > .4)
			m_cln = "monster_knight";
		else
			m_cln = "monster_hell_knight";
	}
	else
	if ( m_level == 7 )
	{
		if (rnd > .8)
			m_cln = "monster_ogre";
		else
	if (rnd > .3)
			m_cln = "monster_hell_knight";
		else
			m_cln = "monster_knight";
	}
	else
	if ( m_level == 8 )
	{
		m_cln = "monster_dog";		// really fast respawning dogs :p
	}
	else
	if ( m_level == 9 )
	{
		if (rnd > .8)
			m_cln = "monster_tarbaby";
		else
	if (rnd > .5)
			m_cln = "monster_ogre";
		else
			m_cln = "monster_hell_knight";
	}
	else
	if ( m_level == 10 )
	{
			m_cln = "monster_tarbaby";
	}
	else
	if ( m_level == 11 )
	{
		if (rnd > .5)
			m_cln = "monster_shalrath";
		else
			m_cln = "monster_knight";
	}
	else
	if ( m_level == 12 )
	{
		if (rnd > .7)
			m_cln = "monster_demon1";
		else
	if (rnd > .4)
			m_cln = "monster_shalrath";
		else
			m_cln = "monster_wizard";
	}
	else
	if ( m_level == 13 )
	{
		if (rnd > .5)
			m_cln = "monster_demon1";
		else
	if (rnd > .4)
			m_cln = "monster_shambler";
		else
			m_cln = "monster_wizard";
	}
	else
	if ( m_level == 14 )
	{
		if (rnd > .5)
			m_cln = "monster_shambler";
		else
			m_cln = "monster_zombie";
	}
	}
	SetSpawnFunc( newmon, m_cln );

	if (tfid == #TRUE)
	{
				strunzone(a1);
				strunzone(a2);
				strunzone(a3);
	}
};
void ( float m_level ) LMS_GetTargets =
{
	self.noise1 = string_null;
	self.noise2 = string_null;
	local string lname, fname, /*begin_targ, end_targ, */a;
	local float file;
	lname = strcat( "level_", ftos(m_level) );
	if ( lms_entity.#lms_readfile == #TRUE )
	{
		fname = frik_strcat( "maps/", mapname, ".tfi" );
		file = open (fname, 0);
		a = "";
		do
		{
			a = read (file);
			if ( a == "//END" || a == "// END" || a == string_null)	
			{
				bprint (2, "info_lmsdetect: No triggers detected - setting to null!\n");
				self.noise1 = string_null;
				self.noise2 = string_null;
				self.#lms_readfile = #FALSE;
				break;
			}
			if ( a == lname )
			{
				a = read (file);
				a = read (file);
				a = read (file);
				a = read (file);
				a = read (file);
				a = read (file);
				a = read (file);
				a = read (file);
				a = read (file);
				if (a == "trigger_start")
				{
					a = read (file);
					self.noise1 = a;
					self.noise1 = strzone(self.noise1);
				}
				else
					a = read (file);
				a = read (file);
				if (a == "trigger_end")
				{
					a = read (file);
					self.noise2 = a;
					self.noise2 = strzone(self.noise2);
				}
				else
					a = read (file);
				break;
			}
		}
		while (1);
		close (file);
	}
};
void () usemany_use =
{
bprint(2,self.netname);
bprint(2," is me name\n");
	self.target = "";
	if (self.noise1 != "")
	{
		self.target = self.noise1;
		SUB_UseTargets ();
	}
	if (self.noise2 != "")
	{
		self.target = self.noise2;
		SUB_UseTargets ();
	}
	if (self.noise3 != "")
	{
		self.target = self.noise3;
		SUB_UseTargets ();
	}
	if (self.noise4 != "")
	{
		self.target = self.noise4;
		SUB_UseTargets ();
	}
};
void () trigger_usemany =
{
	self.use = usemany_use;
};
void () monsterkill_use =
{
	if (activator.is_monster != 1)
		return;
	activator.deathtype = "monster_entkill";
	activator.health = -60;
	Killed(activator, self);
};
void () func_monsterkill =
{
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_NONE;
	if (!self.netname_broadcast)
		self.netname_broadcast = " ended up in the wrong place.\n";
	self.use = monsterkill_use;
};
void () lms_multi_touch =
{
	local entity te;
	if (other.is_monster != 1)
	{
		return;
	}
	if (other.health <= 0)
		return;
	if (!Activated(self, other))
	{
		if (self.else_goal != TF_FLARE_LIT)
		{
			te = Findgoal(self.else_goal);
			if (te)
			{
				DoResults(te, other, self.goal_result & 2);
			}
		}
		return;
	}
	if (self.movedir != '0 0 0')
	{
		makevectors(other.angles);
		if (v_forward * self.movedir < TF_FLARE_LIT)
		{
			return;
		}
	}
	self.enemy = other;
	multi_trigger();
};
void () monster_trigger_multiple =
{
	trigger_multiple();
	self.touch = lms_multi_touch;
};
void () monstergoal_think =
{
	local entity head;
	head = findradius(self.origin, 550);
	while (head)
	{
		if (head.is_monster == 1 && head.is_minion == 0 && head.health > 0/* && coop_visible(self, head)*/)
		{
			if (head.enemy != self && head.wooha != self && head.enemy.classname != "player" && head.enemy.classname != "func_monstergoal")
			{
				head.wooha = self;
			}
		}
		head = head.chain;
	}
	self.nextthink = time + 1;
};
void () monstergoal_pain =
{
	local entity te;
	if (!self.noise4)
		return;
	if (self.#next_warning_time > time)
		return;
	if (self.#last_health == self.health)
		return;
	if (self.noise3)
		bprint(2, self.noise3);
	te = find(world, classname, "player");
	while (te != world)
	{
		CenterPrint(te, self.noise4);
		te = find(te, classname, "player");
	}
	self.#last_health = self.health;
	self.#next_warning_time = time + 1;
};
void () monstergoal_prethink =
{
	self.team_no = 1;
	dremove(self.owner);
	self.classname = "building_sentrygun";
	self.team_no = 1;
	self.movetype = MOVETYPE_BOUNCE;
	setmodel(self,"progs/player.mdl");
	self.takedamage = 1;
	self.th_die = wall_killed;
	self.th_pain = monstergoal_pain;
	self.is_monster = 1;
	self.think = monstergoal_think;
	self.nextthink = time + 1;
};
void () func_monstergoal =
{
	local entity destroyme;
	setup_explodable ();
	self.solid = 4;
	self.movetype = 7;
	self.takedamage = 1;
	setorigin(self, self.origin);
	setmodel(self, self.model);
	destroyme = spawn();
	destroyme.solid = SOLID_BBOX;
	setsize (destroyme,  '-16.000000 -16.000000 -24.000000', '16.000000 16.000000 32.000000');
	destroyme.origin = ((self.mins+self.maxs)*.5);
	destroyme.owner = self;
	destroyme.think = monstergoal_prethink;
	destroyme.nextthink = time;
	setmodel(destroyme,"progs/player.mdl");
};
void () alamo_use =
{
	self.cnt = self.cnt - 1;
	if (self.cnt <= 0)
	{
		self.#alamo_active = #TRUE;
	}
};
void () alamo_touch =
{
	if (self.#alamo_active == #FALSE)
		return;
	if (self.#alamo_lose_time > time)
		return;
	if (other.is_monster != 1 && other.monster_string != "on")
		return;
	if (lms_team1lives < 0)
		return;
	self.#alamo_lose_time = time + 1;
	lms_team1lives = lms_team1lives - 1;
	if (self.noise3)
		bprint(2, self.noise3);
	bprint( 2, "REMAINING TEAM LIVES: " );
	bprint( 2, ftos( lms_team1lives ) );
	bprint( 2, "\n" );
	if (lms_checklose() == #TRUE)
		return;
	self.think = SUB_Null;
};
void () func_alamo =
{
	self.solid = 1;
	self.movetype = 7;
	setorigin(self, self.origin);
	setmodel(self, self.model);
	self.touch = alamo_touch;
	self.use = alamo_use;
};
void ( entity newmon, string newmon_cln ) SetSpawnFunc =
{
	newmon.classname = newmon_cln;
	if (newmon_cln == "monster_dog")
	{
		newmon.#spawnfunc = monster_dog;
		newmon.think1 = monster_dog1;
		newmon.netname = "rottweiler";
		newmon.classname = "monster_dog";
	}
	else
	if (newmon_cln == "monster_army")
	{
		newmon.#spawnfunc = monster_army;
		newmon.think1 = monster_army1;
		newmon.netname = "grunt";
		newmon.classname = "monster_army";
	}
	else
	if (newmon_cln == "monster_knight")
	{
		newmon.#spawnfunc = monster_knight;
		newmon.think1 = monster_knight1;
		newmon.netname = "knight";
		newmon.classname = "monster_knight";
	}
	else
	if (newmon_cln == "monster_hell_knight")
	{
		newmon.#spawnfunc = monster_hell_knight;
		newmon.think1 = monster_hell_knight1;
		newmon.netname = "hell knight";
		newmon.classname = "monster_hell_knight";
	}
	else
	if (newmon_cln == "monster_demon1")
	{
		newmon.#spawnfunc = monster_demon1;
		newmon.think1 = monster_demon2;
		newmon.netname = "fiend";
		newmon.classname = "monster_demon1";
	}
	else
	if (newmon_cln == "monster_shambler")
	{
		newmon.#spawnfunc = monster_shambler;
		newmon.think1 = monster_shambler1;
		newmon.netname = "shambler";
		newmon.classname = "monster_shambler";
	}
	else 
	if (newmon_cln == "monster_wizard")
	{
		newmon.#spawnfunc = monster_wizard;
		newmon.think1 = monster_wizard1;
		newmon.netname = "scrag";
		newmon.classname = "monster_wizard";
	}
	else
	if (newmon_cln == "monster_enforcer")
	{
		newmon.#spawnfunc = monster_enforcer;
		newmon.think1 = monster_enforcer1;
		newmon.netname = "enforcer";
		newmon.classname = "monster_enforcer";
	}
	else
	if (newmon_cln == "monster_shalrath")
	{
		newmon.#spawnfunc = monster_shalrath;
		newmon.think1 = monster_shalrath1;
		newmon.netname = "vore";
		newmon.classname = "monster_shalrath";
	}
	else
	if (newmon_cln == "monster_tarbaby")
	{
		newmon.#spawnfunc = monster_tarbaby;
		newmon.think1 = monster_tarbaby1;
		newmon.netname = "spawn";
		newmon.classname = "monster_tarbaby";
	}
	else
	if (newmon_cln == "monster_ogre")
	{
		newmon.#spawnfunc = monster_ogre;
		newmon.think1 = monster_ogre1;
		newmon.netname = "ogre";
		newmon.classname = "monster_ogre";
	}
	else
	if (newmon_cln == "monster_ogre_marksman")
	{
		newmon.#spawnfunc = monster_ogre;
		newmon.think1 = monster_ogre1;
		newmon.netname = "ogre";
		newmon.classname = "monster_ogre";		
	}
	else
	if (newmon_cln == "monster_zombie")
	{
		newmon.#spawnfunc = monster_zombie;
		newmon.think1 = monster_zombie1;
		newmon.netname = "zombie";
		newmon.classname = "monster_zombie";
	}
	else
	if (newmon_cln == "monster_scourge")
	{
		newmon.#spawnfunc = monster_scourge;
		newmon.think1 = monster_scourge1;
		newmon.netname = "centroid";
	}
	else
	if (newmon_cln == "monster_gremlin")
	{  //It was monster_gremlin here but swapped him for a scourge instead. -arg
		newmon.#spawnfunc = monster_scourge;
		newmon.think1 = monster_scourge1;
		newmon.netname = "centroid";
	}
	else
	if (newmon_cln == "monster_morph")
	{
		newmon.#spawnfunc = monster_morph;
		newmon.think1 = monster_morph1;
		newmon.netname = "morpher";
	}
	else
	if (newmon_cln == "monster_wrath")
	{
		newmon.#spawnfunc = monster_wrath;
		newmon.think1 = monster_wrath1;
		newmon.netname = "wrath";
	}
	else
	if (newmon_cln == "monster_juggernaut")
	{
		newmon.#spawnfunc = monster_juggernaut;
		newmon.think1 = monster_juggernaut1;
		newmon.netname = "juggernaut";
	}
	else
	if (newmon_cln == "monster_spider")
	{
		newmon.#spawnfunc = monster_spider;
		newmon.think1 = monster_spider1;
		newmon.netname = "poisonous spider";
	}
	else
	if (newmon_cln == "monster_corpse")
	{
		newmon.#spawnfunc = monster_spider;
		newmon.think1 = monster_spider1;
		newmon.netname = "poisonous spider";
	}
	else
	if (newmon_cln == "monster_enf2")
	{
		newmon.#spawnfunc = monster_enf2;
		newmon.think1 = monster_enf21;
		newmon.netname = "mark A gunner";
	}
	else
	if (newmon_cln == "monster_enf3")
	{
		newmon.#spawnfunc = monster_enf3;
		newmon.think1 = monster_enf31;
		newmon.netname = "mark B gunner";
	}
	else
	if (newmon_cln == "monster_axegrunt")
	{
		newmon.#spawnfunc = monster_axegrunt;
		newmon.think1 = monster_axegrunt1;
		newmon.netname = "axe grunt";
	}
	else
	if (newmon_cln == "fish")
	{
		newmon.#spawnfunc = monster_fish;
		newmon.think1 = monster_fish1;
		newmon.netname = "rotfish";
		newmon.classname = "monster_fish";
	}
	else
	{
//		bprint(2, "SetSpawnFunc: Invalid or unsupported monster classname: ");
//		bprint(2, newmon_cln );
//		bprint(2, " - fix your .tfi!\n" );
	}
};
//END
