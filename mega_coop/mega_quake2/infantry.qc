void () infantry_atka12;
vector () leadtarget =
{
	local vector enemine;
	traceline (self.origin, self.enemy.origin, FALSE, self);
	enemine = (self.enemy.origin + self.enemy.velocity);
	if ((trace_ent != self.enemy))
	{
		return (normalize ((self.origin/*self.c_aim*/ - self.origin)));
	}
	if (self.enemy.velocity)
	{
		vlen ((enemine - self.origin));
		if ((vlen ((self.enemy.origin - self.origin)) > vlen ((self.enemy.origin - self.origin))))
		{
			if ((range (self.enemy) == 0/*RANGE_MELEE*/))
			{
				return (normalize ((self.enemy.origin - self.origin)));
			}
			if ((range (self.enemy) == 1))	// near
			{
				return (normalize (((self.enemy.origin + ((self.enemy.velocity * 1/*self.dexterity*/) * 0.4)) - self.origin)));
			}
			if ((range (self.enemy) == 2))	// mid
			{
				return (normalize (((self.enemy.origin + ((self.enemy.velocity * 1/*self.dexterity*/) * 0.8)) - self.origin)));
			}
		}
		else
		{
			return (normalize (((self.enemy.origin + ((self.enemy.velocity * 1/*self.dexterity*/) * 0.1)) - self.origin)));
		}
	}
	return (normalize ((self.enemy.origin - self.origin)));
};

void () velocity_cap =
{
	local float rgt;
	local float rgs;
	local float rgr;
	local float rgq;
	local float rgp;
	rgt = (1/*self.rage*/ * 320);
	rgs = self.velocity_x;
	rgr = (rgt / rgs);
	rgq = self.velocity_y;
	rgp = (rgt / rgq);
	if (((checkbottom (self) == TRUE) && (self.velocity_x > rgt)))
	{
		self.velocity_x = (self.velocity_x * rgr);
	}
	if (((checkbottom (self) == TRUE) && (self.velocity_y > rgt)))
	{
		self.velocity_y = (self.velocity_y * rgp);
	}
};

void () charge =
{
	local vector rnd;
	rnd = leadtarget ();
	movetogoal (22);
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	if ((checkbottom (self) == TRUE))
	{
		makevectors (self.angles);
		self.velocity = ((self.velocity * 0.5) + ((normalize (rnd) * 160) + '0 0 2'));
	}
	velocity_cap ();
};


void() GuardLaserTouch =
{
	local vector org;
	
	if (other == self.owner)
		return;
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_NORM);
	org = self.origin - 8*normalize(self.velocity);
	
	if (other.takedamage)
	{
		SpawnBlood (org, /*self.velocity*0.2,*/ 15);
		T_Damage (other, self, self.owner, 5);
	}
	remove(self);
};

void() guard_fire_blaster =
{
	local entity laser;
	sound (self, CHAN_WEAPON, "soldier2/solatck2.wav", 1, ATTN_NORM);
	laser = spawn ();
	laser.owner = self;
	laser.movetype = MOVETYPE_FLY;
	laser.solid = SOLID_BBOX;
	laser.classname = "laser";
	laser.effects = EF_DIMLIGHT;
	makevectors (self.angles);
	laser.velocity = normalize(self.enemy.origin - self.origin);
	laser.velocity = laser.velocity * 600;
	laser.angles = vectoangles(laser.velocity);
	laser.touch = GuardLaserTouch;
	laser.health = time + 5;
	laser.nextthink = time + 5;
	laser.think = SUB_Remove;
	setmodel (laser, "progs/laser.mdl");
	setsize (laser, '0 0 0', '0 0 0');
	setorigin (laser, self.origin + v_forward*8 + '0 0 16');
};

void(vector dir) guard_fire_shotgun =
{
	sound (self, CHAN_WEAPON, "soldier2/solatck1.wav", 1, ATTN_NORM);
	FireBullets (12, dir, '0.1 0.05 0'/*, 2*/);
};

void() guard_fire =
{
	local vector dir;
	self.effects = self.effects | EF_MUZZLEFLASH;
	dir = self.enemy.origin - self.enemy.velocity*0.2;
	dir = normalize(dir - self.origin);
	if (self.skin <= 1)
		guard_fire_shotgun (dir);
	else if (self.skin <= 3)
		guard_fire_blaster ();
	else
	{
		sound (self, CHAN_WEAPON, "soldier2/solatck3.wav", 1, ATTN_NORM);
		FireBullets (1, dir, '0.03 0.05 0'/*, 2*/);
	}
};

void () infantry_stand1 = [ 51, infantry_stand2 ]
{
	ai_stand ();
	if ((random () < 0.3))
	{
		sound (self, CHAN_VOICE, "infidle.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
	}
};

void () infantry_stand2 = [ 52, infantry_stand3 ]
{
	ai_stand ();
};

void () infantry_stand3 = [ 53, infantry_stand4 ]
{
	ai_stand ();
};

void () infantry_stand4 = [ 54, infantry_stand5 ]
{
	ai_stand ();
};

void () infantry_stand5 = [ 55, infantry_stand6 ]
{
	ai_stand ();
};

void () infantry_stand6 = [ 56, infantry_stand7 ]
{
	ai_stand ();
};

void () infantry_stand7 = [ 57, infantry_stand8 ]
{
	ai_stand ();
};

void () infantry_stand8 = [ 58, infantry_stand9 ]
{
	ai_stand ();
};

void () infantry_stand9 = [ 59, infantry_stand10 ]
{
	ai_stand ();
};

void () infantry_stand10 = [ 60, infantry_stand11 ]
{
	ai_stand ();
};

void () infantry_stand11 = [ 61, infantry_stand12 ]
{
	ai_stand ();
};

void () infantry_stand12 = [ 62, infantry_stand1 ]
{
	ai_stand ();
};

void () infantry_walk1 = [ 74, infantry_walk2 ]
{
	if ((random () < 0.3))
	{
		sound (self, CHAN_VOICE, "infidle.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
	}
	ai_walk (13);
};

void () infantry_walk2 = [ 75, infantry_walk3 ]
{
	ai_walk (13);
};

void () infantry_walk3 = [ 76, infantry_walk4 ]
{
	ai_walk (13);
};

void () infantry_walk4 = [ 77, infantry_walk5 ]
{
	ai_walk (13);
};

void () infantry_walk5 = [ 78, infantry_walk6 ]
{
	ai_walk (13);
};

void () infantry_walk6 = [ 79, infantry_walk7 ]
{
	ai_walk (13);
};

void () infantry_walk7 = [ 70, infantry_walk8 ]
{
	ai_walk (13);
};

void () infantry_walk8 = [ 71, infantry_walk9 ]
{
	ai_walk (13);
};

void () infantry_walk9 = [ 72, infantry_walk10 ]
{
	ai_walk (13);
};

void () infantry_walk10 = [ 73, infantry_walk11 ]
{
	ai_walk (13);
};

void () infantry_walk11 = [ 74, infantry_walk12 ]
{
	ai_walk (13);
};

void () infantry_walk12 = [ 75, infantry_walk13 ]
{
	ai_walk (13);
};

void () infantry_walk13 = [ 76, infantry_walk1 ]
{
	ai_walk (13);
};

void () infantry_run1 = [ 93, infantry_run2 ]
{
	if ((random () < 0.3))
	{
		sound (self, CHAN_VOICE, "infsearch.wav", SPAWNFLAG_SUPERSPIKE, ATTN_IDLE);
	}
	ai_run (19);
};

void () infantry_run2 = [ 94, infantry_run3 ]
{
	ai_run (19);
};

void () infantry_run3 = [ 95, infantry_run4 ]
{
	ai_run (19);
};

void () infantry_run4 = [ 96, infantry_run5 ]
{
	ai_run (19);
};

void () infantry_run5 = [ 97, infantry_run6 ]
{
	ai_run (19);
};

void () infantry_run6 = [ 98, infantry_run7 ]
{
	ai_run (19);
};

void () infantry_run7 = [ 99, infantry_run8 ]
{
	ai_run (19);
};

void () infantry_run8 = [ 100, infantry_run1 ]
{
	ai_run (19);
};

void () infantry_atka1 = [ 186, infantry_atka2 ]
{
	sound (other, CHAN_VOICE, "infsight.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	ai_face ();
	self.nextthink = (time + 0.03);
};

void () infantry_atka2 = [ 187, infantry_atka3 ]
{
	ai_face ();
	self.nextthink = (time + 0.03);
};

void () infantry_atka3 = [ 188, infantry_atka4 ]
{
	ai_face ();
	self.nextthink = (time + 0.03);
};

void () infantry_atka4 = [ 189, infantry_atka5 ]
{
	ai_face ();
	self.nextthink = (time + 0.03);
};

void () infantry_atka5 = [ 190, infantry_atka6 ]
{
	ai_face ();
	self.nextthink = (time + 0.03);
};

void () infantry_atka6 = [ 191, infantry_atka7 ]
{
	ai_face ();
	self.nextthink = (time + 0.03);
};

void () infantry_atka7 = [ 192, infantry_atka8 ]
{
	sound (self, CHAN_WEAPON, "weapons/lock4.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	ai_face ();
};

void () infantry_atka8 = [ 193, infantry_atka9 ]
{
	ai_face ();
};

void () infantry_atka9 = [ 194, infantry_atka10 ]
{
	ai_face ();
};

void () infantry_atka10 = [ 195, infantry_atka11 ]
{
	guard_fire ();
	ai_face ();
};

void () infantry_atka11 = [ 196, infantry_atka12 ]
{
	ai_face ();
};

void () infantry_atka12 = [ 195, infantry_atka13 ]
{
	ai_face ();
};

void () infantry_atka13 = [ 196, infantry_atka14 ]
{
	ai_face ();
};

void () infantry_atka14 = [ 197, infantry_atka15 ]
{
	ai_face ();
};

void () infantry_atka15 = [ 198, infantry_atka16 ]
{
	ai_face ();
};

void () infantry_atka16 = [ 199, infantry_run1 ]
{
	ai_face ();
};

void () infantry_atkb1 = [ 200, infantry_atkb2 ]
{
	charge ();
	ai_face ();
};

void () infantry_atkb2 = [ 201, infantry_atkb3 ]
{
	charge ();
	ai_face ();
};

void () infantry_atkb3 = [ 202, infantry_atkb4 ]
{
	charge ();
	ai_face ();
};

void () infantry_atkb4 = [ 203, infantry_atkb5 ]
{
	charge ();
	ai_face ();
};

void () infantry_atkb5 = [ 204, infantry_atkb6 ]
{
	charge ();
	ai_face ();
};

void () infantry_atkb6 = [ 205, infantry_atkb7 ]
{
	Demon_Melee (MSG_BROADCAST);
	charge ();
	ai_face ();
};

void () infantry_atkb7 = [ 206, infantry_atkb8 ]
{
	charge ();
	ai_face ();
};

void () infantry_atkb8 = [ 207, infantry_run1 ]
{
	charge ();
	ai_face ();
};

void () infantry_pain1 = [ 101, infantry_pain2 ]
{
};

void () infantry_pain2 = [ 102, infantry_pain3 ]
{
};

void () infantry_pain3 = [ 103, infantry_pain4 ]
{
};

void () infantry_pain4 = [ 104, infantry_pain5 ]
{
};

void () infantry_pain5 = [ 105, infantry_pain6 ]
{
};

void () infantry_pain6 = [ 106, infantry_pain7 ]
{
};

void () infantry_pain7 = [ 107, infantry_pain8 ]
{
};

void () infantry_pain8 = [ 108, infantry_pain9 ]
{
};

void () infantry_pain9 = [ 109, infantry_pain10 ]
{
};

void () infantry_pain10 = [ 110, infantry_run1 ]
{
};

void (entity attacker, float damage) infantry_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	sound (self, CHAN_VOICE, "infpain.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	self.pain_finished = (time + TE_LIGHTNING2);
	infantry_pain1 ();
};

void () infantry_die1 = [ 126, infantry_die2 ]
{
	self.ammo_shells = 10;
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	self.ammo_nails = 20;
	DropBackpack ();
	self.solid = SOLID_NOT;
};

void () infantry_die2 = [ 127, infantry_die3 ]
{
};

void () infantry_die3 = [ 128, infantry_die4 ]
{
};

void () infantry_die4 = [ 129, infantry_die5 ]
{
};

void () infantry_die5 = [ 130, infantry_die6 ]
{
};

void () infantry_die6 = [ 131, infantry_die7 ]
{
};

void () infantry_die7 = [ 132, infantry_die8 ]
{
};

void () infantry_die8 = [ 133, infantry_die9 ]
{
};

void () infantry_die9 = [ 134, infantry_die10 ]
{
};

void () infantry_die10 = [ 135, infantry_die11 ]
{
};

void () infantry_die11 = [ 136, infantry_die12 ]
{
};

void () infantry_die12 = [ 137, infantry_die13 ]
{
};

void () infantry_die13 = [ 138, infantry_die14 ]
{
};

void () infantry_die14 = [ 139, infantry_die15 ]
{
};

void () infantry_die15 = [ 140, infantry_die16 ]
{
};

void () infantry_die16 = [ 141, infantry_die17 ]
{
};

void () infantry_die17 = [ 142, infantry_die18 ]
{
};

void () infantry_die18 = [ 143, infantry_die19 ]
{
};

void () infantry_die19 = [ 144, infantry_die19 ]
{};

void () infantry_die =
{
	if ((!deathmatch && (self.health < -35)))
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		ThrowHead ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	sound (self, CHAN_VOICE, "infdie.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	//self.dead = "dead";
	infantry_die1 ();
};
//END
