#ifdef decemberween
void () elf_pain1;
void () elf_surprise1;
void () elf_stand1 = [ 0, elf_stand2 ]
{
	ai_stand ();
	if (self.enemy.classname == "player")
	{
		//self.found = SPAWNFLAG_SUPERSPIKE;
		//elf_surprise1 ();
	}
	if ((random () > 0.97))
	{
		sound (self, CHAN_VOICE, "elf/idle.wav", (0.5 + (0.5 * random ())), ATTN_IDLE);
	}
};
void () elf_stand2 = [ 1, elf_stand3 ]
{
	ai_stand ();
};
void () elf_stand3 = [ 2, elf_stand4 ]
{
	ai_stand ();
};
void () elf_stand4 = [ 3, elf_stand5 ]
{
	ai_stand ();
};
void () elf_stand5 = [ 4, elf_stand6 ]
{
	ai_stand ();
};
void () elf_stand6 = [ 5, elf_stand7 ]
{
	ai_stand ();
};
void () elf_stand7 = [ 6, elf_stand8 ]
{
	ai_stand ();
};
void () elf_stand8 = [ 7, elf_stand1 ]
{
	ai_stand ();
};
void () elf_jattack1;
void () elf_skip1 = [ 8, elf_skip2 ]
{
	local float rnd;
	ai_run (12);
	if (self.enemy.classname == "player")
	{
		//self.found = SPAWNFLAG_SUPERSPIKE;
		//elf_surprise1 ();
	}
	rnd = random ();
	//if (!santavictory)
	{
		if (((rnd > 0.6) && (rnd <= 0.7)))
		{
			sound (self, CHAN_VOICE, "elf/skip1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		}
		else
		{
			if (((rnd > 0.7) && (rnd <= 0.8)))
			{
				sound (self, CHAN_VOICE, "elf/skip2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
			}
			else
			{
				if (((rnd > 0.8) && (rnd <= 0.9)))
				{
					sound (self, CHAN_VOICE, "elf/skip3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
				}
			}
		}
	}
};
void () elf_skip2 = [ 9, elf_skip3 ]
{
	ai_run (18);
};
void () elf_skip3 = [ 10, elf_skip4 ]
{
	ai_run (36);
};
void () elf_skip4 = [ 11, elf_skip5 ]
{
	ai_run (18);
};
void () elf_skip5 = [ 12, elf_skip6 ]
{
	ai_run (8);
};
void () elf_skip6 = [ 13, elf_skip7 ]
{
	ai_run (TE_WIZSPIKE);
};
void () elf_skip7 = [ 14, elf_skip8 ]
{
	ai_run (18);
};
void () elf_skip8 = [ 15, elf_skip9 ]
{
	ai_run (24);
};
void () elf_skip9 = [ 16, elf_skip10 ]
{
	ai_run (TE_LAVASPLASH);
};
void () elf_skip10 = [ 17, elf_walk1 ]
{
	local vector delta;

	if (self.inpain)
	{
		self.inpain = 1;
		self.th_pain = elf_pain1;
	}
	ai_run (12);

	if (self.enemy)
	{
		delta = (self.enemy.origin - self.origin);
		if ((vlen (delta) <= 60))
		{
			elf_jattack1 ();
		}
	}
};
void () elf_walk1 = [ 18, elf_walk2 ]
{
	ai_walk (SPAWNFLAG_LASER);
	if (self.enemy.classname == "player")
	{
		//self.found = SPAWNFLAG_SUPERSPIKE;
		//elf_surprise1 ();
	}
	if (self.enemy)
	{
		if ((random () > 0.5))
		{
			elf_skip1 ();
		}
		if (self.enemy.health > 1)
		{
			if ((random () < 0.1))
			{
				sound (self, CHAN_VOICE, "elf/spot1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
			}
			else
			{
				if ((random () > 0.97))
				{
					sound (self, CHAN_VOICE, "elf/spot2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
				}
			}
		}
	}
};
void () elf_walk2 = [ 19, elf_walk3 ]
{
	ai_walk (AS_MELEE);
};
void () elf_walk3 = [ 20, elf_walk4 ]
{
	ai_walk (TE_LIGHTNING3);
};
void () elf_walk4 = [ 21, elf_walk5 ]
{
	ai_walk (15);
};
void () elf_walk5 = [ 22, elf_walk6 ]
{
	ai_walk (TE_LIGHTNING3);
};
void () elf_walk6 = [ 23, elf_walk7 ]
{
	ai_walk (SPAWNFLAG_LASER);
};
void () elf_walk7 = [ 24, elf_walk8 ]
{
	ai_walk (AS_MELEE);
	if (self.enemy)
	{
		if ((random () > 0.5))
		{
			elf_skip1 ();
		}
	}
};
void () elf_walk8 = [ 25, elf_walk9 ]
{
	ai_walk (TE_LIGHTNING3);
};
void () elf_walk9 = [ 26, elf_walk10 ]
{
	ai_walk (24);
};
void () elf_walk10 = [ 27, elf_walk11 ]
{
	ai_walk (TE_LIGHTNING3);
};
void () elf_walk11 = [ 28, elf_walk12 ]
{
	ai_walk (AS_MELEE);
};
void () elf_walk12 = [ 29, elf_walk1 ]
{
	ai_walk (SPAWNFLAG_LASER);
};
void (float pain) CaneHit =
{
	local vector delta;
	local float ldmg;
	if (self.inpain)
	{
		self.inpain = 1;
		self.th_pain = elf_pain1;
	}
	if (!self.enemy)
	{
		return;
	}
	ai_charge (4);
	delta = (self.enemy.origin - self.origin);
	if ((vlen (delta) > 66))
	{
		return;
	}
	ldmg = (((random () + random ()) + random ()) * pain);
	T_Damage (self.enemy, self, self, ldmg);
	if ((random () < 0.5))
	{
		sound (self, CHAN_WEAPON, "elf/cane1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	}
	else
	{
		sound (self, CHAN_WEAPON, "elf/cane2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	}
	if ((pain == 20))
	{
		makevectors (self.angles);
		SpawnMeatSpray ((self.origin + (v_forward * 16)), (-250 * v_right));
	}
};
void () elf_sattack1 = [ 37, elf_sattack2 ]
{
	ai_charge (4);
};
void () elf_sattack2 = [ 38, elf_sattack3 ]
{
	ai_charge (4);
};
void () elf_sattack3 = [ 39, elf_sattack4 ]
{
	ai_charge (8);
};
void () elf_sattack4 = [ 40, elf_sattack5 ]
{
	ai_charge (12);
	CaneHit (TE_LAVASPLASH);
};
void () elf_sattack5 = [ 41, elf_sattack6 ]
{
	ai_charge (4);
};
void () elf_sattack6 = [ 42, elf_sattack7 ]
{
	ai_charge (4);
};
void () elf_sattack7 = [ 43, elf_sattack8 ]
{
	ai_charge (TE_LIGHTNING2);
};
void () elf_sattack8 = [ 44, elf_sattack9 ]
{
	ai_charge (TE_LIGHTNING2);
};
void () elf_sattack9 = [ 45, elf_sattack10 ]
{
	ai_charge (8);
};
void () elf_sattack10 = [ 46, elf_sattack11 ]
{
	ai_charge (12);
};
void () elf_sattack11 = [ 47, elf_sattack12 ]
{
	ai_charge (TE_LIGHTNING2);
};
void () elf_sattack12 = [ 48, elf_walk1 ]
{
	ai_charge (4);
};
void () elf_jattack1 = [ 49, elf_jattack2 ]
{
	ai_charge (SPAWNFLAG_SUPERSPIKE);
	sound (self, CHAN_VOICE, "elf/jump.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
};
void () elf_jattack2 = [ 50, elf_jattack3 ]
{
	ai_charge (SPAWNFLAG_LASER);
};
void () elf_jattack3 = [ 51, elf_jattack4 ]
{
	ai_charge (SPAWNFLAG_LASER);
};
void () elf_jattack4 = [ 52, elf_jattack5 ]
{
	ai_charge (4);
};
void () elf_jattack5 = [ 53, elf_jattack6 ]
{
	ai_charge (TE_LIGHTNING2);
};
void () elf_jattack6 = [ 54, elf_jattack7 ]
{
	ai_charge (SPAWNFLAG_LASER);
};
void () elf_jattack7 = [ 55, elf_jattack8 ]
{
	ai_charge (SPAWNFLAG_SUPERSPIKE);
	CaneHit (13);
};
void () elf_jattack8 = [ 56, elf_walk1 ]
{
	ai_charge (SPAWNFLAG_SUPERSPIKE);
};
void () elf_fjattack1 = [ 49, elf_fjattack2 ]
{
	ai_charge (20);
};
void () elf_fjattack2 = [ 50, elf_fjattack3 ]
{
	ai_charge (SVC_INTERMISSION);
};
void () elf_fjattack3 = [ 51, elf_fjattack4 ]
{
	ai_charge (40);
};
void () elf_fjattack4 = [ 52, elf_fjattack5 ]
{
	ai_charge (60);
};
void () elf_fjattack5 = [ 53, elf_fjattack6 ]
{
	ai_charge (40);
};
void () elf_fjattack6 = [ 54, elf_fjattack7 ]
{
	ai_charge (SVC_INTERMISSION);
};
void () elf_fjattack7 = [ 55, elf_fjattack8 ]
{
	ai_charge (20);
	CaneHit (15);
};
void () elf_fjattack8 = [ 56, elf_walk1 ]
{
	ai_charge (TE_LIGHTNING1);
};
void () elf_flying =
{
	local vector delta;
	if (self.inpain)
	{
		self.inpain = 1;
		self.th_pain = elf_pain1;
	}
	if (!self.enemy)
	{
		return;
	}
	delta = (self.enemy.origin - self.origin);
	if (((vlen (delta) > 220) && (vlen (delta) < 260)))
	{
		sound (self, CHAN_VOICE, "elf/prepare.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		elf_fjattack1 ();
	}
	return;
};
void () elf_attack1 = [ 57, elf_attack2 ]
{
	ai_charge (SPAWNFLAG_SUPERSPIKE);
};
void () elf_attack2 = [ 58, elf_attack3 ]
{
	ai_charge (SPAWNFLAG_LASER);
	CaneHit (8);
};
void () elf_attack3 = [ 59, elf_attack4 ]
{
	ai_charge (SPAWNFLAG_SUPERSPIKE);
};
void () elf_attack4 = [ 60, elf_attack5 ]
{
	ai_charge (1);
};
void () elf_attack5 = [ 61, elf_walk1 ]
{
	ai_charge (1);
};
void () elf_melee =
{
	local float rnd;
	local vector delta;
	rnd = random ();
	delta = (self.enemy.origin - self.origin);

	if (((vlen (delta) > 110) && (vlen (delta) < 130)))
	{
		if ((rnd < 0.75))
		{
			elf_fjattack1 ();
		}
	}
	if ((rnd < 0.2))
	{
		sound (self, CHAN_BODY, "elf/jump.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		elf_jattack1 ();
	}
	else
	{
		if ((rnd < 0.7))
		{
			elf_attack1 ();
		}
		else
		{
			sound (self, CHAN_BODY, "elf/jump.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
			elf_sattack1 ();
		}
	}
};
void () elf_surprise1 = [ 30, elf_surprise2 ]
{
	ai_stand ();
};
void () elf_surprise2 = [ 31, elf_surprise3 ]
{
	ai_stand ();
};
void () elf_surprise3 = [ 32, elf_surprise4 ]
{
	ai_stand ();
};
void () elf_surprise4 = [ 33, elf_surprise5 ]
{
	ai_stand ();
	if (self.enemy.health > 1)
	{
		if ((random () < 0.5))
		{
			sound (self, CHAN_VOICE, "elf/spot1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		}
		else
		{
			sound (self, CHAN_VOICE, "elf/spot2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		}
	}
};
void () elf_surprise5 = [ 34, elf_surprise6 ]
{
	ai_stand ();
};
void () elf_surprise6 = [ 35, elf_surprise7 ]
{
	ai_stand ();
};
void () elf_surprise7 = [ 36, elf_skip1 ]
{
	ai_stand ();
};
void () elf_dieA1 = [ 79, elf_dieA2 ]
{};

void () elf_dieA2 = [ 80, elf_dieA3 ]
{};

void () elf_dieA3 = [ 81, elf_dieA4 ]
{};

void () elf_dieA4 = [ 82, elf_dieA5 ]
{};
void () elf_dieA5 = [ 83, elf_dieA6 ]
{};
void () elf_dieA6 = [ 84, elf_dieA7 ]
{};
void () elf_dieA7 = [ 85, elf_dieA8 ]
{};
void () elf_dieA8 = [ 86, elf_dieA9 ]
{};
void () elf_dieA9 = [ 87, elf_dieA10 ]
{
	self.solid = SOLID_NOT;
};
void () elf_dieA10 = [ 88, elf_dieA11 ]
{};
void () elf_dieA11 = [ 89, elf_dieA12 ]
{};
void () elf_dieA12 = [ 90, elf_dieA13 ]
{};
void () elf_dieA13 = [ 91, elf_dieA14 ]
{};
void () elf_dieA14 = [ 92, elf_dieA15 ]
{};
void () elf_dieA15 = [ 93, elf_dieA15 ]
{};
void () elf_dieB1 = [ 94, elf_dieB2 ]
{};
void () elf_dieB2 = [ 95, elf_dieB3 ]
{};
void () elf_dieB3 = [ 96, elf_dieB4 ]
{};
void () elf_dieB4 = [ 97, elf_dieB5 ]
{};
void () elf_dieB5 = [ 98, elf_dieB6 ]
{};
void () elf_dieB6 = [ 99, elf_dieB7 ]
{
	self.solid = SOLID_NOT;
};
void () elf_dieB7 = [ 100, elf_dieB8 ]
{};
void () elf_dieB8 = [ 101, elf_dieB9 ]
{};
void () elf_dieB9 = [ 102, elf_dieB10 ]
{};
void () elf_dieB10 = [ 103, elf_dieB11 ]
{};
void () elf_dieB11 = [ 104, elf_dieB12 ]
{};
void () elf_dieB12 = [ 105, elf_dieB13 ]
{};
void () elf_dieB13 = [ 106, elf_dieB14 ]
{};
void () elf_dieB14 = [ 107, elf_dieB14 ]
{};
void () elf_pain1 = [ 62, elf_pain2 ]
{
	self.th_pain = SUB_Null;
	sound (self, CHAN_VOICE, "elf/pain.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
};
void () elf_pain2 = [ 63, elf_pain3 ]
{};
void () elf_pain3 = [ 64, elf_pain4 ]
{};
void () elf_pain4 = [ 65, elf_pain5 ]
{};
void () elf_pain5 = [ 66, elf_skip1 ]
{
	self.inpain = SPAWNFLAG_SUPERSPIKE;
};
void () elf_die =
{
	if ((self.health < -50))
	{
		ThrowHead ("progs/h_elf.mdl", self.health);
		ThrowGib ("progs/minigib1.mdl", self.health);
		ThrowGib ("progs/minigib2.mdl", self.health);
		ThrowGib ("progs/minigib3.mdl", self.health);
		ThrowGib ("progs/cane_elf.mdl", self.health);
		return;
	}
	if ((random () < 0.5))
	{
		sound (self, CHAN_VOICE, "elf/death1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		elf_dieA1 ();
	}
	else
	{
		sound (self, CHAN_VOICE, "elf/death2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		elf_dieB1 ();
	}
};
void () monster_elf1 =
{
	local float rnd;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_TOSS;
	setmodel (self, "progs/elfling.mdl");
	self.classname = "monster_elf";
	setsize (self, '-7 -9 -18', '10 12 24');
	self.health = MTF_Monster_Health(50);	// 70
	self.th_stand = elf_stand1;
	self.th_walk = elf_walk1;
	self.th_run = elf_skip1;
	self.th_die = elf_die;
	self.th_melee = elf_melee;
	self.th_missile = elf_flying;
	self.th_pain = elf_pain1;
	rnd = random ();
	self.skin = 1;
	if ((rnd < 0.33))
	{
		self.skin = SPAWNFLAG_SUPERSPIKE;
	}
	else
	{
		if ((rnd < 0.66))
		{
			self.skin = SPAWNFLAG_LASER;
		}
	}
	coop_walkmonster_start ();
};
void () monster_elf =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/elfling.mdl");
	precache_model ("progs/h_elf.mdl");
	precache_model ("progs/cane_elf.mdl");
	precache_model ("progs/minigib1.mdl");
	precache_model ("progs/minigib2.mdl");
	precache_model ("progs/minigib3.mdl");
	precache_sound ("elf/cane1.wav");
	precache_sound ("elf/cane2.wav");
	precache_sound ("elf/death1.wav");
	precache_sound ("elf/death2.wav");
	precache_sound ("elf/jump.wav");
	precache_sound ("elf/spot1.wav");
	precache_sound ("elf/spot2.wav");
	precache_sound ("elf/pain.wav");
	precache_sound ("elf/idle.wav");
	precache_sound ("elf/skip1.wav");
	precache_sound ("elf/skip2.wav");
	precache_sound ("elf/skip3.wav");
	precache_sound ("elf/prepare.wav");
	self.netname = "evil elf";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_elf1;
	COOP_SetLives ();
	monster_elf1 ();
};
#endif
//END
