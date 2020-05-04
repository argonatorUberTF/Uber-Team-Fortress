void () azoth_fire1;
void () azoth_throw1;
void () azoth_leap1;
void () azoth_land1;
void () azoth_land2;
void () azoth_dive1;
void () azoth_hammer1;
void () azoth_deflect1;
void () AzothFloorAttack;
void () azoth_phase2b;
void () azoth_flee;
void () azoth_phase2;
void () azoth_phase4;
void () azoth_phase5;
void () azoth_phase7;
void () azoth_phase7b;
void () azoth_dief1;
float () azoth_new_flightpoint =
{
	local vector d;
	if ((coop == FL_SWIM))
	{
		if (!IsAlive (self.enemy))
		{
			self.enemy = world;
		}
	}
	if ((self.state == FALSE))
	{
		d = self.origin - tower;
		d_z = FALSE;
		if ((vlen (d) < 400))
		{
			azoth_land1 ();
			self.attack_finished = (time - TRUE);
			AzothFloorAttack ();
		}
		else
		{
			self.pos1 = (self.origin - (0.2 * d));
			self.pos1_z = (self.origin_z + MOVETYPE_FLY);
			self.attack_finished = (time + TRUE);
		}
	}
	else
	{
		if ((self.state == TRUE))
		{
			if ((vlen ((self.origin - gate)) <= 100))
			{
				azoth_phase2b ();
				self.velocity = VEC_ORIGIN;
				self.state = FALSE;
				self.attack_finished = (time + FL_SWIM);
				return (FALSE);
			}
			traceline (self.origin, gate, TRUE, self.enemy);
			if ((trace_fraction != TRUE))
			{
				self.pos1 = '1600 -1728 1800';
			}
			else
			{
				self.pos1 = gate;
			}
			self.attack_finished = (time + 15);
		}
		else
		{
			if ((self.state == MOVETYPE_FLY))
			{
				if ((vlen (((self.origin - rift.origin) + '0 0 300')) <= 100))
				{
					azoth_phase7b ();
					self.velocity = VEC_ORIGIN;
					self.state = FALSE;
					self.attack_finished = (time + FL_SWIM);
					return (TRUE);
				}
				traceline (self.origin, (rift.origin - '0 0 300'), TRUE, self.enemy);
				if ((trace_fraction != TRUE))
				{
					self.pos1 = (self.origin + '0 0 100');
				}
				else
				{
					self.pos1 = (rift.origin - '0 0 300');
				}
				self.attack_finished = (time + 15);
			}
			else
			{
				if ((self.state == MOVETYPE_WALK))
				{
					if ((self.pos1 == '2782 -3381 0'))
					{
						setorigin (self, (self.pos1 + '0 1 0'));
						self.velocity = VEC_ORIGIN;
						self.movetype = FALSE;
						azoth_land1 ();
						self.attack_finished = (time - TRUE);
						self.state = FALSE;
					}
					else
					{
						if ((self.pos1 == '2782 -3311 0'))
						{
							self.pos1 = '2782 -3381 0';
							self.attack_finished = (time + MOVETYPE_FLY);
						}
						else
						{
							self.pos1 = '2782 -3311 0';
						}
					}
					self.attack_finished = (time + 25);
				}
				else
				{
					if ((self.state == MOVETYPE_STEP))
					{
						d = self.origin - self.enemy.origin;
						d_z = FALSE;
						if ((vlen (d) < 250))
						{
							azoth_dive1 ();
							self.attack_finished = (time + TRUE);
							return (FALSE);
						}
						else
						{
							azoth_land1 ();
							AzothFloorAttack ();
							self.attack_finished = (time + TRUE);
						}
					}
				}
			}
		}
	}
	return (FALSE);
};
float (entity ent) towerquadrant =
{
	local float q;
	q = vectoyaw ((ent.origin - tower));
	if ((q < FALSE))
	{
		dprint ("angles less than 0\n");
	}
	if ((q <= 90))
	{
		return (TRUE);
	}
	else
	{
		if ((q <= 180))
		{
			return (FL_SWIM);
		}
		else
		{
			if ((q <= 270))
			{
				return (MOVETYPE_WALK);
			}
			else
			{
				return (MOVETYPE_STEP);
			}
		}
	}
};
void (float q) Azoth_jumproundGo =
{
	local vector spot;
	spot_y = q * 90;
	makevectors (spot);
	self.pos1 = (tower + (v_forward * 345));
	self.pos1_z = 500;
	if ((vlen ((self.origin - self.pos1)) > 200))
	{
		return;
	}
	if (((self.enemy.origin_z <= 418) && (enemy_range < FL_SWIM)))
	{
		self.attack_finished = (time + 0.2);
		azoth_throw1 ();
		return;
	}
	azoth_leap1 ();
	self.attack_finished = (time + MOVETYPE_WALK);
};
void () Azoth_jumproundfirst =
{
	local float si;
	local float p;
	si = towerquadrant (self);
	p = towerquadrant (self.enemy);
	if ((si == p))
	{
		return;
	}
	if (((p == MOVETYPE_STEP) && (si == TRUE)))
	{
		Azoth_jumproundGo ((si - 1.1));
	}
	else
	{
		if ((p > si))
		{
			Azoth_jumproundGo ((si + 0.1));
		}
		else
		{
			if (((si == MOVETYPE_STEP) && (p == TRUE)))
			{
				Azoth_jumproundGo ((si + 0.1));
			}
			else
			{
				Azoth_jumproundGo ((si - 1.1));
			}
		}
	}
};
void () Azoth_flytofirst =
{
	local vector spot;
	local vector vout;
	local vector vperp;
	vout = normalize (((self.origin - tower) - ('0 0 1' * self.origin_z)));
	vperp = ('-1 0 0' * vout_y) + ('1 0 0' * vout_x);
	if ((random () < 0.5))
	{
		spot = (600 * vout) + (100 * vperp);
	}
	else
	{
		spot = (600 * vout) - (100 * vperp);
	}
	spot_z = 500;
	if ((spot_z < self.origin_z))
	{
		self.movetype = MOVETYPE_TOSS;
		self.flags = (self.flags - (self.flags & FL_ONGROUND));
		self.velocity = (spot * 1.2);
	}
	traceline ((spot + tower), (tower + '0 0 500'), FALSE, self);
	if ((trace_fraction < 0.8))
	{
		return;
	}
	if ((pointcontents (((tower + (spot * 1.11667)) - '0 0 200')) == CONTENT_SOLID))
	{
		return;
	}
	self.pos1 = (spot + tower);
	azoth_leap1 ();
	self.attack_finished = (time + MOVETYPE_WALK);
};
void (float q) Azoth_flyroundGo =
{
	local vector spot;
	local float dist;
	spot_y = q * 90;
	makevectors (spot);
	self.pos1 = (tower + (v_forward * 345));
	self.pos1_z = 1200;
	dist = vlen ((self.origin - self.pos1));
	if ((dist > 500))
	{
		return;
	}
	if ((dist < 430))
	{
		self.movetype = MOVETYPE_TOSS;
		self.flags = (self.flags - (self.flags & FL_ONGROUND));
		self.velocity = ((self.origin - self.pos1) * FL_SWIM);
		self.velocity_z = 200;
	}
	if ((vlen ((self.origin - tower)) < 300))
	{
		self.movetype = MOVETYPE_TOSS;
		self.flags = (self.flags - (self.flags & FL_ONGROUND));
		self.velocity = ((self.origin - tower) * FL_SWIM);
		self.velocity_z = 200;
	}
	azoth_leap1 ();
	self.attack_finished = (time + MOVETYPE_WALK);
};
void () Azoth_flyroundsecond =
{
	local float si;
	local float p;
	if ((self.enemy.origin_z > 1350))
	{
		return;
	}
	si = towerquadrant (self);
	p = towerquadrant (self.enemy);
	if ((si == p))
	{
		return;
	}
	if (((p == MOVETYPE_STEP) && (si == TRUE)))
	{
		Azoth_flyroundGo ((si - 1.1));
	}
	else
	{
		if ((p > si))
		{
			Azoth_flyroundGo ((si + 0.1));
		}
		else
		{
			if (((si == MOVETYPE_STEP) && (p == TRUE)))
			{
				Azoth_flyroundGo ((si + 0.1));
			}
			else
			{
				Azoth_flyroundGo ((si - 1.1));
			}
		}
	}
};
void () Azoth_flytosecond =
{
	local vector spot;
	if ((self.origin_z > 650))
	{
		Azoth_flyroundsecond ();
		return;
	}
	spot = 600 * normalize (((self.origin - tower) - ('0 0 1' * self.origin_z)));
	spot_z = 900;
	traceline ((spot + tower), (tower + '0 0 900'), FALSE, self);
	if ((trace_fraction < 0.3))
	{
		if ((self.th_die == azoth_flee))
		{
			spot = spot + '100 100 0';
		}
		else
		{
			return;
		}
	}
	self.pos1 = (spot + tower);
	azoth_leap1 ();
	self.attack_finished = (time + MOVETYPE_BOUNCE);
};
float () AzothCheckMissile =
{
	makevectors (self.angles);
	traceline ((((self.origin + '0 0 160') + (v_forward * 14)) + (v_right * 65)), (self.enemy.origin + '0 0 15'), FALSE, self);
	if ((trace_ent == self.enemy))
	{
		return (TRUE);
	}
	else
	{
		return (FALSE);
	}
};
void () AzothFloorAttack =
{
	local float r;
	if ((enemy_range == MOVETYPE_WALK))
	{
		self.attack_finished = (time + 0.6);
		if ((random () < 0.3))
		{
			azoth_throw1 ();
		}
		else
		{
			if (!enemy_vis)
			{
				if ((self.th_die == azoth_phase7))
				{
					if (((random () < 0.1) && (self.origin_z < 150)))
					{
						azoth_leap1 ();
						self.attack_finished = (time + MOVETYPE_PUSH);
						self.state = MOVETYPE_STEP;
						self.pos1 = rift.origin;
					}
					else
					{
						self.attack_finished = (time + 0.6);
					}
				}
				else
				{
					self.attack_finished = (time + 0.1);
				}
			}
		}
	}
	else
	{
		if ((enemy_range == FL_SWIM))
		{
			self.attack_finished = (time + 0.8);
			if ((self.th_die == azoth_phase7))
			{
				r = random ();
				if (((((self.enemy.attack_finished - time) < r) && ((self.enemy.attack_finished - time) > FALSE)) && (r < 0.85)))
				{
					azoth_deflect1 ();
					self.attack_finished = (time + 1.1);
					return;
				}
			}
			if (((random () < 0.6) || AzothCheckMissile ()))
			{
				azoth_throw1 ();
			}
			else
			{
				if (!enemy_vis)
				{
					if ((self.th_die == azoth_phase7))
					{
						if (((random () < 0.1) && (self.origin_z < 150)))
						{
							azoth_leap1 ();
							self.attack_finished = (time + MOVETYPE_PUSH);
							self.state = MOVETYPE_STEP;
							self.pos1 = rift.origin;
						}
						else
						{
							self.attack_finished = (time + 0.6);
						}
					}
					else
					{
						self.attack_finished = (time + 0.1);
					}
				}
			}
		}
		else
		{
			if ((enemy_range == TRUE))
			{
				self.attack_finished = (time + 0.5);
				if (((enemy_vis && (random () < 0.6)) && ((self.enemy.origin_z - self.origin_z) < 20)))
				{
					azoth_fire1 ();
				}
				else
				{
					if ((random () < 0.2))
					{
						azoth_throw1 ();
					}
					else
					{
						if (!enemy_vis)
						{
							if ((self.th_die == azoth_phase7))
							{
								if (((random () < 0.1) && (self.origin_z < 150)))
								{
									azoth_leap1 ();
									self.attack_finished = (time + MOVETYPE_PUSH);
									self.state = MOVETYPE_STEP;
									self.pos1 = rift.origin;
								}
								else
								{
									self.attack_finished = (time + 0.6);
								}
							}
							else
							{
								self.attack_finished = (time + 0.1);
							}
						}
					}
				}
			}
			else
			{
				if ((enemy_range == FALSE))
				{
					self.attack_finished = (time + 0.8);
					azoth_hammer1 ();
				}
			}
		}
	}
};
float () AzothCheckAttack_Phase1 =
{
	local vector spot1;
	local entity targ;
	if ((self.attack_finished > time))
	{
		return (FALSE);
	}
	targ = self.enemy;
	if ((targ.origin_z < 340))
	{
		if ((self.origin_z < 340))
		{
			AzothFloorAttack ();
		}
		else
		{
			if ((random () < 0.3))
			{
				azoth_throw1 ();
				self.attack_finished = (time + TRUE);
			}
			else
			{
				spot1 = normalize (((self.origin - tower) - ('0 0 1' * self.origin_z)));
				spot1_z = TRUE;
				self.movetype = MOVETYPE_TOSS;
				self.flags = (self.flags - (self.flags & FL_ONGROUND));
				self.velocity = (spot1 * 300);
				self.attack_finished = (time + 0.2);
				azoth_land2 ();
			}
		}
		return (TRUE);
	}
	else
	{
		if ((targ.origin_z < 650))
		{
			if ((self.origin_z < 400))
			{
				if ((random () < 0.5))
				{
					azoth_throw1 ();
					self.attack_finished = (time + TRUE);
				}
				else
				{
					if ((vlen (((tower - self.origin) + (self.origin_z * '0 0 1'))) < 850))
					{
						Azoth_flytofirst ();
					}
					else
					{
						self.attack_finished = (time + 1.1);
					}
				}
			}
			else
			{
				if ((self.origin_z < 650))
				{
					Azoth_jumproundfirst ();
					if ((self.attack_finished < time))
					{
						AzothFloorAttack ();
					}
				}
				else
				{
					if ((random () < 0.6))
					{
						azoth_throw1 ();
						self.attack_finished = (time + TRUE);
					}
					else
					{
						Azoth_flytofirst ();
					}
				}
			}
			return (TRUE);
		}
		else
		{
			if ((self.origin_z < 400))
			{
				if ((random () < 0.5))
				{
					azoth_throw1 ();
					self.attack_finished = (time + TRUE);
				}
				else
				{
					if ((vlen (((tower - self.origin) + (self.origin_z * '0 0 1'))) < 850))
					{
						Azoth_flytosecond ();
					}
					else
					{
						self.attack_finished = (time + 1.1);
					}
				}
			}
			else
			{
				if ((self.origin_z < 650))
				{
					if ((random () < 0.6))
					{
						azoth_throw1 ();
						self.attack_finished = (time + TRUE);
					}
					else
					{
						Azoth_flytosecond ();
					}
				}
				else
				{
					Azoth_flyroundsecond ();
					if ((self.attack_finished < time))
					{
						AzothFloorAttack ();
					}
				}
			}
			return (TRUE);
		}
	}
};
float () AzothCheckAttack_Phase5 =
{
	local entity targ;
	if ((self.attack_finished > time))
	{
		return (FALSE);
	}
	targ = self.enemy;
	if ((targ.origin_z < 650))
	{
		if ((self.origin_z < 650))
		{
			Azoth_flytosecond ();
		}
		else
		{
			if ((random () < 0.5))
			{
				azoth_throw1 ();
				self.attack_finished = (time + TRUE);
			}
			else
			{
				self.attack_finished = (time + 0.5);
			}
		}
		return (TRUE);
	}
	else
	{
		if (((self.origin_z > 650) || (self.origin_z < 400)))
		{
			Azoth_flytofirst ();
		}
		else
		{
			if ((random () < 0.6))
			{
				azoth_throw1 ();
				self.attack_finished = (time + TRUE);
			}
			else
			{
				Azoth_jumproundfirst ();
			}
			return (TRUE);
		}
	}
	return (FALSE);
};
float () AzothCheckAttack_Phase4 =
{
	local entity targ;
	if ((self.attack_finished > time))
	{
		return (FALSE);
	}
	targ = self.enemy;
	if ((targ.origin_z > 180))
	{
		if ((((self.origin_z < 150) && (random () < 0.4)) || ((enemy_range == MOVETYPE_WALK) && (random () < 0.1))))
		{
			if ((self.flags & FL_ONGROUND))
			{
				self.state = MOVETYPE_STEP;
				self.pos1 = ((self.origin + (targ.origin * MOVETYPE_STEP)) * 0.2);
				self.pos1_z = 450;
				azoth_leap1 ();
				self.attack_finished = (time + MOVETYPE_WALK);
			}
		}
		else
		{
			AzothFloorAttack ();
		}
		return (TRUE);
	}
	else
	{
		if ((targ.origin_z > 150))
		{
			if ((self.origin_z < 150))
			{
				azoth_leap1 ();
				self.attack_finished = (time + MOVETYPE_PUSH);
				self.state = MOVETYPE_STEP;
				self.pos1 = rift.origin;
			}
			else
			{
				AzothFloorAttack ();
			}
			return (TRUE);
		}
		if ((((self.origin_z > 150) && (random () < 0.4)) || ((enemy_range == MOVETYPE_WALK) && (random () < 0.1))))
		{
			if ((self.flags & FL_ONGROUND))
			{
				self.state = MOVETYPE_STEP;
				self.pos1 = ((self.origin + (targ.origin * MOVETYPE_STEP)) * 0.2);
				self.pos1_z = 450;
				azoth_leap1 ();
				self.attack_finished = (time + MOVETYPE_WALK);
			}
		}
		else
		{
			AzothFloorAttack ();
		}
		return (TRUE);
	}
	return (FALSE);
};
float () AzothCheckAttack =
{
	if ((self.origin_z < -200))
	{
		self.pos1 = self.origin;
		self.pos1_z = 200;
		azoth_leap1 ();
		self.attack_finished = (time + 20);
		return (FALSE);
	}
	if ((((self.state == TRUE) || (self.state == MOVETYPE_WALK)) || (self.state == MOVETYPE_FLY)))
	{
		if ((coop == FL_SWIM))
		{
			if (!rift)
			{
				rift = spawn ();
				rift.classname = "rift_dummy";
				rift.origin = self.origin;
			}
			azoth_dief1 ();
			return (FALSE);
		}
		setorigin (self, self.pos1);
		self.flags = (self.flags - (self.flags & FL_ONGROUND));
		azoth_new_flightpoint ();
		return (FALSE);
	}
	if ((self.th_die == azoth_phase2))
	{
		return (AzothCheckAttack_Phase1 ());
	}
	if ((self.th_die == azoth_phase7))
	{
		return (AzothCheckAttack_Phase4 ());
	}
	if ((self.th_die == azoth_flee))
	{
		return (AzothCheckAttack_Phase5 ());
	}
	return (FALSE);
};
//END
