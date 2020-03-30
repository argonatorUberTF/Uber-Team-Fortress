void (float dist) ai_retreat =
{
	local float num;
	if ((self.enemy.health < 1))
	{
		self.enemy = world;
		self.oldenemy = world;
		self.th_stand ();
		return;
	}
	flee_options ();
	if ((self.fangle == -1))
	{
		self.flags = (self.flags - (self.flags & FL_FLEE));
		ai_run (dist);
		return;
	}
	self.ideal_yaw = self.fangle;
	ChangeYaw ();
	if ((walkmove (self.fangle, dist) == FALSE))
	{
		num = at_ledge (self.origin/*fangle*/, self.origin);
		if ((num > CONTENT_SLIME))
		{
			if (ai2_tracetoss (self.origin/*self.fangle*/, 200, '0 0 250'))
			{
				SightSound ();
				ai2_jump (self.origin/*self.fangle*/, 200, '0 0 250');
				ai_run (dist);
				return;
			}
		}
		flee_options ();
		if ((self.fangle == -1))
		{
			self.flags = (self.flags - (self.flags & FL_FLEE));
			ai_run (dist);
			return;
		}
	}
};

void () flee_options =
{
	local float num;
	local float not;
	local vector judge;
	local vector judy;
	judy = '-1 -1 -1';
	judge = judy;
	num = vectoyaw ((self.enemy.origin - self.origin));
	if (visible (self.enemy))
	{
	//	not = Sub_CardinalizeAngle (num);
	}
	else
	{
		not = -1;
	}
	if ((not != 0))
	{
		judge = checkfleepath (0, judy);
		judy = judge;
	}
	if ((not != 90))
	{
		judge = checkfleepath (90, judy);
		judy = judge;
	}
	if ((not != 180))
	{
		judge = checkfleepath (180, judy);
		judy = judge;
	}
	if ((not != 270))
	{
		judge = checkfleepath (270, judy);
		judy = judge;
	}
	if ((judy_z > -1))
	{
		self.fangle = judy_z;
	}
};

vector (float num, vector t) checkfleepath =
{
	local vector megadeth;
	local float points;
	self.boost = 0;
	megadeth = self.origin;
	if (walkmove (num, 32))
	{
		vispts ();
		if (walkmove (num, 32))
		{
			vispts ();
			if (walkmove (num, 32))
			{
				vispts ();
				if (walkmove (num, 32))
				{
					vispts ();
					if (walkmove (num, 32))
					{
						vispts ();
						if (walkmove (num, 32))
						{
							self.boost = (self.boost + 1);
							if (walkmove (num, 32))
							{
								self.boost = (self.boost + 1);
								if (walkmove (num, 32))
								{
									self.boost = (self.boost + 1);
								}
							}
						}
					}
				}
			}
		}
	}
	if ((vlen ((self.origin - megadeth)) < 300))
	{
		self.boost = 0;
		num = -1;
	}
	points = self.boost;
	self.boost = 0;
	self.origin = megadeth;
	if ((points > t_y))
	{
		t_y = points;
		t_z = num;
	}
	return (t);
};

void () vispts =
{
	if (visible (self.enemy))
	{
		self.boost = (self.boost + 0.5);
	}
	else
	{
		self.boost = (self.boost + 1);
	}
};
//END
