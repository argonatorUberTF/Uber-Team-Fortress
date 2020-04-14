#include "../gweapons.qc"
void () MTF_Setup_Monster =
{
	local float fls, rnd;
	local vector endp;
	self.is_monster = 1;
#ifdef mtf_coop_expsys
	if (self.#is_minion == #TRUE)
		self.team_no = 1;
	else
#endif
	self.team_no = 2;
#ifdef mtf_coop_expsys
	if (self.#is_minion != #TRUE)
#endif
	self.monster_string = "on";	// string identifier
	rnd = cvar ("monster_throwrunes");
	if (rnd == 0)
		rnd = .045;
	else if (rnd < 0)
		rnd = 0;
	else if (rnd > 1)
		rnd = 1;
	if (random() < rnd)
#ifdef mtf_coop_expsys
		if (self.#is_minion != #TRUE)
#endif
			Coop_ThrowRune();
	Inventory_SpawnMerchant( self.origin );
	if (self.monster_items == 0)
	{
		if (random() < .1)
		{
			self.monster_items = self.monster_items | MITEM_QUAD;
		}
		if (random() < .1)
		{
			self.monster_items = self.monster_items | MITEM_INVISIBLE;
		}
		if (random() < .1)
		{
			self.monster_items = self.monster_items | MITEM_SPEED;
		}
		if (random() < .1)
		{
			self.monster_items = self.monster_items | MITEM_MEGAHEALTH;
		}
		if (random() < .175)
		{
			rnd = random();
			if (rnd < .25)
				self.monster_items = self.monster_items | MITEM_FLAME;
			else if (rnd < .50)
				self.monster_items = self.monster_items | MITEM_ICE;
			else if (rnd < .75)
				self.monster_items = self.monster_items | MITEM_LIGHTNING;
			else
				self.monster_items = self.monster_items | MITEM_AIR;
		}
#ifndef NO_POWERSTEALER
		if (random() < .06)
		{
			self.monster_items = self.monster_items | MITEM_POWERSTEALER;
		}
#endif
#ifdef mtfcoop_uberhardmode
		if (uberhardmode) 
		{
			if (random() < .3)
			{
				// So certain monsters now detect spies
				self.monster_items = self.monster_items | MITEM_SPY_DETECTOR;
			}
		}
		else
#endif
		if (random() < .17)
		{
			self.monster_items = self.monster_items | MITEM_SPY_DETECTOR;
		}
	}
	if (self.weapon == 0)
	{
		if (self.classname == "monster_army")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_ROCKETLAUNCHER;
		if (self.classname == "monster_ogre")
				self.weapon = self.weapon | #MWEAPON_LRG;
		if (self.classname == "monster_ogre")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_MIRV;
		if (self.classname == "monster_demon1")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_FIREBALL;
		if (self.classname == "monster_hell_knight")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_FASTSHOT;
		if (self.classname == "monster_enforcer")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_SNIPER;
		if (self.classname == "monster_zombie")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_PLAGUE;
		if (self.classname == "monster_shambler")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_FLAME;	
		if (self.classname == "monster_wizard")
			if (random() < .35)
				self.weapon = self.weapon | #MWEAPON_BOUNCEMISSILE;	
	}
	if (self.monster_items & MITEM_QUAD)
	{
		self.effects = self.effects | EF_BLUE;
	}
	if (self.monster_items & MITEM_INVISIBLE)
	{
		self.old_model = self.model;
		setmodel(self, "progs/eyes.mdl");
		//self.effects = self.effects | 8;	// glow while invisible just aint as fun
	}
	if (self.monster_items & MITEM_SPEED)
	{
		self.effects = self.effects | EF_RED;
	}
	if (self.monster_items & MITEM_MEGAHEALTH)
	{
		self.effects = self.effects | 8;
	}
	if (self.monster_items & MITEM_FLAME)
	{
		fls = self.size_z + 15;
		endp = self.origin;
		endp_z += fls;
		newmis = spawn();
		newmis.owner = self;
		newmis.movetype = 9;
		newmis.solid = 0/*SOLID_NOT*/;
		newmis.effects = EF_RED;
		setmodel(newmis, "progs/flame2.mdl");
		setsize(newmis, '0 0 0', '0 0 0');
		setorigin(newmis, endp);
		newmis.orig_origin = self.origin;
		newmis.think = FlameMonster_Flame;
		newmis.nextthink = time + .1;
	}
	if (self.monster_items & MITEM_ICE)
	{
		fls = self.size_z + 15;
		endp = self.origin;
		endp_z += fls;
		newmis = spawn();
		newmis.owner = self;
		newmis.movetype = 9;
		newmis.solid = 0/*SOLID_NOT*/;
		newmis.effects = EF_BLUE;
#ifdef NEW_DOT
		setmodel(newmis, "progs/newdot.spr");
		newmis.frame = 0;
#else
		setmodel(newmis, "progs/dot1.spr");
#endif
		setsize(newmis, '0 0 0', '0 0 0');
		setorigin(newmis, endp);
		newmis.orig_origin = self.origin;
		newmis.think = FlameMonster_Flame;	// might as well use the same code
		newmis.nextthink = time + .1;
	}
	if (self.monster_items & MITEM_LIGHTNING)
	{
		fls = self.size_z + 15;
		endp = self.origin;
		endp_z += fls;
		newmis = spawn();
		newmis.owner = self;
		newmis.movetype = 9;
		newmis.solid = 0/*SOLID_NOT*/;
		newmis.effects = 8;
		setsize(newmis, '0 0 0', '0 0 0');
		setorigin(newmis, endp);
		newmis.orig_origin = self.origin;
		newmis.think = FlameMonster_Flame;	// might as well use the same code
		newmis.nextthink = time + .1;
	}
	if (self.monster_items & MITEM_AIR)
	{
		self.effects = self.effects | #EF_GREEN;
	}
	if (self.monster_items & MITEM_POWERSTEALER)
	{
		fls = self.size_z + 15;
		endp = self.origin;
		endp_z += fls;
		newmis = spawn();
		newmis.owner = self;
		newmis.movetype = 9;
		newmis.solid = 0/*SOLID_NOT*/;
		newmis.effects = EF_BLUE;
		setmodel(newmis, "progs/spikebal.mdl");
		setsize(newmis, '0 0 0', '0 0 0');
		setorigin(newmis, endp);
		newmis.orig_origin = self.origin;
		newmis.think = FlameMonster_Flame;	// might as well use the same code
		newmis.health = 20;
		newmis.armorvalue = 1;
		newmis.nextthink = time + .1;		
	}	
#ifndef mtf_coop_halflife
	if (cvar("sv_map_halflife") == 1 || #DOOM_MAP) {
		self.effects = 0; // makes wolf3d sprites have boxes on ezquake
	}
#endif
};
float (float orighp) MTF_Monster_Health =
{
	MTF_Setup_Monster ();
	return ( MTF_Monster_Health2(orighp) );
};
void () SUB_Remove;
void () MonsterLightningDamage =
{
	local float nhp;
	if (self.owner.health <= 0 || self.health <= 0)
	{
		self.think = SUB_Remove;
		dremove(self);
	}
	nhp = self.health;
	self.origin = self.owner.origin;
	WriteByte (MSG_BROADCAST, 23);
	WriteByte (MSG_BROADCAST, 9);
	WriteEntity (MSG_BROADCAST, self);
	WriteCoord (MSG_BROADCAST, self.owner.origin_x);
	WriteCoord (MSG_BROADCAST, self.owner.origin_y);
	WriteCoord (MSG_BROADCAST, self.owner.origin_z + 24);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	sound(self, 1, "weapons/lhit.wav", 1, 1);
	if (self.enemy.flags & FL_INWATER)
		T_Damage (self.owner, self, self.real_owner, 9);
	else
		T_Damage (self.owner, self, self.real_owner, 3);
	self.health = nhp - 1;
	if (self.health <= 0)
	{
		self.think = SUB_Remove;
		dremove(self);
	}
	self.nextthink = time + 2;
};
float (entity atckr, entity inflictor, entity targ, float origdmg) MTF_Monster_Damage =
{
	local entity flame, timer;
	local vector vtemp;
	local float s_mult, no_conc, entv;
#ifdef mtf_coop_expsys
	local float dmg_mult, crit_mult;
#endif
	s_mult = cvar ("monster_inflictdamage");
	if (!s_mult || s_mult == 0)
		s_mult = 1;
	if (survival_mode == 1) {
		s_mult = num_players * 0.15;
		s_mult+= 0.55;
		if (s_mult > 1.2)
			s_mult = 1.2;
	}
	else if (survival_mode == 2) {
		s_mult = .5 + (num_players * .15);
		if (s_mult > 1)
			s_mult = 1;
	}
	if (atckr == world || targ == world)
		return ( origdmg );
		
	if (atckr.team_no == targ.team_no && inflictor.is_minion == #TRUE)
		return ( 0 );
	if (atckr.monster_items & MITEM_QUAD)
	{
		if (atckr.super_sound < time)
		{
			atckr.super_sound = (time + 1);
			sound (atckr, 4, "items/damage3.wav", 1, 1);
		}
		origdmg *= 4;
	}
	if ( !(targ.rune_time > time && targ.#rune_type == #RUNE_ELERESIST) )
	{
		if (atckr.monster_items & MITEM_FLAME)
		{
				if (targ.numflames < TF_FLARE_OFF)
					flame = FlameSpawn("1", targ);
				else
					flame = FlameSpawn("3", targ);
				if (flame != world) {			// this caused a crashie before
					flame.classname = "fire";
					flame.health = 30;
					targ.numflames = targ.numflames + 1;
					flame.velocity = targ.velocity;
					flame.enemy = targ;
					flame.touch = OnPlayerFlame_touch;
					flame.owner = atckr;
					vtemp = targ.origin;
					setorigin(flame, vtemp);
					flame.nextthink = time + 0.1;
					flame.think = FlameFollow;
				}
				origdmg = ceil(origdmg * .2);
		}
		else if (atckr.monster_items & MITEM_ICE)
		{
			if (targ.classname == "player")
			{
				if (targ.tfstate & 32768)
				{
				}
				else
				{
					stuffcmd(targ, "v_cshift 125 0 255 100\n");
					targ.tfstate = targ.tfstate | 32768;
					timer = spawn();
					timer.nextthink = time + 15;
					timer.think = TranquiliserTimer;
					timer.classname = "timer";
					timer.owner = targ;
					timer.team_no = targ.owner.team_no;
					timer.is_monster = 1;
					TeamFortress_SetSpeed(targ);
				}
			}
		}
		else if (atckr.monster_items & MITEM_LIGHTNING && inflictor.classname != "timer" && atckr.last_saveme_sound < time)
		{
			if (atckr.is_monster == 1)
				atckr.last_saveme_sound = time + 1;
			timer = spawn();
			timer.health = 5;
			timer.nextthink = time + 2;
			timer.think = MonsterLightningDamage;
			timer.owner = targ;
			timer.real_owner = atckr;
			timer.classname = "timer";
		}
		else if (atckr.monster_items & MITEM_AIR && atckr.last_saveme_sound < time && targ.classname == "player")
		{
			if (atckr.is_monster == 1)
				atckr.last_saveme_sound = time + 1;
			flame = find(world, classname, "timer");
			while (flame != world)
			{
				if (flame.owner == targ)
					no_conc = 1;
				flame = find(flame, classname, "timer");
			}
			if (oldconc == 1 && no_conc == #FALSE)
			{
				timer = spawn ();
				timer.nextthink = time + 0.25;
				timer.think = ConcussionGrenadeTimer;
				timer.team_no = atckr.team_no;
				timer.classname = "timer";
				timer.owner = targ;
				timer.health = 400;
			}
			else if (no_conc == #FALSE)
			{
				stuffcmd(targ, "v_iroll_cycle 0.5\n");
				stuffcmd(targ, "v_ipitch_cycle 1\n");
				stuffcmd(targ, "v_iyaw_cycle 2\n");
				stuffcmd(targ, "v_idlescale 30\n");
				stuffcmd(targ, "bf\n");
				timer = spawn();
				timer.nextthink = time + 5;
				timer.think = ConcussionGrenadeTimer;
				timer.team_no = atckr.team_no;
				timer.classname = "timer";
				timer.owner = targ;
				timer.health = 10;
			}
		}
		if (atckr.monster_items & #MITEM_POWERSTEALER)
		{
			if (targ.rune_time > time) {
				origdmg = 0;
				targ.rune_time = time;
				sprint(targ, 2, "Your RUNE time was stolen by a ÐÏ×ÅÒÓÔÅÁÌÅÒ monster.\n");
				if (atckr.health > 0)
					atckr.health = atckr.health + 200;
			}
			else if (targ.invisible_finished > time) {
				origdmg = 0;
				targ.invisible_finished = time + 3;
				sprint(targ, 2, "Your INVISIBILITY was stolen by a ÐÏ×ÅÒÓÔÅÁÌÅÒ monster.\n");
				if (!(atckr.monster_items & MITEM_INVISIBLE)) {
					atckr.monster_items = atckr.monster_items | MITEM_INVISIBLE;
					atckr.old_model = atckr.model;
					setmodel(atckr, "progs/eyes.mdl");
				}
			}			
			else if (targ.super_damage_finished > time) {
				origdmg = 0;
				targ.super_damage_finished = time;
				sprint(targ, 2, "Your QUAD was stolen by a ÐÏ×ÅÒÓÔÅÁÌÅÒ monster.\n");
				if (!(atckr.monster_items & MITEM_QUAD)) {
					atckr.monster_items = atckr.monster_items | MITEM_QUAD;
					atckr.effects = atckr.effects | EF_BLUE;
				}
			}
			else if (targ.invincible_finished > time) {
				origdmg = 0;
				atckr.invincible_finished = time + (targ.invincible_finished - time);
				if ((atckr.invincible_finished - time) > 15)
					atckr.invincible_finished = 15;
				if (targ.invincible_finished >= (time+3)) {
					targ.invincible_finished = time + 3;
					sprint(targ, 2, "Your PENT time was stolen by a ÐÏ×ÅÒÓÔÅÁÌÅÒ monster - you have 3 seconds left!\n");
				}
				else
					{}				
			}			
		}	
	}
	if (targ.playerclass == 1) {
		entv = vlen(targ.velocity);
		if (entv > 350)
			origdmg *= .35;
		else if (entv > 500)
			origdmg *= .3;
		else if (entv > 700)
			origdmg *= .25;
		else
			origdmg *= .5;
	}
#ifdef mtf_coop_expsys
	dmg_mult = ( MTF_Coop_AttribGain ( targ, #ATTRIB_DAMAGE ) - 1) * .4;		// 04/02/08: was .5, but .4 seems somewhat less brutal..
	if ( random() <= .05 ) //((targ.crit_attr) * .045) )
		if (targ.crit_attr > 0)
			crit_mult = MTF_Coop_AttribGain( targ, #ATTRIB_CRIT ) * .5;
	else
		crit_mult = 0;

	s_mult = s_mult + dmg_mult + crit_mult;
#endif

	if ( targ.#rune_time > time )
		if ( targ.#rune_type == #RUNE_RESISTANCE )
			origdmg = origdmg * .35;
	
	return ( s_mult * (origdmg * 5) );
};
float (entity atckr, entity targ, float origdmg) MTF_Monster_Take_Damage =
{
	local float s_mult;
	s_mult = cvar ("monster_takedamage");
	if (!s_mult || s_mult == 0)
		s_mult = 1;
	if (survival_mode == 1) {
		s_mult = 4 / num_players;
		if (s_mult < 1)
			s_mult = 1;
	}
	else if (survival_mode == 2) {
		s_mult = 3.25 / num_players;
		if (s_mult < 1)
			s_mult = 1;
	}
#ifdef mtf_coop_expsys
	s_mult = s_mult * MTF_Coop_AttribGain( atckr, #ATTRIB_DAMAGE );
#endif
	if (atckr == world || targ == world)
		return ( origdmg );
	if (deathmsg == 3)	// MAC 10
		origdmg *= 2.75;
	if ( deathmsg == 4)	// Super N.G.
		origdmg *= 1.6;
	if ( deathmsg == 15 )		// Do fire resistance/weakness
	{
		origdmg *= .43;
		if (targ.monster_items & MITEM_FLAME)
			origdmg *= .37;	// if we're a flame monster, take less damage from fire
		else if (targ.monster_items & MITEM_ICE)
			origdmg *= 3;	// flame melts ice. gg. ;)
	}
	if ( deathmsg == 6 )		// Rocket Launcher
	{
		origdmg *= 1.05;
	}
	if (targ.#reset_other_attacker < time && targ.#reset_other_attacker != 0)
	{
		targ.#other_attacker = world;
		targ.#reset_other_attacker = 0;
	}	
	if (atckr.classname == "player" && targ.#other_attacker.classname != "player")
	{
		if (targ.#other_possible_atacker == atckr)
		{
			targ.#other_attacker_inflicted += origdmg;
		}
		else
		{
			targ.#other_possible_atacker = atckr;
			targ.#other_attacker_inflicted = origdmg;
		}
		if (targ.#other_attacker_inflicted > 125)			// if you inflict this damage or more, you share the exp from the kill
		{
			targ.#other_possible_atacker = world;
			targ.#other_attacker = atckr;
			targ.#reset_other_attacker = time + 15;
		}		
	}
	if ( atckr.#rune_time > time )
	{
		if ( Coop_IsMonster(targ, #MONSTERTYPE_NORMAL) ) {
			if ( atckr.#rune_type == #RUNE_VAMPRIC ) {	
				if ( atckr.health < atckr.max_health && atckr.health != 0 ) {
					atckr.health = atckr.health + ceil( origdmg * .23 );
					if (atckr.health > atckr.max_health)
						atckr.health = atckr.max_health;
				}
				if (targ.monster_items & MITEM_QUAD) {
					if (atckr.super_damage_finished < (time + 20))
						atckr.super_damage_finished = time + 2;
				}
				if (targ.monster_items & MITEM_INVISIBLE) {
					if (atckr.invisible_finished < (time + 20))
						atckr.invisible_finished = time + 2;
				}		
				if (targ.invincible_finished > time) {
					sprint(atckr, 2, "Your vampric rune negates the monster's invincibility.\n");
					targ.invincible_finished = time;
					if (atckr.invisible_finished < (time + 20))
						atckr.invisible_finished = time + 10;
				}					
			}
			if ( atckr.#rune_type == #RUNE_BERSERKER ) {
				if (self.current_weapon != 16 && self.current_weapon != 8 && self.current_weapon != 4 && self.current_weapon != 2) {}
				else
					origdmg *= 2.75;
			}
			if ( atckr.#rune_type == #RUNE_ARMOR ) {	
				if ( atckr.armorvalue < atckr.maxarmor ) {
					atckr.armorvalue = atckr.armorvalue + ceil( origdmg * .15 );
					if (atckr.armorvalue > atckr.maxarmor)
						atckr.armorvalue = atckr.maxarmor;
				}
			}
			if ( atckr.#rune_type == #RUNE_UBEREXP ) {	
				origdmg *= .5;
			}
		}
	}
	if (targ.invincible_finished >= time)
	{
		if (targ.invincible_sound < time)
		{
			sound(targ, 3, "items/protect3.wav", 1, 1);
			targ.invincible_sound = time + 2;
		}
		origdmg = 0;
	}	
#ifdef CSQC
	if (atckr.classname == "player")
		CSQC_SendMonsterbar( atckr, targ.health - origdmg, targ.max_health );
#endif
	return ( origdmg * s_mult );
};
string ( string pc_name/*, float m_type*/ ) mtf_savemodel =
{
	local float dfactor;
	dfactor = #RETURN_HEAD_NORMAL;
	if (mapname == "hip1m4")	// there's not a snowball's chance in hell this map will work anyways but whatever..
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "hip2m2")	// also doesnt work :(
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "hip2m4")
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "r2m4")
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "r2m5")
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "r2m6")
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "r1m5")
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "neh1m9" || mapname == "neh2m3")
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "qte1m3" || mapname == "qte1m4")
		dfactor = #RETURN_HEAD_ZOMBIE;
	else if (mapname == "qte2m2" || mapname == "qte2m3"/* || mapname == "qte2m4"*/)
		dfactor = #RETURN_HEAD_ZOMBIE;
	if (dfactor == #RETURN_HEAD_ZOMBIE)
		return ("progs/h_zombie.mdl");
	else
		return ( pc_name );	// not a Hipnotic map, return normal
};
float () Hipnotic_SaveModels2 =
{
	local float dfactor;
	dfactor = 0;
	if (mapname == "hip1m4")
		dfactor = 1;
	if (mapname == "hip2m2")
		dfactor = 1;
	if (mapname == "hip2m4")
		dfactor = 1;
	if (mapname == "r2m4")
		dfactor = 1;
	if (mapname == "r2m5")
		dfactor = 1;
	if (mapname == "r2m6")
		dfactor = 1;

	if (mapname == "qte1m3" || mapname == "qte1m4")
		dfactor = 1;
	if (mapname == "qte2m2" || mapname == "qte2m3"/* || mapname == "qte2m4"*/)
		dfactor = 1;

	if (mapname == "neh1m9" || mapname == "neh2m3")
		dfactor = 1;
	return ( dfactor );
};


void ( entity t_rune ) Coop_SetRune =
{
	local float rndm, i, maxrunes, r_type;
	maxrunes = 9;		// # of different runes in the mod
	r_type = 0;
	i = rint(random() * maxrunes);
	while (r_type == 0)
	{		
		rndm = random();
		if ( rndm < (1 / maxrunes) )
			r_type = i;
			
		if (i >= maxrunes)
			i = 1;
		else
			i++;
	}
	t_rune.#rune_time = 30;
	if (r_type == 1) {
		t_rune.weapon = 670 + #RUNE_EXPBONUS;
		t_rune.frame = 1;
	}
	else if (r_type == 2) {
		t_rune.weapon = 670 + #RUNE_VAMPRIC;
		t_rune.frame = 2;
	}
	else if (r_type == 3) {
		t_rune.weapon = 670 + #RUNE_RESISTANCE;
		t_rune.frame = 3;
	}
	else if (r_type == 4)
	{
		t_rune.weapon = 670 + #RUNE_BERSERKER;
		t_rune.frame = 4;
	}
	else if (r_type == 5)
	{
		t_rune.weapon = 670 + #RUNE_AMMO;
		t_rune.frame = 4;
		t_rune.effects = t_rune.effects & EF_RED;
	}
	else if (r_type == 6)
	{
		t_rune.weapon = 670 + #RUNE_ARMOR;
		t_rune.frame = 2;
		t_rune.effects = t_rune.effects & EF_RED;
	}
	else if (r_type == 7) {
		t_rune.weapon = 670 + #RUNE_UBEREXP;
		t_rune.frame = 1;
		t_rune.effects = t_rune.effects & EF_RED;
	}
	else if (r_type == 8) {
		t_rune.weapon = 670 + #RUNE_EXPLOSIVE;
		t_rune.frame = 4;
		t_rune.effects = t_rune.effects & EF_BLUE;
	}
	else if (r_type == 9) {
		t_rune.weapon = 670 + #RUNE_ELERESIST;
		t_rune.frame = 3;
		t_rune.effects = EF_BLUE;
	}
	else
	{
		bprint( 2, "Coop_SetRune: No rune type: " );
		bprint( 2, ftos( r_type ) );
		bprint( 2, "\n" );
	}
};

void () Coop_ThrowRune =
{
	newmis = spawn ();
	newmis.origin = (self.origin - '0 0 24');
	newmis.velocity_z = 3000;
	newmis.velocity_x = (-100 + (random () * 2000));
	newmis.velocity_y = (-100 + (random () * 2000));
	newmis.flags = 256;
	newmis.solid = 1;
	newmis.movetype = MOVETYPE_BOUNCE;
	setsize (newmis, '-16 -16 0', '16 16 56');
	setmodel(newmis, #MODEL_MONSTERDROP);
	newmis.effects = #EF_GREEN;
	newmis.noise = "items/protect.wav";
	Coop_SetRune(newmis);
	if (lms_entity != world) {
		newmis.nextthink = time + 30;
		newmis.think = SUB_Remove;
	}
	newmis.touch = PreMonsterItemTouch;
};

// Item(s) that monster drops on death
void ( entity monster, entity mkiller ) MTF_Monster_DropItem =
{
	local float pent_probability, rune_probability;
	local float spawn_cube;
	local float misc_modifier;
#ifdef mtf_coop_bonus
	local float exp_probability;
	misc_modifier = (0.01 * mkiller.misc_attr);
	exp_probability = .17;
#endif
#ifdef mtf_coop_expsys
	if (monster.#is_minion == #TRUE)		// minion monsters don't drop loot.
		return;
#endif
	if (monster.monster_items == 0)
		return;
#ifdef mtf_coop_expsys
	if (mkiller.playerclass == 8)		// Spy kills = better loot
	{
		if (random() < (.38 - misc_modifier))
			return;
	}
#else
	if (mkiller.playerclass == 8)		// Spy kills = better loot
	{
		if (random() < (.25 - misc_modifier) )
			return;
	}
#endif
	else
		if (random() < .45)
			return;
	if (survival_mode) {
		if (mkiller.frags > 200 && mkiller.frags < 240) {
			if (mapname == "08" || mapname == "04") {
				if (random() < .03)
					spawn_cube = 1;
			}
			else if (random() < .04) //Was .03 chance -arg
				spawn_cube = 1;
		}
	}
	pent_probability = .05;			// old: .04 3/4/13
	rune_probability = .05;
#ifdef mtf_coop_expsys
	if (mkiller.misc_attr > 0)
		pent_probability = 0.05 + (0.05 * mkiller.misc_attr);		// old: 0.05 and 0.05 3/4/13
	if (pent_probability > .55)
		pent_probability = .55;
#endif
	newmis = spawn ();
	newmis.origin = (self.origin - '0 0 24');
	newmis.velocity_z = 300;
	newmis.flags = 256;
	newmis.solid = 1;
	newmis.movetype = 6;
	setsize (newmis, '-16 -16 0', '16 16 56');
	if (random() < pent_probability)
	{
#ifdef mtf_coop_expsys
		if (checkmodelprecache("progs/invulner.mdl") == 1)
			setmodel(newmis, "progs/invulner.mdl");
		else
#endif
		setmodel(newmis, "progs/invisibl.mdl");
		newmis.effects = EF_RED;
		newmis.weapon = 7;
		newmis.noise = "items/protect.wav";
		newmis.items = 1048576;	
	}
#ifdef mtf_coop_halloween
	else if (random() < exp_probability)
	{
		newmis.weapon = 666;	// 50 exp
		if (random() < .20) {
			newmis.weapon = 667;	// 250 exp
			newmis.effects = EF_BLUE;
		}
		if (random() < .04) {
			newmis.weapon = 668;	// 1000 exp
			newmis.effects = EF_RED;
		}
		setmodel(newmis, "progs/potion2.mdl");
		newmis.noise = "items/protect.wav";
	}
#endif
#ifdef mtf_coop_birthday
	else if (random() < .02 && cake_dispensed == #FALSE && lms_entity == world)
	{
		cake_dispensed = #TRUE;
		newmis.weapon = 669;
		setmodel(newmis, #MODEL_CAKE);
		bprint(2, "CAKE! CAKE! CAKE!\n");
		bprint(2, "The CAKE is a LIE!\n");
		bprint(2, "... or is it?\n");
	}
#endif
#ifdef mtf_coop_bonus
	else if (random() < exp_probability && lms_entity == world)
	{
		setmodel(newmis, "progs/grenade3.mdl");
		newmis.skin = 1;
		newmis.effects = 8;
		newmis.weapon = 666;	// 50 exp
		if (random() < .20) {
			newmis.weapon = 667;	// 250 exp
			newmis.effects = EF_BLUE;
			newmis.skin = 2;
		}
		if (random() < .04) {
			newmis.weapon = 668;	// 1000 exp
			newmis.effects = EF_RED;
			newmis.skin = 3;
		}
		newmis.noise = "items/protect.wav";
	}
#endif
	else if (monster.monster_items & MITEM_QUAD)
	{
		setmodel(newmis, #MODEL_QUAD);
		newmis.weapon = 1;
		newmis.noise = "items/damage.wav";
		newmis.items = 4194304;
	}
	else if (monster.monster_items & MITEM_INVISIBLE)
	{
		setmodel(newmis, "progs/invisibl.mdl");
		newmis.weapon = 2;
		newmis.noise = "items/inv1.wav";
		newmis.items = 524288;
	}
	else if (monster.monster_items & MITEM_SPEED)
	{
		if (mkiller.playerclass == 9) {	// Spy kills = better loot
			if (random() > .1) {
				newmis.speed_time = 25;
				newmis.effects = newmis.effects | EF_RED;
			}
		}
		else {
			if (random() < .55) {
				newmis.speed_time = 20;
				newmis.effects = newmis.effects | EF_RED;
			}
		}
		setmodel(newmis, "progs/armor.mdl");
		newmis.skin = 1;
		newmis.weapon = 3;
	}
	else if (monster.monster_items & MITEM_MEGAHEALTH)
	{
		if (mkiller.playerclass == 9)		// Spy kills = better loot
		{
			if (random() > .1)
				newmis.weapon = 4;
		}
		else
			if (random() < .45)
				newmis.weapon = 4;
		if (newmis.weapon == 4) {
			setmodel(newmis, #MODEL_HEALTH_HUNDRED);
			newmis.noise = "items/r_item2.wav";
			newmis.healamount = 100;
			newmis.healtype = 2;
		}
		else	{
			newmis.weapon = 6;
			setmodel(newmis, "maps/b_bh25.bsp");
			newmis.noise = "items/health1.wav";
			newmis.healamount = 75;
			newmis.healtype = 1;
		}
	}
	else if (monster.monster_items & MITEM_FLAME || monster.monster_items & MITEM_ICE)
	{
		setmodel(newmis, "progs/armor.mdl");
		newmis.weapon = 5;
		newmis.skin = 2;
	}
	if (random() < rune_probability)
	{
		setmodel(newmis, #MODEL_MONSTERDROP);
		newmis.effects = #EF_GREEN;
		newmis.noise = "items/protect.wav";
		Coop_SetRune(newmis);
	}	
	if (spawn_cube)
	{
		bprint(2, "€A RESURRECTION CUBE has been dropped‚\n");
		setmodel(newmis, "progs/v_spike.mdl");
		newmis.weapon = 20;
		newmis.effects = #EF_GREEN;
		newmis.noise = "items/protect.wav";
	}
	if (mkiller.classname == "player")
	{
		newmis.#loot_owner = mkiller;
		newmis.#loot_owner_time = time + 10;
	}
	newmis.nextthink = time + 30;
	newmis.think = SUB_Remove;
	newmis.touch = PreMonsterItemTouch;
};
#ifdef mtf_coop_expsys
#include "tfi_tools.qc"
#include "mega_coop_rankings.qc"
#include "mega_coop_inv.qc"
#endif
void ( entity to_res ) MTF_Resurrect_Player =
{
	local entity oself;
	local entity head;
	local vector oorigin, oangle;
	local float bts;				// res player back to start of map?
	local float reconplaya;			// player disconnects then reconnects
	if (to_res.team_no == 0)
		reconplaya = 1;
	oself = self;
	if (self.classname == "player") {
		head = findradius (to_res.origin, 56);
		while (head) {
			if (head.solid > 0 && head != world && head.mdl != "progs/backpack.mdl" && !(head.flags & FL_ITEM))
			{
				if (survival_mode) {
					bts = #TRUE;
					break;
				}
				else {
					sprint(self, 2, "You can't resurrect ");
					sprint(self, 2, to_res.netname);
					sprint(self, 2, " from where he is. Remove all obstacles nearby first.\n");
					return;
				}
			}
			head = head.chain;
		}
	}
	oangle = to_res.angles;
	oorigin = to_res.origin;
	if (to_res.model == "progs/h_player.mdl" || (to_res.mins == '-16 -16 0' && to_res.maxs == '16 16 56'))	// is a gibbed head..
		oorigin_z = oorigin_z + 24;
	if (reconplaya == 0) {
		CopyToBodyQue(to_res);
		setspawnparms(to_res);
	}
	if (pointcontents(oorigin) == CONTENT_LAVA || pointcontents(oorigin) == CONTENT_SLIME || to_res.ammo_cells == 666)
		bts = #TRUE;
	self = to_res;
	if (reconplaya)
	{
	Menu_Team_Input(self.team_no); // Display menu, provide a team to choose. -arg
	//Get the keystroke for team number -arg
		//TeamFortress_TeamSet(1);
		// check to see if its possibly to ressurect the player to the team he was on before he died. -arg
		ResetMenu();
	}
	else
		PutClientInServer();
	self = oself;
	if (!bts) {
		setorigin(to_res, oorigin);
		to_res.angles = oangle;
	}
	if (survival_mode) {
		if (!reconplaya) {
			// ADDME: Set ammo/health/wtva in half!
			to_res.health = to_res.health * .75;  //was .5 -arg
			to_res.armorvalue = to_res.armorvalue * .75;
		}
	}
	if (self.classname == "player") {
		if (self.playerclass == 5)
			self.monsterweight = time + 30;
		else
			self.monsterweight = time + 60;
#ifdef mtf_coop_expsys				
		MTF_Coop_AddServiceExp( self, world, 6, #SRV_RESURRECT );
#endif
#ifdef mtf_coop_achievements
		Achievements_Change( self, world, ACHIEVEMENTS_ADD, ACHIEVEMENT_RESURRECT, 1 );
#endif
	}
	to_res.classname = "player";			// seems like the resurrect cube needs this
};
void () COOP_SetLives =
{
	local string temps;
	total_monsters += 1;
	if ( self.lives ) {
		self.lives = self.lives - 1;
		return;
	}
	temps = infokey (world, "monster_lives");
	self.lives = stof (temps);
	if (!self.lives)
		self.lives = 3;
#ifdef mtfcoop_uberhardmode
	if (uberhardmode) {
		self.lives = 999;
		self.#npc_spawndelay = 45;
	}
#endif
#ifdef mtf_coop_halflife
	if (#HL_MAP) {
		self.lives = 1;
		if (random() > .6) {
			self.lives = 2;
			self.#npc_spawndelay = 2;
		}
	}
#endif
	self.lives = self.lives - 1;
	if (self.classname == "monster_armagon" || self.classname == "monster_dragon"
		|| self.classname == "monster_ubs" || self.classname == "monster_azoth")
		self.lives = 1;
	if (mapname == "qte2m4" && self.classname == "monster_enforcer")
	{
		self.lives = 1;
	}
};
float ( string mname ) Coop_SpecialEnd =
{
	if ( mname == "office" )
		return 88;
	return 0;
};
void () COOP_PreSetupRespawn =
{
	local entity oself;
	oself = self;
	self = self.old_owner;
	COOP_SetupRespawn (self.#npc_spawndelay, self.#npc_spawnfunc);
	self = oself;
	dremove(self);
};
void () Coop_NewSpawnThink =
{
	self.solid = self.owner.solid;
	self.movetype = self.owner.movetype;
	setmodel (self, self.owner.model);
	if (self.owner.model == "progs/eyes.mdl")
		setmodel (self, self.owner.old_model);
	self.size = self.owner.size;
	self.mins = self.owner.mins;
	self.maxs = self.owner.maxs;
	self.classname = self.owner.classname;
	self.netname = self.owner.netname;
	self.angles_y = rint(random() * 360);
	self.th_stand = self.owner.th_stand;
	self.th_walk = self.owner.th_walk;
	self.th_run = self.owner.th_run;
	self.th_missile = self.owner.th_missile;
	self.th_pain = self.owner.th_pain;
	self.th_die = self.owner.th_die;
	self.th_fireball = self.owner.th_fireball;
	self.th_melee = self.owner.th_melee;
	self.targetname = self.owner.targetname;
	self.#is_warped = #TRUE;
	self.health = MTF_Monster_Health(1);
	self.health = self.owner.health;
	self.#npc_spawndelay = self.owner.#npc_spawndelay;
	self.#npc_spawnfunc = self.owner.#npc_spawnfunc;
	self.lives = self.owner.lives;
	if (!walkmove(TF_FLARE_LIT, TF_FLARE_LIT) || pointcontents(self.origin) == CONTENT_LAVA || pointcontents(self.origin) == CONTENT_SLIME )
	{
		dremove(self);
		return;
	}
	total_monsters += 1;
	WriteByte (MSG_ALL, 38);
	WriteByte (MSG_ALL, 12);
	WriteLong (MSG_ALL, total_monsters);
	coop_walkmonster_start();
};
void() coop_walkmonster_start =
{
	local entity monsterwarp, te;
	local float i, crazyspawn;
	if (CheckExistence() == #FALSE) {
		remove(self);
		return;
	}
#ifdef CSQC
	self.max_health = self.health;
#endif
	self.#npc_originalloc = self.origin;
	self.nextthink = self.nextthink + random()*0.5;
	self.think = walkmonster_start;
	if (!self.takedamage && self.health > 0) {
		self.takedamage = 2;
	}
	crazyspawn = cvar ("monster_crazyspawn");
	if (survival_mode == 2)
		crazyspawn = 1;
	if (self.classname == "monster_rider")				// disable multiple spawns for the(se) monster(s)
		crazyspawn = 0;
	if ( crazyspawn >= 1 && self.#is_warped == #FALSE ) {
#ifdef mtf_coop_lms
		if (lms_entity != world)
			return;
#endif
		while ( i <= crazyspawn) {
			monsterwarp = spawn();
			monsterwarp.size = self.size;
			monsterwarp.mins = self.mins;
			monsterwarp.maxs = self.maxs;
			monsterwarp.movetype = MOVETYPE_BOUNCE;
			if (survival_mode) {
				te = find(world,monster_string,"on");
				while (te)
				{
					if (random()<.07 ) {
						monsterwarp.owner = te;
						monsterwarp.origin = (te.origin/* - '0 0 24'*/);
						break;
					}
					te = find(te,monster_string,"on");
				}
			}
			if (monsterwarp.owner == world) {
			bprint(2,"mixing monsterspawn\n");
				monsterwarp.owner = self;
				monsterwarp.origin = (self.origin/* - '0 0 24'*/);
			}
			monsterwarp.velocity_z = 4000;
			monsterwarp.velocity_x = (-100 + (random () * 3000));
			monsterwarp.velocity_y = (-100 + (random () * 3000));
			monsterwarp.think = Coop_NewSpawnThink;
			monsterwarp.nextthink = time + 2.5;
			i++;
		}
		self.#is_warped = #TRUE;
	}
};
void() coop_flymonster_start =
{
	if (CheckExistence() == #FALSE) {
		remove(self);
		return;
	}
#ifdef CSQC
	self.max_health = self.health;
#endif
	
	self.#npc_originalloc = self.origin;
	self.nextthink = self.nextthink + random()*0.5;
	self.think = flymonster_start_go;
};
void() coop_swimmonster_start =
{
	if (CheckExistence() == #FALSE) {
		remove(self);
		return;
	}
	self.#npc_originalloc = self.origin;
	self.nextthink = self.nextthink + random()*0.5;
	self.think = swimmonster_start_go;
};
#ifdef mtf_coop_nehahra
.string soul;
#endif
void ( float preset_no, string n_name, void() spawnfunct) MTF_Setup_Monster_Presets =
{
#ifdef mtf_coop_nehahra
	self.soul = "yes";
#endif
	self.netname = n_name;
	if (preset_no == 0) {
	}
		self.monsterweight = #MWEIGHT_NORMAL;
		self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
		self.#monsterflag = #STRFLAG_MONSTER;
		self.#npc_origangle = self.angles;
		self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = spawnfunct;
	COOP_SetLives ();
	spawnfunct ();
};
void ( float w_health, void() movefunc) MTF_Setup_Monster_Postsets =
{
	if (w_health > 0)
		self.health = MTF_Monster_Health(w_health);
	else
		bprint(2, "monster health is 0??\n");
	movefunc();
};
string ( string c_name ) GetMonsterDeathstring =
{
	if ( c_name != "" ) {
#ifdef mtf_coop_nehahra
		if (c_name == "monster_qguy")
		{
			return (" is outgunned by a ");
		}
		if (c_name == "monster_baron")
		{
			return (" became the thrill kill of a ");
		}
		if (c_name == "monster_beard")
		{
			return (" was slain by ");
		}
		if (c_name == "monster_jagger")
		{
			return (" was jagged by a ");
		}
		if (c_name == "monster_cook")
		{
			if (random () < 0.5)
			{
				return (" becomes the next dish of a ");
			}
			else
			{
				return (" was panned to death by a ");
			}
		}
		if (c_name == "the_mister")
		{
			if (random () < 0.5)
			{
				return (" got owned by ");
			}
			else
			{
				return (" was put to shame by ");
			}
		}
		if (c_name == "monster_wraith")
		{
			return (" was killed by a ");
		}
		if (c_name == "monster_gaunt")
		{
			return (" was killed by a ");
		}
		if (c_name == "monster_enf2")
		{
			return (" was shot by a ");
		}
		if (c_name == "monster_enf3")
		{
			return (" was killed by an ");
		}
		if (c_name == "monster_library")
		{
			return (" was killed by an ");
		}
		if (c_name == "monster_archgaunt")
		{
			return (" was exterminated by an ");
		}
		if (c_name == "monster_oglib ")
		{
			return (" was killed by a rabid ");
		}
		if (c_name == "monster_hunter")
		{
			return (" was taken down by a ");
		}
		if (c_name == "monster_nehahra")
		{
			return (" was destroyed by ");
		}
#endif
	}
	return ( " was killed by a " );
};
void ( entity s_ent, string mname ) setmodelu =
{
	bprint ( 2, "WARNING: Unused model " );
	bprint ( 2, mname );
	bprint ( 2, " being set!\n" );
};
float ( entity t_mons ) Coop_Attackable =
{
	if (t_mons.classname == "func_monstergoal")
	{
		return #TRUE;
	}
	return #FALSE;
};
float ( entity t_mons, float m_type ) Coop_IsMonster =
{
	if (m_type == #MONSTERTYPE_NORMAL)	// an enemy monster who's not a minion and is alive
	{
		if ( t_mons.is_monster == #TRUE && t_mons.monster_string == "on" && t_mons.health > 0 && t_mons.is_minion == #FALSE )
			return #TRUE;
	}
	else if (m_type == #MONSTERTYPE_ANY)	// any monster, minion or otherwise, and is alive
	{
		if ( t_mons.is_monster == #TRUE && t_mons.health > 0 )
			return #TRUE;
	}
	return #FALSE;
};
void () MTF_Coop_ResetItems =
{
	if (self.mtf_items & MTFITEM_CROUCH)
		self.mtf_items -= MTFITEM_CROUCH;
};
#include "mtf_coop_monsterteam.qc"
float () Monsterteam_full =
{
	return #FALSE;
};
float (float mtype) Monsterclass_allow =
{
	if (mtype == 6)
		if (mclass_available & MC_SHAMBLER)
			return 1;
	if (mtype == 7)
		if (mclass_available & MC_FIEND)
			return 1;
	return 0;
};
void ( float mtype, float wepno ) Monsterweapon_setmodel =
{
	local string m_vwep;
	if (mtype == 6)
		if (self.current_weapon == 16) {
			sprint(self, 2, "Lightning attack selected.\n");
		}
		else 
			sprint(self, 2, "Claw attack selected.\n");
			
	self.weaponmodel = m_vwep;
};
void (float mclass) Monsterclass_add =
{
	if (!mclass_available & mclass)
		mclass_available = mclass_available + mclass;
};
void ( entity t_plyr, float mtype) Monsterteam_setmodel =
{
	local string m_model;
	if (mtype == 6)		// shammy
		m_model = "progs/ratsham5.mdl";
	else if (mtype == 7)
		m_model = "progs/demon.mdl";
	setmodel(t_plyr, m_model);
};
void () func_ladder;
void () trigger_ladder =
{
	func_ladder();
};
void () trigger_message_use =
{
	if (self.health == 0)
		bprint(2, self.noise1);
	else if (self.health == 1)
		bprint(2, self.noise2);
	else if (self.health == 2)
		bprint(2, self.noise3);
	else if (self.health == 3)
		bprint(2, self.noise4);		
	self.health++;
	if (self.health > 3)
		dremove(self);
};
void () trigger_message =
{
	if (!self.noise1) {
		bprint(2, "trigger_message: no noise1 message field\n");
		dremove(self);
	}
	self.health = 0;
	self.use = trigger_message_use;
};
void () trigger_sound_use =
{
	if (self.ammo_cells == 0) {
		sound(world, 4, self.noise1, 1, 0);
		dremove(self);
		return;
	}
};
void () trigger_sound =
{
	if (!self.noise1) {
		bprint(2, "trigger_sound: No noise1\n");
		dremove(self);
		return;
	}
	precache_sound(self.noise1);
	self.use = trigger_sound_use;
};
//END
