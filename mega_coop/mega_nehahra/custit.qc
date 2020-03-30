void () trigger_custom =
{
	if (!self.target)
	{
		objerror ("trigger_custom with no targets.  Doh!\n");
	}
	InitTrigger ();
	if (self.noise)
	{
		precache_sound (self.noise);
	}
	if (self.noise1)
	{
		precache_sound (self.noise1);
	}
	if (!self.event)
	{
		self.event = "prefatory@yahoo.com";
	}
	self.touch = check_custom;
	self.think = custom_timing;
	self.nextthink = (time + 1);
};

void () custom_timing =
{
	if ((self.touch != check_custom))
	{
		self.touch = check_custom;
	}
	self.nextthink = (time + 2);
	self.think = custom_timing;
};

void () check_custom =
{
	local entity item55;
	if (((other.classname != "player") || (other.health < 1)))
	{
		return;
	}
	item55 = find (world, netname, self.event);
	if ((item55 != world))
	{
		centerprint (other, "You need the ", self.event);
		if (self.noise1)
		{
			sound (other, CHAN_ITEM, self.noise1, 1, ATTN_NORM);
		}
		self.touch = SUB_Null;
		return;
	}
	if (self.noise)
	{
		sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);
	}
	SUB_UseTargets ();
	remove (self);
};

void () custom_item =
{
	if (!self.model)
	{
		bprint ("MINDCRIME: removed Custom_Item because no model was set\n");
		remove (self);
		return;
	}
	if (!self.netname)
	{
		bprint ("MINDCRIME: removed Custom_Item because no netname was set\n");
		remove (self);
		return;
	}
	if (self.noise)
	{
		precache_sound (self.noise);
	}
	precache_model (self.model);
	setmodel (self, self.model);
	self.touch = cust_item_touch;
	setsize (self, '-16 -16 0', '16 16 56');
	StartItem ();
};

void () cust_item_touch =
{
	if (((other.classname != "player") || (other.health < 1)))
	{
		return;
	}
	if (self.noise)
	{
		sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);
	}
	centerprint (other, "You got the \n");
	centerprint (other, self.netname);
	SUB_UseTargets ();
	remove (self);
};

void () snd_beat_toggle =
{
	if (!self.noise)
	{
		objerror ("No self.noise for snd_beat_toggle.  Doh!");
	}
	if (!self.noise1)
	{
		objerror ("No self.noise1 for snd_beat_toggle.  Doh\n");
	}
	precache_sound (self.noise);
	precache_sound (self.noise1);
	setorigin (self, self.origin);
	if ((self.volume < 1))
	{
		self.volume = 1;
	}
	self.noise2 = self.noise;
	self.cnt = 0;
	if (self.targetname)
	{
		self.use = snd_beat_use;
	}
	else
	{
		if ((self.wait > 0))
		{
			self.think = snd_beat_go;
			self.nextthink = (time + self.wait);
			return;
		}
		self.think = snd_beat_go;
		self.nextthink = (time + self.delay);
	}
};

void () snd_beat_use =
{
	self.think = snd_beat_go;
	self.nextthink = time + 1;//snd_beat_use;
	self.use = SUB_Remove;
};

void () snd_beat_go =
{
	sound (other, CHAN_ITEM, self.noise2, 1, ATTN_NORM);
	self.cnt = (self.cnt + 1);
	if ((self.cnt >= self.volume))
	{
		self.cnt = 0;
		if ((random () < 0.4))
		{
			self.noise2 = self.noise;
		}
		else
		{
			self.noise2 = self.noise1;
		}
	}
	self.nextthink = (time + self.delay);
	self.think = snd_beat_go;
};

void () misc_misc =
{
	if (!self.model)
	{
		bprint ("MINDCRIME: removed misc_misc because no model was set\n");
		remove (self);
		return;
	}
	precache_model (self.model);
	setmodel (self, self.model);
	setorigin (self, self.origin);
	setsize (self, '-16 -16 0', '16 16 56');
};

//END
