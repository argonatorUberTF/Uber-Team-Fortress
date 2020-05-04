void () lsoul_atk1;
void () lsoul_check_frame =
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
	doom_ai_sprite_orient(32);
	self.nextthink = time + 0.1;
};
void () lsoul_stand1 = [ 0, lsoul_stand2 ]
{
	if ((random () < 0.1))
	{
		sound (self, CHAN_VOICE, "doom_pinky/nearby.wav", TRUE, ATTN_IDLE);
	}
	lsoul_check_frame();
	ai_stand (); 
};
void () lsoul_stand2 = [ 8, lsoul_stand1 ]
{
	lsoul_check_frame();
	ai_stand (); 
};
void () lsoul_walk1 = [ 0, lsoul_walk2 ]
{
	if ((random () < 0.4))
	{
		sound (self, CHAN_VOICE, "doom_pinky/nearby.wav", TRUE, ATTN_IDLE);
	}
	lsoul_check_frame();
	ai_walk (5 + TRUE); 
};
void () lsoul_walk2 = [ 8, lsoul_walk1 ]
{
	lsoul_check_frame();
	ai_walk (5 + TRUE); 
};
void () lsoul_run1 = [ 0, lsoul_run2 ]
{
	lsoul_check_frame();
	ai_run (10 + FL_SWIM); 
};
void () lsoul_run2 = [ 8, lsoul_run1 ]
{
	lsoul_check_frame();
	ai_run (10 + FL_SWIM); 
};
void()	Sol_JumpTouch =
{
	local	float	ldmg;
	if (self.health <= 0)
		return;
	if (other.takedamage) //lost soul hit a target that can be damaged
	{
		if ( vlen(self.velocity) > 300 )
		{
			ldmg = 10 + 5*random();
			T_Damage (other, self, self, ldmg);	
		}
	}
	self.velocity = '0 0 0'; //set velocity to 0 after the monster has hit something. (it doesn't matter what it hit, the important thing is that velocity is 0 0 0 when AI takes over again.
	self.movetype = MOVETYPE_STEP; //go back to movetype_step movement for monster AI
	self.touch = SUB_Null; //reset touch function to nothing
	self.think = lsoul_run1; //break out of the charge loop
	self.nextthink = time + 0.1;
};
void () lsoul_charge =
{
	local	vector	vec;
	ai_face();
	self.touch = Sol_JumpTouch; //set touch function
	self.movetype = MOVETYPE_FLYMISSILE; //make this movetype_flymissile so it can fly at the enemy
	self.pos2 = vec = normalize(self.enemy.origin - self.origin);
	self.velocity = vec * 500; //this is what i was talking about in the post.
	self.dest1 = '0 0 0';
	self.frame = 16;
	self.think = lsoul_atk1;
	lsoul_check_frame();
};
void () lsoul_atk1 = [ 16, lsoul_atk2 ]
{
	lsoul_check_frame();
};
void () lsoul_atk2 = [ 16, lsoul_atk3 ]
{
	lsoul_check_frame();
};
void () lsoul_atk3 = [ 24, lsoul_atk3 ]
{		
	if (!self.dest1)
		self.dest1 = self.origin;
	self.dest2 = self.origin;
		
	if (self.dest1 == self.dest2) {
		self.movetype = MOVETYPE_STEP; //go back to movetype_step movement for monster AI
		self.touch = SUB_Null; //reset touch function to nothing
		self.think = lsoul_run1; //break out of the charge loop
	}
	self.dest1 = self.origin;
	lsoul_check_frame();
};
void () lsoul_pain1 = [ 24, lsoul_pain2 ]
{
	lsoul_check_frame();
};
void () lsoul_pain2 = [ 24, lsoul_pain3 ]
{
	lsoul_check_frame();
};
void () lsoul_pain3 = [ 32, lsoul_run1 ]
{
	lsoul_check_frame();
};
void() soul_bite =
{
local vector	delta;
local float 	ldmg;
	if (!self.enemy)
		return;
		ai_face ();
	walkmove (self.ideal_yaw, 12);	/* allow a little closing */
	delta = self.enemy.origin - self.origin;
	if (vlen(delta) > 100)
		return;
	ldmg = 10 + 5*random();
	T_Damage (self.enemy, self, self, ldmg);
};
void () lsoul_bite = [ 16, lsoul_bite2 ]
{
	lsoul_check_frame();
};
void () lsoul_bite2 = [ 24, lsoul_bite3 ]
{
	soul_bite();
	lsoul_check_frame();
};
void () lsoul_bite3 = [ 24, lsoul_bite4 ]
{
	lsoul_check_frame();
};
void () lsoul_bite4 = [ 16, lsoul_run1 ]
{
	lsoul_check_frame();
};
void () lsoul_run =
{
	lsoul_run1 ();
};
void (entity attacker, float damage) lsoul_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + MOVETYPE_WALK);
	lsoul_pain1 ();
	sound (self, CHAN_VOICE, "doom_pinky/pain.wav", TRUE, ATTN_NORM);
};
void () lsoul_die1 = [ 33, lsoul_die2 ]
{
	self.solid = SOLID_NOT;
	sound (self, CHAN_VOICE, "doom_lsoul/die.wav", TRUE, ATTN_NORM);
lsoul_check_frame();
};
void () lsoul_die2 = [ 34, lsoul_die3 ]
{
lsoul_check_frame();
};
void () lsoul_die3 = [ 35, lsoul_die4 ]
{
lsoul_check_frame();
};
void () lsoul_die4 = [ 36, lsoul_die5 ]
{
lsoul_check_frame();
};
void () lsoul_die5 = [ 37, lsoul_die6 ]
{
lsoul_check_frame();
};
void () lsoul_die6 = [ 38, lsoul_die7 ]
{
lsoul_check_frame();
};
void () lsoul_die7 = [ 39, lsoul_die7 ]
{
lsoul_check_frame();
};
void () monster_lsoul1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/lostsoul.spr");
	self.classname = "monster_lsoul";
	setsize (self, '0 0 0', '16 16 30');
	self.health = 200;
	self.th_stand = lsoul_walk1;
	self.th_walk = lsoul_walk1;
	self.th_run = lsoul_run;
	self.th_missile = lsoul_charge;
	self.th_melee = lsoul_bite;
	self.th_pain = lsoul_pain;
	self.th_die = lsoul_die1;
	MTF_Setup_Monster_Postsets( self.health, coop_flymonster_start);
};
void () monster_lsoul =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/lostsoul.spr");
	precache_sound ("doom_pinky/nearby.wav");
	precache_sound ("doom_pinky/pain.wav");
	precache_sound ("doom_lsoul/die.wav");
	MTF_Setup_Monster_Presets ( 0, "Lost Soul", monster_lsoul1 );
};
//END
