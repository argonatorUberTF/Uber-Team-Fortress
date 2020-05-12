void() random_pick_type = 
{
	local float randItem;
	randItem = random();
	self.touch = powerup_touch;
	setsize (self, '-16 -16 -24', '16 16 32');
	if(randItem < 0.2)
	{
		self.touch = newitems_touch;
		self.noise = "shield/pickup.wav";
		setmodel (self, "progs/shield.mdl");
		self.netname = "Power Shield";
		self.items = 0;
		self.items2 = IT2_SHIELD;
	}
	else
	if (randItem < 0.4)
	{
		self.touch = newitems_touch;
		self.noise = "belt/pickup.wav";
		setmodel (self, "progs/beltup.mdl");
		self.netname = "Anti-Grav Belt";
		self.items = 0;
		self.items2 = IT2_ANTIGRAV;
	}
	else
	if (randItem < 0.6)
	{
		self.noise = "items/protect.wav";
		setmodel (self, "progs/invulner.mdl");
		self.netname = "Pentagram of Protection";
		self.items = IT_INVULNERABILITY;
		self.items2 = 0;
	}
	else
	if (randItem < 0.8)
	{
		self.noise = "items/inv1.wav";
		setmodel (self, "progs/invisibl.mdl");
		self.netname = "Ring of Shadows";
		self.items = IT_INVISIBILITY;
		self.items2 = 0;
	}
	else
	{
		self.noise = "items/damage.wav";
		setmodel (self, #MODEL_QUAD);
		self.netname = "Quad Damage";
		self.items = IT_QUAD;
		self.items2 = 0;
	}
};
void() item_random_powerup =
{
	if (!deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/shield.mdl");
	precache_model ("progs/p_shield.mdl");
	precache_model ("progs/beltup.mdl");
	precache_model ("progs/invulner.mdl");
	precache_model ("progs/invisibl.mdl");
	precache_model (#MODEL_QUAD);
	precache_sound2  ("items/inv1.wav");
	precache_sound2 ("items/inv2.wav");
	precache_sound2 ("items/inv3.wav");
	precache_sound2 ("items/protect.wav");
	precache_sound ("items/protect2.wav");
	precache_sound ("items/protect3.wav");
	precache_sound ("items/damage.wav");
	precache_sound ("items/damage2.wav");
	precache_sound ("items/damage3.wav");
	precache_sound ("belt/pickup.wav");
	precache_sound ("belt/use.wav");
	precache_sound ("belt/fadeout.wav");
	precache_sound ("shield/pickup.wav");
	precache_sound ("shield/hit.wav");
	precache_sound ("shield/fadeout.wav");
	random_pick_type();
	StartItem ();
};
void() random_regen = 
{
	random_pick_type();
	SUB_regen();
};
//END
