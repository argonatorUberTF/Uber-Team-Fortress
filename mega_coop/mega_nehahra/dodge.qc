float () ai_threats =
{
	local vector megadeth;
	local entity threata;
	local vector spot1;
	local vector spot2;
	local vector traj;
	local float num;
	local float dodge;
	local float blah;
	local string astri;
	if ((panzy_mode == 1))
	{
		return (0);
	}
	if (!(self.flags & FL_ONGROUND))
	{
		if ((self.classname != "monster_wizard"))
		{
			return (0);
		}
	}
	dodge = 0;
	astri = "thrett";
	if ((self.enemy.classname != "player"))
	{
		astri = "mthret";
	}
	threata = find (world, event, astri);
	if ((threata != world))
	{
		if (((threata.classname == "player") && (threata.health > 0)))
		{
			dodge_incoming (threata);
			if (((self.th_runfire && visible (self.enemy)) && (self.tactic != 1)))
			{
				self.tactic = 1;
				self.th_runfire ();
				return 0;
			}
			return (1);
		}
		if ((threata.owner.classname == "player"))
		{
			if ((threata.owner.health < 1))
			{
				return (0);
			}
		}
		megadeth = threata.origin - self.origin;
		if ((vlen (megadeth) < 1000))
		{
			num = fabs (threata.velocity_x) + fabs (threata.velocity_y);
			if ((num > 20))
			{
				makevectors (threata.angles);
				spot1 = threata.origin;
				traj = normalize (threata.velocity);
				spot2 = threata.origin + (traj * 1000);
				traceline (spot1, spot2, 0, threata);
				megadeth = trace_endpos - self.origin;
				if (((vlen (megadeth) < 400) || (trace_ent == self)))
				{
					dodge = 1;
				}
			}
			else
			{
				megadeth = threata.origin - self.origin;
				blah = vlen (megadeth);
				if ((blah < 300))
				{
					if ((blah < 150))
					{
						dodge = 2;
					}
					else
					{
						dodge = 3;
					}
				}
			}
		}
	}
	if ((dodge == 0))
	{
		return (0);
	}
	if ((dodge == 1))
	{
		dodge_incoming (threata);
	}
	else
	{
		dodge_fixed (threata, dodge);
	}
	return (1);
};
void (entity threata, float dodge) dodge_fixed =
{
	local vector megadeth;
	local float t;
	local float mr;
	local float num;
	local float g;
	if ((self.model == "progs/soldier.mdl"))
	{
		g = 15;
	}
	else
	{
		g = 20;
	}
	mr = 0;
	ai_face ();
	if (infront (threata))
	{
		if ((dodge == 2))
		{
			if ((walkmove (self.angles_y, g) == FALSE))
			{
				mr = 1;
			}
			num = at_ledge (self.angles, self.origin);
			if (((num == 0) && (self.nojump == 0)))
			{
				ai2_jump (self.angles, 200, '0 0 225');
				return;
			}
		}
		else
		{
			megadeth = self.angles - '0 180 0';
			SUB_NormalizeAngles (megadeth);
			if ((walkmove (megadeth_y, g) == FALSE))
			{
				if (panicjump (megadeth))
				{
					return;
				}
				mr = 1;
				num = at_ledge (megadeth, self.origin);
				if (((num == 0) && (self.nojump == 0)))
				{
					ai2_jump (megadeth, -250, '0 0 225');
					return;
				}
			}
		}
	}
	else
	{
		if ((walkmove (self.angles_y, g) == FALSE))
		{
			mr = 1;
		}
		num = at_ledge (self.angles, self.origin);
		if (((num == 0) && (self.nojump == 0)))
		{
			ai2_jump (self.angles, 200, '0 0 225');
			return;
		}
	}
	t = vectoyaw ((self.origin - threata.origin));
	if ((walkmove (t, g) == FALSE))
	{
		dodge_cardinalize (t);
	}
};
void (entity missile) dodge_incoming =
{
	local vector megadeth;
	local float mr;
	local float num;
	local float g;
	if ((self.model == "progs/soldier.mdl"))
	{
		g = 15;
	}
	else
	{
		g = 20;
	}
	megadeth = VEC_ORIGIN;
	ai_face ();
	if (infront (missile))
	{
		if ((walkmove ((self.angles_y - 180), g) == FALSE))
		{
			mr = 1;
		}
	}
	else
	{
		if ((walkmove (self.angles_y, g) == FALSE))
		{
			mr = 1;
		}
	}
	if ((missile.classname == "player"))
	{
		megadeth_y = Calc_Strafemove (missile, self);
	}
	else
	{
		megadeth_y = Calc_Dodgemove (missile, self);
	}
	if ((walkmove (megadeth_y, g) == FALSE))
	{
		if ((self.nojump == 0))
		{
			if (panicjump (megadeth))
			{
				ai2_jump (megadeth, 250, '0 0 250');
				return;
			}
			num = at_ledge (megadeth, self.origin);
			if ((num > CONTENT_SLIME))
			{
				ai2_jump (megadeth, 250, '0 0 250');
				return;
			}
		}
		num = vectoyaw ((self.origin - missile.origin));
		if ((walkmove (num, g) == FALSE))
		{
			dprint ("\n");
		}
	}
};
void (float num) dodge_cardinalize =
{
	local float mr;
	local float t;
	local float dodge;
	local float r;
	local vector vec;
	if ((num > 360))
	{
		num = num - 360;
	}
	num = num + 90;
	dodge = rint ((num / 90));
	r = (num / 90) - dodge;
	mr = dodge * 90;
	mr = mr - 90;
	t = mr - 90;
	if ((r > 0))
	{
		dodge = mr;
		mr = t;
		t = dodge;
	}
	if ((walkmove (mr, 15) == FALSE))
	{
		if ((walkmove (t, 15) == FALSE))
		{
			vec = VEC_ORIGIN;
			vec_y = t;
			ai_ledgejump (vec, 0);
		}
	}
};
float (entity missile, entity head) Calc_Dodgemove =
{
	local vector dave;
	local vector megadeth;
	local float num;
	dave = normalize ((head.origin - missile.origin));
	megadeth = normalize (missile.velocity);
	if ((dave_y < megadeth_y))
	{
		num = megadeth_y - 90;
	}
	else
	{
		num = megadeth_y + 90;
	}
	if ((num > 360))
	{
		num = num - 360;
	}
	else
	{
		if ((num < 0))
		{
			num = num + 360;
		}
	}
	return (num);
};
float (entity missile, entity head) Calc_Strafemove =
{
	local vector dave;
	local vector megadeth;
	local float num;
	dave = normalize ((head.origin - missile.origin));
	makevectors (missile.angles);
	megadeth = normalize ((v_forward * 6000));
	if ((dave_y < megadeth_y))
	{
		num = megadeth_y - 90;
	}
	else
	{
		num = megadeth_y + 90;
	}
	if ((num > 360))
	{
		num = num - 360;
	}
	else
	{
		if ((num < 0))
		{
			num = num + 360;
		}
	}
	return (num);
};
float (vector vec) panicjump =
{
	local vector start;
	local vector end;
	local float num;
	if ((self.health > 10))
	{
		return (0);
	}
	if ((self.nojump > 0))
	{
		return (0);
	}
	vec_x = 0;
	vec_z = 0;
	if ((random () < 0.4))
	{
		vec_y = vec_y + 180;
		if ((vec_y > 360))
		{
			vec_y = vec_y - 360;
		}
	}
	makevectors (vec);
	end = self.origin + (v_forward * 75);
	traceline (self.origin, end, 1, self);
	if ((trace_fraction == 1))
	{
		start = trace_endpos;
		end = start - '0 0 1500';
		traceline (start, end, 1, self);
		if ((trace_fraction > 0.1))
		{
			return (0);
		}
		num = pointcontents (trace_endpos);
		if ((num < CONTENT_WATER))
		{
			return (0);
		}
		if (!(self.brain & NO_SWIM))
		{
			if ((num == CONTENT_WATER))
			{
				return (0);
			}
		}
	}
	return (1);
};
//END
