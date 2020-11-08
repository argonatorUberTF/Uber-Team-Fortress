void() ss_stand	=[	0,	ss_stand	] {self.oframe = 0; ai_sprite_orient(); ai_stand();};
//
//void() ss_walk1	=[	8,	ss_walk1s	] {ai_sprite_orient(); self.nextthink = time + 0.2857; ai_walk(5.12);};	// 20
//void() ss_walk1s	=[	8,	ss_walk2	] {ai_sprite_orient(); self.nextthink = time + 0.0714; ai_walk(0);};		//  5
//void() ss_walk2	=[	16,	ss_walk3	] {ai_sprite_orient(); self.nextthink = time + 0.2143; ai_walk(5.12);};	// 15
//void() ss_walk3	=[	24,	ss_walk3s	] {ai_sprite_orient(); self.nextthink = time + 0.2857; ai_walk(5.12);};
//void() ss_walk3s	=[	24,	ss_walk4	] {ai_sprite_orient(); self.nextthink = time + 0.0714; ai_walk(0);};
//void() ss_walk4	=[	32,	ss_walk1	] {ai_sprite_orient(); self.nextthink = time + 0.2143; ai_walk(5.12);};
//
//void() ss_run1	=[	8,	ss_run1s	] {ai_sprite_orient(); self.nextthink = time + 0.1429; ai_run(20.48);};	// 10
//void() ss_run1s	=[	8,	ss_run2	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(0);};		//  3
//void() ss_run2	=[	16,	ss_run3	] {ai_sprite_orient(); self.nextthink = time + 0.1143; ai_run(20.48);};	//  8
//void() ss_run3	=[	24,	ss_run3s	] {ai_sprite_orient(); self.nextthink = time + 0.1429; ai_run(20.48);};
//void() ss_run3s	=[	24,	ss_run4	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(0);};
//void() ss_run4	=[	32,	ss_run1	] {ai_sprite_orient(); self.nextthink = time + 0.1143; ai_run(20.48);};
//
void() ss_walk1	=[	8,	ss_walk1b	] {self.oframe = 8; ai_sprite_orient(); ai_walk(2.56);};	// 20
void() ss_walk1b	=[	8,	ss_walk1c	] {ai_sprite_orient(); ai_walk(2.56);};	// 20
void() ss_walk1c	=[	8,	ss_walk1s	] {ai_sprite_orient(); self.nextthink = time + 0.0857; ai_walk(2.56);};	// 20
void() ss_walk1s	=[	8,	ss_walk2	] {ai_sprite_orient(); self.nextthink = time + 0.0714;};	//  5
void() ss_walk2	=[	16,	ss_walk2b	] {self.oframe = 16; ai_sprite_orient(); ai_walk(2.56);};	// 15
void() ss_walk2b	=[	16,	ss_walk2c	] {ai_sprite_orient(); ai_walk(2.56);};	// 15
void() ss_walk2c	=[	16,	ss_walk3	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_walk(2.56);};	// 15
void() ss_walk3	=[	24,	ss_walk3b	] {self.oframe = 24; ai_sprite_orient(); ai_walk(2.56);};
void() ss_walk3b	=[	24,	ss_walk3c	] {ai_sprite_orient(); ai_walk(2.56);};
void() ss_walk3c	=[	24,	ss_walk3s	] {ai_sprite_orient(); self.nextthink = time + 0.0857; ai_walk(2.56);};
void() ss_walk3s	=[	24,	ss_walk4	] {ai_sprite_orient(); self.nextthink = time + 0.0714;};
void() ss_walk4	=[	32,	ss_walk4b	] {self.oframe = 32; ai_sprite_orient(); ai_walk(2.56);};
void() ss_walk4b	=[	32,	ss_walk4c	] {ai_sprite_orient(); ai_walk(2.56);};
void() ss_walk4c	=[	32,	ss_walk1	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_walk(2.56);};
void() ss_run1	=[	8,	ss_run1b	] {self.oframe = 8; ai_sprite_orient(); ai_run(10.24);};	// 10
void() ss_run1b	=[	8,	ss_run1s	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(10.24);};	// 10
void() ss_run1s	=[	8,	ss_run2	] {ai_sprite_orient(); self.nextthink = time + 0.0429;};		//  3
void() ss_run2	=[	16,	ss_run2b	] {self.oframe = 16; ai_sprite_orient(); ai_run(10.24);};	//  8
void() ss_run2b	=[	16,	ss_run3	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_run(10.24);};	//  8
void() ss_run3	=[	24,	ss_run3b	] {self.oframe = 24; ai_sprite_orient(); ai_run(10.24);};
void() ss_run3b	=[	24,	ss_run3s	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(10.24);};
void() ss_run3s	=[	24,	ss_run4	] {ai_sprite_orient(); self.nextthink = time + 0.0429;};
void() ss_run4	=[	32,	ss_run4b	] {self.oframe = 32; ai_sprite_orient(); ai_run(10.24);};
void() ss_run4b	=[	32,	ss_run1	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_run(10.24);};
void() ss_atk1	=[	46,	ss_atk2	] {self.oframe = -1; self.nextthink = time + 0.2857; ai_face();};	// 20
void() ss_atk2	=[	47,	ss_atk3	] {self.nextthink = time + 0.2857; ai_face();};
void() ss_atk3	=[	48,	ss_atk4	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/ss_m.spr", 0.05, 0);};
void() ss_atk4	=[	47,	ss_atk5	] {self.nextthink = time + 0.1429; ai_face();};	// 10
void() ss_atk5	=[	48,	ss_atk6	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/ss_m.spr", 0.05, 0);};
void() ss_atk6	=[	47,	ss_atk7	] {self.nextthink = time + 0.1429; ai_face();};
void() ss_atk7	=[	48,	ss_atk8	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/ss_m.spr", 0.05, 0);};
void() ss_atk8	=[	47,	ss_atk9	] {self.nextthink = time + 0.1429; ai_face();};
void() ss_atk9	=[	48,	ss_run1	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/ss_m.spr", 0.05, 0);};
void() ss_pain1	=[	40,	ss_run1	] {self.nextthink = time + 0.1429; };
void() ss_pain2	=[	44,	ss_run1	] {self.nextthink = time + 0.1429; };
void(entity attacker, float damage)	ss_pain =
{
	local float r;
//	if (self.pain_finished > time)
//		return;
	self.oframe = -1;
	r = random();
//	self.pain_finished = time + 0.5;
	if (r < 0.5)
		ss_pain1 ();
	else
		ss_pain2 ();
};
void() ss_die1	=[	41,	ss_die2	]
{
	self.oframe = -1;
	self.solid = SOLID_NOT;
	sound (self, CHAN_VOICE, "046.wav", 1, ATTN_NORM);
	if(self.enemy.items & IT_MACHINEGUN)
	{
		self.ammo_shells = 4;
		DropAmmo();
	}
	else
		DropGun();
	self.nextthink = time + 0.2143;		// 15
};
void() ss_die2	=[	42,	ss_die3	] {self.nextthink = time + 0.2143;};		// 15
void() ss_die3	=[	43,	ss_dead	] {self.nextthink = time + 0.2143;};		// 15
void() ss_dead	=[	45,	ss_dead	] {};
void () monster_ss1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.flags = self.flags | FL_MONSTER;
	setmodel (self, "sprites/monsters/!ss.spr");
	setsize (self, '-16 -16 -32', '16 16 24');
	self.health = 100;
	self.th_stand = ss_stand;
	self.th_walk = ss_walk1;
	self.th_run = ss_run1;
	self.th_missile = ss_atk1;
	self.th_pain = ss_pain;
	self.th_die = ss_die1;
	self.customizeentityforclient = customize_frame;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};

void() monster_ss =
{	
	if (deathmatch == 1)
	{
		dremove(self);
		return;
	}
	precache_model ("sprites/monsters/!ss.spr");
	precache_model ("sprites/monsters/ss_m.spr");
	precache_sound ("024.wav");	// fire
	precache_sound ("015.wav");	// sight
	precache_sound ("046.wav");	// death

	MTF_Setup_Monster_Presets ( 0, "SS Officer", monster_ss1 );
};
//END
