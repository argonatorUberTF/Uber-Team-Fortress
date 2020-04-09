void () monster_qforge =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/forqguy.mdl");
	precache_sound ("forge/fline1.wav");
	precache_sound ("forge/fline2.wav");
	precache_sound ("forge/fline3.wav");
	precache_sound ("forge/fline4.wav");
	precache_sound ("forge/fline5.wav");
	precache_sound ("forge/fline6.wav");
	self.impulse = 0;
	self.cnt = 0;
	self.state = 0;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	setmodel (self, "progs/forqguy.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = 90;
	self.use = qforge_spiel_go;
	self.th_stand = qforge_begin;
	self.th_walk = qforge_wait;
	self.th_die = qforge_die;
	walkmonster_start ();
};
void () qforge_spiel_go =
{
	self.use = SUB_Null;
	spawn_qforgespeak ();
	self.state = 1;
};
void () qforge_begin =
{
	self.takedamage = DAMAGE_NO;
	self.use = qforge_spiel_go;
	qforge_wait ();
};
void () qforge_wait =
{
	if ((self.state > 0))
	{
		self.walkframe = 0;
		qforge_lookup ();
		return;
	}
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
		if ((random () < 0.2))
		{
			qforge_stir ();
			return;
		}
	}
	parse_anim (0, qforge_wait );
	self.frame = self.walkframe;
	self.walkframe = (self.walkframe + 1);
};
void () qforge_stir =
{
	if ((self.state > 0))
	{
		self.walkframe = 0;
		qforge_lookup ();
		return;
	}
	if ((self.walkframe >= 9))
	{
		self.walkframe = 0;
		qforge_wait ();
		return;
	}
	parse_anim (5, qforge_stir );
	self.frame = (5 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () qforge_lookup =
{
	if ((self.walkframe >= 7))
	{
		self.walkframe = 0;
		if ((self.state == 1))
		{
			qforge_uptalk ();
			self.state = 2;
			return;
		}
		else
		{
			self.health = 0;
			self.th_die ();
			return;
		}
	}
	parse_anim (14, qforge_lookup );
	if ((self.state == 1))
	{
		self.frame = (14 + self.walkframe);
	}
	else
	{
		self.frame = (20 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
};
void () qforge_uptalk =
{
	if ((self.state > 2))
	{
		self.walkframe = 0;
		qforge_lookup ();
		return;
	}
	if ((self.walkframe >= 4))
	{
		self.walkframe = 0;
	}
	parse_anim (21, qforge_uptalk );
	self.frame = (21 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () qforge_die = [ 25, qforge_die2 ]
{
	self.solid = SOLID_NOT;
};
void () qforge_die2 = [ 26, qforge_die3 ]
{};
void () qforge_die3 = [ 27, qforge_die4 ]
{};
void () qforge_die4 = [ 28, qforge_die5 ]
{};
void () qforge_die5 = [ 29, qforge_die6 ]
{};
void () qforge_die6 = [ 30, qforge_die6 ]
{};
void () spawn_qforgespeak =
{
	local entity mark;
	mark = spawn ();
	setorigin (mark, self.origin);
	mark.cnt = 0;
	mark.owner = self;
	mark.blink = 0;
	mark.think = qforge_talk;
	mark.nextthink = (time + 0.3);
};
void () qforge_talk =
{
	self.cnt = (self.cnt + 1);
	if ((self.cnt == 1))
	{
		sound (self, CHAN_AUTO, "forge/fline1.wav", 1, ATTN_IDLE);
		self.blink = 4;
	}
	if ((self.cnt == 2))
	{
		sound (self, CHAN_AUTO, "forge/fline2.wav", 1, ATTN_IDLE);
		self.blink = 8;
	}
	if ((self.cnt == 3))
	{
		sound (self, CHAN_AUTO, "forge/fline3.wav", 1, ATTN_IDLE);
		self.blink = 7;
	}
	if ((self.cnt == 4))
	{
		sound (self, CHAN_AUTO, "forge/fline4.wav", 1, ATTN_IDLE);
		self.blink = 4;
	}
	if ((self.cnt == 5))
	{
		sound (self, CHAN_AUTO, "forge/fline5.wav", 1, ATTN_IDLE);
		self.blink = 3;
	}
	if ((self.cnt == 6))
	{
		sound (self, CHAN_AUTO, "forge/fline6.wav", 1, ATTN_IDLE);
		self.blink = 0.1;
	}
	if ((self.cnt > 6))
	{
		self.owner.state = (self.owner.state + 1);
		remove (self);
		return;
	}
	self.think = qforge_talk;
	self.nextthink = (time + self.blink);
};
void () monster_labguy =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/lab1.mdl");
	precache_sound ("player/udeath.wav");
	self.classname = "monster_qguy";
	self.skin = 3;
	self.blink = 0;
	self.th_stand = lab_idle;
	self.th_walk = lab_walk;
	self.th_run = lab_run;
	self.th_die = lab_die;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/lab1.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = 50;
	walkmonster_start ();
};
void () lab_idle =
{
	self.state = 0;
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
		self.blink = (self.blink + 1);
		if ((self.blink > 4))
		{
			self.blink = 0;
			if ((random () < 0.4))
			{
				lab_idleaction ();
				return;
			}
		}
	}
	parse_anim (0, lab_idle );
	self.frame = (0 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab_idleaction =
{
	local float num;
	self.state = 0;
	num = random () + random ();
	if ((num < 0.5))
	{
		lab_looking ();
		return;
	}
	if ((num < 1))
	{
		lab_lookdown ();
		return;
	}
	if ((num < 1.5))
	{
		lab1_control ();
		return;
	}
	lab2_control ();
};
void () lab_looking =
{
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
		if ((self.state == 0))
		{
			self.state = 1;
		}
		else
		{
			self.state = 0;
			lab_looking2 ();
			return;
		}
	}
	parse_anim (6, lab_looking );
	if ((self.state == 0))
	{
		self.frame = (6 + self.walkframe);
	}
	else
	{
		self.frame = (10 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab_looking2 =
{
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
		if ((self.state == 0))
		{
			self.state = 1;
		}
		else
		{
			self.state = 0;
			lab_idle ();
			return;
		}
	}
	parse_anim (11, lab_looking2 );
	if ((self.state == 0))
	{
		self.frame = (11 + self.walkframe);
	}
	else
	{
		self.frame = (15 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab_lookdown =
{
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
		if ((self.state == 0))
		{
			self.state = 1;
		}
		else
		{
			self.state = 0;
			lab_idle ();
			return;
		}
	}
	parse_anim (16, lab_lookdown );
	if ((self.state == 0))
	{
		self.frame = (16 + self.walkframe);
	}
	else
	{
		self.frame = (21 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab1_control =
{
	if ((self.walkframe >= 9))
	{
		self.walkframe = 0;
		if ((self.state == 0))
		{
			self.state = 1;
			lab1_control2 ();
			return;
		}
		else
		{
			self.state = 0;
			lab_idle ();
			return;
		}
	}
	parse_anim (22, lab1_control );
	if ((self.state == 0))
	{
		self.frame = (22 + self.walkframe);
	}
	else
	{
		self.frame = (30 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab1_control2 =
{
	if ((self.walkframe >= 9))
	{
		self.walkframe = 0;
		if ((random () < 0.2))
		{
			lab1_control ();
			return;
		}
	}
	parse_anim (31, lab1_control2 );
	self.frame = (31 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab2_control =
{
	if ((self.walkframe >= 9))
	{
		self.walkframe = 0;
		if ((self.state == 0))
		{
			self.state = 1;
			lab2_control2 ();
			return;
		}
		else
		{
			self.state = 0;
			lab_idle ();
			return;
		}
	}
	parse_anim (40, lab2_control );
	if ((self.state == 0))
	{
		self.frame = (40 + self.walkframe);
	}
	else
	{
		self.frame = (48 - self.walkframe);
	}
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab2_control2 =
{
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
		if ((random () < 0.2))
		{
			lab2_control ();
			return;
		}
	}
	parse_anim (49, lab2_control2 );
	self.frame = (49 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	npc_stand ();
};
void () lab_walk =
{
	if ((self.walkframe >= 11))
	{
		self.walkframe = 0;
	}
	parse_anim (67, lab_walk );
	self.frame = (67 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	npc_walk (15);
};
void () lab_die =
{
	self.solid = SOLID_NOT;
	lab_die2 ();
};
void () lab_die2 =
{
	if ((self.walkframe >= 10))
	{
		self.think = corpse_think;
		self.nextthink = (time + 12);
		return;
	}
	parse_anim (78, lab_die2 );
	self.frame = (78 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};
void () lab_run =
{
	if ((self.walkframe >= 6))
	{
		self.walkframe = 0;
	}
	parse_anim (88, lab_run );
	self.frame = (88 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
	ai2_fleerun (30);
};
void (float dist) npc_walk =
{
	movedist = dist;
	if (self.objekt)
	{
	}
	if ((self.goalentity == world))
	{
		self.th_stand ();
		return;
	}
	if (npc_threats ())
	{
		return;
	}
	movetogoal (dist);
};
void () npc_stand =
{
	if (self.objekt)
	{
	}
	if (npc_threats ())
	{
		return;
	}
	if ((time < self.pausetime))
	{
		return;
	}
	self.th_walk ();
};
float () npc_threats =
{
	local entity head;
	local entity selected;
	selected = world;
	head = find (world, soul, "yes");
	while (head)
	{
		if (((head.enemy.classname == self.classname) || (head.enemy.classname == "player")))
		{
			if (visible (head))
			{
				selected = head;
			}
		}
		head = find (head, soul, "yes");
	}
	if ((selected == world))
	{
		return (0);
	}
	self.enemy = selected;
	self.th_run ();
	return (1);
};
//END
