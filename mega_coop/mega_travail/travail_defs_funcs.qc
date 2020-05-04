float (entity ent) IsAlive =
{
	if (ent.model)
	{
		if ((ent.health > FALSE))
		{
			if ((ent.classname != "monster_corpse"))
			{
				return (TRUE);
			}
		}
	}
	return (FALSE);
};
void () Corpse_Die =
{
	sound (self, FL_SWIM, "zombie/z_miss.wav", TRUE, FALSE);
	ThrowGib ("progs/gib3.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);
	remove (self);
};
void () Corpse_Pain =
{
	self.health = self.max_health;
};
void () Become_Corpse =
{
	setorigin (self, self.origin);
	self.solid = TRUE;
	self.size_z = (self.size_z * 0.5);
	self.classname = "monster_corpse";
	self.flags = (self.flags - FL_MONSTER);
	if ((self.health < -50))
	{
		self.health = -50;
	}
	self.max_health = (60 + self.health);
	self.health = self.max_health;
	self.th_stand = SUB_Null;
	self.th_walk = SUB_Null;
	self.th_run = SUB_Null;
	self.th_melee = SUB_Null;
	self.th_missile = SUB_Null;
	self.th_pain = Corpse_Pain;
	self.th_die = Corpse_Die;
	self.takedamage = TRUE;
	self.target = "";
	if ((coop == FL_SWIM))
	{
		self.think = SUB_Remove;
		self.nextthink = ((time + SVC_INTERMISSION) + (random () * SVC_INTERMISSION));
	}
};
void () killed_monster =
{
	killed_monsters = killed_monsters + TRUE;
	WriteByte (FL_SWIM, SVC_KILLEDMONSTER);
};
entity () SelectUBSPoint =
{
	local entity spot;
	local float freespots;
	local float totalspots;
	local entity lastfreespot;
	totalspots = FALSE;
	freespots = FALSE;
	lastfreespot = world;
	spot = find (world, classname, "info_ubs_waypoint");
	while (spot)
	{
		totalspots = totalspots + TRUE;
		if ((spot != lastspawn))
		{
			spot.goalentity = lastfreespot;
			lastfreespot = spot;
			freespots = freespots + TRUE;
		}
		spot = find (spot, classname, "info_ubs_waypoint");
	}
	if (totalspots)
	{
		if (freespots)
		{
			freespots = freespots - 0.01;
			freespots = floor ((random () * freespots));
			spot = lastfreespot;
			while (freespots)
			{
				spot = spot.goalentity;
				freespots = freespots - TRUE;
			}
			lastspawn = spot;
			return (spot);
		}
		freespots = FALSE;
		lastfreespot = world;
		spot = find (world, classname, "info_ubs_waypoint");
		while (spot)
		{
			if ((spot != lastspawn))
			{
				spot.goalentity = lastfreespot;
				lastfreespot = spot;
				freespots = freespots + TRUE;
			}
			spot = find (spot, classname, "info_ubs_waypoint");
		}
		if (freespots)
		{
			freespots = freespots - 0.01;
			freespots = floor ((random () * freespots));
			spot = lastfreespot;
			while (freespots)
			{
				spot = spot.goalentity;
				freespots = freespots - TRUE;
			}
			lastspawn = spot;
			return (spot);
		}
		totalspots = totalspots - 0.01;
		totalspots = floor ((random () * totalspots));
		spot = find (world, classname, "info_ubs_waypoint");
		while (totalspots)
		{
			totalspots = totalspots - TRUE;
			spot = find (spot, classname, "info_ubs_waypoint");
		}
		lastspawn = spot;
		return (spot);
	}
};
void () info_ubs_waypoint =
{
	local entity head;
	head = findradius (self.origin, FL_NOTARGET);
	if ((head.classname == "monster_ubs"))
	{
		head.ubs_point = SelectUBSPoint ();
	}
	self.think = info_ubs_waypoint;
	self.nextthink = (time + TRUE);
};
void () update_monster =
{};
void () monster_touch =
{
	local vector delta;
	local float pushang;
	if ((other.classname != "player"))
	{
		return;
	}
	if ((other.health <= FALSE))
	{
		return;
	}
	if ((!(other.flags & FL_ONGROUND) && (other.absmin_z >= (self.absmax_z - FL_SWIM))))
	{
		other.flags = (other.flags + FL_ONGROUND);
		return;
	}
	if (((((((((self.classname != "monster_shambler") && (self.classname != "monster_oldone")) && (self.classname != "monster_vermis")) && (self.classname != "monster_shalrath")) && (self.classname != "monster_boss")) && (self.classname != "monster_armagon")) && (self.model != "progs/uberscrag.mdl")) && !self.velocity_z))
	{
		if ((self.classname == "explo_box"))
		{
			self.flags = (self.flags - FL_ONGROUND);
		}
		delta = vectoangles (other.velocity);
		pushang = delta_y;
		if ((((self.classname == "monster_ogre") || (self.classname == "monster_hell_knight")) || (self.classname == "monster_demon1")))
		{
			walkmove (pushang, (FL_CLIENT * frametime));
		}
		else
		{
			walkmove (pushang, (FL_INWATER * frametime));
		}
	}
};
void () BurnMonster =
{
	if ((self.classname == "monster_juggernaut"))
	{
		if ((((pointcontents (self.origin) == CONTENT_WATER) || (pointcontents (self.origin) == CONTENT_LAVA)) || (pointcontents (self.origin) == CONTENT_SLIME)))
		{
			self.effects = FL_CLIENT;
			T_Damage (self, world, world, 50);
			self.effects = (self.effects - (self.effects & FL_CLIENT));
		}
		return;
	}
	if ((pointcontents ((self.origin - '0 0 24')) == CONTENT_LAVA))
	{
		T_Damage (self, world, world, MOVETYPE_FLY);
	}
	else
	{
		if ((pointcontents ((self.origin - '0 0 24')) == CONTENT_SLIME))
		{
			//particle (self.origin, '0 0 5', 63, (MOVETYPE_WALK + self.waterlevel));
			//particle (self.origin, '0 0 10', MOVETYPE_FLY, FL_SWIM);
			T_Damage (self, world, world, TRUE);
		}
	}
};
//END
