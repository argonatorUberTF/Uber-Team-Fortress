void () wizspike_touch =
{
	local entity mark;
	mark = self.owner;
	if ((other == mark))
	{
		return;
	}
	if ((other.classname == mark.classname))
	{
		remove (self);
		return;
	}
	if ((other != mark.enemy))
	{
		remove (self);
		return;
	}
	if ((other.solid == SOLID_TRIGGER))
	{
		return;
	}
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	if (other.takedamage)
	{
		spawn_touchblood (MOVETYPE_FLYMISSILE);
		T_Damage (other, self, self.owner, MOVETYPE_FLYMISSILE);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}
	remove (self);
};
void () knightspike_touch =
{
	local entity mark;
	mark = self.owner;
	if ((other == self.owner))
	{
		return;
	}
	if ((other.solid == SOLID_TRIGGER))
	{
		return;
	}
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	if ((mark.enemy != other))
	{
		if ((((other.classname == "monster_knight") || (other.classname == "monster_hell_knight")) || (other.classname == "monster_baron")))
		{
			remove (self);
			return;
		}
		if ((other.classname == "monster_beard"))
		{
			remove (self);
			return;
		}
	}
	if (other.takedamage)
	{
		spawn_touchblood (MOVETYPE_FLYMISSILE);
		T_Damage (other, self, self.owner, MOVETYPE_FLYMISSILE);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}
	remove (self);
};
void (vector p1, vector p2, entity from, float damage) ClientLightningDamage =
{
	local entity e1;
	local entity e2;
	local vector f;
	local float num;
	f = p2 - p1;
	normalize (f);
	f_x = 0 - f_y;
	f_y = f_x;
	f_z = 0;
	f = f * FL_INWATER;
	e2 = world;
	e1 = world;
	traceline (p1, p2, 0, self);
	if (trace_ent.takedamage)
	{
		if ((trace_ent.flags != FL_BLOODLESS))
		{
			particle (trace_endpos, '0 0 100', 225, (damage * MOVETYPE_STEP));
		}
		T_Damage (trace_ent, from, from, damage);
		if ((from.classname == "monster_gaunt"))
		{
			if ((from.flags & FL_ONGROUND))
			{
				makevectors (from.angles);
				from.origin_z = (from.origin_z + 1);
				if ((random () < 0.4))
				{
					num = 175;
				}
				else
				{
					num = -175;
				}
				from.velocity = ((v_right * num) + '0 0 225');
				from.flags = (from.flags - FL_ONGROUND);
			}
		}
		if ((self.classname == "player"))
		{
			if ((other.classname == "player"))
			{
				trace_ent.velocity_z = (trace_ent.velocity_z + 400);
			}
		}
	}
	e1 = trace_ent;
	traceline ((p1 + f), (p2 + f), 0, self);
	if (((trace_ent != e1) && trace_ent.takedamage))
	{
		if ((trace_ent.flags != FL_BLOODLESS))
		{
			particle (trace_endpos, '0 0 100', 225, (damage * MOVETYPE_STEP));
		}
	}
	T_Damage (trace_ent, from, from, damage);
	e2 = trace_ent;
	traceline ((p1 - f), (p2 - f), 0, self);
	if ((((trace_ent != e1) && (trace_ent != e2)) && trace_ent.takedamage))
	{
		if ((trace_ent.flags != FL_BLOODLESS))
		{
			particle (trace_endpos, '0 0 100', 225, (damage * MOVETYPE_STEP));
		}
		T_Damage (trace_ent, from, from, damage);
	}
};
void (vector org, vector dir) launch_rocket =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles (dir);
	newmis.touch = M_MissileTouch;
	newmis.classname = "rocket";
	newmis.event = "thrett";
	newmis.think = SUB_Remove;
	newmis.nextthink = (time + MOVETYPE_TOSS);
	setmodel (newmis, "progs/missile.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);
	newmis.velocity = (dir * 1000);
};
void () M_MissileTouch =
{
	local float damg;
	if ((other == self.owner))
	{
		return;
	}
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	damg = 40 + (random () * 20);
	if (self.owner.model == "progs/soldier_neh.mdl") {
		damg *= .65;
		damg = ceil(damg);
	}
	T_RadiusDamage (self, self.owner, 30, other);
	if (other.health)
	{
		if ((other.classname == "monster_shambler"))
		{
			damg = damg * 0.5;
		}
		T_Damage (other, self, self.owner, damg);
	}
	self.origin = (self.origin - (FL_CLIENT * normalize (self.velocity)));
	WriteByte (4, 23);
	WriteByte (4, 3);
	WriteCoord (4, self.origin_x);
	WriteCoord (4, self.origin_y);
	WriteCoord (4, self.origin_z);
	multicast (self.origin, 1);
	BecomeExplosion ();
};
void () MGrenadeExplode =
{
	self.classname = "nadda";
	self.event = "";
	T_RadiusDamage (self, self.owner, 40, world);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	BecomeExplosion ();
};
void () MGrenadeTouch =
{
	if ((other == self.owner))
	{
		return;
	}
	if ((other.takedamage == DAMAGE_AIM))
	{
		MGrenadeExplode ();
		return;
	}
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
	if ((self.velocity == VEC_ORIGIN))
	{
		self.avelocity = VEC_ORIGIN;
	}
};
void () Mons_fire_grenade =
{
	local entity missile;
	self.effects = (self.effects | EF_MUZZLEFLASH);
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	makevectors (self.angles);
	if ((random () < 0.5))
	{
		missile.velocity = mindcrime_lead (600);
	}
	else
	{
		missile.velocity = normalize ((self.enemy.origin - self.origin));
	}
	missile.velocity = (missile.velocity * 600);
	missile.velocity_z = 200;
	missile.avelocity = '300 300 300';
	missile.angles = vectoangles (missile.velocity);
	missile.touch = MGrenadeTouch;
	missile.event = "mthret";
	missile.classname = "grenade";
	missile.netname = "threat2";
	missile.nextthink = (time + 2.5);
	missile.think = MGrenadeExplode;
	setmodel (missile, "progs/grenade.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, self.origin);
};
void () Mons_fire_sprocket =
{
	local entity missile;
	local vector org;
	local vector vec;
	ai2_jumpsplash (-200, '0 0 200');
	self.effects = (self.effects | EF_MUZZLEFLASH);
	sound (self, CHAN_WEAPON, "weapons/thump.wav", CHAN_WEAPON, ATTN_NORM);
	makevectors (self.angles);
	org = ((self.origin + (v_forward * SVC_INTERMISSION)) + (v_right * 8.5)) + '0 0 16';
	vec = normalize (vec);
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	missile.event = "mthret";
	makevectors (self.angles);
	if ((random () < 0.6))
	{
		missile.velocity = mindcrime_lead (700);
	}
	else
	{
		missile.velocity = normalize ((self.enemy.origin - self.origin));
	}
	missile.velocity = (missile.velocity * 700);
	missile.angles = vectoangles (missile.velocity);
	missile.touch = T_MissileTouch;
	missile.nextthink = (time + MOVETYPE_FLY);
	missile.think = SUB_Remove;
	setmodel (missile, "progs/sprocket.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, ((self.origin + (v_forward * FL_CLIENT)) + '0 0 16'));
};
void () Mons_fire_rocket =
{
	local entity missile;
	local vector org;
	local vector vec;
	ai2_jumpsplash (-200, '0 0 200');
	muzzleflash();
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", CHAN_WEAPON, ATTN_NORM);
	makevectors (self.angles);
	org = ((self.origin + (v_forward * SVC_INTERMISSION)) + (v_right * 8.5)) + '0 0 16';
	vec = normalize (vec);
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	makevectors (self.angles);
	if ((random () < 0.6))
	{
		missile.velocity = mindcrime_lead (1000);
	}
	else
	{
		missile.velocity = normalize ((self.enemy.origin - self.origin));
	}
	missile.velocity = (missile.velocity * 1000);
	missile.angles = vectoangles (missile.velocity);
	missile.touch = M_MissileTouch;
	missile.event = "mthret";
	missile.nextthink = (time + MOVETYPE_FLY);
	missile.think = SUB_Remove;
	setmodel (missile, "progs/missile.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, ((self.origin + (v_forward * FL_CLIENT)) + '0 0 16'));
};
void () Mons_fire_shotgun =
{
	local vector dir;
	local entity en;
	ai_face ();
	sound (self, CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM);
	en = self.enemy;
	dir = en.origin - (en.velocity * 0.2);
	dir = normalize ((dir - self.origin));
	FireBullets (10, dir, '0.14 0.08 0');
};
void () Mons_fire_shotgun2 =
{
	local vector dir;
	local entity en;
	ai_face ();
	sound (self, CHAN_WEAPON, "weapons/shotgn3.wav", 1, ATTN_NORM);
	self.effects = (self.effects | EF_MUZZLEFLASH);
	en = self.enemy;
	dir = en.origin - (en.velocity * 0.2);
	dir = normalize ((dir - self.origin));
	FireBullets (MOVETYPE_STEP, dir, '0.1 0.1 0');
};
void () Mons_fire_nails =
{
	local vector dir;
	local entity en;
	sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
	en = self.enemy;
	if ((random () < 0.6))
	{
		dir = mindcrime_lead (1000);
	}
	else
	{
		dir = normalize ((en.origin - self.origin));
	}
	makevectors (self.angles);
	mons_spike (((self.origin + '0 0 26') + (v_right * 5)), dir);
	newmis.touch = monspike_touch;
	setmodel (newmis, "progs/s_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
};
void (vector org, vector dir) mons_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles (dir);
	newmis.touch = monspike_touch;
	newmis.classname = "spike";
	newmis.event = "mthret";
	newmis.think = SUB_Remove;
	newmis.nextthink = (time + MOVETYPE_TOSS);
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);
	newmis.velocity = (dir * 1000);
};
void () monspike_touch =
{
	local entity mark;
	mark = self.owner;
	if ((other == self.owner))
	{
		return;
	}
	if (((other.flags & FL_MONSTER) && (mark.enemy != other)))
	{
		remove (self);
		return;
	}
	if ((other.solid == SOLID_TRIGGER))
	{
		return;
	}
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	if (other.takedamage)
	{
		spawn_touchblood (9);
		T_Damage (other, self, self.owner, 9);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_SPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}
	remove (self);
};
vector (float t) mindcrime_lead =
{
	local float num;
	local vector dir;
	local vector megadeth;
	local vector vec;
	if ((t < 1000))
	{
		num = 1000 - t;
		t = 1000 + num;
	}
	else
	{
		num = t - 1000;
		t = 1000 - num;
	}
	t = t * 0.000001;
	megadeth = self.enemy.origin - self.origin;
	num = vlen (megadeth);
	num = num * t;
	vec = self.enemy.velocity;
	vec_z = vec_z * 0.25;
	dir = self.enemy.origin + (vec * num);
	dir = normalize ((dir - self.origin));
	return (dir);
};
//END
