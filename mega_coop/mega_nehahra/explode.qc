#ifdef mtf_nehmode
void () BecomeExplosion2 =
{
	if ((nospr32 == 1))
	{
		NormalExplosion ();
		return;
	}
	self.movetype = MOVETYPE_NONE;
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	self.frame = 0;
	self.cnt = 4;
	self.dmg = 20;
	self.lefty = time;
	setmodel (self, "sprites/explode1.spr32");
	self.solid = SOLID_NOT;
	spr32_boom ();
};
void () BecomeExplosion3 =
{
	if ((nospr32 == 1))
	{
		NormalExplosion ();
		return;
	}
	self.movetype = MOVETYPE_NONE;
	self.velocity = VEC_ORIGIN;
	self.frame = 0;
	self.cnt = 4;
	self.dmg = 20;
	self.lefty = time;
	self.touch = SUB_Null;
	setmodel (self, "sprites/explode4.spr32");
	self.solid = SOLID_NOT;
	spr32_boom ();
};
void () spr32_boom =
{
	local float num;
	num = (time - self.lefty) * self.dmg;
	if ((num > self.cnt))
	{
		remove (self);
	}
	self.frame = num;
	self.think = spr32_boom;
	self.nextthink = (time + 0.01);
};
void (entity mark) gibgore =
{
	local vector min;
	local vector max;
	local float vel;
	min = self.origin + self.mins;
	max = (self.origin + self.maxs) + self.maxs;
	vel = 10;
};
void (entity mark) backup_gibgore =
{
	local vector min;
	local vector max;
	local float vel;
	min = self.origin + self.mins;
	max = self.origin + self.maxs;
	vel = 30;
};
void () NormalExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};
#endif//end
