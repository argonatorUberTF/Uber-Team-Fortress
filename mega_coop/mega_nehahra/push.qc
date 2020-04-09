float (entity Top, entity Bottom ) IsOnTopOf;
void () experiment_push =
{
	if ((other.classname != "player"))
	{
		return;
	}
	if ((self.classname != "func_drift"))
	{
		if (IsOnTopOf (other, self))
		{
			return;
		}
		if ((self.pain_finished < time))
		{
			self.pain_finished = (time + 0.6);
			sound (self, 7, "wall/push.wav", 1, ATTN_NORM);
		}
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
		}
	}
	makevectors (other.angles);
	self.velocity_x = (other.velocity_x * 0.6);
	self.velocity_y = (other.velocity_y * 0.6);
};
void () pushable_die =
{
	self.origin = (self.mins+self.maxs)*.5;
	WriteByte (4, 23);
	WriteByte (4, 3);
	WriteCoord (4, self.origin_x);
	WriteCoord (4, self.origin_y);
	WriteCoord (4, self.origin_z);
	multicast (self.origin, 1);
	BecomeExplosion();
};
#ifndef mtf_coop_halflife
#ifdef mtf_coop_nehahra
void () func_pushable =
{
	precache_sound ("wall/push.wav");
	self.mangle = self.angles;
	self.angles = '0 0 0';
	self.classname = "pushwall";
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, self.model);
	setorigin (self, self.origin);
	setsize (self, self.mins, self.maxs);
	// super: neherha intended for you to be able to push the barrels.
	// the other push function was messed up (pushed parallel to your direction) 
	self.touch = player_push2;
#ifdef mtf_coop_halflife
	if (mapname == "c1a2")
		if (self.model == "*29")
			self.origin_z -= 13;
		if (#HL_MAP) {
		if (self.buoyancy > 0)
		{
		self.origin_z += 10;
			self.movetype = MOVETYPE_BOUNCE;
			self.think = func_pushable_think;
			self.nextthink = time + .5;
		}
	}
#endif	
	if (survival_mode) {
		self.monster_string = "sentry_type";		// so monsters attack
		self.team_no = 1;							// so team damage doesnt f**k the walls
		self.takedamage = DAMAGE_YES;
		self.health = 2900;
		self.th_die = pushable_die;
	}
};
#endif
#endif
void () info_weight_switch =
{
	precache_sound ("misc/trigger1.wav");
	self.cnt = 0;
	self.solid = SOLID_TRIGGER;
	setsize (self, '-16 -16 0', '16 16 56');
	InitTrigger ();
	self.touch = weight_sensor;
	self.think = weight_switch_think;
	self.nextthink = (time + 0.5);
};
void () weight_switch_think =
{
	if ((self.cnt == 10))
	{
		self.nextthink = (time + 99999);
		self.think = weight_switch_think;
		return;
	}
	if ((self.cnt != 0))
	{
		SUB_UseTargets ();
		Wsensor_checkothers ();
	}
	self.nextthink = (time + 0.3);
	self.think = weight_switch_think;
};
void () main_weight_switch =
{
	self.cnt = 0;
	self.think = mweight_think;
	self.nextthink = (time + 0.1);
};
void () mweight_think =
{
	local entity head;
	if ((self.cnt == 99))
	{
		head = find (world, classname, "info_weight_switch");
		while (head)
		{
			remove (head);
			head = find (head, classname, "info_weight_switch");
		}
		SUB_UseTargets ();
		remove (self);
		return;
	}
	self.nextthink = (time + 0.3);
	self.think = mweight_think;
};
float () Wsensor_checkothers =
{
	local float kount;
	local float t;
	local entity head;
	t = 0;
	kount = 0;
	head = find (world, classname, "info_weight_switch");
	while (head)
	{
		if ((head != self))
		{
			t = t + 1;
		}
		head = find (head, classname, "info_weight_switch");
	}
	if ((t == 0))
	{
		head = find (world, classname, "main_weight_switch");
		if ((head != world))
		{
			head.cnt = 99;
			self.cnt = 10;
		}
		return (1);
	}
	remove (self);
	return (0);
};
void () weight_sensor =
{
	if ((other.classname != "pushwall"))
	{
		self.cnt = 0;
		return;
	}
	other.touch = SUB_Null;
	sound (self, CHAN_ITEM, "misc/trigger1.wav", 1, ATTN_IDLE);
	self.cnt = 1;
};
//END
