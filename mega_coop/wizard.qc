void () bounce_b =
{
	self.velocity = bounce_off_wall( self );
	self.nextthink = time + 15;
	if (self.velocity == '0 0 0')
		dremove(self);
};
void (entity missile, float mspeed, float accuracy) LaunchMissile =
{
	local vector vec;
	local vector move;
	local float fly;
	makevectors (self.angles);
	vec = (((self.enemy.origin + self.enemy.mins) + (self.enemy.size * 0.7)) - missile.origin);
	fly = (vlen (vec) / mspeed);
	move = self.enemy.velocity;
	move_z = false;
	vec = (vec + (move * fly));
	vec = normalize (vec);
	vec = ((vec + ((accuracy * v_up) * (random () - 0.5))) + ((accuracy * v_right) * (random () - 0.5)));
	missile.attack_finished = 3;
	missile.velocity = (vec * mspeed);
	missile.angles = VEC_ORIGIN;
	missile.angles_y = vectoyaw (missile.velocity);
	missile.nextthink = (time + MOVETYPE_FLY);
	missile.think = SUB_Remove;
};
void () wiz_run1;
void () wiz_side1;
float () WizardCheckAttack =
{
	local vector spot1;
	local vector spot2;
	local entity targ;
	local float chance;
	if ((time < self.attack_finished))
	{
		return (false);
	}
	if (!enemy_vis)
	{
		return (false);
	}
	if ((enemy_range == RANGE_FAR))
	{
		if ((self.attack_state != AS_STRAIGHT))
		{
			self.attack_state = AS_STRAIGHT;
			wiz_run1 ();
		}
		return (false);
	}
	targ = self.enemy;
	spot1 = (self.origin + self.view_ofs);
	spot2 = (targ.origin + targ.view_ofs);
	traceline (spot1, spot2, false, self);
	if ((trace_ent != targ))
	{
		if ((self.attack_state != AS_STRAIGHT))
		{
			self.attack_state = AS_STRAIGHT;
			wiz_run1 ();
		}
		return (false);
	}
	if ((enemy_range == RANGE_MELEE))
	{
		chance = 0.9;
	}
	else
	{
		if ((enemy_range == RANGE_NEAR))
		{
			chance = 0.6;
		}
		else
		{
			if ((enemy_range == RANGE_MID))
			{
				chance = 0.2;
			}
			else
			{
				chance = false;
			}
		}
	}
	if ((random () < chance))
	{
		self.attack_state = AS_MISSILE;
		return (true);
	}
	if ((enemy_range == RANGE_MID))
	{
		if ((self.attack_state != AS_STRAIGHT))
		{
			self.attack_state = AS_STRAIGHT;
			wiz_run1 ();
		}
	}
	else
	{
		if ((self.attack_state != AS_SLIDING))
		{
			self.attack_state = AS_SLIDING;
			wiz_side1 ();
		}
	}
	return (false);
};
void () WizardAttackFinished =
{
	if (((enemy_range >= RANGE_MID) || !enemy_vis))
	{
		self.attack_state = AS_STRAIGHT;
		self.think = wiz_run1;
	}
	else
	{
		self.attack_state = AS_SLIDING;
		self.think = wiz_side1;
	}
};
void () Wiz_FastFire =
{
	local vector vec;
	local vector dst;
	local entity oself;
	if ((self.owner.health > false))
	{
		oself = self;
		self = self.owner;
		muzzleflash ();
		self = oself;
		makevectors (self.enemy.angles);
		dst = (self.enemy.origin - (TE_LIGHTNINGBLOOD * self.movedir));
		vec = normalize ((dst - self.origin));
		sound (self, CHAN_WEAPON, "wizard/wattack.wav", true, ATTN_NORM);
		self = self.owner;		
		launch_spike (oself.origin, vec);
		if (self.weapon & MWEAPON_BOUNCEMISSILE)
			newmis.velocity = (vec * 1200);
		else
			newmis.velocity = (vec * 1400);
		newmis.owner = self.owner;
		newmis.classname = "wizspike";
		setmodel (newmis, "progs/w_spike.mdl");
		setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
		self = oself;
	}
	remove (self);
};
void () Wiz_StartFast =
{
	local entity missile;
	sound (self, CHAN_WEAPON, "wizard/wattack.wav", true, ATTN_NORM);
	self.v_angle = self.angles;
	makevectors (self.angles);
	missile = spawn ();
	missile.owner = self;
	missile.nextthink = (time + 0.6);
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, (((self.origin + '0 0 30') + (v_forward * 14)) + (v_right * 14)));
	missile.enemy = self.enemy;
	missile.nextthink = (time + 0.8);
	missile.think = Wiz_FastFire;
	missile.movedir = v_right;
	missile = spawn ();
	missile.owner = self;
	missile.nextthink = (time + true);
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (missile, (((self.origin + '0 0 30') + (v_forward * 14)) + (v_right * -14)));
	missile.enemy = self.enemy;
	missile.nextthink = (time + 0.3);
	missile.think = Wiz_FastFire;
	missile.movedir = (VEC_ORIGIN - v_right);
};
void () Wiz_idlesound =
{
	local float wr;
	wr = (random () * MOVETYPE_FLY);
	if ((self.waitmin < time))
	{
		self.waitmin = (time + FL_SWIM);
		if ((wr > 4.5))
		{
			sound (self, CHAN_VOICE, "wizard/widle1.wav", true, ATTN_IDLE);
		}
		if ((wr < 1.5))
		{
			sound (self, CHAN_VOICE, "wizard/widle2.wav", true, ATTN_IDLE);
		}
	}
	return;
};
void () wiz_stand1 = [ 0, wiz_stand2 ]
{
	ai_stand ();
};
void () wiz_stand2 = [ 1, wiz_stand3 ]
{
	ai_stand ();
};
void () wiz_stand3 = [ 2, wiz_stand4 ]
{
	ai_stand ();
};
void () wiz_stand4 = [ 3, wiz_stand5 ]
{
	ai_stand ();
};
void () wiz_stand5 = [ 4, wiz_stand6 ]
{
	ai_stand ();
};
void () wiz_stand6 = [ 5, wiz_stand7 ]
{
	ai_stand ();
};
void () wiz_stand7 = [ 6, wiz_stand8 ]
{
	ai_stand ();
};
void () wiz_stand8 = [ 7, wiz_stand1 ]
{
	ai_stand ();
};
void () wiz_walk1 = [ 0, wiz_walk2 ]
{
	ai_walk (FL_CLIENT);
	Wiz_idlesound ();
};
void () wiz_walk2 = [ 1, wiz_walk3 ]
{
	ai_walk (FL_CLIENT);
};
void () wiz_walk3 = [ 2, wiz_walk4 ]
{
	ai_walk (FL_CLIENT);
};
void () wiz_walk4 = [ 3, wiz_walk5 ]
{
	ai_walk (FL_CLIENT);
};
void () wiz_walk5 = [ 4, wiz_walk6 ]
{
	ai_walk (FL_CLIENT);
};
void () wiz_walk6 = [ 5, wiz_walk7 ]
{
	ai_walk (FL_CLIENT);
};
void () wiz_walk7 = [ 6, wiz_walk8 ]
{
	ai_walk (FL_CLIENT);
};
void () wiz_walk8 = [ 7, wiz_walk1 ]
{
	ai_walk (FL_CLIENT);
};
void () wiz_side1 = [ 0, wiz_side2 ]
{
	ai_run (FL_CLIENT);
	Wiz_idlesound ();
};
void () wiz_side2 = [ 1, wiz_side3 ]
{
	ai_run (FL_CLIENT);
};
void () wiz_side3 = [ 2, wiz_side4 ]
{
	ai_run (FL_CLIENT);
};
void () wiz_side4 = [ 3, wiz_side5 ]
{
	ai_run (FL_CLIENT);
};
void () wiz_side5 = [ 4, wiz_side6 ]
{
	ai_run (FL_CLIENT);
};
void () wiz_side6 = [ 5, wiz_side7 ]
{
	ai_run (FL_CLIENT);
};
void () wiz_side7 = [ 6, wiz_side8 ]
{
	ai_run (FL_CLIENT);
};
void () wiz_side8 = [ 7, wiz_side1 ]
{
	ai_run (FL_CLIENT);
};
void () wiz_run1 = [ 15, wiz_run2 ]
{
	ai_run (FL_INWATER);
	Wiz_idlesound ();
};
void () wiz_run2 = [ 16, wiz_run3 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run3 = [ 17, wiz_run4 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run4 = [ 18, wiz_run5 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run5 = [ 19, wiz_run6 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run6 = [ 20, wiz_run7 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run7 = [ 21, wiz_run8 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run8 = [ 22, wiz_run9 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run9 = [ 23, wiz_run10 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run10 = [ 24, wiz_run11 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run11 = [ 25, wiz_run12 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run12 = [ 26, wiz_run13 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run13 = [ 27, wiz_run14 ]
{
	ai_run (FL_INWATER);
};
void () wiz_run14 = [ 28, wiz_run1 ]
{
	ai_run (FL_INWATER);
};
void () wiz_fast1 = [ 29, wiz_fast2 ]
{
	ai_face ();
	Wiz_StartFast ();
};
void () wiz_fast2 = [ 30, wiz_fast3 ]
{
	ai_face ();
};
void () wiz_fast3 = [ 31, wiz_fast4 ]
{
	ai_face ();
};
void () wiz_fast4 = [ 32, wiz_fast5 ]
{
	ai_face ();
};
void () wiz_fast5 = [ 33, wiz_fast6 ]
{
	ai_face ();
};
void () wiz_fast6 = [ 34, wiz_fast7 ]
{
	ai_face ();
};
void () wiz_fast7 = [ 33, wiz_fast8 ]
{
	ai_face ();
};
void () wiz_fast8 = [ 32, wiz_fast9 ]
{
	ai_face ();
};
void () wiz_fast9 = [ 31, wiz_fast10 ]
{
	ai_face ();
};
void () wiz_fast10 = [ 30, wiz_run1 ]
{
	ai_face ();
	SUB_AttackFinished (FL_SWIM);
	WizardAttackFinished ();
};
void () wiz_pain1 = [ 42, wiz_pain2 ]
{};
void () wiz_pain2 = [ 43, wiz_pain3 ]
{};
void () wiz_pain3 = [ 44, wiz_pain4 ]
{};
void () wiz_pain4 = [ 45, wiz_run1 ]
{};
void () wiz_death1 = [ 46, wiz_death2 ]
{
	self.velocity_x = (-200 + (400 * random ()));
	self.velocity_y = (-200 + (400 * random ()));
	self.velocity_z = (100 + (100 * random ()));
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	sound (self, CHAN_VOICE, "wizard/wdeath.wav", true, ATTN_NORM);
};
void () wiz_death2 = [ 47, wiz_death3 ]
{};
void () wiz_death3 = [ 48, wiz_death4 ]
{
	self.solid = SOLID_NOT;
};
void () wiz_death4 = [ 49, wiz_death5 ]
{};
void () wiz_death5 = [ 50, wiz_death6 ]
{};
void () wiz_death6 = [ 51, wiz_death7 ]
{};
void () wiz_death7 = [ 52, wiz_death8 ]
{};
void () wiz_death8 = [ 53, wiz_death8 ]
{};
void () wiz_die =
{
	if ((self.health < -40))
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", true, ATTN_NORM);
		ThrowHead (mtf_savemodel("progs/h_wizard.mdl"), self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		return;
	}
	wiz_death1 ();
};
void () Wiz_Pain =
{
	sound (self, CHAN_VOICE, "wizard/wpain.wav", true, ATTN_NORM);
	wiz_pain1 ();
};
void () Wiz_Missile =
{
	wiz_fast1 ();
};
void () monster_wizard1 =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
#ifdef mtf_coop_halloween
	setmodel (self, "progs/wizard_ghost.mdl");
#else
	setmodel (self, "progs/wizard.mdl");
#endif
	setsize (self, VEC_HULL_MIN, '16 16 40');
	self.health = MTF_Monster_Health(80);
	self.th_stand = wiz_stand1;
	self.th_walk = wiz_walk1;
	self.th_run = wiz_run1;
	self.th_missile = Wiz_Missile;
	self.th_pain = Wiz_Pain;
	self.th_die = wiz_die;
	coop_flymonster_start ();
};
void () monster_wizard =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
#ifdef mtf_coop_halloween
	precache_model ("progs/wizard_ghost.mdl");
#else
	precache_model ("progs/wizard.mdl");
#endif
	precache_model (mtf_savemodel("progs/h_wizard.mdl"));
	precache_model ("progs/w_spike.mdl");
	precache_sound2 ("wizard/hit.wav");
	precache_sound2 ("wizard/wattack.wav");
	precache_sound2 ("wizard/wdeath.wav");
	precache_sound2 ("wizard/widle1.wav");
	precache_sound2 ("wizard/widle2.wav");
	precache_sound2 ("wizard/wpain.wav");
	precache_sound2 ("wizard/wsight.wav");
	self.netname = "scrag";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_wizard1;
	COOP_SetLives ();
	monster_wizard1 ();
};
//END
