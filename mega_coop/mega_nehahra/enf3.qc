void () enf3_ouch1 = [ 83, enf3_ouch2 ]
{
	ai_back (7);
};
void () enf3_ouch2 = [ 84, enf3_ouch3 ]
{
	ai_back (4);
};
void () enf3_ouch3 = [ 85, enf3_ouch4 ]
{
	ai_back (10);
};
void () enf3_ouch4 = [ 86, enf3_ouch5 ]
{
	ai_back (7);
};
void () enf3_ouch5 = [ 87, enf3_ouch6 ]
{
	ai_back (3);
};
void () enf3_ouch6 = [ 88, enf3_run1 ]
{};
void () enf3_run1 =
{
	if (borkfactor1 ())
	{
		return;
	}
	parse_anim ( 0, enf3_run2 );
	if ((self.enemy != world))
	{
		ai_run (18);
		return;
	}
	ai_walk (18);
};
void () enf3_run2 = [ 1, enf3_run3 ]
{
	if ((self.enemy != world))
	{
		ai_run (14);
		return;
	}
	ai_walk (14);
};
void () enf3_run3 = [ 2, enf3_run4 ]
{
	if ((self.enemy != world))
	{
		ai_run (MOVETYPE_PUSH);
		return;
	}
	ai_walk (MOVETYPE_PUSH);
};
void () enf3_run4 = [ 3, enf3_run5 ]
{
	if ((self.enemy != world))
	{
		ai_run (12);
		return;
	}
	ai_walk (12);
};
void () enf3_run5 = [ 4, enf3_run6 ]
{
	if ((self.enemy != world))
	{
		ai_run (14);
		return;
	}
	ai_walk (14);
	if ((random () < 0.2))
	{
		enf3_idlesound ();
	}
};
void () enf3_run6 = [ 5, enf3_run7 ]
{
	if ((self.enemy != world))
	{
		ai_run (14);
		return;
	}
	ai_walk (14);
};
void () enf3_run7 =
{
	local vector dave;
	visible (self.enemy);
	if ((visible (self.enemy) && (self.enemy.health > 5)))
	{
		dave = self.enemy.origin - self.origin;
		if ((vlen (dave) > 120))
		{
			parse_anim ( 22, enf3_shoot4 );
			ai_face ();
			return;
		}
	}
	parse_anim ( 6, enf3_run8 );
	if ((self.enemy != world))
	{
		ai_run (MOVETYPE_PUSH);
		return;
	}
	ai_stand ();//MOVETYPE_PUSH);
};
void () enf3_run8 = [ 7, enf3_run1 ]
{
	if ((self.enemy != world))
	{
		ai_run (MOVETYPE_BOUNCEMISSILE);
		return;
	}
	ai_walk (MOVETYPE_BOUNCEMISSILE);
};
void () enf3_pain1 =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	if ((self.enemy.weapon == IT_SPROCKET))
	{
		self.pain_finished = (time + 0.6);
		if ((random () > 0.9))
		{
			if ((random () < 0.2))
			{
				sound (self, CHAN_VOICE, "enf3/shit.wav", 1, ATTN_NORM);
			}
		}
		enf3_ouch1 ();
		return;
	}
	else
	{
		self.pain_finished = (time + 3);
	}
	if ((random () < 0.2))
	{
		parse_anim ( 14, enf3_shoot );
		return;
	}
	if ((random () < 0.5))
	{
		enf3_ouch1 ();
		return;
	}
	parse_anim ( 8, enf3_pain2 );
};
void () enf3_pain2 = [ 9, enf3_pain3 ]
{};
void () enf3_pain3 = [ 10, enf3_pain4 ]
{};
void () enf3_pain4 = [ 11, enf3_pain5 ]
{};
void () enf3_pain5 = [ 12, enf3_pain6 ]
{};
void () enf3_pain6 = [ 13, enf3_pain7 ]
{};
void () enf3_pain7 = [ 14, enf3_shoot ]
{};
void () enf3_stand1 = [ 76, enf3_stand2 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 2000, 0);
};
void () enf3_stand2 = [ 77, enf3_stand3 ]
{
	ai_stand ();
};
void () enf3_stand3 = [ 78, enf3_stand4 ]
{
	ai_stand ();
};
void () enf3_stand4 = [ 79, enf3_stand5 ]
{
	ai_stand ();
	if ((random () < 0.2))
	{
		enf3_idlesound ();
	}
};
void () enf3_stand5 = [ 80, enf3_stand6 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 2000, 0);
};
void () enf3_stand6 = [ 81, enf3_stand7 ]
{
	ai_stand ();
};
void () enf3_stand7 = [ 82, enf3_stand1 ]
{
	ai_stand ();
};
void () enf3_shoot = [ 15, enf3_shoot2 ]
{
	self.th_pain = enf3_pain1;
	self.th_die = enf3_die;
};
void () enf3_shoot2 = [ 16, enf3_shoot3 ]
{
	ai_face ();
};
void () enf3_shoot3 = [ 17, enf3_shoot4 ]
{
	ai_face ();
};
void () enf3_shoot4 = [ 18, enf3_shoot5 ]
{
	ai_face ();
};
void () enf3_shoot5 = [ 19, enf3_shoot6 ]
{
	Mons_fire_nails ();
};
void () enf3_shoot6 = [ 20, enf3_shoot7 ]
{
	ai_face ();
	if ((self.enemy.classname == "monster_zombie"))
	{
		ai2_jump (self.angles, 200, '0 0 230');
	}
};
void () enf3_shoot7 = [ 21, enf3_shoot8 ]
{
	Mons_fire_nails ();
};
void () enf3_shoot8 =
{
	local vector dave;
	if (borkfactor1 ())
	{
		return;
	}
	visible (self.enemy);
	if ((visible (self.enemy) && (self.enemy.health > 5)))
	{
		if (!Mons_proxim ())
		{
			dave = self.enemy.origin - self.origin;
			if ((vlen (dave) > 120))
			{
				parse_anim ( 22, enf3_shoot4 );
				ai_face ();
				return;
			}
		}
	}
	parse_anim ( 22, enf3_shoot9 );
};
void () enf3_shoot9 = [ 17, enf3_shoot10 ]
{};
void () enf3_shoot10 = [ 16, enf3_run1 ]
{};
void () enf3_open1 = [ 23, enf3_open2 ]
{
	ai_charge (4);
};
void () enf3_open2 = [ 24, enf3_open3 ]
{
	ai_charge (FL_CLIENT);
	sound (self, CHAN_VOICE, "enf3/jump1.wav", 1, ATTN_NORM);
};
void () enf3_open3 = [ 25, enf3_open4 ]
{
	ai_charge (7);
};
void () enf3_open4 = [ 26, enf3_open5 ]
{
	ai_charge (7);
};
void () enf3_open5 = [ 27, enf3_open6 ]
{
	ai_charge (6);
};
void () enf3_open6 = [ 28, enf3_open7 ]
{
	ai_charge (5);
};
void () enf3_open7 = [ 29, enf3_open8 ]
{
	ai_charge (4);
};
void () enf3_open8 = [ 30, enf3_dice ]
{};
void () enf3_close = [ 30, enf3_close2 ]
{
	if ((self.flags & FL_ONGROUND))
	{
		makevectors (self.angles);
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * -200) + '10 10 180');
		self.flags = (self.flags - FL_ONGROUND);
	}
};
void () enf3_close2 = [ 29, enf3_close3 ]
{
	sound (self, CHAN_VOICE, "enf3/jump1.wav", 1, ATTN_NORM);
};
void () enf3_close3 = [ 28, enf3_close4 ]
{};
void () enf3_close4 = [ 27, enf3_close5 ]
{};
void () enf3_close5 = [ 26, enf3_close6 ]
{
	ai_back (2);
};
void () enf3_close6 = [ 25, enf3_close7 ]
{
	ai_back (7);
};
void () enf3_close7 =
{
	if (((self.enemy.health > 0) && visible (self.enemy)))
	{
		parse_anim ( 24, enf3_shoot );
		return;
	}
	if ((self.enemy == world))
	{
		parse_anim ( 24, enf3_stand1 );
		return;
	}
	parse_anim ( 24, enf3_run1 );
};
void () enf3_bladepull =
{
	ai_face ();
	if (visible (self.enemy))
	{
		if ((walkmove (self.angles_y, 20) == FALSE))
		{
			id_run_slide (10);
		}
	}
	else
	{
		movetogoal (25);
	}
};
void () enf3_dice = [ 94, enf3_dice2 ]
{
	enf3_bladepull ();
	self.th_pain = enf3_blpain;
	self.th_die = enf3_bldie;
	self.nextthink = (time + 0.05);
};
void () enf3_dice2 = [ 95, enf3_dice3 ]
{
	enf3_bladepull ();
};
void () enf3_dice3 = [ 96, enf3_dice4 ]
{
	enf3_bladepull ();
	sound (self, CHAN_VOICE, "enf3/bspin.wav", 1, ATTN_NORM);
};
void () enf3_dice4 = [ 97, enf3_dice5 ]
{
	enf3_bladepull ();
	if ((random () > 0.9))
	{
		if ((self.rotate_type == 0))
		{
			self.rotate_type = 1;
			sound (self, CHAN_ITEM, "enf3/rig.wav", 1, ATTN_NORM);
		}
	}
};
void () enf3_dice5 = [ 98, enf3_dice6 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 25));
};
void () enf3_dice6 = [ 99, enf3_dice7 ]
{
	enf3_bladepull ();
	chainsaw (1);
};
void () enf3_dice7 = [ 100, enf3_dice8 ]
{
	chainsaw (1);
	enf3_bladepull ();
};
void () enf3_dice8 = [ 101, enf3_dice9 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 15));
};
void () enf3_dice9 = [ 102, enf3_dice10 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 15));
};
void () enf3_dice10 = [ 103, enf3_dice11 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 15));
};
void () enf3_dice11 =
{
	local vector dave;
	dave = self.enemy.origin - self.origin;
	if (((vlen (dave) > 140) && (self.enemy.health > 5)))
	{
		parse_anim ( 41, enf3_dice24 );
		return;
	}
	parse_anim ( 104, enf3_dice12 );
	sound (self, CHAN_VOICE, "enf3/bspin.wav", 1, ATTN_NORM);
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice12 = [ 105, enf3_dice13 ]
{
	enf3_bladepull ();
	chainsaw (0);
};
void () enf3_dice13 = [ 106, enf3_dice14 ]
{
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
	enf3_bladepull ();
};
void () enf3_dice14 = [ 107, enf3_dice15 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice15 = [ 108, enf3_dice16 ]
{
	chainsaw (0);
	enf3_bladepull ();
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice16 = [ 109, enf3_dice17 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
	sound (self, CHAN_VOICE, "enf3/bspin.wav", 1, ATTN_NORM);
};
void () enf3_dice17 = [ 110, enf3_dice18 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice18 = [ 111, enf3_dice19 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice19 = [ 112, enf3_dice20 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice20 = [ 113, enf3_dice21 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice21 = [ 114, enf3_dice22 ]
{
	enf3_bladepull ();
	chainsaw (1);
};
void () enf3_dice22 = [ 115, enf3_dice23 ]
{
	enf3_bladepull ();
	chainsaw (0);
	self.angles_y = (self.angles_y + (random () * 5));
};
void () enf3_dice23 =
{
	local vector dave;
	dave = self.enemy.origin - self.origin;
	if (((vlen (dave) < 140) && (self.enemy.health > 5)))
	{
		parse_anim ( 101, enf3_dice9 );
		return;
	}
	parse_anim ( 116, enf3_dice24 );
	chainsaw (0);
};
void () enf3_dice24 = [ 117, enf3_dice25 ]
{
	self.th_pain = enf3_pain1;
	self.th_die = enf3_die;
};
void () enf3_dice25 = [ 118, enf3_close ]
{
	self.nextthink = (time + 0.1);
};
void () enf3_melee =
{
	local vector dave;
	dave = self.enemy.origin - self.origin;
	if ((vlen (dave) < 120))
	{
		enf3_open1 ();
		return;
	}
	enf3_shoot ();
};
void () enf3_blpain =
{
	if ((random () < 0.4))
	{
		parse_anim ( 60, enf3_dice9 );
		return;
	}
	parse_anim ( 56, enf3_blpain2 );
	ai_pain (5);
	sound (self, CHAN_BODY, "enf3/blout.wav", 1, ATTN_NORM);
};
void () enf3_blpain2 = [ 57, enf3_blpain3 ]
{
	enf3_painsound ();
};
void () enf3_blpain3 = [ 58, enf3_blpain4 ]
{
	ai_pain (3);
};
void () enf3_blpain4 = [ 59, enf3_blpain5 ]
{};
void () enf3_blpain5 =
{
	local vector dave;
	dave = self.enemy.origin - self.origin;
	if ((vlen (dave) < 120))
	{
		enf3_dice9 ();
		return;
	}
	parse_anim ( 60, enf3_close );
};
void () enf3_bldie =
{
	dead_stay_dead ();
	parse_anim ( 61, enf3_bldie2 );
	sound (self, CHAN_VOICE, "enforcer/death1.wav", 1, ATTN_NORM);
};
void () enf3_bldie2 = [ 62, enf3_bldie3 ]
{
	ThrowGib ("progs/gib1.mdl", -150);
	sound (self, CHAN_ITEM, "enf3/blhit.wav", 1, ATTN_NORM);
};
void () enf3_bldie3 = [ 63, enf3_bldie4 ]
{
	ThrowGib ("progs/gib2.mdl", -120);
};
void () enf3_bldie4 = [ 64, enf3_bldie5 ]
{
	ThrowGib ("progs/gib3.mdl", -50);
};
void () enf3_bldie5 = [ 65, enf3_bldie6 ]
{
	ThrowGib ("progs/gib3.mdl", self.health);
	if ((random () < 0.4))
	{
		self.ammo_nails = 5;
	}
	else
	{
		self.ammo_nails = 10;
	}
		self.ammo_rockets = 10;
		self.ammo_cells = 10;
	DropBackpack ();
};
void () enf3_bldie6 =
{
	if ((skill == 0))
	{
		self.ammo_nails = 20;
		self.ammo_shells = 10;
		self.ammo_rockets = 10;
		self.ammo_cells = 10;
	DropBackpack ();
	}
	sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
	ThrowHead (mtf_savemodel("progs/h_enf3.mdl"), self.health);
	ThrowGib ("progs/gib1.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);
	return;
};
void () enf3_die =
{
	if ((self.health < -35))
	{
		if ((skill == 0))
		{
			self.ammo_nails = 20;
			self.ammo_shells = 10;
			self.ammo_rockets = 10;
			self.ammo_cells = 10;
			DropBackpack ();
		}
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead (mtf_savemodel("progs/h_enf3.mdl"), self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	enf3_deathsound ();
	if ((random () < 0.7))
	{
		parse_anim ( 89, enf3_plop1 );
		return;
	}
	parse_anim ( 66, enf3_die2 );
	dead_stay_dead ();
};
void () enf3_die2 = [ 67, enf3_die3 ]
{};
void () enf3_die3 = [ 68, enf3_die4 ]
{};
void () enf3_die4 = [ 69, enf3_die5 ]
{
	self.solid = SOLID_NOT;
	if ((random () < 0.4))
	{
		self.ammo_nails = 25;
	}
	else
	{
		self.ammo_nails = 20;
	}
	self.ammo_shells = 10;
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	DropBackpack ();
};
void () enf3_die5 = [ 70, enf3_die6 ]
{};
void () enf3_die6 = [ 71, corpse_think ]
{};
void () enf3_plop1 = [ 90, enf3_plop2 ]
{
	dead_stay_dead ();
};
void () enf3_plop2 = [ 91, enf3_plop3 ]
{};
void () enf3_plop3 = [ 92, enf3_plop4 ]
{
	self.solid = SOLID_NOT;
	self.ammo_shells = 10;
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	self.ammo_nails = 20;
	DropBackpack ();
};
void () enf3_plop4 = [ 93, corpse_think ]
{};
void () monster_enf3 =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_sound ("enforcer/death1.wav");
	precache_model ("progs/s_spike.mdl");
	precache_model2 ("progs/mark4.mdl");
	precache_model2 (mtf_savemodel("progs/h_enf3.mdl"));
	precache_model2 (mtf_savemodel("progs/h_mega.mdl"));
	precache_sound2 ("enf3/enf3p1.wav");
	precache_sound2 ("enf3/enf3p2.wav");
	precache_sound2 ("enf3/enf3p3.wav");
	precache_sound2 ("enf3/blhit.wav");
	precache_sound2 ("enf3/blout.wav");
	precache_sound2 ("enf3/bspin.wav");
	precache_sound2 ("enf3/jump1.wav");
	precache_sound2 ("enf3/blgo.wav");
	precache_sound2 ("enf3/com.wav");
	precache_sound2 ("enf3/got.wav");
	precache_sound2 ("enf3/rig.wav");
	precache_sound ("enf3/sight1.wav");
	precache_sound ("enf3/sight2.wav");
	precache_sound ("enf3/sight3.wav");
	precache_sound ("enf3/death1.wav");
	precache_sound ("enf3/death2.wav");
	precache_sound ("enf3/death3.wav");
	precache_sound ("enf3/idle1.wav");
	precache_sound ("enf3/idle2.wav");
	precache_sound ("enf3/idle3.wav");
	precache_sound ("enf3/shit.wav");
	MTF_Setup_Monster_Presets ( 0, "mutant ogre", monster_enf31 );
};
void () enforcer3_start =
{
	trigger_spawnmonster ();
	carnify_enforcer3 ();
};
void () carnify_enforcer3 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/mark4.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	if (!self.health)
	{
		self.health = 190;
	}
	self.yaw_speed = 70;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
	//walkmonster_start ();
};
void () enf3_actor_wait = [ 75, enf3_actor_wait ]
{
	self.use = enf3_awake;
};
void () enf3_awake = [ 75, enf3_awake2 ]
{
	self.th_stand = enf3_stand1;
	self.th_walk = enf3_run1;
	self.use = monster_use;
};
void () enf3_awake2 = [ 74, enf3_awake3 ]
{};
void () enf3_awake3 = [ 73, enf3_awake4 ]
{};
void () enf3_awake4 =
{
	if ((self.goalentity != world))
	{
		parse_anim ( 74, enf3_run1 );
	}
	else
	{
		parse_anim ( 74, enf3_stand1 );
	}
};
void () enf3_painsound =
{
	local float num;
	num = random ();
	if ((num < 0.2))
	{
		sound (self, CHAN_VOICE, "enf3/enf3p1.wav", 1, ATTN_NORM);
		return;
	}
	if ((num < 0.7))
	{
		sound (self, CHAN_VOICE, "enf3/enf3p2.wav", 1, ATTN_NORM);
		return;
	}
	sound (self, CHAN_VOICE, "enf3/enf3p3.wav", 1, ATTN_NORM);
};
void () enf3_sightsound =
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
			//sound (self, CHAN_VOICE, "enf3/hey.wav", 1, ATTN_NORM);
		}
		else
		{
			if ((rsnd == FL_SWIM))
			{
				sound (self, CHAN_VOICE, "enf3/com.wav", 1, ATTN_NORM);
			}
			else
			{
				if ((rsnd == 0))
				{
					sound (self, CHAN_VOICE, "enf3/got.wav", 1, ATTN_NORM);
				}
				else
				{
					sound (self, CHAN_VOICE, "enf3/rig.wav", 1, ATTN_NORM);
				}
			}
		}
		return;
	}
	rsnd = rint ((random () * MOVETYPE_WALK));
	if ((rsnd == 1))
	{
	}
	else
	{
		if ((rsnd == FL_SWIM))
		{
			sound (self, CHAN_VOICE, "enf3/sight3.wav", 1, ATTN_NORM);
		}
		else
		{
			if ((rsnd == 0))
			{
				sound (self, CHAN_VOICE, "enf3/sight1.wav", 1, ATTN_NORM);
			}
			else
			{
				sound (self, CHAN_VOICE, "enf3/sight2.wav", 1, ATTN_NORM);
			}
		}
	}
};
void () enf3_idlesound =
{
	local float num;
	num = random () + random ();
	if ((num < 0.6))
	{
		sound (self, CHAN_VOICE, "enf3/idle1.wav", 1, ATTN_NORM);
		return;
	}
	if ((num < 1.2))
	{
		sound (self, CHAN_VOICE, "enf3/idle2.wav", 1, ATTN_NORM);
		return;
	}
	sound (self, CHAN_VOICE, "enf3/idle3.wav", 1, ATTN_NORM);
};
void () enf3_deathsound =
{
	local float num;
	num = random () + random ();
	if ((num < 0.6))
	{
		sound (self, CHAN_VOICE, "enf3/death1.wav", 1, ATTN_NORM);
		return;
	}
	if ((num < 1.2))
	{
		sound (self, CHAN_VOICE, "enf3/death2.wav", 1, ATTN_NORM);
		return;
	}
	sound (self, CHAN_VOICE, "enf3/death3.wav", 1, ATTN_NORM);
};
//END
