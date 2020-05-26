$frame cubelf01 cubelf02 cubelf03 cubelf04 cubelf05 cubelf06 cubelf07 cubelf08
$frame cubelf09 cubelf10 cubelf11 cubelf12 cubelf13 cubelf14 cubelf15 cubelf16
$frame cubelf17 cubelf18 cubelf19 cubelf20
void() gravity_touch =
{
	if (other.takedamage && other.health > 13)
	{
		deathmsg = 204;
		T_Damage (other, self, self.owner, 5000);		// was 5000 SH*
	}
};
void() gravity_pull =
{
	local entity e;
	local float d;
	local vector org;
	local float gPercent;
	local float gDist = 1287; // range of the weapon //originally 960 - SH*
	local float gPower = 620; // ideal speed of pull - //originally 512 - SH*
	local float magnitude;
	local float MAX_SPIN = 1000; // EFC max angle velocity rate of spinning debris
	if (time > self.attack_finished)
	{
		if (self.effects & 4)
			self.effects = self.effects - 4;
		deathmsg = 204; // Set death type for obituary. -arg
		make_explosion ();
		EMPGrenadeExplode();
		T_RadiusDamage (self, self.owner, 250, world);
		WriteByte (4, SVC_TEMPENTITY);
		WriteByte (4, TE_EXPLOSION);
		WriteCoord (4, self.origin_x);
		WriteCoord (4, self.origin_y);
		WriteCoord (4, self.origin_z);
		dremove(self);
		return; //efc - keep going so we can stop the spinning
	}
	org = (self.absmin + self.absmax) * 0.5;
	e = findradius (self.origin, gDist);
	while (e)
	{
	if (e.classname != "backpack") //Don't pull in backpacks. bad things can happen on touch. -arg
	if (e.classname != "merchant") //Don't grab the merchant. He's still shook up losing Elvis.
		//if (visible(e)) //comment out to pull through walls!!! SH*(crazy -arg)
		if (e.classname != "gravity") // don't yank on any other gravity wells
				if (e.team_no != self.team_no) // don't pull in team mates, no whee!!  -arg
					if (e != self.owner) // don't pull in the person who fired it also. -arg
					if (e.movetype != MOVETYPE_PUSH)
						if ((e.movetype != MOVETYPE_NOCLIP)  || (e.classname == "spectator") )
							if (e.movetype != MOVETYPE_NONE || (intermission_running && e.classname == "info_intermission"))
							{
								d = vlen(e.origin - org);
								if (e.flags & FL_ONGROUND)
								{
									e.velocity_z = 40; // Push up a little bit
									e.flags = e.flags - FL_ONGROUND;
								}
								gPercent = 1 - (d / gDist);
								e.velocity = e.velocity + normalize (self.origin - e.origin) * gPower * gPercent;
						if (e.classname != "player") 
						{
						if (time > self.attack_finished)
						{
							//efc stop the f'ing spinning
							e.avelocity = '0 0 0';
						}
						else
						{
							if (visible(e)) // EFC: don't spin stuff far away (looks dumb and wastes bandwidth)
							{
						magnitude = gPercent*gPercent * MAX_SPIN;
						e.avelocity_y = magnitude;   // would need to normalize if it was multidimensional spin
						}
					}
				}	
								if (intermission_running)
								{
									if (e.classname == "info_intermission")
									{
										e.movetype = MOVETYPE_BOUNCE;
										WriteByte (MSG_ALL, SVC_INTERMISSION);
										WriteCoord (MSG_ALL, e.origin_x);
										WriteCoord (MSG_ALL, e.origin_y);
										WriteCoord (MSG_ALL, e.origin_z);
										WriteAngle (MSG_ALL, e.mangle_x);
										WriteAngle (MSG_ALL, e.mangle_y);
										WriteAngle (MSG_ALL, e.mangle_z);
									} // end EFC add
								}	
							}
		e = e.chain;
		deathmsg = 204; // Set death type for obituary. -arg
	}
};
void() gravity_pulse1 = [ $cubelf01, gravity_pulse2 ]
{
	gravity_pull();
};
void() gravity_pulse2 = [ $cubelf02, gravity_pulse3 ]
{
	gravity_pull();
};
void() gravity_pulse3 = [ $cubelf03, gravity_pulse4 ]
{
	gravity_pull();
};
void() gravity_pulse4 = [ $cubelf04, gravity_pulse5 ]
{
	gravity_pull();
};
void() gravity_pulse5 = [ $cubelf05, gravity_pulse6 ]
{
	gravity_pull();
};
void() gravity_pulse6 = [ $cubelf06, gravity_pulse7 ]
{
	gravity_pull();
};
void() gravity_pulse7 = [ $cubelf07, gravity_pulse8 ]
{
	gravity_pull();
};
void() gravity_pulse8 = [ $cubelf08, gravity_pulse9 ]
{
	gravity_pull();
};
void() gravity_pulse9 = [ $cubelf09, gravity_pulse10 ]
{
	gravity_pull();
};
void() gravity_pulse10 = [ $cubelf10, gravity_pulse11 ]
{
	gravity_pull();
};

void() gravity_pulse11 = [ $cubelf11, gravity_pulse12 ]
{
	gravity_pull();
};
void() gravity_pulse12 = [ $cubelf12, gravity_pulse13 ]
{
	gravity_pull();
};
void() gravity_pulse13 = [ $cubelf13, gravity_pulse14 ]
{
	gravity_pull();
};
void() gravity_pulse14 = [ $cubelf14, gravity_pulse15 ]
{
	gravity_pull();
};

void() gravity_pulse15 = [ $cubelf15, gravity_pulse16 ]
{
	gravity_pull();
};

void() gravity_pulse16 = [ $cubelf16, gravity_pulse17 ]
{
	gravity_pull();
};

void() gravity_pulse17 = [ $cubelf16, gravity_pulse18 ]
{
	gravity_pull();
};
void() gravity_pulse18 = [ $cubelf16, gravity_pulse19 ]
{
	gravity_pull();
};

void() gravity_pulse19 = [ $cubelf16, gravity_pulse20 ]
{
	gravity_pull();
};
void() gravity_pulse20 = [ $cubelf16, gravity_pulse1 ]
{
	gravity_pull();
};
void() gravity_explode =
{
	setmodel (self, "progs/cubel.mdl");
	self.attack_finished = time + 8.5; 											// duration of gravity well   SH*
	self.touch = gravity_touch;
	self.effects = self.effects | 4;							//SH*
	self.effects = self.effects | EF_BLUE;									//SH*	
	self.think = gravity_pulse1;
	self.nextthink = time + 0.1;
};
void() drop_gravity =
{
	if (self.pk_gravitywellammo <= 0)
	{
		return; // pk112
	}
	self.pk_gravitywellammo = self.pk_gravitywellammo -1;
	egravity = spawn();
	egravity.classname = "gravity";
	egravity.owner = self;
	egravity.solid = 1;
	egravity.movetype = 6;
	egravity.netname ="Gravity_Well";
	makevectors (self.angles);
	setorigin (egravity, self.origin + self.view_ofs + v_forward * 12); // efc- start higher and further out
	setmodel (egravity, "progs/cube.mdl");
	setsize (egravity, '-32 -32 -32', '32 32 32');
	egravity.think = gravity_explode;
	egravity.nextthink = time + 2.0;
	sound (self, CHAN_BODY, "misc/grav/grav_ergo.wav", 1, ATTN_NORM); //Changed to grav_ergo.wav--used the PKA roar sound. SH* Need to precache in weapons.qc line 63 also***
	makevectors (self.v_angle); // efc aim
	egravity.velocity = aim (self, 800); // efc aim
	egravity.velocity = egravity.velocity * (600 + random() * 20) + '0 0 375'; // efc aim
	egravity.weapon = 4096;
	egravity.team_no = self.team_no;
	//AddToSplash (egravity);  /// This might be causing the dropping through floor bug.
};
//END