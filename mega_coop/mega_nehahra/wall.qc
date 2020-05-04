void () doom_barrel_think, doom_barrel_die;
void () Anglechecking =
{
	if ((self.angles_x > 360))
	{
		self.angles_x = (self.angles_x - 360);
	}
	if ((self.angles_x < 0))
	{
		self.angles_x = (self.angles_x + 360);
	}
	if ((self.angles_y > 360))
	{
		self.angles_y = (self.angles_y - 360);
	}
	if ((self.angles_y < 0))
	{
		self.angles_y = (self.angles_y + 360);
	}
	if ((self.angles_z > 360))
	{
		self.angles_z = (self.angles_z - 360);
	}
	if ((self.angles_z < 0))
	{
		self.angles_z = (self.angles_z + 360);
	}
};
void () setup_explodable =
{
	local float num;
	local float bah;
	if ((self.spawnflags & 1))
	{
		bah = 2;
	}
	else
	{
		bah = 1;
	}
	if ((self.dmg > bah))
	{
		self.dmg = 0;
	}
	if (((self.blink < 0.1) || (self.blink > 0.9)))
	{
		self.blink = 0;
	}
	num = ((self.ammo_shells + self.ammo_cells) + self.ammo_rockets) + self.ammo_nails;
	if ((num != 0))
	{
		precache_ammo ();
	}
	if (((self.items > 0) || (self.armorvalue > 0)))
	{
		precache_thrown (self.items);
	}
	if ((self.spawnflags & FL_FLY))
	{
		precache_model ("progs/frubble1.mdl");
		precache_model ("progs/frubble2.mdl");
		precache_model ("progs/frubble3.mdl");
	}
	else
	{
		precache_model ("progs/rubble1.mdl");
		precache_model ("progs/rubble2.mdl");
		precache_model ("progs/rubble3.mdl");
		precache_model ("progs/rubble4.mdl");
		precache_model ("progs/rubble5.mdl");
		precache_model ("progs/rubble6.mdl");
	}
	if ((self.sounds == 0))
	{
		precache_sound ("wall/wall01.wav");
		self.noise1 = "wall/wall01.wav";
	}
	else
	{
		if ((self.sounds == 1))
		{
			precache_sound ("wall/rubble.wav");
			self.noise1 = "wall/rubble.wav";
		}
		else
		{
			if ((self.sounds == 2))
			{
				precache_sound ("wall/wallbrk.wav");
				self.noise1 = "wall/wallbrk.wav";
			}
			else
			{
				if ((self.sounds == 3))
				{
					precache_sound ("wall/woodbrk.wav");
					self.noise1 = "wall/woodbrk.wav";
				}
				else
				{
					if ((self.sounds == 4))
					{
						precache_sound ("wall/glassbrk.wav");
						self.noise1 = "wall/glassbrk.wav";
					}
					else
					{
						if ((self.sounds == 5))
						{
							precache_sound ("wall/thngland.wav");
							self.noise1 = "wall/thngland.wav";
						}
						else
						{
							if ((self.sounds == 6))
							{
								precache_sound ("wall/metalbrk.wav");
								self.noise1 = "wall/metalbrk.wav";
							}
							else
							{
								if ((self.sounds == 7))
								{
									precache_sound ("wall/claybrk.wav");
									self.noise1 = "wall/claybrk.wav";
								}
								else
								{
									precache_sound ("misc/null.wav");
									self.noise1 = "misc/null.wav";
								}
							}
						}
					}
				}
			}
		}
	}
};
void () func_cover =
{
	self.angles = VEC_ORIGIN;
	self.movetype = MOVETYPE_PUSH;
	self.solid = SOLID_BSP;
	self.use = SUB_Remove;
	setmodel (self, self.model);
	if ((self.spawnflags & FL_FLY))
	{
		self.model = string_null;
	}
};
void () func_pain =
{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_PUSH;
	self.solid = SOLID_BSP;
	pain_deathtype ();
	if ((self.dmg < 1))
	{
		self.dmg = 1;
	}
	self.touch = painz_touch;
	setmodel (self, self.model);
};
void () pain_deathtype =
{
	if ((self.cnt < 1))
	{
		self.deathtype = "simple";
		return;
	}
	if ((self.cnt == 1))
	{
		self.deathtype = "hotp";
	}
	else
	{
		if ((self.cnt == 2))
		{
			self.deathtype = "impaled";
		}
		else
		{
			if ((self.cnt == 3))
			{
				self.deathtype = "diced";
			}
			else
			{
				if ((self.cnt == 4))
				{
					self.deathtype = "hod";
				}
				else
				{
					if ((self.cnt == 5))
					{
						self.deathtype = "hell";
					}
					else
					{
						if ((self.cnt == 6))
						{
							self.deathtype = "void";
						}
						else
						{
							if ((self.cnt == 7))
							{
								self.deathtype = "swal";
							}
							else
							{
								if ((self.cnt == 8))
								{
									self.deathtype = "hotm";
								}
							}
						}
					}
				}
			}
		}
	}
};
void () painz_touch =
{
	if ((((other.flags & FL_CLIENT) || other.flags) & FL_MONSTER))
	{
		if (((self.classname == "func_bobbingobject") && (other.health <= self.dmg)))
		{
			self.dmg = (self.dmg + 100);
		}
		T_Damage (other, self, self, self.dmg);
	}
};
void (string gibname, float dm) ThrowRubble =
{
	local entity new;
	new = spawn ();
	new.origin_x = (self.absmin_x + (random () * self.size_x));
	new.origin_y = (self.absmin_y + (random () * self.size_y));
	new.origin_z = (self.absmin_z + (random () * self.size_z));
	setmodel (new, gibname);
	setsize (new, VEC_ORIGIN, VEC_ORIGIN);
	new.skin = self.dmg;
	new.alpha = self.blink;
	new.alpha = self.alpha;
	new.velocity = VelocityForDamage (dm);
	new.movetype = MOVETYPE_BOUNCE;
	new.solid = SOLID_NOT;
	new.avelocity_x = (random () * 600);
	new.avelocity_y = (random () * 600);
	new.avelocity_z = (random () * 600);
	new.think = SUB_Remove;
	new.ltime = time;
	new.nextthink = ((time + MOVETYPE_WALK) + (random () * MOVETYPE_BOUNCEMISSILE));
	new.frame = 0;
	new.flags = 0;
};
void () exploding_wall_use =
{
	activator = self;
	SUB_UseTargets ();
};
void () wall_killed =
{
	local float rubble_count;
	local float num;
	self.use = SUB_Null;
	self.th_die = SUB_Null;
	SUB_UseTargets ();
	sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	rubble_count = ((self.size_x * self.size_y) * self.size_z) / 600000;
	if ((self.classname == "func_sobject"))
	{
		rubble_count = rint ((rubble_count / 2));
	}
	if (rubble_count > 12)
		rubble_count = 12;
	while ((rubble_count > CONTENT_EMPTY))
	{
		Rubblesets ();
		rubble_count = rubble_count - 1;
	}
	yield_armor ();
	num = ((self.ammo_shells + self.ammo_cells) + self.ammo_rockets) + self.ammo_nails;
	if (((num != 0) || (self.items > 0)))
	{
		yield_items ();
	}
	remove (self);
};
void () Rubblesets =
{
	if ((self.spawnflags & FL_FLY))
	{
		if (((self.dmg > 2) || (self.dmg < 0)))
		{
			self.dmg = 0;
		}
		ThrowRubble ("progs/frubble1.mdl", self.health);
		ThrowRubble ("progs/frubble2.mdl", self.health);
		ThrowRubble ("progs/frubble3.mdl", self.health);
		return;
	}
	if (((self.dmg > 1) || (self.dmg < 0)))
	{
		self.dmg = 0;
	}
	if ((self.classname == "func_sobject"))
	{
		ThrowRubble ("progs/rubble1.mdl", self.health);
		ThrowRubble ("progs/rubble2.mdl", self.health);
		ThrowRubble ("progs/rubble3.mdl", self.health);
		return;
	}
	if ((random () < 0.5))
	{
		ThrowRubble ("progs/rubble5.mdl", self.health);
		ThrowRubble ("progs/rubble2.mdl", self.health);
		ThrowRubble ("progs/rubble3.mdl", self.health);
		return;
	}
	ThrowRubble ("progs/rubble4.mdl", self.health);
	ThrowRubble ("progs/rubble6.mdl", self.health);
	ThrowRubble ("progs/rubble1.mdl", self.health);
};
void () info_throw_rubble =
{
	local float t;
	if ((self.spawnflags & 1))
	{
		t = 2;
	}
	else
	{
		t = 1;
	}
	if ((self.spawnflags & FL_FLY))
	{
		if (((self.dmg > 2) || (self.dmg < 0)))
		{
			self.dmg = 0;
		}
		precache_model ("progs/frubble1.mdl");
		precache_model ("progs/frubble2.mdl");
		precache_model ("progs/frubble3.mdl");
		return;
	}
	else
	{
		if (((self.dmg > 1) || (self.dmg < 0)))
		{
			self.dmg = 0;
		}
		precache_model ("progs/rubble1.mdl");
		precache_model ("progs/rubble2.mdl");
		precache_model ("progs/rubble3.mdl");
		precache_model ("progs/rubble4.mdl");
		precache_model ("progs/rubble5.mdl");
		precache_model ("progs/rubble6.mdl");
	}
	if ((self.cnt > 0))
	{
		self.cnt = (self.cnt * -1);
	}
	self.use = throwrub;
};
void () throwrub =
{
	Rubblesets ();
	remove (self);
};
void () func_explodable =
{
	func_wall ();		// xavior note: if this ain't called first, it ain't solid. No idea why.
	exploding_wall ();
};
void () func_quakedmg =
{
	self.health = 5000;
	exploding_wall ();
};
void () func_sobject =
{
	if (!self.health)
	{
		self.health = 15;
	}
	exploding_wall ();
};
void () exploding_wall =
{
	local vector tempvec;
	local entity te, oself;
	setmodel (self, self.model);
	setup_explodable ();
	if (self.targetname)
	{
		self.use = wall_killed;
	}
	self.flags = FL_BLOODLESS;
	self.solid = SOLID_BBOX;
	self.solid = SOLID_BSP;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	if (!self.health)
	{
		self.health = 100;
	}
	self.th_die = wall_killed;
	self.takedamage = DAMAGE_YES;
	if ((world.wad == "q2q1tex.wad" || #DOOM_MAP) && self.use == wall_killed)
	{
		self.takedamage = DAMAGE_NO;		// can only be killed by a trigger
	}
	
	if (#DOOM_MAP)
	{
		tempvec = self.maxs-self.mins;
		if (tempvec == '38 38 46' || tempvec == '36 36 42')
		{
			oself = self;
			precache_model("progs/barrel.spr");
			te = spawn();
			setmodel(te, "progs/barrel.spr");
			setorigin(te, ((self.maxs+self.mins)*0.5));
			te.solid = SOLID_BBOX;
			setsize (te, VEC_HULL_MIN, '16 16 40');
			self = te;
			droptofloor();
			self.think = doom_barrel_think;
			self.takedamage = 1;
			self.health = oself.health;
			if (!oself.dmg)
				self.dmg = 140;
			else
				self.dmg = oself.dmg*2;
			self.noise1 = oself.noise1;
			self.th_die = doom_barrel_die;
			self.nextthink = time;
			self = oself;
			dremove(self);
		}
	}
	
};
void () func_bobbingobject =
{
dremove(self);
	if ((self.dmg > 0))
	{
		if ((self.spawnflags & FL_MONSTER))
		{
			self.touch = squish_touch2;
		}
		else
		{
			self.touch = painz_touch;
		}
		if ((self.cnt > 0))
		{
			pain_deathtype ();
		}
	}
	if ((self.sounds == 1))
	{
		precache_sound ("machine/m1_st.wav");
		precache_sound ("machine/m1_go.wav");
		precache_sound ("machine/m1_xx.wav");
	}
	if ((self.sounds == 2))
	{
		precache_sound ("machine/m2_st.wav");
		precache_sound ("machine/m2_go.wav");
		precache_sound ("machine/m2_xx.wav");
	}
	if ((self.sounds == 3))
	{
		precache_sound ("machine/m3_st.wav");
		precache_sound ("machine/m3_go.wav");
		precache_sound ("machine/m3_xx.wav");
	}
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_PUSH;
	self.solid = SOLID_BSP;
	setmodel (self, self.model);
	setorigin (self, self.origin);
	if (self.targetname)
	{
		if ((self.spawnflags & START_ON))
		{
			self.use = bobber_off;
		}
		else
		{
			self.use = bobber_on;
			self.think = SUB_Null;
		}
	}
	else
	{
	}
	self.count = 0;
	self.cnt = (self.size_z / 2);
	if (!self.speed)
	{
		self.speed = 4;
	}
	self.speed = (1000 / self.speed);
	if (!self.think || self.think == SUB_Null) {
		bprint(2,"BAAAAHHH\n");
		return;
	}
	self.nextthink = (time + 0.02);
	self.ltime = time;
	if ((self.sounds > 0))
	{
		spawn_mchsnd ();
	}
};
void () bobber_on =
{
	self.use = bobber_off;
	self.nextthink = (time + 0.02);
	if ((self.sounds == 0))
	{
		return;
	}
	if ((self.sounds == 1))
	{
		sound (self, CHAN_VOICE, "machine/m1_st.wav", 1, ATTN_NORM);
	}
	if ((self.sounds == 2))
	{
		sound (self, CHAN_VOICE, "machine/m2_st.wav", 1, ATTN_NORM);
	}
	if ((self.sounds == 3))
	{
		sound (self, CHAN_VOICE, "machine/m3_st.wav", 1, ATTN_NORM);
	}
};
void () bobber_off =
{
	self.think = SUB_Null;
	self.nextthink = (time + 0.2);
	self.use = bobber_on;
	if ((self.sounds == 0))
	{
		return;
	}
	if ((self.sounds == 1))
	{
		sound (self, CHAN_VOICE, "machine/m1_xx.wav", 1, ATTN_NORM);
	}
	if ((self.sounds == 2))
	{
		sound (self, CHAN_VOICE, "machine/m2_xx.wav", 1, ATTN_NORM);
	}
	if ((self.sounds == 3))
	{
		sound (self, CHAN_VOICE, "machine/m3_xx.wav", 1, ATTN_NORM);
	}
};
void () spawn_mchsnd =
{
	local entity mach;
	local vector spot;
	mach = spawn ();
	spot = Sub_CalcOrigin (self);
	mach.origin = spot;
	setorigin (mach, spot);
	mach.classname = "mchsnd";
	mach.enemy = self;
	mach.think = mchsnd_think;
	mach.nextthink = (time + 0.5);
};
void () mchsnd_think =
{
	if ((self.enemy.think == SUB_Null))
	{
		self.nextthink = (time + 0.2);
		return;
	}
	if ((self.enemy.sounds == 1))
	{
		sound (self, CHAN_AUTO, "machine/m1_go.wav", 1, ATTN_NORM);
	}
	if ((self.enemy.sounds == 2))
	{
		sound (self, CHAN_AUTO, "machine/m2_go.wav", 1, ATTN_NORM);
	}
	if ((self.enemy.sounds == 3))
	{
		sound (self, CHAN_AUTO, "machine/m3_go.wav", 1, ATTN_NORM);
	}
	self.nextthink = (time + 0.5);
};
void () func_mindcrime =
{
	setorigin (self, self.origin);
	setmodel (self, self.model);
	setsize (self, self.mins, self.maxs);
	self.use = object_fall;
	setup_explodable ();
	self.flags = FL_BLOODLESS;
	self.solid = SOLID_BBOX;
	pain_deathtype ();
	self.movetype = MOVETYPE_NONE;
	if (!self.health)
	{
		self.health = 100;
	}
	if ((self.nojump < 0))
	{
		self.nojump = (self.nojump * -1);
	}
	if ((self.spawnflags & MC_CONTROL))
	{
		if ((self.boost < 1))
		{
			self.boost = 1;
		}
		SetMovedir ();
	}
	self.max_health = self.health;
	self.th_die = object_fall;
	self.takedamage = DAMAGE_YES;
};
void () object_fall =
{
	SUB_UseTargets ();
	if ((self.flags & FL_ONGROUND))
	{
		self.flags = (self.flags - (self.flags & FL_ONGROUND));
	}
	if ((self.spawnflags != FALSE))
	{
		mindcrime_throw ();
	}
	self.use = SUB_Null;
	self.takedamage = DAMAGE_NO;
	if ((self.health > 0))
	{
		self.health = -100;
	}
	self.movetype = MOVETYPE_STEP;
	self.solid = SOLID_SLIDEBOX;
	if (self.speed)
	{
		self.touch = squish_touch;
	}
	self.think = wait_to_die;
	self.nextthink = (time + 0.1);
};
void () wait_to_die =
{
	checkbottom (self);
	if ((checkbottom (self) && (self.velocity_z == 0)))
	{
		self.touch = SUB_Null;
		if ((self.impulse == 0))
		{
			self.think = SUB_Null;
			self.solid = SOLID_BSP;
			self.movetype = MOVETYPE_PUSH;
			return;
		}
		if ((self.impulse == 1))
		{
			self.touch = player_push2;
			self.think = SUB_Null;
			return;
		}
		if ((self.impulse == 2))
		{
			wall_killed ();
			return;
		}
		if ((self.impulse == 3))
		{
			self.movetype = MOVETYPE_BOUNCE;
			if (((pointcontents (self.origin) == CONTENT_WATER) || (pointcontents (self.origin) == CONTENT_SLIME)))
			{
				self.think = fgib_think;
				self.nextthink = (time + 0.1);
				return;
			}
		}
	}
	self.think = wait_to_die;
	self.nextthink = (time + 0.1);
};
#ifndef mtf_coop_halflife
void () player_push2 =
{
	if ((other.classname != "player"))
	{
		return;
	}
	if ((walkmove (other.angles_y, 2) == FALSE))
	{
		self.velocity_x = (other.velocity_x + (400 * random ()));
		self.velocity_y = (other.velocity_y + (400 * random ()));
	}
};
#endif
void () squish_touch =
{
	local vector spot;
	if ((other.flags & FL_CLIENT))
	{
		spot = self.absmin + ((self.absmax - self.absmin) * 0.5);
		spot = spot - '0 0 10';
		if ((other.origin_z < spot_z))
		{
			T_Damage (other, self, self, self.speed);
		}
	}
};
void () squish_touch2 =
{
	local vector spot;
	if ((other.flags & FL_CLIENT))
	{
		spot = self.absmin + ((self.absmax - self.absmin) * 0.5);
		spot = spot - '0 0 10';
		if ((other.origin_z < spot_z))
		{
			T_Damage (other, self, self, self.dmg);
		}
	}
};
void () func_object =
{
	setmodel (self, self.model);
	setorigin (self, self.origin);
	setsize (self, self.mins, self.maxs);
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.touch = player_push2;
};
void () mindcrime_throw =
{
	if ((self.spawnflags & MC_CONTROL))
	{
		self.velocity = ((self.movedir * self.boost) + '0 0 20');
	}
	if ((self.spawnflags & MC_UP))
	{
		self.origin_z = (self.origin_z + 1);
		self.velocity_z = self.nojump;
	}
};
void () breakable_brush =
{
	func_explodable();
};
//END
