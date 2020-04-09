void() stop_earthquake;
void() earthquake_rumble =
{
	if (self.attack_finished < time)
		stop_earthquake();
	else
	{
		sound( self, CHAN_VOICE, "equake/rumble.wav", 1, ATTN_NONE );
		self.think = earthquake_rumble;
		self.nextthink = time + 1;
	}
}; 
void() start_earthquake =
{
	earthquake_active = 1;
	if ( self.spawnflags & EQ_RANDOM )
		self.attack_finished = time + random() * self.delay;
	else
		self.attack_finished = time + self.delay;
	earthquake_rumble();
};
void() stop_earthquake =
{
	earthquake_active = 0;
	self.think = start_earthquake;
	if ( self.spawnflags & EQ_RANDOM )
		self.nextthink = time + random() * self.wait;
	else
		self.nextthink = time + self.wait;
};
void() earthquake =
{
	if (!self.delay)
		self.delay = 20;
	if (!self.wait)
		self.wait = 60;
	if (!self.weapon)
		self.weapon = 40;	
	precache_sound ("equake/rumble.wav");
	earthquake_active = 0;
	earthquake_intensity = self.weapon * 0.5;
	setsize (self, '0 0 0', '0 0 0');
	self.think = stop_earthquake;
	self.nextthink = time + 1;
};
void() earthquake_touch = 
{
	if (self.delay)
	{
		if ( self.attack_finished < time )
		{
			sound ( self, CHAN_VOICE, "equake/rumble.wav", 1, ATTN_NORM );
			self.attack_finished = time + 1;
		}			
		if ( other.classname == "player" )
		{
			if ( other.flags & FL_ONGROUND )
			{
				other.velocity_x = other.velocity_x + 
									(random() * self.weapon * 2) -
									self.weapon;
				other.velocity_y = other.velocity_y + 
									(random() * self.weapon * 2) -
									self.weapon;
				other.velocity_z = other.velocity_z + 
									(random() * self.weapon * 2) -
									self.weapon;
			}
		}
	}
};
void() earthquake_use = 
{
	self.delay = !self.delay;
};
void() trigger_earthquake =
{
	precache_sound ("equake/rumble.wav");
	if (!self.weapon)
		self.weapon = 40;	
	self.weapon = self.weapon * 0.5;
	self.delay = 1;
	self.touch = earthquake_touch;
	if (self.targetname)
	{
		self.use = earthquake_use;
		self.delay = 0;
	}
	InitTrigger();
};
void() kill_earthquake =
{
	local entity 	eq;
	if ( other.classname != "player" )
		return;
	eq = find (world, classname, "earthquake");
	if (eq != world)
	{
		earthquake_active = 0;
		remove (eq); 
	}
};
void() trigger_earthquake_kill =
{
	self.touch = kill_earthquake;

	InitTrigger();
};
//END
