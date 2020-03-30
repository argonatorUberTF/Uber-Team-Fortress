void () dbaron_slash1;
void () dbaron_PreFireBall;
void () dbaron_Slash;
void () dbaron_atk1;

void () dbaron_check_frame =
{
	if (self.frame >= 0 && self.frame <= 17)			/* idle */
	{

		
	}
	else if (self.frame >= 39 && self.frame <=  54)  	/* walk and run */
	{
	}
	else if (self.frame >= 55 && self.frame <=  58)  	/* attacking */
	{
	}
	else if (self.frame >= 17 && self.frame <=  32)  	/* death */
	{
	}
	else if (self.frame >= 33 && self.frame <=  38)  	/* pain */
	{
	}
	self.oframe = self.frame;
	doom_ai_sprite_orient(48);
	self.nextthink = time + 0.1;
};

void () dbaron_stand1 = [ 0, dbaron_stand2 ]
{
	dbaron_check_frame();
	ai_stand (); 

};

void () dbaron_stand2 = [ 8, dbaron_stand3 ]
{
	dbaron_check_frame();
	ai_stand (); 
};

void () dbaron_stand3 = [ 16, dbaron_stand4 ]
{
	dbaron_check_frame();
	ai_stand (); 
};

void () dbaron_stand4 = [ 24, dbaron_stand5 ]
{
	dbaron_check_frame();
	ai_stand (); 
};

void () dbaron_stand5 = [ 16, dbaron_stand6 ]
{
	dbaron_check_frame();
	ai_stand (); 
};

void () dbaron_stand6 = [ 8, dbaron_stand1 ]
{
	dbaron_check_frame();
	ai_stand (); 
};



void () dbaron_walk1 = [ 0, dbaron_walk2 ]
{
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_knight/nearby.wav", TRUE, ATTN_IDLE);
	}

	dbaron_check_frame();
	ai_walk (5 + TRUE); 
};

void () dbaron_walk2 = [ 8, dbaron_walk3 ]
{
	dbaron_check_frame();
	ai_walk (5 + TRUE); 
};

void () dbaron_walk3 = [ 16, dbaron_walk4 ]
{
dbaron_check_frame();
	ai_walk (5 + TRUE); 
};

void () dbaron_walk4 = [ 24, dbaron_walk5 ]
{
dbaron_check_frame();
	ai_walk (5 + TRUE); 
};

void () dbaron_walk5 = [ 16, dbaron_walk6 ]
{
dbaron_check_frame();
	ai_walk (5 + FL_SWIM); 
};

void () dbaron_walk6 = [ 8, dbaron_walk1 ]
{
dbaron_check_frame();
	ai_walk (5 + MOVETYPE_WALK); 
};


void () dbaron_run1 = [ 0, dbaron_run2 ]
{
	dbaron_check_frame();
	ai_run (10 + FL_SWIM); 
};

void () dbaron_run2 = [ 8, dbaron_run3 ]
{
dbaron_check_frame();
	ai_run (10 + MOVETYPE_FLY); 
	 
};

void () dbaron_run3 = [ 16, dbaron_run4 ]
{
dbaron_check_frame();
	ai_run (10 + MOVETYPE_STEP); 
	 
};

void () dbaron_run4 = [ 24, dbaron_run1 ]
{
dbaron_check_frame();
	ai_run (10 + MOVETYPE_WALK); 
	 
};

void () dbaron_run5 = [ 16, dbaron_run6 ]
{
dbaron_check_frame();
	ai_run (10 + MOVETYPE_STEP); 
	 
};

void () dbaron_run6 = [ 8, dbaron_run1 ]
{
dbaron_check_frame();
	ai_run (10 + MOVETYPE_STEP); 
	
};
void () baronFire_Touch =
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
	sound (self, CHAN_WEAPON, "doom_imp/hit.wav", TRUE, ATTN_STATIC);
	org = (self.origin - (FL_CLIENT * normalize (self.velocity)));
	if ((other.classname == "monster_dbaron"))
	{
		return;
	}
	if (other.health)
	{
		SpawnBlood (org, 15);
		T_Damage (other, self, self.owner, 15);
	}
	remove (self);
};

void (vector org, vector vec) dbaron_FireBall =
{
	if ((self.classname == "monster_dbaron"))
	{
		sound (self, CHAN_WEAPON, "doom_imp/fire.wav", TRUE, ATTN_NORM);
	}
	vec = normalize (vec);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	setmodel (newmis, "sprites/doom/baron_ball_s.spr");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);
	newmis.velocity = (vec * 500);
	newmis.angles = vectoangles (newmis.velocity);
	newmis.classname = "green";
	newmis.nextthink = (time + MOVETYPE_FLY);
	newmis.think = SUB_Remove;
	newmis.touch = baronFire_Touch;
	self.attack_finished = (time + TRUE);
};

void () dbaron_PreFireBall =
{
	local vector org;
	org = (((self.origin + (v_forward * MOVETYPE_BOUNCE)) + (v_right * -10)) + '0 0 30');
	dbaron_FireBall (org, (self.enemy.origin - self.origin));
};

void () dbaron_fire =
{

	makevectors (self.angles);
	traceline ((self.origin + '0 0 16'), ((self.origin + '0 0 16') + (v_forward * 34)), FALSE, self);
	if (trace_ent.takedamage)
	{
		dbaron_slash1 ();
	}
	else
	{
		dbaron_atk1 ();
	}
};


void () dbaron_atk1 = [ 32, dbaron_atk2 ]
{
dbaron_check_frame();
	ai_face (); 
};

void () dbaron_atk2 = [ 32, dbaron_atk3 ]
{
dbaron_check_frame();
	ai_face (); 
};

void () dbaron_atk3 = [ 40, dbaron_atk4 ]
{
dbaron_check_frame();
	ai_face (); 
};

void () dbaron_atk4 = [ 48, dbaron_atk5 ]
{
	dbaron_check_frame();
	ai_face ();
	dbaron_PreFireBall ();
};

void () dbaron_atk5 = [ 48, dbaron_atk6 ]
{
	dbaron_check_frame();
	ai_face (); 
};

void () dbaron_atk6 = [ 56, dbaron_run1 ]
{
	dbaron_check_frame();
	ai_face (); 
};

void () dbaron_Slash =
{
	local float Idmg;
	sound (self, CHAN_WEAPON, "doom_knight/claw.wav", TRUE, ATTN_STATIC);
	Idmg = ((random () * MOVETYPE_BOUNCE) + 14);
	T_Damage (self.enemy, self, self, Idmg);
};

void () dbaron_slash1 = [ 32, dbaron_slash2 ]
{
	dbaron_check_frame();
	ai_face (); 
};

void () dbaron_slash2 = [ 40, dbaron_slash3 ]
{
	dbaron_check_frame();
	ai_face (); 
};

void () dbaron_slash3 = [ 48, dbaron_slash4 ]
{
	dbaron_Slash ();
	dbaron_check_frame();
	ai_face (); 
};

void () dbaron_slash4 = [ 48, dbaron_run1 ]
{
	ai_face (); 
};


void () dbaron_pain1 = [ 56, dbaron_pain2 ]
{
	dbaron_check_frame();
};

void () dbaron_pain2 = [ 56, dbaron_run1 ]
{
	dbaron_check_frame();
};

void () dbaron_run =
{
	sound (self, CHAN_VOICE, "doom_knight/site.wav", TRUE, ATTN_IDLE);
	dbaron_run1 ();
};

void (entity attacker, float damage) dbaron_pain =
{
	local float r;
	r = random ();
	if ((self.pain_finished > time))
	{
		return;
	}
	
	dbaron_pain1 ();
	sound (self, CHAN_VOICE, "doom_knight/pain.wav", TRUE, ATTN_NORM);
};

void () dbaron_die1 = [ 57, dbaron_die2 ]
{
dbaron_check_frame();
	self.solid = SOLID_NOT;
	self.ammo_nails = MOVETYPE_FLY;
	DropClip (); 
};

void () dbaron_die2 = [ 58, dbaron_die3 ]
{
dbaron_check_frame();
};

void () dbaron_die3 = [ 59, dbaron_die4 ]
{
dbaron_check_frame();
};

void () dbaron_die4 = [ 60, dbaron_die5 ]
{
dbaron_check_frame();
};

void () dbaron_die5 = [ 61, dbaron_die6 ]
{
dbaron_check_frame();
};

void () dbaron_die6 = [ 62, dbaron_die7 ]
{
dbaron_check_frame();
};

void () dbaron_die7 = [ 63, dbaron_die7 ]
{
dbaron_check_frame();
};


void () dbaron_die =
{
	sound (self, CHAN_VOICE, "doom_knight/die.wav", TRUE, ATTN_NORM);
	dbaron_die1 ();
};

void () monster_dbaron1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/baron.spr");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.classname = "monster_dbaron";
	self.health = 700;
	self.th_stand = dbaron_stand1;
	self.th_walk = dbaron_walk1;
	self.th_run = dbaron_run;
	self.th_missile = dbaron_fire;
	self.th_pain = dbaron_pain;
	self.th_die = dbaron_die;
	
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};

void () monster_dbaron =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/baron_ball_s.spr");
	precache_model ("sprites/doom/baron.spr");
	precache_sound ("doom_knight/claw.wav");
	precache_sound ("doom_knight/die.wav");
	precache_sound ("doom_knight/nearby.wav");
	precache_sound ("doom_knight/pain.wav");
	precache_sound ("doom_knight/site.wav");
	precache_sound ("soldier/pain2.wav");
	precache_sound ("soldier/sattck1.wav");
	precache_sound ("soldier/sight1.wav");
	precache_sound ("doom_imp/die2.wav");
	precache_sound ("doom_imp/hit.wav");
	precache_sound ("doom_imp/fire.wav");
	precache_sound ("doom_imp/claw.wav");
	precache_sound ("action/gibs.wav");
	MTF_Setup_Monster_Presets ( 0, "Baron of Hell", monster_dbaron1 );
};
//END
