#define GIB1_KGS	0
#define GIB2_KGS	0
#define GIB3_KGS	0
void (float blah) DropPowerBackPack =
{
};

void () COOP_Idle =
{
	ai_stand ();
};

void (float noo) COOP_Walk =
{
	ai_walk(noo);
};

void (float naa) COOP_Run =
{
	ai_run(naa);
};

void () COOP_Turn =
{
	ai_face ();
};

void  (string gname, float dmga, float blah, float oblah, float oblaha, float oblahhh) ThrowGibC =
{
	ThrowGib( gname, dmga );
};

void  (string gname, float dmga, float blah, float oblah, float oblaha, float oblahhh) throwgibc =
{
	ThrowGib( gname, dmga );
};

void () Idle =
{
	ai_stand ();
};

void () MonsterCorpse =
{};

void() berserk_fidget;
void() berserk_stand = [0, berserk_stand]
{
	if (self.walkframe >= 5)
		self.walkframe = 0;
	self.frame = self.frame + self.walkframe;
	
	self.walkframe = self.walkframe + 1;
	if (self.frame == 0)
		berserk_fidget ();
};

void() berserk_stand_fidget = [5, berserk_stand_fidget]
{
	if (self.frame >= 24)
	{
		berserk_stand ();
		return;
	}
	
	if (self.walkframe >= 19)
		self.walkframe = 0;
	self.frame = self.frame + self.walkframe;
	
	self.walkframe = self.walkframe + 1;
};

void() berserk_fidget =
{
	if (random() > 0.15)
		return;
	
	berserk_stand_fidget ();
	sound (self, CHAN_WEAPON, "berserk/beridle1.wav", 1, ATTN_IDLE);
};

void() berserk_walk1  = [25, berserk_walk2 ] {ai_walk(9.1);};
void() berserk_walk2  = [26, berserk_walk3 ] {ai_walk(6.3);};
void() berserk_walk3  = [27, berserk_walk4 ] {ai_walk(4.9);};
void() berserk_walk4  = [28, berserk_walk5 ] {ai_walk(6.7);};
void() berserk_walk5  = [29, berserk_walk6 ] {ai_walk(6);};
void() berserk_walk6  = [30, berserk_walk7 ] {ai_walk(8.2);};
void() berserk_walk7  = [31, berserk_walk8 ] {ai_walk(7.2);};
void() berserk_walk8  = [32, berserk_walk9 ] {ai_walk(6.1);};
void() berserk_walk9  = [33, berserk_walk10] {ai_walk(4.9);};
void() berserk_walk10 = [34, berserk_walk11] {ai_walk(4.7);};
void() berserk_walk11 = [35, berserk_walk1 ] {ai_walk(4.7);};

void() berserk_run1 = [36, berserk_run2] {ai_run(21);};
void() berserk_run2 = [37, berserk_run3] {ai_run(11);};
void() berserk_run3 = [38, berserk_run4] {ai_run(21);};
void() berserk_run4 = [39, berserk_run5] {ai_run(25);};
void() berserk_run5 = [40, berserk_run6] {ai_run(18);};
void() berserk_run6 = [41, berserk_run1] {ai_run(19);};


void() BerserkerSpike =
{
	local vector delta;
	local float rvel;
	if (!self.enemy)
		return;
	delta = self.enemy.origin - self.origin;
	if (vlen(delta) > 100)
		return;
	if (!CanDamage (self.enemy, self))
		return;
	T_Damage (self.enemy, self, self, 80);
	if ((self.enemy.classname == "player"))
	{
                rvel = 64 + random() * 64;
		self.enemy.velocity_z = self.enemy.velocity_z + 400;
		self.enemy.velocity = self.enemy.velocity - v_forward * rvel;
	}
};

void() berserk_spike1 = [42, berserk_spike2] {ai_face();};
void() berserk_spike2 = [43, berserk_spike3] {ai_face();};
void() berserk_spike3 = [44, berserk_spike4] {ai_face();sound (self, CHAN_WEAPON, "berserk/attack.wav", 1, ATTN_NORM);};
void() berserk_spike4 = [45, berserk_spike5] {ai_face();walkmove(self.ideal_yaw, 6);BerserkerSpike();};
void() berserk_spike5 = [46, berserk_spike6] {ai_face();};
void() berserk_spike6 = [47, berserk_spike7] {ai_face();};
void() berserk_spike7 = [48, berserk_spike8] {ai_face();};
void() berserk_spike8 = [49, berserk_run1  ] {ai_face();};


void() BerserkerClub = 
{
	local vector delta;
	local float rvel;
	if (!self.enemy)
		return;
	delta = self.enemy.origin - self.origin;
	if (vlen(delta) > 100)
		return;
	if (!CanDamage (self.enemy, self))
		return;
	T_Damage (self.enemy, self, self, 88);
	if ((self.enemy.classname == "player"))
	{
              	rvel = 32 + random()*32;
		self.enemy.velocity_z = self.enemy.velocity_z + rvel;
		self.enemy.velocity = self.enemy.velocity - v_forward * 400;
	}
};

void() berserk_club1 = [50, berserk_club2] {ai_face();};
void() berserk_club2 = [51, berserk_club3] {ai_face();};
void() berserk_club3 = [52, berserk_club4] {ai_face();};
void() berserk_club4 = [53, berserk_club5] {ai_face();};
void() berserk_club5 = [54, berserk_club6] {ai_face();sound (self, CHAN_WEAPON, "berserk/attack.wav", 1, ATTN_NORM);};
void() berserk_club6 = [55, berserk_club7] {ai_face();};
void() berserk_club7 = [56, berserk_club8] {ai_face();};
void() berserk_club8 = [57, berserk_club9] {ai_face();};
void() berserk_club9 = [58, berserk_club10] {ai_face();walkmove(self.ideal_yaw, 6);BerserkerClub();};
void() berserk_club10 = [59, berserk_club11] {ai_face();};
void() berserk_club11 = [60, berserk_club12] {ai_face();};
void() berserk_club12 = [61, berserk_run1] {ai_face();};


void() berserk_melee =
{
	if (random() < 0.5)
		berserk_spike1 ();
	else
		berserk_club1 ();
};

void() berserk_pain1 = [76, berserk_pain2] {};
void() berserk_pain2 = [77, berserk_pain3] {};
void() berserk_pain3 = [78, berserk_pain4] {};
void() berserk_pain4 = [79, berserk_run1] {};
	
void() berserk_painb1 = [80, berserk_painb2] {};
void() berserk_painb2 = [81, berserk_painb3] {};
void() berserk_painb3 = [82, berserk_painb4] {};
void() berserk_painb4 = [83, berserk_painb5] {};
void() berserk_painb5 = [84, berserk_painb6] {};
void() berserk_painb6 = [85, berserk_painb7] {};
void() berserk_painb7 = [86, berserk_painb8] {};
void() berserk_painb8 = [87, berserk_painb9] {};
void() berserk_painb9 = [88, berserk_painb10] {};
void() berserk_painb10 = [89, berserk_painb11] {};
void() berserk_painb11 = [90, berserk_painb12] {};
void() berserk_painb12 = [91, berserk_painb13] {};
void() berserk_painb13 = [92, berserk_painb14] {};
void() berserk_painb14 = [93, berserk_painb15] {};
void() berserk_painb15 = [94, berserk_painb16] {};
void() berserk_painb16 = [95, berserk_painb17] {};
void() berserk_painb17 = [96, berserk_painb18] {};
void() berserk_painb18 = [97, berserk_painb19] {};
void() berserk_painb19 = [98, berserk_painb20] {};
void() berserk_painb20 = [99, berserk_run1] {};
	
void(entity attacker, float damage) berserk_pain =
{
	if (self.health < 120)
		self.skin = 1;
	if (self.pain_finished > time)
		return;
	self.pain_finished = time + 3;
	sound (self, CHAN_VOICE, "berserk/berpain2.wav", 1, ATTN_NORM);
	if (damage < 20 || random() < 0.5)
		berserk_pain1 ();
	else
		berserk_painb1 ();
};


void() berserk_die1 = [100, berserk_die2] {};
void() berserk_die2 = [101, berserk_die3] {};
void() berserk_die3 = [102, berserk_die4] {self.solid = SOLID_NOT;};
void() berserk_die4 = [103, berserk_die5] {};
void() berserk_die5 = [104, berserk_die6] {};
void() berserk_die6 = [105, berserk_die7] {};
void() berserk_die7 = [106, berserk_die8] {};
void() berserk_die8 = [107, berserk_die9] {};
void() berserk_die9 = [108, berserk_die10] {};
void() berserk_die10 = [109, berserk_die11] {};
void() berserk_die11 = [110, berserk_die12] {};
void() berserk_die12 = [111, berserk_die13] {};
void() berserk_die13 = [112, berserk_die13] {MonsterCorpse();};
	
void() berserk_dieb1 = [113, berserk_dieb2] {};
void() berserk_dieb2 = [114, berserk_dieb3] {};
void() berserk_dieb3 = [115, berserk_dieb4] {self.solid = SOLID_NOT;};
void() berserk_dieb4 = [116, berserk_dieb5] {};
void() berserk_dieb5 = [117, berserk_dieb6] {};
void() berserk_dieb6 = [118, berserk_dieb7] {};
void() berserk_dieb7 = [119, berserk_dieb8] {};
void() berserk_dieb8 = [120, berserk_dieb8] {MonsterCorpse();};
	
void(entity attacker, float damage) berserk_die =
{
        DropPowerBackPack(2);
	if (self.health < -60)
	{
		self.skin = 0;
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowGib("progs/gib1.mdl", -40);
		ThrowGib("progs/gib2.mdl", -40);
		ThrowGib("progs/gib3.mdl", -40);
		remove (self);
		return;
	}
	self.skin = 1;
	sound (self, CHAN_VOICE, "berserk/berdeth2.wav", 1, ATTN_NORM);
	if (damage >= 50)
		berserk_die1 ();
	else
		berserk_dieb1 ();
};

void() monster_lsoul;

//end
