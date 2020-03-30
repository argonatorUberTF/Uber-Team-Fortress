void (float offset) ubs_shot1;
void () spawnwiz;
void () ubs_shot2;
void () ubs_dodge;
void () ubs_side;
void () ubs_run;
void () ubs_countscraglets =
{
	local entity head;
	self.ident = FALSE;
	head = findradius (self.origin, 2000);
	while (head)
	{
		if ((head.classname == "monster_wizard"))
		{
			self.ident = (self.ident + TRUE);
		}
		head = head.chain;
	}
};
float inside;

void () ubscheckdist =
{
	local vector dist;
	local float d;
	local float cond;
	local entity head;
	if (inside)
	{
		return;
	}
	inside = TRUE;
	dist = self.enemy.origin - self.origin;
	dist_z = FALSE;
	d = vlen (dist);
	if ((d < 450))
	{
		if (visible (self.enemy))
		{
			ai_run ((((TRUE / d) * 5000) * CONTENT_EMPTY));
		}
	}
	cond = FALSE;
	if (((d < 450) && (d > FALSE)))
	{
		if (!visible (self.enemy))
		{
			cond = TRUE;
		}
	}
	if (cond)
	{
		ai_run (FL_INWATER);
	}
	else
	{
		if (((d > 450) && (d <= 600)))
		{
			ai_run (MOVETYPE_STEP);
		}
		else
		{
			if ((d >= 600))
			{
				ai_run ((20 * (d / 500)));
			}
		}
	}
	head = findradius (self.origin, 500);
	while (head)
	{
		if ((head.classname == "missile"))
		{
			ubs_dodge ();
		}
		head = head.chain;
	}
	ubs_countscraglets ();
	inside = FALSE;
};
void () ubshome;
void () ubshome2;

void () ubs_shot2 =
{
	local vector offang;
	local vector org;
	local vector vec;
	offang = vectoangles ((self.enemy.origin - self.origin));
	makevectors (offang);
	org = self.origin + (v_forward * FL_GODMODE);
	vec = normalize (v_forward);
	launch_spike (org, vec);
	newmis.classname = "spawnspike";
	setmodel (newmis, "progs/utele.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	newmis.avelocity = '700 40 40';
	newmis.velocity = (vec * 300);
	sound (self, TRUE, "ubs/spawnfr.wav", TRUE, TRUE);
	newmis.enemy = self.owner.enemy;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.think = ubshome2;
	newmis.nextthink = (time + 0.2);
};

void (float setting) ubs_spread =
{
	local vector offang;
	local vector org;
	local vector vec;
	offang = vectoangles ((self.enemy.origin - self.origin));
	if ((setting != TRUE))
	{
		offang_x = offang_x + ((random () * -50) + 25);
		offang_y = offang_y + ((random () * -50) + 25);
		offang_z = offang_z + ((random () * -50) + 25);
	}
	makevectors (offang);
	org = ((self.origin + self.mins) + (self.size * 0.5)) + (v_forward * 20);
	vec = normalize (v_forward);
	vec_z = (FALSE - vec_z) + ((random () - 0.5) * 0.1);
	launch_spike (org, vec);
	newmis.classname = "wizspike";
	setmodel (newmis, "progs/w_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	newmis.velocity = (vec * 500);
	sound (self, TRUE, "ubs/attack1.wav", TRUE, TRUE);
	newmis.think = ubshome;
	newmis.nextthink = (time + 0.4);
	newmis.enemy = self.enemy;
};

void (float dist, float damage) ubs_zap =
{
	local vector org;
	local vector dir;
	self.effects = (self.effects | FL_SWIM);
	ai_face ();
	org = self.origin + '0 0 40';
	dir = (self.enemy.origin + '0 0 16') - org;
	dir = normalize (dir);
	traceline (org, (self.origin + (dir * dist)), FALSE, self);
	WriteByte (FALSE, SVC_TEMPENTITY);
	WriteByte (FALSE, TE_LIGHTNING1/*MOVETYPE_FLY*/);
	WriteEntity (FALSE, self);
	WriteCoord (FALSE, org_x);
	WriteCoord (FALSE, org_y);
	WriteCoord (FALSE, org_z);
	WriteCoord (FALSE, trace_endpos_x);
	WriteCoord (FALSE, trace_endpos_y);
	WriteCoord (FALSE, trace_endpos_z);
	if ((trace_ent.classname == "monster_zombie"))
	{
		damage = 70;
	}
	if ((trace_ent.health <= damage))
	{
		damage = 60;
	}
	if (trace_ent.takedamage)
	{
		T_Damage (trace_ent, self, self, damage);
	}
};

void () ubs_shot1_touch =
{
	self.think = SUB_Null;
	if ((other == self.owner))
	{
		ubshome ();
	}
	T_Damage (other, self, self.owner, 15);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	multicast (self.origin, MULTICAST_PHS);
	BecomeExplosion ();
};

void () ubs_shot1_touch2 =
{
	self.think = SUB_Null;
	if ((other == self.owner))
	{
		self.think = ubshome2;
	}
	self.owner.ident = (self.owner.ident + TRUE);
	self.nextthink = (time + 0.1);
	spawnwiz ();
	BecomeExplosion ();
};

void () ubshome =
{
	local vector dir;
	local vector vtemp;
	local vector dist;
	local float d;
	self.angles = vectoangles (self.velocity);
	dist = self.enemy.origin - self.origin;
	dist_z = FALSE;
	d = vlen (dist);
	traceline (self.origin, self.enemy.origin, TRUE, self);
	if ((trace_fraction == TRUE))
	{
		if (!IsAlive (self.enemy))
		{
			self.think = SUB_Null;
		}
		vtemp = self.enemy.origin + '0 0 10';
		dir = normalize ((vtemp - self.origin));
		if ((skill == MOVETYPE_WALK))
		{
			self.velocity = (dir * 430);
		}
		if ((self.classname == "wizspike"))
		{
			self.velocity = (dir * 400);
		}
		else
		{
			self.velocity = (dir * 300);
		}
		self.nextthink = (time + 0.1);
		self.think = ubshome;
		self.enemy = self.owner.enemy;
		if (((self.temp6 == 15) && (self.classname != "wizspike")))
		{
			self.think = SUB_Null;
			self.nextthink = (time + 0.1);
		}
		if ((self.classname != "wizspike"))
		{
			self.temp6 = (self.temp6 + TRUE);
		}
	}
	if ((self.classname == "wizspike"))
	{
		self.angles = vectoangles (self.velocity);
		if ((self.temp6 == STAT_TOTALMONSTERS))
		{
			self.think = SUB_Null;
		}
		self.temp6 = (self.temp6 + TRUE);
	}
};

void () ubshome2 =
{
	local vector dir;
	local vector vtemp;
	local vector dist;
	local float d;
	dist = self.enemy.origin - self.origin;
	d = vlen (dist);
	traceline (self.origin, self.enemy.origin, TRUE, self);
	if ((trace_fraction == TRUE))
	{
		if (!IsAlive (self.enemy))
		{
			self.think = SUB_Null;
		}
		vtemp = self.enemy.origin + '0 0 20';
		dir = normalize ((vtemp - self.origin));
		self.velocity = (dir * 300);
		self.enemy = self.owner.enemy;
	}
	if ((d >= FL_ITEM))
	{
		self.think = ubshome2;
	}
	if ((d < FL_ITEM))
	{
		self.think = spawnwiz;
	}
	self.nextthink = (time + 0.1);
	if ((self.skin == FALSE))
	{
		self.skin = TRUE;
	}
	else
	{
		if ((self.skin == TRUE))
		{
			self.skin = FALSE;
		}
	}
};

void (float offset) ubs_shot1 =
{
	local entity missile;
	local vector dir;
	local float dist;
	local float flytime;
	dir = normalize (((self.enemy.origin + '0 0 10') - self.origin));
	dist = vlen ((self.enemy.origin - self.origin));
	flytime = dist * 0.002;
	if ((flytime < 0.1))
	{
		flytime = 0.1;
	}
	self.effects = (self.effects | FL_SWIM);
	sound (self, TRUE, "shalrath/attack2.wav", TRUE, TRUE);
	missile = spawn ();
	missile.owner = self;
	missile.solid = FL_SWIM;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/v_spike.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	missile.origin = (self.origin + '0 0 10');
	missile.velocity = (dir * 400);
	missile.avelocity = '800 200 200';
	missile.touch = ubs_shot1_touch;
	missile.think = ubshome;
	missile.nextthink = (time + 0.6);
	missile.enemy = self.enemy;
	missile.movetype = MOVETYPE_FLYMISSILE;
};

void (entity missile, float mspeed, float accuracy) UbsMissile =
{
	local vector vec;
	local vector move;
	local float fly;
	makevectors (self.angles);
	vec = ((self.enemy.origin + self.enemy.mins) + (self.enemy.size * 0.7)) - missile.origin;
	fly = vlen (vec) / mspeed;
	move = self.enemy.velocity;
	move_z = FALSE;
	vec = vec + (move * fly);
	vec = normalize (vec);
	vec = (vec + ((accuracy * v_up) * (random () - 0.5))) + ((accuracy * v_right) * (random () - 0.5));
	missile.velocity = (vec * mspeed);
	missile.angles = VEC_ORIGIN;
	missile.angles_y = vectoyaw (missile.velocity);
	missile.nextthink = (time + MOVETYPE_FLY);
	missile.think = SUB_Remove;
};

float () ubsCheckAttack =
{
	local vector spot1;
	local vector spot2;
	local entity targ;
	local float chance;
	if ((time < self.attack_finished))
	{
		return (FALSE);
	}
	if (!enemy_vis)
	{
		return (FALSE);
	}
	if ((enemy_range == MOVETYPE_WALK))
	{
		if ((self.attack_state != TRUE))
		{
			self.attack_state = TRUE;
			ubs_run ();
		}
		return (FALSE);
	}
	targ = self.enemy;
	spot1 = self.origin + self.view_ofs;
	spot2 = targ.origin + targ.view_ofs;
	traceline (spot1, spot2, FALSE, self);
	if ((trace_ent != targ))
	{
		if ((self.attack_state != TRUE))
		{
			self.attack_state = TRUE;
			ubs_run ();
		}
		return (FALSE);
	}
	if ((enemy_range == FALSE))
	{
		chance = 0.9;
	}
	else
	{
		if ((enemy_range == TRUE))
		{
			chance = 0.6;
		}
		else
		{
			if ((enemy_range == FL_SWIM))
			{
				chance = 0.2;
			}
			else
			{
				chance = FALSE;
			}
		}
	}
	if ((random () < chance))
	{
		self.attack_state = MOVETYPE_STEP;
		return (TRUE);
	}
	if ((enemy_range == FL_SWIM))
	{
		if ((self.attack_state != TRUE))
		{
			self.attack_state = TRUE;
			ubs_run ();
		}
	}
	else
	{
		if (((self.attack_state != FL_SWIM) && (random () < 0.5)))
		{
			self.attack_state = FL_SWIM;
			ubs_side ();
		}
	}
	return (FALSE);
};

void () ubsAttackFinished =
{
	if (((enemy_range >= FL_SWIM) || !enemy_vis))
	{
		self.attack_state = TRUE;
		self.think = ubs_run;
	}
};

void () ubs_FastFire =
{
	local vector vec;
	local vector dst;
	if (IsAlive (self.owner))
	{
		self.owner.effects = (self.owner.effects | FL_SWIM);
		makevectors (self.enemy.angles);
		dst = self.enemy.origin - (13 * self.movedir);
		vec = normalize ((dst - self.origin));
		sound (self, TRUE, "ubs/wattack.wav", TRUE, TRUE);
		launch_spike (self.origin, vec);
		newmis.velocity = (vec * 600);
		newmis.owner = self.owner;
		newmis.classname = "wizspike";
		setmodel (newmis, "progs/w_spike.mdl");
		setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	}
	remove (self);
};

void () ubs_StartFast =
{
	local entity missile;
	sound (self, TRUE, "ubs/wattack.wav", TRUE, TRUE);
	self.v_angle = self.angles;
	makevectors (self.angles);
	missile = spawn ();
	missile.owner = self;
	missile.nextthink = (time + 0.6);
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, (((self.origin + '0 0 30') + (v_forward * 14)) + (v_right * 14)));
	missile.enemy = self.enemy;
	missile.nextthink = (time + 0.8);
	missile.think = ubs_FastFire;
	missile.movedir = v_right;
	missile = spawn ();
	missile.owner = self;
	missile.nextthink = (time + TRUE);
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, (((self.origin + '0 0 30') + (v_forward * 14)) + (v_right * -14)));
	missile.enemy = self.enemy;
	missile.nextthink = (time + 0.3);
	missile.think = ubs_FastFire;
	missile.movedir = (VEC_ORIGIN - v_right);
};

void () ubs_idlesound =
{
	local float wr;
	wr = random () * MOVETYPE_FLY;
	if ((self.waitmin < time))
	{
		self.waitmin = (time + FL_SWIM);
		if ((wr > 4.5))
		{
			sound (self, FL_SWIM, "ubs/widle1.wav", TRUE, FALSE);
		}
		if ((wr < 1.5))
		{
			sound (self, FL_SWIM, "ubs/widle2.wav", TRUE, FALSE);
		}
	}
	return;
};
void () ubs_unfurl2;

void () ubs_unfurl1 = [ 0, ubs_unfurl2 ]
{
	sound (self, FL_SWIM, "ubs/wsight.wav", TRUE, FALSE);
	self.takedamage = FL_SWIM;
	self.ideal_yaw = (self.angles * '0 1 0');
	self.view_ofs = '0 0 25';
	self.flags = (self.flags | TRUE);
	self.flags = (self.flags | FL_MONSTER);
};
void () ubs_unfurl3;

void () ubs_unfurl2 = [ 1, ubs_unfurl3 ]
{
};
void () ubs_unfurl4;

void () ubs_unfurl3 = [ 2, ubs_unfurl4 ]
{
};
void () ubs_unfurl5;

void () ubs_unfurl4 = [ 3, ubs_unfurl5 ]
{
};
void () ubs_unfurl6;

void () ubs_unfurl5 = [ 4, ubs_unfurl6 ]
{
};
void () ubs_unfurl7;

void () ubs_unfurl6 = [ 5, ubs_unfurl7 ]
{
};
void () ubs_unfurl8;

void () ubs_unfurl7 = [ 6, ubs_unfurl8 ]
{
};
void () ubs_unfurl9;

void () ubs_unfurl8 = [ 7, ubs_unfurl9 ]
{
};
void () ubs_unfurl10;

void () ubs_unfurl9 = [ 8, ubs_unfurl10 ]
{
};
void () ubs_unfurl11;

void () ubs_unfurl10 = [ 9, ubs_unfurl11 ]
{
};

void () ubs_unfurl11 = [ 10, ubs_runa1 ]
{
	self.ideal_yaw = vectoyaw ((self.enemy.origin - self.origin));
	self.ubs_point = SelectUBSPoint ();
	self.pausetime = 100000000;
	self.th_run ();
};
void () ubs_standa2;

void () ubs_standa1 = [ 11, ubs_standa2 ]
{
	ai_stand ();
};
void () ubs_standa3;

void () ubs_standa2 = [ 12, ubs_standa3 ]
{
	ai_stand ();
};
void () ubs_standa4;

void () ubs_standa3 = [ 13, ubs_standa4 ]
{
	ai_stand ();
};
void () ubs_standa5;

void () ubs_standa4 = [ 14, ubs_standa5 ]
{
	ai_stand ();
};
void () ubs_standa6;

void () ubs_standa5 = [ 15, ubs_standa6 ]
{
	ai_stand ();
};
void () ubs_standa7;

void () ubs_standa6 = [ 16, ubs_standa7 ]
{
	ai_stand ();
};
void () ubs_standa8;

void () ubs_standa7 = [ 17, ubs_standa8 ]
{
	ai_stand ();
};
void () ubs_stand;

void () ubs_standa8 = [ 18, ubs_stand ]
{
	ai_stand ();
};
void () ubs_standb2;

void () ubs_standb1 = [ 19, ubs_standb2 ]
{
	ai_stand ();
};
void () ubs_standb3;

void () ubs_standb2 = [ 20, ubs_standb3 ]
{
	ai_stand ();
};
void () ubs_standb4;

void () ubs_standb3 = [ 21, ubs_standb4 ]
{
	ai_stand ();
};
void () ubs_standb5;

void () ubs_standb4 = [ 22, ubs_standb5 ]
{
	ai_stand ();
};
void () ubs_standb6;

void () ubs_standb5 = [ 23, ubs_standb6 ]
{
	ai_stand ();
};
void () ubs_standb7;

void () ubs_standb6 = [ 24, ubs_standb7 ]
{
	ai_stand ();
};
void () ubs_standb8;

void () ubs_standb7 = [ 25, ubs_standb8 ]
{
	ai_stand ();
};

void () ubs_standb8 = [ 26, ubs_stand ]
{
	ai_stand ();
};
void () ubs_standc2;

void () ubs_standc1 = [ 27, ubs_standc2 ]
{
	ai_stand ();
};
void () ubs_standc3;

void () ubs_standc2 = [ 28, ubs_standc3 ]
{
	ai_stand ();
};
void () ubs_standc4;

void () ubs_standc3 = [ 29, ubs_standc4 ]
{
	ai_stand ();
};
void () ubs_standc5;

void () ubs_standc4 = [ 30, ubs_standc5 ]
{
	ai_stand ();
};
void () ubs_standc6;

void () ubs_standc5 = [ 31, ubs_standc6 ]
{
	ai_stand ();
};
void () ubs_standc7;

void () ubs_standc6 = [ 32, ubs_standc7 ]
{
	ai_stand ();
};
void () ubs_standc8;

void () ubs_standc7 = [ 33, ubs_standc8 ]
{
	ai_stand ();
};

void () ubs_standc8 = [ 34, ubs_stand ]
{
	ai_stand ();
};

void () ubs_stand =
{
	if ((self.health <= 500))
	{
		ubs_standc1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_standb1 ();
		}
		else
		{
			ubs_standa1 ();
		}
	}
};
void () ubs_walka2;

void () ubs_walka1 = [ 11, ubs_walka2 ]
{
	ai_walk (FL_CLIENT);
	ubs_idlesound ();
};
void () ubs_walka3;

void () ubs_walka2 = [ 12, ubs_walka3 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walka4;

void () ubs_walka3 = [ 13, ubs_walka4 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walka5;

void () ubs_walka4 = [ 14, ubs_walka5 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walka6;

void () ubs_walka5 = [ 15, ubs_walka6 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walka7;

void () ubs_walka6 = [ 16, ubs_walka7 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walka8;

void () ubs_walka7 = [ 17, ubs_walka8 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walk;

void () ubs_walka8 = [ 18, ubs_walk ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkb2;

void () ubs_walkb1 = [ 19, ubs_walkb2 ]
{
	ai_walk (FL_CLIENT);
	ubs_idlesound ();
};
void () ubs_walkb3;

void () ubs_walkb2 = [ 20, ubs_walkb3 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkb4;

void () ubs_walkb3 = [ 21, ubs_walkb4 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkb5;

void () ubs_walkb4 = [ 22, ubs_walkb5 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkb6;

void () ubs_walkb5 = [ 23, ubs_walkb6 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkb7;

void () ubs_walkb6 = [ 24, ubs_walkb7 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkb8;

void () ubs_walkb7 = [ 25, ubs_walkb8 ]
{
	ai_walk (FL_CLIENT);
};

void () ubs_walkb8 = [ 26, ubs_walk ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkc2;

void () ubs_walkc1 = [ 27, ubs_walkc2 ]
{
	ai_walk (FL_CLIENT);
	ubs_idlesound ();
};
void () ubs_walkc3;

void () ubs_walkc2 = [ 28, ubs_walkc3 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkc4;

void () ubs_walkc3 = [ 29, ubs_walkc4 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkc5;

void () ubs_walkc4 = [ 30, ubs_walkc5 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkc6;

void () ubs_walkc5 = [ 31, ubs_walkc6 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkc7;

void () ubs_walkc6 = [ 32, ubs_walkc7 ]
{
	ai_walk (FL_CLIENT);
};
void () ubs_walkc8;

void () ubs_walkc7 = [ 33, ubs_walkc8 ]
{
	ai_walk (FL_CLIENT);
};

void () ubs_walkc8 = [ 34, ubs_walk ]
{
	ai_walk (FL_CLIENT);
};

void () ubs_walk =
{
	if ((self.health <= 500))
	{
		ubs_walkc1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_walkb1 ();
		}
		else
		{
			ubs_walka1 ();
		}
	}
};
void () ubs_sidea2;

void () ubs_sidea1 = [ 11, ubs_sidea2 ]
{
	ai_run (20);
	self.attack_state = FL_SWIM;
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidea3;

void () ubs_sidea2 = [ 12, ubs_sidea3 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidea4;

void () ubs_sidea3 = [ 13, ubs_sidea4 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidea5;

void () ubs_sidea4 = [ 14, ubs_sidea5 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidea6;

void () ubs_sidea5 = [ 15, ubs_sidea6 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidea7;

void () ubs_sidea6 = [ 16, ubs_sidea7 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidea8;

void () ubs_sidea7 = [ 17, ubs_sidea8 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};

void () ubs_sidea8 = [ 18, ubs_run ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sideb2;

void () ubs_sideb1 = [ 19, ubs_sideb2 ]
{
	ai_run (20);
	self.attack_state = FL_SWIM;
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sideb3;

void () ubs_sideb2 = [ 20, ubs_sideb3 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sideb4;

void () ubs_sideb3 = [ 21, ubs_sideb4 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sideb5;

void () ubs_sideb4 = [ 22, ubs_sideb5 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sideb6;

void () ubs_sideb5 = [ 23, ubs_sideb6 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sideb7;

void () ubs_sideb6 = [ 24, ubs_sideb7 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sideb8;

void () ubs_sideb7 = [ 25, ubs_sideb8 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};

void () ubs_sideb8 = [ 26, ubs_run ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidec2;

void () ubs_sidec1 = [ 27, ubs_sidec2 ]
{
	ai_run (20);
	self.attack_state = FL_SWIM;
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidec3;

void () ubs_sidec2 = [ 28, ubs_sidec3 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidec4;

void () ubs_sidec3 = [ 29, ubs_sidec4 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidec5;

void () ubs_sidec4 = [ 30, ubs_sidec5 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidec6;

void () ubs_sidec5 = [ 31, ubs_sidec6 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidec7;

void () ubs_sidec6 = [ 32, ubs_sidec7 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};
void () ubs_sidec8;

void () ubs_sidec7 = [ 33, ubs_sidec8 ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};

void () ubs_sidec8 = [ 34, ubs_run ]
{
	ai_run (24);
	ubs_zap (500, (TRUE + skill));
};

void () ubs_side =
{
	sound (self, FL_SWIM, "ubs/elec.wav", TRUE, TRUE);
	self.attack_finished = (time + TRUE);
	if ((self.health <= 500))
	{
		ubs_sidec1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_sideb1 ();
		}
		else
		{
			ubs_sidea1 ();
		}
	}
};
void () ubs_dodgea2;

void () ubs_dodgea1 = [ 11, ubs_dodgea2 ]
{
	ai_run (SVC_INTERMISSION);
	self.attack_state = FL_SWIM;
};
void () ubs_dodgea3;

void () ubs_dodgea2 = [ 12, ubs_dodgea3 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgea4;

void () ubs_dodgea3 = [ 13, ubs_dodgea4 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgea5;

void () ubs_dodgea4 = [ 14, ubs_dodgea5 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgea6;

void () ubs_dodgea5 = [ 15, ubs_dodgea6 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgea7;

void () ubs_dodgea6 = [ 16, ubs_dodgea7 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgea8;

void () ubs_dodgea7 = [ 17, ubs_dodgea8 ]
{
	ai_run (SVC_INTERMISSION);
};

void () ubs_dodgea8 = [ 18, ubs_run ]
{
	ai_run (SVC_INTERMISSION);
	self.attack_state = TRUE;
};
void () ubs_dodgeb2;

void () ubs_dodgeb1 = [ 19, ubs_dodgeb2 ]
{
	ai_run (SVC_INTERMISSION);
	self.attack_state = FL_SWIM;
};
void () ubs_dodgeb3;

void () ubs_dodgeb2 = [ 20, ubs_dodgeb3 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgeb4;

void () ubs_dodgeb3 = [ 21, ubs_dodgeb4 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgeb5;

void () ubs_dodgeb4 = [ 22, ubs_dodgeb5 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgeb6;

void () ubs_dodgeb5 = [ 23, ubs_dodgeb6 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgeb7;

void () ubs_dodgeb6 = [ 24, ubs_dodgeb7 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgeb8;

void () ubs_dodgeb7 = [ 25, ubs_dodgeb8 ]
{
	ai_run (SVC_INTERMISSION);
};

void () ubs_dodgeb8 = [ 26, ubs_run ]
{
	ai_run (SVC_INTERMISSION);
	self.attack_state = TRUE;
};
void () ubs_dodgec2;

void () ubs_dodgec1 = [ 27, ubs_dodgec2 ]
{
	ai_run (SVC_INTERMISSION);
	self.attack_state = FL_SWIM;
};
void () ubs_dodgec3;

void () ubs_dodgec2 = [ 28, ubs_dodgec3 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgec4;

void () ubs_dodgec3 = [ 29, ubs_dodgec4 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgec5;

void () ubs_dodgec4 = [ 30, ubs_dodgec5 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgec6;

void () ubs_dodgec5 = [ 31, ubs_dodgec6 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgec7;

void () ubs_dodgec6 = [ 32, ubs_dodgec7 ]
{
	ai_run (SVC_INTERMISSION);
};
void () ubs_dodgec8;

void () ubs_dodgec7 = [ 33, ubs_dodgec8 ]
{
	ai_run (SVC_INTERMISSION);
};

void () ubs_dodgec8 = [ 34, ubs_run ]
{
	ai_run (SVC_INTERMISSION);
	self.attack_state = TRUE;
};

void () ubs_dodge =
{
	if ((self.health <= 500))
	{
		ubs_dodgec1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_dodgeb1 ();
		}
		else
		{
			ubs_dodgea1 ();
		}
	}
};
void () ubs_runa2;

void () ubs_runa1 = [ 11, ubs_runa2 ]
{
	ubs_idlesound ();
	ubscheckdist ();
	self.attack_state = TRUE;
	ai_face ();
};
void () ubs_runa3;

void () ubs_runa2 = [ 12, ubs_runa3 ]
{
	ubscheckdist ();
	ai_face ();
};
void () ubs_runa4;

void () ubs_runa3 = [ 13, ubs_runa4 ]
{
	ubscheckdist ();
	ai_face ();
};
void () ubs_runa5;

void () ubs_runa4 = [ 14, ubs_runa5 ]
{
	ubscheckdist ();
	ai_face ();
};
void () ubs_runa6;

void () ubs_runa5 = [ 15, ubs_runa6 ]
{
	ubscheckdist ();
	ai_face ();
};
void () ubs_runa7;

void () ubs_runa6 = [ 16, ubs_runa7 ]
{
	ubscheckdist ();
	ai_face ();
};
void () ubs_runa8;

void () ubs_runa7 = [ 17, ubs_runa8 ]
{
	ubscheckdist ();
	ai_face ();
};

void () ubs_runa8 = [ 18, ubs_run ]
{
	ubscheckdist ();
	ai_face ();
};
void () ubs_runb2;

void () ubs_runb1 = [ 19, ubs_runb2 ]
{
	ubs_idlesound ();
	ubscheckdist ();
	self.attack_state = TRUE;
};
void () ubs_runb3;

void () ubs_runb2 = [ 20, ubs_runb3 ]
{
	ubscheckdist ();
};
void () ubs_runb4;

void () ubs_runb3 = [ 21, ubs_runb4 ]
{
	ubscheckdist ();
};
void () ubs_runb5;

void () ubs_runb4 = [ 22, ubs_runb5 ]
{
	ubscheckdist ();
};
void () ubs_runb6;

void () ubs_runb5 = [ 23, ubs_runb6 ]
{
	ubscheckdist ();
};
void () ubs_runb7;

void () ubs_runb6 = [ 24, ubs_runb7 ]
{
	ubscheckdist ();
};
void () ubs_runb8;

void () ubs_runb7 = [ 25, ubs_runb8 ]
{
	ubscheckdist ();
};

void () ubs_runb8 = [ 26, ubs_run ]
{
	ubscheckdist ();
};
void () ubs_runc2;

void () ubs_runc1 = [ 27, ubs_runc2 ]
{
	ubs_idlesound ();
	ubscheckdist ();
	self.attack_state = TRUE;
};
void () ubs_runc3;

void () ubs_runc2 = [ 28, ubs_runc3 ]
{
	ubscheckdist ();
};
void () ubs_runc4;

void () ubs_runc3 = [ 29, ubs_runc4 ]
{
	ubscheckdist ();
};
void () ubs_runc5;

void () ubs_runc4 = [ 30, ubs_runc5 ]
{
	ubscheckdist ();
};
void () ubs_runc6;

void () ubs_runc5 = [ 31, ubs_runc6 ]
{
	ubscheckdist ();
};
void () ubs_runc7;

void () ubs_runc6 = [ 32, ubs_runc7 ]
{
	ubscheckdist ();
};
void () ubs_runc8;

void () ubs_runc7 = [ 33, ubs_runc8 ]
{
	ubscheckdist ();
};

void () ubs_runc8 = [ 34, ubs_run ]
{
	ubscheckdist ();
};

void () ubs_run =
{
	if ((self.health <= 500))
	{
		ubs_runc1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_runb1 ();
		}
		else
		{
			ubs_runa1 ();
		}
	}
};
void () ubs_fasta2;

void () ubs_fasta1 = [ 107, ubs_fasta2 ]
{
	ai_face ();
};
void () ubs_fasta3;

void () ubs_fasta2 = [ 108, ubs_fasta3 ]
{
	ai_face ();
};
void () ubs_fasta4;

void () ubs_fasta3 = [ 109, ubs_fasta4 ]
{
	ai_face ();
};
void () ubs_fasta5;

void () ubs_fasta4 = [ 110, ubs_fasta5 ]
{
	ai_face ();
};
void () ubs_fasta6;

void () ubs_fasta5 = [ 111, ubs_fasta6 ]
{
	ai_face ();
};
void () ubs_fasta7;

void () ubs_fasta6 = [ 112, ubs_fasta7 ]
{
	ai_face ();
};
void () ubs_fasta8;

void () ubs_fasta7 = [ 113, ubs_fasta8 ]
{
	ai_face ();
	ubs_shot1 (FALSE);
};
void () ubs_fasta9;

void () ubs_fasta8 = [ 114, ubs_fasta9 ]
{
};
void () ubs_fasta10;

void () ubs_fasta9 = [ 115, ubs_fasta10 ]
{
	ubscheckdist ();
};
void () ubs_fasta11;

void () ubs_fasta10 = [ 116, ubs_fasta11 ]
{
	ubscheckdist ();
};
void () ubs_fasta12;

void () ubs_fasta11 = [ 117, ubs_fasta12 ]
{
	ubscheckdist ();
};
void () ubs_fasta13;

void () ubs_fasta12 = [ 118, ubs_fasta13 ]
{
	ubscheckdist ();
};
void () ubs_fasta14;

void () ubs_fasta13 = [ 119, ubs_fasta14 ]
{
	ubscheckdist ();
};

void () ubs_fasta14 = [ 120, ubs_run ]
{
	SUB_AttackFinished (TRUE);
};
void () ubs_fastb2;

void () ubs_fastb1 = [ 121, ubs_fastb2 ]
{
	ai_face ();
};
void () ubs_fastb3;

void () ubs_fastb2 = [ 122, ubs_fastb3 ]
{
	ai_face ();
};
void () ubs_fastb4;

void () ubs_fastb3 = [ 123, ubs_fastb4 ]
{
	ai_face ();
};
void () ubs_fastb5;

void () ubs_fastb4 = [ 124, ubs_fastb5 ]
{
	ai_face ();
};
void () ubs_fastb6;

void () ubs_fastb5 = [ 125, ubs_fastb6 ]
{
	ai_face ();
};
void () ubs_fastb7;

void () ubs_fastb6 = [ 126, ubs_fastb7 ]
{
	ai_face ();
};
void () ubs_fastb8;

void () ubs_fastb7 = [ 127, ubs_fastb8 ]
{
	ai_face ();
	ubs_shot1 (FALSE);
};
void () ubs_fastb9;

void () ubs_fastb8 = [ 128, ubs_fastb9 ]
{
};
void () ubs_fastb10;

void () ubs_fastb9 = [ 129, ubs_fastb10 ]
{
	ubscheckdist ();
};
void () ubs_fastb11;

void () ubs_fastb10 = [ 130, ubs_fastb11 ]
{
	ubscheckdist ();
};
void () ubs_fastb12;

void () ubs_fastb11 = [ 131, ubs_fastb12 ]
{
	ubscheckdist ();
};
void () ubs_fastb13;

void () ubs_fastb12 = [ 132, ubs_fastb13 ]
{
	ubscheckdist ();
};
void () ubs_fastb14;

void () ubs_fastb13 = [ 133, ubs_fastb14 ]
{
	ubscheckdist ();
};

void () ubs_fastb14 = [ 134, ubs_run ]
{
	SUB_AttackFinished (TRUE);
};
void () ubs_fastc2;

void () ubs_fastc1 = [ 135, ubs_fastc2 ]
{
	ai_face ();
};
void () ubs_fastc3;

void () ubs_fastc2 = [ 136, ubs_fastc3 ]
{
	ai_face ();
};
void () ubs_fastc4;

void () ubs_fastc3 = [ 137, ubs_fastc4 ]
{
	ai_face ();
};
void () ubs_fastc5;

void () ubs_fastc4 = [ 138, ubs_fastc5 ]
{
	ai_face ();
};
void () ubs_fastc6;

void () ubs_fastc5 = [ 139, ubs_fastc6 ]
{
	ai_face ();
};
void () ubs_fastc7;

void () ubs_fastc6 = [ 140, ubs_fastc7 ]
{
	ai_face ();
};
void () ubs_fastc8;

void () ubs_fastc7 = [ 141, ubs_fastc8 ]
{
	ai_face ();
	ubs_shot1 (FALSE);
};
void () ubs_fastc9;

void () ubs_fastc8 = [ 142, ubs_fastc9 ]
{
};
void () ubs_fastc10;

void () ubs_fastc9 = [ 143, ubs_fastc10 ]
{
	ubscheckdist ();
};
void () ubs_fastc11;

void () ubs_fastc10 = [ 144, ubs_fastc11 ]
{
	ubscheckdist ();
};
void () ubs_fastc12;

void () ubs_fastc11 = [ 145, ubs_fastc12 ]
{
	ubscheckdist ();
};
void () ubs_fastc13;

void () ubs_fastc12 = [ 146, ubs_fastc13 ]
{
	ubscheckdist ();
};
void () ubs_fastc14;

void () ubs_fastc13 = [ 147, ubs_fastc14 ]
{
	ubscheckdist ();
};

void () ubs_fastc14 = [ 148, ubs_run ]
{
	SUB_AttackFinished (TRUE);
};

void () ubs_fast =
{
	if ((self.health <= 500))
	{
		ubs_fastc1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_fastb1 ();
		}
		else
		{
			ubs_fasta1 ();
		}
	}
};
void () ubs_makewiza2;

void () ubs_makewiza1 = [ 107, ubs_makewiza2 ]
{
	sound (self, FALSE, "ubs/spawnst.wav", TRUE, FALSE);
};
void () ubs_makewiza3;

void () ubs_makewiza2 = [ 108, ubs_makewiza3 ]
{
};
void () ubs_makewiza4;

void () ubs_makewiza3 = [ 109, ubs_makewiza4 ]
{
};
void () ubs_makewiza5;

void () ubs_makewiza4 = [ 110, ubs_makewiza5 ]
{
};
void () ubs_makewiza6;

void () ubs_makewiza5 = [ 111, ubs_makewiza6 ]
{
};
void () ubs_makewiza7;

void () ubs_makewiza6 = [ 112, ubs_makewiza7 ]
{
};
void () ubs_makewiza8;

void () ubs_makewiza7 = [ 113, ubs_makewiza8 ]
{
	ubs_shot2 ();
};
void () ubs_makewiza9;

void () ubs_makewiza8 = [ 114, ubs_makewiza9 ]
{
};
void () ubs_makewiza10;

void () ubs_makewiza9 = [ 115, ubs_makewiza10 ]
{
};
void () ubs_makewiza11;

void () ubs_makewiza10 = [ 116, ubs_makewiza11 ]
{
};
void () ubs_makewiza12;

void () ubs_makewiza11 = [ 117, ubs_makewiza12 ]
{
};
void () ubs_makewiza13;

void () ubs_makewiza12 = [ 118, ubs_makewiza13 ]
{
};
void () ubs_makewiza14;

void () ubs_makewiza13 = [ 119, ubs_makewiza14 ]
{
};

void () ubs_makewiza14 = [ 120, ubs_run ]
{
	ubscheckdist ();
	SUB_AttackFinished (FL_SWIM);
	ubsAttackFinished ();
};
void () ubs_makewizb2;

void () ubs_makewizb1 = [ 121, ubs_makewizb2 ]
{
	sound (self, FALSE, "ubs/spawnst.wav", TRUE, FALSE);
};
void () ubs_makewizb3;

void () ubs_makewizb2 = [ 122, ubs_makewizb3 ]
{
};
void () ubs_makewizb4;

void () ubs_makewizb3 = [ 123, ubs_makewizb4 ]
{
};
void () ubs_makewizb5;

void () ubs_makewizb4 = [ 124, ubs_makewizb5 ]
{
};
void () ubs_makewizb6;

void () ubs_makewizb5 = [ 125, ubs_makewizb6 ]
{
};
void () ubs_makewizb7;

void () ubs_makewizb6 = [ 126, ubs_makewizb7 ]
{
};
void () ubs_makewizb8;

void () ubs_makewizb7 = [ 127, ubs_makewizb8 ]
{
	ubs_shot2 ();
};
void () ubs_makewizb9;

void () ubs_makewizb8 = [ 128, ubs_makewizb9 ]
{
};
void () ubs_makewizb10;

void () ubs_makewizb9 = [ 129, ubs_makewizb10 ]
{
};
void () ubs_makewizb11;

void () ubs_makewizb10 = [ 130, ubs_makewizb11 ]
{
};
void () ubs_makewizb12;

void () ubs_makewizb11 = [ 131, ubs_makewizb12 ]
{
};
void () ubs_makewizb13;

void () ubs_makewizb12 = [ 132, ubs_makewizb13 ]
{
};
void () ubs_makewizb14;

void () ubs_makewizb13 = [ 133, ubs_makewizb14 ]
{
};

void () ubs_makewizb14 = [ 134, ubs_run ]
{
	ubscheckdist ();
	SUB_AttackFinished (FL_SWIM);
	ubsAttackFinished ();
};
void () ubs_makewizc2;

void () ubs_makewizc1 = [ 135, ubs_makewizc2 ]
{
	sound (self, FALSE, "ubs/spawnst.wav", TRUE, FALSE);
};
void () ubs_makewizc3;

void () ubs_makewizc2 = [ 136, ubs_makewizc3 ]
{
};
void () ubs_makewizc4;

void () ubs_makewizc3 = [ 137, ubs_makewizc4 ]
{
};
void () ubs_makewizc5;

void () ubs_makewizc4 = [ 138, ubs_makewizc5 ]
{
};
void () ubs_makewizc6;

void () ubs_makewizc5 = [ 139, ubs_makewizc6 ]
{
};
void () ubs_makewizc7;

void () ubs_makewizc6 = [ 140, ubs_makewizc7 ]
{
};
void () ubs_makewizc8;

void () ubs_makewizc7 = [ 141, ubs_makewizc8 ]
{
	ubs_shot2 ();
};
void () ubs_makewizc9;

void () ubs_makewizc8 = [ 142, ubs_makewizc9 ]
{
};
void () ubs_makewizc10;

void () ubs_makewizc9 = [ 143, ubs_makewizc10 ]
{
};
void () ubs_makewizc11;

void () ubs_makewizc10 = [ 144, ubs_makewizc11 ]
{
};
void () ubs_makewizc12;

void () ubs_makewizc11 = [ 145, ubs_makewizc12 ]
{
};
void () ubs_makewizc13;

void () ubs_makewizc12 = [ 146, ubs_makewizc13 ]
{
};
void () ubs_makewizc14;

void () ubs_makewizc13 = [ 147, ubs_makewizc14 ]
{
};

void () ubs_makewizc14 = [ 148, ubs_run ]
{
	ubscheckdist ();
	SUB_AttackFinished (FL_SWIM);
	ubsAttackFinished ();
};

void () ubs_makewiz =
{
	if ((self.health <= 500))
	{
		ubs_makewizc1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_makewizb1 ();
		}
		else
		{
			ubs_makewiza1 ();
		}
	}
};
void () ubs_spreada2;

void () ubs_spreada1 = [ 35, ubs_spreada2 ]
{
	ai_face ();
};
void () ubs_spreada3;

void () ubs_spreada2 = [ 36, ubs_spreada3 ]
{
	ai_face ();
};
void () ubs_spreada4;

void () ubs_spreada3 = [ 37, ubs_spreada4 ]
{
	ai_face ();
};
void () ubs_spreada5;

void () ubs_spreada4 = [ 38, ubs_spreada5 ]
{
	ai_face ();
};
void () ubs_spreada6;

void () ubs_spreada5 = [ 39, ubs_spreada6 ]
{
	ai_face ();
};
void () ubs_spreada7;

void () ubs_spreada6 = [ 40, ubs_spreada7 ]
{
	ai_face ();
	ubs_spread (TRUE);
};
void () ubs_spreada8;

void () ubs_spreada7 = [ 41, ubs_spreada8 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada9;

void () ubs_spreada8 = [ 42, ubs_spreada9 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada10;

void () ubs_spreada9 = [ 43, ubs_spreada10 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada11;

void () ubs_spreada10 = [ 44, ubs_spreada11 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada12;

void () ubs_spreada11 = [ 45, ubs_spreada12 ]
{
	ai_face ();
};
void () ubs_spreada13;

void () ubs_spreada12 = [ 46, ubs_spreada13 ]
{
	ai_face ();
	ubs_spread (TRUE);
};
void () ubs_spreada14;

void () ubs_spreada13 = [ 47, ubs_spreada14 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada15;

void () ubs_spreada14 = [ 48, ubs_spreada15 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada16;

void () ubs_spreada15 = [ 49, ubs_spreada16 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada17;

void () ubs_spreada16 = [ 50, ubs_spreada17 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreada18;

void () ubs_spreada17 = [ 51, ubs_spreada18 ]
{
	ai_face ();
};
void () ubs_spreada19;

void () ubs_spreada18 = [ 52, ubs_spreada19 ]
{
	ai_face ();
};
void () ubs_spreada20;

void () ubs_spreada19 = [ 53, ubs_spreada20 ]
{
	ai_face ();
};
void () ubs_spreada21;

void () ubs_spreada20 = [ 54, ubs_spreada21 ]
{
	ai_face ();
};
void () ubs_spreada22;

void () ubs_spreada21 = [ 55, ubs_spreada22 ]
{
	ai_face ();
};
void () ubs_spreada23;

void () ubs_spreada22 = [ 56, ubs_spreada23 ]
{
	ai_face ();
};
void () ubs_spreada24;

void () ubs_spreada23 = [ 57, ubs_spreada24 ]
{
	ai_face ();
};

void () ubs_spreada24 = [ 58, ubs_run ]
{
	ubscheckdist ();
	SUB_AttackFinished (FL_SWIM);
	ubsAttackFinished ();
};
void () ubs_spreadb2;

void () ubs_spreadb1 = [ 59, ubs_spreadb2 ]
{
	ai_face ();
};
void () ubs_spreadb3;

void () ubs_spreadb2 = [ 60, ubs_spreadb3 ]
{
	ai_face ();
};
void () ubs_spreadb4;

void () ubs_spreadb3 = [ 61, ubs_spreadb4 ]
{
	ai_face ();
};
void () ubs_spreadb5;

void () ubs_spreadb4 = [ 62, ubs_spreadb5 ]
{
	ai_face ();
};
void () ubs_spreadb6;

void () ubs_spreadb5 = [ 63, ubs_spreadb6 ]
{
	ai_face ();
};
void () ubs_spreadb7;

void () ubs_spreadb6 = [ 64, ubs_spreadb7 ]
{
	ai_face ();
	ubs_spread (TRUE);
};
void () ubs_spreadb8;

void () ubs_spreadb7 = [ 65, ubs_spreadb8 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb9;

void () ubs_spreadb8 = [ 66, ubs_spreadb9 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb10;

void () ubs_spreadb9 = [ 67, ubs_spreadb10 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb11;

void () ubs_spreadb10 = [ 68, ubs_spreadb11 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb12;

void () ubs_spreadb11 = [ 69, ubs_spreadb12 ]
{
	ai_face ();
};
void () ubs_spreadb13;

void () ubs_spreadb12 = [ 70, ubs_spreadb13 ]
{
	ai_face ();
	ubs_spread (TRUE);
};
void () ubs_spreadb14;

void () ubs_spreadb13 = [ 71, ubs_spreadb14 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb15;

void () ubs_spreadb14 = [ 72, ubs_spreadb15 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb16;

void () ubs_spreadb15 = [ 73, ubs_spreadb16 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb17;

void () ubs_spreadb16 = [ 74, ubs_spreadb17 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadb18;

void () ubs_spreadb17 = [ 75, ubs_spreadb18 ]
{
	ai_face ();
};
void () ubs_spreadb19;

void () ubs_spreadb18 = [ 76, ubs_spreadb19 ]
{
	ai_face ();
};
void () ubs_spreadb20;

void () ubs_spreadb19 = [ 77, ubs_spreadb20 ]
{
	ai_face ();
};
void () ubs_spreadb21;

void () ubs_spreadb20 = [ 78, ubs_spreadb21 ]
{
	ai_face ();
};
void () ubs_spreadb22;

void () ubs_spreadb21 = [ 79, ubs_spreadb22 ]
{
	ai_face ();
};
void () ubs_spreadb23;

void () ubs_spreadb22 = [ 80, ubs_spreadb23 ]
{
	ai_face ();
};
void () ubs_spreadb24;

void () ubs_spreadb23 = [ 81, ubs_spreadb24 ]
{
	ai_face ();
};

void () ubs_spreadb24 = [ 82, ubs_run ]
{
	ubscheckdist ();
	SUB_AttackFinished (FL_SWIM);
	ubsAttackFinished ();
};
void () ubs_spreadc2;

void () ubs_spreadc1 = [ 83, ubs_spreadc2 ]
{
	ai_face ();
};
void () ubs_spreadc3;

void () ubs_spreadc2 = [ 84, ubs_spreadc3 ]
{
	ai_face ();
};
void () ubs_spreadc4;

void () ubs_spreadc3 = [ 85, ubs_spreadc4 ]
{
	ai_face ();
};
void () ubs_spreadc5;

void () ubs_spreadc4 = [ 86, ubs_spreadc5 ]
{
	ai_face ();
};
void () ubs_spreadc6;

void () ubs_spreadc5 = [ 87, ubs_spreadc6 ]
{
	ai_face ();
};
void () ubs_spreadc7;

void () ubs_spreadc6 = [ 88, ubs_spreadc7 ]
{
	ai_face ();
	ubs_spread (TRUE);
};
void () ubs_spreadc8;

void () ubs_spreadc7 = [ 89, ubs_spreadc8 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc9;

void () ubs_spreadc8 = [ 90, ubs_spreadc9 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc10;

void () ubs_spreadc9 = [ 91, ubs_spreadc10 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc11;

void () ubs_spreadc10 = [ 92, ubs_spreadc11 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc12;

void () ubs_spreadc11 = [ 93, ubs_spreadc12 ]
{
	ai_face ();
};
void () ubs_spreadc13;

void () ubs_spreadc12 = [ 94, ubs_spreadc13 ]
{
	ai_face ();
	ubs_spread (TRUE);
};
void () ubs_spreadc14;

void () ubs_spreadc13 = [ 95, ubs_spreadc14 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc15;

void () ubs_spreadc14 = [ 96, ubs_spreadc15 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc16;

void () ubs_spreadc15 = [ 97, ubs_spreadc16 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc17;

void () ubs_spreadc16 = [ 98, ubs_spreadc17 ]
{
	ai_face ();
	ubs_spread (FALSE);
};
void () ubs_spreadc18;

void () ubs_spreadc17 = [ 99, ubs_spreadc18 ]
{
	ai_face ();
};
void () ubs_spreadc19;

void () ubs_spreadc18 = [ 100, ubs_spreadc19 ]
{
	ai_face ();
};
void () ubs_spreadc20;

void () ubs_spreadc19 = [ 101, ubs_spreadc20 ]
{
	ai_face ();
};
void () ubs_spreadc21;

void () ubs_spreadc20 = [ 102, ubs_spreadc21 ]
{
	ai_face ();
};
void () ubs_spreadc22;

void () ubs_spreadc21 = [ 103, ubs_spreadc22 ]
{
	ai_face ();
};
void () ubs_spreadc23;

void () ubs_spreadc22 = [ 104, ubs_spreadc23 ]
{
	ai_face ();
};
void () ubs_spreadc24;

void () ubs_spreadc23 = [ 105, ubs_spreadc24 ]
{
	ai_face ();
};

void () ubs_spreadc24 = [ 106, ubs_run ]
{
	ubscheckdist ();
	SUB_AttackFinished (FL_SWIM);
	ubsAttackFinished ();
};

void () ubs_spreadx =
{
	if ((self.health <= 500))
	{
		ubs_spreadc1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_spreadb1 ();
		}
		else
		{
			ubs_spreada1 ();
		}
	}
};
void () ubs_paina2;

void () ubs_paina1 = [ 179, ubs_paina2 ]
{
	ubscheckdist ();
	self.attack_state = TRUE;
};
void () ubs_paina3;

void () ubs_paina2 = [ 180, ubs_paina3 ]
{
	ubscheckdist ();
};
void () ubs_paina4;

void () ubs_paina3 = [ 181, ubs_paina4 ]
{
	ubscheckdist ();
};
void () ubs_paina5;

void () ubs_paina4 = [ 182, ubs_paina5 ]
{
	ubscheckdist ();
};
void () ubs_paina6;

void () ubs_paina5 = [ 183, ubs_paina6 ]
{
	ubscheckdist ();
};
void () ubs_paina7;

void () ubs_paina6 = [ 184, ubs_paina7 ]
{
	ubscheckdist ();
};

void () ubs_paina7 = [ 185, ubs_run ]
{
	ubscheckdist ();
};
void () ubs_painb2;

void () ubs_painb1 = [ 186, ubs_painb2 ]
{
	ubscheckdist ();
	self.attack_state = TRUE;
};
void () ubs_painb3;

void () ubs_painb2 = [ 187, ubs_painb3 ]
{
	ubscheckdist ();
};
void () ubs_painb4;

void () ubs_painb3 = [ 188, ubs_painb4 ]
{
	ubscheckdist ();
};
void () ubs_painb5;

void () ubs_painb4 = [ 189, ubs_painb5 ]
{
	ubscheckdist ();
};
void () ubs_painb6;

void () ubs_painb5 = [ 190, ubs_painb6 ]
{
	ubscheckdist ();
};
void () ubs_painb7;

void () ubs_painb6 = [ 191, ubs_painb7 ]
{
	ubscheckdist ();
};

void () ubs_painb7 = [ 192, ubs_run ]
{
	ubscheckdist ();
};
void () ubs_painc2;

void () ubs_painc1 = [ 193, ubs_painc2 ]
{
	ubscheckdist ();
	self.attack_state = TRUE;
};
void () ubs_painc3;

void () ubs_painc2 = [ 194, ubs_painc3 ]
{
	ubscheckdist ();
};
void () ubs_painc4;

void () ubs_painc3 = [ 195, ubs_painc4 ]
{
	ubscheckdist ();
};
void () ubs_painc5;

void () ubs_painc4 = [ 196, ubs_painc5 ]
{
	ubscheckdist ();
};
void () ubs_painc6;

void () ubs_painc5 = [ 197, ubs_painc6 ]
{
	ubscheckdist ();
};
void () ubs_painc7;

void () ubs_painc6 = [ 198, ubs_painc7 ]
{
	ubscheckdist ();
};

void () ubs_painc7 = [ 199, ubs_run ]
{
	ubscheckdist ();
};

void () Suckup_Think =
{
	local entity head;
	self.movetype = FL_CLIENT;
	self.solid = FALSE;
	self.velocity = (MOVETYPE_WALK * (self.owner.origin - self.origin));
	head = findradius (self.origin, FL_MONSTER);
	if (((head == self.owner) || !self.owner.model))
	{
		spawn_tfog (self.origin);
		remove (self);
		return;
	}
	self.think = Suckup_Think;
	self.nextthink = (time + 0.1);
};

void (string gibname, float dm, vector gibpos) ThrowUBSGib =
{
	local entity new;
	new = spawn ();
	new.owner = self;
	new.origin = gibpos;
	setmodel (new, gibname);
	setsize (new, VEC_ORIGIN, VEC_ORIGIN);
	new.velocity = VelocityForDamage (dm);
	new.movetype = MOVETYPE_BOUNCE;
	new.solid = FALSE;
	new.avelocity_x = (random () * 600);
	new.avelocity_y = (random () * 600);
	new.avelocity_z = (random () * 600);
	new.think = Suckup_Think;
	new.ltime = time;
	new.nextthink = ((time + TRUE) + (random () * FL_SWIM));
	new.frame = FALSE;
	new.flags = FALSE;
};

void () ubs_dieend1 = [ 223, ubs_dieend2 ]
{
	sound (self, FL_SWIM, "ubs/wdeath2.wav", TRUE, FALSE);
};
void () ubs_dieend3;

void () ubs_dieend2 = [ 224, ubs_dieend3 ]
{
};
void () ubs_dieend4;

void () ubs_dieend3 = [ 225, ubs_dieend4 ]
{
};
void () ubs_dieend5;

void () ubs_dieend4 = [ 226, ubs_dieend5 ]
{
};
void () ubs_dieend6;

void () ubs_dieend5 = [ 227, ubs_dieend6 ]
{
};
void () ubs_dieend7;

void () ubs_dieend6 = [ 228, ubs_dieend7 ]
{
};
void () ubs_dieend8;

void () ubs_dieend7 = [ 229, ubs_dieend8 ]
{
};
void () ubs_dieend9;

void () ubs_dieend8 = [ 230, ubs_dieend9 ]
{
};
void () ubs_dieend10;

void () ubs_dieend9 = [ 231, ubs_dieend10 ]
{
};
void () ubs_dieend11;

void () ubs_dieend10 = [ 232, ubs_dieend11 ]
{
};
void () ubs_dieend12;

void () ubs_dieend11 = [ 233, ubs_dieend12 ]
{
};
void () ubs_dieend13;

void () ubs_dieend12 = [ 233, ubs_dieend13 ]
{
	setorigin (self, self.origin);
	spawn_tfog (self.origin);
	self.model = "";
	self.solid = TRUE;
};

void () ubs_dieend13 = [ 233, ubs_dieend13 ]
{
	if ((!checkclient () || (coop == FL_SWIM)))
	{
		remove (self);
	}
};

void () ubs_killdie =
{
	local entity wizkill;
	wizkill = nextent (world);
	while ((wizkill != world))
	{
		if ((wizkill.model == "progs/wizard.mdl"))
		{
			spawn_tfog (self.origin);
			spawn_tfog (wizkill.origin);
			WriteByte (FALSE, SVC_TEMPENTITY);
			WriteByte (FALSE, MOVETYPE_TOSS);
			WriteEntity (FALSE, self);
			WriteCoord (FALSE, self.origin_x);
			WriteCoord (FALSE, self.origin_y);
			WriteCoord (FALSE, self.origin_z);
			WriteCoord (FALSE, wizkill.origin_x);
			WriteCoord (FALSE, wizkill.origin_y);
			WriteCoord (FALSE, wizkill.origin_z);
			sound (wizkill, FL_SWIM, "player/udeath.wav", TRUE, TRUE);
			ThrowUBSGib ("progs/h_wizard.mdl", -50, wizkill.origin);
			ThrowUBSGib ("progs/gib2.mdl", -50, wizkill.origin);
			ThrowUBSGib ("progs/gib2.mdl", -50, wizkill.origin);
			ThrowUBSGib ("progs/gib2.mdl", -50, wizkill.origin);
			if (((wizkill.classname != "monster_corpse") && (wizkill.health > FALSE)))
			{
				killed_monster ();
			}
			remove (wizkill);
			return;
		}
		wizkill = nextent (wizkill);
	}
	ubs_dieend1 ();
};
void () ubs_death2;

void () ubs_death1 = [ 200, ubs_death2 ]
{
	sound (self, FL_SWIM, "ubs/wdeath1.wav", TRUE, FALSE);
};
void () ubs_death3;

void () ubs_death2 = [ 201, ubs_death3 ]
{
};
void () ubs_death4;

void () ubs_death3 = [ 202, ubs_death4 ]
{
};
void () ubs_death5;

void () ubs_death4 = [ 203, ubs_death5 ]
{
};
void () ubs_death6;

void () ubs_death5 = [ 204, ubs_death6 ]
{
};
void () ubs_death7;

void () ubs_death6 = [ 205, ubs_death7 ]
{
};
void () ubs_death8;

void () ubs_death7 = [ 206, ubs_death8 ]
{
};
void () ubs_death9;

void () ubs_death8 = [ 207, ubs_death9 ]
{
};
void () ubs_death10;

void () ubs_death9 = [ 208, ubs_death10 ]
{
};
void () ubs_death11;

void () ubs_death10 = [ 209, ubs_death11 ]
{
};
void () ubs_death12;

void () ubs_death11 = [ 210, ubs_death12 ]
{
	ubs_killdie ();
};
void () ubs_death13;

void () ubs_death12 = [ 211, ubs_death13 ]
{
};
void () ubs_death14;

void () ubs_death13 = [ 212, ubs_death14 ]
{
};
void () ubs_death15;

void () ubs_death14 = [ 213, ubs_death15 ]
{
};
void () ubs_death16;

void () ubs_death15 = [ 214, ubs_death16 ]
{
};
void () ubs_death17;

void () ubs_death16 = [ 215, ubs_death17 ]
{
};
void () ubs_death18;

void () ubs_death17 = [ 216, ubs_death18 ]
{
};
void () ubs_death19;

void () ubs_death18 = [ 217, ubs_death19 ]
{
};
void () ubs_death20;

void () ubs_death19 = [ 218, ubs_death20 ]
{
};
void () ubs_death21;

void () ubs_death20 = [ 219, ubs_death21 ]
{
};
void () ubs_death22;

void () ubs_death21 = [ 220, ubs_death22 ]
{
};
void () ubs_death23;

void () ubs_death22 = [ 221, ubs_death23 ]
{
};

void () ubs_death23 = [ 222, ubs_death1 ]
{
	ubs_killdie ();
};

void () ubs_die =
{
	self.movetype = MOVETYPE_FLY;
	self.velocity = VEC_ORIGIN;
	setsize (self, '-16 -16 -16', '16 16 16');
	ubs_death1 ();
};
void () flap_land2;

void () flap_land1 = [ 18, flap_land2 ]
{
};
void () flap_land3;

void () flap_land2 = [ 19, flap_land3 ]
{
};
void () flap_land4;

void () flap_land3 = [ 20, flap_land4 ]
{
};
void () flap_land5;

void () flap_land4 = [ 21, flap_land5 ]
{
};
void () flap_land6;

void () flap_land5 = [ 22, flap_land6 ]
{
};

void () flap_land6 = [ 23, flap_land6 ]
{
	self.nextthink = ((time + MOVETYPE_BOUNCE) + (random () * MOVETYPE_BOUNCE));
	self.think = SUB_Remove;
};

void () Flap_Think =
{
	if ((self.velocity == VEC_ORIGIN))
	{
		flap_land1 ();
	}
};
void () flap_drop2;

void () flap_drop1 = [ 0, flap_drop2 ]
{
	Flap_Think ();
};
void () flap_drop3;

void () flap_drop2 = [ 1, flap_drop3 ]
{
	Flap_Think ();
};
void () flap_drop4;

void () flap_drop3 = [ 2, flap_drop4 ]
{
	Flap_Think ();
};
void () flap_drop5;

void () flap_drop4 = [ 3, flap_drop5 ]
{
	Flap_Think ();
};
void () flap_drop6;

void () flap_drop5 = [ 4, flap_drop6 ]
{
	Flap_Think ();
};
void () flap_drop7;

void () flap_drop6 = [ 5, flap_drop7 ]
{
	Flap_Think ();
};
void () flap_drop8;

void () flap_drop7 = [ 6, flap_drop8 ]
{
	Flap_Think ();
};
void () flap_drop9;

void () flap_drop8 = [ 7, flap_drop9 ]
{
	Flap_Think ();
};
void () flap_drop10;

void () flap_drop9 = [ 8, flap_drop10 ]
{
	Flap_Think ();
};
void () flap_float1;

void () flap_drop10 = [ 9, flap_float1 ]
{
	Flap_Think ();
};
void () flap_float2;

void () flap_float1 = [ 10, flap_float2 ]
{
	Flap_Think ();
};
void () flap_float3;

void () flap_float2 = [ 11, flap_float3 ]
{
	Flap_Think ();
};
void () flap_float4;

void () flap_float3 = [ 12, flap_float4 ]
{
	Flap_Think ();
};
void () flap_float5;

void () flap_float4 = [ 13, flap_float5 ]
{
	Flap_Think ();
};
void () flap_float6;

void () flap_float5 = [ 14, flap_float6 ]
{
	Flap_Think ();
};
void () flap_float7;

void () flap_float6 = [ 15, flap_float7 ]
{
	Flap_Think ();
};
void () flap_float8;

void () flap_float7 = [ 16, flap_float8 ]
{
	Flap_Think ();
};

void () flap_float8 = [ 17, flap_float1 ]
{
	Flap_Think ();
};

void () Toss_Flap =
{
	local entity new;
	self.ubs_deflapped = TRUE;
	new = spawn ();
	new.origin = (self.origin + (v_forward * FL_MONSTER));
	setmodel (new, "progs/uberskinflap.mdl");
	setsize (new, VEC_ORIGIN, VEC_ORIGIN);
	new.velocity_x = (-200 + (400 * random ()));
	new.velocity_y = (-200 + (400 * random ()));
	new.velocity_z = (100 + (100 * random ()));
	new.movetype = MOVETYPE_TOSS;
	new.solid = FALSE;
	new.think = flap_drop1;
	new.nextthink = (time + 0.01);
	new.frame = FALSE;
	new.flags = FALSE;
};

void (entity attacker, float damage) ubs_Pain =
{

	if ((self.health <= 500))
	{
		if ((self.ubs_deflapped != TRUE))
		{
			Toss_Flap ();
			sound (self, FL_SWIM, "ubs/wpain.wav", TRUE, FALSE);
			ubs_painc1 ();
			self.pain_finished = (time + FL_SWIM);
		}
	}
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + FL_SWIM);
	sound (self, FL_SWIM, "ubs/wpain.wav", TRUE, FALSE);
	if (((random () * 70) > damage))
	{
		return;
	}
	if ((self.health <= 500))
	{
		ubs_painc1 ();
	}
	else
	{
		if ((self.health <= 1000))
		{
			ubs_painb1 ();
		}
		else
		{
			ubs_paina1 ();
		}
	}
};

void () ubs_Missile =
{
	local vector dist;
	local float d;
	local float rnd1;
	dist = self.enemy.origin - self.origin;
	dist_z = FALSE;
	rnd1 = random ();
	d = vlen (dist);
	if (((((d >= 200) && (d < 500)) && (rnd1 < 0.4)) && (self.attack_finished < time)))
	{
		self.attack_finished = (time + 0.4);
		if ((self.health <= 500))
		{
			ubs_spreadc1 ();
		}
		else
		{
			if ((self.health <= 1000))
			{
				ubs_spreadb1 ();
			}
			else
			{
				ubs_spreada1 ();
			}
		}
	}
	else
	{
		if ((((d > 400) && (self.attack_finished < time)) && (rnd1 < 0.4)))
		{
			self.attack_finished = (time + TRUE);
			if ((self.health <= 500))
			{
				ubs_fastc1 ();
			}
			else
			{
				if ((self.health <= 1000))
				{
					ubs_fastb1 ();
				}
				else
				{
					ubs_fasta1 ();
				}
			}
		}
		else
		{
			if (((((d > 400) && (self.attack_finished < time)) && (rnd1 >= 0.4)) && (self.ident >= MOVETYPE_STEP)))
			{
				self.attack_finished = (time + TRUE);
				if ((self.health <= 500))
				{
					ubs_fastc1 ();
				}
				else
				{
					if ((self.health <= 1000))
					{
						ubs_fastb1 ();
					}
					else
					{
						ubs_fasta1 ();
					}
				}
			}
			else
			{
				if ((((d > 400) && (rnd1 >= 0.4)) && (self.ident < MOVETYPE_STEP)))
				{
					self.attack_finished = (time + TRUE);
					if ((self.health <= 500))
					{
						ubs_makewizc1 ();
					}
					else
					{
						if ((self.health <= 1000))
						{
							ubs_makewizb1 ();
						}
						else
						{
							ubs_makewiza1 ();
						}
					}
				}
				else
				{
					return;
				}
			}
		}
	}
};

void () ubs_awake =
{
	self.solid = MOVETYPE_WALK;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/uberscrag.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = MTF_Monster_Health(((25000 + (skill * 500)) / 2));
	self.th_stand = ubs_stand;
	self.th_walk = ubs_walk;
	self.th_run = ubs_run;
	self.th_missile = ubs_Missile;
	self.th_pain = ubs_Pain;
	self.th_die = ubs_die;
	self.yaw_speed = 25;
	self.enemy = activator;
	spawn_tfog (self.origin);
	ubs_unfurl1 ();
};

void () monster_ubs1 =
{
	self.touch = monster_touch;
	total_monsters = total_monsters + TRUE;
	self.use = ubs_awake;
	if ((coop == FL_SWIM))
	{
		self.use ();
	}
};

void () monster_ubs =
{

	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/uberscrag.mdl");
	precache_model ("progs/uberskinflap.mdl");
	precache_model ("progs/w_spike.mdl");
	precache_model ("progs/v_spike.mdl");
	precache_sound ("ubs/hit.wav");
	precache_sound ("ubs/attack1.wav");
	precache_sound ("ubs/wdeath1.wav");
	precache_sound ("ubs/wdeath2.wav");
	precache_sound ("ubs/widle1.wav");
	precache_sound ("ubs/widle2.wav");
	precache_sound ("ubs/wpain.wav");
	precache_sound ("ubs/wsight.wav");
	precache_sound ("ubs/elec.wav");
	precache_sound ("ubs/spawnfr.wav");
	precache_sound ("ubs/spawnst.wav");
	precache_model ("progs/wizard.mdl");
	precache_model ("progs/h_wizard.mdl");
	precache_model ("progs/w_spike.mdl");
	precache_model ("progs/utele.mdl");
	precache_sound ("wizard/hit.wav");
	precache_sound ("wizard/wattack.wav");
	precache_sound ("wizard/wdeath.wav");
	precache_sound ("wizard/widle1.wav");
	precache_sound ("wizard/widle2.wav");
	precache_sound ("wizard/wsight.wav");
	precache_sound ("wizard/wpain.wav");
	precache_sound ("shalrath/attack2.wav");
	self.netname = "Uber Scragg";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_ubs1;
	COOP_SetLives ();
	monster_ubs1 ();
};

void () spawnwiz =
{
	local entity newwiz;
	local vector tempvec;
	self.touch = SUB_Null;
	self.think = SUB_Null;
	if ((pointcontents (self.origin) == CONTENT_EMPTY))
	{
		if ((other == self.owner))
		{
			self.think = ubshome2;
			self.nextthink = (time + 0.1);
			return;
		}
		self.owner.ident = (self.owner.ident + TRUE);
		newwiz = spawn ();
		newwiz.classname = "monster_wizard";
		newwiz.origin = (self.origin + '0 0 10');
		newwiz.solid = MOVETYPE_WALK;
		newwiz.movetype = MOVETYPE_STEP;
		setmodel (newwiz, "progs/wizard.mdl");
		setsize (newwiz, VEC_HULL_MIN, '16 16 40');
		newwiz.health = 80;
		newwiz.th_stand = wiz_stand1;
		newwiz.th_walk = wiz_walk1;
		newwiz.th_run = wiz_run1;
		newwiz.th_missile = Wiz_Missile;
		newwiz.th_pain = Wiz_Pain;
		newwiz.th_die = wiz_die;
		tempvec = self.velocity;
		tempvec_z = FALSE;
		newwiz.angles = vectoangles (tempvec);
		newwiz.enemy = self.owner.enemy;
		newwiz.yaw_speed = 20;
		newwiz.takedamage = FL_SWIM;
		newwiz.temp6 = TRUE;
		newwiz.nextthink = (time + 0.1);
		newwiz.think = wiz_run1;
		spawn_tfog (newwiz.origin);
		newwiz.flags = (newwiz.flags | TRUE);
		newwiz.flags = (newwiz.flags | FL_MONSTER);
		total_monsters = total_monsters + TRUE;
		update_monster ();
	}
	SUB_Remove ();
};
//END
