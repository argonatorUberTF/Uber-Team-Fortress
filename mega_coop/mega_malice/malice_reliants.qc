void () dealwithskill =
{
	if (malice_ched)
		return;
// Hack to precache other malice stuff
	precache_model ( "progs/bdrop.mdl" );
	precache_model ( "progs/d_explod.spr" );
	precache_model ( "progs/s_flame1.spr" );
	precache_model ( "progs/s_smoke.spr" );
	precache_model ( "progs/s_flame2.spr" );
	precache_model ( "progs/s_punish.spr" );
	precache_model ( "progs/comet.mdl" );
	precache_sound ("ambience/siren.wav");
	precache_model ( "progs/s_splash.spr" );
	malice_ched = 1;
};

void () trigger_cutscene =
{
	precache_model( "progs/null.spr");
	self.map = "start";
	setmodel (self, "progs/null.spr");
	setsize (self, '-30 -30 -10', '30 30 10');
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_STEP;
	self.touch = changelevel_touch;
};

void () utility_prop =
{
	item_sub ();
};

void () weapon_hellfire =
{
	dremove(self);
};

void(entity ent) MuzzleEnt =
{
	WriteByte (MSG_MULTICAST, SVC_MUZZLEFLASH);
	WriteEntity (MSG_MULTICAST, self);
	multicast (self.origin, MULTICAST_PVS);

};

void(float punch) punchself =
{
};

void(vector org) te_gunshot =
{
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, 2/*TE_GUNSHOTQW*/);
	WriteByte (MSG_MULTICAST, 1);
	WriteCoord (MSG_MULTICAST, org_x);
	WriteCoord (MSG_MULTICAST, org_y);
	WriteCoord (MSG_MULTICAST, org_z);
	multicast (org, MULTICAST_PVS);
};

void () ambient_disco =
{
	precache_sound ("ambience/disco.wav");
	ambientsound (self.origin, "ambience/disco.wav", WEAPON_SHOTGUN, ATTN_NORM);
};

void () ambient_disco2 =
{
	precache_sound ("ambience/disco2.wav");
	ambientsound (self.origin, "ambience/disco2.wav", WEAPON_SHOTGUN, ATTN_NORM);
};

void () plasma1 = [ 0, plasma2 ]
{
};

void () plasma2 = [ 1, plasma3 ]
{
};

void () plasma3 = [ 2, plasma4 ]
{
};

void () plasma4 = [ 3, plasma5 ]
{
};

void () plasma5 = [ 4, plasma6 ]
{
};

void () plasma6 = [ 5, SUB_Remove ]
{
};

void () RailExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	setmodel (self, "progs/s_punish.spr");
	plasma1 ();
};

void () PlasTouch =
{
	local float amount;
	if ((other == self.owner))
	{
		return;
	}
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	amount = (SVC_SETVIEWANGLES + (random () * SVC_SETVIEWANGLES));
	if (other.health)
	{
		T_Damage (other, self, self.owner, amount);
	}
	remove (self);
};

void () W_DeathFire =
{
	local entity plasma;
	sound (self, CHAN_WEAPON, "weapons/plasma.wav", AS_STRAIGHT, ATTN_NORM);
	plasma = spawn ();
	plasma.owner = self;
	plasma.movetype = MOVETYPE_FLYMISSILE;
	plasma.solid = SOLID_BBOX;
	makevectors (self.v_angle);
	plasma.velocity = aim (self, AS_STRAIGHT);
	plasma.velocity = (plasma.velocity * 1500);
	plasma.angles = vectoangles (plasma.velocity);
	plasma.touch = PlasTouch;
	setmodel (plasma, "progs/comet.mdl");
	setsize (plasma, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (plasma, ((self.origin + (v_forward * 20)) + '0 0 18'));
};

void (vector org, vector dir) Flame_bomb;
void () MorterExplode =
{
	local vector dir;
	local vector org;
	makevectors (self.angles);
	dir = vectoangles (v_forward);
	dir_x = MSG_BROADCAST;
	dir_z = MSG_BROADCAST;
	org = (self.origin + (v_forward * -10));
	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", AS_STRAIGHT, ATTN_NORM);
	self.effects = (self.effects | EF_DIMLIGHT);
	BecomeExplosion ();
	if ((pointcontents (self.origin) == CONTENT_WATER))
	{
		return;
	}
	Flame_bomb (org, (dir + '0 45 0'));
	Flame_bomb (org, (dir + '0 135 0'));
	Flame_bomb (org, (dir + '0 225 0'));
	Flame_bomb (org, (dir + '0 315 0'));
	if (deathmatch)
	{
		Flame_bomb (org, (('0 1 0' * random ()) * 360));
		Flame_bomb (org, (('0 1 0' * random ()) * 360));
		return;
	}
	Flame_bomb (org, dir);
	Flame_bomb (org, (dir + '0 90 0'));
	Flame_bomb (org, (dir + '0 180 0'));
	Flame_bomb (org, (dir + '0 270 0'));
};

void() CheckTouch;

void () MorterTouch =
{
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	MorterExplode ();
	T_RadiusDamage (self, self.owner, 90, other);
	if ((other == self.owner))
	{
		return;
	}
	if (other.health)
	{
		T_Damage (other, self, self.owner, 60);
		CheckTouch ();
	}
};

void (entity head7) Enolagay;
void () AtomSmash;
void () ionstorm;

void (float limit) W_FireBigassGun =
{
	local entity pulse;
	local entity body;
	punchself(CONTENT_SLIME);
	pulse = spawn ();
	pulse.owner = self;
	pulse.classname = "AtomSmasher";
	pulse.movetype = MOVETYPE_FLYMISSILE;
	pulse.solid = SOLID_BBOX;
	makevectors (self.v_angle);
	pulse.velocity = aim (self, 1000);
	pulse.velocity = (pulse.velocity * 800);
	pulse.angles = vectoangles (pulse.velocity);
	pulse.avelocity = '0 0 250';
	pulse.touch = AtomSmash;
	pulse.effects = EF_DIMLIGHT;
	pulse.nextthink = time + .01;
	pulse.think = ionstorm;
	setmodel (pulse, "progs/null.spr");
	setsize (pulse, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (pulse, ((self.origin + (v_forward * 22)) + '0 0 18'));
	sound (self, CHAN_WEAPON, "misc/discharg.wav", AS_STRAIGHT, ATTN_NORM);
	serverflags = (serverflags / H_MEGA);
	if (!(serverflags & 15))
	{
		self.tools = (self.tools - (self.tools & UT_BIGASSGUN));
		body = find (world, netname, "Atom Smasher");
		if (((body != world) && deathmatch))
		{
			body.think = SUB_regen;
			body.nextthink = (time + 120);
		}
		W_SetCurrentAmmo ();
		if (((self.tools == (self.tools | UT_SCUBA)) && (self.flags & FL_INWATER)))
		{
			self.modelindex = modelindex_scuba;
		}
		else
		{
			self.modelindex = modelindex_player;
		}
	}
	self.velocity = (self.velocity - (aim (self, AS_STRAIGHT) * 1000));
};

void () ionstorm =
{
	makevectors (self.angles);
	
	SpawnBlood ((self.origin + (v_right * SVC_INTERMISSION)), 15);
	SpawnBlood ((self.origin + (v_right * -30)), 15);
	SpawnBlood ((self.origin + (v_up * SVC_INTERMISSION)), 15);
	SpawnBlood ((self.origin + (v_up * -30)), 15);
	self.nextthink = (time + 0.05);

};

void () blow_baby =
{
	if ((self.frame == SVC_TEMPENTITY))
	{
		remove (self);
	}
	else
	{
		self.frame = (self.frame + AS_STRAIGHT);
	}
	self.nextthink = time;
};

void (entity victim) BreakDown =
{
	local float intensity;

	sound (victim, CHAN_WEAPON, "misc/thud.wav", AS_STRAIGHT, ATTN_NORM);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LAVASPLASH);
	WriteCoord (MSG_BROADCAST, victim.origin_x);
	WriteCoord (MSG_BROADCAST, victim.origin_y);
	WriteCoord (MSG_BROADCAST, (victim.origin_z - 50));
	intensity = (self.owner.atomic_intensity * 300);
	T_Damage (victim, self, self.owner, intensity);
};

void () AtomSmash =
{
	local entity victim;
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	sound (self, CHAN_WEAPON, "misc/thud.wav", AS_STRAIGHT, ATTN_NORM);
	if ((self.owner.classname == "player"))
	{
		self.owner.warp_factor = AS_STRAIGHT;
		Enolagay (self.owner);
	}
	victim = findradius (self.origin, 800);
	while (victim)
	{
		if ((victim.takedamage && (victim != self.owner)))
		{
			traceline (self.origin, victim.origin, TRUE, self);
			if ((trace_fraction == AS_STRAIGHT))
			{
				BreakDown (victim);
			}
			if ((victim.classname == "player"))
			{
				victim.warp_factor = AS_STRAIGHT;
				Enolagay (victim);
			}
		}
		victim = victim.chain;
	}
	if ((self.classname != "player"))
	{
		self.think = SUB_Remove;
		self.nextthink = time;
	}
};

void () OverLoad =
{
	local entity victim;
	T_RadiusDamage (self, self, 2000, world);
	sound (self, CHAN_WEAPON, "misc/ion.wav", AS_STRAIGHT, ATTN_NORM);
	victim = findradius (self.origin, 800);
	while (victim)
	{
		if ((victim.takedamage && (victim != self)))
		{
			traceline (self.origin, victim.origin, TRUE, self);
			if ((trace_fraction == AS_STRAIGHT))
			{
				BreakDown (victim);
			}
			if ((victim.classname == "player"))
			{
				victim.warp_factor = AS_STRAIGHT;
				Enolagay (victim);
			}
		}
		victim = victim.chain;
	}
};

void () shell1 = [ 0, shell2 ]
{
};

void () shell2 = [ 1, shell3 ]
{
};

void () shell3 = [ 2, shell4 ]
{
};

void () shell4 = [ 3, shell5 ]
{
};

void () shell5 = [ 4, shell6 ]
{
};

void () shell6 = [ 5, shell7 ]
{
};

void () shell7 = [ 6, shell8 ]
{
};

void () shell8 = [ 7, SUB_Remove ]
{
};


void () Hmmm_something_burning;

void (entity head7) Enolagay =
{
	local entity bomby;
	bomby = spawn ();
	bomby.owner = head7;
	setorigin (bomby, head7.origin);
	bomby.think = Hmmm_something_burning;
	bomby.nextthink = time;
};

void () Hmmm_something_burning =
{
	if ((self.owner.classname != "player"))
	{
		return;
	}
	if ((self.owner.warp_factor == WEAPON_SHOTGUN))
	{
		stuffcmd (self.owner, "fov 179\n");
	}
	else
	{
		if ((self.owner.warp_factor == WEAPON_ROCKET))
		{
			stuffcmd (self.owner, "fov 175\n");
		}
		else
		{
			if ((self.owner.warp_factor == AS_MELEE))
			{
				stuffcmd (self.owner, "fov 165\n");
			}
			else
			{
				if ((self.owner.warp_factor == WEAPON_SPIKES))
				{
					stuffcmd (self.owner, "fov 150\n");
				}
				else
				{
					if ((self.owner.warp_factor == SVC_SETVIEWPORT))
					{
						stuffcmd (self.owner, "fov 130\n");
					}
					else
					{
						if ((self.owner.warp_factor == TE_LIGHTNING2))
						{
							stuffcmd (self.owner, "fov 110\n");
						}
						else
						{
							if ((self.owner.warp_factor == TE_WIZSPIKE))
							{
								stuffcmd (self.owner, "fov 90\n");
							}
							else
							{
								if ((self.owner.warp_factor == WEAPON_BIG))
								{
									stuffcmd (self.owner, "fov 80\n");
								}
								else
								{
									if ((self.owner.warp_factor == TE_LIGHTNING3))
									{
										stuffcmd (self.owner, "fov 75\n");
									}
									else
									{
										if ((self.owner.warp_factor == SVC_SETVIEWANGLES))
										{
											stuffcmd (self.owner, "fov 70\n");
										}
										else
										{
											if ((self.owner.warp_factor == TE_TELEPORT))
											{
												stuffcmd (self.owner, "fov 75\n");
											}
											else
											{
												if ((self.owner.warp_factor == 12))
												{
													stuffcmd (self.owner, "fov 80\n");
												}
												else
												{
													if ((self.owner.warp_factor == 13))
													{
														stuffcmd (self.owner, "fov 85\n");
													}
													else
													{
														stuffcmd (self.owner, "fov 90\n");
														self.think = SUB_Null;
														return;
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	self.owner.warp_factor = (self.owner.warp_factor + WEAPON_SHOTGUN);
	self.think = Hmmm_something_burning;
	self.nextthink = (time + 0.05);
};

void () UpdateAmmoBars =
{
	local float bar;
	local float percent;
	local float special_happy_count;
	special_happy_count = MSG_BROADCAST;
	percent = self.ammo_shells2;
	while ((special_happy_count < WEAPON_SPIKES))
	{
		if ((special_happy_count == WEAPON_SHOTGUN))
		{
			percent = (self.ammo_nails2 / WEAPON_ROCKET);
		}
		else
		{
			if ((special_happy_count == WEAPON_ROCKET))
			{
				percent = self.ammo_rockets2;
			}
			else
			{
				if ((special_happy_count == AS_MELEE))
				{
					percent = self.ammo_cells2;
				}
			}
		}
		if ((percent > 90))
		{
			percent = rint (((100 - percent) / SVC_SETVIEWANGLES));
			bar = (((WEAPON_SHOTGUN - percent) * 100) + 99);
		}
		else
		{
			if ((percent > 45))
			{
				percent = rint ((((90 - percent) * TE_LIGHTNING3) / 45));
				bar = (((TE_LIGHTNING3 - percent) * SVC_SETVIEWANGLES) + TE_LIGHTNING3);
			}
			else
			{
				percent = rint ((((45 - percent) * TE_LIGHTNING3) / 45));
				bar = (TE_LIGHTNING3 - percent);
			}
		}
		if ((special_happy_count == MSG_BROADCAST))
		{
			self.ammo_shells = bar;
		}
		else
		{
			if ((special_happy_count == WEAPON_SHOTGUN))
			{
				self.ammo_nails = bar;
			}
			else
			{
				if ((special_happy_count == WEAPON_ROCKET))
				{
					self.ammo_rockets = bar;
				}
				else
				{
					if ((special_happy_count == AS_MELEE))
					{
						self.ammo_cells = bar;
					}
				}
			}
		}
		special_happy_count = (special_happy_count + WEAPON_SHOTGUN);
	}
};
void (vector org, vector dir) malice_launch_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles (dir);
	newmis.touch = spike_touch;
	newmis.classname = "spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = (time + TE_LIGHTNING2);
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);
	newmis.velocity = (dir * 1000);
};
//END
