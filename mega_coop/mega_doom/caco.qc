void () caco_check_frame =
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
	doom_ai_sprite_orient(40);
	self.nextthink = time + 0.1;
};
void () caco_stand1 = [ 0, caco_stand1 ]
{
	caco_check_frame();
	ai_stand (); 
};
void () caco_walk1 = [ 0, caco_walk1 ]
{
caco_check_frame();
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_imp/idle.wav", TRUE, ATTN_IDLE);
	}
	ai_walk (5 + TRUE); 
};
void () caco_run1 = [ 0, caco_run1 ]
{
	caco_check_frame();
	ai_run (10 + FL_SWIM); 
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "doom_imp/idle.wav", TRUE, ATTN_IDLE);
	}
};
void () CacoBall_Touch =
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
	sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", TRUE, ATTN_STATIC);
	org = (self.origin - (FL_CLIENT * normalize (self.velocity)));
	if (other.health)
	{
		SpawnBlood (org, 15);
		T_Damage (other, self, self.owner, MOVETYPE_FLY);
	}
	remove (self);
};
void (vector org, vector vec) LaunchCacoBall =
{
	vec = normalize (vec);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	setmodel (newmis, "sprites/doom/impball.spr");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);
	newmis.velocity = (vec * 600);
	newmis.angles = vectoangles (newmis.velocity);
	newmis.nextthink = (time + MOVETYPE_BOUNCE);
	newmis.think = SUB_Remove;
	newmis.touch = CacoBall_Touch;
};
void () caco_fire =
{
	local vector org;
	makevectors (self.angles);
	org = ((((self.origin + (v_forward * SVC_INTERMISSION)) + (v_right * 8.5)) + (v_up * CONTENT_LAVA)) + '0 0 8');
	LaunchCacoBall (org, (self.enemy.origin - self.origin));
};
void () caco_atk1 = [ 8, caco_atk2 ]
{
caco_check_frame();
	ai_face (); 
};
void () caco_atk2 = [ 16, caco_atk3 ]
{
caco_check_frame();
	ai_face (); 
};
void () caco_atk3 = [ 24, caco_atk4 ]
{
	caco_check_frame();
	ai_face (); 
	caco_fire ();
};
void () caco_atk4 = [ 16, caco_run1 ]
{
	caco_check_frame();
	ai_face ();
};
void () caco_pain1 = [ 32, caco_pain2 ]
{
	caco_check_frame();
};
void () caco_pain2 = [ 32, caco_pain3 ]
{
	caco_check_frame();
};
void () caco_pain3 = [ 40, caco_pain4 ]
{
	caco_check_frame();
};
void () caco_pain4 = [ 40, caco_run1 ]
{
	caco_check_frame();
};
void () caco_run =
{
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_caco/site.wav", TRUE, ATTN_IDLE);
	}
	caco_run1 ();
};
void (entity attacker, float damage) caco_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + MOVETYPE_WALK);
	caco_pain1 ();
	sound (self, CHAN_VOICE, "doom_caco/pain.wav", TRUE, ATTN_NORM);
};
void () caco_die1 = [ 41, caco_die2 ]
{
	self.solid = SOLID_NOT;
	self.velocity_x = (-200 + (400 * random ()));
	self.velocity_y = (-200 + (400 * random ()));
	self.velocity_z = (100 + (100 * random ()));
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	sound (self, CHAN_VOICE, "doom_caco/die.wav", TRUE, ATTN_NORM);
caco_check_frame();
};
void () caco_die2 = [ 42, caco_die3 ]
{
caco_check_frame();
};
void () caco_die3 = [ 43, caco_die4 ]
{
caco_check_frame();
};
void () caco_die4 = [ 44, caco_die5 ]
{
caco_check_frame();
};
void () caco_die5 = [ 45, caco_die6 ]
{
caco_check_frame();
};
void () caco_die6 = [ 46, caco_die6 ]
{
caco_check_frame();
};
void () monster_caco1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/caco.spr");
	self.classname = "monster_caco";
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.health = 400;
	self.th_stand = caco_walk1;
	self.th_walk = caco_walk1;
	self.th_run = caco_run;
	self.th_missile = caco_atk1;
	self.th_pain = caco_pain;
	self.th_die = caco_die1;
	MTF_Setup_Monster_Postsets( self.health, coop_flymonster_start);
};
void () monster_caco =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/caco.spr");
	precache_model ("sprites/doom/impball.spr");
	precache_sound ( "doom_imp/idle.wav" );
	precache_sound ("doom_caco/die.wav");
	precache_sound ("doom_caco/site.wav");
	precache_sound ("doom_caco/pain.wav");
	precache_sound ("soldier/pain2.wav");
	precache_sound ("soldier/sattck1.wav");
	precache_sound ("soldier/sight1.wav");
	precache_sound ("player/udeath.wav");
	MTF_Setup_Monster_Presets ( 0, "Cacodemon", monster_caco1 );
};
//END
