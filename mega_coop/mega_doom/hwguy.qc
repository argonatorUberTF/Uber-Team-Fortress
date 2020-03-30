void () hgunner_check_frame =
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


void () hgunner_stand1 = [ 0, hgunner_stand1 ]
{
	if (self.cells_bonus < 2)
		self.frame = 0;
	else if (self.cells_bonus < 4)
		self.frame = 8;
	else if (self.cells_bonus < 6)
		self.frame = 16;
	else if (self.cells_bonus < 8)
		self.frame = 24;
	else {
		self.frame = 0;
		self.cells_bonus = 0;
	}
	
	ai_stand (); 
	
	if (random () < 0.07)
		sound (self, CHAN_VOICE, "doom_other/dsposact.wav", TRUE, ATTN_IDLE);

	self.cells_bonus++;
	hgunner_check_frame();
	ai_stand (); 
};

void () hgunner_stand =
{
	self.cells_bonus = 0;
	hgunner_stand1();
};


void () hgunner_walk1 = [ 0, hgunner_walk1 ]
{
	if (self.cells_bonus < 2)
		self.frame = 0;
	else if (self.cells_bonus < 4)
		self.frame = 8;
	else if (self.cells_bonus < 6)
		self.frame = 16;
	else if (self.cells_bonus < 8)
		self.frame = 24;
	else {
		self.frame = 0;
		self.cells_bonus = 0;
	}
	
	self.cells_bonus++;
	
	hgunner_check_frame();
	ai_walk (5 + TRUE); 
};

void () hgunner_walk =
{
	self.cells_bonus = 0;
	hgunner_walk1();
};


void () hgunner_run1 = [ 0, hgunner_run1 ]
{
	if (self.cells_bonus < 2)
		self.frame = 0;
	else if (self.cells_bonus < 4)
		self.frame = 8;
	else if (self.cells_bonus < 6)
		self.frame = 16;
	else if (self.cells_bonus < 8)
		self.frame = 24;
	else {
		self.frame = 0;
		self.cells_bonus = 0;
	}
	
	self.cells_bonus++;
	
	hgunner_check_frame();
	ai_run (10); 
};

void () hgunner_run =
{
	local float r;
	r = random ();
	if (r < 0.36)
		sound (self, CHAN_VOICE, "doom_other/dsposit1.wav", TRUE, ATTN_IDLE);
	else
		if (r < 0.67)
			sound (self, CHAN_VOICE, "doom_other/dsposit2.wav", TRUE, ATTN_IDLE);
		else
			if (r < TRUE)
				sound (self, CHAN_VOICE, "doom_other/dsposit3.wav", TRUE, ATTN_IDLE);

	self.cells_bonus = 0;
	hgunner_run1();
};


void () hgunner_fire =
{
	local vector dir;
	local entity en;
	ai_face ();
	sound (self, CHAN_WEAPON, "doom_other/dsshotgn.wav", TRUE, ATTN_NORM);
	en = self.enemy;
	dir = (en.origin - (en.velocity * 0.2));
	dir = normalize ((dir - self.origin));
	FireBullets (3, dir, '0.1 0.1 0');
	self.attack_finished = (time + 1.6);
};

void () hgunner_atk1 = [ 32, hgunner_atk1 ]
{
	ai_face ();
	if (self.cells_bonus < 2)
		self.frame = 32;
	else if (self.cells_bonus >=2) {
		if (coop_visible(self, self.enemy) && self.enemy.health >= 1) {
			self.frame = 40;
			hgunner_fire();
			self.cells_bonus = 0;
		}
		else {
			hgunner_run();
			return;
		}	
	}
	self.cells_bonus++;
	hgunner_check_frame();
};

void () hgunner_atk =
{
	self.cells_bonus = 0;
	hgunner_atk1();
};

void () hgunner_pain1 = [ 0, hgunner_pain1 ]
{
	if (self.cells_bonus < 2)
		self.frame = 48;
	else {
		self.frame = 0;
		self.cells_bonus = 0;
		hgunner_run();
		return;
	}
	self.cells_bonus++;
	hgunner_check_frame();
};

void () hgunner_pain =
{
	if (self.pain_finished > time)
		return;
	sound (self, CHAN_VOICE, "doom_other/dspopain.wav", TRUE, ATTN_NORM);
	self.pain_finished = (time + 2.5);
	self.cells_bonus = 0;
	hgunner_pain1();
};



void () hgunner_die1 = [ 0, hgunner_die1 ]
{
	self.frame = 49 + self.cells_bonus;
	if (self.frame >= 55) {
		self.frame = 55;
		self.cells_bonus = self.cells_bonus - 1;
	}
	
	self.cells_bonus++;
	hgunner_check_frame();
};

void () hgunner_gib1 = [ 0, hgunner_gib1 ]
{
	self.frame = 56 + self.cells_bonus;
	if (self.frame >= 61) {
		self.frame = 61;
		self.cells_bonus = self.cells_bonus - 1;
	}
	
	self.cells_bonus++;
	hgunner_check_frame();
};

void () hgunner_die =
{
	local float r;
	self.cells_bonus = 0;
	self.solid = SOLID_NOT;
	if (self.health < -65) {			// Gib'd
		sound (self, CHAN_VOICE, "doom_other/dsslop.wav", TRUE, ATTN_NORM); 
		hgunner_gib1();
	}
	else {
		r = random ();
		if (r < 0.36)
			sound (self, CHAN_VOICE, "doom_other/dspodth1.wav", TRUE, ATTN_IDLE);
		else
			if (r < 0.67)
				sound (self, CHAN_VOICE, "doom_other/dspodth2.wav", TRUE, ATTN_IDLE);
			else
				if (r < TRUE)
					sound (self, CHAN_VOICE, "doom_other/dspodth3.wav", TRUE, ATTN_IDLE);
	
		hgunner_die1();
	}
};
void () monster_hgunner1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "sprites/doom/cgguy.spr");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = 100;
	self.th_stand = hgunner_stand;
	self.th_walk = hgunner_walk;
	self.th_run = hgunner_run;
	self.th_missile = hgunner_atk;
	self.th_pain = hgunner_pain;
	self.th_die = hgunner_die;
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};

void () monster_hgunner =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("sprites/doom/cgguy.spr");
	
	precache_sound ("doom_other/dsposit3.wav");
	precache_sound ("doom_other/dsposit2.wav");
	precache_sound ("doom_other/dsposit1.wav");
	precache_sound ("doom_other/dspodth1.wav");
	precache_sound ("doom_other/dspodth2.wav");
	precache_sound ("doom_other/dspodth3.wav");
	precache_sound ("doom_other/dspopain.wav");
	precache_sound ("doom_other/dsposact.wav");
	precache_sound ("doom_other/dsshotgn.wav");
	precache_sound ("doom_other/dsslop.wav");
	MTF_Setup_Monster_Presets ( 0, "Heavy Weapon Dude", monster_hgunner1 );
};
//END


