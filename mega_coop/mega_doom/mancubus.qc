void () mancubus_check_frame =
{
	if (self.frame >= 0 && self.frame <= 17)			/* idle */
	{
	}
	else
	if (self.frame >= 39 && self.frame <=  54)  	/* walk and run */
	{
	}
	else
	if (self.frame >= 55 && self.frame <=  58)  	/* attacking */
	{
	}
	else
	if (self.frame >= 17 && self.frame <=  32)  	/* death */
	{
	}
	else
	if (self.frame >= 33 && self.frame <=  38)  	/* pain */
	{
	}
	self.oframe = self.frame;
	doom_ai_sprite_orient(64);
	self.nextthink = time + 0.1;
};
void () mancubus_stand1 = [ 0, mancubus_stand1 ]
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
		sound (self, CHAN_VOICE, "doom_other/dsposact.wav", TRUE, ATTN_IDLE);
	self.cells_bonus++;
	mancubus_check_frame();
	ai_stand (); 
};
void () mancubus_stand =
{
	self.cells_bonus = 0;
	mancubus_stand1();
};
void () mancubus_walk1 = [ 0, mancubus_walk1 ]
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
	mancubus_check_frame();
	ai_walk (5 + TRUE); 
};
void () mancubus_walk =
{
	self.cells_bonus = 0;
	mancubus_walk1();
};
void () mancubus_run1 = [ 0, mancubus_run1 ]
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
	mancubus_check_frame();
	ai_run (10); 
};
void () mancubus_run =
{
	local float r;
	r = random ();
	if (r < 0.36)
		sound (self, CHAN_VOICE, "doom_other/dsmansit.wav", TRUE, ATTN_IDLE);
	self.cells_bonus = 0;
	mancubus_run1();
};
void () mancuMissileTouch =
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
	sound (self, CHAN_WEAPON, "doom_other/dsfirxpl.wav", TRUE, ATTN_NORM);
	org = (self.origin - (FL_CLIENT * normalize (self.velocity)));
	if ((other.classname == "monster_mancubus"))
	{
		return;
	}
	if (other.health)
	{
		SpawnBlood (org,  15);
		T_Damage (other, self, self.owner, 45);
	}
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};
void (vector org, vector vec) mancuFire =
{
	vec = normalize (vec);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;
	setmodel (newmis, "progs/missile.mdl");
	setsize (newmis, '-5 -5 -2', '5 5 2');
	setorigin (newmis, org);
	newmis.velocity = (vec * 600);
	newmis.angles = vectoangles (newmis.velocity);
	newmis.nextthink = (time + MOVETYPE_BOUNCE);
	newmis.think = SUB_Remove;
	self.attack_finished = (time + 1);
	newmis.touch = mancuMissileTouch;
	sound (newmis, CHAN_WEAPON, "doom_other/dsfirsht.wav", TRUE, ATTN_NORM);
};
void () mancuMissile =
{
	local vector org;
	local vector org2;
	makevectors (self.angles);
	org = (((self.origin + (v_forward * 20)) + (v_right * MOVETYPE_BOUNCEMISSILE)) + '0 0 10');	// used to be +16 on _z
	org2 = (((self.origin + (v_forward * 20)) + (v_right * -15.5)) + '0 0 10');
	ai_face ();
	mancuFire (org, (self.enemy.origin - self.origin));
	mancuFire (org2, (self.enemy.origin - self.origin));
};
void () mancubus_atk1 = [ 0, mancubus_atk1 ]
{
	ai_face ();
	if (self.cells_bonus < 3)
		self.frame = 48;
	else
	if (self.cells_bonus == 3)
	{
		if (coop_visible(self, self.enemy))
		{
			self.frame = 56;
			mancuMissile();
		}
	}
	else
	if (self.cells_bonus == 4)
		self.frame = 56;
	else 
	if (self.cells_bonus == 5 || self.cells_bonus == 6)
		self.frame = 48;
	else
	{
		mancubus_run1 ();
		return;
	}
	self.cells_bonus++;
	mancubus_check_frame();
};
void () mancubus_atk =
{
	if (self.attack_finished > time) 
		return;
	sound (self, CHAN_VOICE, "doom_other/dsmanatk.wav", TRUE, ATTN_NORM);
	self.cells_bonus = 0;
	mancubus_atk1();
};
void () mancubus_pain1 = [ 0, mancubus_pain1 ]
{
	if (self.cells_bonus < 1)
		self.frame = 64;
	else
	if (self.cells_bonus < 3)
		self.frame = 65;
	else
	{
		self.frame = 0;
		self.cells_bonus = 0;
		mancubus_run1();
		return;
	}
	self.cells_bonus++;
	mancubus_check_frame();
};
void () mancubus_pain =
{
	if (self.pain_finished > time)
		return;
	sound (self, CHAN_VOICE, "doom_other/dsmnpain.wav", TRUE, ATTN_NORM);
	self.pain_finished = (time + 2.5);
	self.cells_bonus = 0;
	mancubus_pain1();
};
void () mancubus_die1 = [ 0, mancubus_die1 ]
{
	self.frame = 66 + self.cells_bonus;
	if (self.frame >= 75) {
		self.frame = 75;
		self.cells_bonus = self.cells_bonus - 1;
	}
	self.cells_bonus++;
	mancubus_check_frame();
};
void () mancubus_die =
{
	self.cells_bonus = 0;
	self.solid = SOLID_NOT;
	mancubus_die1();
	sound (self, CHAN_VOICE, "doom_other/dsmandth.wav", TRUE, ATTN_NORM);
};
void () monster_mancubus1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/mancubus.spr");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = 340;
	self.th_stand = mancubus_stand;
	self.th_walk = mancubus_walk;
	self.th_run = mancubus_run;
	self.th_missile = mancubus_atk;
	self.th_pain = mancubus_pain;
	self.th_die = mancubus_die;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () monster_mancubus =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/mancubus.spr");
	precache_sound ("doom_other/dsmansit.wav");
	precache_sound ("doom_other/dsposact.wav");
	precache_sound ("doom_other/dsmnpain.wav");
	precache_sound ("doom_other/dsmandth.wav");
	precache_sound ("doom_other/dsmanatk.wav");
	precache_sound ("doom_other/dsfirsht.wav");
	precache_sound ("doom_other/dsfirxpl.wav");
	MTF_Setup_Monster_Presets ( 0, "Mancubus", monster_mancubus1 );
};
//END
