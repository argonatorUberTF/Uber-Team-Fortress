#define nofixcount

#ifndef mtf_coop
#pragma DONT_COMPILE_THIS_FILE
#else
//============================================================================

float	spawner_noTriggerId;		// next id of a spawner without a targetname, so we can tell them apart

void() monster_spawner_spawn = {
	local entity	e, oself;
	local string	oldTarget;
	local float		maxCount, ftmp, rchance;

	// if lives are up, then all monsters are or have been spawned
	// only time this can happen is if this gets called too much
	// because we check below after we spawn if lives went to 0 and when a monster dies we also check then
	if ( !self.lives || self.cnt == self.count ) {
		// if OFF_AT_COUNT then make sure it's off
		if ( self.spawnflags & 32 ) {
			self.state = 0;
			self.think = SUB_Null;
		}
		return;
	}

	if ( !self.currentammo ) {
		objerror( "no valid monsters specified" );
		return;
	}

	// increase monster count
	self.cnt = self.cnt + 1;
	// subtract a life when a monster spawns
	self.lives = self.lives - 1;

	// if the new monster reaches our limit then stop spawning
	if ( self.cnt == self.count || !self.lives ) {
		// if OFF_AT_COUNT then turn it off
		if ( self.spawnflags & 32 )
			self.state = 0;
		self.think = SUB_Null;
	}

	e = spawn();
	e.target = self.targetname;
	e.angles = self.angles;
	if ( self.netname )
		e.targetname = self.netname;

	setorigin( e, self.origin );

	// find a monster to spawn
	oself = self;
	self = e;
	
	maxCount = 100;

	// .currentammo is checked for being zero before this is performed
	rchance = 1 / oself.currentammo;

	do {
		ftmp = 0;

		// call random multiple times to keep things easy and easy to add more monsters
		if ( oself.aflag & 1 && random() < rchance ){
			monster_zombie1();self.classname = "monster_zombie";}
		else if ( oself.aflag & 2 && random() < rchance ){
			monster_shambler1();self.classname = "monster_shambler";}
		else if ( oself.aflag & 4 && random() < rchance ){
			monster_knight1();self.classname = "monster_knight";}
		else if ( oself.aflag & 8 && random() < rchance ){
			monster_enforcer1();self.classname = "monster_enforcer";}
		else if ( oself.aflag & 16 && random() < rchance ){
			monster_demon2();self.classname = "monster_demon1";}
		else if ( oself.aflag & 32 && random() < rchance ){
			monster_army1();self.classname = "monster_army";}
		else if ( oself.aflag & 64 && random() < rchance ){
			monster_ogre1();self.classname = "monster_ogre";}
		else if ( oself.aflag & 128 && random() < rchance ){
			monster_shalrath1();self.classname = "monster_shalrath";}
		else if ( oself.aflag & 256 && random() < rchance ){
			monster_wizard1();self.classname = "monster_wizard";}
		else if ( oself.aflag & 512 && random() < rchance ){
			monster_dog1();self.classname = "monster_dog";}
		else if ( oself.aflag & 1024 && random() < rchance ){
			monster_fish1();self.classname = "monster_fish";}
		else if ( oself.aflag & 2048 && random() < rchance ){
			monster_hell_knight1();self.classname = "monster_hell_knight";}
		else if ( oself.aflag & 4096 && random() < rchance ){
			monster_tarbaby1();self.classname = "monster_tarbaby";}
		else {
			maxCount = maxCount - 1;

			// if we failed to spawn one then force one to spawn
			if ( !maxCount )
				rchance = 1;

			ftmp = 1;
		}
	} while ( ftmp );

	self = oself;

	// set monster specific things
	/*
	if ( self.targetname == #DEFAULT_SPAWNER_TARGETNAME )
		e.#npc_isCoopMonster = self.ammo_detpack;
	else
		e.#npc_isCoopMonster = 2;		// so we can tell spawned monsters from map monsters
	*/
	e.is_monster = 1;
	
	e.#npc_useTargetsOnRespawn = #TRUE;	// make sure we always fire our targets
	e.lives = 0;
	e.endtime = self.endtime;
	if ( self.team_no )
		e.team_no = self.team_no;

	// check for randomizing the spawn position
	if ( self.spawnflags & 1 || self.spawnflags & 2 || InSolid( e ) ) {
		maxCount = 100;

		while ( maxCount ) {
			if ( random() < 0.5 )
				e.origin_x = e.origin_x - random() * self.t_length;
			else
				e.origin_x = e.origin_x + random() * self.t_length;

			if ( random() < 0.5 )
				e.origin_y = e.origin_y + random() * self.t_length;
			else
				e.origin_y = e.origin_y - random() * self.t_length;

			setorigin( e, e.origin );

			// check for invalid positions
			traceline( e.origin, e.origin + '0 0 -8192', #TL_BSP_ONLY, e );

			// if spawnflags 2 is set, then the position must be visible to the spawner
			if ( trace_fraction == 1 || InSolid( e ) || ( self.spawnflags & 2 && !visible( e ) ) ) {
				setorigin( e, self.origin );
				maxCount = maxCount - 1;
			} else
				maxCount = 0;
		}
	}

	if ( self.spawnflags & 64 )
		e.angles = vectoangles( self.origin - e.origin );
	else if ( self.spawnflags & 128 )
		e.angles = vectoangles( e.origin - self.origin );

	spawn_tfog( e.origin );

	// fire event
	oldTarget = self.target;
	self.target = self.event;
	activator = e;
	SUB_UseTargets();
	self.target = oldTarget;

	// setup to spawn another monster if needed
	// don't worry about zero waits because those are done as they die
	if ( self.wait > 0 ) {
		if ( self.think )
			self.nextthink = time + self.wait;
	}
	e.#npc_spawndelay = 1;
	e.is_monster = 1;
	//e.nextthink = time + 1;
	//e.think = respawn_think;
	//e.team_no = 0;
	e.lives = -1;
	e.monster_string = "on";
	SetSpawnFunc(e, e.classname);
};

/*
================
monster_spawner_use

Gets called whenever this trigger gets fired or when
a monster that this trigger spawned has died.
================
*/
void() monster_spawner_use = {
	if ( self.classname != "monster_spawner" )
		return;

	// check if we're being used because of a monster death
	// map monsters can have a monster_spawner as a target and things will work fine
	//if ( COOP_IsCoopMonster( other ) && other.enemy == activator && other.#npc_isCoopMonster == self.ammo_detpack ) {
	if (other.is_monster == #TRUE) {
		self.cnt = self.cnt - 1;

		// since one died, the only way we can't spawn another one is
		// if our lives are up
		if ( !self.lives ) {
			// only remove it if all monsters are dead
			if ( !self.cnt ) {
				self.targetname = "";
				self.use = SUB_Null;
				self.nextthink = time + 0.1;
				self.think = SUB_Remove;
			} else
				self.think = SUB_Null;

			// fire our targets when a monster dies
			SUB_UseTargets();
			return;
		}

		// if spawning is enabled then spawn a new monster after the wait time
		if ( self.wait > 0 ) {
			if ( self.targetname == #DEFAULT_SPAWNER_TARGETNAME ) {
				self.nextthink = time + self.wait;
				self.think = monster_spawner_spawn;
			} else {
				if ( self.state ) {
					self.nextthink = time + self.wait;
					self.think = monster_spawner_spawn;
				} else
					self.think = SUB_Null;
			}
		} else if ( self.targetname == #DEFAULT_SPAWNER_TARGETNAME )
			monster_spawner_spawn();

		// fire our targets when a monster dies
		SUB_UseTargets();
		return;
	}

	// this should never happen, except if the map is trying to be funny
	// if targetname isn't present then the only time this should be fired is when one of our monsters die
	if ( self.targetname == #DEFAULT_SPAWNER_TARGETNAME )
		return;

	// check if we should be toggled on/off
	if ( self.wait > 0 ) {
		if ( !self.state ) {
			self.state = 1;
			self.nextthink = time + self.wait;
			self.think = monster_spawner_spawn;

			// the code below, if used, won't break as nextthink is reset when a spawned monster dies
			// and monster_spawner_spawn checks count and lives before spawning a monster
			// also state is managed in monster_spawner_spawn()

			// check if SPAWN_COUNT_TOGGLE or SPAWN_TOGGLE are set
			if ( self.spawnflags & 512 ) {
				// spawn up to count now that we're toggled on, this may not spawn any at all
				while ( self.cnt < self.count && self.lives )
					monster_spawner_spawn();
			} else if ( self.spawnflags & 256 ) {
				// spawn one right away (if we're suppose to)
				monster_spawner_spawn();
			}
		} else {
			self.state = 0;
			self.think = SUB_Null;
		}
	} else
		monster_spawner_spawn();
};

/*QUAKED monster_spawner (0 .5 .8) (-8 -8 -8) (8 8 8) RANDOM_POS VISIBLE_RANDOM_POS START_ON SPAWN_FIRST SPAWN_COUNT_FIRST OFF_AT_COUNT LOOK_AT LOOK_AWAY SPAWN_TOGGLE SPAWN_COUNT_TOGGLE
Spawns random monsters at random positions with a maximum and current limit.
If "targetname" and "wait" are set, then the trigger is toggled on/off, and defaults to off unless START_ON spawnflag is set.
If just "targetname" is set, then the only way for a monster to spawn is when the monster_spawner is fired.
If just "wait" is set, then monsters are continuously spawned according to "count" and "lives".
If neither "targetname" nor "wait" are set, then monsters spawn continuously and instantly according to "count" and "lives".
"count" specifies how many monsters are allowed to be spawned at once.
"lives" specifies the overall total number of monsters this can spawn.
"count" and "lives" always apply no matter how a monster is spawned.
"t_length" specifies the radius of the random monster placement if one of the random placement spawnflags are present or a monster spawns inside another.
"team_no" specifies the team the monsters will be on, if set to 1 then the monster count is not increased.
If "netname" is set, it will be the spawned monsters's "targetname" field.
If "endtime" is set, it will be copied to a monster when it spawns.
If "event" is set, it will fire all entities that have a matching "targetname" field when a monster spawns from the monster_spawner.
"aflag" specifies the monster(s) to spawn, if not set or zero then every monster type can potentially be spawned.
The monsters will face the angle of the monster_spawner.
The monster_spawner will fire it's targets every time a monster dies.
The monster_spawner removes itself once "lives" are used up and all spawned monsters have died.
*/
void() monster_spawner = {
	local entity	temp, oself;
	local float		ftmp;

	// this is stored in the #isCoopMonster field, so make sure it's greater than 1
	if ( !spawner_noTriggerId )
		spawner_noTriggerId = 2;

	if ( CheckExistence() == #FALSE ) {
		dremove( self );
		return;
	}

	if ( deathmatch ) {
		remove( self );
		return;
	}

	self.cnt = 0;
	self.state = 0;

	// make sure the spawner can't interact with anything
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;

	// check for invalids
	if ( self.spawnflags & 8 )
	if ( self.spawnflags & 16 )
		objerror( "spawn_first and spawn_count_first doesn't make sense" );

	if ( self.spawnflags & 4 ) {
		// only valid if targetname and wait are present
		if ( self.wait <= 0 || self.targetname == "" )
			objerror( "start_on is only valid if targetname and wait are set" );
	} else {
		if ( self.wait > 0 && self.targetname != "" )
		if ( self.spawnflags & 8 || self.spawnflags & 16 )
			objerror( "spawn_first and spawn_count_first are not valid without start_on when wait and targetname are set" );
	}

	if ( self.targetname )
	if ( self.target )
	if ( self.target == self.targetname )
		objerror( "target == targetname" );

	if ( self.wait <= 0 || self.targetname == "" ) {
		if ( self.spawnflags & 32 )
			objerror( "off_at_count is only valid if targetname and wait are set" );
		if ( self.spawnflags & 256 || self.spawnflags & 512 )
			objerror( "spawn_toggle and spawn_count_toggle are only valid if targetname and wait are set" );
	}

	// set the default random placement range
	if ( self.t_length <= 0 )
		self.t_length = 256;
	// set the default amount of monsters at a time
	if ( self.count <= 0 )
		self.count = 1;
	// set default lives
	if ( self.lives <= 0 )
		self.lives = 1;
	// endtime shouldn't be negative
	if ( self.endtime < 0 )
		self.endtime = 0;
	// default to all monsters
	if ( !self.aflag )
		self.aflag = 8191;
	// set the default targetname to notify us of monster deaths
	if ( self.targetname == #DEFAULT_SPAWNER_TARGETNAME )
		objerror( "invalid targetname for monster_spawner\n" );
	if ( !self.targetname ) {
		self.ammo_detpack = spawner_noTriggerId;
		spawner_noTriggerId = spawner_noTriggerId + 1;
		self.targetname = #DEFAULT_SPAWNER_TARGETNAME;
	} else
		self.ammo_detpack = 2;				// doesn't have to be unique if a targetname was specified

#ifndef nofixcount
	// only increase monster count if we're not on a team or we're not on team one
	if ( !self.team_no || !Teammate( self.team_no, 1 ) )
		total_monsters = total_monsters + self.lives;
#endif
	// first precache sounds and models
	temp = spawn();

	// preserve total_monsters
	ftmp = total_monsters;

	oself = self;
	self = temp;

	oself.currentammo = 0;
	if ( oself.aflag & 1 ) {
		monster_zombie();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 2 ) {
		monster_shambler();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 4 ) {
		monster_knight();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 8 ) {
		monster_enforcer();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 16 ) {
		monster_demon1();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 32 ) {
		monster_army();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 64 ) {
		monster_ogre();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 128 ) {
		monster_shalrath();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 256 ) {
		monster_wizard();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 512 ) {
		monster_dog();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 1024 ) {
		monster_fish();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 2048 ) {
		monster_hell_knight();
		oself.currentammo = oself.currentammo + 1;
	}
	if ( oself.aflag & 4096 ) {
		monster_tarbaby();
		oself.currentammo = oself.currentammo + 1;
	}

	self = oself;
	remove( temp );

	// setup to be triggered, even if no targetname, because we need to know when a monster dies
	self.use = monster_spawner_use;

	// check for START_ON
	if ( self.spawnflags & 4 ) {
		// state is only used when wait and targetname (toggle mode) are set
		self.state = 1;

		if ( self.spawnflags & 16 ) {
			do {
				monster_spawner_spawn();
			} while ( self.cnt < self.count && self.lives );
		} else {
			// spawn one right away
			if ( self.spawnflags & 8 )
				monster_spawner_spawn();

			self.nextthink = time + self.wait;
			self.think = monster_spawner_spawn;
		}
	} else if ( self.wait > 0 ) {	// if self.wait > 0 and self.targetname is set and START_ON isn't set, then we don't need to do anything
		if ( self.targetname == #DEFAULT_SPAWNER_TARGETNAME ) {
			if ( self.spawnflags & 16 ) {
				do {
					monster_spawner_spawn();
				} while ( self.cnt < self.count && self.lives );
			} else {
				// spawn one right away
				if ( self.spawnflags & 8 )
					monster_spawner_spawn();

				self.nextthink = time + self.wait;
				self.think = monster_spawner_spawn;
			}
		}
	} else if ( self.targetname == #DEFAULT_SPAWNER_TARGETNAME ) {
		do {
			monster_spawner_spawn();
		} while ( self.cnt < self.count && self.lives );
	} else {
		if ( self.spawnflags & 16 ) {
			do {
				monster_spawner_spawn();
			} while ( self.cnt < self.count && self.lives );
		} else {
			// spawn one right away
			if ( self.spawnflags & 8 )
				monster_spawner_spawn();
		}
	}

#ifndef nofixcount
	// reset total_monsters
	total_monsters = ftmp;
#endif
};


/*
=============
monsterteam_touch
=============
*/
void() monsterteam_touch = {
	local entity	te;

	if ( other.takedamage )
	if ( other.health <= 0 )
		return;
	if ( other.flags & FL_CLIENT )
		return;
	if ( !other.is_monster )
		return;				// not a coop monster
	if ( other.deadflag )
		return;

	if ( self.team_no ) {
		if ( other.team_no != self.team_no )
			return;			// wrong team
	}

	if ( self.targetname ) {
		if ( self.nextthink < time )
			return;			// not fired yet
		else {
			if ( self.spawnflags & 2 ) {
				if ( other == self.enemy ) {
					self.enemy = world;
					return;
				}
			} else if ( self.spawnflags & 4 ) {
				if ( other == self.enemy )	// if it's the activator, reset .enemy and fire the targets
					self.enemy = world;
				else					// some other monster besides the activator, just return
					return;
			}
		}
	}

	// tf goal code
	if (!Activated(self,other))
	{
		// If an else goal should be activated, activate it
		if (self.else_goal != 0)
		{
			te = Findgoal(self.else_goal);
			if (te)
				DoResults(te, other, (self.goal_result & 2/*#TFGR_ADD_BONUSES*/));
		}

		return;
	}

	// valid monster has touched the trigger
	if ( self.team )
		other.team_no = self.team;

	activator = other;
	SUB_UseTargets();				// could do some neat stuff here when a monster touches
};

/*
=============
monsterteam_use
=============
*/
void() monsterteam_use = {
	local entity	te;
	local float		numChanged;

	// don't allow non-players to fire the trigger if spawnflags 1 is present
	if ( self.spawnflags & 1 && !( activator.flags & FL_CLIENT ) )
		return;

	if ( self.event ) {
		numChanged = 0;

		te = find( world, targetname, self.event );
		while ( te ) {
			if ( ( te.deadflag == DEAD_NO && te.is_monster == 1/*COOP_IsCoopMonster( te )*/ ) || te.classname == "respawning monster" ) {
				if ( !( self.spawnflags & 2 ) || te != activator )
				if ( !( self.spawnflags & 4 ) || te == activator )
				if ( !self.team_no || te.team_no == self.team_no )
				if ( te.team_no != self.team ) {
					te.team_no = self.team;
					numChanged = 1;	// for now we don't care how many, just that some were
				}
			}

			te = find( te, targetname, self.event );
		}

		if ( numChanged )
			SUB_UseTargets();
	}

	// spawnflags 8 means no touch, so return if it's present
	if ( self.spawnflags & 8 )
		return;

	// spawnflags 2 changes every monster's team except the one that fired the trigger
	// spawnflags 4 changes only the activator's team
	if ( self.spawnflags & 2 || self.spawnflags & 4 )
		self.enemy = activator;

	self.nextthink = time + 0.2;
	force_retouch = 2;		// make sure even still objects get hit
	self.think = SUB_Null;
};

/*QUAKED trigger_monsterteam (.5 .5 .5) PLAYER_ONLY NOACTIVATOR ACTIVATOR_ONLY NOTOUCH
Gizmo - Any non-player owned monster touching this (unless the notouch spawnflag is set) will have it's team changed to the value in the "team" field if set. If the "team_no" field is set, only monsters belonging to the "team_no" team will have their team changed to the "team" field.
The trigger_monsterteam will fire it's targets if it has been touched and notouch isn't present (even if "team" isn't present), or if the trigger_monsterteam is fired and "event" is present and at least one monster (that isn't already on "team") is affected.
This trigger can have all the fields a trigger_relay can have for firing it's targets.

If the trigger_monsterteam has the "event" field, all monsters that have a matching "targetname" field will have their team set to "team" when fired, spawnflags and "team_no" still apply when this happens. Note that "event" works on monsters that are dead and are respawning but haven't respawned yet, whereas with touch this is not possible.
If the trigger_monsterteam has a "targetname" field, it will only change any monster's teams by touch or "event" when it has been fired.
If the trigger_monsterteam has a "targetname" the following spawnflags are valid:
Bit 1:	Can only be fired by players (IE: if a monster dies from another monster and the dead monster has a "target" matching the trigger_monsterteam's "targetname" the trigger_monsterteam will not be fired).
Bit 2:	Every monster except the monster that fired the trigger_monsterteam (and those filtered by the "team_no" field) can get their team changed.
Bit 4:	Only the monster that fired the trigger_monsterteam can get it's team changed, if it's "team_no" matches. (cannot be used in conjunction with 2)
Bit 8:	The trigger_monsterteam cannot be touched
*/
void() trigger_monsterteam = {
	if ( CheckExistence() == #FALSE ) {
		dremove( self );
		return;
	}

	if ( deathmatch ) {
		remove( self );
		return;
	}

	if ( self.event )
	if ( !self.targetname )
		objerror( "event without targetname doesn't do anything" );

	if ( self.spawnflags & 8 )
	if ( !self.targetname )
		objerror( "notouch without targetname would be useless" );

	if ( self.spawnflags & 2 && self.spawnflags & 4 )
		objerror( "noactivator and activator_only doesn't make sense" );

	InitTrigger();
	if ( !( self.spawnflags & 8 ) )
		self.touch = monsterteam_touch;
	self.use = monsterteam_use;
};
#endif
