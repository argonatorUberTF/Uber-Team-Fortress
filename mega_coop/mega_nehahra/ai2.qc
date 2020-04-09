void (vector org, vector min, vector max, vector vel, entity ignore) ai3_tracetoss =
{
	if (!tracetossent)
	{
		tracetossent = spawn ();
	}
	setorigin (tracetossent, org);
	setsize (tracetossent, min, max);
	tracetossent.velocity = vel;
	tracetoss (tracetossent, ignore);
};
float (vector vec2, float t, vector mustaine) ai2_tracetoss =
{
	local vector megadeth;
	local vector dave;
	local vector vec;
	local float num;
	megadeth = self.velocity;
	makevectors (vec2);
	self.velocity = ((v_forward * t) + mustaine);
	tracetoss (self, self);
	if (self.enemy)
	{
		if ((((trace_ent != world) && (trace_ent != self.enemy)) && (trace_ent.classname != self.classname)))
		{
			self.velocity = megadeth;
			return (0);
		}
		if ((trace_endpos_z < self.enemy.origin_z))
		{
			num = self.enemy.origin_z - trace_endpos_z;
			if ((num > 150))
			{
				self.velocity = megadeth;
				return (0);
			}
		}
	}
	dave = trace_endpos;
	vec = dave - '0 0 400';
	traceline (dave, vec, 0, self);
	num = pointcontents (trace_endpos);
	if (((trace_fraction == 1) || (num < CONTENT_SLIME)))
	{
		self.velocity = megadeth;
		return (0);
	}
	if (((self.brain & NO_SWIM) && (num < CONTENT_SOLID)))
	{
		self.velocity = megadeth;
		return (0);
	}
	else
	{
		self.velocity = megadeth;
		return (1);
	}
};
void (vector megadeth, float t) ai_ledgejump =
{
	local float num;
	if (visible (self.enemy))
	{
		if (ai2_check_z ())
		{
			num = at_ledge (megadeth, self.origin);
			if ((num < CONTENT_WATER))
			{
				return;
			}
			if ((num == CONTENT_WATER))
			{
				if ((self.brain & NO_SWIM))
				{
					return;
				}
			}
			if ((t == 0))
			{
				ai2_jump (megadeth, 200, '0 0 225');
			}
			else
			{
				ai2_jump (megadeth, -200, '0 0 230');
			}
		}
	}
};
void (entity head, vector vec) ai_teleport =
{
	spawn_tfog (head.origin);
	spawn_tdeath (vec, head);
	head.origin = vec;
	spawn_tfog (vec);
	setorigin (head, vec);
	head.flags = (head.flags - (head.flags & FL_ONGROUND));
};
void () ai_checkflee =
{
	if ((((self.health > 39) && self.flags) & FL_FLEE))
	{
		self.flags = (self.flags - FL_FLEE);
	}
	if (((self.health < 40) && (random () < 0.2)))
	{
		if (!(self.flags & FL_FLEE))
		{
			self.flags = (self.flags | FL_FLEE);
		}
	}
};
void (float num, vector dave) ai2_jumpsplash =
{
	local vector megadeth;
	megadeth = self.enemy.origin - self.origin;
	if ((vlen (megadeth) < 150))
	{
		if ((self.flags & FL_ONGROUND))
		{
			makevectors (self.angles);
			self.origin_z = (self.origin_z + 1);
			self.velocity = ((v_forward * num) + dave);
			self.flags = (self.flags - FL_ONGROUND);
		}
	}
};
void (vector vec, float num, vector dave) ai2_jump =
{
	if ((self.flags & FL_SWIM))
	{
		return;
	}
	if ((self.flags & FL_ONGROUND))
	{
		vec_x = 0;
		vec_z = 0;
		makevectors (vec);
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * num) + dave);
		self.flags = (self.flags - FL_ONGROUND);
	}
};
float (string foe, float dist, float kind) ai_emnity =
{
	local entity head;
	local vector megadeth;
	local entity selected;
	selected = world;
	head = find (world, classname, foe);
	while (head)
	{
		visible (head);
		if ((visible (head) && (head.health > 0)))
		{
			megadeth = head.origin - self.origin;
			if ((vlen (megadeth) < dist))
			{
				selected = head;
			}
		}
		head = find (head, classname, foe);
	}
	if ((selected == world))
	{
		return (0);
	}
	if ((kind == 0))
	{
		self.pain_finished = (time + 0.6);
		T_Damage (self, selected, selected, 0.1);
	}
	else
	{
		self.objekt = head;
	}
	return (1);
};
float (vector vec, vector vec2) at_ledge =
{
	local float num;
	local vector spot1;
	local vector spot2;
	local vector start;
	local vector end;
	local vector megadeth;
	local float cont;
	if ((self.flags & FL_SWIM))
	{
		return (-7);
	}
	if (!(self.flags & FL_ONGROUND))
	{
		return (-7);
	}
	megadeth = vec;
	megadeth_x = 0;
	megadeth_z = 0;
	makevectors (megadeth);
	spot1 = vec2 - '0 0 24';
	spot2 = vec2 + (v_forward * 80);
	traceline (spot1, spot2, 1, self);
	if ((trace_fraction < 1))
	{
		return (-8);
	}
	megadeth = spot1;
	spot1 = spot2 - '0 0 1000';
	traceline (spot2, spot1, 1, self);
	cont = pointcontents (trace_endpos);
	num = trace_endpos_z;
	if ((trace_fraction >= 0.1))
	{
		start = megadeth;
		end = vec2 + (v_forward * 175);
		traceline (start, end, 1, self);
		if ((trace_fraction < 1))
		{
			return (-9);
		}
		start = trace_endpos;
		end = start - '0 0 1000';
		traceline (start, end, 1, self);
		if ((trace_endpos_z == num))
		{
			if ((pointcontents (trace_endpos) != cont))
			{
				return (-10);
			}
			return (cont);
		}
	}
	return (-11);
};
float () ai_mourndead =
{
	local entity head;
	local entity selected;
	local vector megadeth;
	local float dist;
	if ((self.classname == "monster_gaunt"))
	{
		if ((self.event == "done"))
		{
			return (0);
		}
	}
	dist = 200;
	selected = world;
	head = find (world, classname, self.classname);
	while (head)
	{
		if (((head.health < 1) && (head != self)))
		{
			if ((head.relations != 66))
			{
				megadeth = self.origin - head.origin;
				if ((vlen (megadeth) < 150))
				{
					selected = head;
				}
			}
		}
		head = find (head, classname, self.classname);
	}
	if ((selected == world))
	{
		return (0);
	}
	else
	{
		if ((self.classname != "monster_gaunt"))
		{
			selected.relations = 66;
		}
		if (self.th_mourn)
		{
			self.th_mourn ();
		}
		return (1);
	}
};
float () ai_jagmourn =
{
	local entity head;
	local entity selected;
	local vector megadeth;
	local float dist;
	dist = 200;
	selected = world;
	head = find (world, classname, self.classname);
	while (head)
	{
		if (((head.health < 1) && (head != self)))
		{
			if ((head.relations < 12))
			{
				megadeth = self.origin - head.origin;
				if ((vlen (megadeth) < 150))
				{
					selected = head;
				}
			}
		}
		head = find (head, classname, self.classname);
	}
	if ((selected == world))
	{
		return (0);
	}
	else
	{
		selected.relations = (selected.relations + 1);
		self.enemy = selected.enemy;
		// xav hax:
		if (self.th_mourn == SUB_Null) {
			bprint(2,"MOURN FIX - TELL DEV\n");
			jagger_mourn();
		}
		else
			self.th_mourn ();
		return (1);
	}
};
float () ai_check_z =
{
	local float num;
	if ((self.origin_z < self.enemy.origin_z))
	{
		num = self.enemy.origin_z - self.origin_z;
		if ((num > 80))
		{
			return (1);
		}
	}
	return (0);
};
float () ai2_check_z =
{
	local float num;
	if ((self.classname == "monster_hknight"))
	{
		if ((self.watertype != self.enemy.watertype))
		{
			return (0);
		}
	}
	if ((self.origin_z > self.enemy.origin_z))
	{
		if ((self.enemy.watertype > CONTENT_SLIME))
		{
			num = self.origin_z - self.enemy.origin_z;
			if ((num > 80))
			{
				return (1);
			}
		}
		else
		{
			self.nojump = 10;
		}
	}
	return (0);
};
void () objekt_touch =
{
	if ((self.enemy == world))
	{
		if (((other.classname == "player") && (self.enemy.classname != "player")))
		{
			if (self.th_back)
			{
				self.objekt = other;
				self.touch = SUB_Null;
				self.th_back ();
			}
		}
	}
};
void () ai_objledge =
{
	local float num;
	if ((self.nojump == 1))
	{
		return;
	}
	if ((self.origin_z > self.objekt.origin_z))
	{
		if ((self.objekt.watertype > CONTENT_SLIME))
		{
			num = self.origin_z - self.objekt.origin_z;
			if ((num > 80))
			{
				if (visible (self.objekt))
				{
					ai_face_objekt ();
					ai2_jump (self.origin/*self.ideal_yaw*/, 200, '0 0 225');
				}
			}
		}
	}
};
float (float dist) ai_checkobjdist =
{
	local vector megadeth;
	megadeth = self.objekt.origin - self.origin;
	if ((vlen (megadeth) < dist))
	{
		return (0);
	}
	else
	{
		return (1);
	}
};
float () ai_checksmalldist =
{
	local vector megadeth;
	if (!visible (self.enemy))
	{
		return (0);
	}
	megadeth = self.enemy.origin - self.origin;
	if ((vlen (megadeth) < 100))
	{
		return (1);
	}
	else
	{
		return (0);
	}
};
float () ai_checkdist =
{
	local vector megadeth;
	if ((self.th_melee && (self.classname != "monster_cook")))
	{
		return (0);
	}
	if (!visible (self.enemy))
	{
		return (0);
	}
	megadeth = self.enemy.origin - self.origin;
	if (((vlen (megadeth) < 200) && (self.classname != "monster_zombie")))
	{
		return (1);
	}
	else
	{
		return (0);
	}
};
float (entity mark, float dist) ai2_checkdist =
{
	local vector megadeth;
	megadeth = mark.origin - self.origin;
	if ((vlen (megadeth) < dist))
	{
		return (1);
	}
	else
	{
		return (0);
	}
};
void (entity mark) ai2_face =
{
	self.ideal_yaw = vectoyaw ((mark.origin - self.origin));
	ChangeYaw ();
};
void () ai_face_goal =
{
	if ((self.goalentity == world))
	{
		return;
	}
	self.ideal_yaw = vectoyaw ((self.goalentity.origin - self.origin));
	ChangeYaw ();
};
void () ai_face_objekt =
{
	self.ideal_yaw = vectoyaw ((self.objekt.origin - self.origin));
	ChangeYaw ();
};
void (float dist) ai2_walk =
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
	movetogoal (dist);
};
void () ai2_stand =
{
	if (self.objekt)
	{
	}
	if ((time < self.pausetime))
	{
		return;
	}
	self.th_walk ();
};
void (float dist) ai2_run =
{
	local vector megadeth;
	local entity putz;
	if (((self.relations == 4) && (self.enemy.classname == "player")))
	{
		self.enemy = world;
		self.oldenemy = world;
		self.goalentity = world;
		self.th_stand ();
		return;
	}
	movedist = dist;
	self.goalentity = self.enemy;
	if (((self.objekt && (self.enemy.enemy == self.objekt)) && !visible (self.enemy)))
	{
		self.enemy = world;
		self.oldenemy = world;
		self.goalentity = world;
		self.th_stand ();
		return;
	}
	megadeth = self.enemy.origin - self.origin;
	if ((self.enemy.health <= 0))
	{
		putz = self.enemy;
		self.enemy = world;
		self.goalentity = world;
		self.objekt = world;
		if ((self.th_wins && (putz.classname == "player")))
		{
			self.walkframe = 0;
			self.th_wins ();
			return;
		}
		if ((self.oldenemy.health > 0))
		{
			self.enemy = self.oldenemy;
			HuntTarget ();
		}
		else
		{
			if (self.movetarget)
			{
				self.th_walk ();
			}
			else
			{
				self.th_stand ();
			}
			return;
		}
	}
	if (!(self.brain & NO_SWIM))
	{
		if ((self.watertype < CONTENT_SOLID))
		{
			monster_swim ();
		}
	}
	self.show_hostile = (time + 1);
	enemy_vis = visible (self.enemy);
	if (enemy_vis)
	{
		self.search_time = (time + MOVETYPE_FLY);
	}
	if ((coop && (self.search_time < time)))
	{
		if (FindTarget ())
		{
			return;
		}
	}
	enemy_infront = infront (self.enemy);
	enemy_range = range (self.enemy);
	enemy_yaw = vectoyaw ((self.enemy.origin - self.origin));
	if (!(self.brain & INTREPID))
	{
		if ((self.flags & FL_ONGROUND))
		{
			if (ai_threats ())
			{
				return;
			}
		}
		if ((vlen (megadeth) > 1000))
		{
			if (((self.health < 40) && !visible (self.enemy)))
			{
				if ((random () > 0.9))
				{
					self.enemy = world;
					self.oldenemy = world;
					self.th_stand ();
					return;
				}
				if ((random () < 0.5))
				{
					T_Heal (self, 1, 1);
				}
				ai_back (8);
			}
		}
		if (((self.health < 50) && (self.health < self.enemy.health)))
		{
			if ((self.th_missile && (walkmove ((self.angles_y - 180), movedist) == 0)))
			{
				if (((random () > 0.6) && visible (self.enemy)))
				{
					self.th_missile ();
				}
				ai_run_slide (/*10*/);
			}
			else
			{
				ai_back (8);
			}
			if ((random () < 0.1))
			{
				T_Heal (self, 1, 1);
			}
			if (((random () < 0.3) && visible (self.enemy)))
			{
				CheckAnyAttack ();
			}
		}
	}
	if ((self.nojump == 0))
	{
		ai_ledgejump (self.angles, 0);
	}
	if ((self.attack_state == AS_MISSILE))
	{
		ai_run_missile (/*dist*/);
		return;
	}
	if ((self.attack_state == AS_MELEE))
	{
		ai_run_melee (/*dist*/);
		return;
	}
	if (CheckAnyAttack ())
	{
		return;
	}
	if ((self.attack_state == AS_SLIDING))
	{
		ai_run_slide (/*0.1*/);
		return;
	}
	if ((self.classname != "monster_wizard"))
	{
		movetogoal (dist);
		return;
	}
	if (ai_checkdist ())
	{
		if ((random () < 0.8))
		{
			if ((walkmove ((self.angles_y - 180), 15) == TRUE))
			{
				return;
			}
		}
	}
	if (!self.th_melee)
	{
		if (ai2_checkdist (self.enemy, 250))
		{
			if (visible (self.enemy))
			{
				self.th_missile ();
				return;
			}
		}
	}
	if ((self.brain & BLINK))
	{
		ai4_checkblink ();
	}
	if ((self.brain & NAVLOGIC))
	{
		if (ai4_strategy (dist))
		{
			return;
		}
	}
	movetogoal (dist);
};
void () ai2_run_slide =
{
	local float ofs;

	if (self.lefty)
	{
		ofs = 90;
	}
	else
	{
		ofs = -90;
	}
	if (walkmove ((self.ideal_yaw + ofs), movedist))
	{
		if ((ofs == -90))
		{
			makevectors (self.angles);
			self.flags = (self.flags - (self.flags & FL_ONGROUND));
			self.velocity = (v_right * 160);
		}
		else
		{
			makevectors (self.angles);
			self.flags = (self.flags - (self.flags & FL_ONGROUND));
			self.velocity = (v_right * -160);
		}
		return;
	}
	self.lefty = (1 - self.lefty);
	walkmove ((self.ideal_yaw - ofs), movedist);
	if ((ofs == -90))
	{
		makevectors (self.angles);
		self.flags = (self.flags - (self.flags & FL_ONGROUND));
		self.velocity = (v_right * 160);
	}
	else
	{
		makevectors (self.angles);
		self.flags = (self.flags - (self.flags & FL_ONGROUND));
		self.velocity = (v_right * -160);
	}
};
void (float dist) ai3_pain =
{
	if ((time < self.enemy.attack_finished))
	{
		ai_run_slide ();
		return;
	}
	ai_back (dist);
};
void (float dist) ai3_run =
{
	local vector megadeth;
	local entity putz;

	if (((self.relations == 4) && (self.enemy.classname == "player")))
	{
		self.enemy = world;
		self.oldenemy = world;
		self.goalentity = world;
		self.th_stand ();
		return;
	}
	movedist = dist;
	self.goalentity = self.enemy;
	if (((self.objekt && (self.enemy.enemy == self.objekt)) && !visible (self.enemy)))
	{
		self.enemy = world;
		self.oldenemy = world;
		self.goalentity = world;
		self.th_stand ();
		return;
	}
	megadeth = self.enemy.origin - self.origin;
	if ((self.enemy.health <= 0))
	{
		putz = self.enemy;
		self.enemy = world;
		self.goalentity = world;
		self.objekt = world;
		if ((self.th_wins && (putz.classname == "player")))
		{
			self.walkframe = 0;
			self.th_wins ();
			return;
		}
		if ((self.oldenemy.health > 0))
		{
			self.enemy = self.oldenemy;
			HuntTarget ();
		}
		else
		{
			if (self.movetarget)
			{
				self.th_walk ();
			}
			else
			{
				self.th_stand ();
			}
			return;
		}
	}
	if (!(self.brain & NO_SWIM))
	{
		if ((self.watertype < CONTENT_SOLID))
		{
			monster_swim ();
		}
	}
	self.show_hostile = (time + 1);
	enemy_vis = visible (self.enemy);
	if ((self.flags & FL_ONGROUND))
	{
		if (!(self.brain & INTREPID))
		{
			if (ai_threats ())
			{
				return;
			}
		}
	}
	if (enemy_vis)
	{
		self.search_time = (time + MOVETYPE_FLY);
	}
	if ((coop && (self.search_time < time)))
	{
		if (FindTarget ())
		{
			return;
		}
	}
	enemy_infront = infront (self.enemy);
	enemy_range = range (self.enemy);
	enemy_yaw = vectoyaw ((self.enemy.origin - self.origin));
	if ((time < self.enemy.attack_finished))
	{
		if (((self.enemy.weapon == IT_SWORD) && visible (self.enemy)))
		{
			if ((random () < 0.5))
			{
				self.th_missile ();
			}
			ai_run_slide (/*2*/);
		}
	}
	if (!(self.brain & INTREPID))
	{
		if ((self.health < 15))
		{
			if ((walkmove ((self.angles_y - 180), 20) == 0))
			{
				ai_run_slide (/*9*/);
			}
			if (((random () < 0.3) && visible (self.enemy)))
			{
				self.th_missile ();
			}
			return;
		}
	}
	if ((self.nojump == 0))
	{
		ai_ledgejump (self.angles, 0);
	}
	if ((self.attack_state == AS_MISSILE))
	{
		ai_run_missile (/*dist*/);
		return;
	}
	if ((self.attack_state == AS_MELEE))
	{
		ai_run_melee (/*dist*/);
		return;
	}
	if (CheckAnyAttack ())
	{
		return;
	}
	if ((self.attack_state == AS_SLIDING))
	{
		ai_run_slide (/*0.1*/);
		return;
	}
	if (ai_checkdist ())
	{
		ai_back (dist);
		return;
	}
	if (!self.th_melee)
	{
		if (ai2_checkdist (self.enemy, 250))
		{
			if (visible (self.enemy))
			{
				self.th_missile ();
				return;
			}
		}
	}
	if ((self.brain & BLINK))
	{
		ai4_checkblink ();
	}
	if ((self.brain & NAVLOGIC))
	{
		if (ai4_strategy (dist))
		{
			return;
		}
	}
	movetogoal (dist);
};
void (float dist) ai4_run =
{
	local vector megadeth;
	local entity putz;
	if (((self.relations == 4) && (self.enemy.classname == "player")))
	{
		self.enemy = world;
		self.oldenemy = world;
		self.goalentity = world;
		self.th_stand ();
		return;
	}
	movedist = dist;
	self.goalentity = self.enemy;
	if (((self.objekt && (self.enemy.enemy == self.objekt)) && !visible (self.enemy)))
	{
		self.enemy = world;
		self.oldenemy = world;
		self.goalentity = world;
		self.th_stand ();
		return;
	}
	megadeth = self.enemy.origin - self.origin;
	if ((self.enemy.health <= 0))
	{
		putz = self.enemy;
		self.enemy = world;
		self.goalentity = world;
		self.objekt = world;
		if ((self.oldenemy.health > 0))
		{
			self.enemy = self.oldenemy;
			HuntTarget ();
		}
		else
		{
			if (self.movetarget)
			{
				self.th_walk ();
			}
			else
			{
				self.th_stand ();
			}
			return;
		}
	}
	if (!(self.brain & NO_SWIM))
	{
		if ((self.watertype < CONTENT_SOLID))
		{
			monster_swim ();
		}
	}
	self.show_hostile = (time + 1);
	enemy_vis = visible (self.enemy);
	if ((self.flags & FL_ONGROUND))
	{
		if (!(self.brain & INTREPID))
		{
			if (ai_threats ())
			{
				return;
			}
		}
	}
	if (enemy_vis)
	{
		self.search_time = (time + MOVETYPE_FLY);
	}
	if ((coop && (self.search_time < time)))
	{
		if (FindTarget ())
		{
			return;
		}
	}
	enemy_infront = infront (self.enemy);
	enemy_range = range (self.enemy);
	enemy_yaw = vectoyaw ((self.enemy.origin - self.origin));
	if ((time < self.enemy.attack_finished))
	{
		if (((self.enemy.weapon == IT_SWORD) && visible (self.enemy)))
		{
			ai_run_slide (/*6*/);
		}
	}
	if (!(self.brain & INTREPID))
	{
		if ((self.health < 15))
		{
			if ((walkmove ((self.angles_y - 180), 20) == 0))
			{
				ai_run_slide (/*9*/);
			}
			return;
		}
	}
	if ((self.nojump == 0))
	{
		ai_ledgejump (self.angles, 0);
	}
	if ((self.attack_state == AS_MISSILE))
	{
		ai_run_missile (/*dist*/);
		return;
	}
	if ((self.attack_state == AS_MELEE))
	{
		ai_run_melee (/*dist*/);
		return;
	}
	if ((self.attack_state == AS_SLIDING))
	{
		ai_run_slide (/*0.1*/);
		return;
	}
	if (ai_checkdist ())
	{
		ai_back (dist);
		return;
	}
	if ((self.brain & BLINK))
	{
		ai4_checkblink ();
	}
	if ((self.brain & NAVLOGIC))
	{
		if (ai4_strategy (dist))
		{
			return;
		}
	}
	movetogoal (dist);
};
float () Mons_consider =
{
	local entity head;
	local entity selected;
	local float dist;
	dist = 180;
	selected = world;
	head = findradius (self.enemy.origin, 180);
	while (head)
	{
		if ((trace_plane_dist < 180))
		{
			visible (head);
			if (((visible (head) && (head.health > 0)) && (head != self)))
			{
				if ((((head != self.enemy) && (head.classname != self.classname)) && (head.classname != "player")))
				{
					selected = head;
					dist = trace_plane_dist;
				}
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
		return (1);
	}
};
float () Mons_proxim =
{
	local entity head;
	local entity selected;
	local float dist;
	dist = 180;
	selected = world;
	head = findradius (self.origin, 180);
	while (head)
	{
		if ((trace_plane_dist < 180))
		{
			visible (head);
			if ((((visible (head) && (head.health > 0)) && (head != self)) && (head != self.enemy)))
			{
				if (((head.classname != self.classname) && (head.classname != "player")))
				{
					selected = head;
					dist = trace_plane_dist;
				}
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
		return (1);
	}
};
float () ai_threatproxim =
{
	local entity threata;
	local vector dave;
	if (((self.classname == "monster_qguy") && (self.relations > 1)))
	{
		return (0);
	}
	threata = find (world, classname, "player");
	if ((threata == world))
	{
		return (0);
	}
	if ((threata.health < 1))
	{
		return (0);
	}
	threata = find (world, event, "thrett");
	if ((threata != world))
	{
		if ((threata.owner != self))
		{
			dave = threata.origin - self.origin;
			if ((vlen (dave) > 300))
			{
				return (0);
			}
		}
	}
	if ((threata.owner.classname != "player"))
	{
		return (0);
	}
	else
	{
		if ((self.relations > 2))
		{
			return (0);
		}
	}
	if (((threata.owner == self.objekt) || (threata.owner.health < 1)))
	{
		return (0);
	}
	self.enemy = threata.owner;
	FoundTarget ();
	HuntTarget ();
	return (1);
};
void (float dist) ai2_fleerun =
{
	self.enemy = world;
	self.oldenemy = world;
	if (((self.goalentity.classname != "path_danger") && (self.goalentity.classname != "path_corner")))
	{
		self.goalentity = SelectPathTarget ("path_danger");
		if ((self.goalentity == world))
		{
			self.movetarget = SelectPathTarget ("path_corner");
			self.goalentity = SelectPathTarget ("path_corner");
		}
	}
	movetogoal (dist);
};
entity (string pathst) SelectPathTarget =
{
	local entity head;
	local entity selected;
	local float dist;
	dist = 700;
	selected = world;
	head = findradius (self.origin, 700);
	while (head)
	{
		if ((head.classname == pathst))
		{
			if (visible (head))
			{
				selected = head;
				dist = trace_plane_dist;
			}
		}
		head = head.chain;
	}
	return (selected);
};
float () coward_is_safe =
{
	local entity head;
	local entity selected;
	selected = world;
	head = find (world, soul, "yes");
	while (head)
	{
		visible (head);
		if ((visible (head) && (head.classname != self.classname)))
		{
			selected = head;
		}
		head = find (head, soul, "yes");
	}
	if ((selected == world))
	{
		return (0);
	}
	return (1);
};
//END
