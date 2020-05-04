// pushable stuff (code taken from nehahra+megatf coop
// physics pushables by Urre
void () player_push2 =
{
	local float yaw;
	local vector mvec;
	if ((other.classname != "player"))
	{
		return;
	}
	if (IsOnTopOf(other, self))
		return;
    if (self.flags & FL_ONGROUND) {
      self.flags = self.flags - FL_ONGROUND;
      }
	yaw = other.angles_y* 3.14159265358979323846 *2 / 360;
	mvec_x = cos(yaw)*80;
	mvec_y = sin(yaw)*80;
	self.velocity = mvec;
};
void () func_pushable_think =
{
	if (self.buoyancy) {
		if (pointcontents((self.absmax+self.absmin)*.5) == CONTENT_WATER/* || pointcontents((self.absmax+self.absmin)*.5) == -1*/)
		{
			self.movetype = MOVETYPE_BOUNCE;
			self.velocity_z = 100;
		}
		else
			self.movetype = MOVETYPE_STEP;
		//bprint(2,"floatinnnggg\n");
	}
	self.nextthink = time + .1;
};
void () func_pushable_use_think =
{
	if (self.enemy != world) {
		if (time > self.has_tesla) {
			self.enemy = world;
			self.touch = player_push2;
		}
		else {
			walkmove (self.enemy.angles_y, -10);
		}
	}
	self.nextthink = time;
};
void () func_pushable_hluse =
{
	if (time < self.has_tesla) {
		self.has_tesla = 0;
		return;
	}
	self.has_tesla = time + 2;
	self.enemy = activator;
	self.touch = SUB_Null;
	self.think = func_pushable_use_think;
	self.nextthink = time;
};
//End
