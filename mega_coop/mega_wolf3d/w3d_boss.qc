void() wolfboss_stand		=[	0,	wolfboss_stand	] {ai_stand();};
//
//void() wolfboss_walk1		=[	0,	wolfboss_walk1s	] {self.nextthink = time + 0.2857; ai_walk(5.12);};		// 20 tics
//void() wolfboss_walk1s	=[	0,	wolfboss_walk2	] {self.nextthink = time + 0.0714; ai_walk(0);};		//  5
//void() wolfboss_walk2		=[	1,	wolfboss_walk3	] {self.nextthink = time + 0.2143; ai_walk(5.12);};		// 15
//void() wolfboss_walk3		=[	2,	wolfboss_walk3s	] {self.nextthink = time + 0.2857; ai_walk(5.12);};
//void() wolfboss_walk3s	=[	2,	wolfboss_walk4	] {self.nextthink = time + 0.0714; ai_walk(0);};
//void() wolfboss_walk4		=[	3,	wolfboss_walk1	] {self.nextthink = time + 0.2143; ai_walk(5.12);};
//
//void() wolfboss_run1		=[	0,	wolfboss_run1s	] {self.nextthink = time + 0.1429; ai_run(15.36);};		// 10
//void() wolfboss_run1s		=[	0,	wolfboss_run2	] {self.nextthink = time + 0.0429; ai_run(0);};			//  3
//void() wolfboss_run2		=[	1,	wolfboss_run3	] {self.nextthink = time + 0.1143; ai_run(15.36);};		//  8
//void() wolfboss_run3		=[	2,	wolfboss_run3s	] {self.nextthink = time + 0.1429; ai_run(15.36);};
//void() wolfboss_run3s		=[	2,	wolfboss_run4	] {self.nextthink = time + 0.0429; ai_run(0);};
//void() wolfboss_run4		=[	3,	wolfboss_run1	] {self.nextthink = time + 0.1143; ai_run(15.36);};
//
void() wolfboss_walk1		=[	0,	wolfboss_walk1b	] {ai_walk(2.56);};		// 20 tics
void() wolfboss_walk1b	=[	0,	wolfboss_walk1c	] {ai_walk(2.56);};		// 20 tics
void() wolfboss_walk1c	=[	0,	wolfboss_walk1s	] {self.nextthink = time + 0.0857; ai_walk(2.56);};		// 20 tics
void() wolfboss_walk1s	=[	0,	wolfboss_walk2	] {self.nextthink = time + 0.0714;};		//  5
void() wolfboss_walk2		=[	1,	wolfboss_walk2b	] {ai_walk(2.56);};		// 15
void() wolfboss_walk2b	=[	1,	wolfboss_walk2c	] {ai_walk(2.56);};		// 15
void() wolfboss_walk2c	=[	1,	wolfboss_walk3	] {self.nextthink = time + 0.0143; ai_walk(2.56);};		// 15
void() wolfboss_walk3		=[	2,	wolfboss_walk3b	] {ai_walk(2.56);};
void() wolfboss_walk3b	=[	2,	wolfboss_walk3c	] {ai_walk(2.56);};
void() wolfboss_walk3c	=[	2,	wolfboss_walk3s	] {self.nextthink = time + 0.0857; ai_walk(2.56);};
void() wolfboss_walk3s	=[	2,	wolfboss_walk4	] {self.nextthink = time + 0.0714;};
void() wolfboss_walk4		=[	3,	wolfboss_walk4b	] {ai_walk(2.56);};
void() wolfboss_walk4b	=[	3,	wolfboss_walk4c	] {ai_walk(2.56);};
void() wolfboss_walk4c	=[	3,	wolfboss_walk1	] {self.nextthink = time + 0.0143; ai_walk(2.56);};
void() wolfboss_run1		=[	0,	wolfboss_run1b	] {ai_run(7.68);};		// 10
void() wolfboss_run1b		=[	0,	wolfboss_run1s	] {self.nextthink = time + 0.0429; ai_run(7.68);};		// 10
void() wolfboss_run1s		=[	0,	wolfboss_run2	] {self.nextthink = time + 0.0429;};			//  3
void() wolfboss_run2		=[	1,	wolfboss_run2b	] {ai_run(7.68);};		//  8
void() wolfboss_run2b		=[	1,	wolfboss_run3	] {self.nextthink = time + 0.0143; ai_run(7.68);};		//  8
void() wolfboss_run3		=[	2,	wolfboss_run3b	] {ai_run(7.68);};
void() wolfboss_run3b		=[	2,	wolfboss_run3s	] {self.nextthink = time + 0.0429; ai_run(7.68);};
void() wolfboss_run3s		=[	2,	wolfboss_run4	] {self.nextthink = time + 0.0429;};
void() wolfboss_run4		=[	3,	wolfboss_run4b	] {ai_run(7.68);};
void() wolfboss_run4b		=[	3,	wolfboss_run1	] {self.nextthink = time + 0.0143; ai_run(7.68);};
void() wolfboss_atk1		=[	4,	wolfboss_atk2	] {self.nextthink = time + 0.4286; ai_face();};			// 30
void() wolfboss_atk2		=[	5,	wolfboss_atk3	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/wolfboss_m.spr", 0.05, 0);};
void() wolfboss_atk3		=[	6,	wolfboss_atk4	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/wolfboss_m.spr", 0.05, 1);};
void() wolfboss_atk4		=[	5,	wolfboss_atk5	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/wolfboss_m.spr", 0.05, 0);};
void() wolfboss_atk5		=[	6,	wolfboss_atk6	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/wolfboss_m.spr", 0.05, 1);};
void() wolfboss_atk6		=[	5,	wolfboss_atk7	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/wolfboss_m.spr", 0.05, 0);};
void() wolfboss_atk7		=[	6,	wolfboss_atk8	] {self.nextthink = time + 0.1429; ai_face(); ai_monster_fire("sprites/monsters/wolfboss_m.spr", 0.05, 1);};
void() wolfboss_atk8		=[	4,	wolfboss_run1	] {self.nextthink = time + 0.1429; ai_face();};			// 10
void()	wolfboss_die1	=[	8,	wolfboss_die2	]
{
	self.solid = SOLID_NOT;
	DropKey(); 
	self.nextthink = time + 0.2143;		// 15 tics
};
void()	wolfboss_die2	=[	9,	wolfboss_die3	]
{
	sound (self, CHAN_VOICE, "019.wav", 1, ATTN_NORM);
	self.nextthink = time + 0.2143;		// 15
};
void()	wolfboss_die3	=[	10,	wolfboss_dead	] {self.nextthink = time + 0.2143;};	// 15
void()	wolfboss_dead	=[	7,	wolfboss_dead	] {};
void () monster_wolfboss1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.flags = self.flags | FL_MONSTER;
	setmodel (self, "sprites/monsters/!boss.spr");
	setsize (self, '-16 -16 -32', '16 16 24');
	skill = cvar("skill");
	if (skill == -1)
		self.health = 850;
	else if (skill == 0)
		self.health = 950;
	else if (skill == 1)
		self.health = 1050;
	else
		self.health = 1200;
	self.th_stand = wolfboss_stand;
	self.th_walk = wolfboss_walk1;
	self.th_run = wolfboss_run1;
	self.th_missile = wolfboss_atk1;
//	self.th_pain = wolfboss_pain;
	self.th_die = wolfboss_die1;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void() monster_wolfboss =
{	
	if (deathmatch == 1)
	{
		dremove(self);
		return;
	}
	precache_model ("sprites/monsters/!boss.spr");
	precache_model ("sprites/monsters/boss_m.spr");
	precache_model ("sprites/items/!keys.spr");
	precache_sound ("lsfx/012.wav");	// key grab
	precache_sound ("022.wav");	// fire
	precache_sound ("017.wav");	// sight
	precache_sound ("019.wav");	// death
	MTF_Setup_Monster_Presets ( 0, "Otto Von Pwnenshtadt", monster_wolfboss1 );
};
//END