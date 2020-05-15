void () arachnotron_check_frame =
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
	doom_ai_sprite_orient(65);
	self.nextthink = time + 0.1;
};
void () arachnotron_stand1 = [ 0, arachnotron_stand1 ]
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
	arachnotron_check_frame();
	ai_stand (); 
};
void () arachnotron_stand =
{
	self.cells_bonus = 0;
	arachnotron_stand1();
};
void () arachnotron_walk1 = [ 0, arachnotron_walk1 ]
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
	if (random() < 0.15)
		sound (self, CHAN_VOICE, "doom_other/dsbspwlk.wav", TRUE, ATTN_IDLE);
	self.cells_bonus++;
	arachnotron_check_frame();
	ai_walk (5 + TRUE); 
};
void () arachnotron_walk =
{
	self.cells_bonus = 0;
	arachnotron_walk1();
};
void () arachnotron_run1 = [ 0, arachnotron_run1 ]
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
	if (random() < 0.15)
		sound (self, CHAN_VOICE, "doom_other/dsbspwlk.wav", TRUE, ATTN_IDLE);
	self.cells_bonus++;
	arachnotron_check_frame();
	ai_run (10); 
};
void () arachnotron_run =
{
	local float r;
	r = random ();
	if (r < 0.36)
		sound (self, CHAN_VOICE, "doom_other/dsbspsit.wav", TRUE, ATTN_IDLE);
	self.cells_bonus = 0;
	arachnotron_run1();
};
void () arachball_flythink =
{
	if (self.frame == 1)
		self.frame = 0;
	else
		self.frame = 1;
		
	if (time > self.health)
	{
		SUB_Remove();
	}
	self.nextthink = time + 0.1;
};
void () arachexplode1 = [ 2, arachexplode2 ]
{};
void () arachexplode2 = [ 3, arachexplode3 ]
{};
void () arachexplode3 = [ 4, arachexplode4 ]
{};
void () arachexplode4 = [ 5, SUB_Remove ]
{};
void () ArachMissileTouch =
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
	if ((other.classname == "monster_arachnotron"))
	{
		return;
	}
	if (other.health)
	{
		SpawnBlood (org, 15);
		T_Damage (other, self, self.owner, MOVETYPE_FLY);
	}
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	arachexplode1 ();
};
void (vector org, vector vec) ArachFire =
{
	vec = normalize (vec);
	sound (self, CHAN_WEAPON, "doom_other/dsplasma.wav", TRUE, ATTN_NORM);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	setmodel (newmis, "sprites/doom/arachball.spr");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);
	newmis.velocity = (vec * 600);
	newmis.angles = vectoangles (newmis.velocity);
	newmis.health = time + MOVETYPE_BOUNCE;
	newmis.nextthink = time + 0.1;
	newmis.think = arachball_flythink;
	newmis.touch = ArachMissileTouch;
};
void () ArachMissile =
{
	local vector org;
	makevectors (self.angles);
	org = ((self.origin + (v_forward * SVC_INTERMISSION)) + '0 0 30');
	ArachFire (org, (self.enemy.origin - self.origin));
};
void () arachnotron_atk1 = [ 0, arachnotron_atk1 ]
{
	ai_face ();
	if (self.cells_bonus < 2)
		self.frame = 48;
	else
	if (self.cells_bonus >=2)
	{
		if (coop_visible(self, self.enemy) && self.enemy.health >= 1)
		{
			self.frame = 56;
			ArachMissile();
			self.cells_bonus = 0;
		}
		else
		{
			arachnotron_run1();
			return;
		}	
	}
	self.cells_bonus++;
	arachnotron_check_frame();
};
void () arachnotron_atk =
{
	if (self.attack_finished > time) 
		return;
	self.cells_bonus = 0;
	arachnotron_atk1();
};
void () arachnotron_pain1 = [ 0, arachnotron_pain1 ]
{
	if (self.cells_bonus < 3)
		self.frame = 64;
	else
	{
		self.frame = 0;
		self.cells_bonus = 0;
		arachnotron_run1();
		return;
	}
	self.cells_bonus++;
	arachnotron_check_frame();
};
void () arachnotron_pain =
{
	if (self.pain_finished > time)
		return;
	sound (self, CHAN_VOICE, "doom_other/dsdmpain.wav", TRUE, ATTN_NORM);
	self.pain_finished = (time + 2.5);
	self.cells_bonus = 0;
	arachnotron_pain1();
};
void () arachnotron_die1 = [ 0, arachnotron_die1 ]
{
	self.frame = 65 + self.cells_bonus;
	if (self.frame >= 71)
{
		self.frame = 71;
		self.cells_bonus = self.cells_bonus - 1;
	}
	self.cells_bonus++;
	arachnotron_check_frame();
};
void () arachnotron_die =
{
	self.cells_bonus = 0;
	self.solid = SOLID_NOT;
	arachnotron_die1();
	sound (self, CHAN_VOICE, "doom_other/dsbspdth.wav", TRUE, ATTN_NORM);
};
void () monster_arachnotron1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/arachno.spr");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = 340;
	self.th_stand = arachnotron_stand;
	self.th_walk = arachnotron_walk;
	self.th_run = arachnotron_run;
	self.th_missile = arachnotron_atk;
	self.th_pain = arachnotron_pain;
	self.th_die = arachnotron_die;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () monster_arachnotron =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/arachno.spr");
	precache_model ("sprites/doom/arachball.spr");
	precache_sound ("doom_other/dsbspsit.wav");
	precache_sound ("doom_other/dsbspwlk.wav");
	precache_sound ("doom_other/dsbspact.wav");
	precache_sound ("doom_other/dsdmpain.wav");
	precache_sound ("doom_other/dsbspdth.wav");
	precache_sound ("doom_other/dsplasma.wav");
	precache_sound ("doom_other/dsfirxpl.wav");
	MTF_Setup_Monster_Presets ( 0, "Arachnotron", monster_arachnotron1 );
};
//END
