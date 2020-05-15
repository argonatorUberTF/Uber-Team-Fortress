void () revenant_check_frame =
{
	self.oframe = self.frame;
	doom_ai_sprite_orient(88);
	self.nextthink = time + 0.1;
};
void () revenant_stand1 = [ 0, revenant_stand1 ]
{
	if (self.cells_bonus < 2)
		self.frame = 0;
	else
	if (self.cells_bonus < 4)
		self.frame = 8;
	else
	if (self.cells_bonus < 6)
		self.frame = 16;
	else
	if (self.cells_bonus < 8)
		self.frame = 24;
	else 
	if (self.cells_bonus < 10)
		self.frame = 32;
	else
	if (self.cells_bonus < 12)
		self.frame = 40;
	else
	{
		self.frame = 0;
		self.cells_bonus = 0;
	}
	ai_stand (); 
	if (random () < 0.07)
		sound (self, CHAN_VOICE, "doom_other/DSSKEACT.wav", TRUE, ATTN_IDLE);
	self.cells_bonus++;
	revenant_check_frame();
	ai_stand (); 
};
void () revenant_stand =
{
	self.cells_bonus = 0;
	revenant_stand1();
};
void () revenant_walk1 = [ 0, revenant_walk1 ]
{
	if (self.cells_bonus < 2)
		self.frame = 0;
	else
	if (self.cells_bonus < 4)
		self.frame = 8;
	else
	if (self.cells_bonus < 6)
		self.frame = 16;
	else 
	if (self.cells_bonus < 8)
		self.frame = 24;
	else
	if (self.cells_bonus < 10)
		self.frame = 32;
	else
	if (self.cells_bonus < 12)
		self.frame = 40;
	else
	{
		self.frame = 0;
		self.cells_bonus = 0;
	}
	self.cells_bonus++;
	revenant_check_frame();
	ai_walk (5 + TRUE); 
};
void () revenant_walk =
{
	self.cells_bonus = 0;
	revenant_walk1();
};
void () revenant_run1 = [ 0, revenant_run1 ]
{
	if (self.cells_bonus < 2)
		self.frame = 0;
	else
	if (self.cells_bonus < 4)
		self.frame = 8;
	else
	if (self.cells_bonus < 6)
		self.frame = 16;
	else
	if (self.cells_bonus < 8)
		self.frame = 24;
	else
	if (self.cells_bonus < 10)
		self.frame = 32;
	else
	if (self.cells_bonus < 12)
		self.frame = 40;
	else
	{
		self.frame = 0;
		self.cells_bonus = 0;
	}
	self.cells_bonus++;
	revenant_check_frame();
	ai_run (10); 
};
void () revenant_run =
{
	local float r;
	r = random ();
	if (r < 0.36)
		sound (self, CHAN_VOICE, "doom_other/DSSKESIT.wav", TRUE, ATTN_IDLE);
	self.cells_bonus = 0;
	revenant_run1();
};
void () RevMissileTouch =
{
	local vector org;
	if ((other == self.owner))
	{
		return;
	}
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	sound (self, CHAN_WEAPON, "doom_other/DSBAREXP.wav", TRUE, ATTN_STATIC);
	org = (self.origin - (FL_CLIENT * normalize (self.velocity)));
	if ((other.classname == "monster_revenant"))
	{
		return;
	}
	if (other.health)
	{
		SpawnBlood (org,  15);
		T_Damage (other, self, self.owner, 20);
	}
	remove (self);
};
void () RevHome =
{
	local vector dir;
	local vector vtemp;
	vtemp = (self.enemy.origin + '0 0 10');
	if ((self.enemy.health < TRUE))
	{
		remove (self);
		return;
	}
	dir = normalize ((vtemp - self.origin));
	self.angles = vectoangles (dir);
	self.velocity = (dir * 300);
	self.nextthink = (time + 0.5);
	self.think = RevHome;
};
void () RevFireBall =
{
	local entity missile;
	local vector dir;
	local float dist;
	local float flytime;
	dir = normalize (((self.enemy.origin + '0 0 10') - self.origin));
	dist = vlen ((self.enemy.origin - self.origin));
	flytime = (dist * 0.002);
	if ((flytime < 0.1))
	{
		flytime = 0.1;
	}
	self.effects = (self.effects | EF_MUZZLEFLASH);
	sound (self, CHAN_WEAPON, "doom_other/DSSKEATK.wav", TRUE, ATTN_NORM);
	missile = spawn ();
	missile.owner = self;
	missile.solid = SOLID_BBOX;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/missile.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	missile.origin = (self.origin + '0 0 20');
	missile.angles = vectoangles (dir);
	missile.velocity = (dir * 250);
	missile.nextthink = (flytime + time);
	missile.think = RevHome;
	missile.enemy = self.enemy;
	missile.touch = RevMissileTouch;
	self.attack_finished = (time + TRUE);
};
void () revenant_atk1 = [ 0, revenant_atk1 ]
{
	ai_face ();
	if (self.cells_bonus < 3)
		self.frame = 72;
	else
if (self.cells_bonus == 3)
{
		if (coop_visible(self, self.enemy))
{
			self.frame = 80;
			RevFireBall();
		}
	}
	else
if (self.cells_bonus == 4)
		self.frame = 80;
	else	{
		revenant_run1 ();
		return;
	}
	self.cells_bonus++;
	revenant_check_frame();
};
void () revenant_atk =
{
	if (self.attack_finished > time) 
		return;
	sound (self, CHAN_VOICE, "doom_other/dsmanatk.wav", TRUE, ATTN_NORM);
	self.cells_bonus = 0;
	revenant_atk1();
};
void () Rev_Punch =
{
	local vector delta;
	local float Idmg;
	ai_charge (MOVETYPE_BOUNCE);
	if (!self.enemy)
	{
		return;
	}
	delta = (self.enemy.origin - self.origin);
	if ((vlen (delta) > 100))
	{
		return;
	}
	sound (self, CHAN_WEAPON, "doom_other/DSSKEPCH.wav", TRUE, ATTN_STATIC);
	Idmg = ((random () * MOVETYPE_BOUNCE) + 18);
	T_Damage (self.enemy, self, self, Idmg);
	self.attack_finished = (time + 0.8);
};
void () revenant_melee1 = [ 0, revenant_melee1 ]
{
	if (self.cells_bonus < 2)
	{
		self.frame = 48;
		ai_charge(5);
	}
	else
	if (self.cells_bonus < 3)
	{
		self.frame = 56;
		ai_charge(5);
	}
	else
	if (self.cells_bonus < 4)
	{
		if (coop_visible(self, self.enemy))
		{
			self.frame = 64;
			Rev_Punch();
		}
	}
	else
	if (self.cells_bonus < 5)
		self.frame = 64;
	else
	{
		revenant_run1 ();
		return;
	}
	self.cells_bonus++;
	revenant_check_frame();
};
void () revenant_melee =
{
	if (self.attack_finished > time) 
		return;
	sound (self, CHAN_VOICE, "doom_other/DSSKESWG.wav", TRUE, ATTN_NORM);
	self.cells_bonus = 0;
	revenant_melee1();
};
void () revenant_pain1 = [ 0, revenant_pain1 ]
{
	if (self.cells_bonus < 1)
		self.frame = 88;
	else
	if (self.cells_bonus < 3)
		self.frame = 88;
	else
	{
		self.frame = 0;
		self.cells_bonus = 0;
		revenant_run1();
		return;
	}
	self.cells_bonus++;
	revenant_check_frame();
};
void () revenant_pain =
{
	if (self.pain_finished > time)
		return;
	sound (self, CHAN_VOICE, "doom_other/DSPOPAIN.wav", TRUE, ATTN_NORM);
	self.pain_finished = (time + 0.5);
	self.cells_bonus = 0;
	revenant_pain1();
};
void () revenant_die1 = [ 0, revenant_die1 ]
{
	self.frame = 89 + self.cells_bonus;
	if (self.frame >= 93)
	{
		self.frame = 93;
		self.cells_bonus = self.cells_bonus - 1;
	}
	self.cells_bonus++;
	revenant_check_frame();
};
void () revenant_die =
{
	self.cells_bonus = 0;
	self.solid = SOLID_NOT;
	revenant_die1();
	sound (self, CHAN_VOICE, "doom_other/DSSKEDTH.wav", TRUE, ATTN_NORM);
};
void () monster_revenant1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/revenant.spr");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = 340;
	self.th_stand = revenant_stand;
	self.th_walk = revenant_walk;
	self.th_run = revenant_run;
	self.th_missile = revenant_atk;
	self.th_melee = revenant_melee;
	self.th_pain = revenant_pain;
	self.th_die = revenant_die;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () monster_revenant =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/revenant.spr");
	precache_sound ("doom_other/DSSKESIT.wav");
	precache_sound ("doom_other/DSSKEACT.wav");
	precache_sound ("doom_other/DSPOPAIN.wav");
	precache_sound ("doom_other/DSSKEDTH.wav");
	precache_sound ("doom_other/DSSKESWG.wav");
	precache_sound ("doom_other/DSSKEPCH.wav");
	precache_sound ("doom_other/DSSKEATK.wav");
	precache_sound ("doom_other/DSBAREXP.wav");
	MTF_Setup_Monster_Presets ( 0, "Revenant", monster_revenant1 );
};
//END
