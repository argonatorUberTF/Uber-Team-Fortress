void () axe_stand2;
void () axe_stand1 = [ 17, axe_stand2 ]
{
	ai_stand ();
};
void () axe_stand3;
void () axe_stand2 = [ 18, axe_stand3 ]
{
	ai_stand ();
};
void () axe_stand4;
void () axe_stand3 = [ 19, axe_stand4 ]
{
	ai_stand ();
};
void () axe_stand5;
void () axe_stand4 = [ 20, axe_stand5 ]
{
	ai_stand ();
};
void () axe_stand6;
void () axe_stand5 = [ 21, axe_stand6 ]
{
	ai_stand ();
};
void () axe_stand7;
void () axe_stand6 = [ 22, axe_stand7 ]
{
	ai_stand ();
};
void () axe_stand8;
void () axe_stand7 = [ 23, axe_stand8 ]
{
	ai_stand ();
};
void () axe_stand9;
void () axe_stand8 = [ 24, axe_stand9 ]
{
	ai_stand ();
};
void () axe_stand10;
void () axe_stand9 = [ 25, axe_stand10 ]
{
	ai_stand ();
};
void () axe_stand11;

void () axe_stand10 = [ 26, axe_stand11 ]
{
	ai_stand ();
};
void () axe_stand12;
void () axe_stand11 = [ 27, axe_stand12 ]
{
	ai_stand ();
};
void () axe_stand12 = [ 28, axe_stand1 ]
{
	ai_stand ();
};
void () axe_walk2;
void () axe_walk1 = [ 17, axe_walk2 ]
{
	ai_walk (TRUE);
};
void () axe_walk3;

void () axe_walk2 = [ 18, axe_walk3 ]
{
	ai_walk (TRUE);
};
void () axe_walk4;

void () axe_walk3 = [ 19, axe_walk4 ]
{
	ai_walk (TRUE);
};
void () axe_walk5;

void () axe_walk4 = [ 20, axe_walk5 ]
{
	ai_walk (TRUE);
};
void () axe_walk6;

void () axe_walk5 = [ 21, axe_walk6 ]
{
	ai_walk (TRUE);
};
void () axe_walk7;

void () axe_walk6 = [ 22, axe_walk7 ]
{
	ai_walk (TRUE);
};
void () axe_walk8;

void () axe_walk7 = [ 23, axe_walk8 ]
{
	ai_walk (TRUE);
};
void () axe_walk9;

void () axe_walk8 = [ 24, axe_walk9 ]
{
	ai_walk (TRUE);
};
void () axe_walk10;

void () axe_walk9 = [ 25, axe_walk10 ]
{
	ai_walk (TRUE);
};
void () axe_walk11;

void () axe_walk10 = [ 26, axe_walk11 ]
{
	ai_walk (TRUE);
};
void () axe_walk12;

void () axe_walk11 = [ 27, axe_walk12 ]
{
	ai_walk (TRUE);
};

void () axe_walk12 = [ 28, axe_walk1 ]
{
	ai_walk (TRUE);
};
void () axe_run2;

void () axe_run1 = [ 0, axe_run2 ]
{
	if ((random () < 0.2))
	{
		sound (self, FL_SWIM, "knight/idle.wav", TRUE, FL_SWIM);
	}
	ai_run (25);
};
void () axe_run3;

void () axe_run2 = [ 1, axe_run3 ]
{
	ai_run (18);
};
void () axe_run4;

void () axe_run3 = [ 2, axe_run4 ]
{
	ai_run (STAT_TOTALMONSTERS);
};
void () axe_run5;

void () axe_run4 = [ 3, axe_run5 ]
{
	ai_run (25);
};
void () axe_run6;

void () axe_run5 = [ 4, axe_run6 ]
{
	ai_run (18);
};

void () axe_run6 = [ 5, axe_run1 ]
{
	ai_run (STAT_TOTALMONSTERS);
};
void (vector dir) axe_chop =
{
	local vector delta;
	local vector toss;
	local float ldmg;
	if (!self.enemy)
	{
		return;
	}
	ai_charge_side ();
	delta = self.enemy.origin - self.origin;
	if ((vlen (delta) > 60))
	{
		return;
	}
	if (!CanDamage (self.enemy, self))
	{
		return;
	}
	ldmg = ((random () + random ()) + random ()) * FL_SWIM;
	T_Damage (self.enemy, self, self, ldmg);
	toss = ((v_forward * dir_x) + (v_right * dir_y)) + (v_up * dir_z);
	self.enemy.velocity = (self.enemy.velocity + toss);
};
void () axe_runatka1 = [ 119, axe_runatka2 ]
{
	if ((random () > 0.5))
	{
		sound (self, TRUE, "knight/sword2.wav", TRUE, TRUE);
	}
	else
	{
		sound (self, TRUE, "knight/sword1.wav", TRUE, TRUE);
	}
	ai_charge (SVC_INTERMISSION);
};
void () axe_runatka3;

void () axe_runatka2 = [ 120, axe_runatka3 ]
{
	ai_charge (20);
};
void () axe_runatka4;

void () axe_runatka3 = [ 121, axe_runatka4 ]
{
	ai_charge (MOVETYPE_BOUNCE);
	axe_chop (VEC_ORIGIN);
};
void () axe_runatka5;

void () axe_runatka4 = [ 122, axe_runatka5 ]
{
	axe_chop ('50 -20 10');
};
void () axe_runatka6;

void () axe_runatka5 = [ 123, axe_runatka6 ]
{
	axe_chop ('100 -40 10');
};

void () axe_runatka6 = [ 124, axe_run1 ]
{
	ai_charge_side ();
};
void () axe_runatkb2;

void () axe_runatkb1 = [ 125, axe_runatkb2 ]
{
	if ((random () > 0.5))
	{
		sound (self, TRUE, "knight/sword2.wav", TRUE, TRUE);
	}
	else
	{
		sound (self, TRUE, "knight/sword1.wav", TRUE, TRUE);
	}
	ai_charge (SVC_INTERMISSION);
};
void () axe_runatkb3;

void () axe_runatkb2 = [ 126, axe_runatkb3 ]
{
	ai_charge (20);
};
void () axe_runatkb4;

void () axe_runatkb3 = [ 127, axe_runatkb4 ]
{
	ai_charge (MOVETYPE_BOUNCE);
	axe_chop (VEC_ORIGIN);
};
void () axe_runatkb5;

void () axe_runatkb4 = [ 128, axe_runatkb5 ]
{
	axe_chop ('40 75 10');
};
void () axe_runatkb6;

void () axe_runatkb5 = [ 129, axe_runatkb6 ]
{
	axe_chop ('80 150 20');
};

void () axe_runatkb6 = [ 130, axe_run1 ]
{
	ai_charge_side ();
};
void () axe_runatkc2;

void () axe_runatkc1 = [ 131, axe_runatkc2 ]
{
	if ((random () > 0.5))
	{
		sound (self, TRUE, "knight/sword2.wav", TRUE, TRUE);
	}
	else
	{
		sound (self, TRUE, "knight/sword1.wav", TRUE, TRUE);
	}
	ai_charge (SVC_INTERMISSION);
};
void () axe_runatkc3;

void () axe_runatkc2 = [ 132, axe_runatkc3 ]
{
	ai_charge (20);
};
void () axe_runatkc4;

void () axe_runatkc3 = [ 133, axe_runatkc4 ]
{
	ai_charge (MOVETYPE_BOUNCE);
	axe_chop (VEC_ORIGIN);
};
void () axe_runatkc5;

void () axe_runatkc4 = [ 134, axe_runatkc5 ]
{
	axe_chop ('60 0 10');
};
void () axe_runatkc6;

void () axe_runatkc5 = [ 135, axe_runatkc6 ]
{
	axe_chop ('120 0 20');
};

void () axe_runatkc6 = [ 136, axe_run1 ]
{
	ai_charge_side ();
};
void () axe_runatkd2;

void () axe_runatkd1 = [ 137, axe_runatkd2 ]
{
	if ((random () > 0.5))
	{
		sound (self, TRUE, "knight/sword2.wav", TRUE, TRUE);
	}
	else
	{
		sound (self, TRUE, "knight/sword1.wav", TRUE, TRUE);
	}
	ai_charge (SVC_INTERMISSION);
};
void () axe_runatkd3;

void () axe_runatkd2 = [ 138, axe_runatkd3 ]
{
	ai_charge (20);
};
void () axe_runatkd4;

void () axe_runatkd3 = [ 139, axe_runatkd4 ]
{
	ai_charge (MOVETYPE_BOUNCE);
	axe_chop (VEC_ORIGIN);
};
void () axe_runatkd5;

void () axe_runatkd4 = [ 140, axe_runatkd5 ]
{
	axe_chop ('30 -75 100');
};
void () axe_runatkd6;

void () axe_runatkd5 = [ 141, axe_runatkd6 ]
{
	axe_chop ('60 -150 200');
};

void () axe_runatkd6 = [ 142, axe_run1 ]
{
	ai_charge_side ();
};

void (entity attacker, float damage) axe_atk =
{
	local float r;
	if ((self.pain_finished > time))
	{
		return;
	}
	r = random ();
	if ((r < 0.25))
	{
		axe_runatka1 ();
	}
	else
	{
		if ((r < 0.5))
		{
			axe_runatkb1 ();
		}
		else
		{
			if ((r < 0.75))
			{
				axe_runatkc1 ();
			}
			else
			{
				axe_runatkd1 ();
			}
		}
	}
};

void () axe_pain1 = [ 29, axe_pain2 ]
{
	ai_painforward (FALSE);
};
void () axe_pain3;

void () axe_pain2 = [ 30, axe_pain3 ]
{
	ai_painforward (CONTENT_EMPTY);
};
void () axe_pain4;

void () axe_pain3 = [ 31, axe_pain4 ]
{
	ai_painforward (CONTENT_SOLID);
};
void () axe_pain5;

void () axe_pain4 = [ 32, axe_pain5 ]
{
};
void () axe_pain6;

void () axe_pain5 = [ 33, axe_pain6 ]
{
};

void () axe_pain6 = [ 34, axe_run1 ]
{
};

void (entity attacker, float damage) axe_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	sound (self, FL_SWIM, "knight/khurt.wav", TRUE, TRUE);
	axe_pain1 ();
	self.pain_finished = (time + 0.75);
};

void () axe_die1 = [ 41, axe_die2 ]
{
};
void () axe_die3;

void () axe_die2 = [ 42, axe_die3 ]
{
};
void () axe_die4;

void () axe_die3 = [ 43, axe_die4 ]
{
	self.solid = FALSE;
};
void () axe_die5;

void () axe_die4 = [ 44, axe_die5 ]
{
};
void () axe_die6;

void () axe_die5 = [ 45, axe_die6 ]
{
};
void () axe_die7;

void () axe_die6 = [ 46, axe_die7 ]
{
};
void () axe_die8;

void () axe_die7 = [ 47, axe_die8 ]
{
};
void () axe_die9;

void () axe_die8 = [ 48, axe_die9 ]
{
	Become_Corpse ();
};

void () axe_die9 = [ 49, axe_die9 ]
{
	if (!checkclient ())
	{
		remove (self);
	}
};
void () axe_die =
{
	if ((self.health < -30))
	{
		sound (self, FL_SWIM, "player/udeath.wav", TRUE, TRUE);
		ThrowHead ("progs/h_guard.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	sound (self, FL_SWIM, "knight/kdeath.wav", TRUE, TRUE);
	axe_die1 ();
};
void () monster_axegrunt1 =
{
	self.solid = MOVETYPE_WALK;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/axegrunt.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = MTF_Monster_Health(75);
	self.th_stand = axe_stand1;
	self.th_walk = axe_walk1;
	self.th_run = axe_run1;
	self.th_melee = axe_atk;
	self.th_pain = axe_pain;
	self.th_die = axe_die;
	coop_walkmonster_start ();
};
void () monster_axegrunt =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/axegrunt.mdl");
	precache_model ("progs/h_guard.mdl");
	precache_sound ("knight/kdeath.wav");
	precache_sound ("knight/khurt.wav");
	precache_sound ("knight/ksight.wav");
	precache_sound ("knight/sword1.wav");
	precache_sound ("knight/sword2.wav");
	precache_sound ("knight/idle.wav");
	self.netname = "axe grunt";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_axegrunt1;
	COOP_SetLives ();
	monster_axegrunt1 ();
};
//END
