// mood.. cuz im moody! TEEHEE
void () come_back_again =
{
	if ((COUNT_MOOD_EFX > TRUE))
	{
		COUNT_MOOD_EFX = (COUNT_MOOD_EFX - TRUE);
	}
	if ((COUNT_MOOD_EFX < FL_SWIM))
	{
		if (((random () * 1000) < MOVETYPE_WALK))
		{
			COUNT_MOOD_EFX = 100;
			CHOOSE_ATMOS = (random () * FL_CLIENT);
			if ((CHOOSE_ATMOS > MOVETYPE_PUSH))
			{
				sound (self, CHAN_VOICE, "ambience/jungle1.wav", TRUE, ATTN_NONE);
			}
			if ((CHOOSE_ATMOS > MOVETYPE_TOSS))
			{
				if ((CHOOSE_ATMOS < MOVETYPE_PUSH))
				{
					sound (self, CHAN_VOICE, "ambience/jungle2.wav", TRUE, ATTN_NONE);
				}
			}
			if ((CHOOSE_ATMOS > MOVETYPE_FLY))
			{
				if ((CHOOSE_ATMOS < MOVETYPE_TOSS))
				{
					sound (self, CHAN_VOICE, "ambience/jungle3.wav", TRUE, ATTN_NONE);
				}
			}
			if ((CHOOSE_ATMOS > MOVETYPE_STEP))
			{
				if ((CHOOSE_ATMOS < MOVETYPE_FLY))
				{
					sound (self, CHAN_VOICE, "ambience/jungle4.wav", TRUE, ATTN_NONE);
				}
			}
			if ((CHOOSE_ATMOS > MOVETYPE_WALK))
			{
				if ((CHOOSE_ATMOS < MOVETYPE_STEP))
				{
					sound (self, CHAN_VOICE, "ambience/jungle5.wav", TRUE, ATTN_NONE);
				}
			}
			if ((CHOOSE_ATMOS > FL_SWIM))
			{
				if ((CHOOSE_ATMOS < MOVETYPE_WALK))
				{
					sound (self, CHAN_VOICE, "ambience/jungle6.wav", TRUE, ATTN_NONE);
				}
			}
			if ((CHOOSE_ATMOS < FL_SWIM))
			{
				sound (self, CHAN_VOICE, "ambience/jungle7.wav", TRUE, ATTN_NONE);
			}
		}
	}
	self.think = come_back_again;
	self.nextthink = FL_SWIM;
};
void () amb_mood =
{
	setmodel (self, self.model);
	precache_sound ("ambience/jungle1.wav");
	precache_sound ("ambience/jungle2.wav");
	precache_sound ("ambience/jungle3.wav");
	precache_sound ("ambience/jungle4.wav");
	precache_sound ("ambience/jungle5.wav");
	precache_sound ("ambience/jungle6.wav");
	precache_sound ("ambience/jungle7.wav");
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_NONE;
	self.think = come_back_again;
	self.nextthink = FL_SWIM;
};
void () DebrisBounceSound =
{
	local float r;
	r = random ();
	if ((r < 0.4))
	{
		if ((self.walltype == SPAWNFLAG_LASER))
		{
			sound (self, CHAN_AUTO, "enviro/physics/glassbit.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		}
		else
		{
			sound (self, CHAN_AUTO, "enviro/physics/piece1.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		}
	}
	else
	{
		if ((r < 0.7))
		{
			if ((self.walltype == SPAWNFLAG_LASER))
			{
				sound (self, CHAN_AUTO, "enviro/physics/glassbit.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
			}
			else
			{
				sound (self, CHAN_AUTO, "enviro/physics/piece2.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
			}
		}
		else
		{
			if ((r < 0.9))
			{
				if ((self.walltype == SPAWNFLAG_LASER))
				{
					sound (self, CHAN_AUTO, "enviro/physics/glassbit.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
				}
				else
				{
					sound (self, CHAN_AUTO, "enviro/physics/piece3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
				}
			}
			else
			{
				remove (self);
				return;
			}
		}
	}
	if ((self.velocity == VEC_ORIGIN))
	{
		self.avelocity = VEC_ORIGIN;
	}
};
void () throw_debris =
{
	local entity missile;
	local entity targ;
	targ = find (world, targetname, self.target);
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	missile.touch = DebrisBounceSound;
	makevectors (self.angles);
	missile.velocity = VelocityForDamage (self.health);
	missile.avelocity = '300 100 200';
	if ((targ.classname == "light"))
	{
		missile.nextthink = ((time + 4) + (random () * 4));
	}
	else
	{
		missile.nextthink = ((time + TE_LAVASPLASH) + (random () * TE_LAVASPLASH));
	}
	missile.think = SUB_Remove;
	if (!self.walltype)
	{
		setmodel (missile, "progs/rubble.mdl");
		self.walltype = MSG_BROADCAST;
	}
	if ((self.walltype == MSG_BROADCAST))
	{
		setmodel (missile, "progs/rubble.mdl");
		missile.skin = MSG_BROADCAST;
	}
	else
	{
		if ((self.walltype == SPAWNFLAG_SUPERSPIKE))
		{
			setmodel (missile, "progs/rubble.mdl");
			missile.skin = SPAWNFLAG_SUPERSPIKE;
		}
		else
		{
			if ((self.walltype == SPAWNFLAG_LASER))
			{
				setmodel (missile, "progs/glass.mdl");
				if ((random () < 0.5))
				{
					missile.skin = SPAWNFLAG_LASER;
				}
				else
				{
					if ((random () < 0.5))
					{
						missile.skin = SPAWNFLAG_SUPERSPIKE;
					}
					else
					{
						missile.skin = MSG_BROADCAST;
					}
				}
			}
			else
			{
				if ((self.walltype == AS_MELEE))
				{
					setmodel (missile, "progs/rubble.mdl");
					missile.skin = AS_MELEE;
				}
				else
				{
					if ((self.walltype == 4))
					{
						setmodel (missile, "progs/rubble.mdl");
						missile.skin = 4;
					}
					else
					{
						if ((self.walltype == TE_LIGHTNING1))
						{
							setmodel (missile, "progs/rubble.mdl");
							missile.skin = TE_LIGHTNING1;
						}
						else
						{
							if ((self.walltype == TE_LIGHTNING2))
							{
								setmodel (missile, "progs/rubble.mdl");
								missile.skin = TE_LIGHTNING2;
							}
							else
							{
								if ((self.walltype == TE_WIZSPIKE))
								{
									setmodel (missile, "progs/rubble.mdl");
									missile.skin = TE_WIZSPIKE;
								}
								else
								{
									if ((self.walltype == 8))
									{
										setmodel (missile, "progs/rubble.mdl");
										missile.skin = 8;
									}
									else
									{
										if ((self.walltype == TE_LIGHTNING3))
										{
											setmodel (missile, "progs/rubble.mdl");
											missile.skin = TE_LIGHTNING3;
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
	if ((targ.classname == "light"))
	{
		setmodel (missile, "progs/sglass.mdl");
	}
	if (((random () < 0.25) || (missile.model != "progs/rubble.mdl")))
	{
		missile.frame = MSG_BROADCAST;
	}
	else
	{
		if ((random () < 0.5))
		{
			missile.frame = SPAWNFLAG_SUPERSPIKE;
		}
		else
		{
			if ((random () < 0.75))
			{
				missile.frame = SPAWNFLAG_LASER;
			}
			else
			{
				if ((random () <= SPAWNFLAG_SUPERSPIKE))
				{
					missile.frame = AS_MELEE;
				}
			}
		}
	}
	missile.origin_x = (self.absmin_x + (self.size_x * random ()));
	missile.origin_y = (self.absmin_y + (self.size_y * random ()));
	missile.origin_z = (self.absmin_z + (self.size_z * random ()));
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
};
void () wall_die =
{
	local entity targ;
	targ = find (world, targetname, self.target);
	if ((targ.classname == "light"))
	{
		lightstyle (targ.style, "a");
		self.style = SPAWNFLAG_SUPERSPIKE;
	}
	if ((self.walltype == MSG_BROADCAST))
	{
		sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	}
	else
	{
		if ((self.walltype == SPAWNFLAG_SUPERSPIKE))
		{
			sound (self, CHAN_AUTO, "enviro/physics/wallexpl.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
		}
		else
		{
			if ((self.walltype == SPAWNFLAG_LASER))
			{
				sound (self, CHAN_AUTO, "enviro/physics/glass.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
				sound (self, CHAN_AUTO, "enviro/physics/glass.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
				sound (self, CHAN_AUTO, "enviro/physics/glassbit.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
			}
			else
			{
				if ((self.walltype == AS_MELEE))
				{
					sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
				}
				else
				{
					if ((self.walltype == 4))
					{
						sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
					}
					else
					{
						if ((self.walltype == TE_LIGHTNING1))
						{
							sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
						}
						else
						{
							if ((self.walltype == TE_LIGHTNING2))
							{
								sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
							}
							else
							{
								if ((self.walltype == TE_WIZSPIKE))
								{
									sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
								}
								else
								{
									if ((self.walltype == 8))
									{
										sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
									}
									else
									{
										if ((self.walltype == TE_LIGHTNING3))
										{
											sound (self, CHAN_AUTO, "weapons/r_exp3.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
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
	if ((self.style == SPAWNFLAG_SUPERSPIKE))
	{
		throw_debris ();
		throw_debris ();
		throw_debris ();
		throw_debris ();
		throw_debris ();
		throw_debris ();
		throw_debris ();
	}
	else
	{
		if ((self.style == SPAWNFLAG_LASER))
		{
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
		}
		else
		{
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
			throw_debris ();
		}
	}
	SUB_UseTargets ();
	remove (self);
};
void () wall_touch =
{
	if ((self.cnt == SPAWNFLAG_SUPERSPIKE))
	{
		return;
	}
	if ((other.classname != "player"))
	{
		return;
	}
	self.think = wall_die;
	self.nextthink = (self.ltime + 0.1);
	self.cnt = SPAWNFLAG_SUPERSPIKE;
};
void () wall_explode =
{
	precache_model2 ("progs/sglass.mdl");
	precache_model2 ("progs/glass.mdl");
	precache_model2 ("progs/rubble.mdl");
	precache_sound2 ("enviro/physics/glass.wav");
	precache_sound2 ("enviro/physics/glassbit.wav");
	precache_sound2 ("enviro/physics/wallexpl.wav");
	precache_sound2 ("enviro/physics/piece1.wav");
	precache_sound2 ("enviro/physics/piece2.wav");
	precache_sound2 ("enviro/physics/piece3.wav");
	self.mangle = self.angles;
	self.angles = VEC_ORIGIN;
	self.movetype = MOVETYPE_PUSH;
	setmodel (self, self.model);
	self.solid = SOLID_BSP;
	self.classname = "wall_explode";
	setorigin (self, self.origin);
	if (self.targetname)
	{
		self.use = wall_die;
		self.takedamage = DAMAGE_NO;
		return;
	}
	if (!self.health)
	{
		self.touch = wall_touch;
	}
	else
	{
		self.takedamage = DAMAGE_YES;
		self.th_die = wall_die;
	}
};
void () weapon_napalm =
{
	self.classname = "item_artifact_super_damage";
	item_artifact_super_damage();
};
void () weapon_lightme =
{
	self.classname = "item_artifact_super_damage";
	item_artifact_super_damage();
};
void () weapon_not_a_spear =
{
	self.classname = "item_artifact_super_damage";
	item_artifact_super_damage();
};
void () monster_azoth;
void () monster_legond =
{
	monster_azoth ();
};
//END
