void () sargeant_fire;
void () sargeant_check_frame =
{
	if (self.frame >= 0 && self.frame <= 17)			/* idle */
	{}
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
	doom_ai_sprite_orient(48);
	self.nextthink = time + 0.1;
};
void () sargeant_stand1 = [ 0, sargeant_stand2 ]
{
	sargeant_check_frame();
	ai_stand (); 
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_soldier/nearby.wav", TRUE, ATTN_IDLE);
	}
};
void () sargeant_stand2 = [ 8, sargeant_stand3 ]
{
	sargeant_check_frame();
	ai_stand (); 
};
void () sargeant_stand3 = [ 16, sargeant_stand4 ]
{
	sargeant_check_frame();
	ai_stand (); 
};
void () sargeant_stand4 = [ 24, sargeant_stand5 ]
{
	sargeant_check_frame();
	ai_stand (); 
};
void () sargeant_stand5 = [ 16, sargeant_stand6 ]
{
	sargeant_check_frame();
	ai_stand (); 
};
void () sargeant_stand6 = [ 8, sargeant_stand1 ]
{
	sargeant_check_frame();
	ai_stand (); 
};
void () sargeant_walk1 = [ 0, sargeant_walk2 ]
{
	sargeant_check_frame();
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_soldier/nearby.wav", TRUE, ATTN_IDLE);
	}
	ai_walk (5 + TRUE); 
};
void () sargeant_walk2 = [ 8, sargeant_walk3 ]
{
	sargeant_check_frame();
	ai_walk (5 + TRUE); 
};
void () sargeant_walk3 = [ 16, sargeant_walk4 ]
{
	sargeant_check_frame();
	ai_walk (5 + TRUE); 
};
void () sargeant_walk4 = [ 24, sargeant_walk5 ]
{
	sargeant_check_frame();
	ai_walk (5 + TRUE); 
};
void () sargeant_walk5 = [ 16, sargeant_walk6 ]
{
	sargeant_check_frame();
	ai_walk (5 + FL_SWIM); 
};
void () sargeant_walk6 = [ 8, sargeant_walk1 ]
{
	sargeant_check_frame();
	ai_walk (5 + MOVETYPE_WALK); 
};
void () sargeant_run1 = [ 0, sargeant_run2 ]
{
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "soldier/idle.wav", TRUE, ATTN_IDLE);
	}
	sargeant_check_frame();
	ai_run (5 + FL_SWIM); 
};
void () sargeant_run2 = [ 8, sargeant_run3 ]
{
	sargeant_check_frame();
	ai_run (5 + MOVETYPE_FLY); 
	 
};
void () sargeant_run3 = [ 16, sargeant_run4 ]
{
	sargeant_check_frame();
	ai_run (5 + MOVETYPE_STEP); 
	 
};
void () sargeant_run4 = [ 24, sargeant_run1 ]
{
	sargeant_check_frame();
	ai_run (5 + MOVETYPE_WALK); 
	 
};
void () sargeant_run5 = [ 16, sargeant_run6 ]
{
	sargeant_check_frame();
	ai_run (5 + MOVETYPE_STEP); 
	 
};
void () sargeant_run6 = [ 8, sargeant_run1 ]
{
	sargeant_check_frame();
	ai_run (5 + MOVETYPE_STEP); 
	
};
void () sargeant_atk1 = [ 32, sargeant_atk2 ]
{
	sargeant_check_frame();
	ai_face (); 
};
void () sargeant_atk2 = [ 40, sargeant_atk3 ]
{
	ai_face (); 
	sargeant_check_frame();
	
	sargeant_fire ();
};
void () sargeant_atk3 = [ 40, sargeant_atk4 ]
{
sargeant_check_frame();
	ai_face (); 
};
void () sargeant_atk4 = [ 32, sargeant_run1 ]
{
	sargeant_check_frame();
	ai_face (); 
};
void () sargeant_pain1 = [ 48, sargeant_pain2 ]
{
	sargeant_check_frame();
};
void () sargeant_pain2 = [ 48, sargeant_run1 ]
{
	sargeant_check_frame();
};
void (entity attacker, float damage) sargeant_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 2.5);
	sargeant_pain1 ();
	sound (self, CHAN_VOICE, "doom_soldier/pain.wav", TRUE, ATTN_NORM);
};
void () sargeant_run =
{
	local float r;
	r = random ();
	if ((r < 0.36))
	{
		sound (self, CHAN_VOICE, "doom_soldier/site1.wav", TRUE, ATTN_IDLE);
	}
	else
	{
		if ((r < 0.67))
		{
			sound (self, CHAN_VOICE, "doom_soldier/site2.wav", TRUE, ATTN_IDLE);
		}
		else
		{
			if ((r < TRUE))
			{
				sound (self, CHAN_VOICE, "doom_soldier/site3.wav", TRUE, ATTN_IDLE);
			}
		}
	}
	sargeant_run1 ();
};
void () sargeant_fire =
{
	local vector dir;
	local entity en;
	ai_face ();
	sound (self, CHAN_WEAPON, "weapons/shotgun.wav", TRUE, ATTN_NORM);
	en = self.enemy;
	dir = (en.origin - (en.velocity * 0.2));
	dir = normalize ((dir - self.origin));
	FireBullets (10, dir, '0.1 0.1 0');
	self.attack_finished = (time + 1.6);
};
void () sargeant_die1 = [ 49, sargeant_die2 ]
{
	sargeant_check_frame();
	self.solid = SOLID_NOT;
	self.ammo_nails = MOVETYPE_FLY;
	DropShot (); 
};
void () sargeant_die2 = [ 50, sargeant_die3 ]
{
	sargeant_check_frame();
};
void () sargeant_die3 = [ 51, sargeant_die4 ]
{
	sargeant_check_frame();
};
void () sargeant_die4 = [ 52, sargeant_die5 ]
{
	sargeant_check_frame();
};
void () sargeant_die5 = [ 53, sargeant_die5 ]
{
sargeant_check_frame();
};
void () sargeant_gib1 = [ 54, sargeant_gib2 ]
{
sargeant_check_frame();
	self.solid = SOLID_NOT;
	self.ammo_nails = MOVETYPE_FLY;
	DropShot (); 
};
void () sargeant_gib2 = [ 55, sargeant_gib3 ]
{
sargeant_check_frame();
};
void () sargeant_gib3 = [ 56, sargeant_gib4 ]
{
sargeant_check_frame();
};
void () sargeant_gib4 = [ 57, sargeant_gib5 ]
{
sargeant_check_frame();
};
void () sargeant_gib5 = [ 58, sargeant_gib6 ]
{
sargeant_check_frame();
};
void () sargeant_gib6 = [ 59, sargeant_gib7 ]
{
sargeant_check_frame();
};
void () sargeant_gib7 = [ 60, sargeant_gib8 ]
{
sargeant_check_frame();
};
void () sargeant_gib8 = [ 61, sargeant_gib9 ]
{
sargeant_check_frame();
};
void () sargeant_gib9 = [ 62, sargeant_gib9 ]
{
sargeant_check_frame();
};
void () sargeant_die =
{
	local float r;
	if ((self.health < -65))
	{
		sound (self, CHAN_VOICE, "action/gibs.wav", TRUE, ATTN_NORM); 
		sargeant_gib1 (); 
		return;
	}
	r = random ();
	if ((r < 0.34))
	{
		sound (self, CHAN_VOICE, "doom_soldier/die1.wav", TRUE, ATTN_NORM);
	}
	else
	{
		if ((r < 0.67))
		{
			sound (self, CHAN_VOICE, "doom_soldier/die2.wav", TRUE, ATTN_NORM);
		}
		else
		{
			if ((r < TRUE))
			{
				sound (self, CHAN_VOICE, "doom_soldier/die3.wav", TRUE, ATTN_NORM);
			}
		}
	}
	sargeant_die1 ();
};
void () monster_sargeant1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/sarge.spr");
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.health = SVC_INTERMISSION;
	self.th_stand = sargeant_stand1;
	self.th_walk = sargeant_walk1;
	self.th_run = sargeant_run;
	self.th_missile = sargeant_atk1;
	self.th_pain = sargeant_pain;
	self.th_die = sargeant_die;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () monster_sargeant =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/sarge.spr");
	precache_sound ("doom_soldier/die1.wav");
	precache_sound ("doom_soldier/die2.wav");
	precache_sound ("doom_soldier/die3.wav");
	precache_sound ("doom_soldier/nearby.wav");
	precache_sound ("soldier/idle.wav");
	precache_sound ("doom_soldier/pain.wav");
	precache_sound ("doom_soldier/site1.wav");
	precache_sound ("doom_soldier/site2.wav");
	precache_sound ("doom_soldier/site3.wav");
	precache_sound ("soldier/pain2.wav");
	precache_sound ("soldier/sattck1.wav");
	precache_sound ("soldier/sight1.wav");
	precache_sound ("weapons/shotgun.wav");
	precache_sound ("action/gibs.wav");
	precache_sound ("player/udeath.wav");
	MTF_Setup_Monster_Presets ( 0, "Doom Sargeant", monster_sargeant1 );
};
//END
