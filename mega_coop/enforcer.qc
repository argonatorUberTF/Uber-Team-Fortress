void () enf_satk1;
void () enforcer_fire =
{
	local vector org, sorg;
	muzzleflash ();
	makevectors (self.angles);
	if (self.weapon & #MWEAPON_SNIPER)
	{
		sound (self, 1, "weapons/rifle.wav", 1, 1);
		if (self.building != world)
			dremove(self.building);
		org = self.origin;// + (v_forward * 10.000000);
		traceline (org, self.enemy.origin + '0 0 11', 0, self);
		if (trace_ent != world && (trace_ent.classname == "player" || trace_ent.is_monster == 1))
		{
			SpawnBlood (trace_endpos, 9);
			if (random() > 0.7)
			{
				if (trace_ent.invincible_time != TRUE)
				{
					trace_ent.leg_damage = TF_FLARE_OFF;
					if (trace_ent.classname == "player")
					{
						sprint(trace_ent, 2, "Your leg's been shot by a sniper bullet! Seek a health pack or a medic.\n");
						TeamFortress_SetSpeed(trace_ent);
					}
				}
				TF_T_Damage (trace_ent, self, self, 13, 0, 8);
			}
			else
{
				if (vlen(trace_ent.velocity) > 500 && random() > 0.3)
					TF_T_Damage (trace_ent, self, self, 10, 0, 8);
				else
if (vlen(trace_ent.velocity) > 300 && random() > 0.5)
					TF_T_Damage (trace_ent, self, self, 20, 0, 8);
				else
					TF_T_Damage (trace_ent, self, self, 40, 0, 8);	// xav: maybe randomize damage here a bit..
			}
		}
		else
		{
		makevectors(self.origin);
		sorg = trace_endpos - (v_forward * 4.000000);
		WriteByte (4.000000, 23.000000);
		WriteByte (4.000000, 0.000000);
		WriteCoord (4.000000, sorg_x);
		WriteCoord (4.000000, sorg_y);
		WriteCoord (4.000000, sorg_z);
		multicast (self.origin, 1.000000);
		}
	}
	else
	{
		org = (((self.origin + (v_forward * SVC_INTERMISSION)) + (v_right * 8.5)) + '0 0 16');
		LaunchLaser (org, (self.enemy.origin - self.origin));
	}
};
void () enf_stand1 = [ 0, enf_stand2 ]
{
	ai_stand ();
};
void () enf_stand2 = [ 1, enf_stand3 ]
{
	ai_stand ();
};
void () enf_stand3 = [ 2, enf_stand4 ]
{
	ai_stand ();
};
void () enf_stand4 = [ 3, enf_stand5 ]
{
	ai_stand ();
};
void () enf_stand5 = [ 4, enf_stand6 ]
{
	ai_stand ();
};
void () enf_stand6 = [ 5, enf_stand7 ]
{
	ai_stand ();
};
void () enf_stand7 = [ 6, enf_stand1 ]
{
	ai_stand ();
};
void () enf_walk1 = [ 7, enf_walk2 ]
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "enforcer/idle1.wav", true, ATTN_IDLE);
	}
	ai_walk (FL_SWIM);
};
void () enf_walk2 = [ 8, enf_walk3 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () enf_walk3 = [ 9, enf_walk4 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () enf_walk4 = [ 10, enf_walk5 ]
{
	ai_walk (MOVETYPE_WALK);
};
void () enf_walk5 = [ 11, enf_walk6 ]
{
	ai_walk (true);
};
void () enf_walk6 = [ 12, enf_walk7 ]
{
	ai_walk (FL_SWIM);
};
void () enf_walk7 = [ 13, enf_walk8 ]
{
	ai_walk (FL_SWIM);
};
void () enf_walk8 = [ 14, enf_walk9 ]
{
	ai_walk (true);
};
void () enf_walk9 = [ 15, enf_walk10 ]
{
	ai_walk (FL_SWIM);
};
void () enf_walk10 = [ 16, enf_walk11 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () enf_walk11 = [ 17, enf_walk12 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () enf_walk12 = [ 18, enf_walk13 ]
{
	ai_walk (true);
};
void () enf_walk13 = [ 19, enf_walk14 ]
{
	ai_walk (FL_SWIM);
};
void () enf_walk14 = [ 20, enf_walk15 ]
{
	ai_walk (MOVETYPE_WALK);
};
void () enf_walk15 = [ 21, enf_walk16 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () enf_walk16 = [ 22, enf_walk1 ]
{
	ai_walk (FL_SWIM);
};
void () enf_run1 = [ 23, enf_run2 ]
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "enforcer/idle1.wav", true, ATTN_IDLE);
	}
	ai_run (18);
};
void () enf_run2 = [ 24, enf_run3 ]
{
	ai_run (14);
};
void () enf_run3 = [ 25, enf_run4 ]
{
	ai_run (MOVETYPE_PUSH);
};
void () enf_run4 = [ 26, enf_run5 ]
{
	ai_run (TE_BLOOD);
};
void () enf_run5 = [ 27, enf_run6 ]
{
	ai_run (14);
};
void () enf_run6 = [ 28, enf_run7 ]
{
	ai_run (14);
};
void () enf_run7 = [ 29, enf_run8 ]
{
	ai_run (MOVETYPE_PUSH);
};
void () enf_run8 = [ 30, enf_run1 ]
{
	ai_run (MOVETYPE_BOUNCEMISSILE);
};
void () enf_atk1 = [ 31, enf_atk2 ]
{
	ai_face ();
};
void () enf_atk2 = [ 32, enf_atk3 ]
{
	ai_face ();
};
void () enf_atk3 = [ 33, enf_atk4 ]
{
	ai_face ();
};
void () enf_atk4 = [ 34, enf_atk5 ]
{
	ai_face ();
};
void () enf_atk5 = [ 35, enf_atk6 ]
{
	ai_face ();
};
void () enf_atk6 = [ 36, enf_atk7 ]
{
	enforcer_fire ();
};
void () enf_atk7 = [ 37, enf_atk8 ]
{
	ai_face ();
};
void () enf_atk8 = [ 38, enf_atk9 ]
{
	ai_face ();
};
void () enf_atk9 = [ 35, enf_atk10 ]
{
	ai_face ();
};
void () enf_atk10 = [ 36, enf_atk11 ]
{
	enforcer_fire ();
};
void () enf_atk11 = [ 37, enf_atk12 ]
{
	ai_face ();
};
void () enf_atk12 = [ 38, enf_atk13 ]
{
	ai_face ();
};
void () enf_atk13 = [ 39, enf_atk14 ]
{
	ai_face ();
};
void () enf_atk14 = [ 40, enf_run1 ]
{
	ai_face ();
	if (self.weapon & #MWEAPON_SNIPER)
		SUB_CheckRefire (enf_satk1);
	else
		SUB_CheckRefire (enf_atk1);
};
void () enf_paina1 = [ 66, enf_paina2 ]
{};
void () enf_paina2 = [ 67, enf_paina3 ]
{};
void () enf_paina3 = [ 68, enf_paina4 ]
{};
void () enf_paina4 = [ 69, enf_run1 ]
{};
void () enf_painb1 = [ 70, enf_painb2 ]
{};
void () enf_painb2 = [ 71, enf_painb3 ]
{};
void () enf_painb3 = [ 72, enf_painb4 ]
{};
void () enf_painb4 = [ 73, enf_painb5 ]
{};
void () enf_painb5 = [ 74, enf_run1 ]
{};
void () enf_painc1 = [ 75, enf_painc2 ]
{};
void () enf_painc2 = [ 76, enf_painc3 ]
{};
void () enf_painc3 = [ 77, enf_painc4 ]
{};
void () enf_painc4 = [ 78, enf_painc5 ]
{};
void () enf_painc5 = [ 79, enf_painc6 ]
{};
void () enf_painc6 = [ 80, enf_painc7 ]
{};
void () enf_painc7 = [ 81, enf_painc8 ]
{};
void () enf_painc8 = [ 82, enf_run1 ]
{};
void () enf_paind1 = [ 83, enf_paind2 ]
{};
void () enf_paind2 = [ 84, enf_paind3 ]
{};
void () enf_paind3 = [ 85, enf_paind4 ]
{};
void () enf_paind4 = [ 86, enf_paind5 ]
{
	ai_painforward (FL_SWIM);
};
void () enf_paind5 = [ 87, enf_paind6 ]
{
	ai_painforward (true);
};
void () enf_paind6 = [ 88, enf_paind7 ]
{};
void () enf_paind7 = [ 89, enf_paind8 ]
{};
void () enf_paind8 = [ 90, enf_paind9 ]
{};
void () enf_paind9 = [ 91, enf_paind10 ]
{};
void () enf_paind10 = [ 92, enf_paind11 ]
{};
void () enf_paind11 = [ 93, enf_paind12 ]
{
	ai_painforward (true);
};
void () enf_paind12 = [ 94, enf_paind13 ]
{
	ai_painforward (true);
};
void () enf_paind13 = [ 95, enf_paind14 ]
{
	ai_painforward (true);
};
void () enf_paind14 = [ 96, enf_paind15 ]
{};
void () enf_paind15 = [ 97, enf_paind16 ]
{};
void () enf_paind16 = [ 98, enf_paind17 ]
{
	ai_pain (true);
};
void () enf_paind17 = [ 99, enf_paind18 ]
{
	ai_pain (true);
};
void () enf_paind18 = [ 100, enf_paind19 ]
{};
void () enf_paind19 = [ 101, enf_run1 ]
{};
void () enf_pain =
{
	local float r;
	r = random ();
	if ((self.pain_finished > time))
	{
		return;
	}
	if (self.building != world)
		dremove(self.building);
	if ((r < 0.5))
	{
		sound (self, CHAN_VOICE, "enforcer/pain1.wav", true, ATTN_NORM);
	}
	else
	{
		sound (self, CHAN_VOICE, "enforcer/pain2.wav", true, ATTN_NORM);
	}
	if ((r < 0.2))
	{
		self.pain_finished = (time + true);
		enf_paina1 ();
	}
	else
	{
		if ((r < 0.4))
		{
			self.pain_finished = (time + true);
			enf_painb1 ();
		}
		else
		{
			if ((r < 0.7))
			{
				self.pain_finished = (time + true);
				enf_painc1 ();
			}
			else
			{
				self.pain_finished = (time + FL_SWIM);
				enf_paind1 ();
			}
		}
	}
};
void () enf_die1 = [ 41, enf_die2 ]
{};
void () enf_die2 = [ 42, enf_die3 ]
{};
void () enf_die3 = [ 43, enf_die4 ]
{
	self.solid = SOLID_NOT;
	self.ammo_shells = 10;
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	self.ammo_nails = 20;
	DropBackpack ();
};
void () enf_die4 = [ 44, enf_die5 ]
{
	ai_forward (14);
};
void () enf_die5 = [ 45, enf_die6 ]
{
	ai_forward (FL_SWIM);
};
void () enf_die6 = [ 46, enf_die7 ]
{};
void () enf_die7 = [ 47, enf_die8 ]
{};
void () enf_die8 = [ 48, enf_die9 ]
{};
void () enf_die9 = [ 49, enf_die10 ]
{
	ai_forward (MOVETYPE_WALK);
};
void () enf_die10 = [ 50, enf_die11 ]
{
	ai_forward (MOVETYPE_FLY);
};
void () enf_die11 = [ 51, enf_die12 ]
{
	ai_forward (MOVETYPE_FLY);
};
void () enf_die12 = [ 52, enf_die13 ]
{
	ai_forward (MOVETYPE_FLY);
};
void () enf_die13 = [ 53, enf_die14 ]
{};
void () enf_die14 = [ 54, enf_die14 ]
{};
void () enf_fdie1 = [ 55, enf_fdie2 ]
{};
void () enf_fdie2 = [ 56, enf_fdie3 ]
{};
void () enf_fdie3 = [ 57, enf_fdie4 ]
{
	self.solid = SOLID_NOT;
	self.ammo_shells = 10;
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	self.ammo_nails = 20;
	DropBackpack ();
};
void () enf_fdie4 = [ 58, enf_fdie5 ]
{};
void () enf_fdie5 = [ 59, enf_fdie6 ]
{};
void () enf_fdie6 = [ 60, enf_fdie7 ]
{};
void () enf_fdie7 = [ 61, enf_fdie8 ]
{};
void () enf_fdie8 = [ 62, enf_fdie9 ]
{};
void () enf_fdie9 = [ 63, enf_fdie10 ]
{};
void () enf_fdie10 = [ 64, enf_fdie11 ]
{};
void () enf_fdie11 = [ 65, enf_fdie11 ]
{};
void () Enforcer_SniperSight_Update =
{
	local vector org;
	if (self.owner.health <= 0 || self.owner == world || self.owner.is_monster != #TRUE)
		dremove(self);
	self.frame = 0.000000;
	org = self.owner.origin;// + (v_forward * 10.000000);
	traceline (org, self.owner.enemy.origin + '0 0 11', 0, self);
	self.angles = vectoangles (v_forward);
	setorigin (self, trace_endpos);
	self.effects = 8;	// let it glow so we know who's a friendly and who's not
	self.nextthink = (time + 0.1);
};
void () Enforcer_SniperSight_Create =
{
	local entity sight;
	if (self.building != world)	// secondary precaution
		dremove(self.building);
	sight = spawn ();
	sight.owner = self;
	sight.movetype = 8.000000;
	sight.solid = 0.000000;
	setmodel (sight, "progs/newdot.spr");
	sight.frame = 1;
	sight.classname = "timer";
	setorigin (sight, self.origin);
	sight.think = Enforcer_SniperSight_Update;
	self.building = sight;
	sight.nextthink = (time + 0.050000);
};
void () enf_satk1 = [ 31, enf_satk2 ]
{
	Enforcer_SniperSight_Create ();
	ai_face ();
};
void () enf_satk2 = [ 32, enf_satk3 ]
{
	ai_face ();
};
void () enf_satk3 = [ 33, enf_satk4 ]
{
	ai_face ();
};
void () enf_satk4 = [ 34, enf_satk5 ]
{
	ai_face ();
};
void () enf_satk5 = [ 35, enf_satk6 ]
{
	ai_face ();
};
void () enf_satk6 = [ 35, enf_satk7 ]
{
	ai_face ();
};
void () enf_satk7 = [ 35, enf_satk8 ]
{
	ai_face ();
};
void () enf_satk8 = [ 35, enf_satk9 ]
{
	ai_face ();
};
void () enf_satk9 = [ 35, enf_satk9a ]
{
	ai_face ();
};
void () enf_satk9a = [ 35, enf_satk9b ]
{
	ai_face ();
};
void () enf_satk9b = [ 35, enf_satk9c ]
{
	ai_face ();
};
void () enf_satk9c = [ 35, enf_satk10 ]
{
	ai_face ();
};
void () enf_satk10 = [ 36, enf_satk11]
{
	ai_face ();
//	SUB_CheckRefire (enf_satk1);
};
void () enf_satk11 = [ 37, enf_satk12 ]
{
	enforcer_fire ();
	ai_face ();
};
void () enf_satk12 = [ 38, enf_satk13 ]
{
	ai_face ();
};
void () enf_satk13 = [ 39, enf_satk14 ]
{
	ai_face ();
};
void () enf_satk14 = [ 40, enf_run1 ]
{
	ai_face ();
	SUB_CheckRefire (enf_satk1);
};
void () enf_die =
{
	if ((self.health < -35))
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", true, ATTN_NORM);
		ThrowHead (mtf_savemodel("progs/h_mega.mdl"), self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	sound (self, CHAN_VOICE, "enforcer/death1.wav", true, ATTN_NORM);
	if ((random () > 0.5))
	{
		enf_die1 ();
	}
	else
	{
		enf_fdie1 ();
	}
};
void () monster_enforcer1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/enforcer.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = MTF_Monster_Health(80);
	self.th_stand = enf_stand1;
	self.th_walk = enf_walk1;
	self.th_run = enf_run1;
	self.th_pain = enf_pain;
	self.th_die = enf_die;
	if (self.weapon & MWEAPON_SNIPER)
		self.th_missile = enf_satk1;
	else
		self.th_missile = enf_atk1;
	coop_walkmonster_start ();
};
void () monster_enforcer =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model2 ("progs/enforcer.mdl");
	precache_model2 (mtf_savemodel("progs/h_mega.mdl"));
	precache_model2 ("progs/laser.mdl");
	precache_sound2 ("enforcer/death1.wav");
	precache_sound2 ("enforcer/enfire.wav");
	precache_sound2 ("enforcer/enfstop.wav");
	precache_sound2 ("enforcer/idle1.wav");
	precache_sound2 ("enforcer/pain1.wav");
	precache_sound2 ("enforcer/pain2.wav");
	precache_sound2 ("enforcer/sight1.wav");
	precache_sound2 ("enforcer/sight2.wav");
	precache_sound2 ("enforcer/sight3.wav");
	precache_sound2 ("enforcer/sight4.wav");
	self.netname = "enforcer";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_enforcer1;
	COOP_SetLives ();
	monster_enforcer1 ();
};
//END
