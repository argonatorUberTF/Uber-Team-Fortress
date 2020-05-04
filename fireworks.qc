//TODO: Needs more work to make sure it works and looks right. -arg -agent
/*
void () firework_think_c0 =
{
	if ((self.wait < time))
	{
		remove (self);
		return;
	}
	particle (self.origin, (self.velocity * 0.5), (random () * 250), TE_LAVASPLASH);
	self.nextthink = (time + 0.1);
	self.think = firework_think_c0;
};
void () firework_think_cw =
{
	if ((self.wait < time))
	{
		remove (self);
		return;
	}
	particle (self.origin, (self.velocity * 0.5), 160, TE_LAVASPLASH);
	self.nextthink = (time + 0.1);
	self.think = firework_think_cw;
};
void () firework_think_cr =
{
	if ((self.wait < time))
	{
		remove (self);
		return;
	}
	particle (self.origin, (self.velocity * 0.5), 72, TE_LAVASPLASH);
	self.nextthink = (time + 0.1);
	self.think = firework_think_cr;
};
void () firework_think_cy =
{
	if ((self.wait < time))
	{
		remove (self);
		return;
	}
	particle (self.origin, (self.velocity * 0.5), 195, TE_LAVASPLASH);
	self.nextthink = (time + 0.1);
	self.think = firework_think_cy;
};
void () firework_think_cb =
{
	if ((self.wait < time))
	{
		remove (self);
		return;
	}
	particle (self.origin, (self.velocity * 0.5), 215, TE_LAVASPLASH);
	self.nextthink = (time + 0.1);
	self.think = firework_think_cb;
};
void () FireworkNormalBoom =
{
	local vector vel;
	local float num;
	local float tcolor;

	if ((random () < 0.6))
	{
		tcolor = AS_MELEE;
	}
	else
	{
		if ((random () < 0.7))
		{
			tcolor = SPAWNFLAG_SUPERSPIKE;
		}
		else
		{
			if ((random () < 0.7))
			{
				tcolor = SPAWNFLAG_LASER;
			}
			else
			{
				if ((random () < 0.6))
				{
					tcolor = DOOR_DONT_LINK;
				}
				else
				{
					tcolor = MSG_BROADCAST;
				}
			}
		}
	}
	num = MSG_BROADCAST;
	while ((num < SECRET_NO_SHOOT))
	{
		newmis = spawn ();
		newmis.owner = world;
		newmis.movetype = MOVETYPE_TOSS;
		newmis.solid = SOLID_NOT;
		newmis.effects = (newmis.effects | EF_BRIGHTLIGHT);
		newmis.angles = vectoangles ('0 0 1');
		newmis.touch = SUB_Remove;
		newmis.classname = "firework";
		newmis.nextthink = time;
		if ((tcolor == MSG_BROADCAST))
		{
			newmis.think = firework_think_cw;
		}
		if ((tcolor == SPAWNFLAG_SUPERSPIKE))
		{
			newmis.think = firework_think_cr;
		}
		if ((tcolor == SPAWNFLAG_LASER))
		{
			newmis.think = firework_think_cy;
		}
		if ((tcolor == AS_MELEE))
		{
			newmis.think = firework_think_cb;
		}
		if ((tcolor == DOOR_DONT_LINK))
		{
			if ((random () < 0.34))
			{
				newmis.think = firework_think_cr;
			}
			else
			{
				if ((random () < 0.34))
				{
					newmis.think = firework_think_cw;
				}
				else
				{
					newmis.think = firework_think_cb;
				}
			}
		}
		

		newmis.wait = ((time + 0.5) + (random () * SPAWNFLAG_SUPERSPIKE));
		setmodel (newmis, "");
		setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
		setorigin (newmis, self.origin);
		vel_x = (crandom () * 200);
		vel_y = (crandom () * 200);
		vel_z = (crandom () * 200);
		newmis.velocity = ('0 0 250' + vel);
		num = (num + SPAWNFLAG_SUPERSPIKE);
	}
	remove (self);
	return;
};
void (vector here) FireworkBall;
void () threestepthree =
{
	local vector org;
	sound (self, CHAN_AUTO, "weapons/r_exp3.wav", 0.3, ATTN_NORM);
	org_x = (20 + (crandom () * 80));
	org_y = (20 + (crandom () * 80));
	org_z = (20 + (crandom () * 80));
	traceline (self.origin, (self.origin + org), TRUE, self);
	if ((trace_fraction >= SPAWNFLAG_SUPERSPIKE))
	{
		FireworkBall ((self.origin + org));
	}
	else
	{
		org_x = (TE_LAVASPLASH + (crandom () * 20));
		org_y = (TE_LAVASPLASH + (crandom () * 20));
		org_z = (TE_LAVASPLASH + (crandom () * 20));
		traceline (self.origin, (self.origin + org), TRUE, self);
		if ((trace_fraction >= SPAWNFLAG_SUPERSPIKE))
		{
			FireworkBall ((self.origin + org));
		}
	}
	remove (self);
	return;
};
void () threesteptwo =
{
	local vector org;
	sound (self, CHAN_AUTO, "weapons/r_exp3.wav", 0.3, ATTN_NORM);
	org_x = (20 + (crandom () * 80));
	org_y = (20 + (crandom () * 80));
	org_z = (20 + (crandom () * 80));
	traceline (self.origin, (self.origin + org), TRUE, self);
	if ((trace_fraction >= SPAWNFLAG_SUPERSPIKE))
	{
		FireworkBall ((self.origin + org));
	}
	else
	{
		org_x = (TE_LAVASPLASH + (crandom () * 20));
		org_y = (TE_LAVASPLASH + (crandom () * 20));
		org_z = (TE_LAVASPLASH + (crandom () * 20));
		traceline (self.origin, (self.origin + org), TRUE, self);
		if ((trace_fraction >= SPAWNFLAG_SUPERSPIKE))
		{
			FireworkBall ((self.origin + org));
		}
	}
	self.nextthink = (time + 0.4);
	self.think = threestepthree;
};
void (vector here) FireworkRing =
{
	local float ring;
	ring = 20;
	self.angles_x = (crandom () * 360);
	self.angles_y = (crandom () * 360);
	self.angles_z = (crandom () * 360);
	makevectors (self.angles);
	if ((random () < 0.4))
	{
		particle (here, (((v_forward * 375) + (v_right * 375)) + (v_up * 50)), 215, ring);
		particle (here, (((v_forward * -375) + (v_right * -375)) + (v_up * -50)), 215, ring);
		particle (here, (((v_forward * -375) + (v_right * 375)) + (v_up * 50)), 215, ring);
		particle (here, (((v_forward * 375) + (v_right * -375)) + (v_up * -50)), 215, ring);
		particle (here, (((v_forward * 420) + (v_right * MSG_BROADCAST)) + (v_up * 25)), 215, ring);
		particle (here, (((v_forward * -420) + (v_right * MSG_BROADCAST)) + (v_up * -25)), 215, ring);
		particle (here, (((v_forward * MSG_BROADCAST) + (v_right * 420)) + (v_up * 25)), 215, ring);
		particle (here, (((v_forward * MSG_BROADCAST) + (v_right * -420)) + (v_up * -25)), 215, ring);
	}
	else
	{
		if ((random () < 0.4))
		{
			particle (here, (((v_forward * 375) + (v_right * 375)) + (v_up * 50)), 72, ring);
			particle (here, (((v_forward * -375) + (v_right * -375)) + (v_up * -50)), 72, ring);
			particle (here, (((v_forward * -375) + (v_right * 375)) + (v_up * 50)), 72, ring);
			particle (here, (((v_forward * 375) + (v_right * -375)) + (v_up * -50)), 72, ring);
			particle (here, (((v_forward * 420) + (v_right * MSG_BROADCAST)) + (v_up * 25)), 72, ring);
			particle (here, (((v_forward * -420) + (v_right * MSG_BROADCAST)) + (v_up * -25)), 72, ring);
			particle (here, (((v_forward * MSG_BROADCAST) + (v_right * 420)) + (v_up * 25)), 72, ring);
			particle (here, (((v_forward * MSG_BROADCAST) + (v_right * -420)) + (v_up * -25)), 72, ring);
		}
		else
		{
			if ((random () < 0.4))
			{
				particle (here, (((v_forward * 375) + (v_right * 375)) + (v_up * 50)), 195, ring);
				particle (here, (((v_forward * -375) + (v_right * -375)) + (v_up * -50)), 195, ring);
				particle (here, (((v_forward * -375) + (v_right * 375)) + (v_up * 50)), 195, ring);
				particle (here, (((v_forward * 375) + (v_right * -375)) + (v_up * -50)), 195, ring);
				particle (here, (((v_forward * 420) + (v_right * MSG_BROADCAST)) + (v_up * 25)), 195, ring);
				particle (here, (((v_forward * -420) + (v_right * MSG_BROADCAST)) + (v_up * -25)), 195, ring);
				particle (here, (((v_forward * MSG_BROADCAST) + (v_right * 420)) + (v_up * 25)), 195, ring);
				particle (here, (((v_forward * MSG_BROADCAST) + (v_right * -420)) + (v_up * -25)), 195, ring);
			}
			else
			{
				if ((random () < 0.4))
				{
					particle (here, (((v_forward * 375) + (v_right * 375)) + (v_up * 50)), 160, ring);
					particle (here, (((v_forward * -375) + (v_right * -375)) + (v_up * -50)), 160, ring);
					particle (here, (((v_forward * -375) + (v_right * 375)) + (v_up * 50)), 160, ring);
					particle (here, (((v_forward * 375) + (v_right * -375)) + (v_up * -50)), 160, ring);
					particle (here, (((v_forward * 420) + (v_right * MSG_BROADCAST)) + (v_up * 25)), 160, ring);
					particle (here, (((v_forward * -420) + (v_right * MSG_BROADCAST)) + (v_up * -25)), 160, ring);
					particle (here, (((v_forward * MSG_BROADCAST) + (v_right * 420)) + (v_up * 25)), 160, ring);
					particle (here, (((v_forward * MSG_BROADCAST) + (v_right * -420)) + (v_up * -25)), 160, ring);
				}
				else
				{
					if ((random () < 0.4))
					{
						particle (here, (((v_forward * 375) + (v_right * 375)) + (v_up * 50)), 180, ring);
						particle (here, (((v_forward * -375) + (v_right * -375)) + (v_up * -50)), 180, ring);
						particle (here, (((v_forward * -375) + (v_right * 375)) + (v_up * 50)), 180, ring);
						particle (here, (((v_forward * 375) + (v_right * -375)) + (v_up * -50)), 180, ring);
						particle (here, (((v_forward * 420) + (v_right * MSG_BROADCAST)) + (v_up * 25)), 180, ring);
						particle (here, (((v_forward * -420) + (v_right * MSG_BROADCAST)) + (v_up * -25)), 180, ring);
						particle (here, (((v_forward * MSG_BROADCAST) + (v_right * 420)) + (v_up * 25)), 180, ring);
						particle (here, (((v_forward * MSG_BROADCAST) + (v_right * -420)) + (v_up * -25)), 180, ring);
					}
					else
					{
						particle (here, (((v_forward * 375) + (v_right * 375)) + (v_up * 50)), 122, ring);
						particle (here, (((v_forward * -375) + (v_right * -375)) + (v_up * -50)), 122, ring);
						particle (here, (((v_forward * -375) + (v_right * 375)) + (v_up * 50)), 122, ring);
						particle (here, (((v_forward * 375) + (v_right * -375)) + (v_up * -50)), 122, ring);
						particle (here, (((v_forward * 420) + (v_right * MSG_BROADCAST)) + (v_up * 25)), 122, ring);
						particle (here, (((v_forward * -420) + (v_right * MSG_BROADCAST)) + (v_up * -25)), 122, ring);
						particle (here, (((v_forward * MSG_BROADCAST) + (v_right * 420)) + (v_up * 25)), 122, ring);
						particle (here, (((v_forward * MSG_BROADCAST) + (v_right * -420)) + (v_up * -25)), 122, ring);
					}
				}
			}
		}
	}
};
void (vector here) FireworkBall =
{
	local vector dir;
	local float num;
	local float many;
	local float loop;
	num = MSG_BROADCAST;
	many = 15;
	loop = (SVC_INTERMISSION + (random () * 20));
	if ((random () < 0.3))
	{
		while ((num < loop))
		{
			dir_x = (crandom () * 400);
			dir_y = (crandom () * 400);
			dir_z = (crandom () * 400);
			particle (here, dir, 160, many);
			num = (num + SPAWNFLAG_SUPERSPIKE);
		}
	}
	else
	{
		if ((random () < 0.4))
		{
			while ((num < loop))
			{
				dir_x = (crandom () * 400);
				dir_y = (crandom () * 400);
				dir_z = (crandom () * 400);
				particle (here, dir, 72, many);
				num = (num + SPAWNFLAG_SUPERSPIKE);
			}
		}
		else
		{
			if ((random () < 0.4))
			{
				while ((num < loop))
				{
					dir_x = (crandom () * 400);
					dir_y = (crandom () * 400);
					dir_z = (crandom () * 400);
					particle (here, dir, 122, many);
					num = (num + SPAWNFLAG_SUPERSPIKE);
				}
			}
			else
			{
				if ((random () < 0.4))
				{
					while ((num < loop))
					{
						dir_x = (crandom () * 400);
						dir_y = (crandom () * 400);
						dir_z = (crandom () * 400);
						particle (here, dir, 215, many);
						num = (num + SPAWNFLAG_SUPERSPIKE);
					}
				}
				else
				{
					if ((random () > 0.6))
					{
						while ((num < 20))
						{
							dir_x = (crandom () * 400);
							dir_y = (crandom () * 400);
							dir_z = (crandom () * 400);
							particle (here, dir, 180, many);
							num = (num + SPAWNFLAG_SUPERSPIKE);
						}
					}
					else
					{
						while ((num < loop))
						{
							dir_x = (crandom () * 400);
							dir_y = (crandom () * 400);
							dir_z = (crandom () * 400);
							if ((random () > 0.6))
							{
								particle (here, dir, 72, many);
							}
							else
							{
								if ((random () > 0.6))
								{
									particle (here, dir, 160, many);
								}
								else
								{
									particle (here, dir, 215, many);
								}
							}
							num = (num + SPAWNFLAG_SUPERSPIKE);
						}
					}
				}
			}
		}
	}
};
void () FireworkExplode =
{
	self.effects = (self.effects | EF_MUZZLEFLASH);
	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 0.3, ATTN_NORM);
	setorigin (self, (self.origin - '0 0 50'));
	if ((random () < 0.4))
	{
		FireworkBall (self.origin); //FireworkNormalBoom ();
		return;
	}
	if ((random () < 0.3))
	{
		FireworkBall (self.origin);
		remove (self);
		return;
	}
	FireworkBall (self.origin);
	self.velocity = VEC_ORIGIN;
	setmodel (self, "");
	self.nextthink = (time + 0.4);
	self.think = threesteptwo;
};
void () FireworkFly =
{
	traceline (self.origin, (self.origin + '0 0 400'), TRUE, self);
	if (((((trace_fraction != SPAWNFLAG_SUPERSPIKE) || (self.wait < time)) || trace_inwater) || (pointcontents (trace_endpos) == CONTENT_SKY)))
	{
		self.think = FireworkExplode;
		self.nextthink = time;
	}
	else
	{
		self.think = FireworkFly;
		self.nextthink = (time + 0.1);
	}
};
void () FireworkThink =
{
	local entity missile;
	if ((intermission_running && (self.owner.classname == "info_intermission")))
	{
		return;
	}
	self.think = FireworkThink;
	self.nextthink = ((time + (random () * DOOR_DONT_LINK)) + AS_MELEE);
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 0.3, ATTN_NORM);
	missile = spawn ();
	missile.owner = world;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	missile.effects = (missile.effects | EF_DIMLIGHT);
	missile.velocity = '0 0 400';
	missile.angles = vectoangles (missile.velocity);
	missile.touch = FireworkExplode;
	missile.think = FireworkFly;
	missile.nextthink = (time + SPAWNFLAG_SUPERSPIKE);
	missile.wait = ((time + 1.5) + (random () * DOOR_DONT_LINK));
	setmodel (missile, "progs/missile.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, (self.origin + '0 0 5'));
};

void (vector here) CreateFireworks =
{
	local entity Ent;
	if ((pointcontents (here) == CONTENT_SOLID))
	{
		return;
	}
	Ent = spawn ();
	Ent.solid = SOLID_NOT;
	Ent.owner = self;
	Ent.movetype = MOVETYPE_NONE;
	Ent.classname = "fireworks";
	Ent.netname = "Fireworks Display";
	Ent.nextthink = ((time + AS_MELEE) + (random () * SPAWNFLAG_LASER));
	Ent.think = FireworkThink;
	Ent.angles = vectoangles ('0 0 1');
	setsize (Ent, VEC_ORIGIN, VEC_ORIGIN);
	setmodel (Ent, "progs/missile.mdl");
	setorigin (Ent, here);
};
void () SpawnFireworks =
{
	local vector pos;
	traceline (self.origin, (self.origin - '0 0 100000'), TRUE, self);
	pos = trace_endpos;
	traceline (pos, (self.origin + '0 0 300'), TRUE, self);
	if ((trace_fraction >= SPAWNFLAG_SUPERSPIKE))
	{
		CreateFireworks (pos);
		if ((random () > 0.4))
		{
			CreateFireworks ((pos + (crandom () * '20 20 0')));
		}
		if ((random () > 0.5))
		{
			CreateFireworks ((pos + (crandom () * '20 20 0')));
		}
		if ((random () < 0.3))
		{
			CreateFireworks ((pos + (crandom () * '20 20 0')));
		}
	}
};
void () misc_fireworks =
{
	if ((pointcontents (self.origin) == CONTENT_SOLID))
	{
		remove (self);
		return;
	}
	droptofloor ();
	if ((random () < 0.5))
	{
		SpawnFireworks ();
	}
	self.solid = SOLID_NOT;
	self.owner = self;
	self.movetype = MOVETYPE_NONE;
	self.classname = "fireworks";
	self.netname = "Fireworks Display";
	self.nextthink = ((time + AS_MELEE) + (random () * SPAWNFLAG_LASER));
	self.think = FireworkThink;
	self.angles = vectoangles ('0 0 1');
	setsize (self, VEC_ORIGIN, VEC_ORIGIN);
	setmodel (self, "progs/missile.mdl");
};
// for breakables
void () SetSpawnObject =
{
	if (self.spawnobject == 1) item_armor1();
//	else if (self.spawnobject == 2) item_healthkit();
//	else if (self.spawnobject == 3) item_ammo_pistol();
//	else if (self.spawnobject == 4) item_ammo_pistol_large();
//	else if (self.spawnobject == 5)   	item_ammo_smg1();
//	else if (self.spawnobject == 6)   	item_ammo_smg1_large();
//	else if (self.spawnobject == 7)   	item_smg1_grenade();
//	else if (self.spawnobject == 8)   	weapon_supershotgun();
//	else if (self.spawnobject == 9)   	item_box_buckshot();
//	else if (self.spawnobject == 10)   	weapon_supernailgun();
//	else if (self.spawnobject == 11)   	item_box_sniper_rounds();
//	else if (self.spawnobject == 12)   	item_ammo_ar2_large();
//	else if (self.spawnobject == 13)   	item_ammo_ar2_large();
//	else if (self.spawnobject == 14)   	weapon_rocketlauncher();
//	else if (self.spawnobject == 15)   	item_rockets();
//	else if (self.spawnobject == 16)   	item_cells();
//	else if (self.spawnobject == 17)   	weapon_grenadelauncher();
	else if (self.spawnobject == 18)   	weapon_nailgun();
	else if (self.spawnobject == 19)   	weapon_supernailgun();
//	else if (self.spawnobject == 20)   	item_ammo_ar2_large();
//	else if (self.spawnobject == 21)   	weapon_lightning();
};
*/
//END