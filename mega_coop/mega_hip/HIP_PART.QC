//Todo: add particle() support to MVDSV? 
void () particlefield_XZ =
{
	local vector pos;
	local vector start;
	local vector end;
	if ( ( self.spawnflags & USE_COUNT ) && ( counter_GetCount( other ) != self.cnt ) )
		{
		return;
		}
	self.ltime = time + 0.25;
	if ( self.noise )
		{
		sound(self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
		}
	if (!checkclient() )
		return;
	start = self.dest1 + self.origin;
	end   = self.dest2 + self.origin;
	pos_y = start_y;
	pos_z = start_z;
	while( pos_z <= end_z )
		{
		pos_x = start_x;
		while( pos_x <= end_x )
			{
			pos_x = pos_x + 16;
			}
		pos_z = pos_z + 16;
		}
};
void () particlefield_YZ =
{
	local vector pos;
	local vector start;
	local vector end;
	if ( ( self.spawnflags & USE_COUNT ) &&
		( counter_GetCount( other ) != self.cnt ) )
		{
		return;
		}
	self.ltime = time + 0.25;
	if ( self.noise )
		{
		sound(self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
		}
	if (!checkclient() )
		return;
	start = self.dest1 + self.origin;
	end   = self.dest2 + self.origin;
	pos_x = start_x;
	pos_z = start_z;
	while( pos_z < end_z )
		{
		pos_y = start_y;
		while( pos_y < end_y )
			{
			pos_y = pos_y + 16;
			}
		pos_z = pos_z + 16;
		}
};
void () particlefield_XY =
{
	local vector pos;
	local vector start;
	local vector end;
	if ( ( self.spawnflags & USE_COUNT ) &&
		( counter_GetCount( other ) != self.cnt ) )
		{
		return;
		}
	self.ltime = time + 0.25;
	if ( self.noise )
		{
		sound(self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
		}
	if (!checkclient() )
		return;
	start = self.dest1 + self.origin;
	end   = self.dest2 + self.origin;
	pos_x = start_x;
	pos_z = start_z;
	while( pos_x < end_x )
		{
		pos_y = start_y;
		while( pos_y < end_y )
			{
			//particle ( pos, '0 0 0', self.color, self.count );
			pos_y = pos_y + 16;
			}
		pos_x = pos_x + 16;
		}
};
void () particlefield_touch =
{
	if ( !self.dmg )
		return;
	if ( time > self.ltime)
		return;
	if (time < self.attack_finished)
		return;
	self.attack_finished = time + 0.5;
	T_Damage (other, self, self, self.dmg);
};
void() func_particlefield =
{
	if ( !self.color )
		{
		self.color = 192;
		}
   if ( self.count == 0 )
		{
		self.count = 2;
		}
	self.classname = "particlefield";
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	setmodel (self, self.model);
	self.model = string_null;
	self.origin = ( self.mins + self.maxs ) * 0.5;
	setorigin (self, self.origin);
	self.dest = self.maxs - self.mins - '16 16 16';
	self.dest1 = self.mins + '8 8 8' - self.origin;
	self.dest2 = self.maxs + '7.9 7.9 7.9' - self.origin;
	setsize (self, self.mins, self.maxs);
	self.touch = particlefield_touch;
	if ( self.dest_x > self.dest_z )
	{
		if ( self.dest_y > self.dest_z )
		{
			self.use = particlefield_XY;
			self.dest1_z = ( self.dest1_z + self.dest2_z ) / 2;
		}
		else
		{
			self.use = particlefield_XZ;
			self.dest1_y = ( self.dest1_y + self.dest2_y ) / 2;
		}
	}
	else
	{
		if ( self.dest_y > self.dest_x )
		{
			self.use = particlefield_YZ;
			self.dest1_x = ( self.dest1_x + self.dest2_x ) / 2;
		}
		else
		{
			self.use = particlefield_XZ;
			self.dest1_y = ( self.dest1_y + self.dest2_y ) / 2;
		}
	}
	if ( self.noise )
		{
		precache_sound( self.noise );
		}
	self.ltime = time;
};
void () blocker_touch =
{
	if ( !self.dmg )
		return;
	if (time < self.attack_finished)
		return;
	self.attack_finished = time + 0.5;
	T_Damage (other, self, self, self.dmg);
};
void() func_togglewall =
{
	self.classname = "togglewall";
	self.movetype = MOVETYPE_PUSH;
	self.mdl = self.model;
	setmodel (self, self.model);
	setsize (self, self.mins, self.maxs);
	setorigin (self, self.origin);
	self.touch = blocker_touch;
	self.use = blocker_use;
	if ( !self.noise )
	{
		self.noise = ("misc/null.wav");
	}
	if ( !self.noise1 )
	{
		self.noise1 = ("misc/null.wav");
	}
	precache_sound( self.noise );
	precache_sound( self.noise1 );
	self.solid = SOLID_BSP;
	self.model = string_null;
	if ( self.spawnflags & START_OFF )
	{
		self.state = 0;
		setorigin( self, self.origin + '8000 8000 8000' );
	}
	else
	{
		self.state = 1;
		sound(self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	}
};
//END
