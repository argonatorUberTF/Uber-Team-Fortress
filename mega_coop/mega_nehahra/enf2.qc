void () monster_enf21 =
{
	if (!(self.brain & NAVLOGIC))
	{
		self.brain = (self.brain | NAVLOGIC);
	}
	if ((((self.targetname == "actor1") || (self.targetname == "actor2")) || (self.targetname == "actor3")))
	{
		self.th_stand = mark3_actor_wait;
		self.th_walk = mark3_actor_wait;
	}
	else
	{
		self.th_stand = mark3_dstand;
		self.th_walk = mark3_walk1;
	}
	self.th_run = mark3_run1;
	self.th_pain = mark3_pain;
	self.th_die = mark3_die;
	self.th_missile = mark3_shoot;
	if ((self.brain & TRIGGER_SPAWN))
	{
		self.use = enf2_start;
		return;
	}
	carnify_enforcer2 ();
};
void () monster_enf31 =
{
	if (!(self.brain & NAVLOGIC))
	{
		self.brain = (self.brain | NAVLOGIC);
	}
	if (((self.targetname == "actor15") || (self.targetname == "actor16")))
	{
		self.th_stand = enf3_actor_wait;
		self.th_walk = enf3_actor_wait;
	}
	else
	{
		self.th_stand = enf3_stand1;
		self.th_walk = enf3_run1;
	}
	self.th_run = enf3_run1;
	self.th_pain = enf3_pain1;
	self.th_die = enf3_die;
	self.th_melee = enf3_melee;
	if ((self.brain & TRIGGER_SPAWN))
	{
		self.use = enforcer3_start;
		return;
	}
	carnify_enforcer3 ();
};
void () mark3_stand1 = [ 23, mark3_stand2 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_stand2 = [ 24, mark3_stand3 ]
{
	ai_stand ();
};

void () mark3_stand3 = [ 25, mark3_stand4 ]
{
	ai_stand ();
};

void () mark3_stand4 = [ 26, mark3_stand5 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_stand5 = [ 27, mark3_stand6 ]
{
	ai_stand ();
};

void () mark3_stand6 = [ 28, mark3_stand7 ]
{
	ai_stand ();
	if ((random () > 0.8))
	{
		enf2_idlesound ();
	}
};

void () mark3_stand7 = [ 29, mark3_stand1 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_walk1 = [ 62, mark3_walk2 ]
{
	if ((random () < 0.2))
	{
		enf2_idlesound ();
	}
	ai_walk (FL_SWIM);
};

void () mark3_walk2 = [ 63, mark3_walk3 ]
{
	ai_walk (MOVETYPE_STEP);
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_walk3 = [ 64, mark3_walk4 ]
{
	ai_walk (MOVETYPE_STEP);
};

void () mark3_walk4 = [ 65, mark3_walk5 ]
{
	ai_walk (MOVETYPE_WALK);
};

void () mark3_walk5 = [ 66, mark3_walk6 ]
{
	ai_walk (1);
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_walk6 = [ 67, mark3_walk7 ]
{
	ai_walk (FL_SWIM);
};

void () mark3_walk7 = [ 68, mark3_walk8 ]
{
	ai_emnity ("monster_qguy", 1500, 0);
	ai_walk (FL_SWIM);
};

void () mark3_walk8 = [ 69, mark3_walk9 ]
{
	ai_walk (1);
};

void () mark3_walk9 = [ 70, mark3_walk10 ]
{
	ai_walk (FL_SWIM);
};

void () mark3_walk10 = [ 71, mark3_walk11 ]
{
	ai_walk (MOVETYPE_STEP);
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_walk11 = [ 72, mark3_walk12 ]
{
	ai_walk (MOVETYPE_STEP);
};

void () mark3_walk12 = [ 73, mark3_walk13 ]
{
	ai_walk (1);
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_walk13 = [ 74, mark3_walk14 ]
{
	ai_walk (FL_SWIM);
};

void () mark3_walk14 = [ 75, mark3_walk15 ]
{
	ai_walk (MOVETYPE_WALK);
	ai_emnity ("monster_qguy", 1500, 0);
};

void () mark3_walk15 = [ 76, mark3_walk16 ]
{
	ai_walk (MOVETYPE_STEP);
};

void () mark3_walk16 = [ 77, mark3_walk1 ]
{
	ai_walk (FL_SWIM);
};

void () mark3_run1 =
{
	if (borkfactor1 ())
	{
		return;
	}
	parse_anim ( 30, mark3_run2 );
	if ((random () < 0.2))
	{
		enf2_idlesound ();
	}
	ai3_run (22);
};

void () mark3_run2 = [ 31, mark3_run3 ]
{
	ai3_run (22);
};

void () mark3_run3 = [ 32, mark3_run4 ]
{
	ai3_run (22);
};

void () mark3_run4 = [ 33, mark3_run5 ]
{
	ai3_run (22);
};

void () mark3_run5 = [ 34, mark3_run6 ]
{
	ai3_run (22);
};

void () mark3_run6 = [ 35, mark3_run1 ]
{
	ai3_run (22);
};

void () mark3_dstand = [ 36, mark3_dstand2 ]
{
	ai_stand ();
};

void () mark3_dstand2 = [ 37, mark3_dstand3 ]
{
	ai_stand ();
};

void () mark3_dstand3 = [ 38, mark3_dstand4 ]
{
	ai_stand ();
};

void () mark3_dstand4 = [ 39, mark3_dstand5 ]
{
	ai_stand ();
};

void () mark3_dstand5 = [ 40, mark3_dstand6 ]
{
	ai_stand ();
};

void () mark3_dstand6 = [ 41, mark3_dstand7 ]
{
	ai_stand ();
};

void () mark3_dstand7 =
{
	local float yawn;

	yawn = random ();
	if ((yawn < 0.5))
	{
		parse_anim ( 42, mark3_dstand );
		ai_stand ();
		return;
	}
	parse_anim ( 42, mark3_gunup );
	ai_stand ();
};

void () mark3_gunup = [ 43, mark3_gunup2 ]
{
	ai_stand ();
};

void () mark3_gunup2 = [ 44, mark3_gunup3 ]
{
	ai_stand ();
};

void () mark3_gunup3 = [ 45, mark3_gunup4 ]
{
	ai_stand ();
};

void () mark3_gunup4 = [ 46, mark3_gunup5 ]
{
	ai_stand ();
};

void () mark3_gunup5 = [ 47, mark3_stand1 ]
{
	self.th_stand = mark3_stand1;
	ai_stand ();
};

void () mark3_shoot =
{
	if (((self.origin_z >= self.enemy.origin_z) && (random () < 0.3)))
	{
		mark3_lowshot ();
	}
	else
	{
		mark3_atk1 ();
	}
};

void () mark3_atk1 =
{
	if (borkfactor1 ())
	{
		return;
	}
	if (visible (self.enemy))
	{
		parse_anim ( 48, mark3_atk2 );
		ai_face ();
		return;
	}
	parse_anim ( 48, mark3_walk1 );
};

void () mark3_atk2 = [ 49, mark3_atk3 ]
{
	ai_face ();
	self.th_stand = mark3_stand1;
};

void () mark3_atk3 = [ 50, mark3_atk4 ]
{
	ai_face ();
};

void () mark3_atk4 =
{
	if ((self.health < 25))
	{
		if ((random () < 0.5))
		{
			sound (self, CHAN_WEAPON, "weapons/shotdud.wav", 1, ATTN_NORM);
			parse_anim ( 53, mark3_atk7 );
			return;
		}
	}
	parse_anim ( 51, mark3_atk5 );
	ai_face ();
};

void () mark3_atk5 = [ 52, mark3_atk6 ]
{
	Mons_fire_shotgun2 ();
	ai3_run (0);
};

void () mark3_atk6 =
{
	if (visible (self.enemy))
	{
		if ((random () < 0.7))
		{
			parse_anim ( 53, mark3_atk5 );
			ai_face ();
			return;
		}
	}
	parse_anim ( 53, mark3_atk7 );
	ai_face ();
};

void () mark3_atk7 = [ 54, mark3_atk8 ]
{
	ai_face ();
};

void () mark3_atk8 = [ 55, mark3_run1 ]
{
	ai_face ();
};

void () mark3_paina1 = [ 56, mark3_paina2 ]
{
};

void () mark3_paina2 = [ 57, mark3_paina3 ]
{
};

void () mark3_paina3 = [ 58, mark3_paina4 ]
{
};

void () mark3_paina4 = [ 59, mark3_paina5 ]
{
};

void () mark3_paina5 = [ 60, mark3_paina6 ]
{
};

void () mark3_paina6 = [ 61, mark3_run1 ]
{
};

void (entity attacker, float damage) mark3_pain =
{
	local float r;
	r = random ();
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 0.6);
	if ((r < 0.5))
	{
		sound (self, CHAN_VOICE, "enf2/pain1.wav", 1, ATTN_NORM);
	}
	else
	{
		sound (self, CHAN_VOICE, "enf2/pain2.wav", 1, ATTN_NORM);
	}
	mark3_paina1 ();
};

void () mark3_die1 =
{
	dead_stay_dead ();
	parse_anim ( 0, mark3_die2 );
};

void () mark3_die2 = [ 1, mark3_die3 ]
{
};

void () mark3_die3 = [ 2, mark3_die4 ]
{
	self.solid = SOLID_NOT;
	if ((random () < 0.4))
	{
		self.ammo_shells = 20;
	}
	else
	{
		self.ammo_shells = 15;
	}
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	self.ammo_nails = 20;
	DropBackpack ();
};

void () mark3_die4 = [ 3, mark3_die5 ]
{
	ai_forward (14);
};

void () mark3_die5 = [ 4, mark3_die6 ]
{
	ai_forward (FL_SWIM);
};

void () mark3_die6 = [ 5, mark3_die7 ]
{
};

void () mark3_die7 = [ 6, mark3_die8 ]
{
};

void () mark3_die8 = [ 7, mark3_die9 ]
{
};

void () mark3_die9 = [ 8, mark3_die10 ]
{
	ai_forward (MOVETYPE_WALK);
};

void () mark3_die10 = [ 9, mark3_die11 ]
{
	ai_forward (MOVETYPE_FLY);
};

void () mark3_die11 = [ 10, mark3_die12 ]
{
	ai_forward (MOVETYPE_FLY);
};

void () mark3_die12 = [ 11, mark3_die13 ]
{
	ai_forward (MOVETYPE_FLY);
};

void () mark3_die13 = [ 12, mark3_die14 ]
{
};

void () mark3_die14 = [ 13, mark3_die15 ]
{
};

void () mark3_die15 = [ 14, mark3_die16 ]
{
};

void () mark3_die16 = [ 15, mark3_die17 ]
{
};

void () mark3_die17 = [ 16, mark3_die18 ]
{
};

void () mark3_die18 = [ 17, mark3_die19 ]
{
};

void () mark3_die19 = [ 18, mark3_die20 ]
{
};

void () mark3_die20 = [ 19, mark3_die21 ]
{
};

void () mark3_die21 = [ 21, mark3_die21 ]
{
};

void () mark3_die22 = [ 22, corpse_think ]
{
};

void () mark3_fdie1 =
{
	dead_stay_dead ();
	parse_anim ( 78, mark3_fdie2 );
};

void () mark3_fdie2 = [ 79, mark3_fdie3 ]
{
};

void () mark3_fdie3 = [ 80, mark3_fdie4 ]
{
	self.solid = SOLID_NOT;
	if ((random () < 0.4))
	{
		self.ammo_shells = 15;
	}
	else
	{
		self.ammo_shells = 10;
	}
		self.ammo_rockets = 10;
	DropBackpack ();
};

void () mark3_fdie4 = [ 81, mark3_fdie5 ]
{
};

void () mark3_fdie5 = [ 82, mark3_fdie6 ]
{
};

void () mark3_fdie6 = [ 83, mark3_fdie7 ]
{
};

void () mark3_fdie7 = [ 84, mark3_fdie8 ]
{
};

void () mark3_fdie8 = [ 85, corpse_think ]
{
};

void () mark3_lowshot = [ 96, mark3_lowshot2 ]
{
	ai_face ();
};

void () mark3_lowshot2 =
{
	self.th_pain = mark3_lowpain;
	self.th_die = mark3_lowdie;
	parse_anim ( 97, mark3_lowshot3 );
	ai_face ();
};

void () mark3_lowshot3 = [ 98, mark3_lowshot4 ]
{
	ai_face ();
};

void () mark3_lowshot4 = [ 99, mark3_lowshot5 ]
{
	ai_face ();
};

void () mark3_lowshot5 = [ 100, mark3_lowshot6 ]
{
	Mons_fire_shotgun2 ();
};

void () mark3_lowshot6 =
{
	if ((visible (self.enemy) && (random () < 0.6)))
	{
		parse_anim ( 101, mark3_lowshot5 );
		ai_face ();
		return;
	}
	parse_anim ( 101, mark3_lowshot7 );
};

void () mark3_lowshot7 = [ 99, mark3_lowshot8 ]
{
};

void () mark3_lowshot8 = [ 97, mark3_lowshot9 ]
{
};

void () mark3_lowshot9 =
{
	self.th_pain = mark3_pain;
	self.th_die = mark3_die;
	parse_anim ( 98, mark3_run1 );
};

void () mark3_lowdie = [ 102, mark3_lowdie2 ]
{
};

void () mark3_lowdie2 = [ 103, mark3_die ]
{
};

void () mark3_lowpain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 0.6);
	parse_anim ( 102, mark3_lowpain2 );
};

void () mark3_lowpain2 = [ 103, mark3_lowpain3 ]
{
};

void () mark3_lowpain3 =
{
	self.th_pain = mark3_pain;
	self.th_die = mark3_die;
	parse_anim ( 104, mark3_run1 );
};

void () mark3_die =
{
	if ((self.health < -35))
	{
		if ((skill == 0))
		{
		self.ammo_shells = 10;
		self.ammo_rockets = 10;
		self.ammo_cells = 10;
		self.ammo_nails = 20;
			DropBackpack ();
		}
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowHead (mtf_savemodel("progs/h_enf2.mdl"), self.health);
		return;
	}
	enf2_deathsound ();
	if ((random () > 0.5))
	{
		mark3_die1 ();
	}
	else
	{
		mark3_fdie1 ();
	}
};

void () monster_enf2 =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model2 ("progs/mark3.mdl");
	precache_model2 (mtf_savemodel("progs/h_enf2.mdl"));
	precache_sound2 ("enforcer/death1.wav");
	precache_sound2 ("enf2/sight1.wav");
	precache_sound2 ("enf2/comeon.wav");
	precache_sound2 ("enf2/pain1.wav");
	precache_sound2 ("enf2/pain2.wav");
	precache_sound ("enf2/sight2.wav");
	precache_sound ("enf2/sight3.wav");
	precache_sound ("enf2/sight4.wav");
	precache_sound ("enf2/sight5.wav");
	precache_sound ("enf2/death1.wav");
	precache_sound ("enf2/death2.wav");
	precache_sound ("enf2/death3.wav");
	precache_sound ("enf2/idle1.wav");
	precache_sound ("enf2/idle2.wav");
	precache_sound ("enf2/idle3.wav");
	MTF_Setup_Monster_Presets ( 0, "field enforcer", monster_enf21 );
}

void () enf2_start =
{
	trigger_spawnmonster ();
	carnify_enforcer2 ();
};

void () carnify_enforcer2 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/mark3.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.yaw_speed = 70;
	if (!self.health)
	{
		self.health = 160;
	}
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};

void () mark3_actor_wait = [ 36, mark3_actor_wait ]
{
	self.use = mark3_actor_use;
};

void () mark3_actor_use =
{
	if ((self.goalentity != world))
	{
		parse_anim( 36, mark3_walk1 );
		ai_walk (5);
	}
	else
	{
		parse_anim ( 36, mark3_dstand );
		ai_stand ();
	}
	self.th_stand = mark3_dstand;
	self.th_walk = mark3_walk1;
	self.use = monster_use;
};

void () enf2_runfire1 =
{
	if (borkfactor1 ())
	{
		return;
	}
	parse_anim ( 105, enf2_runfire2 );
	ai_face ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();// (12);
};

void () enf2_runfire2 = [ 106, enf2_runfire3 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	Mons_fire_shotgun2 ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();// (12);
};

void () enf2_runfire3 = [ 107, enf2_runfire4 ]
{
	ai_face ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();// (12);
};

void () enf2_runfire4 = [ 108, enf2_runfire5 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	Mons_fire_shotgun2 ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();// (12);
};

void () enf2_runfire5 = [ 109, enf2_runfire6 ]
{
	ai_face ();
	if (ai_threats ())
	{
		return;
	}
	ai_run_slide ();// (12);
};

void () enf2_runfire6 =
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	Mons_fire_shotgun2 ();
	self.walkframe = 0;
	if (ai_threats ())
	{
		if (visible (self.enemy))
		{
			parse_anim ( 110, enf2_runfire1 );
			ai_run_slide ();// (12);
			return;
		}
	}
	parse_anim ( 110, mark3_run1 );
	self.tactic = 0;
	ai_run_slide ();// (12);
};

void () enf2_sightsound =
{
	local float rsnd;
	if ((self.enemy == world))
	{
		return;
	}
	if ((self.enemy.classname == "player"))
	{
		rsnd = rint ((random () * MOVETYPE_WALK));
		if ((rsnd == 1))
		{
			sound (self, CHAN_VOICE, "enf2/comeon.wav", 1, ATTN_NORM);
		}
		else
		{
			if ((rsnd == FL_SWIM))
			{
				sound (self, CHAN_VOICE, "enf2/sight1.wav", 1, ATTN_NORM);
			}
			else
			{
				if ((rsnd == 0))
				{
					sound (self, CHAN_VOICE, "enf2/sight4.wav", 1, ATTN_NORM);
				}
				else
				{
					sound (self, CHAN_VOICE, "enf2/sight3.wav", 1, ATTN_NORM);
				}
			}
		}
		return;
	}
	rsnd = rint ((random () * MOVETYPE_WALK));
	if ((rsnd == 1))
	{
		sound (self, CHAN_VOICE, "enf2/comeon.wav", 1, ATTN_NORM);
	}
	else
	{
		if ((rsnd == FL_SWIM))
		{
			sound (self, CHAN_VOICE, "enf2/sight4.wav", 1, ATTN_NORM);
		}
		else
		{
			if ((rsnd == 0))
			{
				sound (self, CHAN_VOICE, "enf2/sight5.wav", 1, ATTN_NORM);
			}
			else
			{
				sound (self, CHAN_VOICE, "enf2/sight2.wav", 1, ATTN_NORM);
			}
		}
	}
};

void () enf2_idlesound =
{
	local float num;
	num = random () + random ();
	if ((num < 0.6))
	{
		sound (self, CHAN_VOICE, "enf2/idle1.wav", 1, ATTN_NORM);
		return;
	}
	if ((num < 1.2))
	{
		sound (self, CHAN_VOICE, "enf2/idle2.wav", 1, ATTN_NORM);
		return;
	}
	sound (self, CHAN_VOICE, "enf2/idle3.wav", 1, ATTN_NORM);
};

void () enf2_deathsound =
{
	local float num;
	num = random () + random ();
	if ((num < 0.6))
	{
		sound (self, CHAN_VOICE, "enf2/death1.wav", 1, ATTN_NORM);
		return;
	}
	if ((num < 1.2))
	{
		sound (self, CHAN_VOICE, "enf2/death2.wav", 1, ATTN_NORM);
		return;
	}
	sound (self, CHAN_VOICE, "enf2/death3.wav", 1, ATTN_NORM);
};

//END 