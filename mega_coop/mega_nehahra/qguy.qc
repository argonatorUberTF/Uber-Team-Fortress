void (float side, float damg) kguard_firing =
{
	local vector delta;
	ai_face ();
	if (visible (self.enemy))
	{
		if ((self.origin_z < self.enemy.origin_z))
		{
			Mons_fire_nails ();
			return;
		}
		delta = self.enemy.origin - self.origin;
		if (((vlen (delta) > 200) && (self.rotate_type != 1)))
		{
			if (((random () < 0.5) && (self.enemy.origin_z <= self.origin_z)))
			{
				Mons_fire_grenade ();
				return;
			}
			Mons_fire_rocket ();
			if ((self.flags & FL_ONGROUND))
			{
				self.origin_z = (self.origin_z + 1);
				self.velocity_z = 200;
				self.flags = (self.flags - FL_ONGROUND);
				return;
			}
		}
	}
	Mons_fire_nails ();
};

void () kguard_stand1 = [ 12, kguard_stand2 ]
{
	ai_stand ();
};

void () kguard_stand2 = [ 13, kguard_stand3 ]
{
	ai_stand ();
	TargetBadGuys ();
};

void () kguard_stand3 = [ 14, kguard_stand4 ]
{
	ai_stand ();
};

void () kguard_stand4 = [ 15, kguard_stand5 ]
{
	ai_stand ();
};

void () kguard_stand5 = [ 16, kguard_stand6 ]
{
	ai_stand ();
};

void () kguard_stand6 = [ 15, kguard_stand7 ]
{
	ai_stand ();
};

void () kguard_stand7 = [ 14, kguard_stand8 ]
{
	ai_stand ();
};

void () kguard_stand8 = [ 16, kguard_stand9 ]
{
	ai_stand ();
};

void () kguard_stand9 =
{
	ai_stand ();
	kguard_stand1 ();
};

void () kguard_walk1 = [ 6, kguard_walk2 ]
{
	ai_walk (28);
	TargetBadGuys ();
};

void () kguard_walk2 = [ 7, kguard_walk3 ]
{
	ai_walk (28);
	if (((self.objekt != world) && (self.objekt.classname == "player")))
	{
		ai_objledge ();
	}
};

void () kguard_walk3 = [ 8, kguard_walk4 ]
{
	ai_walk (28);
};

void () kguard_walk4 = [ 9, kguard_walk5 ]
{
	ai_walk (28);
};

void () kguard_walk5 = [ 10, kguard_walk6 ]
{
	ai_walk (28);
};

void () kguard_walk6 = [ 11, kguard_walk1 ]
{
	ai_walk (28);
};

void () kguard_back =
{
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
		self.touch = objekt_touch;
		parse_anim ( 11, kguard_stand1 );
		return;
	}
	parse_anim ( 6, kguard_back );
	self.frame = (11 - self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai_back (12);
};

void () kguard_run1 = [ 6, kguard_run2 ]
{
	ai3_run (29);
};

void () kguard_run2 = [ 7, kguard_run3 ]
{
	ai3_run (29);
	TargetBadGuys ();
};

void () kguard_run3 = [ 8, kguard_run4 ]
{
	ai3_run (29);
};

void () kguard_run4 = [ 9, kguard_run5 ]
{
	ai3_run (29);
};

void () kguard_run5 = [ 10, kguard_run6 ]
{
	ai3_run (29);
	ai_threats ();
};

void () kguard_run6 = [ 11, kguard_run7 ]
{
	ai3_run (29);
};

void () kguard_run7 =
{
	ai3_run (29);
	kguard_shoot ();
};

void () kguard_atta1 =
{
	if (qguy_tolerance ())
	{
		self.th_stand ();
		return;
	}
	parse_anim ( 113, kguard_atta4 );
	ai_face ();
};

void () kguard_atta4 = [ 114, kguard_atta5 ]
{
	ai_face ();
	kguard_firing (0, 0);
	self.effects = (self.effects | EF_MUZZLEFLASH);
};

void () kguard_atta5 =
{
	if (((random () < 0.4) && visible (self.enemy)))
	{
		parse_anim ( 115, kguard_atta4 );
		ai_face ();
	}
	parse_anim ( 115, kguard_atta6 );
	ai_face ();
};

void () kguard_atta6 = [ 116, kguard_atta7 ]
{
	ai_face ();
};

void () kguard_atta7 = [ 117, kguard_atta8 ]
{
	ai_face ();
};

void () kguard_atta8 =
{
	ai_face ();
	kguard_shoot ();
};

void () kguard_pain1 =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 2.1);
	parse_anim ( 35, kguard_pain2 );
	PainSound ();
};

void () kguard_pain2 = [ 36, kguard_pain3 ]
{
};

void () kguard_pain3 = [ 37, kguard_pain4 ]
{
};

void () kguard_pain4 = [ 38, kguard_pain5 ]
{
};

void () kguard_pain5 = [ 39, kguard_pain6 ]
{
};

void () kguard_pain6 = [ 40, kguard_shoot ]
{
};

void () kguard_pain =
{
	kguard_pain1 ();
};

void () kguard_die1 = [ 50, kguard_die2 ]
{
};

void () kguard_die2 = [ 51, kguard_die3 ]
{
};

void () kguard_die3 = [ 52, kguard_die4 ]
{
};

void () kguard_die4 = [ 53, kguard_die5 ]
{
};

void () kguard_die5 = [ 54, kguard_die6 ]
{
};

void () kguard_die6 = [ 55, kguard_die7 ]
{
};

void () kguard_die7 = [ 56, kguard_die8 ]
{
};

void () kguard_die8 = [ 57, kguard_die9 ]
{
};

void () kguard_die9 = [ 58, kguard_die10 ]
{
};

void () kguard_die10 = [ 59, kguard_die11 ]
{
};

void () kguard_die11 = [ 60, corpse_think ]
{
};

void () kguard_dieb1 = [ 85, kguard_dieb2 ]
{
};

void () kguard_dieb2 = [ 86, kguard_dieb3 ]
{
};

void () kguard_dieb3 = [ 87, kguard_dieb4 ]
{
};

void () kguard_dieb4 = [ 88, kguard_dieb5 ]
{
};

void () kguard_dieb5 = [ 89, kguard_dieb6 ]
{
};

void () kguard_dieb6 = [ 90, kguard_dieb7 ]
{
};

void () kguard_dieb7 = [ 91, kguard_dieb8 ]
{
};

void () kguard_dieb8 = [ 92, kguard_dieb9 ]
{
};

void () kguard_dieb9 = [ 93, corpse_think ]
{
};

void () kguard_die =
{
	if ((self.health < -35))
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowHead ("progs/gib3.mdl", self.health);
		return;
	}
	if ((random () < 0.5))
	{
		sound (self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
	}
	else
	{
		sound (self, CHAN_VOICE, "player/death1.wav", 1, ATTN_NORM);
	}
	self.solid = SOLID_NOT;
	if ((random () > 0.5))
	{
		kguard_die1 ();
	}
	else
	{
		kguard_dieb1 ();
	}
};

void () monster_qguy1 =
{
	return;
};

void () monster_qguy =
{
	if (deathmatch)
	{
		return;
	}
	precache_model ("progs/s_spike.mdl");
	precache_sound ("weapons/rocket1i.wav");
	if (!(self.brain & NAVLOGIC))
	{
		self.brain = (self.brain | NAVLOGIC);
	}
	self.rotate_type = self.cnt;
	if ((((self.targetname == "actor10") || (self.targetname == "actor6")) || (self.targetname == "actor9")))
	{
		self.th_stand = kguard_actor_wait;
		self.th_walk = kguard_actor_wait;
	}
	else
	{
		self.th_stand = kguard_stand1;
		self.th_walk = kguard_walk1;
	}
	self.th_run = kguard_run1;
	self.th_pain = kguard_pain;
	self.th_die = kguard_die;
	self.th_melee = kguard_atta1;
	self.th_missile = SUB_Null;
	if ((self.relations == -1))
	{
		self.relations = 0;
	}
	else
	{
		if ((self.relations < 2))
		{
			self.relations = 2;
		}
	}
	if ((self.relations > 2))
	{
		self.th_back = kguard_back;
	}
	if ((self.brain & TRIGGER_SPAWN))
	{
//		self.use = qguy_start;
		return;
	}
	if (self.is_monster != 1)
	{
		MTF_Setup_Monster_Presets ( 0, "quake guy", monster_qguy1 );
		self.is_monster = 1;
	}
	self.lives = 0;
	carnify_qguy ();
};

void () qguy_start =
{
	trigger_spawnmonster ();
	carnify_qguy ();
};

void () carnify_qguy =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/player.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	if (!self.health)
	{
		self.health = 2;//50;
	}
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
	walkmonster_start ();
};

void () kguard_actor_wait =
{
	self.use = kguard_actor_use;
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
	}
	parse_anim ( 12, kguard_actor_wait );
	self.frame = (12 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};

void () kguard_actor_use =
{
	if ((self.goalentity == world))
	{
		parse_anim ( 69, kguard_stand1 );
	}
	else
	{
		parse_anim ( 69, kguard_walk1 );
		ai_walk (5);
	}
	self.th_stand = kguard_stand1;
	self.th_walk = kguard_walk1;
	self.use = monster_use;
};

void () kguard_shoot =
{
	if ((self.enemy.health < 1))
	{
		kguard_stand1 ();
		self.enemy = world;
		return;
	}
	ai_face ();
	if (((visible (self.enemy) * random ()) > 0.5))
	{
		kguard_atta1 ();
		return;
	}
	kguard_run1 ();
};

float () TargetBadGuys =
{
	local entity head;
	local entity selected;
	local float dist;

	if ((self.relations == -1))
	{
		return 0;
	}
	dist = 1000;
	selected = world;
	head = findradius (self.origin, 1000);
	while (head)
	{
		if (visible (head))
		{
			if ((trace_plane_dist < dist))
			{
				if (((head.health > 0) && (head != self)))
				{
					if ((((head.classname != "player") && (head.classname != self.classname)) && (head.classname != "camera")))
					{
						if ((head.flags & FL_MONSTER))
						{
							selected = head;
							dist = trace_plane_dist;
						}
					}
				}
			}
		}
		head = head.chain;
	}
	if (((selected == world) || (selected == self.enemy)))
	{
		return (0);
	}
	else
	{
		self.enemy = selected;
		FoundTarget ();
		HuntTarget ();
		return (1);
	}
};

float () qguy_tolerance =
{
	if ((self.enemy.classname == "monster_qguy"))
	{
		if ((self.pest == world))
		{
			self.pest = self.enemy;
		}
		if ((self.pest != self.enemy))
		{
			self.tolerate = 0;
			self.pest = self.enemy;
		}
		self.tolerate = (self.tolerate + 1);
		if ((self.tolerate > 2))
		{
			return (0);
		}
		self.enemy = world;
		self.goalentity = world;
		self.oldenemy = world;
		return (1);
	}
	return (0);
};
//END
