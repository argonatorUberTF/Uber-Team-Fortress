void () juggernaut_pain2;
void () juggernaut_pain1 = [ 90, juggernaut_pain2 ]
{
	ai_pain (TRUE);
};
void () juggernaut_pain3;
void () juggernaut_pain2 = [ 91, juggernaut_pain3 ]
{
	ai_pain (TRUE);
};
void () juggernaut_pain4;
void () juggernaut_pain3 = [ 92, juggernaut_pain4 ]
{
	ai_pain (TRUE);
};
void () juggernaut_pain5;
void () juggernaut_pain4 = [ 93, juggernaut_pain5 ]
{
	ai_painforward (TRUE);
};
void () juggernaut_pain6;
void () juggernaut_pain5 = [ 94, juggernaut_pain6 ]
{
	ai_painforward (TRUE);
};
void () juggernaut_pain6 = [ 95, juggernaut_run1 ]
{
	ai_painforward (TRUE);
};
void (entity attacker, float take) juggernaut_pain =
{
	local float r;
	r = random ();
	if ((r <= 0.3))
	{
		sound (self, FALSE, "monsters/juggers/jshort2.wav", TRUE, TRUE);
	}
	else
	{
		if ((r <= 0.6))
		{
			sound (self, FALSE, "monsters/juggers/jshort3.wav", TRUE, TRUE);
		}
		else
		{
			if ((r <= 0.9))
			{
				sound (self, FALSE, "monsters/juggers/jshort4.wav", TRUE, TRUE);
			}
			else
			{
				sound (self, FALSE, "monsters/juggers/jshort1.wav", TRUE, TRUE);
			}
		}
	}
	if ((random () < 0.2))
	{
		sound (self, MOVETYPE_STEP, "monsters/juggers/jbent.wav", TRUE, TRUE);
	}
	if ((take < ((self.health + take) * 0.2)))
	{
		return;
	}
	self.pain_finished = (time + MOVETYPE_WALK);
	juggernaut_pain1 ();
};
void () juggernaut_death1 = [ 96, juggernaut_death2 ]
{};
void () juggernaut_death3;
void () juggernaut_death2 = [ 97, juggernaut_death3 ]
{
	ai_back (MOVETYPE_STEP);
};
void () juggernaut_death4;
void () juggernaut_death3 = [ 98, juggernaut_death4 ]
{};
void () juggernaut_death5;
void () juggernaut_death4 = [ 99, juggernaut_death5 ]
{
	ai_back (MOVETYPE_STEP);
};
void () juggernaut_death6;
void () juggernaut_death5 = [ 100, juggernaut_death6 ]
{};
void () juggernaut_death7;
void () juggernaut_death6 = [ 101, juggernaut_death7 ]
{
	self.solid = FALSE;
};
void () juggernaut_death8;
void () juggernaut_death7 = [ 102, juggernaut_death8 ]
{};
void () juggernaut_death9;
void () juggernaut_death8 = [ 103, juggernaut_death9 ]
{};
void () juggernaut_death10;
void () juggernaut_death9 = [ 104, juggernaut_death10 ]
{
	self.ammo_shells = 10;
	self.ammo_rockets = 10;
	self.ammo_cells = 10;
	self.ammo_nails = 20;
	DropBackpack ();
};
void () juggernaut_death10 = [ 105, juggernaut_death11 ]
{
	local float r;
	r = random ();
	sound (self, MOVETYPE_WALK, "monsters/juggers/jfalls.wav", TRUE, TRUE);
};
void () juggernaut_death11 = [ 106, juggernaut_death11 ]
{
	if ((coop == FL_SWIM))
	{
		Become_Corpse ();
	}
};
void () juggernaut_die2 =
{
	if ((self.mdl == "progs/jugg.mdl"))
	{
		ThrowHead ("progs/h_jugg.mdl", self.health);
		ThrowGib ("progs/a_jugg.mdl", self.health);
	}
	else
	{
		if ((self.mdl == "progs/jugg2.mdl"))
		{
			ThrowHead ("progs/h_jugg2.mdl", self.health);
			ThrowGib ("progs/a_jugg2.mdl", self.health);
		}
	}
	T_RadiusDamage (self, self, 120, self);
	sound (self, MOVETYPE_WALK, "monsters/juggers/jgib.wav", TRUE, TRUE);
	self.origin = (self.origin + '0 0 24');
	WriteByte (FALSE, SVC_TEMPENTITY);
	WriteByte (FALSE, MOVETYPE_WALK);
	WriteCoord (FALSE, self.origin_x);
	WriteCoord (FALSE, self.origin_y);
	WriteCoord (FALSE, self.origin_z);
};
void () juggernaut_die =
{
	if ((self.health < -50))
	{
		self.think = juggernaut_die2;
		self.nextthink = time;
		return;
	}
	juggernaut_death1 ();
};
void () juggernaut_idlea2;
void () juggernaut_idlea1 = [ 0, juggernaut_idlea2 ]
{
	ai_stand ();
	if ((random () < 0.2))
	{
		sound (self, FALSE, "monsters/juggers/jidle.wav", TRUE, TRUE);
	}
};
void () juggernaut_idlea3;
void () juggernaut_idlea2 = [ 1, juggernaut_idlea3 ]
{
	ai_stand ();
};
void () juggernaut_idlea4;
void () juggernaut_idlea3 = [ 2, juggernaut_idlea4 ]
{
	ai_stand ();
};
void () juggernaut_idlea5;
void () juggernaut_idlea4 = [ 3, juggernaut_idlea5 ]
{
	ai_stand ();
};
void () juggernaut_idlea6;
void () juggernaut_idlea5 = [ 4, juggernaut_idlea6 ]
{
	ai_stand ();
};
void () juggernaut_idlea7;
void () juggernaut_idlea6 = [ 5, juggernaut_idlea7 ]
{
	ai_stand ();
};
void () juggernaut_idlea8;
void () juggernaut_idlea7 = [ 6, juggernaut_idlea8 ]
{
	ai_stand ();
};
void () juggernaut_idlea9;
void () juggernaut_idlea8 = [ 7, juggernaut_idlea9 ]
{
	ai_stand ();
};
void () juggernaut_idlea10;
void () juggernaut_idlea9 = [ 8, juggernaut_idlea10 ]
{
	ai_stand ();
};
void () juggernaut_idlea11;
void () juggernaut_idlea10 = [ 9, juggernaut_idlea11 ]
{
	ai_stand ();
};
void () juggernaut_idlea12;
void () juggernaut_idlea11 = [ 10, juggernaut_idlea12 ]
{
	ai_stand ();
};
void () juggernaut_idlea13;
void () juggernaut_idlea12 = [ 11, juggernaut_idlea13 ]
{
	ai_stand ();
};
void () juggernaut_idlea14;
void () juggernaut_idlea13 = [ 12, juggernaut_idlea14 ]
{
	ai_stand ();
};
void () juggernaut_idlea15;
void () juggernaut_idlea14 = [ 13, juggernaut_idlea15 ]
{
	ai_stand ();
};
void () juggernaut_idlea16;
void () juggernaut_idlea15 = [ 14, juggernaut_idlea16 ]
{
	ai_stand ();
};
void () juggernaut_idlea16 = [ 15, juggernaut_idlea1 ]
{
	ai_stand ();
};
void () ai_jugg_wait =
{
	ai_face ();
	if ((enemy_range > TRUE))
	{
		self.th_run ();
		return;
	}
	if (!IsAlive (self.enemy))
	{
		self.th_run ();
		return;
	}
	self.show_hostile = (time + TRUE);
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
	if (CheckAnyAttack ())
	{
		return;
	}
	BurnMonster ();
};
void () juggernaut_wait2;
void () juggernaut_wait1 = [ 0, juggernaut_wait2 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait3;
void () juggernaut_wait2 = [ 1, juggernaut_wait3 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait4;
void () juggernaut_wait3 = [ 2, juggernaut_wait4 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait5;
void () juggernaut_wait4 = [ 3, juggernaut_wait5 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait6;
void () juggernaut_wait5 = [ 4, juggernaut_wait6 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait7;
void () juggernaut_wait6 = [ 5, juggernaut_wait7 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait8;
void () juggernaut_wait7 = [ 6, juggernaut_wait8 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait9;
void () juggernaut_wait8 = [ 7, juggernaut_wait9 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait10;
void () juggernaut_wait9 = [ 8, juggernaut_wait10 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait11;
void () juggernaut_wait10 = [ 9, juggernaut_wait11 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait12;
void () juggernaut_wait11 = [ 10, juggernaut_wait12 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait13;
void () juggernaut_wait12 = [ 11, juggernaut_wait13 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait14;
void () juggernaut_wait13 = [ 12, juggernaut_wait14 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait15;
void () juggernaut_wait14 = [ 13, juggernaut_wait15 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait16;
void () juggernaut_wait15 = [ 14, juggernaut_wait16 ]
{
	ai_jugg_wait ();
};
void () juggernaut_wait16 = [ 15, juggernaut_wait1 ]
{
	ai_jugg_wait ();
};
void () juggernaut_idleb2;
void () juggernaut_idleb1 = [ 16, juggernaut_idleb2 ]
{
	ai_stand ();
	if ((random () < 0.2))
	{
		sound (self, FALSE, "monsters/juggers/jidle.wav", TRUE, TRUE);
	}
};
void () juggernaut_idleb3;
void () juggernaut_idleb2 = [ 17, juggernaut_idleb3 ]
{
	ai_stand ();
};
void () juggernaut_idleb4;
void () juggernaut_idleb3 = [ 18, juggernaut_idleb4 ]
{
	ai_stand ();
};
void () juggernaut_idleb5;
void () juggernaut_idleb4 = [ 19, juggernaut_idleb5 ]
{
	ai_stand ();
};
void () juggernaut_idleb6;
void () juggernaut_idleb5 = [ 20, juggernaut_idleb6 ]
{
	ai_stand ();
};
void () juggernaut_idleb7;
void () juggernaut_idleb6 = [ 21, juggernaut_idleb7 ]
{
	ai_stand ();
};
void () juggernaut_idleb8;
void () juggernaut_idleb7 = [ 22, juggernaut_idleb8 ]
{
	ai_stand ();
};
void () juggernaut_idleb9;
void () juggernaut_idleb8 = [ 23, juggernaut_idleb9 ]
{
	ai_stand ();
};
void () juggernaut_idleb10;
void () juggernaut_idleb9 = [ 24, juggernaut_idleb10 ]
{
	ai_stand ();
};
void () juggernaut_idleb11;
void () juggernaut_idleb10 = [ 25, juggernaut_idleb11 ]
{
	ai_stand ();
};
void () juggernaut_idleb12;
void () juggernaut_idleb11 = [ 26, juggernaut_idleb12 ]
{
	ai_stand ();
};
void () juggernaut_idleb13;
void () juggernaut_idleb12 = [ 27, juggernaut_idleb13 ]
{
	ai_stand ();
};
void () juggernaut_idleb14;
void () juggernaut_idleb13 = [ 28, juggernaut_idleb14 ]
{
	ai_stand ();
};
void () juggernaut_idleb15;
void () juggernaut_idleb14 = [ 29, juggernaut_idleb15 ]
{
	ai_stand ();
};
void () juggernaut_idleb16;
void () juggernaut_idleb15 = [ 30, juggernaut_idleb16 ]
{
	ai_stand ();
};
void () juggernaut_idleb16 = [ 31, juggernaut_idleb1 ]
{
	ai_stand ();
};
void () juggernaut_idle =
{
	if ((random () < 0.5))
	{
		juggernaut_idlea1 ();
	}
	else
	{
		juggernaut_idleb1 ();
	}
};
void () juggernaut_walk2;
void () juggernaut_walk1 = [ 32, juggernaut_walk2 ]
{
	ai_walk (FL_CLIENT);
	sound (self, MOVETYPE_WALK, "monsters/juggers/jstep1.wav", 0.5, TRUE);
	if ((random () <= 0.4))
	{
		sound (self, FALSE, "monsters/juggers/jwhir.wav", TRUE, TRUE);
	}
	if ((random () <= 0.3))
	{
		sound (self, FALSE, "monsters/juggers/jidle.wav", TRUE, TRUE);
	}
};
void () juggernaut_walk3;
void () juggernaut_walk2 = [ 33, juggernaut_walk3 ]
{
	ai_walk (FALSE);
};
void () juggernaut_walk4;
void () juggernaut_walk3 = [ 34, juggernaut_walk4 ]
{
	ai_walk (FALSE);
};
void () juggernaut_walk5;
void () juggernaut_walk4 = [ 35, juggernaut_walk5 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () juggernaut_walk6;
void () juggernaut_walk5 = [ 36, juggernaut_walk6 ]
{
	ai_walk (FL_CLIENT);
};
void () juggernaut_walk7;
void () juggernaut_walk6 = [ 37, juggernaut_walk7 ]
{
	ai_walk (MOVETYPE_STEP);
	sound (self, MOVETYPE_WALK, "monsters/juggers/jstep2.wav", 0.25, TRUE);
	if (((random () <= 0.2) && (self.health < (self.max_health * 0.4))))
	{
		if ((random () <= 0.2))
		{
			sound (self, FALSE, "monsters/juggers/jshort3.wav", TRUE, TRUE);
		}
		else
		{
			sound (self, FALSE, "monsters/juggers/jshort2.wav", TRUE, TRUE);
		}
	}
};
void () juggernaut_walk8;
void () juggernaut_walk7 = [ 38, juggernaut_walk8 ]
{
	ai_walk (FALSE);
};
void () juggernaut_walk9;
void () juggernaut_walk8 = [ 39, juggernaut_walk9 ]
{
	ai_walk (FALSE);
};
void () juggernaut_walk10;
void () juggernaut_walk9 = [ 40, juggernaut_walk10 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () juggernaut_walk10 = [ 41, juggernaut_walk1 ]
{
	ai_walk (FL_CLIENT);
};
void () juggernaut_run2;
void () juggernaut_run1 = [ 32, juggernaut_run2 ]
{
	ai_run (FALSE);
	if ((random () <= 0.5))
	{
		sound (self, MOVETYPE_WALK, "monsters/juggers/jstep3.wav", 0.5, TRUE);
	}
	else
	{
		sound (self, MOVETYPE_WALK, "monsters/juggers/jstep2.wav", 0.5, TRUE);
	}
};
void () juggernaut_run3;
void () juggernaut_run2 = [ 33, juggernaut_run3 ]
{
	ai_run (FALSE);
};
void () juggernaut_run4;
void () juggernaut_run3 = [ 34, juggernaut_run4 ]
{
	ai_run (FL_CLIENT);
};
void () juggernaut_run5;
void () juggernaut_run4 = [ 35, juggernaut_run5 ]
{
	ai_run (FL_INWATER);
};
void () juggernaut_run6;
void () juggernaut_run5 = [ 36, juggernaut_run6 ]
{
	ai_run (FL_CLIENT);
};
void () juggernaut_run7;
void () juggernaut_run6 = [ 37, juggernaut_run7 ]
{
	ai_run (FALSE);
	sound (self, MOVETYPE_WALK, "monsters/juggers/jstep1.wav", 0.25, TRUE);
	if (((random () <= 0.2) && (self.health < (self.max_health * 0.4))))
	{
		sound (self, FALSE, "monsters/juggers/jshort4.wav", TRUE, TRUE);
	}
};
void () juggernaut_run8;
void () juggernaut_run7 = [ 38, juggernaut_run8 ]
{
	ai_run (MOVETYPE_STEP);
};
void () juggernaut_run9;
void () juggernaut_run8 = [ 39, juggernaut_run9 ]
{
	ai_run (FALSE);
};
void () juggernaut_run10;
void () juggernaut_run9 = [ 40, juggernaut_run10 ]
{
	ai_run (FL_CLIENT);
};
void () juggernaut_run10 = [ 41, juggernaut_run1 ]
{
	ai_run (FL_INWATER);
};
void () juggernaut_rocket_touch =
{
	local float damg;
	if ((pointcontents (self.origin) == CONTENT_SKY))
	{
		remove (self);
		return;
	}
	damg = 50 + (random () * MOVETYPE_BOUNCE);
	if (other.health)
	{
		if ((other.classname == "monster_shambler"))
		{
			damg = damg * 0.5;
		}
		T_Damage (other, self, self.owner, damg);
	}
	T_RadiusDamage (self, self.owner, 60, other);
	self.origin = (self.origin - (FL_CLIENT * normalize (self.velocity)));
	WriteByte (FALSE, SVC_TEMPENTITY);
	WriteByte (FALSE, MOVETYPE_WALK);
	WriteCoord (FALSE, self.origin_x);
	WriteCoord (FALSE, self.origin_y);
	WriteCoord (FALSE, self.origin_z);
	BecomeExplosion ();
};
void () juggernaut_firea6;
void () JuggHome =
{
	local vector dir;
	local vector vtemp;
	self.angles = vectoangles (self.velocity);
	if (!IsAlive (self.enemy))
	{
		self.enemy = self.owner.enemy;
	}
	vtemp = self.enemy.origin + '0 0 10';
	dir = normalize ((vtemp - self.origin));
	self.velocity = (normalize ((self.velocity + (dir * 250))) * 500);
	self.nextthink = (time + 0.2);
	self.think = JuggHome;
};
void () juggernaut_launch_rocket =
{
	local entity missile;
	local vector org;
	local vector vec;
	local vector up;
	local vector right;
	local vector forward;
	local float ammo;
	ai_face ();
	sound (self, TRUE, "weapons/sgun1.wav", TRUE, TRUE);
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = FL_SWIM;
	missile.classname = "juggy_rocket";
	makevectors (self.angles);
	ammo = self.ammo_rockets;
	forward = v_forward * SVC_INTERMISSION;
	if (((ammo / MOVETYPE_WALK) == floor ((ammo / MOVETYPE_WALK))))
	{
		right = v_right * 35;
	}
	else
	{
		if ((((ammo + TRUE) / MOVETYPE_WALK) == floor (((ammo + TRUE) / MOVETYPE_WALK))))
		{
			right = v_right * SVC_FINALE;
		}
		else
		{
			right = v_right * SVC_KILLEDMONSTER;
		}
	}
	if (((ceil ((ammo / MOVETYPE_WALK)) / FL_SWIM) == floor ((ceil ((ammo / MOVETYPE_WALK)) / FL_SWIM))))
	{
		up = '0 0 40';
	}
	else
	{
		up = '0 0 32';
	}
	org = ((self.origin + forward * 2) + right) + up;		// xav: STUPID BUGS!!! had to add the "* 2" to stop jugg from hitting itself.
	vec = (self.enemy.origin + '0 0 16') - (((self.origin + forward) + (v_right * SVC_FINALE)) + '0 0 36');
	vec = normalize (vec);
	missile.velocity = (vec * 500);
	missile.angles = vectoangles (missile.velocity);
	missile.touch = juggernaut_rocket_touch;
	missile.nextthink = (time + 0.1);
	missile.think = JuggHome;
	missile.enemy = self.enemy;
	setmodel (missile, "progs/missile.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, org);
	missile.effects = FL_SWIM;
	self.ammo_rockets = (self.ammo_rockets - TRUE);
	self.count = (self.count + TRUE);
	if (((self.count < floor (((random () * (skill + TRUE)) * 1.5))) && (self.ammo_rockets > FALSE)))
	{
		juggernaut_firea6 ();
	}
};
void () juggernaut_laser_touch =
{
	if ((other.solid == TRUE))
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
		spawn_touchblood (15);
		T_Damage (other, self, self.owner, 15);
	}
	sound (self, MOVETYPE_STEP, "enforcer/enfstop.wav", TRUE, MOVETYPE_WALK);
	remove (self);
};
void () juggernaut_fire_chain =
{
	local vector dir;
	local vector org;
	ai_face ();
	if ((self.ammo_cells < TRUE))
	{
		sound (self, TRUE, "monsters/juggers/jwhir.wav", TRUE, TRUE);
		return;
	}
	if ((random () <= 0.2))
	{
		sound (self, FALSE, "monsters/juggers/jwhir.wav", TRUE, TRUE);
	}
	sound (self, TRUE, "monsters/juggers/jshot.wav", TRUE, TRUE);
	makevectors (self.angles);
	org = ((self.origin + (v_forward * MOVETYPE_BOUNCE)) - (v_right * 20)) + '0 0 44';
	dir = (self.enemy.origin + '0 0 16') - (self.enemy.velocity * 0.2);
	dir = normalize ((dir - org));
	launch_spike (org, dir);
	setmodel (newmis, "progs/laser.mdl");
	newmis.touch = juggernaut_laser_touch;
	newmis.effects = FL_SWIM;
	self.ammo_cells = (self.ammo_cells - TRUE);
};
void () juggernaut_firea2;
void () juggernaut_firea1 = [ 42, juggernaut_firea2 ]
{
	ai_face ();
	BurnMonster ();
	self.count = FALSE;
};
void () juggernaut_firea3;
void () juggernaut_firea2 = [ 43, juggernaut_firea3 ]
{
	ai_face ();
};
void () juggernaut_firea4;
void () juggernaut_firea3 = [ 44, juggernaut_firea4 ]
{
	ai_face ();
};
void () juggernaut_firea5;
void () juggernaut_firea4 = [ 45, juggernaut_firea5 ]
{
	ai_face ();
	sound (self, FL_SWIM, "monsters/juggers/jlocked.wav", TRUE, TRUE);
};
void () juggernaut_firea5 = [ 46, juggernaut_firea6 ]
{
	ai_face ();
};
void () juggernaut_firea7;
void () juggernaut_firea6 = [ 47, juggernaut_firea7 ]
{
	ai_face ();
	BurnMonster ();
};
void () juggernaut_firea8;
void () juggernaut_firea7 = [ 48, juggernaut_firea8 ]
{
	ai_face ();
};
void () juggernaut_firea9;
void () juggernaut_firea8 = [ 49, juggernaut_firea9 ]
{
	ai_face ();
	juggernaut_launch_rocket ();
};
void () juggernaut_firea10;
void () juggernaut_firea9 = [ 50, juggernaut_firea10 ]
{
	ai_face ();
};
void () juggernaut_firea11;
void () juggernaut_firea10 = [ 51, juggernaut_firea11 ]
{
	ai_face ();
};
void () juggernaut_firea12;
void () juggernaut_firea11 = [ 52, juggernaut_firea12 ]
{
	ai_face ();
};
void () juggernaut_firea13;
void () juggernaut_firea12 = [ 52, juggernaut_firea13 ]
{
	ai_face ();
};
void () juggernaut_firea14;
void () juggernaut_firea13 = [ 52, juggernaut_firea14 ]
{
	ai_face ();
};
void () juggernaut_firea14 = [ 53, juggernaut_run1 ]
{
	ai_face ();
	BurnMonster ();
};
void () juggernaut_fireb2;
void () juggernaut_fireb1 = [ 56, juggernaut_fireb2 ]
{
	ai_face ();
};
void () juggernaut_fireb3;
void () juggernaut_fireb2 = [ 57, juggernaut_fireb3 ]
{
	juggernaut_fire_chain ();
};
void () juggernaut_fireb4;
void () juggernaut_fireb3 = [ 58, juggernaut_fireb4 ]
{
	ai_face ();
};
void () juggernaut_fireb4 = [ 59, juggernaut_fireb1 ]
{
	local vector spot1;
	local vector spot2;
	local entity targ;
	juggernaut_fire_chain ();
	targ = self.enemy;
	spot1 = self.origin + self.view_ofs;
	spot2 = targ.origin + targ.view_ofs;
	traceline (spot1, spot2, FALSE, self);
	if ((((trace_ent != targ) || (trace_inopen && trace_inwater)) || (random () < 0.3)))
	{
		juggernaut_run1 ();
		return;
	}
};
void () juggernaut_walkfire2;
void () juggernaut_walkfire1 = [ 60, juggernaut_walkfire2 ]
{
	ai_walk (FALSE);
	if ((random () <= 0.5))
	{
		sound (self, MOVETYPE_WALK, "monsters/juggers/jstep1.wav", 0.25, TRUE);
	}
	else
	{
		sound (self, MOVETYPE_WALK, "monsters/juggers/jstep2.wav", 0.25, TRUE);
	}
};
void () juggernaut_walkfire3;
void () juggernaut_walkfire2 = [ 61, juggernaut_walkfire3 ]
{
	ai_walk (FALSE);
	juggernaut_fire_chain ();
};
void () juggernaut_walkfire4;
void () juggernaut_walkfire3 = [ 62, juggernaut_walkfire4 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () juggernaut_walkfire5;
void () juggernaut_walkfire4 = [ 63, juggernaut_walkfire5 ]
{
	ai_walk (FL_CLIENT);
	juggernaut_fire_chain ();
};
void () juggernaut_walkfire6;
void () juggernaut_walkfire5 = [ 64, juggernaut_walkfire6 ]
{
	ai_walk (MOVETYPE_STEP);
};
void () juggernaut_walkfire7;
void () juggernaut_walkfire6 = [ 65, juggernaut_walkfire7 ]
{
	ai_walk (FALSE);
	juggernaut_fire_chain ();
	if ((random () <= 0.5))
	{
		sound (self, MOVETYPE_WALK, "monsters/juggers/jstep3.wav", 0.25, TRUE);
	}
	else
	{
		sound (self, MOVETYPE_WALK, "monsters/juggers/jstep1.wav", 0.25, TRUE);
	}
};
void () juggernaut_walkfire8;
void () juggernaut_walkfire7 = [ 66, juggernaut_walkfire8 ]
{
	ai_walk (FALSE);
};
void () juggernaut_walkfire9;
void () juggernaut_walkfire8 = [ 67, juggernaut_walkfire9 ]
{
	ai_walk (MOVETYPE_STEP);
	juggernaut_fire_chain ();
};
void () juggernaut_walkfire10;
void () juggernaut_walkfire9 = [ 68, juggernaut_walkfire10 ]
{
	ai_walk (FL_CLIENT);
};
void () juggernaut_walkfire10 = [ 69, juggernaut_walkfire1 ]
{
	local vector spot1;
	local vector spot2;
	local entity targ;
	ai_walk (MOVETYPE_STEP);
	juggernaut_fire_chain ();
	targ = self.enemy;
	spot1 = self.origin + self.view_ofs;
	spot2 = targ.origin + targ.view_ofs;
	traceline (spot1, spot2, FALSE, self);
	if ((((trace_ent != targ) || (trace_inopen && trace_inwater)) || (random () < 0.5)))
	{
		juggernaut_run1 ();
		return;
	}
};
void () juggernaut_fire =
{
	if ((random () < 0.2))
	{
		if (((random () < 0.65) && (self.ammo_rockets > FALSE)))
		{
			if ((self.health < (self.max_health / FL_SWIM)))
			{
				sound (self, MOVETYPE_STEP, "monsters/juggers/jhydro2.wav", TRUE, TRUE);
			}
			else
			{
				sound (self, MOVETYPE_STEP, "monsters/juggers/jhydro3.wav", TRUE, TRUE);
			}
			juggernaut_firea1 ();
		}
		else
		{
			if ((self.ammo_cells > FALSE))
			{
				sound (self, MOVETYPE_STEP, "monsters/juggers/jhydro1.wav", TRUE, TRUE);
				if ((self.frame == FL_MONSTER))
				{
					juggernaut_walkfire1 ();
				}
				else
				{
					if ((self.frame == SVC_SELLSCREEN))
					{
						juggernaut_walkfire2 ();
					}
					else
					{
						if ((self.frame == 34))
						{
							juggernaut_walkfire3 ();
						}
						else
						{
							if ((self.frame == 35))
							{
								juggernaut_walkfire4 ();
							}
							else
							{
								if ((self.frame == 36))
								{
									juggernaut_walkfire5 ();
								}
								else
								{
									if ((self.frame == 37))
									{
										juggernaut_walkfire6 ();
									}
									else
									{
										if ((self.frame == 38))
										{
											juggernaut_walkfire7 ();
										}
										else
										{
											if ((self.frame == 39))
											{
												juggernaut_walkfire8 ();
											}
											else
											{
												if ((self.frame == 40))
												{
													juggernaut_walkfire9 ();
												}
												else
												{
													if ((self.frame == 41))
													{
														juggernaut_walkfire10 ();
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
};
void () juggernaut_ai_melee =
{
	local vector delta;
	local float ldmg;
	local float r;
	r = random ();
	if (!self.enemy)
	{
		return;
	}
	delta = self.enemy.origin - self.origin;
	if ((vlen (delta) <= 80))
	{
		ldmg = ((random () + random ()) + random ()) * 15;
		T_Damage (self.enemy, self, self, ldmg);
		if ((r <= 0.3))
		{
			sound (self, TRUE, "monsters/juggers/jwhap1.wav", TRUE, TRUE);
		}
		else
		{
			if ((r <= 0.6))
			{
				sound (self, TRUE, "monsters/juggers/jwhap2.wav", TRUE, TRUE);
			}
			else
			{
				sound (self, TRUE, "monsters/juggers/jwhap3.wav", TRUE, TRUE);
			}
		}
	}
	else
	{
		if ((r <= 0.3))
		{
			sound (self, TRUE, "monsters/juggers/jswipe1.wav", TRUE, TRUE);
		}
		else
		{
			if ((r <= 0.6))
			{
				sound (self, TRUE, "monsters/juggers/jswipe2.wav", TRUE, TRUE);
			}
			else
			{
				sound (self, TRUE, "monsters/juggers/jswipe3.wav", TRUE, TRUE);
			}
		}
	}
};
void () juggernaut_melee2;
void () juggernaut_melee1 = [ 70, juggernaut_melee2 ]
{
	ai_charge (FALSE);
	BurnMonster ();
};
void () juggernaut_melee3;
void () juggernaut_melee2 = [ 71, juggernaut_melee3 ]
{
	ai_charge (FALSE);
	BurnMonster ();
};
void () juggernaut_melee4;
void () juggernaut_melee3 = [ 72, juggernaut_melee4 ]
{
	ai_charge (FALSE);
	BurnMonster ();
};
void () juggernaut_melee5;
void () juggernaut_melee4 = [ 73, juggernaut_melee5 ]
{
	ai_charge (FALSE);
	BurnMonster ();
};
void () juggernaut_melee6;
void () juggernaut_melee5 = [ 74, juggernaut_melee6 ]
{
	ai_charge (FALSE);
	BurnMonster ();
};
void () juggernaut_melee7;
void () juggernaut_melee6 = [ 75, juggernaut_melee7 ]
{
	ai_charge (MOVETYPE_STEP);
};
void () juggernaut_melee8;
void () juggernaut_melee7 = [ 76, juggernaut_melee8 ]
{
	ai_charge (FL_CLIENT);
};
void () juggernaut_melee9;
void () juggernaut_melee8 = [ 77, juggernaut_melee9 ]
{
	ai_charge (FL_CLIENT);
	juggernaut_ai_melee ();
};
void () juggernaut_melee10;
void () juggernaut_melee9 = [ 78, juggernaut_melee10 ]
{
	ai_charge (MOVETYPE_STEP);
	juggernaut_ai_melee ();
};
void () juggernaut_melee11;
void () juggernaut_melee10 = [ 79, juggernaut_melee11 ]
{
	ai_charge (MOVETYPE_STEP);
};
void () juggernaut_melee12;
void () juggernaut_melee11 = [ 80, juggernaut_melee12 ]
{
	ai_charge (FALSE);
};
void () juggernaut_melee12 = [ 81, juggernaut_run1 ]
{
	ai_charge (FALSE);
};
void () juggernaut_meleeb2;
void () juggernaut_meleeb1 = [ 82, juggernaut_meleeb2 ]
{
	ai_charge (FALSE);
};
void () juggernaut_meleeb3;
void () juggernaut_meleeb2 = [ 83, juggernaut_meleeb3 ]
{
	ai_charge (FALSE);
};
void () juggernaut_meleeb4;
void () juggernaut_meleeb3 = [ 84, juggernaut_meleeb4 ]
{
	ai_charge (FALSE);
};
void () juggernaut_meleeb5;
void () juggernaut_meleeb4 = [ 85, juggernaut_meleeb5 ]
{
	ai_charge (FALSE);
};
void () juggernaut_meleeb6;
void () juggernaut_meleeb5 = [ 86, juggernaut_meleeb6 ]
{
	ai_charge (FALSE);
};
void () juggernaut_meleeb7;
void () juggernaut_meleeb6 = [ 87, juggernaut_meleeb7 ]
{
	ai_charge (FALSE);
	juggernaut_ai_melee ();
	juggernaut_ai_melee ();
};
void () juggernaut_meleeb8;
void () juggernaut_meleeb7 = [ 88, juggernaut_meleeb8 ]
{
	ai_charge (FALSE);
};
void () juggernaut_meleeb8 = [ 89, juggernaut_run1 ]
{
	ai_charge (FALSE);
};
void () juggernaut_melee =
{
	local float len;
	len = vlen (((self.enemy.origin + self.enemy.view_ofs) - (self.origin + self.view_ofs)));
	if ((len < 80))
	{
		juggernaut_meleeb1 ();
	}
	else
	{
		juggernaut_melee1 ();
	}
};
void () monster_juggernaut1 =
{
	self.solid = MOVETYPE_WALK;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/jugg2.mdl"/*self.mdl*/);
	setsize (self, VEC_HULL2_MIN, '32 32 68');
	self.max_health = MTF_Monster_Health(1500/*2000*/);
	self.health = self.max_health;
	self.th_stand = juggernaut_idle;
	self.th_walk = juggernaut_walk1;
	self.th_run = juggernaut_run1;
	self.th_die = juggernaut_die;
	self.th_melee = juggernaut_melee;
	self.th_missile = juggernaut_fire;
	self.th_pain = juggernaut_pain;
	self.th_jugg = juggernaut_wait1;
	self.ammo_rockets = 18;
	self.ammo_cells = SVC_INTERMISSION;
	coop_walkmonster_start ();
};
void () monster_juggernaut =
{
	local float r;
	r = random ();
	if (deathmatch)
	{
		remove (self);
		return;
	}
	self.mdl = "progs/jugg2.mdl";
	precache_model ("progs/a_jugg2.mdl");
	precache_model ("progs/h_jugg2.mdl");
	precache_model ("progs/jugg2.mdl");
	precache_model ("progs/laser.mdl");
	precache_sound ("enforcer/enfstop.wav");
	precache_sound ("monsters/juggers/jbent.wav");
	precache_sound ("monsters/juggers/jlocked.wav");
	precache_sound ("monsters/juggers/jshot.wav");
	precache_sound ("monsters/juggers/jhydro1.wav");
	precache_sound ("monsters/juggers/jhydro2.wav");
	precache_sound ("monsters/juggers/jhydro3.wav");
	precache_sound ("monsters/juggers/jidle.wav");
	precache_sound ("monsters/juggers/jstep1.wav");
	precache_sound ("monsters/juggers/jstep2.wav");
	precache_sound ("monsters/juggers/jstep3.wav");
	precache_sound ("monsters/juggers/jshort1.wav");
	precache_sound ("monsters/juggers/jshort2.wav");
	precache_sound ("monsters/juggers/jshort3.wav");
	precache_sound ("monsters/juggers/jshort4.wav");
	precache_sound ("monsters/juggers/jwhap1.wav");
	precache_sound ("monsters/juggers/jwhap2.wav");
	precache_sound ("monsters/juggers/jwhap3.wav");
	precache_sound ("monsters/juggers/jwhir.wav");
	precache_sound ("monsters/juggers/jfalls.wav");
	precache_sound ("monsters/juggers/jswipe1.wav");
	precache_sound ("monsters/juggers/jswipe2.wav");
	precache_sound ("monsters/juggers/jswipe3.wav");
	precache_sound ("monsters/juggers/jgib.wav");
	self.netname = "juggernaut";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_juggernaut1;
	COOP_SetLives ();
	monster_juggernaut1 ();
};
//END
