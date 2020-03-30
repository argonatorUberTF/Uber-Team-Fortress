void() dn_and_wait_go_up;
void() dn_and_wait_go_down;
void() dn_and_wait_crush;
void() dn_and_wait_hit_top =
{
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.state = STATE_TOP;
};
void() dn_and_wait_hit_bottom =
{
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.state = STATE_BOTTOM;
	self.think = dn_and_wait_go_up;
	self.nextthink = self.ltime + self.health;
};

void() dn_and_wait_go_down =
{
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_DOWN;
	SUB_CalcMove (self.pos2, self.speed, dn_and_wait_hit_bottom);
};
void() dn_and_wait_go_up =
{
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_UP;
	SUB_CalcMove (self.pos1, self.speed, dn_and_wait_hit_top);
};

void() dn_and_wait_crush =
{
	T_Damage (other, self, self, 1);
	if (self.state == STATE_UP)
		dn_and_wait_go_down ();
	else if (self.state == STATE_DOWN)
		dn_and_wait_go_up ();
	else
		objerror ("plat_new_crush: bad self.state\n");
};
void() dn_and_wait_use =
{
	if (self.state != STATE_TOP)
		return;
	dn_and_wait_go_down ();
};
void() toggle_go_up;
void() toggle_go_down;
void() toggle_crush;
void() toggle_hit_top =
{
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.state = STATE_TOP;
};

void() toggle_hit_bottom =
{
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.state = STATE_BOTTOM;
};

void() toggle_go_down =
{
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_DOWN;
	SUB_CalcMove (self.pos2, self.speed, toggle_hit_bottom);
};

void() toggle_go_up =
{
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_UP;
	SUB_CalcMove (self.pos1, self.speed, toggle_hit_top);
};

void() toggle_crush =
{
	T_Damage (other, self, self, 1);
	if (self.state == STATE_UP)
		toggle_go_down ();
	else if (self.state == STATE_DOWN)
		toggle_go_up ();
	else
		objerror ("plat_new_crush: bad self.state\n");
};

void() toggle_use =
{
	if (self.state == STATE_TOP)
		toggle_go_down ();
	else if(self.state == STATE_BOTTOM)
		toggle_go_up ();
};
void() elvtr_crush;

void() elvtr_stop =
{
	self.elevatorOnFloor = self.elevatorToFloor;
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.state = STATE_BOTTOM;
	self.elevatorLastUse = time;
};

void() elvtr_go =
{
	self.elevatorDestination = self.pos2;
	self.elevatorDestination_z = self.pos2_z + (self.height * self.elevatorToFloor);
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_UP;
	SUB_CalcMove (self.elevatorDestination, self.speed, elvtr_stop);
	self.elevatorLastUse = time;
};

void() elvtr_crush =
{
	self.elevatorToFloor = self.elevatorOnFloor;
	elvtr_go ();
};
void() elvtr_use =
{
	local float		tempDist, elvPos, btnPos;
	if ( (self.elevatorLastUse + 2) > time)
		return;
	self.elevatorLastUse = time;
	
	if (ELV_BUTN_DIR == 0)
		return;
	elvPos = (self.absmin_z + self.absmax_z) * 0.5;
	btnPos = (other.absmin_z + other.absmax_z) * 0.5;
	if (elvPos > btnPos)
	{
		tempDist = (elvPos - btnPos) / self.height;
		tempDist = ceil ( tempDist);
		self.elevatorToFloor = self.elevatorOnFloor - tempDist;
		elvtr_go ();
		return;
	}
	else
	{
		tempDist = btnPos - elvPos;
		if (tempDist > self.height)
		{
			tempDist = tempDist / self.height;
			tempDist = floor ( tempDist );
			self.elevatorToFloor = self.elevatorOnFloor + tempDist;
			elvtr_go ();
			return;
		}
	}
	if (ELV_BUTN_DIR == -1)
	{	
		if(self.elevatorOnFloor > 0)
		{
			self.elevatorToFloor = self.elevatorOnFloor - 1;
			elvtr_go ();
		}
	}
	else if(ELV_BUTN_DIR == 1)
	{
		if(self.elevatorOnFloor < (self.cnt - 1))
		{
			self.elevatorToFloor = self.elevatorOnFloor + 1;
			elvtr_go ();
		}
	}
};
void() plat2_center_touch;

void() plat2_go_up;

void() plat2_go_down;

void() plat2_crush;

void() plat2_spawn_inside_trigger =
{
	local entity	trigger;
	local vector	tmin, tmax;
	trigger = spawn();
	trigger.touch = plat2_center_touch;
	trigger.movetype = MOVETYPE_NONE;
	trigger.solid = SOLID_TRIGGER;
	trigger.enemy = self;
	tmin = self.mins + '25 25 0';
	tmax = self.maxs - '25 25 -8';
	tmin_z = tmax_z - (self.pos1_z - self.pos2_z + 8);
	if (self.spawnflags & PLAT_LOW_TRIGGER)
		tmax_z = tmin_z + 8;
	
	if (self.size_x <= 50)
	{
		tmin_x = (self.mins_x + self.maxs_x) / 2;
		tmax_x = tmin_x + 1;
	}
	if (self.size_y <= 50)
	{
		tmin_y = (self.mins_y + self.maxs_y) / 2;
		tmax_y = tmin_y + 1;
	}
	setsize (trigger, tmin, tmax);
};

void() plat2_hit_top =
{
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.state = STATE_TOP;
	self.plat2LastMove = time;
	if(self.plat2Called == 1)
	{
		self.think = plat2_go_down;
		self.nextthink = self.ltime + 1.5;
		self.plat2Called = 0;
		self.plat2LastMove = 0; // allow immediate move
	}
	else if(!(self.spawnflags & START_AT_TOP))
	{
		self.think = plat2_go_down;
		self.nextthink = self.ltime + self.delay;
		self.plat2Called = 0;
	}
};

void() plat2_hit_bottom =
{
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.state = STATE_BOTTOM;
	self.plat2LastMove = time;
	if(self.plat2Called == 1)
	{
		self.think = plat2_go_up;
		self.nextthink = self.ltime + 1.5;
		self.plat2Called = 0;
		self.plat2LastMove = 0; // allow immediate move
	}
	else if(self.spawnflags & START_AT_TOP)
	{	
		self.think = plat2_go_up;
		self.nextthink = self.ltime + self.delay;
		self.plat2Called = 0;
	}
};

void() plat2_go_down =
{
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_DOWN;
	SUB_CalcMove (self.pos2, self.speed, plat2_hit_bottom);
};

void() plat2_go_up =
{
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_UP;
	SUB_CalcMove (self.pos1, self.speed, plat2_hit_top);
};

void() plat2_use = 
{
	if(self.state > 4)
	self.state = self.state - 10;	
	self.use = SUB_Null;
};

void() plat2_center_touch =
{
	local float		otherState;
	local vector	platPosition;
//
	if (other.classname != "player")
		return;
		
	if (other.health <= 0)
		return;
	self = self.enemy;
	if ((self.plat2LastMove + 2) > time)
		return;

	if (self.state > 4)		// disabled.
		return;
	if (self.plat2GoTo > STATE_BOTTOM)
	{
		if (self.plat2GoTime < time)
		{
			if (self.plat2GoTo == STATE_UP)
				plat2_go_up();		
			else
				plat2_go_down();
				
			self.plat2GoTo = 0;
		}
		return;
	}
	if (self.state > STATE_BOTTOM)		// STATE_UP or STATE_DOWN
		return;
	platPosition = (self.absmax + self.absmin) * 0.5;
	if (self.state == STATE_TOP)
	{
		otherState = STATE_TOP;
		if ( platPosition_z > other.origin_z )
			otherState = STATE_BOTTOM;
	}
	else
	{
		otherState = STATE_BOTTOM;
		if ( (other.origin_z - platPosition_z) > self.height)
			otherState = STATE_TOP;
	}	

	if (self.state == otherState)
	{
		self.plat2Called = 0;
		self.plat2GoTime = time + 0.5;
	}
	else
	{
		self.plat2GoTime = time + 0.1;
		self.plat2Called = 1;
	}	
	if (self.state == STATE_BOTTOM)
		self.plat2GoTo = STATE_UP;
	else if(self.state == STATE_TOP)
		self.plat2GoTo = STATE_DOWN;
};

void() plat2_crush =
{
	T_Damage (other, self, self, 1);
	if (self.state == STATE_UP)
		plat2_go_down ();
	else if (self.state == STATE_DOWN)
		plat2_go_up ();
	else
		objerror ("plat2_crush: bad self.state\n");
};
void() func_new_plat =
{
	local float negativeHeight;
	negativeHeight = 0;
	if (!self.t_length)
		self.t_length = 80;
	if (!self.t_width)
		self.t_width = 10;
	if (self.sounds == 0)
		self.sounds = 2;
	if (self.sounds == 1)
	{
		precache_sound ("plats/plat1.wav");
		precache_sound ("plats/plat2.wav");
		self.noise = "plats/plat1.wav";
		self.noise1 = "plats/plat2.wav";
	}
	if (self.sounds == 2)
	{
		precache_sound ("plats/medplat1.wav");
		precache_sound ("plats/medplat2.wav");
		self.noise = "plats/medplat1.wav";
		self.noise1 = "plats/medplat2.wav";
	}
	self.mangle = self.angles;
	self.angles = '0 0 0';
	self.classname = "plat";
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	setorigin (self, self.origin);	
	setmodel (self, self.model);
	setsize (self, self.mins , self.maxs);
	if (!self.speed)
		self.speed = 150;
	self.pos1 = self.origin;
	self.pos2 = self.origin;
	if (self.height < 0)
	{
		negativeHeight = 1;
		self.height = 0 - self.height;
	}
	if (self.height)
		self.pos2_z = self.origin_z - self.height;
	else
	{
		negativeHeight = 1;
		self.height = self.size_z - 8;
		self.pos2_z = self.origin_z - self.height;
	}
	if (self.spawnflags & DN_N_WAIT)
	{
		self.use = dn_and_wait_use;
		self.blocked = dn_and_wait_crush;

		if (negativeHeight == 1)
		{
			self.state = STATE_BOTTOM;
			setorigin (self, self.pos2);	
		}
		else
			self.state = STATE_TOP;
		if (!self.health)
			self.health = 5;
	}
	else if (self.spawnflags & PLT_TOGGLE)
	{
		self.use = toggle_use;
		self.blocked = toggle_crush;
		if (negativeHeight == 1)
		{	
			setorigin (self, self.pos2);
			self.state = STATE_BOTTOM;
		}
		else
		{
			self.state = STATE_TOP;
		}
	}
	else if (self.spawnflags & ELEVATOR)
	{
		self.elevatorOnFloor = 0;
		self.elevatorToFloor = 0;
		self.elevatorLastUse = 0;
		if (self.spawnflags & START_AT_TOP)
		{
			self.pos1 = self.origin;
			self.pos2 = self.origin;
			self.pos2_z = self.origin_z - (self.height * (self.cnt - 1));
			self.elevatorOnFloor = self.cnt - 1;
		}
		else
		{
			self.pos1 = self.origin;
			self.pos2 = self.origin;
			self.pos1_z = self.origin_z + (self.height * (self.cnt - 1));
			self.elevatorOnFloor = 0;
		}
		self.use = elvtr_use;
		self.blocked = elvtr_crush;
	}
	else if (self.spawnflags & PLAT2)
	{
		plat2_spawn_inside_trigger ();	// the "start moving" trigger	
		self.plat2Called = 0;
		self.plat2LastMove = 0;
		self.plat2GoTo = 0;
		self.plat2GoTime = 0;
		self.blocked = plat2_crush;
		if (!self.delay)
			self.delay = 3;
			
		if (negativeHeight == 1)
		{
			self.state = STATE_BOTTOM;
			self.spawnflags = PLAT2;
			setorigin (self, self.pos2);	
		}
		else
		{
			self.spawnflags = self.spawnflags | START_AT_TOP;
			self.state = STATE_TOP;
		}
		if (self.targetname)
		{
			self.use = plat2_use;
			self.state = self.state + 10;
		}
	}
};
//END
