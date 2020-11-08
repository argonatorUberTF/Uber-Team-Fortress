void() wolf_dog_bite =
{
local vector	delta;
	sound (self, CHAN_VOICE, "076.wav", 1, ATTN_NORM);
	if (!self.enemy)
		return;
	if (!CanDamage (self.enemy, self))
		return;
	delta = self.enemy.origin - self.origin;
	if (vlen(delta) > 100)
		return;
	if (random()*256 < 180)
		T_Damage (self.enemy, self, self, random()*16);
};
void() wolf_dog_stand	=[	0,	wolf_dog_stand	] {self.oframe = 0; ai_sprite_orient(); ai_stand();};
//
//void() wolf_dog_walk1	=[	0,	wolf_dog_walk1s	] {ai_sprite_orient(); self.nextthink = time + 0.2857; ai_walk(15);};		// 20 tics
//void() wolf_dog_walk1s	=[	0,	wolf_dog_walk2	] {ai_sprite_orient(); self.nextthink = time + 0.0714; ai_walk(0);};		//  5
//void() wolf_dog_walk2	=[	8,	wolf_dog_walk3	] {ai_sprite_orient(); self.nextthink = time + 0.2143; ai_walk(15);};		// 15
//void() wolf_dog_walk3	=[	16,	wolf_dog_walk3s	] {ai_sprite_orient(); self.nextthink = time + 0.2857; ai_walk(15);};
//void() wolf_dog_walk3s	=[	16,	wolf_dog_walk4	] {ai_sprite_orient(); self.nextthink = time + 0.0714; ai_walk(0);};
//void() wolf_dog_walk4	=[	24,	wolf_dog_walk1	] {ai_sprite_orient(); self.nextthink = time + 0.2143; ai_walk(15);};
//void() wolf_dog_run1	=[	0,	wolf_dog_run1s	] {ai_sprite_orient(); self.nextthink = time + 0.1429; ai_run(30);};	// 10
//void() wolf_dog_run1s	=[	0,	wolf_dog_run2	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(0);};		//  3
//void() wolf_dog_run2	=[	8,	wolf_dog_run3	] {ai_sprite_orient(); self.nextthink = time + 0.1143; ai_run(30);};	//  8
//void() wolf_dog_run3	=[	16,	wolf_dog_run3s	] {ai_sprite_orient(); self.nextthink = time + 0.1429; ai_run(30);};
//void() wolf_dog_run3s	=[	16,	wolf_dog_run4	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(0);};
//void() wolf_dog_run4	=[	24,	wolf_dog_run1	] {ai_sprite_orient(); self.nextthink = time + 0.1143; ai_run(30);};
//
void() wolf_dog_walk1	=[	0,	wolf_dog_walk1b	] {ai_sprite_orient(); ai_walk(7.5);};		// 20 tics
void() wolf_dog_walk1b	=[	0,	wolf_dog_walk1c	] {ai_sprite_orient(); ai_walk(7.5);};		// 20 tics
void() wolf_dog_walk1c	=[	0,	wolf_dog_walk1s	] {ai_sprite_orient(); self.nextthink = time + 0.0857; ai_walk(7.5);};		// 20 tics
void() wolf_dog_walk1s	=[	0,	wolf_dog_walk2	] {ai_sprite_orient(); self.nextthink = time + 0.0714;};		//  5
void() wolf_dog_walk2	=[	8,	wolf_dog_walk2b	] {ai_sprite_orient(); ai_walk(7.5);};		// 15
void() wolf_dog_walk2b	=[	8,	wolf_dog_walk2c	] {ai_sprite_orient(); ai_walk(7.5);};		// 15
void() wolf_dog_walk2c	=[	8,	wolf_dog_walk3	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_walk(7.5);};		// 15
void() wolf_dog_walk3	=[	16,	wolf_dog_walk3b	] {ai_sprite_orient(); ai_walk(7.5);};
void() wolf_dog_walk3b	=[	16,	wolf_dog_walk3c	] {ai_sprite_orient(); ai_walk(7.5);};
void() wolf_dog_walk3c	=[	16,	wolf_dog_walk3s	] {ai_sprite_orient(); self.nextthink = time + 0.0857; ai_walk(7.5);};
void() wolf_dog_walk3s	=[	16,	wolf_dog_walk4	] {ai_sprite_orient(); self.nextthink = time + 0.0714;};
void() wolf_dog_walk4	=[	24,	wolf_dog_walk4b	] {ai_sprite_orient(); ai_walk(7.5);};
void() wolf_dog_walk4b	=[	24,	wolf_dog_walk4c	] {ai_sprite_orient(); ai_walk(7.5);};
void() wolf_dog_walk4c	=[	24,	wolf_dog_walk1	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_walk(7.5);};
void() wolf_dog_run1	=[	0,	wolf_dog_run1b	] {self.oframe = 0; ai_sprite_orient(); ai_run(15);};	// 10
void() wolf_dog_run1b	=[	0,	wolf_dog_run1s	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(15);};	// 10
void() wolf_dog_run1s	=[	0,	wolf_dog_run2	] {ai_sprite_orient(); self.nextthink = time + 0.0429;};		//  3
void() wolf_dog_run2	=[	8,	wolf_dog_run2b	] {self.oframe = 8; ai_sprite_orient(); ai_run(15);};	//  8
void() wolf_dog_run2b	=[	8,	wolf_dog_run3	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_run(15);};	//  8
void() wolf_dog_run3	=[	16,	wolf_dog_run3b	] {self.oframe = 16; ai_sprite_orient(); ai_run(15);};
void() wolf_dog_run3b	=[	16,	wolf_dog_run3s	] {ai_sprite_orient(); self.nextthink = time + 0.0429; ai_run(15);};
void() wolf_dog_run3s	=[	16,	wolf_dog_run4	] {ai_sprite_orient(); self.nextthink = time + 0.0429;};
void() wolf_dog_run4	=[	24,	wolf_dog_run4b	] {self.oframe = 24; ai_sprite_orient(); ai_run(15);};
void() wolf_dog_run4b	=[	24,	wolf_dog_run1	] {ai_sprite_orient(); self.nextthink = time + 0.0143; ai_run(15);};
void() wolf_dog_atta1	=[	36,	wolf_dog_atta2	] {self.oframe = -1; self.nextthink = time + 0.1429; ai_face();};		// 10
void() wolf_dog_atta2	=[	37,	wolf_dog_atta3	] {self.nextthink = time + 0.1429; ai_face();};
void() wolf_dog_atta3	=[	38,	wolf_dog_atta4	]
{
	self.nextthink = time + 0.1429;
	ai_face();
	wolf_dog_bite();
};
void() wolf_dog_atta4	=[	36,	wolf_dog_atta5	] {self.nextthink = time + 0.1429; ai_face();};
void() wolf_dog_atta5	=[	0,	wolf_dog_run1	] {self.nextthink = time + 0.1429; ai_face();};
void() wolf_dog_pain = {};
void() wolf_dog_die1		=[	32,	wolf_dog_die2	]
{
	self.oframe = -1;
	self.solid = SOLID_NOT;
	self.nextthink = time + 0.2143;		// 15
};
void() wolf_dog_die2		=[	33,	wolf_dog_die3	]
{
	sound (self, CHAN_VOICE, "035.wav", 1, ATTN_NORM);
	self.nextthink = time + 0.2143;
};
void() wolf_dog_die3		=[	34,	wolf_dog_dead	] {self.nextthink = time + 0.2143;};
void() wolf_dog_dead		=[	35,	wolf_dog_dead	] {};
void () monster_wolf_dog1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.flags = self.flags | FL_MONSTER;
	setmodel (self, "sprites/monsters/doggeh2.spr");
	setsize (self, '-16 -16 -32', '16 16 24');
	self.health = 1;
	self.yaw_speed = 60;
	self.th_stand = wolf_dog_stand;
	self.th_walk = wolf_dog_walk1;
	self.th_run = wolf_dog_run1;
	self.th_pain = wolf_dog_pain;
	self.th_die = wolf_dog_die1;
	self.th_melee = wolf_dog_atta1;
	self.customizeentityforclient = customize_frame;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void() monster_wolf_dog =
{
	if (deathmatch == 1)
	{
		dremove(self);
		return;
	}
	precache_model ("sprites/monsters/doggeh2.spr");
	precache_sound ("076.wav");		// bite
	precache_sound ("035.wav");		// die
	precache_sound ("002.wav");		// sight
	MTF_Setup_Monster_Presets ( 0, "rottweiler", monster_wolf_dog1 );
};
//END
