void () Demon_JumpTouch;
void (float side) Demon_Melee;
float(float inp) CheckDemonFireBall;
void(float side) Demon_Shoot_Fire;
$cd /raid/quake/id1/models/demon3
$scale	0.8
$origin 0 0 24
$base base
$skin base
$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13
$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8
$frame run1 run2 run3 run4 run5 run6
$frame leap1 leap2 leap3 leap4 leap5 leap6 leap7 leap8 leap9 leap10
$frame leap11 leap12
$frame pain1 pain2 pain3 pain4 pain5 pain6
$frame death1 death2 death3 death4 death5 death6 death7 death8 death9
$frame attacka1 attacka2 attacka3 attacka4 attacka5 attacka6 attacka7 attacka8
$frame attacka9 attacka10 attacka11 attacka12 attacka13 attacka14 attacka15
void () demon1_stand1 = [ 0, demon1_stand2 ]
{
	ai_stand ();
};

void () demon1_stand2 = [ 1, demon1_stand3 ]
{
	ai_stand ();
};

void () demon1_stand3 = [ 2, demon1_stand4 ]
{
	ai_stand ();
};

void () demon1_stand4 = [ 3, demon1_stand5 ]
{
	ai_stand ();
};

void () demon1_stand5 = [ 4, demon1_stand6 ]
{
	ai_stand ();
};

void () demon1_stand6 = [ 5, demon1_stand7 ]
{
	ai_stand ();
};

void () demon1_stand7 = [ 6, demon1_stand8 ]
{
	ai_stand ();
};

void () demon1_stand8 = [ 7, demon1_stand9 ]
{
	ai_stand ();
};

void () demon1_stand9 = [ 8, demon1_stand10 ]
{
	ai_stand ();
};

void () demon1_stand10 = [ 9, demon1_stand11 ]
{
	ai_stand ();
};

void () demon1_stand11 = [ 10, demon1_stand12 ]
{
	ai_stand ();
};

void () demon1_stand12 = [ 11, demon1_stand13 ]
{
	ai_stand ();
};

void () demon1_stand13 = [ 12, demon1_stand1 ]
{
	ai_stand ();
};

void () demon1_walk1 = [ 13, demon1_walk2 ]
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "demon/idle1.wav", true, ATTN_IDLE);
	}
	ai_walk (FL_CLIENT);
};

void () demon1_walk2 = [ 14, demon1_walk3 ]
{
	ai_walk (MOVETYPE_TOSS);
};

void () demon1_walk3 = [ 15, demon1_walk4 ]
{
	ai_walk (MOVETYPE_TOSS);
};

void () demon1_walk4 = [ 16, demon1_walk5 ]
{
	ai_walk (MOVETYPE_PUSH);
};

void () demon1_walk5 = [ 17, demon1_walk6 ]
{
	ai_walk (MOVETYPE_STEP);
};

void () demon1_walk6 = [ 18, demon1_walk7 ]
{
	ai_walk (MOVETYPE_TOSS);
};

void () demon1_walk7 = [ 19, demon1_walk8 ]
{
	ai_walk (MOVETYPE_BOUNCE);
};

void () demon1_walk8 = [ 20, demon1_walk1 ]
{
	ai_walk (MOVETYPE_BOUNCE);
};

void () demon1_run1 = [ 21, demon1_run2 ]
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "demon/idle1.wav", true, ATTN_IDLE);
	}
	ai_run (20);
};

void () demon1_run2 = [ 22, demon1_run3 ]
{
	ai_run (15);
};

void () demon1_run3 = [ 23, demon1_run4 ]
{
	ai_run (36);
};

void () demon1_run4 = [ 24, demon1_run5 ]
{
	ai_run (20);
};

void () demon1_run5 = [ 25, demon1_run6 ]
{
	ai_run (15);
};

void () demon1_run6 = [ 26, demon1_run1 ]
{
	ai_run (36);
};

void () demon1_jump1 = [ 27, demon1_jump2 ]
{
	ai_face ();
};

void () demon1_jump2 = [ 28, demon1_jump3 ]
{
	ai_face ();
};

void () demon1_jump3 = [ 29, demon1_jump4 ]
{
	ai_face ();
};

void () demon1_jump4 = [ 30, demon1_jump5 ]
{
	ai_face ();
	self.touch = Demon_JumpTouch;
	makevectors (self.angles);
	self.origin_z = (self.origin_z + true);
	self.velocity = ((v_forward * 600) + '0 0 250');
	if ((self.flags & FL_ONGROUND))
	{
		self.flags = (self.flags - FL_ONGROUND);
	}
};

void () demon1_jump5 = [ 31, demon1_jump6 ]
{
};

void () demon1_jump6 = [ 32, demon1_jump7 ]
{
};

void () demon1_jump7 = [ 33, demon1_jump8 ]
{
};

void () demon1_jump8 = [ 34, demon1_jump9 ]
{
};

void () demon1_jump9 = [ 35, demon1_jump10 ]
{
};

void () demon1_jump10 = [ 36, demon1_jump1 ]
{
	self.nextthink = (time + MOVETYPE_WALK);
};

void () demon1_jump11 = [ 37, demon1_jump12 ]
{
};

void () demon1_jump12 = [ 38, demon1_run1 ]
{
};

void () demon1_atta1 = [ 54, demon1_atta2 ]
{
	ai_charge (MOVETYPE_STEP);
};

void () demon1_atta2 = [ 55, demon1_atta3 ]
{
	ai_charge (false);
};

void () demon1_atta3 = [ 56, demon1_atta4 ]
{
	ai_charge (false);
};

void () demon1_atta4 = [ 57, demon1_atta5 ]
{
	ai_charge (true);
};

void () demon1_atta5 = [ 58, demon1_atta6 ]
{
	ai_charge (FL_SWIM);
	Demon_Melee (200);
};

void () demon1_atta6 = [ 59, demon1_atta7 ]
{
	ai_charge (true);
};

void () demon1_atta7 = [ 60, demon1_atta8 ]
{
	ai_charge (MOVETYPE_TOSS);
};

void () demon1_atta8 = [ 61, demon1_atta9 ]
{
	ai_charge (FL_CLIENT);
};

void () demon1_atta9 = [ 62, demon1_atta10 ]
{
	ai_charge (MOVETYPE_STEP);
};

void () demon1_atta10 = [ 63, demon1_atta11 ]
{
	ai_charge (FL_SWIM);
};

void () demon1_atta11 = [ 64, demon1_atta12 ]
{
	Demon_Melee (-200);
};

void () demon1_atta12 = [ 65, demon1_atta13 ]
{
	ai_charge (MOVETYPE_FLY);
};

void () demon1_atta13 = [ 66, demon1_atta14 ]
{
	ai_charge (FL_CLIENT);
};

void () demon1_atta14 = [ 67, demon1_atta15 ]
{
	ai_charge (MOVETYPE_STEP);
};

void () demon1_atta15 = [ 68, demon1_run1 ]
{
	ai_charge (MOVETYPE_STEP);
};

void () demon1_pain1 = [ 39, demon1_pain2 ]
{
};

void () demon1_pain2 = [ 40, demon1_pain3 ]
{
};

void () demon1_pain3 = [ 41, demon1_pain4 ]
{
};

void () demon1_pain4 = [ 42, demon1_pain5 ]
{
};

void () demon1_pain5 = [ 43, demon1_pain6 ]
{
};

void () demon1_pain6 = [ 44, demon1_run1 ]
{
};
void() demon1_fire1;
void(float side) Demon_Shoot_Fire;
void()	demon1_fire1	=[	$attacka1,		demon1_fire2	] {ai_charge(16);};
void()	demon1_fire2	=[	$attacka2,		demon1_fire3	] {ai_charge(8);};
void()	demon1_fire3	=[	$attacka3,		demon1_fire4	] {ai_charge(2);};
void()	demon1_fire4	=[	$attacka4,		demon1_fire5	] {ai_charge(4);
};
void()	demon1_fire5	=[	$attacka5,		demon1_fire6	] {ai_charge(8);};
void()	demon1_fire6	=[	$attacka6,		demon1_fire7	] {ai_charge(4); Demon_Shoot_Fire(-1);};
void()	demon1_fire7	=[	$attacka7,		demon1_fire8	] {ai_charge(24);};
void()	demon1_fire8	=[	$attacka8,		demon1_fire9	] {ai_charge(32);};
void()	demon1_fire9	=[	$attacka9,		demon1_fire10	] {ai_charge(16);};
void()	demon1_fire10	=[	$attacka10,		demon1_fire11	] {ai_charge(8);
};
void()	demon1_fire11	=[	$attacka11,		demon1_fire12	] {ai_charge(4); Demon_Shoot_Fire(1);};
void()	demon1_fire12	=[	$attacka12,		demon1_fire13	] {ai_charge(20);};
void()	demon1_fire13	=[	$attacka13,		demon1_fire14	] {ai_charge(32);};
void()	demon1_fire14	=[	$attacka14,		demon1_fire15	] {ai_charge(16);};
void()	demon1_fire15	=[	$attacka15,		demon1_run1		] {ai_charge(16);};


void (entity attacker, float damage) demon1_pain =
{
	if ((self.touch == Demon_JumpTouch))
	{
		return;
	}
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + true);
	sound (self, CHAN_VOICE, "demon/dpain1.wav", true, ATTN_NORM);
	if (((random () * 200) > damage))
	{
		return;
	}
	demon1_pain1 ();
};

void () demon1_die1 = [ 45, demon1_die2 ]
{
	sound (self, CHAN_VOICE, "demon/ddeath.wav", true, ATTN_NORM);
};

void () demon1_die2 = [ 46, demon1_die3 ]
{
};

void () demon1_die3 = [ 47, demon1_die4 ]
{
};

void () demon1_die4 = [ 48, demon1_die5 ]
{
};

void () demon1_die5 = [ 49, demon1_die6 ]
{
};

void () demon1_die6 = [ 50, demon1_die7 ]
{
	self.solid = SOLID_NOT;
};

void () demon1_die7 = [ 51, demon1_die8 ]
{
};

void () demon1_die8 = [ 52, demon1_die9 ]
{
};

void () demon1_die9 = [ 53, demon1_die9 ]
{
};

void () demon_die =
{
	if ((self.health < -80))
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", true, ATTN_NORM);
		ThrowHead (mtf_savemodel("progs/h_demon.mdl"), self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		return;
	}
	demon1_die1 ();
};

void () Demon_MeleeAttack =
{
	demon1_atta1 ();
};

void () monster_demon2 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/demon.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = MTF_Monster_Health(300);
	self.th_stand = demon1_stand1;
	self.th_walk = demon1_walk1;
	self.th_run = demon1_run1;
	self.th_die = demon_die;
	self.th_melee = Demon_MeleeAttack;
	self.th_missile = demon1_jump2;
	self.th_pain = demon1_pain;
	self.th_fireball = demon1_fire1; //CH
	coop_walkmonster_start ();
};

void () monster_demon =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/demon.mdl");
	precache_model (mtf_savemodel("progs/h_demon.mdl"));
	precache_sound ("demon/ddeath.wav");
	precache_sound ("demon/dhit2.wav");
	precache_sound ("demon/djump.wav");
	precache_sound ("demon/dpain1.wav");
	precache_sound ("demon/idle1.wav");
	precache_sound ("demon/sight2.wav");
	self.netname = "fiend";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_demon2;
	COOP_SetLives ();

	monster_demon2 ();
};
void () monster_demon1 =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	Monsterclass_add(#MC_FIEND);
	precache_model ("progs/demon.mdl");
	precache_model (mtf_savemodel("progs/h_demon.mdl"));
	precache_sound ("demon/ddeath.wav");
	precache_sound ("demon/dhit2.wav");
	precache_sound ("demon/djump.wav");
	precache_sound ("demon/dpain1.wav");
	precache_sound ("demon/idle1.wav");
	precache_sound ("demon/sight2.wav");
	self.netname = "fiend";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_demon2;
	COOP_SetLives ();
	monster_demon2 ();
};

float () CheckDemonMelee =
{
	if ((enemy_range == RANGE_MELEE))
	{
		self.attack_state = AS_MELEE;
		return (true);
	}
	return (false);
};

float () CheckDemonJump =
{
	local vector dist;
	local float d;
	if (((self.origin_z + self.mins_z) > ((self.enemy.origin_z + self.enemy.mins_z) + (0.75 * self.enemy.size_z))))
	{
		return (false);
	}
	if (((self.origin_z + self.maxs_z) < ((self.enemy.origin_z + self.enemy.mins_z) + (0.25 * self.enemy.size_z))))
	{
		return (false);
	}
	dist = (self.enemy.origin - self.origin);
	dist_z = false;
	d = vlen (dist);
	if ((d < 100))
	{
		return (false);
	}
	if ((d > 200))
	{
		if ((random () < 0.9))
		{
			return (false);
		}
	}
	return (true);
};

float () DemonCheckAttack =
{
	if (self.weapon & #MWEAPON_FIREBALL)
	{
		if (CheckDemonFireBall(0)) //Normal
		{
			self.attack_state = #AS_FIREBALL;
			return #TRUE;
		}
		if (CheckDemonFireBall(1)) //Ranged
		{
			self.attack_state = #AS_FIREBALL;
			return #TRUE;
		}
	}
	if (CheckDemonMelee ())
	{
		self.attack_state = AS_MELEE;
		return (true);
	}
	if (CheckDemonJump ())
	{
		self.attack_state = AS_MISSILE;
		sound (self, CHAN_VOICE, "demon/djump.wav", true, ATTN_NORM);
		return (true);
	}
	return (false);
};

void (float side) Demon_Melee =
{
	local float ldmg;
	local vector delta;
	ai_face ();
	walkmove (self.ideal_yaw, TE_BLOOD);
	delta = (self.enemy.origin - self.origin);
	if ((vlen (delta) > 100))
	{
		return;
	}
	if (!CanDamage (self.enemy, self))
	{
		return;
	}
	sound (self, CHAN_WEAPON, "demon/dhit2.wav", true, ATTN_NORM);
	ldmg = (MOVETYPE_BOUNCE + (MOVETYPE_FLY * random ()));
	T_Damage (self.enemy, self, self, ldmg);
	makevectors (self.angles);
	SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), (side * v_right));
};

void () Demon_JumpTouch =
{
	local float ldmg;
	if ((self.health <= false))
	{
		return;
	}
	if (other.takedamage)
	{
		if ((vlen (self.velocity) > 400))
		{
			ldmg = (40 + (MOVETYPE_BOUNCE * random ()));
			T_Damage (other, self, self, ldmg);
		}
	}
	if (!checkbottom (self))
	{
		if ((self.flags & FL_ONGROUND))
		{
			self.touch = SUB_Null;
			self.think = demon1_jump1;
			self.nextthink = (time + 0.1);
		}
		return;
	}
	self.touch = SUB_Null;
	self.think = demon1_jump11;
	self.nextthink = (time + 0.1);
};
void() demon_fire_touch;
void(float side) Demon_Shoot_Fire =
{
	local vector	delta;
	local	vector	offang;
	local	vector	org, dir;
	ai_face ();
	walkmove (self.ideal_yaw, 12);	// allow a little closing
	delta = self.enemy.origin - self.origin;
	offang = vectoangles (delta);
	makevectors (offang);
	sound (self, CHAN_WEAPON, "hknight/attack1.wav", 1, ATTN_NORM); //Odd, it was already precached
	if (side > 0) //CH cause to spawn on side of demon.
		org = self.origin + (v_forward * 10) + (v_right * 20);
	else
		org = self.origin + (v_forward * 10) - (v_right * 20);
	dir = normalize (v_forward);
	dir_z = 0 - dir_z + (random() - 0.5)*0.1; //Random Z addage
	dir_x = dir_x + (random() - 0.5)*0.05; //Random X addage
	dir_y = dir_y + (random() - 0.5)*0.05; //Random Y addage
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.touch = demon_fire_touch;
	newmis.classname = "demon_fire";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/lavaball.mdl");
	setsize (newmis, '0 0 0', '0 0 0');
	setorigin (newmis, org);
	newmis.velocity = dir * 1000;
};
void() demon_fire_touch =
{
	local float fire_dmg;
	fire_dmg = 35/*60*/ + random()*40;		// 60 is a bit harsh.
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		dremove(self);
		return;
	}
	deathmsg = self.weapon;
	T_RadiusDamage (self, self.owner, fire_dmg , self.owner);
	self.origin = self.origin - 8*normalize(self.velocity); //???
	WriteByte (#MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
	multicast (self.origin, MULTICAST_PHS);
	dremove(self);
};
float(float inp) CheckDemonFireBall =
{
	local	vector	dist;
	local	float	d;
	local float d2;
	if (!visible2(self.enemy, self)) //If can see
		return #FALSE;
	dist = self.enemy.origin - self.origin;
	dist_z = 0; //CH only need x,y
	d2 = vlen(dist);
	dist = self.enemy.origin - self.origin;
	dist_x = dist_y = 0; //CH only need z
	d = vlen(dist);
	if (inp == 1) //Range attack
	{
		if (random() < 0.9) //CH as not to fire all the time
			return #FALSE;
		if (d2 < 300) //Min X,Y distance away before throw fireball
			return #FALSE;
		return #TRUE;
	}
	else //Normal attack
	{
		if (random() > 0.9) //CH as not to fire all the time
			return #FALSE;
		if (d2 < 200) //Min X,Y distance away before throw fireball
			return #FALSE;
		if (d < 100) //Min Z distance away before throw fireball
			return #FALSE;
		return #TRUE;
	}
};
//END
