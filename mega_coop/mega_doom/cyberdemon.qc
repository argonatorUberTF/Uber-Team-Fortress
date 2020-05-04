void () cdemon_slash1;
void () cdemon_check_frame =
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
	doom_ai_sprite_orient(48);
	self.nextthink = time + 0.1;
};
void () cdemon_stand1 = [ 0, cdemon_stand2 ]
{
	cdemon_check_frame();
	ai_stand (); 
};
void () cdemon_stand2 = [ 8, cdemon_stand3 ]
{
	cdemon_check_frame();
	ai_stand (); 
};
void () cdemon_stand3 = [ 16, cdemon_stand4 ]
{
	cdemon_check_frame();
	ai_stand (); 
};
void () cdemon_stand4 = [ 24, cdemon_stand5 ]
{
	cdemon_check_frame();
	ai_stand (); 
};
void () cdemon_stand5 = [ 16, cdemon_stand6 ]
{
	cdemon_check_frame();
	ai_stand (); 
};
void () cdemon_stand6 = [ 8, cdemon_stand1 ]
{
	cdemon_check_frame();
	ai_stand (); 
};
void () cdemon_walk1 = [ 0, cdemon_walk2 ]
{
cdemon_check_frame();
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_cdemon/idle.wav", TRUE, ATTN_IDLE);
	}
	ai_walk (5 + TRUE); 
};
void () cdemon_walk2 = [ 8, cdemon_walk3 ]
{
cdemon_check_frame();
	ai_walk (5 + TRUE); 
	sound (self, CHAN_WEAPON, "doom_cyber/cybmet.wav", TRUE, ATTN_NORM);
};
void () cdemon_walk3 = [ 16, cdemon_walk4 ]
{
cdemon_check_frame();
	ai_walk (5 + TRUE); 
};
void () cdemon_walk4 = [ 24, cdemon_walk5 ]
{
cdemon_check_frame();
	ai_walk (5 + TRUE); 
};
void () cdemon_walk5 = [ 16, cdemon_walk6 ]
{
cdemon_check_frame();
	ai_walk (5 + FL_SWIM); 
	sound (self, CHAN_WEAPON, "doom_cyber/cybhoof.wav", TRUE, ATTN_NORM);
};
void () cdemon_walk6 = [ 8, cdemon_walk1 ]
{
cdemon_check_frame();
	ai_walk (5 + MOVETYPE_WALK); 
};
void () cdemon_run1 = [ 0, cdemon_run2 ]
{
cdemon_check_frame();
	ai_run (20 + FL_SWIM); 
};
void () cdemon_run2 = [ 8, cdemon_run3 ]
{
sound (self, CHAN_WEAPON, "doom_cyber/cybmet.wav", TRUE, ATTN_NORM);	
cdemon_check_frame();
	ai_run (20 + MOVETYPE_FLY); 
	 
};
void () cdemon_run3 = [ 16, cdemon_run4 ]
{
cdemon_check_frame();
	ai_run (20 + MOVETYPE_STEP); 
	 
};
void () cdemon_run4 = [ 24, cdemon_run1 ]
{
cdemon_check_frame();
	ai_run (20 + MOVETYPE_WALK); 
	 
};
void () cdemon_run5 = [ 16, cdemon_run6 ]
{
sound (self, CHAN_WEAPON, "doom_cyber/cybhoof.wav", TRUE, ATTN_NORM);
cdemon_check_frame();
	ai_run (20 + MOVETYPE_STEP); 
};
void () cdemon_run6 = [ 8, cdemon_run1 ]
{
cdemon_check_frame();
	ai_run (20 + MOVETYPE_STEP); 
};
void () cdemon_atk1 = [ 32, cdemon_atk2 ]
{
cdemon_check_frame();
	ai_face (); 
};
void () cdemon_atk2 = [ 32, cdemon_atk3 ]
{
cdemon_check_frame();
	ai_face (); 
	CyberDemonFireMissile ();
};
void () cdemon_atk3 = [ 40, cdemon_atk4 ]
{
cdemon_check_frame();
	ai_face (); 
};
void () cdemon_atk4 = [ 40, cdemon_run1 ]
{
	cdemon_check_frame();
	ai_face ();
};
void () cdemon_Slash =
{
	local vector delta;
	local float Idmg;
	if ((self.attack_finished > time))
	{
		return;
	}
	ai_charge (MOVETYPE_BOUNCE);
	if (!self.enemy)
	{
		return;
	}
	delta = (self.enemy.origin - self.origin);
	sound (self, CHAN_WEAPON, "doom_cdemon/claw.wav", TRUE, ATTN_STATIC);
	Idmg = 60 + ((random () * MOVETYPE_BOUNCE) + MOVETYPE_FLY + 10);
	T_Damage (self.enemy, self, self, Idmg);
	self.attack_finished = (time + 0.3);
	SUB_CheckRefire (cdemon_slash1);
};
void () cdemon_slash1 = [ 32, cdemon_slash2 ]
{
	cdemon_check_frame();
	ai_face (); 
};
void () cdemon_slash2 = [ 40, cdemon_slash3 ]
{
	cdemon_check_frame();
	ai_face (); 
};
void () cdemon_slash3 = [ 40, cdemon_slash4 ]
{
	cdemon_Slash ();
	cdemon_check_frame();
	ai_face (); 
};
void () cdemon_slash4 = [ 32, cdemon_run1 ]
{
	ai_face (); 
	cdemon_check_frame();
};
void () cdemon_run =
{
	cdemon_run1 (); 
};
void () cdemon_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	if ((random () < 0.1))
	{
		sound (self, CHAN_VOICE, "doom_cyber/cybpain.wav", TRUE, ATTN_NORM);
	}
	self.pain_finished = (time + FL_SWIM);
	self.frame = 48;
	cdemon_check_frame();
};
void () cdemon_die1 = [ 49, cdemon_die2 ]
{
cdemon_check_frame();
	self.solid = SOLID_NOT;
	self.ammo_nails = MOVETYPE_FLY;
	DropClip (); 
};
void () cdemon_die2 = [ 50, cdemon_die3 ]
{
cdemon_check_frame();
};
void () cdemon_die3 = [ 51, cdemon_die4 ]
{
cdemon_check_frame();
};
void () cdemon_die4 = [ 52, cdemon_die5 ]
{
cdemon_check_frame();
};
void () cdemon_die5 = [ 53, cdemon_die6 ]
{
cdemon_check_frame();
};
void () cdemon_die6 = [ 54, cdemon_die7 ]
{
cdemon_check_frame();
};
void () cdemon_die7 = [ 55, cdemon_die8 ]
{
cdemon_check_frame();
};
void () cdemon_die8 = [ 56, cdemon_die9 ]
{
cdemon_check_frame();
};
void () cdemon_die9 = [ 57, cdemon_die9 ]
{
cdemon_check_frame();
};
void () cdemon_die =
{
	sound (self, MOVETYPE_PUSH, "doom_cyber/cybdie.wav", TRUE, ATTN_NORM);
	cdemon_die1 ();
};
void () monster_cdemon1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/cdemon.spr");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 8000;
	self.th_stand = cdemon_stand1;
	self.th_walk = cdemon_walk1;
	self.th_run = cdemon_run1;
	self.th_die = cdemon_die;
	self.th_melee = cdemon_slash1;
	self.th_missile = cdemon_atk1;
	self.th_pain = cdemon_pain;
	self.lives = 0;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () monster_cdemon =
{
	precache_model ("sprites/doom/cdemon.spr");
	precache_model ("progs/missile.mdl");
	precache_sound ("doom_cyber/cybsee.wav");
	precache_sound ("doom_cyber/cybdie.wav");
	precache_sound ("doom_cyber/cybhoof.wav");
	precache_sound ("doom_cyber/cybpain.wav");
	precache_sound ("doom_cyber/cybmet.wav");
	precache_sound ("doom_cyber/cybfire.wav");
	precache_sound ("doom_cyber/boom.wav");
	precache_sound ("doom_cyber/servo.wav");
	self.origin_z+= 100;
	self.origin_x+= 100;
	MTF_Setup_Monster_Presets ( 0, "Cyber Demon", monster_cdemon1 );
};
//END
