#define rushlives		ammo_attr
void (float radius, vector offset) ai_orbit2;
void (float offset) hknight_shot =
{
	local vector offang;
	local vector org;
	local vector vec;
	offang = vectoangles ((self.enemy.origin - self.origin));
	offang_y = offang_y + (offset * MOVETYPE_TOSS);
	makevectors (offang);
	org = ((self.origin + self.mins) + (self.size * 0.5)) + (v_forward * 20);
	vec = normalize (v_forward);
	vec_z = (0 - vec_z) + ((random () - 0.5) * 0.1);
	launch_spike (org, vec);
	newmis.classname = "knightspike";
	newmis.event = "mthret";
	setmodel (newmis, "progs/k_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	newmis.velocity = (vec * 300);
	sound (self, CHAN_WEAPON, "hknight/attack1.wav", 1, ATTN_NORM);
};
float () CheckForCharge =
{
	if ((panzy_mode == 1))
	{
		return (0);
	}
	if (!enemy_vis)
	{
		return (0);
	}
	if ((time < self.attack_finished))
	{
		return (0);
	}
	if ((fabs ((self.origin_z - self.enemy.origin_z)) > 20))
	{
		return (0);
	}
	if ((vlen ((self.origin - self.enemy.origin)) < 80))
	{
		return (0);
	}
	SUB_AttackFinished (FL_SWIM);
	if ((random () < 0.5))
	{
		if (hknight_rushdecide ())
		{
			return (1);
		}
	}
	hknight_char_a1 ();
	return (1);
};
void () CheckContinueCharge =
{
	if ((time > self.attack_finished))
	{
		SUB_AttackFinished (MOVETYPE_WALK);
		hknight_run1 ();
		return;
	}
	if ((random () > 0.5))
	{
		sound (self, CHAN_WEAPON, "knight/sword2.wav", 1, ATTN_NORM);
	}
	else
	{
		sound (self, CHAN_WEAPON, "knight/sword1.wav", 1, ATTN_NORM);
	}
};
void () hknight_stand1 = [ 0, hknight_stand2 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_stand2 = [ 1, hknight_stand3 ]
{
	ai_stand ();
};
void () hknight_stand3 = [ 2, hknight_stand4 ]
{
	ai_stand ();
};
void () hknight_stand4 = [ 3, hknight_stand5 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_stand5 = [ 4, hknight_stand6 ]
{
	ai_stand ();
};
void () hknight_stand6 = [ 5, hknight_stand7 ]
{
	ai_stand ();
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_stand7 = [ 6, hknight_stand8 ]
{
	ai_stand ();
};
void () hknight_stand8 = [ 7, hknight_stand9 ]
{
	ai_stand ();
};
void () hknight_stand9 = [ 8, hknight_stand1 ]
{
	ai_stand ();
};
void () hknight_rush1 =
{
	self.effects = (self.effects | EF_MUZZLEFLASH);
	self.pain_finished = (time + 1);
	parse_anim ( 166, hknight_rush2 );
	ai_face ();
	ai_melee ();
};
void () hknight_rush2 =
{
	if (!ai_knightrush ())
	{
		self.th_run ();
		return;
	}
	parse_anim ( 167, hknight_rush3 );
	ai_face ();
	ai_melee ();
	sound (self, 1/*CHAN_DAMAUL*/, "sets/dml1_4.wav", 1, ATTN_NORM);
};
void () hknight_rush3 =
{
	self.effects = (self.effects | EF_MUZZLEFLASH);
	if (!ai_knightrush ())
	{
		self.th_run ();
		return;
	}
	parse_anim ( 168, hknight_rush4 );
	ai_face ();
	ai_melee ();
};
void () hknight_rush4 =
{
	if (!ai_knightrush ())
	{
		self.th_run ();
		return;
	}
	parse_anim ( 169, hknight_rush1 );
	ai_face ();
	ai_melee ();
	sound (self, 1/*CHAN_DAMAUL*/, "sets/dml1_4.wav", 1, ATTN_NORM);
};
float () ai_knightrush =
{
	if (!infront (self.enemy))
	{
		self.#rushlives = (self.#rushlives + 1);
		if ((self.#rushlives > 13))
		{
			self.#rushlives = 0;
			self.yaw_speed = 20;
			strategy_move = strategy_move - 1;
			return (0);
		}
	}
	if ((walkmove (self.angles_y, 23) == FALSE))
	{
		melee_rushhit ();
		strategy_move = strategy_move - 1;
		self.yaw_speed = 20;
		return (0);
	}
	if ((walkmove (self.angles_y, 23) == FALSE))
	{
		melee_rushhit ();
		self.yaw_speed = 20;
		strategy_move = strategy_move - 1;
		return (0);
	}
	else
	{
		return (1);
	}
};
float () melee_rushhit =
{
	local float ldmg;
	local vector delta;
	ai_face ();
	walkmove (self.ideal_yaw, 12);
	delta = self.enemy.origin - self.origin;
	if ((vlen (delta) > 100))
	{
		return (0);
	}
	if (!CanDamage (self.enemy, self))
	{
		return (0);
	}
	ldmg = MOVETYPE_BOUNCE + (MOVETYPE_BOUNCEMISSILE * random ());
	T_Damage (self.enemy, self, self, ldmg);
	makevectors (self.angles);
	SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), (100 * v_right));
	SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), (-100 * v_right));
	makevectors (self.enemy.angles);
	self.enemy.flags = (self.enemy.flags - (self.enemy.flags & FL_ONGROUND));
	self.enemy.origin_z = (self.enemy.origin_z + 1);
	self.enemy.velocity = ((v_forward * -200) + '0 0 220');
	return (1);
};
void () hknight_walk1 = [ 9, hknight_walk2 ]
{
	hk_idle_sound ();
	ai_walk (FL_SWIM);
};
void () hknight_walk2 = [ 10, hknight_walk3 ]
{
	ai_walk (MOVETYPE_FLY);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_walk3 = [ 11, hknight_walk4 ]
{
	ai_walk (MOVETYPE_FLY);
};
void () hknight_walk4 = [ 12, hknight_walk5 ]
{
	ai_walk (MOVETYPE_STEP);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_walk5 = [ 13, hknight_walk6 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () hknight_walk6 = [ 14, hknight_walk7 ]
{
	ai_walk (FL_SWIM);
};
void () hknight_walk7 = [ 15, hknight_walk8 ]
{
	ai_walk (FL_SWIM);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_walk8 = [ 16, hknight_walk9 ]
{
	ai_walk (MOVETYPE_WALK);
};
void () hknight_walk9 = [ 17, hknight_walk10 ]
{
	ai_walk (MOVETYPE_WALK);
};
void () hknight_walk10 = [ 18, hknight_walk11 ]
{
	ai_walk (MOVETYPE_STEP);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_walk11 = [ 19, hknight_walk12 ]
{
	ai_walk (MOVETYPE_WALK);
};
void () hknight_walk12 = [ 20, hknight_walk13 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () hknight_walk13 = [ 21, hknight_walk14 ]
{
	ai_walk (MOVETYPE_TOSS);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_walk14 = [ 22, hknight_walk15 ]
{
	ai_walk (FL_SWIM);
};
void () hknight_walk15 = [ 23, hknight_walk16 ]
{
	ai_walk (FL_SWIM);
};
void () hknight_walk16 = [ 24, hknight_walk17 ]
{
	ai_walk (MOVETYPE_STEP);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_walk17 = [ 25, hknight_walk18 ]
{
	ai_walk (MOVETYPE_WALK);
};
void () hknight_walk18 = [ 26, hknight_walk19 ]
{
	ai_walk (MOVETYPE_WALK);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_walk19 = [ 27, hknight_walk20 ]
{
	ai_walk (MOVETYPE_WALK);
};
void () hknight_walk20 = [ 28, hknight_walk1 ]
{
	ai_walk (FL_SWIM);
	ai_emnity ("monster_qguy", 1500, 0);
};
void () hknight_run1 =
{
	if (borkfactor1 ())
	{
		return;
	}
	parse_anim ( 29, hknight_run2 );
	hk_idle_sound ();
	ai_run (20);
};
void () hknight_run2 = [ 30, hknight_run3 ]
{
	ai_run (25);
};
void () hknight_run3 = [ 31, hknight_run4 ]
{
	ai_run (18);
	if ((self.nojump == 0))
	{
		ai_ledgejump (self.angles, 0);
	}
};
void () hknight_run4 = [ 32, hknight_run5 ]
{
	ai_run (FL_INWATER);
};
void () hknight_run5 =
{
	if (CheckForCharge ())
	{
		return;
	}
	parse_anim ( 33, hknight_run6 );
	ai_run (14);
};
void () hknight_run6 = [ 34, hknight_run7 ]
{
	ai_run (25);
};
void () hknight_run7 = [ 35, hknight_run8 ]
{
	ai_run (21);
};
void () hknight_run8 = [ 36, hknight_run1 ]
{
	ai_run (13);
};
void () hknight_pain1 = [ 37, hknight_pain2 ]
{
	sound (self, CHAN_VOICE, "hknight/pain1.wav", 1, ATTN_NORM);
};
void () hknight_pain2 = [ 38, hknight_pain3 ]
{};
void () hknight_pain3 = [ 39, hknight_pain4 ]
{};
void () hknight_pain4 = [ 40, hknight_pain5 ]
{};
void () hknight_pain5 = [ 41, hknight_run1 ]
{};
void () hknight_die1 = [ 42, hknight_die2 ]
{
	ai_forward (MOVETYPE_BOUNCE);
};
void () hknight_die2 = [ 43, hknight_die3 ]
{
	ai_forward (FL_CLIENT);
};
void () hknight_die3 = [ 44, hknight_die4 ]
{
	self.solid = SOLID_NOT;
	ai_forward (MOVETYPE_PUSH);
};
void () hknight_die4 = [ 45, hknight_die5 ]
{};
void () hknight_die5 = [ 46, hknight_die6 ]
{};
void () hknight_die6 = [ 47, hknight_die7 ]
{};
void () hknight_die7 = [ 48, hknight_die8 ]
{};
void () hknight_die8 = [ 49, hknight_die9 ]
{
	ai_forward (MOVETYPE_BOUNCE);
};
void () hknight_die9 = [ 50, hknight_die10 ]
{
	ai_forward (MOVETYPE_BOUNCEMISSILE);
};
void () hknight_die10 = [ 51, hknight_die11 ]
{};
void () hknight_die11 = [ 52, hknight_die12 ]
{};
void () hknight_die12 = //[ 53, corpse_think ]
{
	if (self.classname == "monster_hell_knight")
		parse_anim ( 53, hknight_die12 );
	else
		parse_anim ( 53, corpse_think );
};
void () hknight_dieb1 = [ 54, hknight_dieb2 ]
{};
void () hknight_dieb2 = [ 55, hknight_dieb3 ]
{};
void () hknight_dieb3 = [ 56, hknight_dieb4 ]
{
	self.solid = SOLID_NOT;
};
void () hknight_dieb4 = [ 57, hknight_dieb5 ]
{};
void () hknight_dieb5 = [ 58, hknight_dieb6 ]
{};
void () hknight_dieb6 = [ 59, hknight_dieb7 ]
{};
void () hknight_dieb7 = [ 60, hknight_dieb8 ]
{};
void () hknight_dieb8 =
{
	self.cnt = 0;
	parse_anim ( 61, hknight_dieb9 );
};
void () hknight_dieb10 =
{
	parse_anim ( 62, hknight_dieb10 );
};
void () hknight_dieb9 =
{
	if (((self.classname == "monster_beard") && (self.lives > 0)))
	{
		self.aflag = (((9 + random ()) + random ()) + random ());
		parse_anim ( 62, beard_returndelay );
	}
	else
	{
		SUB_UseTargets ();
		if (self.classname == "monster_hell_knight")
			parse_anim ( 62, hknight_dieb10 );
		else
			parse_anim ( 62, corpse_think );
		//parse_anim ( 62, corpse_think );
	}
};
void () beard_returndelay =
{
	if ((self.cnt > self.aflag))
	{
		self.solid = SOLID_SLIDEBOX;
		if (!walkmove (0, 0))
		{
			self.solid = SOLID_NOT;
		}
		else
		{
			self.cnt = 0;
			self.aflag = 0;
			self.health = 200;
			self.walkframe = 0;
			self.takedamage = DAMAGE_YES;
			beard_kippup ();
			return;
		}
	}
	parse_anim ( 62, beard_returndelay );
	self.cnt = (self.cnt + 1);
};
void () beard_kippup =
{
	if ((self.walkframe >= 9))
	{
		self.walkframe = 0;
		self.th_run ();
		return;
	}
	parse_anim ( 166, beard_kippup );
	self.frame = (166 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () hknight_die =
{
	local float num;
	num = 0;
	strategy_move = 0;
	if ((self.classname == "monster_beard"))
	{
		self.lives = (self.lives - 1);
	}
	if ((self.health < -40))
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		if ((self.classname == "monster_beard"))
		{
			ThrowHead (mtf_savemodel("progs/gib3.mdl"), self.health);
		}
		else
		{
			ThrowHead (mtf_savemodel("progs/h_hellkn.mdl"), self.health);
		}
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	sound (self, CHAN_VOICE, "hknight/death1.wav", 1, ATTN_NORM);
	if ((self.classname == "monster_beard"))
	{
		hknight_dieb1 ();
		return;
	}
	if ((random () > 0.5))
	{
		hknight_die1 ();
	}
	else
	{
		hknight_dieb1 ();
	}
};
void () hknight_magica1 = [ 79, hknight_magica2 ]
{
	ai_face ();
};
void () hknight_magica2 = [ 80, hknight_magica3 ]
{
	ai_face ();
};
void () hknight_magica3 = [ 81, hknight_magica4 ]
{
	ai_face ();
};
void () hknight_magica4 = [ 82, hknight_magica5 ]
{
	ai_face ();
};
void () hknight_magica5 = [ 83, hknight_magica6 ]
{
	ai_face ();
};
void () hknight_magica6 = [ 84, hknight_magica7 ]
{
	ai_face ();
	if (ai_check_z ())
	{
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
			self.origin_z = (self.origin_z + 1);
			self.velocity_z = 280;
		}
	}
};
void () hknight_magica7 = [ 85, hknight_magica8 ]
{
	hknight_shot (CONTENT_SOLID);
};
void () hknight_magica8 = [ 86, hknight_magica9 ]
{
	hknight_shot (CONTENT_EMPTY);
};
void () hknight_magica9 = [ 87, hknight_magica10 ]
{
	hknight_shot (0);
};
void () hknight_magica10 = [ 88, hknight_magica11 ]
{
	hknight_shot (1);
};
void () hknight_magica11 = [ 89, hknight_magica12 ]
{
	hknight_shot (FL_SWIM);
};
void () hknight_magica12 = [ 90, hknight_magica13 ]
{
	hknight_shot (MOVETYPE_WALK);
};
void () hknight_magica13 = [ 91, hknight_magica14 ]
{
	ai_face ();
};
void () hknight_magica14 = [ 92, hknight_run1 ]
{
	ai_face ();
};
void () hknight_magicb1 = [ 93, hknight_magicb2 ]
{
	ai_face ();
};
void () hknight_magicb2 = [ 94, hknight_magicb3 ]
{
	ai_face ();
};
void () hknight_magicb3 = [ 95, hknight_magicb4 ]
{
	ai_face ();
};
void () hknight_magicb4 = [ 96, hknight_magicb5 ]
{
	ai_face ();
};
void () hknight_magicb5 = [ 97, hknight_magicb6 ]
{
	ai_face ();
};
void () hknight_magicb6 = [ 98, hknight_magicb7 ]
{
	ai_face ();
	if (ai_check_z ())
	{
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
			self.origin_z = (self.origin_z + 1);
			self.velocity_z = 300;
		}
	}
};
void () hknight_magicb7 = [ 99, hknight_magicb8 ]
{
	hknight_shot (CONTENT_SOLID);
};
void () hknight_magicb8 = [ 100, hknight_magicb9 ]
{
	hknight_shot (CONTENT_EMPTY);
};
void () hknight_magicb9 = [ 101, hknight_magicb10 ]
{
	hknight_shot (0);
};
void () hknight_magicb10 = [ 102, hknight_magicb11 ]
{
	hknight_shot (1);
};
void () hknight_magicb11 = [ 103, hknight_magicb12 ]
{
	hknight_shot (FL_SWIM);
};
void () hknight_magicb12 = [ 104, hknight_magicb13 ]
{
	hknight_shot (MOVETYPE_WALK);
};
void () hknight_magicb13 = [ 105, hknight_run1 ]
{
	ai_face ();
};
float () hknight_rushdecide =
{
	if ((self.classname == "monster_beard"))
	{
		return (0);
	}
	if ((self.origin_z == self.enemy.origin_z))
	{
		if ((strategy_move < 2))
		{
			strategy_move = 1;
			sound (self, 1/*CHAN_BODY*/, "sets/set2_4.wav", 1, ATTN_NONE);
			ai_face ();
			self.yaw_speed = 5;
			hknight_rush1 ();
			return (1);
		}
	}
	return (0);
};
void () hknight_magicc1 =
{
	if ((self.classname == "monster_beard"))
	{
		beard_attack1 ();
		return;
	}
	if (hknight_rushdecide ())
	{
		return;
	}
	parse_anim ( 155, hknight_magicc2 );
	ai_face ();
};
void () hknight_magicc2 = [ 156, hknight_magicc3 ]
{
	ai_face ();
};
void () hknight_magicc3 = [ 157, hknight_magicc4 ]
{
	ai_face ();
};
void () hknight_magicc4 = [ 158, hknight_magicc5 ]
{
	ai_face ();
	if (ai_check_z ())
	{
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
			self.origin_z = (self.origin_z + 1);
			self.velocity_z = 180;
		}
	}
};
void () hknight_magicc5 = [ 159, hknight_magicc6 ]
{
	ai_face ();
};
void () hknight_magicc6 = [ 160, hknight_magicc7 ]
{
	hknight_shot (CONTENT_SOLID);
};
void () hknight_magicc7 = [ 161, hknight_magicc8 ]
{
	hknight_shot (CONTENT_EMPTY);
};
void () hknight_magicc8 = [ 162, hknight_magicc9 ]
{
	hknight_shot (0);
};
void () hknight_magicc9 = [ 163, hknight_magicc10 ]
{
	hknight_shot (1);
};
void () hknight_magicc10 = [ 164, hknight_magicc11 ]
{
	hknight_shot (FL_SWIM);
};
void () hknight_magicc11 = [ 165, hknight_run1 ]
{
	hknight_shot (MOVETYPE_WALK);
};
void () hknight_char_a1 = [ 63, hknight_char_a2 ]
{
	ai_charge (20);
};
void () hknight_char_a2 = [ 64, hknight_char_a3 ]
{
	ai_charge (25);
};
void () hknight_char_a3 = [ 65, hknight_char_a4 ]
{
	ai_charge (18);
};
void () hknight_char_a4 = [ 66, hknight_char_a5 ]
{
	ai_charge (FL_INWATER);
};
void () hknight_char_a5 = [ 67, hknight_char_a6 ]
{
	ai_charge (14);
};
void () hknight_char_a6 = [ 68, hknight_char_a7 ]
{
	ai_charge (20);
	ai_melee ();
};
void () hknight_char_a7 = [ 69, hknight_char_a8 ]
{
	ai_charge (21);
	ai_melee ();
};
void () hknight_char_a8 = [ 70, hknight_char_a9 ]
{
	ai_charge (13);
	ai_melee ();
};
void () hknight_char_a9 = [ 71, hknight_char_a10 ]
{
	ai_charge (20);
	ai_melee ();
};
void () hknight_char_a10 = [ 72, hknight_char_a11 ]
{
	ai_charge (20);
	ai_melee ();
};
void () hknight_char_a11 = [ 73, hknight_char_a12 ]
{
	ai_charge (18);
	ai_melee ();
};
void () hknight_char_a12 = [ 74, hknight_char_a13 ]
{
	ai_charge (FL_INWATER);
};
void () hknight_char_a13 = [ 75, hknight_char_a14 ]
{
	ai_charge (14);
};
void () hknight_char_a14 = [ 76, hknight_char_a15 ]
{
	ai_charge (25);
};
void () hknight_char_a15 = [ 77, hknight_char_a16 ]
{
	ai_charge (21);
};
void () hknight_char_a16 = [ 78, hknight_run1 ]
{
	ai_charge (13);
};
void () hknight_char_b1 = [ 106, hknight_char_b2 ]
{
	CheckContinueCharge ();
	ai_charge (SVC_TEMPENTITY);
	ai_melee ();
};
void () hknight_char_b2 = [ 107, hknight_char_b3 ]
{
	ai_charge (17);
	ai_melee ();
};
void () hknight_char_b3 = [ 108, hknight_char_b4 ]
{
	ai_charge (12);
	ai_melee ();
};
void () hknight_char_b4 = [ 109, hknight_char_b5 ]
{
	ai_charge (22);
	ai_melee ();
};
void () hknight_char_b5 = [ 110, hknight_char_b6 ]
{
	ai_charge (18);
	ai_melee ();
};
void () hknight_char_b6 = [ 111, hknight_char_b1 ]
{
	ai_charge (FL_CLIENT);
	ai_melee ();
};
void () hknight_slice1 = [ 112, hknight_slice2 ]
{
	ai_charge (MOVETYPE_FLYMISSILE);
};
void () hknight_slice2 = [ 113, hknight_slice3 ]
{
	ai_charge (MOVETYPE_TOSS);
};
void () hknight_slice3 = [ 114, hknight_slice4 ]
{
	ai_charge (13);
};
void () hknight_slice4 = [ 115, hknight_slice5 ]
{
	ai_charge (MOVETYPE_STEP);
};
void () hknight_slice5 = [ 116, hknight_slice6 ]
{
	ai_charge (MOVETYPE_PUSH);
	ai_melee ();
};
void () hknight_slice6 = [ 117, hknight_slice7 ]
{
	ai_charge (15);
	ai_melee ();
};
void () hknight_slice7 = [ 118, hknight_slice8 ]
{
	ai_charge (FL_CLIENT);
	ai_melee ();
};
void () hknight_slice8 = [ 119, hknight_slice9 ]
{
	ai_charge (FL_SWIM);
	ai_melee ();
};
void () hknight_slice9 = [ 120, hknight_slice10 ]
{
	ai_melee ();
};
void () hknight_slice10 = [ 121, hknight_run1 ]
{
	ai_charge (MOVETYPE_WALK);
};
void () hknight_smash1 = [ 122, hknight_smash2 ]
{
	ai_charge (1);
};
void () hknight_smash2 = [ 123, hknight_smash3 ]
{
	ai_charge (13);
};
void () hknight_smash3 = [ 124, hknight_smash4 ]
{
	ai_charge (MOVETYPE_FLYMISSILE);
};
void () hknight_smash4 = [ 125, hknight_smash6 ]
{
	ai_charge (MOVETYPE_BOUNCEMISSILE);
	ai_melee ();
};
void () hknight_smash6 = [ 127, hknight_smash7 ]
{
	ai_charge (MOVETYPE_PUSH);
	ai_melee ();
};
void () hknight_smash7 = [ 128, hknight_smash8 ]
{
	ai_charge (12);
	ai_melee ();
};
void () hknight_smash8 = [ 129, hknight_smash9 ]
{
	ai_charge (FL_SWIM);
	ai_melee ();
};
void () hknight_smash9 = [ 130, hknight_smash11 ]
{
	ai_charge (MOVETYPE_WALK);
	ai_melee ();
};
void () hknight_smash11 = [ 132, hknight_run1 ]
{
	ai_charge (0);
};
void () hknight_watk1 = [ 133, hknight_watk3 ]
{
	ai_charge (4);
};
void () hknight_watk3 = [ 135, hknight_watk5 ]
{
	ai_charge (2);
};
void () hknight_watk5 = [ 137, hknight_watk7 ]
{
	ai_charge (2);
};
void () hknight_watk7 = [ 139, hknight_watk9 ]
{
	ai_charge (1);
	ai_melee ();
};
void () hknight_watk9 = [ 141, hknight_watk11 ]
{
	ai_charge (MOVETYPE_FLY);
	ai_melee ();
};
void () hknight_watk11 = [ 143, hknight_watk13 ]
{
	ai_charge (FL_SWIM);
};
void () hknight_watk13 = [ 145, hknight_watk15 ]
{
	ai_charge (2);
};
void () hknight_watk15 = [ 147, hknight_watk17 ]
{
	ai_charge (3);
};
void () hknight_watk17 = [ 149, hknight_watk19 ]
{
	ai_charge (1);
	ai_melee ();
};
void () hknight_watk19 = [ 151, hknight_watk22 ]
{
	ai_charge (MOVETYPE_STEP);
};
void () hknight_watk22 = [ 153, hknight_run1 ]
{
	ai_charge (MOVETYPE_WALK);
};
void () hk_idle_sound =
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "hknight/idle.wav", 1, ATTN_NORM);
	}
};
void (entity attacker, float damage) hknight_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	sound (self, CHAN_VOICE, "hknight/pain1.wav", 1, ATTN_NORM);
	if (((time - self.pain_finished) > MOVETYPE_FLY))
	{
		hknight_pain1 ();
		self.pain_finished = (time + 1);
		return;
	}
	if (((random () * SVC_INTERMISSION) > damage))
	{
		return;
	}
	self.pain_finished = (time + 1);
	hknight_pain1 ();
};
void () hknight_melee =
{
	if ((random () < 0.4))
	{
		if ((self.classname == "monster_beard"))
		{
			beard_attack1 ();
			return;
		}
	}
	hknight_type = hknight_type + 1;
	sound (self, CHAN_WEAPON, "hknight/slash1.wav", 1, ATTN_NORM);
	if ((hknight_type == 1))
	{
		hknight_slice1 ();
	}
	else
	{
		if ((hknight_type == FL_SWIM))
		{
			hknight_smash1 ();
		}
		else
		{
			if ((hknight_type == MOVETYPE_WALK))
			{
				hknight_watk1 ();
				hknight_type = 0;
			}
		}
	}
};
void () monster_hell_knight1 =
{
	if (!(self.brain & NO_SWIM))
	{
		self.brain = (self.brain | NO_SWIM);
	}
	if ((self.classname == "monster_beard"))
	{
		self.lives = 8;
		self.th_wins = beard_wins;
		if (!self.health)
		{
			self.health = 650;
		}
		if (!(self.brain & BLINK))
		{
			self.brain = (self.brain | BLINK);
		}
	}
	else
	{
		self.health = 250;
	}
	if (!(self.brain & NAVLOGIC))
	{
		self.brain = (self.brain | NAVLOGIC);
	}
	if (((self.targetname == "actor19") || (self.targetname == "actor20")))
	{
		self.th_stand = hknight_wait;
		self.th_walk = hknight_wait;
	}
	else
	{
		self.th_stand = hknight_stand1;
		self.th_walk = hknight_walk1;
	}
	if (((self.classname == "monster_beard") && (world.model == "maps/neh2m1.bsp")))
	{
		self.th_stand = hknight_wait;
		self.th_walk = hknight_wait;
	}
	self.th_run = hknight_run1;
	self.th_melee = hknight_melee;
	self.th_missile = hknight_magicc1;
	self.th_pain = hknight_pain;
	self.th_die = hknight_die;
	if ((self.brain & TRIGGER_SPAWN))
	{
		self.use = hknight_start;
		return;
	}
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	if (!self.model)
	{
		setmodel (self, "progs/hknight_neh.mdl");
	}
	setsize (self, VEC_HULL_MIN, '16 16 40');
	MTF_Setup_Monster_Postsets ( self.health, coop_walkmonster_start );
};
void () monster_hell_knight =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	if ((self.classname == "monster_beard"))
	{
		precache_model2 ("progs/beard.mdl");
		precache_sound2 ("ghoro/balls.wav");
		precache_sound2 ("ghoro/spawnb.wav");
		setmodel (self, "progs/beard.mdl");
		precache_sound2 ("ghoro/talk1.wav");
		precache_sound2 ("ghoro/talk2.wav");
		precache_sound2 ("ghoro/talk3.wav");
		precache_sound2 ("ghoro/laugh.wav");
		precache_model2 ("progs/k_spike.mdl");
		precache_model2 (mtf_savemodel("progs/h_hellkn.mdl"));
		precache_sound2 ("hknight/attack1.wav");
		precache_sound ("hknight/death1.wav");
		precache_sound2 ("hknight/pain1.wav");
		precache_sound2 ("hknight/sight1.wav");
		precache_sound ("hknight/hit.wav");
		precache_sound2 ("hknight/slash1.wav");
		precache_sound ("hknight/idle.wav");
		precache_sound2 ("hknight/grunt.wav");
		precache_sound ("knight/sword1.wav");
		precache_sound ("knight/sword2.wav");
		precache_sound2 ("sets/set2_4.wav");
		precache_sound ("sets/dml1_4.wav");
		MTF_Setup_Monster_Presets( 0, "super knight", monster_hell_knight1 );
	}
	else
	{
		precache_model2 ("progs/hknight_neh.mdl");
		precache_model2 ("progs/k_spike.mdl");
		precache_model2 (mtf_savemodel("progs/h_hellkn.mdl"));
		precache_sound2 ("hknight/attack1.wav");
		precache_sound ("hknight/death1.wav");
		precache_sound2 ("hknight/pain1.wav");
		precache_sound2 ("hknight/sight1.wav");
		precache_sound ("hknight/hit.wav");
		precache_sound2 ("hknight/slash1.wav");
		precache_sound ("hknight/idle.wav");
		precache_sound2 ("hknight/grunt.wav");
		precache_sound ("knight/sword1.wav");
		precache_sound ("knight/sword2.wav");
		MTF_Setup_Monster_Presets( 0, "hell knight", monster_hell_knight1 );
	}
};
void () hknight_start =
{
	trigger_spawnmonster ();
	carnify_hknight ();
};
void () carnify_hknight =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/hknight_neh.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	if (!self.health)
	{
		self.health = 250;
	}
	walkmonster_start ();
};
void () hknight_wait =
{
	self.use = hknight_begin;
	if ((self.walkframe >= 8))
	{
		self.walkframe = 0;
	}
	parse_anim ( 0, hknight_wait );
	self.frame = (0 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () hknight_begin =
{
	self.use = monster_use;
	self.th_stand = hknight_stand1;
	self.th_walk = hknight_walk1;
	if ((self.goalentity == world))
	{
		parse_anim ( 0, hknight_stand1 );
	}
	else
	{
		parse_anim ( 0, hknight_walk1 );
	}
};
void () monster_beard =
{
	if ((world.model == "maps/neh2m1.bsp"))
	{
		self.spawnflags = (self.spawnflags & 32);
		self.targetname = "explo_1";
	}
	monster_hell_knight ();
};
void (float num, vector dave) beard_balls =
{
	local entity balla;
	sound (self, CHAN_VOICE, "ghoro/spawnb.wav", 1, ATTN_NORM);
	balla = spawn ();
	balla.movetype = MOVETYPE_FLYMISSILE;
	balla.solid = SOLID_NOT;
	balla.aether = dave;
	balla.boost = num;
	balla.enemy = self.enemy;
	balla.effects = EF_BRIGHTFIELD;
	balla.owner = self;
	setmodel (balla, "progs/s_explod.spr");
	setsize (balla, '0 0 0', '0 0 0');
	setorigin (balla, self.origin);
	balla.cnt = 0;
	balla.avelocity = '40 40 40';
	balla.think = thinking_balls;
	balla.nextthink = (time + 0.1);
};
void () thinking_balls =
{
	if ((self.cnt > 10))
	{
		sound (self, 1/*CHAN_ENDER*/, "ghoro/spawnb.wav", 1, ATTN_NORM);
		self.solid = SOLID_BBOX;
		self.touch = Brd_MissileTouch;
		self.think = fire_a_ball;
		self.nextthink = (time + 1);
		return;
	}
	self.cnt = (self.cnt + 1);
	ai_orbit2 (self.boost, self.aether);
	if ((self.pain_finished > time))
	{
		self.think = thinking_balls;
		self.nextthink = (time + 0.1);
		return;
	}
	self.pain_finished = (time + 1.1);
	sound (self, CHAN_AUTO, "ghoro/balls.wav", 1, ATTN_NORM);
	self.think = thinking_balls;
	self.nextthink = (time + 0.1);
};
void () Brd_MissileTouch =
{
	local float damg;
	if ((other == self.owner))
	{
		return;
	}
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	if (other.health)
	{
		if ((self.flags & FL_MONSTER))
		{
			damg = 25 + (random () * 5);
			T_RadiusDamage (self, self.owner, 60, other);
		}
		else
		{
			damg = 100 + (random () * 20);
			T_RadiusDamage (self, self.owner, 120, other);
		}
		T_Damage (other, self, self.owner, damg);
		self.origin = (self.origin - (FL_CLIENT * normalize (self.velocity)));
		if ((random () < 0.4))
		{
			BecomeExplosion ();
		}
		else
		{
			BecomeExplosion3 ();
		}
		return;
	}
	sound (self, 1/*CHAN_BAL*/, "ghoro/spawnb.wav", 1, ATTN_NORM);
	remove (self);
};
void () fire_a_ball =
{
	self.blink = (self.blink + 1);
	if ((self.blink > 12))
	{
		sound (self, 1/*CHAN_BAL*/, "ghoro/spawnb.wav", 1, ATTN_NORM);
		remove (self);
		return;
	}
	sound (self, CHAN_AUTO, "ghoro/balls.wav", 1, ATTN_NORM);
	self.solid = SOLID_BBOX;
	makevectors (self.owner.angles);
	self.velocity = normalize ((self.enemy.origin - self.origin));
	self.velocity = (self.velocity * 600);
	self.think = fire_a_ball;
	self.nextthink = (time + 0.6);
};
void (float radius, vector offset) ai_orbit2 =
{
	local vector dir;
	local float dist;
	if (((self.rotate_type > 3) || (self.rotate_type < 0)))
	{
		self.rotate_type = 0;
	}
	traceline (self.origin, (self.owner.origin + offset), TRUE, world);
	if ((trace_fraction < 1))
	{
		setorigin (self, (self.owner.origin + offset));
		self.rotate_type = (self.rotate_type + 1);
		return;
	}
	if ((self.rotate_type == 0))
	{
		dir = (self.owner.origin + offset) - self.origin;
		dir_x = dir_x + radius;
	}
	else
	{
		if ((self.rotate_type == 1))
		{
			dir = (self.owner.origin + offset) - self.origin;
			dir_y = dir_y + radius;
		}
		else
		{
			if ((self.rotate_type == 2))
			{
				dir = (self.owner.origin + offset) - self.origin;
				dir_x = dir_x - radius;
			}
			else
			{
				dir = (self.owner.origin + offset) - self.origin;
				dir_y = dir_y - radius;
			}
		}
	}
	dist = vlen (dir);
	if ((dist < 8))
	{
		self.rotate_type = (self.rotate_type + 1);
	}
	else
	{
		if ((dist < 50))
		{
			self.velocity = normalize (dir);
			self.velocity = (self.velocity * 150);
		}
		else
		{
			self.velocity = normalize (dir);
			self.velocity = (self.velocity * 500);
		}
	}
};
void () beard_attack1 = [ 92, beard_attack2 ]
{
	self.pain_finished = (time + 2);
	ai_face ();
};
void () beard_attack2 = [ 91, beard_attack3 ]
{
	ai_face ();
	self.takedamage = DAMAGE_NO;
};
void () beard_attack3 = [ 90, beard_attack4 ]
{
	ai_face ();
};
void () beard_attack4 = [ 89, beard_attack5 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
};
void () beard_attack5 = [ 88, beard_attack6 ]
{
	ai_face ();
};
void () beard_attack6 = [ 87, beard_attack7 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	beard_balls (5, '0 0 10');
};
void () beard_attack7 = [ 86, beard_attack8 ]
{
	ai_face ();
};
void () beard_attack8 = [ 85, beard_attack9 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	beard_balls (5, '0 0 30');
};
void () beard_attack9 = [ 84, beard_attack10 ]
{
	ai_face ();
};
void () beard_attack10 = [ 83, beard_attack11 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	beard_balls (9, '0 0 40');
	self.takedamage = DAMAGE_AIM;
};
void () beard_attack11 = [ 84, beard_attack12 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
};
void () beard_attack12 = [ 85, beard_attack13 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
};
void () beard_attack13 = [ 84, beard_attack14 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
	self.walkframe = 0;
};
void () beard_attack14 = [ 85, beard_attack15 ]
{
	ai_face ();
	self.effects = (self.effects | EF_MUZZLEFLASH);
};
void () beard_attack15 =
{
	if ((self.walkframe >= 11))
	{
		self.th_run ();
		return;
	}
	parse_anim ( 95, beard_attack15 );
	self.frame = (95 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_face ();
};
void () beard_wins =
{
	beard_talksound ();
	if ((random () < 0.4))
	{
		beard_look ();
	}
	else
	{
		beard_nod ();
	}
};
void () beard_talksound =
{
	local float num;
	num = random () + random ();
	if ((num < 0.6))
	{
		sound (self, CHAN_VOICE, "ghoro/talk1.wav", 1, ATTN_NORM);
		return;
	}
	if ((num < 1.2))
	{
		sound (self, CHAN_VOICE, "ghoro/talk2.wav", 1, ATTN_NORM);
		return;
	}
	sound (self, CHAN_VOICE, "ghoro/talk3.wav", 1, ATTN_NORM);
};
void () beard_look =
{
	if ((self.walkframe >= 18))
	{
		self.walkframe = 0;
		self.th_stand ();
		return;
	}
	parse_anim ( 175, beard_look );
	self.frame = (175 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () beard_nod =
{
	if ((self.walkframe >= 9))
	{
		self.walkframe = 0;
		self.th_stand ();
		return;
	}
	parse_anim ( 193, beard_nod );
	self.frame = (193 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
//END
