void () army_fire;
void () eg_fire =
{
	if (self.classname == "monster_eliteguard")
		guard_fire_blaster ();
	else
		guard_fire_blaster () ;
};
void () soldier2_stand1 = [ 147, soldier2_stand2 ]
{
	ai_stand ();
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "soldier/idle.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
	}
	ai_stand ();
};
void () soldier2_stand2 = [ 148, soldier2_stand3 ]
{
	ai_stand ();
};
void () soldier2_stand3 = [ 149, soldier2_stand4 ]
{
	ai_stand ();
};
void () soldier2_stand4 = [ 150, soldier2_stand5 ]
{
	ai_stand ();
};
void () soldier2_stand5 = [ 151, soldier2_stand6 ]
{
	ai_stand ();
};
void () soldier2_stand6 = [ 152, soldier2_stand7 ]
{
	ai_stand ();
};
void () soldier2_stand7 = [ 153, soldier2_stand8 ]
{
	ai_stand ();
};
void () soldier2_stand8 = [ 154, soldier2_stand9 ]
{
	ai_stand ();
};
void () soldier2_stand9 = [ 155, soldier2_stand10 ]
{
	ai_stand ();
};
void () soldier2_stand10 = [ 156, soldier2_stand11 ]
{
	ai_stand ();
};
void () soldier2_stand11 = [ 157, soldier2_stand12 ]
{
	ai_stand ();
};
void () soldier2_stand12 = [ 158, soldier2_stand13 ]
{
	ai_stand ();
};
void () soldier2_stand13 = [ 159, soldier2_stand14 ]
{
	ai_stand ();
};
void () soldier2_stand14 = [ 160, soldier2_stand15 ]
{
	ai_stand ();
};
void () soldier2_stand15 = [ 161, soldier2_stand16 ]
{
	ai_stand ();
};
void () soldier2_stand16 = [ 162, soldier2_stand17 ]
{
	ai_stand ();
};
void () soldier2_stand17 = [ 163, soldier2_stand18 ]
{
	ai_stand ();
};
void () soldier2_stand18 = [ 164, soldier2_stand19 ]
{
	ai_stand ();
};
void () soldier2_stand19 = [ 165, soldier2_stand20 ]
{
	ai_stand ();
};
void () soldier2_stand20 = [ 166, soldier2_stand21 ]
{
	ai_stand ();
};
void () soldier2_stand21 = [ 167, soldier2_stand22 ]
{
	ai_stand ();
};
void () soldier2_stand22 = [ 168, soldier2_stand23 ]
{
	ai_stand ();
};
void () soldier2_stand23 = [ 169, soldier2_stand24 ]
{
	ai_stand ();
};
void () soldier2_stand24 = [ 170, soldier2_stand25 ]
{
	ai_stand ();
};
void () soldier2_stand25 = [ 171, soldier2_stand26 ]
{
	ai_stand ();
};
void () soldier2_stand26 = [ 172, soldier2_stand27 ]
{
	ai_stand ();
};
void () soldier2_stand27 = [ 173, soldier2_stand28 ]
{
	ai_stand ();
};
void () soldier2_stand28 = [ 174, soldier2_stand29 ]
{
	ai_stand ();
};
void () soldier2_stand29 = [ 175, soldier2_stand30 ]
{
	ai_stand ();
};
void () soldier2_stand30 = [ 176, soldier2_stand1 ]
{
	ai_stand ();
};
void () soldier2_walk1 = [ 219, soldier2_walk2 ]
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "soldier/idle.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
	}
	ai_walk (7);
};
void () soldier2_walk2 = [ 220, soldier2_walk3 ]
{
	ai_walk (7);
};
void () soldier2_walk3 = [ 221, soldier2_walk4 ]
{
	ai_walk (7);
};
void () soldier2_walk4 = [ 222, soldier2_walk5 ]
{
	ai_walk (7);
};
void () soldier2_walk5 = [ 223, soldier2_walk6 ]
{
	ai_walk (7);
};
void () soldier2_walk6 = [ 224, soldier2_walk7 ]
{
	ai_walk (7);
};
void () soldier2_walk7 = [ 225, soldier2_walk8 ]
{
	ai_walk (7);
};
void () soldier2_walk8 = [ 226, soldier2_walk1 ]	// xav'd
{
	ai_walk (7);
};
void () soldier2_walk9 = [ 227, soldier2_walk10 ]
{
	ai_walk (7);
};
void () soldier2_walk10 = [ 228, soldier2_walk11 ]	//
{
	ai_walk (7);
};
void () soldier2_walk11 = [ 229, soldier2_walk12 ]
{
	ai_walk (13);
};
void () soldier2_walk12 = [ 230, soldier2_walk13 ]
{
	ai_walk (13);
};
void () soldier2_walk13 = [ 231, soldier2_walk14 ]
{
	ai_walk (13);
};
void () soldier2_walk14 = [ 232, soldier2_walk15 ]
{
	ai_walk (13);
};
void () soldier2_walk15 = [ 233, soldier2_walk1 ]
{
	ai_walk (13);
};
void () soldier2_run1 = [ 98, soldier2_run2 ]
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "soldier/idle.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
	}
	ai_run (19);
};
void () soldier2_run2 = [ 99, soldier2_run3 ]
{
	ai_run (19);
};
void () soldier2_run3 = [ 100, soldier2_run4 ]
{
	ai_run (19);
};
void () soldier2_run4 = [ 101, soldier2_run5 ]
{
	ai_run (19);
};
void () soldier2_run5 = [ 102, soldier2_run6 ]
{
	ai_run (19);
};
void () soldier2_run6 = [ 103, soldier2_run7 ]
{
	ai_run (19);
};
void () soldier2_run7 = [ 104, soldier2_run8 ]
{
	ai_run (19);
};
void () soldier2_run8 = [ 105, soldier2_run1 ]
{
	ai_run (19);
};
void () soldier2_atk1 = [ 1, soldier2_atk2 ]
{
	ai_face ();
	eg_fire ();
};
void () soldier2_atk2 = [ 2, soldier2_atk3 ]
{
	ai_face ();
};
void () soldier2_atk3 = [ 3, soldier2_atk4 ]
{
	ai_face ();
};
void () soldier2_atk4 = [ 4, soldier2_atk5 ]
{
	ai_face ();
	eg_fire();
};
void () soldier2_atk5 = [ 5, soldier2_atk6 ]
{
	ai_face ();
};
void () soldier2_atk6 = [ 6, soldier2_atk7 ]
{
	ai_face ();
};
void () soldier2_atk7 = [ 7, soldier2_atk8 ]
{
	ai_face ();
};
void () soldier2_atk8 = [ 8, soldier2_atk9 ]
{
	ai_face ();
};
void () soldier2_atk9 = [ 9, soldier2_atk10 ]
{
	ai_face ();
};
void () soldier2_atk10 = [ 10, soldier2_atk11 ]
{
	ai_face ();
};
void () soldier2_atk11 = [ 11, soldier2_atk12 ]
{
	ai_face ();
};
void () soldier2_atk12 = [ 12, soldier2_run1 ]
{
	ai_face ();
};
void () soldier2_atkb1 = [ 13, soldier2_atkb2 ]
{
	ai_face ();
};
void () soldier2_atkb2 = [ 14, soldier2_atkb3 ]
{
	ai_face ();
};
void () soldier2_atkb3 = [ 15, soldier2_atkb4 ]
{
	ai_face ();
};
void () soldier2_atkb4 = [ 16, soldier2_atkb5 ]
{
	ai_face ();
};
void () soldier2_atkb5 = [ 17, soldier2_atkb6 ]
{
	ai_face ();
	eg_fire ();
};
void () soldier2_atkb6 = [ 18, soldier2_atkb7 ]
{
	ai_face ();
};
void () soldier2_atkb7 = [ 19, soldier2_atkb8 ]
{
	ai_face ();
};
void () soldier2_atkb8 = [ 20, soldier2_atkb9 ]
{
	ai_face ();
};
void () soldier2_atkb9 = [ 21, soldier2_atkb10 ]
{
	ai_face ();
};
void () soldier2_atkb10 = [ 22, soldier2_atkb11 ]
{
	ai_face ();
};
void () soldier2_atkb11 = [ 23, soldier2_atkb12 ]
{
	ai_face ();
};
void () soldier2_atkb12 = [ 24, soldier2_atkb13 ]
{
	ai_face ();
};
void () soldier2_atkb13 = [ 25, soldier2_atkb14 ]
{
	ai_face ();
};
void () soldier2_atkb14 = [ 26, soldier2_atkb15 ]
{
	ai_face ();
};
void () soldier2_atkb15 = [ 27, soldier2_atkb16 ]
{
	ai_face ();
};
void () soldier2_atkb16 = [ 28, soldier2_atkb17 ]
{
	ai_face ();
};
void () soldier2_atkb17 = [ 29, soldier2_atkb18 ]
{
	ai_face ();
};
void () soldier2_atkb18 = [ 30, soldier2_run1 ]
{
	ai_face ();
};
void () soldier2_atkc1 = [ 31, soldier2_atkc2 ]
{
	ai_face ();
};
void () soldier2_atkc2 = [ 32, soldier2_atkc3 ]
{
	ai_face ();
};
void () soldier2_atkc3 = [ 33, soldier2_atkc4 ]
{
	ai_face ();
	eg_fire ();
};
void () soldier2_atkc4 = [ 34, soldier2_atkc5 ]
{
	ai_face ();
};
void () soldier2_atkc5 = [ 35, soldier2_atkc6 ]
{
	ai_face ();
};
void () soldier2_atkc6 = [ 36, soldier2_atkc7 ]
{
	ai_face ();
};
void () soldier2_atkc7 = [ 37, soldier2_atkc8 ]
{
	ai_face ();
};
void () soldier2_atkc8 = [ 38, soldier2_atkc9 ]
{
	ai_face ();
};
void () soldier2_atkc9 = [ 39, soldier2_run1 ]
{
	ai_face ();
};
void () soldier2_atkd1 = [ 40, soldier2_atkd2 ]
{
	ai_face ();
};
void () soldier2_atkd2 = [ 41, soldier2_atkd3 ]
{
	ai_face ();
};
void () soldier2_atkd3 = [ 42, soldier2_atkd4 ]
{
	ai_face ();
	eg_fire ();
};
void () soldier2_atkd4 = [ 43, soldier2_atkd5 ]
{
	ai_face ();
};
void () soldier2_atkd5 = [ 44, soldier2_atkd6 ]
{
	ai_face ();
};
void () soldier2_atkd6 = [ 45, soldier2_run1 ]
{
	ai_face ();
};
void () soldier2_atke1 = [ 110, soldier2_atke2 ]
{
	ai_face ();
	charge ();
};
void () soldier2_atke2 = [ 111, soldier2_atke3 ]
{
	ai_face ();
	charge ();
};
void () soldier2_atke3 = [ 112, soldier2_atke4 ]
{
	ai_face ();
	charge ();
};
void () soldier2_atke4 = [ 113, soldier2_atke5 ]
{
	ai_face ();
	charge ();
	army_fire ();
};
void () soldier2_atke5 = [ 114, soldier2_atke6 ]
{
	ai_face ();
	charge ();
};
void () soldier2_atke6 = [ 115, soldier2_atke7 ]
{
	ai_face ();
	charge ();
};
void () soldier2_atke7 = [ 116, soldier2_atke8 ]
{
	ai_face ();
	charge ();
};
void () soldier2_atke8 = [ 117, soldier2_atke9 ]
{
	ai_face ();
};
void () soldier2_atke9 = [ 118, soldier2_atke10 ]
{
	ai_face ();
};
void () soldier2_atke10 = [ 119, soldier2_atke11 ]
{
	ai_face ();
};
void () soldier2_atke11 = [ 120, soldier2_atke12 ]
{
	ai_face ();
};
void () soldier2_atke12 = [ 121, soldier2_atke13 ]
{
	ai_face ();
};
void () soldier2_atke13 = [ 122, soldier2_atke14 ]
{
	ai_face ();
};
void () soldier2_atke14 = [ 123, soldier2_atke15 ]
{
	ai_face ();
};
void () soldier2_atke15 = [ 124, soldier2_atke16 ]
{
	ai_face ();
};
void () soldier2_atke16 = [ 125, soldier2_atke17 ]
{
	ai_face ();
};
void () soldier2_atke17 = [ 126, soldier2_atke18 ]
{
	ai_face ();
};
void () soldier2_atke18 = [ 127, soldier2_run1 ]
{
	ai_face ();
};
void () soldier2_pain1 = [ 51, soldier2_pain2 ]
{};
void () soldier2_pain2 = [ 52, soldier2_pain3 ]
{};
void () soldier2_pain3 = [ 53, soldier2_pain4 ]
{};
void () soldier2_pain4 = [ 54, soldier2_pain5 ]
{};
void () soldier2_pain5 = [ 55, soldier2_run1 ]
{};
void (entity attacker, float damage) soldier2_pain =
{
	local float r;
	if ((self.pain_finished > time))
	{
		return;
	}
	r = random ();
	self.pain_finished = (time + TE_LIGHTNING2);
	soldier2_pain1 ();
	sound (self, CHAN_VOICE, "soldier/pain1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
};
void () soldier2_die1 = [ 233, soldier2_die2 ]
{
	self.solid = SOLID_NOT;
	self.ammo_shells = 10;
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	self.ammo_nails = 20;
	DropBackpack ();
};
void () soldier2_die2 = [ 234, soldier2_die3 ]
{};
void () soldier2_die3 = [ 235, soldier2_die4 ]
{};
void () soldier2_die4 = [ 236, soldier2_die5 ]
{};
void () soldier2_die5 = [ 237, soldier2_die6 ]
{};
void () soldier2_die6 = [ 238, soldier2_die7 ]
{};
void () soldier2_die7 = [ 239, soldier2_die7 ]
{};
void () soldier2_attack =
{
	local float attdecide;
	attdecide = floor ((random () * TE_LIGHTNING1));
	if ((attdecide == MSG_BROADCAST))
	{
		soldier2_atk1 ();
	}
	if ((attdecide == SPAWNFLAG_SUPERSPIKE))
	{
		soldier2_atkb1 ();
	}
	if ((attdecide == SPAWNFLAG_LASER))
	{
		soldier2_atkc1 ();
	}
	if ((attdecide == AS_MELEE))
	{
		soldier2_atkd1 ();
	}
	if ((attdecide == SECRET_1ST_DOWN))
	{
		soldier2_atke1 ();
	}
	if ((attdecide == TE_LIGHTNING1))
	{
		soldier2_atk1 ();
	}
};
void () soldier2_die =
{
	if ((!deathmatch && (self.health < -35)))
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		ThrowHead ("progs/h_player.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	sound (self, CHAN_VOICE, "soldier/death1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	soldier2_die1 ();
};
//END
