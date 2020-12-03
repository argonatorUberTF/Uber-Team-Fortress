#ifdef decemberween
void (entity attacker, float damage) santa_pain;
vector (float pspeed, vector org) special_aim =
{
	local entity targ;
	local vector dir;
	local float dist;
	local float tspeed;
	local float ahead;
	local vector ts;
	targ = self.enemy;
	dist = vlen ((targ.origin - org));
	if ((dist > 200))
	{
		ts = (targ.origin - targ.origin/*targ.organgles*/);
		tspeed = (vlen (ts) * 1.065);
		if ((tspeed > 1))
		{
			ahead = (tspeed / pspeed);
			ahead = (ahead * (dist / tspeed));
		}
		else
		{
			ahead = 1;
		}
		dir = normalize ((((targ.origin + (ahead * ts)) + '0 0 10') - org));
	}
	else
	{
		dir = normalize (((targ.origin + '0 0 10') - org));
	}
	//targ.organgles = targ.origin;
	return (dir);
};
void () santa_lounge1 = [ 0, santa_lounge2 ]
{
	ai_stand ();
	if ((random () > 0.95))
	{
		sound (self, CHAN_AUTO, "santa/hohoho.wav", 0.5, ATTN_IDLE);
	}
};
void () santa_lounge2 = [ 1, santa_lounge3 ]
{
	ai_stand ();
};
void () santa_lounge3 = [ 2, santa_lounge4 ]
{
	ai_stand ();
};
void () santa_lounge4 = [ 3, santa_lounge5 ]
{
	ai_stand ();
};
void () santa_lounge5 = [ 4, santa_lounge6 ]
{
	ai_stand ();
};

void () santa_lounge6 = [ 5, santa_lounge1 ]
{
	ai_stand ();
};
void () santa_seated;
void () santa_seatedA1 = [ 71, santa_seatedA2 ]
{
	ai_stand ();
};
void () santa_seatedA2 = [ 72, santa_seatedA3 ]
{
	ai_stand ();
};
void () santa_seatedA3 = [ 73, santa_seatedA4 ]
{
	ai_stand ();
};
void () santa_seatedA4 = [ 74, santa_seatedA5 ]
{
	ai_stand ();
};
void () santa_seatedA5 = [ 75, santa_seatedA6 ]
{
	ai_stand ();
};
void () santa_seatedA6 = [ 76, santa_seatedA1 ]
{
	santa_seated ();
};
void () santa_seatedB1 = [ 78, santa_seatedB2 ]
{
	ai_stand ();
};
void () santa_seatedB2 = [ 79, santa_seatedB3 ]
{
	ai_stand ();
};
void () santa_seatedB3 = [ 80, santa_seatedB4 ]
{
	ai_stand ();
};
void () santa_seatedB4 = [ 81, santa_seatedB5 ]
{
	ai_stand ();
};
void () santa_seatedB5 = [ 82, santa_seatedB6 ]
{
	ai_stand ();
};
void () santa_seatedB6 = [ 83, santa_seatedB1 ]
{
	santa_seated ();
};
void () FreeSanta =
{
/*
	if ((other.classname == "player"))
	{
		bprint (other.netname);
		bprint (" has liberated Santa from the claws of hell!\n");
		playervictory = SPAWNFLAG_SUPERSPIKE;
		sound (other, CHAN_AUTO, "santa/saved.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		execute_changelevel ();
		remove (self);
	}
	*/
};
void () santa_seated =
{
	self.touch = FreeSanta;
	self.health = 30000;
	if ((random () < 0.3))
	{
		santa_seatedA1 ();
	}
	else
	{
		santa_seatedB1 ();
	}
};
void () santa_stand;

void () santa_stand1 = [ 6, santa_stand2 ]
{
	ai_stand ();
	if ((random () > 0.95))
	{
		sound (self, CHAN_AUTO, "santa/hohoho.wav", 0.5, ATTN_IDLE);
	}
};
void () santa_stand2 = [ 7, santa_stand3 ]
{
	ai_stand ();
};
void () santa_stand3 = [ 8, santa_stand4 ]
{
	ai_stand ();
};
void () santa_stand4 = [ 9, santa_stand5 ]
{
	ai_stand ();
};
void () santa_stand5 = [ 10, santa_stand6 ]
{
	ai_stand ();
};
void () santa_stand6 = [ 11, santa_stand ]
{
	santa_stand ();
};
void () santa_run;
void () santa_run1 = [ 22, santa_run2 ]
{
	ai_run (20);
	self.health = (self.health + 0.1);
	self.th_stand = santa_stand1;
};
void () santa_run2 = [ 23, santa_run3 ]
{
	ai_run (24);
};
void () santa_run3 = [ 24, santa_run4 ]
{
	ai_run (20);
};
void () santa_run4 = [ 25, santa_run5 ]
{
	ai_run (20);
};
void () santa_run5 = [ 26, santa_run6 ]
{
	ai_run (24);
};
void () santa_run6 = [ 27, santa_run ]
{
	ai_run (20);
};
void () santa_victorious1 = [ 12, santa_victorious2 ]
{
	local float rnd;
	if ((self.inpain <= 1))
	{
		rnd = random ();
		if ((rnd < 0.33))
		{
			sound (self, CHAN_VOICE, "santa/laugh1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
		}
		else
		{
			if ((rnd < 0.66))
			{
				sound (self, CHAN_VOICE, "santa/laugh2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
			}
			else
			{
				sound (self, CHAN_VOICE, "santa/laugh3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
			}
		}
		self.inpain = (TE_LIGHTNING1 + (TE_LIGHTNING1 * random ()));
	}
	else
	{
		self.inpain = (self.inpain - SPAWNFLAG_SUPERSPIKE);
	}
};

void () santa_victorious2 = [ 13, santa_victorious3 ]
{};
void () santa_victorious3 = [ 14, santa_victorious4 ]
{};
void () santa_victorious4 = [ 15, santa_victorious5 ]
{};
void () santa_victorious5 = [ 16, santa_victorious6 ]
{};
void () santa_victorious6 = [ 17, santa_victorious1 ]
{
	santa_victorious1 ();
};
void () santa_stand =
{
	self.inpain = 1;

		santa_stand1 ();
};
void () santa_run =
{
	self.inpain = 1;
		santa_run1 ();
};

void () snowball_think =
{
	local float t;
	local float col;
	local float num;
	local vector vel;
	t = AS_MELEE;
	while (t)
	{
		t = (t - SPAWNFLAG_SUPERSPIKE);
		col = (16 * random ());
		num = (75 + (25 * random ()));
		if ((random () < 0.5))
		{
			vel_x = (25 + (20 * random ()));
		}
		else
		{
			vel_x = (CONTENT_EMPTY * (25 + (20 * random ())));
		}
		if ((random () < 0.5))
		{
			vel_y = (25 + (20 * random ()));
		}
		else
		{
			vel_y = (CONTENT_EMPTY * (25 + (20 * random ())));
		}
		if ((random () < 0.5))
		{
			vel_z = (25 + (20 * random ()));
		}
		else
		{
			vel_z = (CONTENT_EMPTY * (25 + (20 * random ())));
		}
		//particle (self.origin, vel, col, num);
	}
	self.think = SUB_Remove;
	self.nextthink = (time + 0.1);
};
void () SantaSnowballTouch =
{
	if ((((other.classname == "monster_elf") || (other.classname == "monster_snowman")) || (other.classname == "monster_deer")))
	{
		remove (self);
		return;
	}
	if ((other.classname == "snowball"))
	{
		return;
	}
	if ((other == self.owner))
	{
		remove (self);
		return;
	}
	if (other.takedamage)
	{
		T_Damage (other, self, self.owner, ((random () * 15) + TE_LIGHTNING1));
	}
	sound (self, CHAN_VOICE, "zombie/z_miss.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	self.nextthink = (time + 0.1);
	self.think = snowball_think;
};
void (vector org, vector dir, entity targ) SantaFireSnowball =
{
	local entity missile;
	//local entity mpuff;
	//local vector lead;
	//local vector trg;
	sound (self, CHAN_WEAPON, "santa/fire.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	missile.enemy = targ;
	missile.classname = "snowball";
	missile.velocity = (dir * 1000);
	missile.angles = vectoangles (missile.velocity);
	missile.touch = SantaSnowballTouch;
	missile.think = SUB_Remove;
	missile.nextthink = (time + TE_LAVASPLASH);
	setmodel (missile, "progs/snowball.mdl");
	setsize (missile, '-2 -2 -2', '2 2 2');
	setorigin (missile, org);
};

void (float side) SantaSmack =
{
	local vector delta;
	local float ldmg;
	ai_charge (TE_LAVASPLASH);
	delta = (self.enemy.origin - self.origin);
	if ((vlen (delta) > 100))
	{
		return;
	}
	ldmg = (((random () + random ()) + random ()) * 12);
	T_Damage (self.enemy, self, self, ldmg);
	if ((self.enemy.classname == "player"))
	{
		stuffcmd (self.enemy, "bf\n");
	}
	sound (self, CHAN_VOICE, "santa/smack.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	if (side)
	{
		makevectors (self.angles);
		SpawnMeatSpray ((self.origin + (v_forward * 16)), (side * v_right));
	}
};
void () santa_sacksw1 = [ 32, santa_sacksw2 ]
{
	ai_charge (AS_MELEE);
};
void () santa_sacksw2 = [ 33, santa_sacksw3 ]
{
	ai_charge (TE_WIZSPIKE);
};
void () santa_sacksw3 = [ 34, santa_sacksw4 ]
{
	ai_charge (AS_MELEE);
};
void () santa_sacksw4 = [ 35, santa_sacksw5 ]
{
	ai_charge (TE_WIZSPIKE);
};
void () santa_sacksw5 = [ 36, santa_sacksw6 ]
{
	ai_charge (TE_WIZSPIKE);
};
void () santa_sacksw6 = [ 37, santa_sacksw7 ]
{
	ai_charge (14);
};
void () santa_sacksw7 = [ 38, santa_sacksw8 ]
{
	ai_charge (18);
};
void () santa_sacksw8 = [ 39, santa_sacksw9 ]
{
	ai_charge (24);
	SantaSmack (150);
};
void () santa_sacksw9 = [ 40, santa_sacksw10 ]
{
	ai_charge (TE_LAVASPLASH);
};
void () santa_sacksw10 = [ 41, santa_run1 ]
{
	if (self.inpain)
	{
		self.inpain = 1;
		self.th_pain = santa_pain;
	}
	ai_charge (TE_WIZSPIKE);
	if ((random () < 0.5))
	{
		self.think = santa_sacksw1;
	}
};
void (vector dira, vector dirb, vector orga, vector orgb, entity targ) santa_fire =
{
	if (self.inpain)
	{
		self.inpain = 1;
		self.th_pain = santa_pain;
	}
	SantaFireSnowball (orga, dira, targ);
	SantaFireSnowball (orgb, dirb, targ);
};
void () santa_gun1 = [ 28, santa_gun2 ]
{
	local vector dira;
	local vector dirb;
	local vector orga;
	local vector orgb;

	ai_face ();
	dira = special_aim (1000, self.origin);
	dira = vectoangles (dira);
	makevectors (dira);
	orga = (((self.origin + (v_right * SVC_KILLEDMONSTER)) + (v_up * 25)) + (v_forward * 45));
	orgb = (((self.origin + (v_right * 18)) + (v_up * 22)) + (v_forward * 45));
	dira = special_aim (1000, orga);
	dirb = special_aim (1000, orgb);
	dirb = (dirb - (v_right * 0.05));
	santa_fire (dira, dirb, orga, orgb, self.enemy);
	self.effects = (self.effects | EF_MUZZLEFLASH);
};
void () santa_gun2 = [ 29, santa_gun3 ]
{
	ai_face ();
};
void () santa_gun3 = [ 30, santa_gun4 ]
{
	ai_face ();
};
void () santa_gun4 = [ 31, santa_run1 ]
{
	ai_face ();
};
void () santa_paina1 = [ 42, santa_paina2 ]
{
	self.inpain = SPAWNFLAG_SUPERSPIKE;
	self.th_pain = SUB_Null;
};
void () santa_paina2 = [ 43, santa_paina3 ]
{};
void () santa_paina3 = [ 44, santa_paina4 ]
{};
void () santa_paina4 = [ 45, santa_paina5 ]
{};
void () santa_paina5 = [ 46, santa_run1 ]
{};
void () santa_painb1 = [ 47, santa_painb2 ]
{
	self.inpain = SPAWNFLAG_SUPERSPIKE;
	self.th_pain = SUB_Null;
};
void () santa_painb2 = [ 48, santa_painb3 ]
{};
void () santa_painb3 = [ 49, santa_painb4 ]
{};
void () santa_painb4 = [ 50, santa_painb5 ]
{};
void () santa_painb5 = [ 51, santa_run1 ]
{};
void (entity attacker, float damage) santa_pain =
{
	local float r;
	if ((self.health <= 1))
	{
		return;
	}
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + SPAWNFLAG_SUPERSPIKE);
	r = random ();
	if ((r < 0.5))
	{
		santa_paina1 ();
		sound (self, CHAN_VOICE, "santa/pain1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	}
	else
	{
		santa_painb1 ();
		sound (self, CHAN_VOICE, "santa/pain2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	}
};
void () santa_detstage2 =
{
	if ((self.inpain == CONTENT_EMPTY))
	{
		return;
	}
	if (self.inpain)
	{
		self.inpain = (self.inpain - SPAWNFLAG_SUPERSPIKE);
		ThrowGib ("progs/gib1.mdl", (random () * -150));
		ThrowGib ("progs/gib2.mdl", (random () * -150));
		ThrowGib ("progs/gib3.mdl", (random () * -150));
		self.nextthink = (time + 0.25);
		self.think = santa_detstage2;
	}
	else
	{
		ThrowHead ("progs/h_santa.mdl", (random () * -400));
		ThrowGib ("progs/gib_s1.mdl", (random () * -250));
		ThrowGib ("progs/gib_s1.mdl", (random () * -250));
		ThrowGib ("progs/gib1.mdl", (random () * -200));
		ThrowGib ("progs/gib2.mdl", (random () * -200));
		ThrowGib ("progs/gib3.mdl", (random () * -200));
		self.inpain = CONTENT_EMPTY;
	}
};
void () santa_detstage1 =
{
	local vector dir;
	if ((random () < 0.5))
	{
		sound (self, CHAN_AUTO, "santa/death.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	}
	if (self.inpain)
	{
		dir_z = (25 + (75 * random ()));
		if ((random () < 0.5))
		{
			dir_x = (25 + (70 * random ()));
		}
		else
		{
			dir_x = (CONTENT_EMPTY * (25 + (70 * random ())));
		}
		if ((random () < 0.5))
		{
			dir_y = (25 + (70 * random ()));
		}
		else
		{
			dir_y = (CONTENT_EMPTY * (25 + (70 * random ())));
		}
		self.inpain = (self.inpain - SPAWNFLAG_SUPERSPIKE);
		SpawnMeatSpray (self.origin, dir);
		self.nextthink = (time + 0.25);
		self.think = santa_detstage1;
	}
	else
	{
		self.inpain = TE_LIGHTNING1;
		self.solid = SOLID_NOT;
		self.think = santa_detstage2;
		self.nextthink = (time + 2.75);
	}
};
void () santa_detonate =
{
	self.inpain = 35;
	self.think = santa_detstage1;
	self.nextthink = (time + 4);
};
void () santa_deatha1 = [ 52, santa_deatha2 ]
{
	sound (self, CHAN_VOICE, "santa/pain1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
};
void () santa_deatha2 = [ 53, santa_deatha3 ]
{};
void () santa_deatha3 = [ 54, santa_deatha4 ]
{};
void () santa_deatha4 = [ 55, santa_deatha5 ]
{};
void () santa_deatha5 = [ 56, santa_deatha6 ]
{};
void () santa_deatha6 = [ 57, santa_deatha7 ]
{};
void () santa_deatha7 = [ 58, santa_deatha8 ]
{};
void () santa_deatha8 = [ 59, santa_deatha9 ]
{};
void () santa_deatha9 = [ 60, santa_deatha10 ]
{};
void () santa_deatha10 = [ 61, santa_detonate ]
{};
void () santa_deathb1 = [ 62, santa_deathb2 ]
{
	sound (self, CHAN_VOICE, "santa/pain2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
};
void () santa_deathb2 = [ 63, santa_deathb3 ]
{};
void () santa_deathb3 = [ 64, santa_deathb4 ]
{};
void () santa_deathb4 = [ 65, santa_deathb5 ]
{};
void () santa_deathb5 = [ 66, santa_deathb6 ]
{};
void () santa_deathb6 = [ 67, santa_deathb7 ]
{};
void () santa_deathb7 = [ 68, santa_deathb8 ]
{};
void () santa_deathb8 = [ 69, santa_deathb9 ]
{};
void () santa_deathb9 = [ 70, santa_detonate ]
{};
void () santa_die =
{
	self.solid = 0;
	if ((random () < 0.5))
	{
		santa_deatha1 ();
	}
	else
	{
		santa_deathb1 ();
	}
};
void () monster_santa1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_TOSS;
	setmodel (self, "progs/santa.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	//self.health = 1200;
	self.health = MTF_Monster_Health(600);
	if ((self.spawnflags & 2))
	{
		self.skin = SPAWNFLAG_SUPERSPIKE;
		self.th_stand = santa_seated;
		self.th_walk = santa_seated;
		self.th_run = santa_seated;
		self.th_die = santa_die;
		self.th_melee = santa_seated;
		self.th_missile = santa_seated;
		self.th_pain = santa_seated;
	}
	else
	{
		self.th_stand = santa_lounge1;
		self.th_walk = SUB_Null;
		self.th_run = santa_run;
		self.th_die = santa_die;
		self.th_melee = santa_sacksw1;
		self.th_missile = santa_gun1;
		self.th_pain = santa_pain;
	}
	//self.found = 1;
	coop_walkmonster_start ();
};
void () monster_santa =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/santa.mdl");
	precache_model ("progs/h_santa.mdl");
	precache_model ("progs/snowball.mdl");
	precache_model ("progs/gib_s1.mdl");
	precache_sound ("santa/hohoho.wav");
	precache_sound ("santa/pain1.wav");
	precache_sound ("santa/pain2.wav");
	precache_sound ("santa/spot.wav");
	precache_sound ("santa/fire.wav");
	precache_sound ("santa/smack.wav");
	precache_sound ("santa/death.wav");
	precache_sound ("santa/laugh1.wav");
	precache_sound ("santa/laugh2.wav");
	precache_sound ("santa/laugh3.wav");
	precache_sound ("santa/saved.wav");
	precache_sound ("zombie/z_miss.wav");
	self.netname = "santa";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_santa1;
	COOP_SetLives ();
	monster_santa1 ();
};
#endif
//END
