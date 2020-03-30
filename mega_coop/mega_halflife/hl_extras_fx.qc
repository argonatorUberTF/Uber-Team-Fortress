float total_sparks;			// remember, we're also catering to quakeworld clients here
#define MAX_SPARKS			30
#define SILENT				2

//
//	Written by Frank Condello <pox@planetquake.com>
//	
//	Audio/Visual effect mapping entities, and weapon effects.
//

// SHELLEJECT ==================================================================


// For Shotguns and Super Nailgun
void() eject_shell =
{	
	if (deathmatch || coop)
		return;
	local entity shell;
	shell = spawn ();
	shell.owner = self;
	shell.solid = SOLID_TRIGGER;
	shell.movetype = MOVETYPE_BOUNCE;
	shell.classname = "shell";
	//setmodel (shell, "progs/shell.mdl");		// xav: not used yet
	setsize (shell, VEC_ORIGIN, VEC_ORIGIN);	
	setorigin (shell, self.origin + v_forward*40 + v_right*6);
	
	if (self.weapon == IT_SUPER_NAILGUN)
		shell.skin = 1;
	else
		shell.skin = 0;
	makevectors (self.v_angle);
	shell.velocity = v_forward*20 + v_right*30 + v_up * 180 + random()*v_right*100 + random()*v_up*20;
	shell.angles = vectoangles(shell.velocity);
	shell.angles_x = 90;
	shell.avelocity = vectoangles(shell.velocity);
	shell.avelocity_x = shell.avelocity_x*(random()*15);// top spin
	shell.nextthink = time + 2;
	shell.think = SUB_Remove;
};
void() spark_spawn;
void() spark_pause;
void() spark_touch =
{
	local float kill;
	if (self.wait == -1)// nailgun
		kill = 0.4;
	else
		kill = 0.1;
	if (random() < kill || self.owner.classname == "env_spark") { // remove some sparks on touch
		total_sparks -= 1;
		remove(self);
	}
};

void() spark_start =
{
	self.use = spark_pause;// next use stops it
	self.nextthink = time +  (random() + self.wait);
};

void() spark_think =
{
	if (self.attack_finished < time) {
		total_sparks -= 1;
		remove(self);
		return;
	}
	if (pointcontents(self.origin + '0 0 -8') < CONTENT_SOLID) {
		total_sparks -= 1;
		remove(self);
		return;
	}
	self.nextthink = time + 0.1;
};

void() spark_pause =
{
	self.nextthink = -1;
	self.use = spark_start;
};

void() spark_spawn =
{	
	local entity spark;
	local float r;
	if (!(self.spawnflags & SILENT)) {
		r = rint(random() * 3);	// play a random spark sound	
		if (r == 1)
			sound (self, CHAN_AUTO, "misc/spark1.wav", 1, ATTN_NORM);
		else if (r == 2)
			sound (self, CHAN_AUTO, "misc/spark2.wav", 1, ATTN_NORM);
		else if (r == 0)
			sound (self, CHAN_AUTO, "misc/spark3.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_AUTO, "misc/spark4.wav", 1, ATTN_NORM);
	}
	if (total_sparks <= #MAX_SPARKS) {
		spark = spawn ();
		setorigin (spark, self.origin);
		spark.solid = SOLID_NOT;
		spark.movetype = MOVETYPE_BOUNCE;
		spark.classname = "spark";
		spark.owner = self;
		spark.think1 = SUB_Remove;// So triggers can kill it
		// set the spark velocity
		spark.velocity_x = (random() * 200) - 25;
		spark.velocity_y = (random() * 200) - 25;
		spark.velocity_z = 0;
		spark.touch = spark_touch;
		spark.attack_finished = time + random()*3; // random lifespan for sparks that aren't removed on touch
		spark.think = spark_think;
		spark.nextthink = time + 0.1;
		setmodel (spark, "progs/spark.spr");
		setsize (spark, VEC_ORIGIN, VEC_ORIGIN);
		total_sparks++;
	}
	self.nextthink = time +  (random() + self.wait);
};

void() fx_spark =
{	
	if (!(self.spawnflags & SILENT)) {
		precache_sound ("misc/spark1.wav");
		precache_sound ("misc/spark2.wav");
		precache_sound ("misc/spark3.wav");
		precache_sound ("misc/spark4.wav");
	}

	if (self.wait < 0)
		self.wait = 0; // default frequency to 0
	
	self.think = spark_spawn;
	
	if (self.targetname != string_null && !self.spawnflags & START_ONFX)
		spark_pause();
	else
		spark_start();
};

void () env_spark =
{
	precache_model ("progs/spark.spr");
	fx_spark();
};

// Special effect for the nailgun
void(float ox) spawn_ngspark =
{	
	if (deathmatch || coop || self.waterlevel >= 3)
		return;
	local entity spark;
	spark = spawn ();
	spark.owner = self;
	spark.solid = SOLID_NOT;// NOTE: SOLID_TRIGGER will make sound in func_water (doesn't matter for real water)
	spark.movetype = MOVETYPE_BOUNCE;
	spark.classname = "ngspark";
	makevectors (self.v_angle);
	spark.velocity = v_forward*60 + v_up * 260 + crandom()*v_right*200 + crandom()*v_up*20;
	spark.angles = vectoangles(spark.velocity);	
	spark.wait = -1;// quickly kill these
	spark.touch = spark_touch;
	spark.nextthink = time + random()*1;
	spark.think = SUB_Remove;
	setmodel (spark, "progs/spark.spr");
	setsize (spark, VEC_ORIGIN, VEC_ORIGIN);		
	setorigin (spark, self.origin + v_forward*36 + v_right*ox);
};

// DRIPS ====================================================================

void() drip_spawn;
void() drip_pause;

// splash animation (runs at 20fps)
void()	s_splash1	=	[0,	s_splash2] {self.nextthink = time+0.05;};
void()	s_splash2	=	[1,	s_splash3] {self.nextthink = time+0.05;};
void()	s_splash3	=	[2,	s_splash4] {self.nextthink = time+0.05;};
void()	s_splash4	=	[3,	s_splash5] {self.nextthink = time+0.05;};
void()	s_splash5	=	[4,	s_splash6] {self.nextthink = time+0.05;};
void()	s_splash6	=	[5,	SUB_Remove] {self.nextthink = time+0.05;};

void() drip_touch =
{
	local float r;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	setorigin(self, self.origin + '0 0 4');
// play a random drip sound
	if (!(self.spawnflags & SILENT))
	{
		r = rint(random() * 2);
		if (r == 1)
			sound (self, CHAN_AUTO, "misc/drip1.wav", 1, ATTN_STATIC);
		else if (r == 2)
			sound (self, CHAN_AUTO, "misc/drip2.wav", 1, ATTN_STATIC);
		else if (r == 0)
			sound (self, CHAN_AUTO, "misc/drip3.wav", 1, ATTN_STATIC);
	}	
// particle effect - GL quake tends to blur the slpash.spr...
	particle (self.origin, '0 0 0.25', 0, 5);
	setmodel (self, "progs/splash.spr");
	s_splash1();
};

// Splash on liquids
void() drip_think =
{
	if (self.attack_finished < time) {
		self.nextthink = -1;
		drip_touch();
		return;
	}
	if (pointcontents(self.origin + '0 0 -16') < CONTENT_SOLID) {
		self.nextthink = -1;
		drip_touch();
		return;
	}
	
	self.nextthink = time + 0.1;
};

void() drip_start =
{
	self.use = drip_pause;// next use stops it
	self.nextthink = time + (random() + self.wait);
};

void() drip_pause =
{
	// Wait around for next use
	self.nextthink = -1;
	self.use = drip_start;
};

void() drip_spawn =
{	
	local entity drip;
	drip = spawn ();
	drip.solid = SOLID_TRIGGER;
	drip.movetype = MOVETYPE_TOSS;
 	drip.spawnflags = self.spawnflags;
	drip.classname = "drip";
	drip.think1 = drip_touch;// So triggers can kill it
// let gravity control the drip
	drip.velocity = VEC_ORIGIN;
	setmodel (drip, "progs/drip.spr");
	setsize (drip, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (drip, self.origin);
	drip.touch = drip_touch;
	if (self.cnt) {// Check for water
		drip.think = drip_think;
		drip.attack_finished = time + 3;
		drip.nextthink = time + 0.1;
	} else {// trace didn't hit water, so just go away if no touch
		drip.think = SUB_Remove;
		drip.nextthink = time + 3;
	}
	self.nextthink = time + (random() + self.wait);
};

void() fx_drip =
{	
	vector spot1, spot2;
	precache_model ("progs/drip.spr");
	precache_model ("progs/splash.spr");
	if (!(self.spawnflags & SILENT)) {
		precache_sound ("misc/drip1.wav");
		precache_sound ("misc/drip2.wav");
		precache_sound ("misc/drip3.wav");
	}
	if (self.wait <= 0) // default frequency to 3 seconds
		self.wait = 3;
	// Do a downard trace to see if we hit water to
	// avoid constant pointcontent checks if we can.
	spot1 = self.origin;
	spot2 = self.origin - '0 0 4096';
	traceline (spot1, spot2, TRUE, self);
	if (trace_inwater) self.cnt = TRUE;
	self.think = drip_spawn;
	if (self.targetname != string_null && !self.spawnflags & START_ONFX)
		drip_pause();
	else
		drip_start();
};

// CUSTOM SOUNDS ===================================================================

void() sound_pause;

void() sound_play;

void() sound_start =
{
	self.use = sound_pause;// next use stops it
	self.think = sound_play;
	self.nextthink = time + 0.1;
};

void() sound_pause =
{
	// play the shutoff wav if we got one, then hang around until next use
	if (self.noise1 != string_null)
		sound (self, CHAN_VOICE, self.noise1, self.volume, self.distance);
	self.nextthink = -1;
	self.use = sound_start;
};

void() sound_play = 
{
	if (self.state == 0) {// no more repeats - reset & pause
		self.state = self.count;		
		sound_pause();
		return;
	}
	else
		sound (self, CHAN_VOICE, self.noise, self.volume, self.distance);
	
// reduce repititions by 1 if not infinite
	if (self.count > 0) self.state = self.state - 1;
// Set next play time
	self.nextthink = time + (random()*self.cnt) + self.pausetime;
};

void() fx_sound =
{
	if (self.noise == string_null)
		objerror ("fx_sound without noise!");
	precache_sound (self.noise);
	if (self.noise1 != string_null)
		precache_sound (self.noise1);
// default volume to one if not specified
	if(self.volume <= 0)
		self.volume = 1.0;
// default attenuation to NORM if out of range
	if(self.distance < ATTN_NONE || self.distance > ATTN_STATIC)
		self.distance = ATTN_NORM;
// Set infinite repeat if not specified	
	if (!self.count) self.count = -1;
// Paustime < 0 makes no sense
	if (self.pausetime<0) self.pausetime = 0;
// "state" holds the current number of repeats before pausing
	self.state = self.count;
// Make sure random seed is valid
	if (self.cnt < 0) self.cnt = 0;
// start sound when triggered
	if (self.targetname != string_null && !self.spawnflags & START_ONFX) {
		self.use = sound_start;
	}
	else {// Start immediately
		self.use = sound_pause;// next use stops it
		self.think = sound_play;
		self.nextthink = time + 1.0;// FIXME! - WTF?
	}
};

//============================================================================

void() ambientsound_start =
{
	ambientsound (self.origin, self.noise, self.volume, self.distance);
};

void() fx_ambientsound =
{
	if (self.noise == string_null)
		objerror ("fx_ambientsound without noise!");
	precache_sound (self.noise);
// Default volume to 1.0 if not specified
	if(self.volume <= 0)
		self.volume = 1.0;
// Default to ATTN_STATIC if out of range
	if(self.distance < ATTN_NONE || self.distance > ATTN_STATIC)
		self.distance = ATTN_STATIC;
// start right away if not triggered
	if(!self.targetname) {
// Need to start on the second frame since that's when entities not called in world_spawn are created
		self.nextthink = time + 0.1;
		self.think = ambientsound_start;
	}
	else// wait for trigger
		self.use = ambientsound_start;
};

//end
