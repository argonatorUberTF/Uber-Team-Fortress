void () pinky_fire;
void () pinky_bite;
void () pinky_check_frame =
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
	doom_ai_sprite_orient(56);
	self.nextthink = time + 0.1;
};
void () pinky_stand1 = [ 0, pinky_stand2 ]
{
	pinky_check_frame();
	ai_stand (); 
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_pinky/nearby.wav", TRUE, ATTN_IDLE);
	}
};
void () pinky_stand2 = [ 8, pinky_stand3 ]
{
	pinky_check_frame();
	ai_stand (); 
};
void () pinky_stand3 = [ 16, pinky_stand4 ]
{
	pinky_check_frame();
	ai_stand (); 
};
void () pinky_stand4 = [ 24, pinky_stand5 ]
{
	pinky_check_frame();
	ai_stand (); 
};
void () pinky_stand5 = [ 16, pinky_stand6 ]
{
	pinky_check_frame();
	ai_stand (); 
};
void () pinky_stand6 = [ 8, pinky_stand1 ]
{
	pinky_check_frame();
	ai_stand (); 
};
void () pinky_walk1 = [ 0, pinky_walk2 ]
{
	pinky_check_frame();
	ai_walk (5 + TRUE); 
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_pinky/nearby.wav", TRUE, ATTN_IDLE);
	}
};
void () pinky_walk2 = [ 8, pinky_walk3 ]
{
	pinky_check_frame();
	ai_walk (5 + TRUE); 
};
void () pinky_walk3 = [ 16, pinky_walk4 ]
{
	pinky_check_frame();
	ai_walk (5 + TRUE); 
};
void () pinky_walk4 = [ 24, pinky_walk5 ]
{
	pinky_check_frame();
	ai_walk (5 + TRUE); 
};
void () pinky_walk5 = [ 16, pinky_walk6 ]
{
	pinky_check_frame();
	ai_walk (5 + FL_SWIM); 
};
void () pinky_walk6 = [ 8, pinky_walk1 ]
{
	pinky_check_frame();
	ai_walk (5 + MOVETYPE_WALK); 
};
void () pinky_run1 = [ 0, pinky_run2 ]
{
	pinky_check_frame();
	ai_run (5 + FL_SWIM); 
};
void () pinky_run2 = [ 8, pinky_run3 ]
{
	pinky_check_frame();
	ai_run (5 + MOVETYPE_FLY); 
};
void () pinky_run3 = [ 16, pinky_run4 ]
{
	pinky_check_frame();
	ai_run (5 + MOVETYPE_STEP); 
};
void () pinky_run4 = [ 24, pinky_run1 ]
{
	pinky_check_frame();
	ai_run (5 + MOVETYPE_WALK); 
};
void () pinky_run5 = [ 16, pinky_run6 ]
{
	pinky_check_frame();
	ai_run (5 + MOVETYPE_STEP); 
};
void () pinky_run6 = [ 8, pinky_run1 ]
{
	pinky_check_frame();
	ai_run (5 + MOVETYPE_STEP); 
};
void () pinky_bite1 = [ 32, pinky_bite2 ]
{
	pinky_check_frame();
	ai_charge (FL_CLIENT);
};
void () pinky_bite2 = [ 40, pinky_bite3 ]
{
	ai_charge (FL_CLIENT);
	pinky_check_frame();
};
void () pinky_bite3 = [ 48, pinky_bite4 ]
{
	pinky_check_frame();
	ai_charge (FL_CLIENT);
	pinky_bite ();
};
void () pinky_bite4 = [ 40, pinky_run1 ]
{
	pinky_check_frame();
	ai_face (); 
};
void () pinky_melee =
{
	local vector delta;
	local float Idmg;
	ai_charge (MOVETYPE_BOUNCE);
	if (!self.enemy)
	{
		return;
	}
	delta = (self.enemy.origin - self.origin);
	sound (self, CHAN_WEAPON, "doom_pinky/bite.wav", TRUE, ATTN_STATIC);
	Idmg = ((random () * MOVETYPE_BOUNCE) + MOVETYPE_FLY);
	T_Damage (self.enemy, self, self, Idmg);
	self.attack_finished = (time + 0.8);
	SUB_CheckRefire (pinky_bite1);
};
void () pinky_run =
{
	sound (self, CHAN_VOICE, "doom_pinky/site.wav", TRUE, ATTN_IDLE);
	pinky_run1 ();
};
void () pinky_pain1 = [ 56, pinky_pain2 ]
{
	pinky_check_frame();
};
void () pinky_pain2 = [ 56, pinky_pain3 ]
{
	pinky_check_frame();
};
void () pinky_pain3 = [ 56, pinky_pain4 ]
{
	pinky_check_frame();
};
void () pinky_pain4 = [ 56, pinky_run1 ]
{
	pinky_check_frame();
};
void (entity attacker, float damage) pinky_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 1.5);
	pinky_pain1 ();
	sound (self, CHAN_VOICE, "doom_pinky/pain.wav", TRUE, ATTN_NORM);
};
void () pinky_bite =
{
	local float Idmg;
	local vector delta;
	delta = (self.enemy.origin - self.origin);
	if ((vlen (delta) > 100))
	{
		return;
	}
	sound (self, CHAN_WEAPON, "doom_pinky/bite.wav", TRUE, ATTN_STATIC);
	Idmg = ((random () * MOVETYPE_BOUNCE) + MOVETYPE_FLY);
	T_Damage (self.enemy, self, self, Idmg);
	self.attack_finished = (time + 0.3);
	SUB_CheckRefire (pinky_bite1);
};
void () pinky_fire =
{
	makevectors (self.angles);
	traceline ((self.origin + '0 0 16'), ((self.origin + '0 0 16') + (v_forward * 50)), FALSE, self);
	if (trace_ent.takedamage)
	{
		pinky_bite1 ();
	}
	else
	{
		return;
	}
};
void () pinky_die1 = [ 57, pinky_die2 ]
{
	pinky_check_frame();
	self.solid = SOLID_NOT;
};
void () pinky_die2 = [ 58, pinky_die3 ]
{
	pinky_check_frame();
};
void () pinky_die3 = [ 59, pinky_die4 ]
{
	pinky_check_frame();
};
void () pinky_die4 = [ 60, pinky_die5 ]
{
	pinky_check_frame();
};
void () pinky_die5 = [ 61, pinky_die5 ]
{
pinky_check_frame();
};
void () pinky_die =
{
	sound (self, CHAN_VOICE, "doom_pinky/die.wav", TRUE, ATTN_NORM);
	pinky_die1 ();
};
void () monster_pinky1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	if (self.has_tesla == 1)
		setmodel (self, "sprites/doom/spectre2.spr");
	else
		setmodel (self, "sprites/doom/pinky2.spr");
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.classname = "monster_demon";
	self.health = 150;
	self.th_stand = pinky_stand1;
	self.th_walk = pinky_walk1;
	self.th_run = pinky_run;
	self.th_pain = pinky_pain;
	self.th_die = pinky_die;
	self.th_melee = pinky_bite1;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () monster_pinky =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	if (self.has_tesla == 1)
		precache_model ("sprites/doom/spectre2.spr");
		precache_model ("sprites/doom/pinky2.spr");
	precache_sound ("doom_pinky/bite.wav");
	precache_sound ("doom_pinky/site.wav");
	precache_sound ("doom_pinky/die.wav");
	precache_sound ("doom_pinky/nearby.wav");
	precache_sound ("doom_pinky/pain.wav");
	precache_sound ("doom_imp/hit.wav");
	precache_sound ("doom_imp/fire.wav");
	precache_sound ("doom_imp/claw.wav");
	precache_sound ("action/gibs.wav");
	MTF_Setup_Monster_Presets ( 0, "Pinky", monster_pinky1 );
};
//END
