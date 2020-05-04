float () ai_frolic =
{
	local float num;
	local vector dave;
	local vector vec;
	local entity mark;
	mark = self.goalentity;
	ai4_face (mark.xtrace);
	if (jagger_checktop ())
	{
		self.frolic = 0;
		self.boost = 0;
		self.wripple = rint ((20 * random ()));
		self.velocity = '0 0 0';
		self.goalentity = world;
		self.th_stand ();
		return (1);
	}
	self.frolic = (self.frolic + 1);
	if ((self.frolic == 2))
	{
		Jagger_ontop ();
	}
	if ((self.frolic > 4))
	{
		self.boost = (self.boost + 1);
		self.frolic = 0;
		makevectors (self.angles);
		num = 50;
		dave = '0 0 350';
		vec = self.origin + (v_forward * 80);
		vec = vec + '0 0 150';
		traceline (self.origin, vec, 1, self);
		if ((trace_fraction < 1))
		{
			num = 10;
			dave = '0 0 450';
			vec_x = self.origin_x;
			vec_y = self.origin_y;
			traceline (self.origin, vec, 1, self);
			if ((trace_fraction < 1))
			{
				num = -50;
				vec = self.origin - (v_forward * 80);
				traceline (self.origin, vec, 1, self);
				if ((trace_fraction < 1))
				{
					self.boost = 18;
				}
			}
		}
		if ((self.boost > 16))
		{
			self.frolic = 0;
			self.boost = 0;
			self.wripple = rint ((20 * random ()));
			self.velocity = '0 0 0';
			self.goalentity = world;
			self.th_stand ();
			return (1);
		}
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
		}
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * num) + dave);
	}
	return (0);
};
float () jagger_checktop =
{
	local vector spot;
	local float p;
	spot = self.origin + '0 0 45';
	p = pointcontents (spot);
	if ((p == CONTENT_WATER))
	{
		return (0);
	}
	if ((p == CONTENT_EMPTY))
	{
		return (0);
	}
	return (1);
};
void () jagger_frolic =
{
	if (ai_frolic ())
	{
		return;
	}
	parse_anim ( 19, jagger_frolic2 );
};
void () jagger_frolic2 =
{
	if (ai_frolic ())
	{
		return;
	}
	parse_anim ( 20, jagger_frolic3 );
};
void () jagger_frolic3 =
{
	if (ai_frolic ())
	{
		return;
	}
	parse_anim ( 21, jagger_frolic4 );
};
void () jagger_frolic4 =
{
	if ((pointcontents (self.origin) == CONTENT_WATER))
	{
		parse_anim ( 20, jagger_frolic );
		return;
	}
	if (!jagger_checktop ())
	{
		makevectors (self.angles);
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * 250) + '0 0 200');
		self.goalentity = find (world, classname, "info_jagnest");
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
		}
	}
	else
	{
		ai_run_slide(); // (2);
	}
	parse_anim ( 20, jagger_walk );
	ai2_walk (10);
};
void () jagger_ffrolic = [ 19, jagger_ffrolic2 ]
{
	ai2_walk (3);
	if ((self.flags & FL_ONGROUND))
	{
		makevectors (self.angles);
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * 500) + '0 0 300');
		self.flags = (self.flags - FL_ONGROUND);
	}
};
void () jagger_ffrolic2 = [ 20, jagger_ffrolic3 ]
{
	ai2_walk (10);
};
void () jagger_ffrolic3 = [ 21, jagger_ffrolic4 ]
{
	ai2_walk (10);
};
void () jagger_ffrolic4 = [ 20, jagger_stand ]
{
	self.goalentity = world;
	ai2_stand ();
};
void () jagger_mourn =
{
	local entity head;
	local vector megadeth;
	head = find (world, classname, "monster_jagger");
	while (head)
	{
		megadeth = self.origin - head.origin;
		if (((head.enemy == world) && (head.health > 0)))
		{
			if ((vlen (megadeth) < 1000))
			{
				head.think = jagger_call1;
			}
		}
		head = find (head, classname, "monster_jagger");
	}
	jagger_call1 ();
};
void () jagger_call =
{
	local entity head;
	head = find (world, classname, "monster_jagger");
	if (((head == world) || (head.enemy == self.enemy)))
	{
		jagger_watch ();
		return;
	}
	head.enemy = self.enemy;
	T_Damage (head, self.enemy, self.enemy, 1);
	jagger_call1 ();
};
void () jagger_call1 = [ 106, jagger_call2 ]
{
	ai_face ();
};
void () jagger_call2 = [ 107, jagger_call3 ]
{
	ai_face ();
};
void () jagger_call3 = [ 108, jagger_call4 ]
{
	ai_face ();
	sound (self, CHAN_VOICE, "jagger/bidle2.wav", 1, ATTN_IDLE);
};
void () jagger_call4 = [ 109, jagger_call5 ]
{
	ai_face ();
};
void () jagger_call5 = [ 110, jagger_call6 ]
{
	ai_face ();
};
void () jagger_call6 = [ 111, jagger_call7 ]
{
	ai_face ();
};
void () jagger_call7 = [ 112, jagger_call8 ]
{
	ai_face ();
};
void () jagger_call8 = [ 113, jagger_call9 ]
{
	ai_face ();
};
void () jagger_call9 = [ 114, jagger_call10 ]
{
	ai_face ();
};
void () jagger_call10 = [ 115, jagger_call11 ]
{
	ai_face ();
};
void () jagger_call11 = [ 116, jagger_call12 ]
{
	ai_face ();
};
void () jagger_call12 = [ 117, jagger_call13 ]
{
	ai_face ();
};
void () jagger_call13 = [ 110, jagger_call14 ]
{
	ai_face ();
};
void () jagger_call14 = [ 109, jagger_call15 ]
{
	ai_face ();
};
void () jagger_call15 =
{
	if ((self.enemy == world))
	{
		jagger_nedec ();
		return;
	}
	parse_anim ( 108, jagger_watch );
	ai_face ();
};
void () jagger_lower = [ 63, jagger_lower2 ]
{
	ai_face ();
};
void () jagger_lower2 = [ 64, jagger_lower3 ]
{
	ai_face ();
};
void () jagger_lower3 = [ 65, jagger_lower4 ]
{
	ai_face ();
};
void () jagger_lower4 = [ 66, jagger_lower5 ]
{
	ai_face ();
};
void () jagger_lower5 =
{
	ai_run (0);
	jagger2ir ();
	self.th_run ();
};
void () jagger_backup = [ 66, jagger_backup2 ]
{
	ai_face ();
};
void () jagger_backup2 = [ 65, jagger_backup3 ]
{
	ai_face ();
};
void () jagger_backup3 = [ 64, jagger_backup4 ]
{
	ai_face ();
};
void () jagger_backup4 = [ 63, jagger_backup5 ]
{
	ai_face ();
};
void () jagger_backup5 =
{
	ai_run (0);
	jagger2ni ();
	parse_anim ( 63, jagger_watch );
};
void () jagger_curious = [ 118, jagger_curious2 ]
{
	ai_face ();
};
void () jagger_curious2 = [ 119, jagger_curious3 ]
{
	ai_face ();
};
void () jagger_curious3 = [ 120, jagger_curious4 ]
{
	ai_face ();
};
void () jagger_curious4 = [ 121, jagger_curious5 ]
{
	ai_face ();
};
void () jagger_curious5 = [ 120, jagger_curious6 ]
{
	ai_face ();
};
void () jagger_curious6 = [ 119, jagger_watch ]
{
	ai_face ();
};
void () jagger_sprint1 = [ 123, jagger_sprint3 ]
{
	ai_run (35);
};
void () jagger_sprint3 = [ 124, jagger_sprint4 ]
{
	ai_run (40);
};
void () jagger_sprint4 = [ 123, jagger_run12 ]
{
	ai_run (30);
	if ((self.flags & FL_ONGROUND))
	{
		ai2_jump (self.angles, 250, '0 0 250');
	}
};
void () jagger_nod = [ 46, jagger_nod2 ]
{
	ai_face ();
};
void () jagger_nod2 = [ 47, jagger_nod3 ]
{
	ai_face ();
};
void () jagger_nod3 = [ 48, jagger_nod4 ]
{
	ai_face ();
};
void () jagger_nod4 = [ 49, jagger_nod5 ]
{
	ai_face ();
};
void () jagger_nod5 = [ 50, jagger_nod6 ]
{
	ai_face ();
};
void () jagger_nod6 = [ 51, jagger_nod7 ]
{
	ai_face ();
};
void () jagger_nod7 = [ 52, jagger_nod8 ]
{
	ai_face ();
};
void () jagger_nod8 = [ 53, jagger_nod9 ]
{
	ai_face ();
};
void () jagger_nod9 = [ 54, jagger_nod10 ]
{
	ai_face ();
};
void () jagger_nod10 = [ 55, jagger_nod11 ]
{
	ai_face ();
};
void () jagger_nod11 =
{
	jagger2norm ();
	self.goalentity = world;
	self.enemy = world;
	self.oldenemy = world;
	self.th_stand ();
};
void () jagger_old_idlesound =
{
	if ((random () < 0.05))
	{
		sound (self, CHAN_VOICE, "jagger/bidle.wav", 1, ATTN_IDLE);
		sound (self, CHAN_VOICE, "jagger/bidle2.wav", 1, ATTN_IDLE);
	}
	ai_walk (8);
};
void () jagger_walk = [ 0, jagger_walk2 ]
{
	ai2_walk (10);
	ai_jagmourn ();
};
void () jagger_walk2 = [ 1, jagger_walk3 ]
{
	ai2_walk (18);
	if ((pointcontents (self.origin) == CONTENT_WATER))
	{
		Jagger_fishhunt ();
		return;
	}
	if ((self.goalentity.classname == "monster_fish"))
	{
		if ((pointcontents (self.origin) == CONTENT_SLIME))
		{
			self.goalentity = find (world, classname, "info_jagout");
		}
		else
		{
			self.goalentity = find (world, classname, "info_jagwater");
		}
	}
};
void () jagger_walk3 = [ 2, jagger_walk4 ]
{
	ai2_walk (18);
	Jagger_lookdec ();
};
void () jagger_walk4 = [ 3, jagger_walk5 ]
{
	ai2_walk (10);
	if ((self.goalentity.flags & FL_MONSTER))
	{
		if ((self.goalentity.health < 1))
		{
			self.goalentity = world;
		}
	}
};
void () jagger_walk5 = [ 4, jagger_walk6 ]
{
	ai2_walk (18);
	if ((pointcontents (self.origin) == CONTENT_WATER))
	{
		if ((self.goalentity.classname == "info_jagnest"))
		{
			self.goalentity = world;
			jagger_decide ();
		}
	}
};
void () jagger_walk6 = [ 5, jagger_nedec ]
{
	ai2_walk (18);
};
void () jagger_growl = [ 56, jagger_growl2 ]
{
	ai_run (0);
};
void () jagger_growl2 = [ 57, jagger_growl3 ]
{
	ai_face ();
};
void () jagger_growl3 = [ 58, jagger_growl4 ]
{
	ai_face ();
};
void () jagger_growl4 = [ 59, jagger_growl5 ]
{
	ai_face ();
	sound (self, CHAN_VOICE, "jagger/bidle.wav", 1, ATTN_IDLE);
};
void () jagger_growl5 = [ 60, jagger_growl6 ]
{
	ai_face ();
};
void () jagger_growl6 = [ 61, jagger_growl7 ]
{
	ai_face ();
};
void () jagger_growl7 = [ 62, jagger_irdec ]
{
	ai_face ();
};
void () jagger2_growl = [ 77, jagger2_growl2 ]
{
	ai_face ();
};
void () jagger2_growl2 = [ 78, jagger2_growl3 ]
{
	ai_face ();
	sound (self, CHAN_VOICE, "jagger/bidle.wav", 1, ATTN_IDLE);
};
void () jagger2_growl3 = [ 79, jagger2_growl4 ]
{
	ai_face ();
};
void () jagger2_growl4 = [ 80, jagger2_growl5 ]
{
	ai_face ();
};
void () jagger2_growl5 = [ 81, jagger2_growl6 ]
{
	ai_face ();
};
void () jagger2_growl6 = [ 82, jagger2_growl7 ]
{
	ai_face ();
};
void () jagger2_growl7 = [ 83, jagger_irdec2 ]
{
	ai_face ();
};
void () jagger_scareem =
{
	local entity mustaine;
	mustaine = self.enemy;
	if ((mustaine.classname == "monster_ogre"))
	{
		mustaine.flags = (mustaine.flags + FL_FLEE);
	}
};
void () jagger_intimidate = [ 97, jagger_intimid2 ]
{
	ai_face ();
};
void () jagger_intimid2 = [ 98, jagger_intimid3 ]
{
	ai_face ();
};
void () jagger_intimid3 = [ 99, jagger_intimid4 ]
{
	ai_face ();
	sound (self, CHAN_VOICE, "jagger/bidle.wav", 1, ATTN_IDLE);
};
void () jagger_intimid4 = [ 100, jagger_intimid5 ]
{
	ai_face ();
};
void () jagger_intimid5 = [ 101, jagger_intimid6 ]
{
	ai_face ();
};
void () jagger_intimid6 = [ 102, jagger_intimid7 ]
{
	ai_face ();
};
void () jagger_intimid7 = [ 103, jagger_intimid8 ]
{
	ai_face ();
};
void () jagger_intimid8 = [ 104, jagger_intimid9 ]
{
	ai_face ();
};
void () jagger_intimid9 = [ 105, jagger_irdec ]
{
	ai_face ();
};
void () jagger_stand = [ 41, jagger_stand2 ]
{
	ai2_stand ();
	if ((self.watertype == CONTENT_WATER))
	{
		Jagger_fishhunt ();
	}
};
void () jagger_stand2 = [ 42, jagger_stand3 ]
{
	ai2_stand ();
};
void () jagger_stand3 = [ 43, jagger_stand4 ]
{
	ai2_stand ();
	if ((self.goalentity == world))
	{
		jagger_decide ();
	}
};
void () jagger_stand4 = [ 44, jagger_stand5 ]
{
	ai2_stand ();
	Jagger_lookdec ();
};
void () jagger_stand5 = [ 45, jagger_nedec ]
{
	ai2_stand ();
};
void () jagger_watch = [ 41, jagger_watch2 ]
{
	ai_face ();
};
void () jagger_watch2 = [ 42, jagger_watch3 ]
{
	ai_face ();
};
void () jagger_watch3 = [ 43, jagger_watch4 ]
{
	ai_face ();
};
void () jagger_watch4 = [ 44, jagger_watch5 ]
{
	ai_face ();
};
void () jagger_watch5 =
{
	local float gg;
	if ((self.enemy.health < 1))
	{
		jagger2norm ();
		self.enemy = world;
		self.oldenemy = world;
		self.th_stand ();
		return;
	}
	gg = random ();
	if ((gg < 0.4))
	{
		parse_anim ( 45, jagger_watch );
		return;
	}
	if ((gg < 0.6))
	{
		parse_anim ( 45, jagger_growl );
		return;
	}
	if ((gg < 0.8))
	{
		parse_anim ( 45, jagger_intimidate );
		return;
	}
	parse_anim ( 45, jagger_call );
};
void () jagger2_watch = [ 68, jagger2_watch2 ]
{
	ai_run (0);
};
void () jagger2_watch2 = [ 69, jagger2_watch3 ]
{
	ai_face ();
};
void () jagger2_watch3 = [ 70, jagger2_watch4 ]
{
	ai_face ();
};
void () jagger2_watch4 = [ 71, jagger2_watch5 ]
{
	ai_face ();
};
void () jagger2_watch5 = [ 72, jagger2_watch6 ]
{
	ai_face ();
};
void () jagger2_watch6 = [ 73, jagger2_watch7 ]
{
	ai_face ();
};
void () jagger2_watch7 = [ 74, jagger2_watch8 ]
{
	ai_face ();
};
void () jagger2_watch8 = [ 75, jagger2_watch9 ]
{
	ai_face ();
};
void () jagger2_watch9 =
{
	ai_face ();
	if ((random () < 0.4))
	{
		parse_anim ( 76, jagger2_growl );
		return;
	}
	parse_anim ( 76, jagger2_watch );
};
void () jagger_stop1 = [ 29, jagger_stop2 ]
{
	sound (self, CHAN_VOICE, "jagger/ddeath.wav", 1, ATTN_NORM);
};
void () jagger_stop2 = [ 30, jagger_stop3 ]
{};
void () jagger_stop3 = [ 31, jagger_stop4 ]
{};
void () jagger_stop4 = [ 32, jagger_stop5 ]
{};
void () jagger_stop5 = [ 33, jagger_stop6 ]
{
	self.solid = SOLID_NOT;
};
void () jagger_stop6 = [ 34, jagger_stop7 ]
{};
void () jagger_stop7 = [ 35, corpse_think ]
{};
void () jagger_bstop1 = [ 36, jagger_bstop2 ]
{
	sound (self, CHAN_VOICE, "jagger/ddeath.wav", 1, ATTN_NORM);
	ai_forward (16);
};
void () jagger_bstop2 = [ 37, jagger_bstop3 ]
{
	ai_forward (14);
};
void () jagger_bstop3 = [ 38, jagger_bstop4 ]
{
	ai_forward (10);
};
void () jagger_bstop4 = [ 39, jagger_bstop5 ]
{
	ai_forward (5);
};
void () jagger_bstop5 = [ 40, jagger_bstop6 ]
{
	self.solid = SOLID_NOT;
};
void () jagger_bstop6 =
{
	self.think = corpse_think;
	self.nextthink = (time + 3);
};
void () jagger_run =
{
	if (borkfactor1 ())
	{
		return;
	}
	if ((random () < 0.5))
	{
		if (((self.watertype == CONTENT_WATER) && (self.enemy.watertype != CONTENT_WATER)))
		{
			parse_anim ( 20, jagger_frolic );
			return;
		}
	}
	parse_anim ( 6, jagger_run2 );
	ai_run (5);
	ai_face ();
};
void () jagger_run2 = [ 7, jagger_run3 ]
{
	ai_run (5);
	ai_face ();
};
void () jagger_run3 = [ 8, jagger_run4 ]
{
	ai_run (10);
	ai_face ();
};
void () jagger_run4 = [ 9, jagger_run5 ]
{
	ai_face ();
	self.touch = jagger_JumpTouch;
	makevectors (self.angles);
	self.origin_z = (self.origin_z + 1);
	if (jagger_checktop ())
	{
		self.velocity = ((v_forward * 400) + '0 0 5');
	}
	else
	{
		self.velocity = ((v_forward * 400) + '0 0 250');
	}
	if ((self.flags & FL_ONGROUND))
	{
		self.flags = (self.flags - FL_ONGROUND);
	}
	sound (self, CHAN_VOICE, "jagger/bjump.wav", 1, ATTN_NORM);
};
void () jagger_run5 = [ 10, jagger_run6 ]
{};
void () jagger_run6 = [ 11, jagger_run7 ]
{};
void () jagger_run7 = [ 12, jagger_run8 ]
{
	if ((self.watertype != CONTENT_WATER))
	{
		return;
	}
	if (jagger_checktop ())
	{
		ai_run (25);
		return;
	}
	if (visible (self.enemy))
	{
		makevectors (self.angles);
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * 450) + '0 0 250');
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
		}
	}
};
void () jagger_run8 = [ 13, jagger_run9 ]
{};
void () jagger_run9 = [ 14, jagger_run10 ]
{};
void () jagger_run10 = [ 15, jagger_run11 ]
{
	if (jagger_checktop ())
	{
		ai_run (25);
	}
};
void () jagger_run11 = [ 16, jagger_run12 ]
{};
void () jagger_run12 =
{
	local vector megadeth;
	megadeth = self.enemy.origin - self.origin;
	if ((vlen (megadeth) > 650))
	{
		self.enemy = world;
		self.goalentity = world;
		jagger2norm ();
		parse_anim ( 13, jagger_stand );
		return;
	}
	if (ai_check_z ())
	{
		parse_anim ( 122, jagger_sprint1 );
		ai_run (15);
		return;
	}
	parse_anim ( 17, jagger_run );
};
void () jagger_atta1 = [ 23, jagger_atta2 ]
{
	ai_charge (10);
	ai_face ();
};
void () jagger_atta2 = [ 24, jagger_atta3 ]
{
	ai_charge (10);
	ai_face ();
};
void () jagger_atta3 = [ 25, jagger_atta4 ]
{
	ai_charge (10);
	jagger_bite ();
};
void () jagger_atta4 = [ 26, jagger_atta5 ]
{
	sound (self, CHAN_VOICE, "jagger/bjump2.wav", 1, ATTN_NORM);
	jagger_bite ();
};
void () jagger_atta5 = [ 27, jagger_atta6 ]
{
	ai_charge (10);
	jagger_bite ();
};
void () jagger_atta6 = [ 28, jagger_run ]
{
	ai_charge (10);
};
void () jagger_leap1 = [ 25, jagger_leap2 ]
{
	ai_face ();
};
void () jagger_leap2 = [ 26, jagger_leap3 ]
{
	ai_face ();
};
void () jagger_leap3 = [ 27, jagger_leap4 ]
{
	ai_face ();
	if ((self.flags & FL_ONGROUND))
	{
		self.touch = jagger_JumpTouch;
		makevectors (self.angles);
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * 600) + '0 0 250');
		self.flags = (self.flags - FL_ONGROUND);
		if ((random () < 0.05))
		{
			sound (self, CHAN_VOICE, "jagger/bjump.wav", 1, ATTN_NORM);
		}
	}
};
void () jagger_leap4 = [ 28, jagger_leap5 ]
{
	ai_face ();
};
void () jagger_leap5 = [ 29, jagger_leap6 ]
{
	ai_face ();
};

void () jagger_leap6 = [ 13, jagger_run ]
{
	ai_face ();
};
float () CheckJaggerMelee =
{
	if ((enemy_range == RANGE_MELEE))
	{
		self.attack_state = AS_MELEE;
		return (1);
	}
	return (0);
};
void () jagger_JumpTouch =
{
	local float ldmg;
	if ((self.health <= 0))
	{
		return;
	}
	if ((other.classname == self.classname))
	{
		return;
	}
	if (other.takedamage)
	{
		if ((vlen (self.velocity) > 300))
		{
			ldmg = 5 + (10 * random ());
			T_Damage (other, self, self, ldmg);
		}
	}
	if (!checkbottom (self))
	{
		if (((self.flags & FL_ONGROUND) || (self.watertype == CONTENT_WATER)))
		{
			self.touch = SUB_Null;
			self.think = jagger_leap1;
			self.nextthink = time;
		}
		return;
	}
	self.touch = SUB_Null;
	self.think = jagger_run8;
	self.nextthink = time;
};
void (entity attacker, float damage) jagger_pain =
{
	if ((self.touch == jagger_JumpTouch))
	{
		return;
	}
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 3);
	sound (self, CHAN_VOICE, "jagger/dpain1.wav", 1, ATTN_NORM);
	if ((pointcontents (self.origin) == CONTENT_WATER))
	{
		sound (self, 1/*CHAN_DAMAUL*/, "player/razh20.wav", 1, ATTN_NORM);
	}
	return;
};
void () jagger_die =
{
	if ((self.health < -50))
	{
		if ((self.watertype == CONTENT_WATER))
		{
			sound (self, CHAN_BODY, "player/razh20.wav", 1, ATTN_NORM);
		}
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	if ((random () > 0.4))
	{
		jagger_stop1 ();
		return;
	}
	else
	{
		self.movetype = MOVETYPE_BOUNCE;
	}
	self.velocity_x = (-50 + (100 * random ()));
	self.velocity_y = (-50 + (100 * random ()));
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	jagger_bstop1 ();
};
float () CheckJaggerJump =
{
	local vector dist;
	local float d;
	if (((self.origin_z + self.mins_z) > ((self.enemy.origin_z + self.enemy.mins_z) + (0.75 * self.enemy.size_z))))
	{
		return (0);
	}
	if (((self.origin_z + self.maxs_z) < ((self.enemy.origin_z + self.enemy.mins_z) + (0.25 * self.enemy.size_z))))
	{
		return (0);
	}
	dist = self.enemy.origin - self.origin;
	dist_z = 0;
	d = vlen (dist);
	if ((d < 80))
	{
		return (0);
	}
	if ((d > 150))
	{
		return (0);
	}
	return (1);
};
float () JaggerCheckAttack =
{
	if (CheckJaggerMelee ())
	{
		self.attack_state = AS_MELEE;
		return (1);
	}
	if (CheckJaggerJump ())
	{
		if ((self.th_run == jagger_run))
		{
			self.attack_state = AS_MISSILE;
			return (1);
		}
	}
	return (0);
};
void () jagger_bite =
{
	local vector delta;
	local float ldmg;
	if (!self.enemy)
	{
		return;
	}
	ai_charge (10);
	if (!CanDamage (self.enemy, self))
	{
		return;
	}
	delta = self.enemy.origin - self.origin;
	if ((vlen (delta) > 120))
	{
		return;
	}
	ldmg = (random () * 6) + (random () * 6);
	T_Damage (self.enemy, self, self, ldmg);
};
void () jagger_startt =
{
	trigger_spawnmonster ();
	carnify_jagger ();
};
void () carnify_jagger =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/jagger.mdl");
	setsize (self, VEC_HULL_MIN, '16 16 30');
	if (!self.health)
	{
		self.health = 480;
	}
	MTF_Setup_Monster_Postsets( self.health, coop_walkmonster_start);
};
void () jagger2norm =
{
	self.th_stand = jagger_stand;
	self.th_walk = jagger_walk;
	self.th_run = jag_from_norm;
	self.th_melee = SUB_Null;
	self.th_pain = jag_from_norm;
	self.th_missile = SUB_Null;
};

void () jagger_reset =
{
	jagger2norm ();
	self.goalentity = world;
	self.th_stand ();
};
void () jag_from_norm =
{
	if ((self.health < 150))
	{
		jagger2mad ();
		self.th_run ();
		return;
	}
	jagger2ni ();
	self.th_run ();
};
void () jagger2ni =
{
	self.th_stand = jagger_stand;
	self.th_walk = jagger_walk;
	self.th_run = jagger_watch;
	self.th_melee = SUB_Null;
	self.th_pain = jaggerpissed;
	self.th_missile = SUB_Null;
};
void () jagger2ir =
{
	self.th_stand = jagger_stand;
	self.th_walk = jagger_walk;
	self.th_run = jagger2_watch;
	self.th_melee = SUB_Null;
	self.th_missile = SUB_Null;
	self.th_pain = jaggerpissed;
};
void () jaggerpissed =
{
	jagger2mad ();
	self.th_run ();
};
void () jagger2mad =
{
	self.th_stand = jagger_reset;
	self.th_walk = jagger_reset;
	self.th_melee = jagger_atta1;
	self.th_missile = jagger_leap1;
	self.th_run = jagger_run;
	self.th_pain = jagger_pain;
};
void () jagger_decide =
{
	local entity mustaine;
	if ((self.goalentity != world))
	{
		return;
	}
	if (((pointcontents (self.origin) == CONTENT_WATER) && (random () < 0.5)))
	{
		mustaine = find (world, classname, "monster_fish");
		if ((mustaine.health > 1))
		{
			self.goalentity = mustaine;
			return;
		}
	}
	if ((self.watertype != CONTENT_WATER))
	{
		mustaine = find (world, classname, "info_jagwater");
		if ((mustaine != world))
		{
			self.goalentity = mustaine;
			return;
		}
	}
	else
	{
		mustaine = find (world, classname, "jagpoint");
		if ((mustaine != world))
		{
			self.goalentity = mustaine;
			return;
		}
		else
		{
			mustaine = find (world, classname, "info_jagout");
			if ((mustaine != world))
			{
				self.goalentity = mustaine;
				return;
			}
		}
	}
	mustaine = find (world, classname, "ambient_swamp1");
	if ((mustaine != world))
	{
		self.goalentity = mustaine;
		return;
	}
	mustaine = find (world, classname, "ambient_swamp2");
	if ((mustaine != world))
	{
		self.goalentity = mustaine;
		return;
	}
	mustaine = find (world, classname, "ambient_swamp3");
	if ((mustaine != world))
	{
		self.goalentity = mustaine;
		return;
	}
};
void () jagger_nedec =
{
	local vector megadeth;
	local entity mustaine;
	if ((self.wripple > 0))
	{
		self.wripple = (self.wripple - 1);
	}
	Jagger_ontop ();
	mustaine = self.goalentity;
	megadeth = mustaine.origin - self.origin;
	if (((mustaine.classname == "info_jagnest") && (vlen (megadeth) < 250)))
	{
		mustaine = world;
		if ((self.cnt > 0))
		{
			Spew_fish ();
			self.cnt = (self.cnt - 1);
		}
	}
	if ((mustaine == world))
	{
		if ((random () < 0.1))
		{
			self.goalentity = world;
		}
		jagger_stand ();
		return;
	}
	megadeth = mustaine.origin - self.origin;
	if (((mustaine.classname == "ambient_swamp1") || (mustaine.classname == "ambient_swamp2")))
	{
		if ((vlen (megadeth) < 200))
		{
			if (((self.watertype == CONTENT_WATER) && (self.wripple < 1)))
			{
				mustaine = find (world, classname, "info_jagout");
			}
			else
			{
				mustaine = find (world, classname, "info_jagwater");
			}
		}
	}
	if ((((mustaine.classname == "info_jagwater") || (mustaine.classname == "info_jagout")) || (mustaine.classname == "jagpoint")))
	{
		if ((self.wripple <= 0))
		{
			if ((pointcontents (self.origin) == CONTENT_WATER))
			{
				jagger_frolic ();
				return;
			}
			else
			{
				if ((vlen (megadeth) < 600))
				{
					jagger_ffrolic ();
					return;
				}
			}
		}
	}
	if ((mustaine.classname == "monster_fish"))
	{
		if ((mustaine.health < 1))
		{
			self.goalentity = world;
			jagger_stand ();
			return;
		}
		if (((vlen (megadeth) < 200) || visible (mustaine)))
		{
			jagger2mad ();
			parse_anim ( 6, jagger_run );
			return;
		}
	}
	jagger_walk ();
};
void () jagger_irdec =
{
	local entity mustaine;
	local vector megadeth;
	local float no9;
	mustaine = find (world, classname, "info_jagnest");
	if ((mustaine != world))
	{
		megadeth = mustaine.origin - self.origin;
		if ((vlen (megadeth) < 400))
		{
			jagger2mad ();
			self.th_run ();
			return;
		}
	}
	mustaine = self.enemy;
	megadeth = mustaine.origin - self.origin;
	no9 = vlen (megadeth);
	if (((mustaine.health < 1) || (no9 > 300)))
	{
		jagger_nod ();
		return;
	}
	if ((no9 < 110))
	{
		jagger2mad ();
		self.th_run ();
		return;
	}
	if (((no9 > 109) && (no9 < 160)))
	{
		jagger_lower ();
		return;
	}
	if (((no9 > 159) && (no9 < 250)))
	{
		jagger_watch ();
		return;
	}
	if (((no9 > 249) && (no9 < 301)))
	{
		if ((random () < 0.5))
		{
			jagger_watch ();
			return;
		}
		jagger_curious ();
		return;
	}
	jagger_watch ();
};
void () jagger_irdec2 =
{
	local entity mustaine;
	local vector megadeth;
	local float no9;
	if ((self.relations == -1))
	{
		jaggerpissed ();
		return;
	}
	mustaine = find (world, classname, "info_jagnest");
	if ((mustaine != world))
	{
		megadeth = mustaine.origin - self.origin;
		if ((vlen (megadeth) < 600))
		{
			jagger2mad ();
			self.th_run ();
			return;
		}
	}
	mustaine = self.enemy;
	megadeth = mustaine.origin - self.origin;
	no9 = vlen (megadeth);
	if (((mustaine.health < 1) || (no9 > 300)))
	{
		jagger_backup ();
		return;
	}
	if ((no9 < 110))
	{
		jagger2mad ();
		self.th_run ();
		return;
	}
	if (((no9 > 109) && (no9 < 160)))
	{
		jagger2_watch ();
		return;
	}
	if (((no9 > 159) && (no9 < 300)))
	{
		jagger_backup ();
		return;
	}
	jagger2_watch ();
};
float () Jagger_lookdec =
{
	local entity head;
	local entity selected;
	local float dist;
	dist = 300;
	selected = world;
	head = findradius (self.origin, 300);
	while (head)
	{
		if (((head.flags & FL_CLIENT) || (head.flags & FL_MONSTER)))
		{
			if (!(head.flags & FL_NOTARGET))
			{
				if ((visible (head) && (trace_plane_dist < 300)))
				{
					if (((head.health > 0) && (head != self)))
					{
						if (((head.classname != "monster_fish") && (head.classname != self.classname)))
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
	if ((selected == world))
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
float () Jagger_fishhunt =
{
	local entity head;
	local entity selected;
	local float dist;
	if ((self.watertype != CONTENT_WATER))
	{
		return 0;
	}
	dist = 120;
	selected = world;
	head = findradius (self.origin, 300);
	while (head)
	{
		if ((visible (head) && (trace_plane_dist < 300)))
		{
			if (((head.health > 0) && (head != self)))
			{
				if ((head.classname == "monster_fish"))
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
		self.enemy = selected;
		if ((self.classname == "monster_jagger"))
		{
			jagger2mad ();
		}
		FoundTarget ();
		HuntTarget ();
		return (1);
	}
};
float () Jagger_ontop =
{
	local entity head;
	local entity selected;
	local float dist;
	dist = 90;
	selected = world;
	head = findradius (self.origin, 90);
	while (head)
	{
		if ((trace_plane_dist < 90))
		{
			if ((((head.health > 0) && (head != self)) && (head.watertype == CONTENT_WATER)))
			{
				if (((head.classname == self.classname) && (self.origin_z > head.origin_z)))
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
		makevectors (self.angles);
		self.origin_z = (self.origin_z + 1);
		self.velocity = ((v_forward * -250) + '0 0 350');
		if ((self.flags & FL_ONGROUND))
		{
			self.flags = (self.flags - FL_ONGROUND);
		}
		return (1);
	}
};
void () Spew_fish =
{
	local entity item77;
	item77 = spawn ();
	item77.origin = (self.origin + '0 0 24');
	item77.velocity_z = 300;
	item77.velocity_x = (-100 + (random () * 200));
	item77.velocity_y = (-100 + (random () * 200));
	item77.flags = FL_ITEM;
	item77.enemy = self;
	item77.health = 10;
	item77.solid = SOLID_NOT;
	item77.movetype = MOVETYPE_STEP;
	item77.classname = "spew_fish";
	setmodel (item77, "progs/ogre.mdl");
	setsize (item77, VEC_HULL_MIN, '16 16 3');
	item77.frame = 35;
	item77.nextthink = (time + 0.2);
	item77.think = SUB_Null;
	item77.th_stand = SUB_Null;
	item77.th_walk = SUB_Null;
	item77.th_run = SUB_Null;
	item77.th_pain = fishy_blood;
	item77.th_melee = SUB_Null;
	item77.th_missile = SUB_Null;
	item77.th_die = fish_splat;
};
void () fishy_blood =
{
	SpawnMeatSpray (self.origin, ((crandom () * 86) * v_right));
};
void () fish_splat =
{
	SpawnMeatSpray (self.origin, ((crandom () * 86) * v_right));
	ThrowGib ("progs/gib1.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);
	remove (self);
};
void () info_jagnest =
{
	self.cnt = 0;
	self.think = fish_tally;
	self.nextthink = (time + 1.2);
};
void () fish_tally =
{
	local entity e;
	local float n;
	local float j;
	local entity head;
	local entity selected;
	local float dist;

	j = 0;
	e = find (world, classname, "monster_jagger");
	while (e)
	{
		if ((e.health > 5))
		{
			j = j + 1;
		}
		e = find (e, classname, "monster_jagger");
	}
	n = 0;
	e = find (world, classname, "spew_fish");
	while (e)
	{
		n = n + 1;
		e = find (e, classname, "spew_fish");
	}
	if ((n < j))
	{
		self.cnt = n;
	}
	else
	{
		dist = 250;
		selected = world;
		head = findradius (self.origin, 250);
		while (head)
		{
			if ((trace_plane_dist < 250))
			{
				if ((head.health > 0))
				{
					if ((head.classname == "monster_jagger"))
					{
						selected = head;
						dist = trace_plane_dist;
					}
				}
			}
			head = head.chain;
		}
		if ((selected != world))
		{
			e = find (world, classname, "spew_fish");
			if ((pointcontents (e.origin) == CONTENT_EMPTY))
			{
				e.flags = FL_MONSTER;
				e.takedamage = DAMAGE_AIM;
				e.solid = SOLID_SLIDEBOX;
			}
		}
	}
	self.nextthink = (time + 1.2);
};
void () info_jagwater =
{
	local entity new;
	if ((self.spawnflags > 0))
	{
		new = spawn ();
		new.origin = self.origin;
		new.classname = "info_jagout";
		setorigin (new, self.origin);
		new.think = jagout_assess;
		new.nextthink = (time + 1);
		remove (self);
	}
};
void () info_jagout =
{
	self.think = jagout_assess;
	self.nextthink = (time + 1);
};
void () jagout_assess =
{
	local vector vec;
	vec = self.origin - '0 0 200';
	traceline (self.origin, vec, 1, self);
	if ((trace_fraction == 1))
	{
		dprint ("INFO_JAGOUT: Too high,");
		if ((pointcontents (trace_endpos) == CONTENT_WATER))
		{
			dprint ("no land found beneath");
			dprint ("\n");
		}
		dprint ("JAGGER BEHAVIOR MAY BE UNUSUAL\n");
	}
	self.think = jagout_cardinal;
	self.nextthink = (time + 0.5);
};
void () jagout_cardinal =
{
	local vector vec;
	local vector megadeth;
	local float num;
	self.cnt = (self.cnt + 1);
	vec = VEC_ORIGIN;
	if ((self.cnt == 1))
	{
		vec = self.origin + '100 0 0';
	}
	if ((self.cnt == 2))
	{
		vec = self.origin - '100 0 0';
	}
	if ((self.cnt == 3))
	{
		vec = self.origin + '0 100 0';
	}
	if ((self.cnt == 4))
	{
		vec = self.origin - '0 100 0';
	}
	if ((self.cnt == 5))
	{
		vec = self.origin + '100 100 0';
	}
	if ((self.cnt == 6))
	{
		vec = self.origin - '100 100 0';
	}
	if ((self.cnt == 7))
	{
		vec = self.origin + '100 -100 0';
	}
	if ((self.cnt == 8))
	{
		vec = self.origin + '-100 100 0';
	}
	if ((self.cnt > 8))
	{
		self.think = setup_jagpoint;
		self.nextthink = (time + 0.5);
		return;
	}
	traceline (self.origin, vec, 1, self);
	if ((trace_fraction == 1))
	{
		megadeth = vec - '0 0 500';
		traceline (vec, megadeth, 1, self);
		num = vlen ((vec - trace_endpos));
		if ((pointcontents (trace_endpos) == CONTENT_WATER))
		{
			if ((num > self.frolic))
			{
				self.frolic = num;
				self.xgoal = vec;
			}
		}
	}
	self.think = jagout_cardinal;
	self.nextthink = (time + 0.1);
};
void () setup_jagpoint =
{
	local entity new;
	if ((self.xgoal == '0 0 0'))
	{
		dprint ("INFO_JAGOUT: Location lacks logical route\n");
		self.xtrace = self.origin;
		self.think = SUB_Null;
		self.nextthink = (time + 99999);
		return;
	}
	new = spawn ();
	new.xtrace = self.origin;
	new.origin = self.xgoal;
	new.classname = "jagpoint";
	new.fullbright = 1;
};
//END
