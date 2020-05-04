float () wraith_checkenemy =
{
	local entity head;
	head = self.enemy;
	if ((head == world))
	{
		return (0);
	}
	if (((head.health < self.health) || (head.weapon < 8)))
	{
		if ((head.ammo_rockets < 1))
		{
			return (1);
		}
	}
	return (0);
};
void () wraith_2normal =
{
	self.th_stand = wraith_idle1;
	self.th_walk = wraith_motion;
	self.th_run = wraith_motion;
	self.th_pain = wraith_pain;
	self.th_die = wraith_unform;
	self.solid = SOLID_TRIGGER;
	self.effects = (self.effects - (self.effects & EF_DIMLIGHT));
	sound (self, CHAN_VOICE, "wraith/return.wav", 1, ATTN_NONE);
};
void () wraith_2inv =
{
	self.th_stand = wraith_inv_idle;
	self.th_walk = wraith_inv_motion;
	self.th_run = wraith_inv_motion;
	self.solid = SOLID_NOT;
	self.effects = (self.effects | EF_DIMLIGHT);
	sound (self, CHAN_VOICE, "wraith/return.wav", 1, ATTN_NONE);
};
void () wraith_inv_idle =
{
	if (!Wraith_Find_Orphans ())
	{
		Seek_out_soul ();
	}
	if ((self.enemy != world))
	{
		wraith_inv_motion ();
		return;
	}
	parse_anim ( 0, wraith_inv_idle );
	if ((random () < 0.3))
	{
		self.effects = (self.effects | EF_MUZZLEFLASH);
	}
	if ((random () > 0.95))
	{
		sound (self, CHAN_VOICE, "wraith/idle.wav", 1, ATTN_IDLE);
	}
};
void () wraith_inv_motion =
{
	if ((self.health < 60))
	{
		if ((random () < 0.1))
		{
			T_Heal (self, 1, 1);
		}
	}
	else
	{
		if (wraith_checkenemy ())
		{
			wraith_comeback ();
			return;
		}
		if ((self.rotate_type == 1))
		{
			sound (self.enemy, CHAN_VOICE, "wraith/speak.wav", 1, ATTN_IDLE);
			self.rotate_type = 0;
		}
	}
	if ((self.enemy == world))
	{
		if (!Wraith_Find_Orphans ())
		{
			Seek_out_soul ();
		}
	}
	else
	{
		if ((self.enemy.health < 1))
		{
			self.enemy = world;
			self.cnt = 0;
		}
	}
	if ((self.enemy != world))
	{
		wraith_soul_proxim ();
		if (((self.cnt > 1) && (self.enemy.classname == "soul_to_take")))
		{
			sound (self, CHAN_VOICE, "wraith/talk1.wav", 1, ATTN_IDLE);
			self.cnt = 3;
			wraith_inv_souls ();
			return;
		}
		Wraith_Move ();
	}
	else
	{
		if ((self.goalentity != world))
		{
			self.goalentity = world;
		}
	}
	if ((self.walkframe >= 14))
	{
		self.walkframe = 0;
	}
	parse_anim ( 0, wraith_inv_motion );
	if ((random () < 0.2))
	{
		self.effects = (self.effects | EF_MUZZLEFLASH);
	}
};
void () wraith_comeback =
{
	self.alpha = 0.8;
	wraith_comeback2 ();
};
void () wraith_comeback2 =
{
	if ((self.walkframe >= 17))
	{
		self.walkframe = 0;
		wraith_2normal ();
		wraith_motion ();
		return;
	}
	parse_anim ( 103, wraith_comeback2 );
	self.frame = (119 - self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () wraith_attack1 =
{
	local float num;
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
		wraith_attack2 ();
		return;
	}
	parse_anim ( 79, wraith_attack1 );
	self.frame = (79 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	Wraith_Move ();
	if (((self.walkframe > 3) && visible (self.enemy)))
	{
		num = self.walkframe - 6;
		wraith_spike (num);
	}
};
void () wraith_attack2 =
{
	local float num;
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
		wraith_motion ();
		return;
	}
	parse_anim ( 79, wraith_attack2 );
	self.frame = (84 - self.walkframe);
	self.walkframe = (self.walkframe + 1);
	Wraith_Move ();
	if (((self.walkframe < 4) && visible (self.enemy)))
	{
		num = self.walkframe - 3;
		wraith_spike (num);
	}
};
void () wraith_goinv =
{
	wraith_2inv ();
	wraith_goinv2 ();
};
void () wraith_goinv2 =
{
	if ((self.walkframe >= 17))
	{
		self.walkframe = 0;
		self.alpha = -1;
		wraith_inv_motion ();
		return;
	}
	parse_anim ( 103, wraith_goinv2 );
	self.frame = (103 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () wraith_inv_souls =
{
	self.alpha = 0.8;
	wraith_inv_souls2 ();
};
void () wraith_inv_souls2 =
{
	if ((self.walkframe >= 17))
	{
		self.walkframe = 0;
		wraith_2normal ();
		wraith_souls ();
		return;
	}
	parse_anim ( 103, wraith_inv_souls2 );
	self.frame = (119 - self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () Wraith_Move =
{
	local entity sa;
	local float spot;
	local float num;
	ai_face ();
	if ((self.rotate_type == 0))
	{
		num = 5;
	}
	else
	{
		num = -3;
	}
	sa = self.enemy;
	if ((sa.origin_x < self.origin_x))
	{
		self.origin_x = (self.origin_x - num);
	}
	if ((sa.origin_x > self.origin_x))
	{
		self.origin_x = (self.origin_x + num);
	}
	if ((sa.origin_y < self.origin_y))
	{
		self.origin_y = (self.origin_y - num);
	}
	if ((sa.origin_y > self.origin_y))
	{
		self.origin_y = (self.origin_y + num);
	}
	spot = sa.origin_z + 40;
	if ((self.origin_z < spot))
	{
		self.origin_z = (self.origin_z + num);
	}
	if ((self.origin_z > spot))
	{
		self.origin_z = (self.origin_z - num);
	}
};
void (float offset) wraith_spike =
{
	local vector offang;
	local vector org;
	local vector vec;
	offang = vectoangles ((self.enemy.origin - self.origin));
	offang_y = offang_y + (offset * MOVETYPE_TOSS);
	makevectors (offang);
	org = ((self.origin + self.mins) + (self.size * 0.5)) + (v_forward * 20);
	org = org - '0 0 20';
	vec = normalize (v_forward);
	vec_z = (0 - vec_z) + ((random () - 0.5) * 0.1);
	launch_spike (org, vec);
	newmis.classname = "wraithspike";
	setmodel (newmis, "progs/wr_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	newmis.velocity = (vec * 300);
	sound (self, CHAN_WEAPON, "baron/throb.wav", 1, ATTN_IDLE);
};
void () wraith_invisible = [ 0, wraith_invisible ]
{
	if ((self.enemy != world))
	{
		ai_run (6);
	}
	else
	{
		if ((self.goalentity != world))
		{
			ai_walk (4);
		}
		else
		{
			ai_stand ();
		}
	}
};
void () wraith_idle1 =
{
	if (!Wraith_Find_Orphans ())
	{
		Seek_out_soul ();
	}
	if ((self.enemy != world))
	{
		wraith_motion ();
		return;
	}
	if ((self.walkframe >= 23))
	{
		self.walkframe = 0;
		self.nojump = (self.nojump + 1);
		if ((self.nojump > 1))
		{
			self.nojump = 0;
			wraith_idle2 ();
			return;
		}
	}
	parse_anim ( 18, wraith_idle1 );
	if ((self.nojump == 0))
	{
		self.frame = (18 + self.walkframe);
	}
	else
	{
		self.frame = (40 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
	if ((self.walkframe == 12))
	{
		if ((random () < 0.3))
		{
			sound (self, 1/*CHAN_DAMAUL*/, "wraith/idle.wav", 1, ATTN_IDLE);
		}
		else
		{
			sound (self, 1/*CHAN_DAMAUL*/, "wraith/weird.wav", 1, ATTN_IDLE);
		}
	}
};
void () wraith_idle2 =
{
	if (!Wraith_Find_Orphans ())
	{
		Seek_out_soul ();
	}
	if ((self.enemy != world))
	{
		wraith_motion ();
		return;
	}
	if ((self.walkframe >= 23))
	{
		self.walkframe = 0;
		self.nojump = (self.nojump + 1);
		if ((self.nojump > 1))
		{
			self.nojump = 0;
			wraith_idle1 ();
			return;
		}
	}
	parse_anim ( 42, wraith_idle2 );
	if ((self.nojump == 0))
	{
		self.frame = (42 + self.walkframe);
	}
	else
	{
		self.frame = (63 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
	if (((self.walkframe == 8) || (self.walkframe == 18)))
	{
		if ((random () < 0.2))
		{
			sound (self, CHAN_VOICE, "wraith/idle.wav", 1, ATTN_IDLE);
		}
	}
};
void () wraith_motion =
{
	local float mspike;
	local float wspike;
	if ((self.health < 50))
	{
		wraith_goinv ();
		return;
	}
	if ((self.health < 60))
	{
		if ((random () < 0.1))
		{
			T_Heal (self, 1, 1);
		}
	}
	else
	{
		if ((self.rotate_type == 1))
		{
			sound (self.enemy, CHAN_VOICE, "wraith/speak.wav", 1, ATTN_IDLE);
			self.rotate_type = 0;
		}
	}
	if ((self.enemy == world))
	{
		if (!Wraith_Find_Orphans ())
		{
			Seek_out_soul ();
		}
	}
	else
	{
		if ((self.enemy.health < 1))
		{
			self.enemy = world;
			self.cnt = 0;
		}
	}
	if ((self.enemy != world))
	{
		wraith_soul_proxim ();
		if (((self.cnt > 1) && (self.enemy.classname == "soul_to_take")))
		{
			sound (self, CHAN_VOICE, "wraith/talk1.wav", 1, ATTN_IDLE);
			self.cnt = 3;
			wraith_souls ();
			return;
		}
		Wraith_Move ();
		if (((self.enemy.classname != "soul_to_take") && (random () < 0.1)))
		{
			if ((random () < 0.5))
			{
				wraith_attack1 ();
				return;
			}
			mspike = rint ((self.walkframe / 6));
			wspike = 3 - mspike;
			wraith_spike (wspike);
		}
	}
	else
	{
		if ((self.goalentity != world))
		{
			self.goalentity = world;
		}
		else
		{
			if ((random () < 0.4))
			{
				if ((random () < 0.5))
				{
					self.angles_y = (self.angles_y + 15);
				}
				else
				{
					self.angles_y = (self.angles_y - 15);
				}
			}
		}
	}
	if ((self.walkframe >= 14))
	{
		self.walkframe = 0;
	}
	parse_anim ( 66, wraith_motion );
	self.frame = (66 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	if (((self.walkframe == 25) || (self.walkframe == 15)))
	{
		if ((random () < 0.3))
		{
			sound (self, CHAN_VOICE, "wraith/idle.wav", 1, ATTN_IDLE);
		}
	}
};
void () wraith_throws_gunk =
{
	local entity gunk;
	local float n;
	n = 0;
	gunk = find (world, classname, "gunk");
	while (gunk)
	{
		n = n + 1;
		gunk = find (gunk, classname, "gunk");
	}
	if ((n > 3))
	{
		return;
	}
	gunk = spawn ();
	gunk.origin = (self.origin + '0 0 24');
	if ((self.classname == "monster_wraith"))
	{
		gunk.classname = "gunk";
	}
	gunk.velocity_z = 300;
	gunk.velocity_x = (-100 + (random () * 200));
	gunk.velocity_y = (-100 + (random () * 200));
	gunk.solid = SOLID_NOT;
	gunk.cnt = 0;
	gunk.movetype = MOVETYPE_TOSS;
	gunk.nextthink = (time + 0.01);
	gunk.think = Spawn_Wraithgunk;
};
void () wraith_unform =
{
	self.walkframe = 0;
	parse_anim ( 51, wraith_dissipate );
};
void () wraith_dissipate =
{
	if ((self.walkframe >= 17))
	{
		remove (self);
		return;
	}
	if ((self.walkframe == 9))
	{
		if ((random () < 0.2))
		{
			sound (self, CHAN_VOICE, "wraith/talk3.wav", 1, ATTN_IDLE);
		}
		else
		{
			sound (self, CHAN_VOICE, "wraith/call.wav", 1, ATTN_IDLE);
		}
	}
	parse_anim ( 0, wraith_dissipate );
	wraith_throws_gunk ();
	self.frame = (18 - self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () monster_wraith1 =
{
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_NOCLIP;
	setmodel (self, "progs/wraith.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 90');
	if (!self.health)
	{
		self.health = 600;
	}
	self.brain = 0;
	if (((self.targetname == "actor11") || (self.targetname == "actor12")))
	{
		self.th_stand = wraith_wait;
		self.th_walk = wraith_wait;
	}
	else
	{
		self.th_stand = wraith_idle1;
		self.th_walk = wraith_motion;
	}
	self.th_run = wraith_motion;
	self.th_pain = wraith_pain;
	self.th_die = wraith_unform;
	self.rotate_type = 0;
	self.nojump = 0;
	self.touch = death_aura;
	MTF_Setup_Monster_Postsets( self.health, coop_flymonster_start);
};
void () monster_wraith =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	self.alpha = 0.7;
	self.fullbright = 1;
	precache_model ("progs/wraith.mdl");
	precache_model ("progs/s_null.spr");
	precache_model ("progs/wr_spike.mdl");
	precache_model ("progs/soul.mdl");
	precache_sound ("wraith/soul.wav");
	precache_sound ("wraith/idle.wav");
	precache_sound ("wraith/idle2.wav");
	precache_sound ("baron/throb.wav");
	precache_sound ("wraith/rych1.wav");
	precache_sound ("wraith/call.wav");
	precache_sound ("wraith/talk1.wav");
	precache_sound ("wraith/weird.wav");
	precache_sound ("wraith/speak.wav");
	precache_sound ("wraith/growl2.wav");
	precache_sound ("wraith/talk3.wav");
	precache_sound ("wraith/return.wav");
	precache_sound ("wraith/select.wav");
	MTF_Setup_Monster_Presets ( 0, "wraith", monster_wraith1 );
	self.lives = 0;
};
void () death_aura =
{
	if ((other.health < 1))
	{
		return;
	}
	if ((((other.flags & FL_CLIENT) || other.flags) & FL_MONSTER))
	{
		T_Damage (other, self, self, other.health);
	}
};
void () wraith_wait =
{
	self.use = wraith_begin;
	if ((self.walkframe >= 34))
	{
		self.walkframe = 0;
	}
	parse_anim ( 0, wraith_wait );
	self.frame = (0 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () wraith_begin =
{
	self.use = monster_use;
	self.th_stand = wraith_motion;
	self.th_walk = wraith_motion;
	parse_anim ( 0, wraith_motion );
};
void () wraith_pain =
{
	local float num;
	num = random ();
	if ((num < 0.3))
	{
		sound (self, CHAN_VOICE, "wraith/growl2.wav", 1, ATTN_IDLE);
	}
	else
	{
		if ((num < 0.6))
		{
			sound (self, CHAN_VOICE, "wraith/idle2.wav", 1, ATTN_IDLE);
		}
	}
	if ((self.health < 60))
	{
		self.rotate_type = 1;
	}
	wraith_throws_gunk ();
	if ((random () < 0.4))
	{
		parse_anim ( 79, wraith_motion );
		return;
	}
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 5);
	parse_anim ( 86, wraith_pain2 );
};
void () wraith_pain2 = [ 87, wraith_pain3 ]
{};
void () wraith_pain3 = [ 88, wraith_pain4 ]
{};
void () wraith_pain4 = [ 89, wraith_pain5 ]
{};
void () wraith_pain5 = [ 90, wraith_pain6 ]
{};
void () wraith_pain6 = [ 91, wraith_pain7 ]
{};
void () wraith_pain7 = [ 92, wraith_motion ]
{};
void () wraith_special =
{
	if ((self.super_damage_finished > time))
	{
		self.effects = (self.effects | EF_DIMLIGHT);
	}
	else
	{
		self.effects = (self.effects - (self.effects & EF_DIMLIGHT));
	}
};
void () wraith_zeda = [ 93, wraith_zeda1 ]
{
	ai_face ();
};
void () wraith_zeda1 = [ 94, wraith_zeda2 ]
{
	ai_face ();
};
void () wraith_zeda2 = [ 95, wraith_zeda3 ]
{
	ai_face ();
};
void () wraith_zeda3 = [ 96, wraith_zeda4 ]
{
	ai_face ();
};
void () wraith_zeda4 = [ 97, wraith_zeda5 ]
{
	ai_face ();
};
void () wraith_zeda5 = [ 98, wraith_zeda6 ]
{
	ai_face ();
};
void () wraith_zeda6 = [ 99, wraith_zeda7 ]
{
	ai_face ();
};
void () wraith_zeda7 = [ 100, wraith_zeda8 ]
{
	ai_face ();
};
void () wraith_zeda8 = [ 101, wraith_soulcheck ]
{
	ai_face ();
};
void () wraith_soulcheck =
{
	if ((self.enemy.classname != "soul_to_take"))
	{
		self.cnt = 0;
		self.nojump = 0;
		self.enemy = world;
		parse_anim ( 18, wraith_idle1 );
		return;
	}
	parse_anim ( 100, wraith_xeda2 );
	ai_face ();
};
void () wraith_xeda2 = [ 99, wraith_xeda3 ]
{
	ai_face ();
};
void () wraith_xeda3 = [ 98, wraith_zeda6 ]
{};
void () wraith_souls =
{
	if ((self.enemy.classname != "soul_to_take"))
	{
		self.cnt = 0;
		self.nojump = 0;
		self.enemy = world;
		wraith_idle1 ();
		return;
	}
	wraith_zeda ();
};
void (entity mark) Soul_to_take =
{
	local entity soula;
	if ((mark.origin == '0 0 0'))
	{
		dprint ("soul tried to spawn at [0 0 0]\n");
		return;
	}
	soula = spawn ();
	soula.origin = (mark.origin - '0 0 20');
	soula.objekt = mark;
	soula.owner = self;
	soula.enemy = self;
	self.enemy = soula;
	soula.solid = SOLID_TRIGGER;
	soula.health = 9000;
	soula.movetype = MOVETYPE_NOCLIP;
	soula.classname = "soul_to_take";
	soula.model = string_null;
	soula.effects = (soula.effects | EF_DIMLIGHT);
	setsize (soula, VEC_HULL_MIN, '16 16 16');
	soula.nextthink = (time + 0.2);
	soula.think = Soul_Think;
};
void () Soul_Think =
{
	local vector dave;
	local entity sa;
	sa = self.enemy;
	sa.enemy = self;
	if ((sa.cnt < 3))
	{
		self.think = Soul_Think;
		self.nextthink = (time + 0.05);
		return;
	}
	if ((self.model == string_null))
	{
		self.alpha = 0.3;
		self.fullbright = 1;
		setmodel (self, "progs/soul.mdl");
	}
	if ((sa.origin_x < self.origin_x))
	{
		self.origin_x = (self.origin_x - 3);
	}
	if ((sa.origin_x > self.origin_x))
	{
		self.origin_x = (self.origin_x + 3);
	}
	if ((sa.origin_y < self.origin_y))
	{
		self.origin_y = (self.origin_y - 3);
	}
	if ((sa.origin_y > self.origin_y))
	{
		self.origin_y = (self.origin_y + 3);
	}
	if ((sa.origin_z < (self.origin_z + 10)))
	{
		self.origin_z = (self.origin_z - 2);
	}
	if ((sa.origin_z > (self.origin_z + 10)))
	{
		self.origin_z = (self.origin_z + 2);
	}
	dave = self.enemy.origin - self.origin;
	if ((vlen (dave) < 20))
	{
		sa.enemy = world;
		sa.cnt = 0;
		sa.blink = -1;
		if ((sa.health < 1200))
		{
			sa.health = (sa.health + 50);
		}
		sound (self.enemy, CHAN_VOICE, "wraith/rych1.wav", 1, ATTN_IDLE);
		remove (self);
		return;
	}
	self.think = Soul_Think;
	self.nextthink = (time + 0.05);
};
float () Seek_out_soul =
{
	local entity head;
	local entity selected;
	head = find (world, soul, "yes");
	while (head)
	{
		if ((head.health < 1))
		{
			selected = head;
		}
		head = find (head, soul, "yes");
	}
	if ((selected == world))
	{
		return (0);
	}
	else
	{
		selected.soul = "no";
		self.cnt = 1;
		self.enemy = selected;
		sound (self, CHAN_ITEM, "wraith/select.wav", 1, ATTN_IDLE);
		sound (selected, 1/*CHAN_BAL*/, "wraith/select.wav", 1, ATTN_IDLE);
		Soul_to_take (selected);
		spawn_soulsound (selected);
		return (1);
	}
};
float () Wraith_Find_Orphans =
{
	local entity head;
	local entity selected;
	local float dist;
	dist = 1000;
	selected = world;
	head = findradius (self.origin, 1000);
	while (head)
	{
		if (((head.classname == "soul_to_take") && (head.owner == self)))
		{
			if ((visible (head) && (trace_plane_dist < dist)))
			{
				selected = head;
				dist = trace_plane_dist;
			}
		}
		head = head.chain;
	}
	if ((selected == world))
	{
		return (0);
	}
	else
	{
		self.enemy = selected;
		self.cnt = 1;
		return (1);
	}
};
void () wraith_soul_proxim =
{
	local vector megadeth;
	if ((self.enemy.classname != "soul_to_take"))
	{
		return;
	}
	megadeth = self.enemy.origin - self.origin;
	if ((vlen (megadeth) < 300))
	{
		self.cnt = 2;
		return;
	}
	self.cnt = 1;
};
void (entity mark) spawn_soulsound =
{
	local entity head;
	local float num;
	head = spawn ();
	head.origin = mark.origin;
	num = 60 * random ();
	head.think = make_soulsound;
	head.nextthink = (time + num);
};
void () make_soulsound =
{
	sound (self, 1/*CHAN_ENDER*/, "wraith/soul.wav", 1, ATTN_IDLE);
	self.think = SUB_Remove;
	self.nextthink = (time + 1.5);
};
//END
