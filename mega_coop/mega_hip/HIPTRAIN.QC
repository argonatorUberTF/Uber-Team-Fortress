void() train_blocked;
void() func_train;
void() hip_train_next;
void() hip_func_train_find;
void() hip_train_use =
{
	if (self.think != hip_func_train_find)
		{
		if ( self.velocity != '0 0 0' )
			return;		// already activated
		}
	hip_train_next();
};
void() hip_train_wait =
	{
	if (self.wait)
		{
      sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
      if ( self.wait != -1 )
			{
			self.nextthink = self.ltime + self.wait;
			self.wait = 0;
         }
		}
	else
		self.nextthink = self.ltime + 0.1;
	self.think = hip_train_next;
};
void() hip_train_next =
{
	local entity	targ;
	local float		current;
	local string   temp;
	current = self.cnt;
	targ = find (world, targetname, self.target);
	self.cnt = targ.speed;
	self.target = targ.target;
	if (!self.target)
		objerror ("hip_train_next: no next target");
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	self.wait = targ.wait;
 	if (targ.wait)
		{
		self.think = hip_train_wait;
		}
	else
		{
		self.think = hip_train_next;
		}
	if ( self.goalentity.event )
	{
		temp = self.target;
		self.target = self.goalentity.event;
		self.message = self.goalentity.message;
		SUB_UseTargets();
		self.target = temp;
		self.message = string_null;
	}
	self.goalentity = targ;
	if ( current == -1 )
		{
      setorigin (self, targ.origin - self.mins );
		self.nextthink = self.ltime + 0.01;
		}
	else
		{
		if (current>0)
	    	self.speed = current;
		SUB_CalcMove (targ.origin - self.mins, self.speed, self.think );
		}
};
void() hip_func_train_find =
{
	local entity	targ;
	targ = find (world, targetname, self.target);
   self.goalentity = targ;
	self.cnt = targ.speed;
	self.target = targ.target;
	setorigin (self, targ.origin - self.mins);
	if (!self.targetname)
	{
		self.nextthink = self.ltime + 0.1;
		self.think = hip_train_next;
	}
};
void() func_train2 =
{
	if (!self.speed)
		self.speed = 100;
	if (!self.target)
		objerror ("func_train without a target");
	if (!self.dmg)
		self.dmg = 2;
	if ( !self.noise )
	{
		if (self.sounds == 0)
		{
			self.noise = ("misc/null.wav");
		}
		if (self.sounds == 1)
		{
			self.noise = ("plats/train2.wav");
		}
	}
	if ( !self.noise1 )
		{
		if (self.sounds == 0)
			{
			self.noise1 = ("misc/null.wav");
			}
		if (self.sounds == 1)
			{
			self.noise1 = ("plats/train1.wav");
			}
		}
	precache_sound( self.noise );
	precache_sound( self.noise1 );
	self.cnt = 1;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	self.blocked = train_blocked;
	self.use = hip_train_use;
	self.classname = "train2";
	setmodel (self, self.model);
	setsize (self, self.mins , self.maxs);
	setorigin (self, self.origin);
	self.nextthink = self.ltime + 0.1;
   self.think = hip_func_train_find;
};
//END
