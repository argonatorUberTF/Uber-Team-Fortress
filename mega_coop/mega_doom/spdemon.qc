void () spdemon_fire;
void () spdemon_check_frame =
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
	doom_ai_sprite_orient(40);
	self.nextthink = time + 0.1;
};
void () spdemon_stand1 = [ 0, spdemon_stand2 ]
{
	spdemon_check_frame();
	ai_stand (); 
	self.nextthink = time + 0.25;
};
void () spdemon_stand2 = [ 8, spdemon_stand3 ]
{
	spdemon_check_frame();
	ai_stand (); 
	self.nextthink = time + 0.25;
};
void () spdemon_stand3 = [ 16, spdemon_stand4 ]
{
	spdemon_check_frame();
	ai_stand (); 
	self.nextthink = time + 0.25;
};
void () spdemon_stand4 = [ 8, spdemon_stand1 ]
{
	spdemon_check_frame();
	ai_stand (); 
	self.nextthink = time + 0.25;
};
void () spdemon_walk1 = [ 0, spdemon_walk2 ]
{
	spdemon_check_frame();
	if ((random () < 0.2))
	{
		sound (self, CHAN_VOICE, "doom_arach/nearby.wav", TRUE, ATTN_IDLE);
	}
	ai_walk (45 + TRUE); 
};
void () spdemon_walk2 = [ 0, spdemon_walk3 ]
{
	spdemon_check_frame();
	ai_walk (45 + TRUE); 
};
void () spdemon_walk3 = [ 8, spdemon_walk4 ]
{
	sound (self, CHAN_VOICE, "doom_spider/walk.wav", TRUE, ATTN_IDLE);
	spdemon_check_frame();
	ai_walk (45 + TRUE); 
};
void () spdemon_walk4 = [ 8, spdemon_walk5 ]
{
	spdemon_check_frame();
	ai_walk (45 + TRUE); 
};
void () spdemon_walk5 = [ 16, spdemon_walk6 ]
{
	spdemon_check_frame();
	ai_walk (5 + FL_SWIM); 
};
void () spdemon_walk6 = [ 16, spdemon_walk7 ]
{
	spdemon_check_frame();
	ai_walk (5 + MOVETYPE_WALK); 
};
void () spdemon_walk7 = [ 8, spdemon_walk8 ]
{
	spdemon_check_frame();
	ai_walk (5 + MOVETYPE_WALK); 
	sound (self, CHAN_VOICE, "doom_spider/walk.wav", TRUE, ATTN_IDLE);
};
void () spdemon_walk8 = [ 8, spdemon_walk1 ]
{
	spdemon_check_frame();
	ai_walk (5 + MOVETYPE_WALK); 
};
void () spdemon_run1 = [ 0, spdemon_run2 ]
{
	spdemon_check_frame();
	ai_run (45 + TRUE); 
};
void () spdemon_run2 = [ 0, spdemon_run3 ]
{
	spdemon_check_frame();
	ai_run (45 + TRUE); 
};
void () spdemon_run3 = [ 8, spdemon_run4 ]
{
	sound (self, CHAN_VOICE, "doom_spider/walk.wav", TRUE, ATTN_IDLE);
	spdemon_check_frame();
	ai_run (45 + TRUE); 
};
void () spdemon_run4 = [ 8, spdemon_run5 ]
{
	spdemon_check_frame();
	ai_run (45 + TRUE); 
};
void () spdemon_run5 = [ 16, spdemon_run6 ]
{
	spdemon_check_frame();
	ai_run (45 + FL_SWIM); 
};
void () spdemon_run6 = [ 16, spdemon_run7 ]
{
	spdemon_check_frame();
	ai_run (45 + MOVETYPE_WALK); 
};
void () spdemon_run7 = [ 8, spdemon_run8 ]
{
	spdemon_check_frame();
	ai_run (45 + MOVETYPE_WALK); 
	sound (self, CHAN_VOICE, "doom_spider/walk.wav", TRUE, ATTN_IDLE);
};
void () spdemon_run8 = [ 8, spdemon_run1 ]
{
	spdemon_check_frame();
	ai_run (45 + MOVETYPE_WALK); 
};
void () spdemon_run =
{
	sound (self, CHAN_VOICE, "doom_spider/site.wav", TRUE, ATTN_IDLE);
	spdemon_run1 ();
};
void () spdemon_atk1 = [ 24, spdemon_atk2 ]
{
	spdemon_check_frame();
	ai_face (); 
};
void () spdemon_atk2 = [ 24, spdemon_atk3 ]
{
	ai_face (); 
	spdemon_check_frame();
};
void () spdemon_atk3 = [ 32, spdemon_atk4 ]
{
	spdemon_check_frame();
	ai_face (); 
	spdemon_fire ();
};
void () spdemon_atk4 = [ 24, spdemon_atk5 ]
{
	spdemon_check_frame();
	ai_face (); 
};
void () spdemon_atk5 = [ 32, spdemon_atk6 ]
{
	spdemon_check_frame();
	ai_face (); 
	spdemon_fire ();
};
void () spdemon_atk6 = [ 24, spdemon_atk7 ]
{
	spdemon_check_frame();
	ai_face (); 
};
void () spdemon_atk7 = [ 32, spdemon_atk8 ]
{
	spdemon_check_frame();
	ai_face (); 
	spdemon_fire ();
};
void () spdemon_atk8 = [ 24, spdemon_run1 ]
{
	spdemon_check_frame();
	ai_face (); 
};
void () spdemon_pain1 = [ 40, spdemon_pain2 ]
{
	spdemon_check_frame();
};
void () spdemon_pain2 = [ 40, spdemon_pain3 ]
{
	spdemon_check_frame();
};
void () spdemon_pain3 = [ 40, spdemon_run1 ]
{
	spdemon_check_frame();
};
void (entity attacker, float damage) spdemon_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	spdemon_pain1 ();
	self.pain_finished = (time + MOVETYPE_WALK);
};
void () spdemon_fire =
{
	local vector dir;
	local entity en;
	ai_face ();
	if (!visible (self.enemy))
	{
		spdemon_run1 ();
	}
	else
	{
		sound (self, CHAN_WEAPON, "weapons/shotgun.wav", TRUE, ATTN_NORM);
		en = self.enemy;
		dir = en.origin;
		dir = normalize ((dir - self.origin));
		FireBullets (8, dir, '0.1 0.1 0');
	}
};
void () spdemon_die1 = [ 48, spdemon_die2 ]
{
	spdemon_check_frame();
};
void () spdemon_die2 = [ 49, spdemon_die3 ]
{
	spdemon_check_frame();
};
void () spdemon_die3 = [ 50, spdemon_die4 ]
{
	spdemon_check_frame();
};
void () spdemon_die4 = [ 51, spdemon_die5 ]
{
	spdemon_check_frame();
};
void () spdemon_die5 = [ 52, spdemon_die6 ]
{
	spdemon_check_frame();
};
void () spdemon_die6 = [ 53, spdemon_die7 ]
{
	spdemon_check_frame();
};
void () spdemon_die7 = [ 54, spdemon_die8 ]
{
	spdemon_check_frame();
};
void () spdemon_die8 = [ 55, spdemon_die9 ]
{
spdemon_check_frame();
};
void () spdemon_die9 = [ 56, spdemon_die10 ]
{
	spdemon_check_frame();
};
void () spdemon_die10 = [ 57, spdemon_die10 ]
{
	spdemon_check_frame();
};
void () spdemon_die =
{
	sound (self, CHAN_VOICE, "doom_spider/die.wav", TRUE, ATTN_NORM);
	self.solid = SOLID_NOT;
	spdemon_die1();
};
void () monster_spdemon1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/spdemon.spr");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 10000;
	self.lives = 0;
	self.th_stand = spdemon_stand1;
	self.th_walk = spdemon_walk1;
	self.th_run = spdemon_run;
	self.th_missile = spdemon_atk1;
	self.th_pain = spdemon_pain;
	self.th_die = spdemon_die;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () monster_spdemon =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/spdemon.spr");
	precache_sound ("weapons/dsfirxpl.wav");
	precache_sound ("weapons/dsplasma.wav");
	precache_sound ("doom_spider/die.wav");
	precache_sound ("doom_arach/nearby.wav");
	precache_sound ("doom_spider/site.wav");
	precache_sound ("doom_spider/walk.wav");
	precache_sound ("weapons/shotgun.wav");
	self.origin_z+= 100;
	self.origin_x+= 100;
	MTF_Setup_Monster_Presets ( 0, "Spider Mastermind", monster_spdemon1 );
};
//END
