void () spawn_think =
{
	self.think = spawn_think;
	self.nextthink = (time + 1);
};
void () spawn_use =
{
	local entity spawnentity;
	if (((self.spawnmulti == 1) /*|| horn_active*/))
	{
		spawnentity = spawn ();
		SUB_CopyEntity (self.spawnmaster, spawnentity);
	}
	else
	{
		spawnentity = self.spawnmaster;
	}
	spawnentity.model = spawnentity.spawnmodel;
	spawnentity.solid = spawnentity.spawnsolidtype;
	spawnentity.think = spawnentity.spawnthink;
	setmodel (spawnentity, spawnentity.model);
	setorigin (spawnentity, spawnentity.origin);
	spawnentity.mins = spawnentity.spawnmins;
	spawnentity.maxs = spawnentity.spawnmaxs;
	setsize (spawnentity, spawnentity.mins, spawnentity.maxs);
	if ((self.spawnsilent == 0))
	{
		spawn_tfog (spawnentity.origin);
	}
	if (horn_active)
	{
		spawnentity.charmer = horn_charmer;
		spawnentity.charmed = 1;
	}
	if ((spawnentity.flags & FL_MONSTER))
	{
		if (((self.spawnmulti != 0)/* && (horn_active == 0)*/))
		{
			total_monsters = (total_monsters + 1);
			WriteByte (MSG_BROADCAST, SVC_UPDATESTAT/*LONG*/);
			WriteByte (MSG_BROADCAST, STAT_TOTALMONSTERS);
			WriteLong (MSG_BROADCAST, total_monsters);
		}
		if (horn_active)
		{
			spawnentity.effects = (spawnentity.effects | EF_DIMLIGHT);
		}
	}
	if (((self.spawnmulti == 0) /*&& (horn_active == 0)*/))
	{
		remove (self);
	}
};
void () func_spawn =
{
	local entity tempself;
	local entity monster;
	local float tempdeathmatch;
	local float temptotal_monsters;
	local float spawnchance;
	tempself = self;
	tempdeathmatch = deathmatch;
	deathmatch = 0;
	self.monster_items = -1;
	if (!self.spawnfunction)
	{
		spawnchance = random ();
		monster = tempself;
		temptotal_monsters = total_monsters;
		self = spawn ();
		SUB_CopyEntity (tempself, self);
		self.spawnfunction = monster_dog;
		self.spawnclassname = "monster_dog";
		self.classname = self.spawnclassname;
		self.spawnfunction ();
		self.spawnmodel = self.model;
		self.spawnmins = self.mins;
		self.spawnmaxs = self.maxs;
		setmodel (self, "");
		setsize (self, self.spawnmins, self.spawnmaxs);
		self.spawnsolidtype = self.solid;
		self.solid = SOLID_NOT;
		self.spawnthink = self.think;
		self.think = spawn_think;
		self.nextthink = (time + 1);
		if (((spawnchance < 0.5) && (monster == tempself)))
		{
			monster = self;
		}
		self = spawn ();
		SUB_CopyEntity (tempself, self);
		self.spawnfunction = monster_ogre;
		self.spawnclassname = "monster_ogre";
		self.classname = self.spawnclassname;
		self.spawnfunction ();
		self.spawnmodel = self.model;
		self.spawnmins = self.mins;
		self.spawnmaxs = self.maxs;
		setmodel (self, "");
		setsize (self, self.spawnmins, self.spawnmaxs);
		self.spawnsolidtype = self.solid;
		self.solid = SOLID_NOT;
		self.spawnthink = self.think;
		self.think = spawn_think;
		self.nextthink = (time + 1);
		if (((spawnchance < 0.8) && (monster == tempself)))
		{
			monster = self;
		}
		self = spawn ();
		SUB_CopyEntity (tempself, self);
		self.spawnfunction = monster_demon1;
		self.spawnclassname = "monster_demon1";
		self.classname = self.spawnclassname;
		self.spawnfunction ();
		self.spawnmodel = self.model;
		self.spawnmins = self.mins;
		self.spawnmaxs = self.maxs;
		setmodel (self, "");
		setsize (self, self.spawnmins, self.spawnmaxs);
		self.spawnsolidtype = self.solid;
		self.solid = SOLID_NOT;
		self.spawnthink = self.think;
		self.think = spawn_think;
		self.nextthink = (time + 1);
		if (((spawnchance < 0.92) && (monster == tempself)))
		{
			monster = self;
		}
		self = spawn ();
		SUB_CopyEntity (tempself, self);
		self.spawnfunction = monster_zombie;
		self.spawnclassname = "monster_zombie";
		self.classname = self.spawnclassname;
		self.spawnfunction ();
		self.spawnmodel = self.model;
		self.spawnmins = self.mins;
		self.spawnmaxs = self.maxs;
		setmodel (self, "");
		setsize (self, self.spawnmins, self.spawnmaxs);
		self.spawnsolidtype = self.solid;
		self.solid = SOLID_NOT;
		self.spawnthink = self.think;
		self.think = spawn_think;
		self.nextthink = (time + 1);
		if (((spawnchance < 0.97) && (monster == tempself)))
		{
			monster = self;
		}
		self = spawn ();
		SUB_CopyEntity (tempself, self);
		self.spawnfunction = monster_shambler;
		self.spawnclassname = "monster_shambler";
		self.classname = self.spawnclassname;
		self.spawnfunction ();
		self.spawnmodel = self.model;
		self.spawnmins = self.mins;
		self.spawnmaxs = self.maxs;
		setmodel (self, "");
		setsize (self, self.spawnmins, self.spawnmaxs);
		self.spawnsolidtype = self.solid;
		self.solid = SOLID_NOT;
		self.spawnthink = self.think;
		self.think = spawn_think;
		self.nextthink = (time + 1);
		if ((monster == tempself))
		{
			monster = self;
		}
		total_monsters = (temptotal_monsters + 1);
	}
	else
	{
		self = spawn ();
		SUB_CopyEntity (tempself, self);
		temptotal_monsters = total_monsters;
		if ((self.spawnclassname == string_null))
		{
			objerror ("No spawnclassname defined");
		}
		self.classname = self.spawnclassname;
		self.spawnfunction ();
		if ((self.spawnmulti != 0))
		{
			total_monsters = temptotal_monsters;
		}
		self.spawnmodel = self.model;
		self.spawnmins = self.mins;
		self.spawnmaxs = self.maxs;
		setmodel (self, "");
		self.model = "";
		setsize (self, self.spawnmins, self.spawnmaxs);
		self.spawnsolidtype = self.solid;
		self.solid = SOLID_NOT;
		self.spawnthink = self.think;
		self.think = spawn_think;
		self.nextthink = (time + 1);
		monster = self;
	}
	self = tempself;
	deathmatch = tempdeathmatch;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
	setmodel (self, self.model);
	self.use = spawn_use;
	self.spawnmaster = monster;
};
void () func_spawn_small =
{
	func_spawn ();
};
//END