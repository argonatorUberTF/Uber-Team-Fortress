float (entity targ) clean_shot =
{
	local vector spot1;
	local vector spot2;
	spot1 = (self.origin + self.view_ofs);
	spot2 = (targ.origin + targ.view_ofs);
	traceline (spot1, spot2, FALSE, self);
	if ((trace_ent != targ))
	{
		return (FALSE);
	}
	return (TRUE);
};
void () make_breakable_debris =
{
	local float i;
	local entity new;
	i = MSG_BROADCAST;
	while ((i < self.cnt))
	{
		new = spawn ();
		new.origin_x = (((self.maxs_x - self.mins_x) * random ()) + self.mins_x);
		new.origin_y = (((self.maxs_y - self.mins_y) * random ()) + self.mins_y);
		new.origin_z = (((self.maxs_z - self.mins_z) * random ()) + self.mins_z);
		setmodel (new, "progs/debris.mdl");
		setsize (new, VEC_ORIGIN, VEC_ORIGIN);
		new.velocity = VelocityForDamage ((self.health * SPAWNFLAG_LASER));
		new.movetype = MOVETYPE_BOUNCE;
		new.solid = SOLID_NOT;
		new.avelocity_x = (random () * 600);
		new.avelocity_y = (random () * 600);
		new.avelocity_z = (random () * 600);
		new.think = SUB_Remove;
		new.ltime = time;
		new.nextthink = ((time + TE_LAVASPLASH) + (random () * TE_LAVASPLASH));
		new.flags = MSG_BROADCAST;
		if ((random () > 0.333))
		{
			new.frame = SPAWN_CRUCIFIED;
		}
		else
		{
			new.frame = SPAWNFLAG_LASER;
		}
		if ((self.style == SPAWN_CRUCIFIED))
		{
			new.skin = SPAWN_CRUCIFIED;
		}
		if ((self.style == SPAWNFLAG_LASER))
		{
			new.skin = SPAWNFLAG_LASER;
		}
		i = (i + SPAWN_CRUCIFIED);
	}
};
void () func_breakable_die =
{
	self.origin = ((self.absmin + self.absmax) * 0.5);
	setorigin (self, self.origin);
	make_breakable_debris ();
	remove (self);
};
void () func_breakable_killed =
{
	activator = damage_attacker;
	SUB_UseTargets ();
	func_breakable_die ();
};
void () func_breakable_use =
{
	activator = other;
	SUB_UseTargets ();
	func_breakable_die ();
};
void () func_breakable =
{
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	setmodel (self, self.model);
	precache_model ("progs/debris.mdl");
	if (!self.health)
	{
		self.health = 20;
	}
	if (!self.cnt)
	{
		self.cnt = TE_LIGHTNING2;
	}
	if (self.targetname)
	{
		self.use = func_breakable_use;
	}
	else
	{
		self.takedamage = DAMAGE_YES;
		self.th_die = func_breakable_killed;
	}
};
void () func_explobox_explode =
{
	self.takedamage = DAMAGE_NO;
	self.origin = ((self.absmin + self.absmax) * 0.5);
	self.classname = "explo_box";
	T_RadiusDamage (self, self, self.dmg, world);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	BecomeExplosion ();
	sound (self, CHAN_VOICE, "weapons/r_exp3.wav", SPAWN_CRUCIFIED, ATTN_NORM);
};
void () func_explobox_die =
{
	self.nextthink = 0.2;
	self.think = func_explobox_explode;
};
void () func_explobox =
{
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	setmodel (self, self.model);
	precache_sound ("weapons/r_exp3.wav");
	if (!self.health)
	{
		self.health = 20;
	}
	if (!self.dmg)
	{
		self.dmg = 100;
	}
	self.th_die = func_explobox_die;
	self.takedamage = DAMAGE_AIM;
};
void () laser_helper_think =
{
	if ((!self.owner || (self.owner.classname != "func_laser")))
	{
		remove (self);
		return;
	}
	if (!(self.owner.spawnflags & START_OFF))
	{
		self.owner.alpha = ((self.alpha * 0.8) + ((self.alpha * random ()) * 0.4));
	}
	self.nextthink = (time + 0.05);
};
void () func_laser_touch =
{
	if ((other.takedamage && (self.attack_finished < time)))
	{
		T_Damage (other, self, self, self.dmg);
		self.attack_finished = (time + 0.1);
	}
};
void () func_laser_use =
{
	if ((self.spawnflags & START_OFF))
	{
		setorigin (self, VEC_ORIGIN);
		self.spawnflags = (self.spawnflags - START_OFF);
		sound (activator, CHAN_VOICE, "misc/laser_on.wav", SPAWN_CRUCIFIED, ATTN_NORM);
		if (((activator.classname == "player") && (self.message != "")))
		{
			centerprint (activator, self.message);
		}
	}
	else
	{
		setorigin (self, '0 0 9000');
		self.spawnflags = (self.spawnflags + START_OFF);
		sound (activator, CHAN_VOICE, "misc/laseroff.wav", SPAWN_CRUCIFIED, ATTN_NORM);
		if (((activator.classname == "player") && (self.message2 != "")))
		{
			centerprint (activator, self.message2);
		}
	}
};
void () func_laser =
{
	local entity helper;
	setmodel (self, self.model);
	precache_sound ("misc/laser_on.wav");
	precache_sound ("misc/laseroff.wav");
	if ((self.spawnflags & LASER_SOLID))
	{
		self.solid = SOLID_BSP;
		self.movetype = MOVETYPE_PUSH;
	}
	else
	{
		self.solid = SOLID_TRIGGER;
		self.movetype = MOVETYPE_NONE;
	}
	if (!self.alpha)
	{
		self.alpha = 0.5;
	}
	if (!self.dmg)
	{
		self.dmg = SPAWN_CRUCIFIED;
	}
	self.use = func_laser_use;
	self.touch = func_laser_touch;
	if ((self.spawnflags & START_OFF))
	{
		setorigin (self, '0 0 9000');
	}
	helper = spawn ();
	helper.alpha = self.alpha;
	helper.owner = self;
	helper.nextthink = 0.05;
	helper.think = laser_helper_think;
};
void () circuitboard_touch =
{
	if ((other.classname != "player"))
	{
		return;
	}
	if ((other.health <= MSG_BROADCAST))
	{
		return;
	}
	stuffcmd (other, "bf\n");
	centerprint (other, "You got the 17-centimeter Fromitz board!");
	sound (other, CHAN_ITEM, self.noise, SPAWN_CRUCIFIED, ATTN_NORM);
	activator = other;
	SUB_UseTargets ();
	remove (self);
};
void () item_circuitboard =
{
	precache_model ("progs/fromitz.mdl");
	setmodel (self, "progs/fromitz.mdl");
	precache_sound ("items/protect.wav");
	self.noise = "items/protect.wav";
	self.touch = circuitboard_touch;
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	StartItem ();
};
void () light_fixture1 =
{
	precache_model ("progs/fixture1.mdl");
	setmodel (self, "progs/fixture1.mdl");
	self.angles_y = self.angle2;
	makestatic (self);
};
void () light_beacon =
{
	precache_model ("progs/beacon.mdl");
	setmodel (self, "progs/beacon.mdl");
	if ((self.spawnflags & SPAWN_CRUCIFIED))
	{
		self.skin = SPAWN_CRUCIFIED;
	}
	self.angles_y = self.angle2;
	makestatic (self);
};
void () misc_flag =
{
	precache_model ("progs/flag.mdl");
	setmodel (self, "progs/flag.mdl");
	self.frame = (self.spawnflags & AS_MELEE);
	makestatic (self);
};
void () sparks_fade1 = [ 0, sparks_fade2 ]
{
	self.alpha = 0.8;
	self.nextthink = (time + 0.05);
};
void () sparks_fade2 = [ 0, sparks_fade3 ]
{
	self.alpha = 0.6;
	self.nextthink = (time + 0.05);
};
void () sparks_fade3 = [ 0, sparks_fade4 ]
{
	self.alpha = 0.4;
	self.nextthink = (time + 0.05);
};
void () sparks_fade4 = [ 0, SUB_Remove ]
{
	self.alpha = 0.2;
	self.nextthink = (time + 0.05);
};
void () sparks_use =
{
	if ((self.spawnflags & START_OFF))
	{
		self.spawnflags = (self.spawnflags - START_OFF);
	}
	else
	{
		self.spawnflags = (self.spawnflags + START_OFF);
	}
};
void () make_sparks;
void () spark_turnofflight =
{
	SUB_UseTargets ();
	self.think = make_sparks;
	self.nextthink = ((time + ((random () + 0.5) * self.wait)) - 0.15);
};
void () make_sparks =
{
	local float i;
	local entity spark;
	if ((self.spawnflags & START_OFF))
	{
		self.nextthink = (time + 0.1);
		self.think = make_sparks;
	}
	else
	{
		i = ((-0.25 * self.cnt) + ((random () * 0.5) * self.cnt));
		while ((i < self.cnt))
		{
			spark = spawn ();
			spark.owner = self;
			setmodel (spark, "progs/spark.mdl");
			setorigin (spark, self.origin);
			spark.movetype = MOVETYPE_BOUNCE;
			spark.solid = SOLID_TRIGGER;
			spark.gravity = 0.3;
			spark.velocity_x = (-40 + (random () * 80));
			spark.velocity_y = (-40 + (random () * 80));
			spark.velocity_z = (-40 + (random () * 80));
			spark.avelocity = '3000 3000 3000';
			spark.nextthink = ((time + 0.5) + (1.5 * random ()));
			spark.think = sparks_fade1;
			spark.classname = "spark";
			if ((random () < 0.33))
			{
				spark.skin = MSG_BROADCAST;
			}
			else
			{
				if ((random () < 0.5))
				{
					spark.skin = SPAWN_CRUCIFIED;
				}
				else
				{
					spark.skin = SPAWNFLAG_LASER;
				}
			}
			if ((self.spawnflags & SPARKS_PALE))
			{
				spark.skin = (spark.skin + TE_LIGHTNING2);
			}
			else
			{
				if ((self.spawnflags & SPARKS_BLUE))
				{
					spark.skin = (spark.skin + AS_MELEE);
				}
			}
			setsize (spark, VEC_ORIGIN, VEC_ORIGIN);
			i = (i + SPAWN_CRUCIFIED);
		}
		if ((self.sounds == SPAWN_CRUCIFIED))
		{
			sound (self, CHAN_AUTO, "misc/spark.wav", SPAWN_CRUCIFIED, ATTN_STATIC);
		}
		SUB_UseTargets ();
		self.nextthink = ((time + 0.1) + (random () * 0.1));
		self.think = spark_turnofflight;
	}
};
void () misc_sparks =
{
	precache_model ("progs/spark.mdl");
	precache_sound ("misc/spark.wav");
	if (!self.movedir)
	{
		self.movedir = '0 0 -30';
	}
	if (!self.wait)
	{
		self.wait = SPAWNFLAG_LASER;
	}
	if (!self.cnt)
	{
		self.cnt = 15;
	}
	self.use = sparks_use;
	self.nextthink = (time + (random () * 0.1));
	self.think = make_sparks;
};
void () smoke_touch =
{
	if ((other == self.owner))
	{
		return;
	}
	if ((other.solid == SOLID_TRIGGER))
	{
		return;
	}
	if (((self.dmg > MSG_BROADCAST) && other.health))
	{
		T_Damage (other, self, self, self.dmg);
		self.dmg = MSG_BROADCAST;
	}
	self.velocity = VEC_ORIGIN;
	self.movedir = VEC_ORIGIN;
	self.movedir2 = '0 0 15';
};
void () smoke_rise =
{
	self.cnt = (self.cnt + SPAWN_CRUCIFIED);
	if ((self.cnt > TE_LIGHTNING2))
	{
		remove (self);
		return;
	}
	self.frame = self.cnt;
	self.velocity = ((self.velocity + self.movedir2) - (self.movedir * 0.12));
	self.nextthink = ((time + 0.1) + (random () * 0.05));
	self.think = smoke_rise;
};
void () smoke_think =
{
	local entity smoke;
	local entity e;
	local float dist;
	if ((self.spawnflags & START_OFF))
	{
		self.think = smoke_think;
		self.nextthink = (time + 0.1);
	}
	else
	{
		smoke = spawn ();
		smoke.owner = self;
		setmodel (smoke, "progs/s_smoke.spr");
		setorigin (smoke, self.origin);
		smoke.movetype = MOVETYPE_FLY;
		smoke.solid = SOLID_BBOX;
		smoke.velocity_x = ((self.movedir_x - TE_LAVASPLASH) + (random () * 20));
		smoke.velocity_y = ((self.movedir_y - TE_LAVASPLASH) + (random () * 20));
		smoke.velocity_z = ((self.movedir_z - TE_LAVASPLASH) + (random () * 20));
		smoke.angles_z = (random () * 360);
		smoke.nextthink = ((time + 0.1) + (random () * 0.05));
		smoke.think = smoke_rise;
		smoke.touch = smoke_touch;
		smoke.classname = "smoke";
		smoke.dmg = self.dmg;
		smoke.movedir2 = self.movedir2;
		smoke.frame = MSG_BROADCAST;
		smoke.cnt = MSG_BROADCAST;
		setsize (smoke, VEC_ORIGIN, VEC_ORIGIN);
		self.think = smoke_think;
		self.nextthink = (time + self.wait);
		if (self.sounds)
		{
			e = find (world, classname, "player");
			while (e)
			{
				dist = vlen ((self.origin - e.origin));
				if (((300 < dist) && (dist < 350)))
				{
					sound (self, CHAN_VOICE, "misc/airhiss.wav", SPAWN_CRUCIFIED, ATTN_STATIC);
					return;
				}
				e = find (e, classname, "player");
			}
		}
	}
};
void () smoke_use =
{
	if ((self.spawnflags & START_OFF))
	{
		self.spawnflags = (self.spawnflags - START_OFF);
		if (self.sounds)
		{
			sound (self, CHAN_VOICE, "misc/airhiss.wav", SPAWN_CRUCIFIED, ATTN_STATIC);
		}
	}
	else
	{
		self.spawnflags = (self.spawnflags + START_OFF);
		if (self.sounds)
		{
			sound (self, CHAN_VOICE, "misc/airhiss2.wav", SPAWN_CRUCIFIED, ATTN_STATIC);
		}
	}
};
void () smoke_firstthink =
{
	if (self.sounds)
	{
		if (!(self.spawnflags & START_OFF))
		{
			sound (self, CHAN_VOICE, "misc/airhiss.wav", SPAWN_CRUCIFIED, ATTN_STATIC);
		}
	}
	smoke_think ();
};
void () misc_smoke =
{
	precache_model ("progs/s_smoke.spr");
	precache_sound ("misc/airhiss.wav");
	precache_sound ("misc/airhiss2.wav");
	if (!self.dmg)
	{
		self.dmg = MSG_BROADCAST;
	}
	if (!self.movedir)
	{
		self.movedir = '0 0 250';
	}
	if (!self.movedir2)
	{
		self.movedir2 = VEC_ORIGIN;
	}
	if (!self.wait)
	{
		self.wait = 0.1;
	}
	self.use = smoke_use;
	self.nextthink = (time + 0.5);
	self.think = smoke_firstthink;
};
void () splash_think =
{
	local vector vec;
	local float variance;
	variance = (vlen (self.movedir) / SPAWNFLAG_LASER);
	vec_x = ((self.movedir_x - variance) + ((random () * variance) * SPAWNFLAG_LASER));
	vec_y = ((self.movedir_y - variance) + ((random () * variance) * SPAWNFLAG_LASER));
	vec_z = ((self.movedir_z - variance) + ((random () * variance) * SPAWNFLAG_LASER));
	//particle (self.origin, vec, self.color, self.volume);
	self.nextthink = (time + self.wait);
};
void () misc_splash =
{
	if (!self.wait)
	{
		self.wait = 0.1;
	}
	if (!self.movedir)
	{
		self.movedir = '0 0 4';
	}
	if (!self.volume)
	{
		self.volume = TE_LAVASPLASH;
	}
	self.color = (self.color * SECRET_YES_SHOOT);
	self.nextthink = (time + self.wait);
	self.think = splash_think;
};
void () ambient_general =
{
	precache_sound (self.noise);
	if (!self.speed)
	{
		self.speed = ATTN_STATIC;
	}
	if (!self.volume)
	{
		self.volume = 0.5;
	}
	ambientsound (self.origin, self.noise, self.volume, self.speed);
	remove (self);
};
//END
