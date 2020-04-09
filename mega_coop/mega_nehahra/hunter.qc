void () Hunter_Seniority =
{
	local entity head;
	local float meas;
	head = find (world, classname, self.classname);
	while (head)
	{
		if ((((head != self) && (self.aflag > head.aflag)) && (head.aether != '0 0 0')))
		{
			meas = vlen ((head.aether - self.aether));
			if ((meas < 300))
			{
				head.aether = '0 0 0';
				head.cnt = (head.cnt * -2);
			}
		}
		head = find (head, classname, self.classname);
	}
};
void () Aether_Handling =
{
	local entity mark;
	local vector spot1;
	local vector spot2;
	mark = self.enemy;
	if ((self.aether != '0 0 0'))
	{
		Hunter_Seniority ();
	}
	if ((self.cnt != 0))
	{
		self.cnt = (self.cnt + 1);
	}
	if (((self.cnt < 0) || (mark.health < 1)))
	{
		self.aether = '0 0 0';
		return;
	}
	if (((self.cnt == 0) && (self.aether == '0 0 0')))
	{
		if (Dist_Check (mark))
		{
			if (((mark.flags & FL_ONGROUND) && (mark.watertype > CONTENT_WATER)))
			{
				self.aether = mark.origin;
				self.cnt = 1;
			}
		}
	}
	if ((self.cnt > 30))
	{
		spot1 = self.aether + mark.view_ofs;
		spot2 = mark.origin + mark.view_ofs;
		traceline (spot1, spot2, 1, self);
		if (!(trace_inopen && trace_inwater))
		{
			if ((trace_fraction == 1))
			{
				self.cnt = (self.cnt - SOLID_TRIGGER);
				return;
			}
		}
		if (!Dist_Check_Low (self.aether))
		{
			return;
		}
		if (!Dist_Check_Low (self.origin))
		{
			return;
		}
		aether_navigate (self.aether);
		ai_face ();
		self.cnt = 0;
		self.aether = '0 0 0';
	}
	if ((self.aether == '0 0 0'))
	{
	}
};
void (vector selected) aether_navigate =
{
	local vector spot1;
	if ((selected == '0 0 0'))
	{
		return;
	}
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	spot1 = selected - '0 0 500';
	traceline (selected, spot1, 1, self);
	if (((trace_fraction != 1) && (pointcontents (trace_endpos) > CONTENT_SLIME)))
	{
		spawn_tfog (self.origin);
		spawn_tfog (selected);
		spawn_tdeath (selected, self);
		self.origin = (selected + '0 0 25');
	}
};
void (vector selected) old_aether_navigate =
{
	if ((selected == '0 0 0'))
	{
		return;
	}
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	if ((self.classname != "mmonster_hunter"))
	{
		spawn_tfog (self.origin);
		spawn_tfog (selected);
	}
	spawn_tdeath (selected, self);
	self.origin = (selected + '0 0 25');
};
float (entity concern) Dist_Check =
{
	local vector megadeth;
	megadeth = concern.origin - self.origin;
	if ((vlen (megadeth) > 1700))
	{
		return (1);
	}
	else
	{
		return (0);
	}
};
float (vector concern) Dist_Check_Low =
{
	local vector megadeth;
	megadeth = concern - self.enemy.origin;
	if ((vlen (megadeth) > 900))
	{
		return (1);
	}
	else
	{
		return (0);
	}
};
void () hunter_walk =
{
	if ((self.walkframe >= 11))
	{
		self.walkframe = 0;
	}
	if (((self.walkframe == 5) && (self.relations > 2)))
	{
		if ((self.objekt && (self.objekt.classname == "player")))
		{
			if (ai_checkobjdist (200))
			{
				self.walkframe = 0;
				hunter_boogie ();
				ai_walk (MOVETYPE_WALK);
				return;
			}
		}
	}
	parse_anim ( 31, hunter_walk );
	self.frame = (31 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_walk (8);
	if (((self.walkframe == 5) && (random () < 0.2)))
	{
		hunter_idlesound ();
	}
};
void () hunter_stand =
{
	local entity head;
	local entity mark;
	local float ded;
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
	}
	if (((self.walkframe == 3) && (random () < 0.1)))
	{
		hunter_idlesound ();
	}
	parse_anim ( 42, hunter_stand );
	self.frame = (42 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_stand ();
	if ((self.relations > 2))
	{
		return;
	}
	mark = world;
	ded = 0;
	head = find (world, classname, "player");
	while (head)
	{
		if ((head.health > 2))
		{
			mark = head;
		}
		else
		{
			if ((ded == 0))
			{
				self.objekt = head;
				ded = 1;
			}
		}
		head = find (head, classname, "player");
	}
	if ((mark != world))
	{
		self.enemy = mark;
		self.th_run ();
		self.cnt = -20;
		return;
	}
};
void () hunter_oltstand =
{
	local entity head;
	local entity mark;
	local float ded;
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
	}
	if (((self.walkframe == 3) && (random () < 0.1)))
	{
		hunter_idlesound ();
	}
	parse_anim ( 42, hunter_stand );
	self.frame = (42 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_stand ();
	if ((self.relations > 2))
	{
		return;
	}
	mark = world;
	ded = 0;
	head = find (world, classname, "player");
	while (head)
	{
		if ((head.health > 2))
		{
			mark = head;
		}
		else
		{
			if ((ded == 0))
			{
				self.objekt = head;
				ded = 1;
			}
		}
		head = find (head, classname, "player");
	}
	if ((mark != world))
	{
		self.enemy = mark;
		self.th_run ();
		self.cnt = -20;
		return;
	}
};
void () hunter_boogie =
{
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
		if (self.objekt)
		{
			if (!ai_checkobjdist (200))
			{
				hunter_walk ();
				return;
			}
		}
	}
	parse_anim ( 16, hunter_boogie );
	self.frame = (16 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_walk (20);
	if ((self.walkframe == 3))
	{
		ai_objledge ();
	}
};
void () hunter_back =
{
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
		self.touch = objekt_touch;
		parse_anim ( 45, hunter_stand );
		return;
	}
	if (((self.walkframe == 3) && (random () < 0.1)))
	{
		hunter_idlesound ();
	}
	parse_anim ( 16, hunter_back );
	self.frame = (21 - self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_back (8);
};
void () hunter_run =
{
	if ((self.walkframe == 0))
	{
		if (borkfactor1 ())
		{
			return;
		}
	}
	if ((self.relations < 2))
	{
		Aether_Handling ();
	}
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
	}
	parse_anim ( 16, hunter_run );
	self.frame = (16 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	if (((self.walkframe == 3) && (random () < 0.1)))
	{
		hunter_idlesound ();
	}
	if (((self.relations > 2) && (self.enemy != world)))
	{
		if (((self.enemy.classname != "player") && !visible (self.enemy)))
		{
			self.enemy.enemy = world;
			self.enemy = world;
			self.th_stand ();
			return;
		}
	}
	ai2_run (23);
};
void () hunter_die =
{
	local float num;
	if ((self.health < -35))
	{
		if ((skill == 0))
		{
			hunter_dropbackpack ();
		}
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead (mtf_savemodel("progs/h_hunter.mdl"), self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	self.walkframe = 0;
	self.solid = SOLID_NOT;
	parse_anim ( 1, hunter_diea1 );
	num = random ();
	if ((num < 0.4))
	{
		sound (self, CHAN_VOICE, "hunter/die2.wav", 1, ATTN_NORM);
	}
	else
	{
		if ((num < 0.7))
		{
			sound (self, CHAN_VOICE, "hunter/die3.wav", 1, ATTN_NORM);
		}
		else
		{
			sound (self, CHAN_VOICE, "hunter/die1.wav", 1, ATTN_NORM);
		}
	}
};
void () hunter_diea1 =
{
	if ((self.walkframe >= 7))
	{
		parse_anim ( 9, hunter_diea2 );
		hunter_dropbackpack ();
		return;
	}
	parse_anim ( 2, hunter_diea1 );
	self.frame = (2 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () hunter_diea2 =
{
	if ((self.method == -1))
	{
		dead_stay_dead ();
		hunter_diea3 ();
		return;
	}
	self.nextthink = ((time + 20) + (100 * random ()));
	self.think = hunter_respawn;
};
void () hunter_diea3 = [ 9, hunter_diea3 ]
{};
void () hunter_respawn =
{
	local entity spot;
	spot = SelectSpawnPoint ();
	self.state = 0;
	self.health = 120;
	self.th_stand = hunter_stand;
	self.th_walk = hunter_walk;
	self.relations = 0;
	self.enemy = find (world, classname, "player");
	self.angles = spot.angles;
	ai_teleport (self, spot.origin);
	carnify_hunter ();
};
void () hunter_pain =
{
	if ((self.pain_finished > time))
	{
		self.th_run ();
		return;
	}
	self.pain_finished = (time + 0.6);
	self.walkframe = 0;
	parse_anim ( 10, hunter_pain2 );
};
void () hunter_pain2 = [ 11, hunter_pain3 ]
{
	if ((random () < 0.3))
	{
		sound (self, CHAN_VOICE, "hunter/pain2.wav", 1, ATTN_NORM);
	}
	else
	{
		sound (self, CHAN_VOICE, "hunter/pain1.wav", 1, ATTN_NORM);
	}
};
void () hunter_pain3 = [ 12, hunter_pain4 ]
{};
void () hunter_pain4 = [ 13, hunter_pain5 ]
{};
void () hunter_pain5 = [ 14, hunter_pain6 ]
{};
void () hunter_pain6 =
{
	if (visible (self.enemy))
	{
		parse_anim ( 15, hunter_fire );
	}
	parse_anim ( 15, hunter_run );
};
void () hunter_fire =
{
	if (borkfactor1 ())
	{
		return;
	}
	self.walkframe = 0;
	if (((random () < 0.3) || (self.impulse < 4)))
	{
		if (((self.impulse > 1) && (self.impulse != 4)))
		{
			hunter_rapid ();
			return;
		}
	}
	parse_anim ( 22, hunter_fire2 );
	ai_face ();
	ai_threats ();
};
void () hunter_fire2 = [ 23, hunter_fire3 ]
{
	ai_face ();
	ai_threats ();
};
void () hunter_fire3 = [ 24, hunter_fire4 ]
{
	ai_face ();
	ai_threats ();
};
void () hunter_fire4 = [ 25, hunter_fire5 ]
{
	self.effects = (self.effects | EF_MUZZLEFLASH);
	if (((self.impulse < 2) || (self.impulse == 4)))
	{
		Mons_fire_shotgun ();
	}
	else
	{
		Mons_fire_sprocket ();
		ai2_jumpsplash (-200, '0 0 250');
	}
	ai_threats ();
};
void () hunter_fire5 = [ 26, hunter_fire6 ]
{
	ai_threats ();
};
void () hunter_fire6 = [ 27, hunter_run ]
{};
void () hunter_rapid = [ 24, hunter_rapid2 ]
{
	ai_threats ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	if (((self.impulse == 6) || (self.impulse == 3)))
	{
		Mons_fire_nails ();
	}
	else
	{
		Mons_fire_shotgun2 ();
	}
};
void () hunter_rapid2 =
{
	visible (self.enemy);
	if ((visible (self.enemy) && (self.enemy.health > 0)))
	{
		if (!ai_checkdist ())
		{
			parse_anim ( 25, hunter_rapid );
			ai_face ();
			ai_threats ();
			return;
		}
	}
	parse_anim ( 25, hunter_run );
	ai_face ();
};
void () monster_hunter1 =
{
	self.aether = '0 0 0';
	self.aflag = vlen (self.origin);
	self.th_wins = hunter_respect1;
	if ((self.brain & BLINK))
	{
		self.brain = (self.brain - BLINK);
	}
	if ((self.state == 1))
	{
		self.th_stand = hunter_wait;
		self.th_walk = hunter_walk;
		self.state = 0;
	}
	else
	{
		self.th_stand = hunter_stand;
		self.th_walk = hunter_walk;
	}
	self.th_run = hunter_run;
	self.th_missile = hunter_fire;
	self.th_runfire = hunter_runfire1;
	self.th_pain = hunter_pain;
	self.th_die = hunter_die;
	if ((self.relations > 2))
	{
		self.th_back = hunter_back;
	}
	if ((self.brain & TRIGGER_SPAWN))
	{
		self.use = hunter_startt;
		return;
	}
	carnify_hunter ();
};
void () monster_hunter =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/s_spike.mdl");
	precache_model ("progs/sprocket.mdl");		//xav: needs this.
	precache_model ("progs/hunter.mdl");
	precache_model (mtf_savemodel("progs/h_hunter.mdl"));
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");
	precache_sound ("player/udeath.wav");
	precache_sound ("hunter/idle1.wav");
	precache_sound ("hunter/idle2.wav");
	precache_sound ("hunter/idle3.wav");
	precache_sound ("hunter/die1.wav");
	precache_sound ("hunter/die2.wav");
	precache_sound ("hunter/die3.wav");
	precache_sound ("hunter/talk1.wav");
	precache_sound ("hunter/talk2.wav");
	precache_sound ("hunter/yell1.wav");
	precache_sound ("hunter/yell2.wav");
	precache_sound ("hunter/pain1.wav");
	precache_sound ("hunter/pain2.wav");
	MTF_Setup_Monster_Presets ( 0, "hunter", monster_hunter1 );
};
void () hunter_startt =
{
	trigger_spawnmonster ();
	carnify_hunter ();
};
void () carnify_hunter =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/hunter.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	if (!self.health)
	{
		self.health = 120;
	}
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () hunter_wait =
{
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
	}
	parse_anim ( 42, hunter_wait );
	self.frame = (42 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_stand ();
};
void () hunter_respect1 =
{
	if ((random () < 0.2))
	{
		hunter_respect0 ();
	}
	else
	{
		self.th_stand ();
	}
};
void () hunter_respect0 =
{
	if ((self.walkframe >= 11))
	{
		self.walkframe = 0;
		hunter_respect2 ();
		return;
	}
	parse_anim ( 47, hunter_respect0 );
	self.frame = (47 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_stand ();
};
void () hunter_respect2 =
{
	if ((self.walkframe >= 11))
	{
		self.walkframe = 0;
		self.th_stand ();
		return;
	}
	parse_anim ( 47, hunter_respect2 );
	self.frame = (57 - self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_stand ();
};
void () hunter_dropbackpack =
{
	if (((self.impulse != 3) && (self.impulse != 6)))
	{
		self.ammo_shells = 20;
	}
	else
	{
		self.ammo_nails = 25;
	}
	if ((self.impulse > 3))
	{
		self.ammo_rockets = 10;
	}
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	DropBackpack ();
};
void () hunter_idlesound =
{
	local float num;
	num = random ();
	if ((self.enemy != world))
	{
		if (visible (self.enemy))
		{
			if ((num < 0.4))
			{
				sound (self, CHAN_VOICE, "hunter/yell1.wav", 0.6, ATTN_NORM);
				return;
			}
		}
		else
		{
			if ((num < 0.2))
			{
				sound (self, CHAN_VOICE, "hunter/talk1.wav", 0.8, ATTN_NORM);
			}
			else
			{
				if ((num < 0.6))
				{
					sound (self, CHAN_VOICE, "hunter/talk2.wav", 0.8, ATTN_NORM);
				}
				else
				{
					sound (self, CHAN_VOICE, "hunter/yell2.wav", 0.8, ATTN_NORM);
				}
			}
			return;
		}
	}
	if ((num < 0.2))
	{
		sound (self, CHAN_VOICE, "hunter/idle1.wav", 0.8, ATTN_NORM);
	}
	else
	{
		if ((num < 0.5))
		{
			sound (self, CHAN_VOICE, "hunter/idle2.wav", 0.8, ATTN_NORM);
		}
		else
		{
			if ((num < 0.7))
			{
				sound (self, CHAN_VOICE, "hunter/idle3.wav", 0.7, ATTN_NORM);
			}
			else
			{
				sound (self, CHAN_VOICE, "hunter/talk2.wav", 1, ATTN_NORM);
			}
		}
	}
};
void () hunter_runfire1 =
{
	if (borkfactor1 ())
	{
		return;
	}
	parse_anim ( 58, hunter_runfire2 );
	ai_face ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();//(5);
};
void () hunter_runfire2 =
{
	if ((self.enemy.health < 1))
	{
		self.th_stand ();
		return;
	}
	parse_anim ( 59, hunter_runfire3 );
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	if (((self.impulse == 6) || (self.impulse == 3)))
	{
		Mons_fire_nails ();
	}
	else
	{
		Mons_fire_shotgun2 ();
	}
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();//(5);
};
void () hunter_runfire3 = [ 60, hunter_runfire4 ]
{
	ai_face ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();//(5);
};
void () hunter_runfire4 = [ 61, hunter_runfire5 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	if (((self.impulse == 6) || (self.impulse == 3)))
	{
		Mons_fire_nails ();
	}
	else
	{
		Mons_fire_shotgun2 ();
	}
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();//(5);
};
void () hunter_runfire5 = [ 62, hunter_runfire6 ]
{
	ai_face ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();//(5);
};
void () hunter_runfire6 =
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	if (((self.impulse == 6) || (self.impulse == 3)))
	{
		Mons_fire_nails ();
	}
	else
	{
		Mons_fire_shotgun2 ();
	}
	self.walkframe = 0;
	if (ai_threats ())
	{
		if (visible (self.enemy))
		{
			parse_anim ( 63, hunter_runfire1 );
			ai_run_slide ();//(5);
			return;
		}
	}
	parse_anim ( 63, hunter_run );
	self.tactic = 0;
	ai_run_slide ();//(6);
};
//END

