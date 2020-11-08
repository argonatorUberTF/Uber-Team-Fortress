void() guard_stand	=[	0,	guard_stand		] {self.oframe = 0; ai_sprite_orient(); ai_stand();};
//
//void() guard_walk1	=[	8,	guard_walk1s	] {ai_sprite_orient(); self.nextthink = time + 0.2857; ai_walk(7.3143);};	// 20
//void() guard_walk1s	=[	8,	guard_walk2		] {ai_sprite_orient(); self.nextthink = time + 0.0714; ai_walk(0.0001);};	//  5
//void() guard_walk2	=[	16,	guard_walk3		] {ai_sprite_orient(); self.nextthink = time + 0.2143; ai_walk(7.3143);};	// 15
//void() guard_walk3	=[	24,	guard_walk3s	] {ai_sprite_orient(); self.nextthink = time + 0.2857; ai_walk(7.3143);};
//void() guard_walk3s	=[	24,	guard_walk4		] {ai_sprite_orient(); self.nextthink = time + 0.0714; ai_walk(0.0001);};
//void() guard_walk4	=[	32,	guard_walk1		] {ai_sprite_orient(); self.nextthink = time + 0.2143; ai_walk(7.3143);};/
//
//void() guard_run1		=[	8,	guard_run1s		] {ai_sprite_orient(); self.nextthink = time + 0.1429; ai_run(21.9429);};	// 10
//void() guard_run1s	=[	8,	guard_run2		] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(0);};		//  3
//void() guard_run2		=[	16,	guard_run3		] {ai_sprite_orient(); self.nextthink = time + 0.1143; ai_run(21.9429);};	//  8
//void() guard_run3		=[	24,	guard_run3s		] {ai_sprite_orient(); self.nextthink = time + 0.1429; ai_run(21.9429);};
//void() guard_run3s	=[	24,	guard_run4		] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(0);};
//void() guard_run4		=[	32,	guard_run1		] {ai_sprite_orient(); self.nextthink = time + 0.1143; ai_run(21.9429);};
//
void() guard_walk1	=[	8,	guard_walk1b	] {self.oframe = 8; ai_sprite_orient(); ai_walk(2.56);};	// 20
void() guard_walk1b	=[	8,	guard_walk1c	] {ai_sprite_orient(); ai_walk(2.56);};	// 20
void() guard_walk1c	=[	8,	guard_walk1s	] {ai_sprite_orient(); self.nextthink = time + 0.0857; ai_walk(2.56);};	// 20
void() guard_walk1s	=[	8,	guard_walk2		] {ai_sprite_orient(); self.nextthink = time + 0.0714;};	//  5
void() guard_walk2	=[	16,	guard_walk2b	] {self.oframe = 16; ai_sprite_orient(); ai_walk(2.56);};	// 15
void() guard_walk2b	=[	16,	guard_walk2c	] {ai_sprite_orient(); ai_walk(2.56);};	// 15
void() guard_walk2c	=[	16,	guard_walk3		] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_walk(2.56);};	// 15
void() guard_walk3	=[	24,	guard_walk3b	] {self.oframe = 24; ai_sprite_orient(); ai_walk(2.56);};
void() guard_walk3b	=[	24,	guard_walk3c	] {ai_sprite_orient(); ai_walk(2.56);};
void() guard_walk3c	=[	24,	guard_walk3s	] {ai_sprite_orient(); self.nextthink = time + 0.0857; ai_walk(2.56);};
void() guard_walk3s	=[	24,	guard_walk4		] {ai_sprite_orient(); self.nextthink = time + 0.0714;};
void() guard_walk4	=[	32,	guard_walk4b	] {self.oframe = 32; ai_sprite_orient(); ai_walk(2.56);};
void() guard_walk4b	=[	32,	guard_walk4c	] {ai_sprite_orient(); ai_walk(2.56);};
void() guard_walk4c	=[	32,	guard_walk1		] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_walk(2.56);};
void() guard_run1		=[	8,	guard_run1b		] {self.oframe = 8; ai_sprite_orient(); ai_run(7.68);};	// 10
void() guard_run1b	=[	8,	guard_run1s		] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(7.68);};	// 10
void() guard_run1s	=[	8,	guard_run2		] {ai_sprite_orient(); self.nextthink = time + 0.0429;};		//  3
void() guard_run2		=[	16,	guard_run2b		] {self.oframe = 16; ai_sprite_orient(); ai_run(7.68);};	//  8
void() guard_run2b	=[	16,	guard_run3		] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_run(7.68);};	//  8
void() guard_run3		=[	24,	guard_run3b		] {self.oframe = 24; ai_sprite_orient(); ai_run(7.68);};
void() guard_run3b	=[	24,	guard_run3s		] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(7.68);};
void() guard_run3s	=[	24,	guard_run4		] {ai_sprite_orient(); self.nextthink = time + 0.0429;};
void() guard_run4		=[	32,	guard_run4b		] {self.oframe = 32; ai_sprite_orient(); ai_run(7.68);};
void() guard_run4b	=[	32,	guard_run1		] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_run(7.68);};
void() guard_atk1		=[	46,	guard_atk2		] {self.oframe = -1; self.nextthink = time + 0.2857; ai_face();};		// 20
void() guard_atk2		=[	47,	guard_atk3		] {self.nextthink = time + 0.2857; ai_face();};
void() guard_atk3		=[	48,	guard_run1		] {self.nextthink = time + 0.2857; ai_face(); ai_monster_fire("sprites/monsters/guard_m.spr", 0.10, 0);};
void() guard_pain1	=[	40,	guard_run1		] {self.nextthink = time + 0.1429;};		// 10
void() guard_pain2	=[	44,	guard_run1		] {self.nextthink = time + 0.1429;};
void(entity attacker, float damage)	guard_pain =
{
	local float r;
//	if (self.pain_finished > time)
//		return;
	self.oframe = -1;
	r = random();
//	self.pain_finished = time + 0.5;
	if (r < 0.5)
		guard_pain1 ();
	else
		guard_pain2 ();
};
//void() guard_fire =
//{
//	local	vector	dir;
//	self.effects = self.effects | EF_MUZZLEFLASH;
//	newmis = spawn ();
//	newmis.owner = self;
//	newmis.movetype = MOVETYPE_NONE;
//	newmis.solid = SOLID_NOT;
//	newmis.classname = "muzzle flash";
//	newmis.origin = self.origin;
//	setmodel (newmis, "sprites/monsters/guard_m.spr");
//	newmis.nextthink = time + 0.10;
//	newmis.think = SUB_Remove;
//	ai_face();
//	sound (self, CHAN_WEAPON, "049.wav", 1, ATTN_NORM);	
//	dir = normalize (self.enemy.origin - self.origin);
//	FireMonsterBullets (dir);
//};
void()	guard_die1	=[	41,	guard_die2	]
{
	self.oframe = -1;
	self.solid = SOLID_NOT;
	self.ammo_shells = 4;
	DropAmmo();
	self.nextthink = time + 0.2143;		// 15
};
void()	guard_die2	=[	42,	guard_die3	]
{
local float	rsnd;
	rsnd = rint(random() * 6);
	if (rsnd == 0)
		sound (self, CHAN_VOICE, "025.wav", 1, ATTN_NORM);
	else if (rsnd == 1)
		sound (self, CHAN_VOICE, "026.wav", 1, ATTN_NORM);
	else if (rsnd == 2)
		sound (self, CHAN_VOICE, "086.wav", 1, ATTN_NORM);
	else if (rsnd == 3)
		sound (self, CHAN_VOICE, "088.wav", 1, ATTN_NORM);
	else if (rsnd == 4)
		sound (self, CHAN_VOICE, "105.wav", 1, ATTN_NORM);
	else if (rsnd == 5)
		sound (self, CHAN_VOICE, "107.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_VOICE, "109.wav", 1, ATTN_NORM);
	self.nextthink = time + 0.2143;
};
void()	guard_die3	=[	43,	guard_dead	] {self.nextthink = time + 0.2143;};
void()	guard_dead	=[	45,	guard_dead	] {};
void () monster_guard1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.flags = self.flags | FL_MONSTER;
	setmodel (self, "sprites/monsters/!guard.spr");
	setsize (self, '-16 -16 -32', '16 16 24');
	self.health = 50;
	self.th_stand = guard_stand;
	self.th_walk = guard_walk1;
	self.th_run = guard_run1;
	self.th_missile = guard_atk1;
	self.th_pain = guard_pain;
	self.th_die = guard_die1;
	self.customizeentityforclient = customize_frame;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void() monster_guard =
{	
	if (deathmatch == 1)
	{
		dremove(self);
		return;
	}
	precache_model ("sprites/monsters/!guard.spr");
	precache_model ("sprites/monsters/guard_m.spr");
	precache_sound ("049.wav");	// fire
	precache_sound ("001.wav");	// Achtung!
	precache_sound ("025.wav");	// death
	precache_sound ("026.wav");
	precache_sound ("086.wav");
	precache_sound ("088.wav");
	precache_sound ("105.wav");
	precache_sound ("107.wav");
	precache_sound ("109.wav");
	MTF_Setup_Monster_Presets ( 0, "SS Guard", monster_guard1 );
};
//END
