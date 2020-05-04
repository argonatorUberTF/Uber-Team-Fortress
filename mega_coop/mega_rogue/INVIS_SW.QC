$cd /qwork/xpack/models/sword
$origin 0 0 24
$base base
$skin badass3
$frame stand1
$frame runb1 runb2 runb3 runb4 runb5 runb6 runb7 runb8
$frame attackb1 attackb2 attackb3 attackb4 attackb5
$frame attackb6 attackb7 attackb8 attackb9 attackb10
$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10
$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9 deathb10 deathb11
void()	sword_stand1	=[	$stand1,	sword_stand1	] {ai_stand();};
void()	sword_run1	=[	$runb1,		sword_run2	] 
	{self.effects = EF_DIMLIGHT; ai_run(14);};
void()  sword_run2  =[  $runb2,     sword_run3  ] {ai_run(14);};
void()  sword_run3  =[  $runb3,     sword_run4  ] {ai_run(14);};
void()  sword_run4  =[  $runb4,     sword_run5  ] {ai_run(14);};
void()  sword_run5  =[  $runb5,     sword_run6  ] {ai_run(14);};
void()  sword_run6  =[  $runb6,     sword_run7  ] {ai_run(14);};
void()  sword_run7  =[  $runb7,     sword_run8  ] {ai_run(14);};
void()  sword_run8  =[  $runb8,     sword_run1  ] {ai_run(14);};
void()	sword_atk1	=[	$attackb1,		sword_atk2	]
	{sound (self,0,"knight/sword1.wav", 1, 1);ai_charge(14);};
void()  sword_atk2  =[  $attackb2,      sword_atk3  ] {ai_charge(14);};
void()  sword_atk3  =[  $attackb3,      sword_atk4  ] {ai_charge(14);};
void()  sword_atk4  =[  $attackb4,      sword_atk5  ] {ai_charge(14);};
void()	sword_atk5	=[	$attackb5,		sword_atk6	] {ai_melee();};
void()	sword_atk6	=[	$attackb6,		sword_atk7	] {ai_melee();};
void()	sword_atk7	=[	$attackb7,		sword_atk8	] {ai_melee();};
void()  sword_atk8  =[  $attackb8,      sword_atk9  ] {ai_charge(14);};
void()  sword_atk9  =[  $attackb9,      sword_atk10] {ai_charge(14);};
void()  sword_atk10=[   $attackb10,     sword_run1  ] {ai_charge(14);};
void()	sword_die1	=[	$death1,	sword_die2	] {};
void()	sword_die2	=[	$death2,	sword_die3	] {};
void()  sword_die3  =[  $death3,    sword_die4  ]
	{self.solid = SOLID_NOT;};
void()	sword_die4	=[	$death4,	sword_die5	] {};
void()	sword_die5	=[	$death5,	sword_die6	] {};
void()	sword_die6	=[	$death6,	sword_die7	] {};
void()	sword_die7	=[	$death7,	sword_die8	] 
	{ sound (self, 1, "player/axhit2.wav", 0.5, ATTN_NORM);};
void()	sword_die8	=[	$death8,	sword_die9	] {};
void()	sword_die9	=[	$death9,	sword_die10] {};
void()  sword_die10=[   $death10,   sword_die10] {};
void()	sword_dieb1	=[	$deathb1,	sword_dieb2	] {};
void()	sword_dieb2	=[	$deathb2,	sword_dieb3	] {};
void()  sword_dieb3 =[  $deathb3,   sword_dieb4 ]
	{self.solid = SOLID_NOT;};
void()	sword_dieb4	=[	$deathb4,	sword_dieb5	] {};
void()	sword_dieb5	=[	$deathb5,	sword_dieb6	] {};
void()	sword_dieb6	=[	$deathb6,	sword_dieb7	] {};
void()	sword_dieb7	=[	$deathb7,	sword_dieb8	] 
	{ sound (self, 1, "player/axhit2.wav", 0.5, ATTN_NORM); };
void()	sword_dieb8	=[	$deathb8,	sword_dieb9	] {};
void()	sword_dieb9	=[	$deathb9,	sword_dieb10] {};
void()	sword_dieb10 = [ $deathb10,	sword_dieb11] {};
void()	sword_dieb11 = [ $deathb11,	sword_dieb11] {};
void() sword_die =
{
	self.effects=0;
	if (random() < 0.5)
		sword_die1 ();
	else
		sword_dieb1 ();
};
void() sword_pause = 
{
	self.th_run = sword_run1; 
	self.think = sword_run1;
	self.nextthink = time + self.delay;
	self.delay = 0;
};
void() sword_pain = 
{
	self.th_run = sword_run1; 
	self.think = sword_run1;
	self.nextthink = time + 0.1;
	self.delay = 0;
	self.th_pain = SUB_Null;
};
void() monster_sword1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/sword.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
    self.health = MTF_Monster_Health(150);  // 75;
	if ( !self.delay)
		self.delay = 10;
	self.th_stand = sword_stand1;
	self.th_walk = sword_stand1;
	self.th_run = sword_pause;
	self.th_melee = sword_atk1;
	self.th_die = sword_die;
	self.th_pain = sword_pain;
	coop_walkmonster_start ();
};
void() monster_sword =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/sword.mdl");
	precache_sound ("knight/sword1.wav");
	precache_sound ("knight/ksight.wav");
	precache_sound ("player/axhit2.wav");
	self.netname = "invisible swordsman";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_sword1;
	COOP_SetLives ();
	monster_sword1 ();
};
//END
