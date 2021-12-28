void () azoth_run2;
void () azoth_stand2;
void () rift_hold;
void () azoth_stand1 = [ 0, azoth_stand2 ]
{
	ai_stand ();
};
void () azoth_stand3;
void () azoth_stand2 = [ 1, azoth_stand3 ]
{
	ai_stand ();
};
void () azoth_stand4;
void () azoth_stand3 = [ 2, azoth_stand4 ]
{
	ai_stand ();
};
void () azoth_stand5;
void () azoth_stand4 = [ 3, azoth_stand5 ]
{
	ai_stand ();
};
void () azoth_stand6;
void () azoth_stand5 = [ 4, azoth_stand6 ]
{
	ai_stand ();
};
void () azoth_stand7;
void () azoth_stand6 = [ 5, azoth_stand7 ]
{
	ai_stand ();
};
void () azoth_stand8;
void () azoth_stand7 = [ 6, azoth_stand8 ]
{
	ai_stand ();
};
void () azoth_stand9;
void () azoth_stand8 = [ 7, azoth_stand9 ]
{
	ai_stand ();
};
void () azoth_stand10;
void () azoth_stand9 = [ 8, azoth_stand10 ]
{
	ai_stand ();
};
void () azoth_stand11;
void () azoth_stand10 = [ 9, azoth_stand11 ]
{
	ai_stand ();
};
void () azoth_stand11 = [ 10, azoth_stand1 ]
{
	ai_stand ();
};
void () azoth_walk2;
void () azoth_walk1 = [ 11, azoth_walk2 ]
{
	ai_walk (FL_INWATER);
};
void () azoth_walk3;
void () azoth_walk2 = [ 12, azoth_walk3 ]
{
	ai_walk (FL_INWATER);
};
void () azoth_walk4;
void () azoth_walk3 = [ 13, azoth_walk4 ]
{
	ai_walk (FL_INWATER);
};
void () azoth_walk5;
void () azoth_walk4 = [ 14, azoth_walk5 ]
{
	ai_walk (MOVETYPE_BOUNCE);
};
void () azoth_walk6;
void () azoth_walk5 = [ 15, azoth_walk6 ]
{
	ai_walk (17);
};
void () azoth_walk7;
void () azoth_walk6 = [ 16, azoth_walk7 ]
{
	ai_walk (11);
};
void () azoth_walk8;
void () azoth_walk7 = [ 17, azoth_walk8 ]
{
	ai_walk (20);
};
void () azoth_walk9;
void () azoth_walk8 = [ 18, azoth_walk9 ]
{
	ai_walk (26);
};
void () azoth_walk10;
void () azoth_walk9 = [ 19, azoth_walk10 ]
{
	ai_walk (14);
};
void () azoth_walk11;
void () azoth_walk10 = [ 20, azoth_walk11 ]
{
	ai_walk (FL_INWATER);
};
void () azoth_walk12;
void () azoth_walk11 = [ 21, azoth_walk12 ]
{
	ai_walk (MOVETYPE_BOUNCE);
};
void () azoth_walk12 = [ 22, azoth_walk1 ]
{
	ai_walk (14);
};
void () azoth_out1 = [ 11, azoth_out2 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
	movetogoal (FL_INWATER);
};
void () azoth_out2 = [ 12, azoth_out3 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
	movetogoal (FL_INWATER);
};
void () azoth_out3 = [ 13, azoth_out4 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
	movetogoal (FL_INWATER);
};
void () azoth_out4 = [ 14, azoth_out5 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
	movetogoal (MOVETYPE_BOUNCE);
};
void () azoth_out5 = [ 15, azoth_out6 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
	movetogoal (17);
};
void () azoth_out6 = [ 16, azoth_stand1 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
	self.th_stand = azoth_stand1;
};
void () azoth_run1 = [ 11, azoth_run2 ]
{
	ai_run (FL_INWATER);
};
void () azoth_run3;
void () azoth_run2 = [ 12, azoth_run3 ]
{
	ai_run (FL_INWATER);
};
void () azoth_run4;
void () azoth_run3 = [ 13, azoth_run4 ]
{
	ai_run (FL_INWATER);
};
void () azoth_run5;
void () azoth_run4 = [ 14, azoth_run5 ]
{
	ai_run (MOVETYPE_BOUNCE);
};
void () azoth_run6;
void () azoth_run5 = [ 15, azoth_run6 ]
{
	ai_run (17);
};
void () azoth_run7;
void () azoth_run6 = [ 16, azoth_run7 ]
{
	ai_run (11);
};
void () azoth_run8;
void () azoth_run7 = [ 17, azoth_run8 ]
{
	ai_run (20);
};
void () azoth_run9;
void () azoth_run8 = [ 18, azoth_run9 ]
{
	ai_run (26);
};
void () azoth_run10;
void () azoth_run9 = [ 19, azoth_run10 ]
{
	ai_run (14);
};
void () azoth_run11;
void () azoth_run10 = [ 20, azoth_run11 ]
{
	ai_run (FL_INWATER);
};
void () azoth_run12;
void () azoth_run11 = [ 21, azoth_run12 ]
{
	ai_run (MOVETYPE_BOUNCE);
};
void () azoth_run12 = [ 22, azoth_run1 ]
{
	ai_run (14);
};
void () azoth_s_charge1;
void () azoth_swipe1;
void () azoth_s_run1;
float () check_chargerange =
{
	local float h;
	h = self.enemy.absmin_z - self.absmin_z;
	if (((vlen ((self.enemy.origin - self.pos2)) < 700) && (fabs (h) < 48)))
	{
		if ((self.bubble_count > 20))
		{
			return (TRUE);
		}
		else
		{
			self.bubble_count = (self.bubble_count + FL_SWIM);
		}
	}
	return (FALSE);
};
void () azoth_s_stand_think =
{
	if (check_chargerange ())
	{
		azoth_s_charge1 ();
		return;
	}
	self.takedamage = FALSE;
	ai_face ();
	if ((self.bubble_count < FALSE))
	{
		self.bubble_count = FL_SWIM;
	}
	walkmove (FALSE, FALSE);
};
void () azoth_s_stand2;
void () azoth_s_stand1 = [ 167, azoth_s_stand2 ]
{
	azoth_s_stand_think ();
	if (((random () < 0.3) && (self.waitmin < time)))
	{
		sound (self, FL_SWIM, "azoth/pain.wav", TRUE, MOVETYPE_STEP);
		self.waitmin = (time + MOVETYPE_PUSH);
	}
};
void () azoth_s_stand3;
void () azoth_s_stand2 = [ 168, azoth_s_stand3 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand4;
void () azoth_s_stand3 = [ 169, azoth_s_stand4 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand5;
void () azoth_s_stand4 = [ 170, azoth_s_stand5 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand6;
void () azoth_s_stand5 = [ 171, azoth_s_stand6 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand7;
void () azoth_s_stand6 = [ 172, azoth_s_stand7 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand8;
void () azoth_s_stand7 = [ 173, azoth_s_stand8 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand9;
void () azoth_s_stand8 = [ 174, azoth_s_stand9 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand10;
void () azoth_s_stand9 = [ 175, azoth_s_stand10 ]
{
	azoth_s_stand_think ();
};
void () azoth_s_stand10 = [ 176, azoth_s_stand1 ]
{
	azoth_s_stand_think ();
};
void (float dist) shield_run =
{
	local float facing;
	if (!IsAlive (self.enemy))
	{
		self.th_stand ();
	}
	if (check_chargerange ())
	{
		azoth_s_charge1 ();
		return;
	}
	if ((vlen ((self.origin - self.pos2)) < 280))
	{
		azoth_s_stand1 ();
		return;
	}
	facing = vectoyaw ((self.pos2 - self.origin));
	walkmove (facing, dist);
	ai_face ();
	if ((self.bubble_count < FALSE))
	{
		self.bubble_count = FL_SWIM;
	}
};
void () azoth_s_run1 = [ 23, azoth_s_run2 ]
{
	shield_run (FL_INWATER);
	self.takedamage = FALSE;
};
void () azoth_s_run3;
void () azoth_s_run2 = [ 24, azoth_s_run3 ]
{
	shield_run (FL_INWATER);
	self.takedamage = FALSE;
};
void () azoth_s_run4;
void () azoth_s_run3 = [ 25, azoth_s_run4 ]
{
	shield_run (FL_INWATER);
	self.takedamage = FALSE;
};
void () azoth_s_run5;
void () azoth_s_run4 = [ 26, azoth_s_run5 ]
{
	shield_run (MOVETYPE_BOUNCE);
	self.takedamage = FALSE;
};
void () azoth_s_run6;
void () azoth_s_run5 = [ 27, azoth_s_run6 ]
{
	shield_run (17);
	self.takedamage = FALSE;
};
void () azoth_s_run7;
void () azoth_s_run6 = [ 28, azoth_s_run7 ]
{
	shield_run (11);
	self.takedamage = FALSE;
};
void () azoth_s_run8;
void () azoth_s_run7 = [ 29, azoth_s_run8 ]
{
	shield_run (20);
	self.takedamage = FALSE;
};
void () azoth_s_run9;
void () azoth_s_run8 = [ 30, azoth_s_run9 ]
{
	shield_run (26);
	self.takedamage = FALSE;
};
void () azoth_s_run10;
void () azoth_s_run9 = [ 31, azoth_s_run10 ]
{
	shield_run (14);
	self.takedamage = FALSE;
};
void () azoth_s_run11;
void () azoth_s_run10 = [ 32, azoth_s_run11 ]
{
	shield_run (FL_INWATER);
	self.takedamage = FALSE;
};
void () azoth_s_run12;
void () azoth_s_run11 = [ 33, azoth_s_run12 ]
{
	shield_run (MOVETYPE_BOUNCE);
	self.takedamage = FALSE;
};
void () azoth_s_run12 = [ 34, azoth_s_run1 ]
{
	shield_run (14);
	self.takedamage = FALSE;
};
void (float dist) shield_charge =
{
	local float facing;
	local float unstuck;
	facing = vectoyaw ((self.enemy.origin - self.origin));
	unstuck = walkmove (facing, dist);
	if ((vlen ((self.enemy.origin - self.origin)) < 91))
	{
		azoth_swipe1 ();
		return;
	}
	if ((!unstuck || (vlen ((self.enemy.origin - self.pos2)) > 800)))
	{
		self.bubble_count = (self.bubble_count - 20);
		self.think = azoth_s_run1;
	}
	ai_face ();
	self.bubble_count = (self.bubble_count - TRUE);
};
void () azoth_s_charge1 = [ 23, azoth_s_charge2 ]
{
	shield_charge (SVC_INTERMISSION);
	self.takedamage = FALSE;
};
void () azoth_die;
void () azoth_s_charge3;
void () azoth_s_charge2 = [ 24, azoth_s_charge3 ]
{
	shield_charge (24);
	self.takedamage = FALSE;
	sound (self, FL_SWIM, "azoth/awake.wav", TRUE, TRUE);
};
void () azoth_s_charge4;
void () azoth_s_charge3 = [ 25, azoth_s_charge4 ]
{
	shield_charge (24);
	self.takedamage = FALSE;
};
void () azoth_s_charge6;
void () azoth_s_charge4 = [ 27, azoth_s_charge6 ]
{
	shield_charge (MOVETYPE_BOUNCE);
	self.takedamage = FALSE;
};
void () azoth_s_charge8;
void () azoth_s_charge6 = [ 29, azoth_s_charge8 ]
{
	shield_charge (45);
	self.takedamage = FALSE;
};
void () azoth_s_charge9;
void () azoth_s_charge8 = [ 30, azoth_s_charge9 ]
{
	shield_charge (39);
	self.takedamage = FALSE;
};
void () azoth_s_charge10;
void () azoth_s_charge9 = [ 31, azoth_s_charge10 ]
{
	shield_charge (21);
	self.takedamage = FALSE;
};
void () azoth_s_charge11;
void () azoth_s_charge10 = [ 33, azoth_s_charge11 ]
{
	shield_charge (39);
	self.takedamage = FALSE;
};
void () azoth_s_charge12;
void () azoth_s_charge11 = [ 23, azoth_s_charge12 ]
{
	shield_charge (45);
	self.takedamage = FALSE;
};
void () azoth_s_charge12 = [ 24, azoth_s_charge3 ]
{
	shield_charge (24);
	self.takedamage = FALSE;
};
void () azoth_swipe2;
void () azoth_swipe1 = [ 35, azoth_swipe2 ]
{
	ai_charge (20);
};
void () azoth_swipe3;
void () azoth_swipe2 = [ 36, azoth_swipe3 ]
{
	ai_face ();
};
void () azoth_swipe3 = [ 37, azoth_swipe4 ]
{
	local vector delta;
	ai_face ();
	self.takedamage = FL_SWIM;
	if (!self.enemy)
	{
		return;
	}
	delta = self.enemy.origin - self.origin;
	if (((vlen (delta) > 100) && (self.th_die == azoth_die)))
	{
		self.think = azoth_fire1;
	}
};
void () azoth_swipe5;
void () azoth_swipe4 = [ 38, azoth_swipe5 ]
{
	ai_face ();
};
void () azoth_swipe6;
void () azoth_swipe5 = [ 39, azoth_swipe6 ]
{
	ai_face ();
};
void () azoth_swipe7;
void () azoth_swipe6 = [ 40, azoth_swipe7 ]
{
	ai_face ();
};
void () azoth_swipe8;
void () azoth_swipe7 = [ 41, azoth_swipe8 ]
{
	ai_face ();
};
void () azoth_swipe9;
void () azoth_swipe8 = [ 42, azoth_swipe9 ]
{
	ai_face ();
};
void () azoth_swipe10;
void () azoth_swipe9 = [ 43, azoth_swipe10 ]
{
	ai_face ();
};
void () azoth_swipe10 = [ 44, azoth_swipe11 ]
{
	local vector delta;
	local float ldmg;
	ai_charge (20);
	if (!self.enemy)
	{
		return;
	}
	delta = self.enemy.origin - self.origin;
	if ((vlen (delta) > 180))
	{
		return;
	}
	if (!CanDamage (self.enemy, self))
	{
		return;
	}
	ldmg = 13 + (random () * 13);
	T_Damage (self.enemy, self, self, ldmg);
};
void () azoth_swipe11 = [ 45, azoth_swipe12 ]
{
	local vector delta;
	local float ldmg;
	ai_charge (MOVETYPE_BOUNCE);
	if (!self.enemy)
	{
		return;
	}
	delta = self.enemy.origin - self.origin;
	if ((vlen (delta) > 180))
	{
		return;
	}
	if (!CanDamage (self.enemy, self))
	{
		return;
	}
	ldmg = 13 + (random () * 13);
	T_Damage (self.enemy, self, self, ldmg);
};
void () azoth_swipe13;
void () azoth_swipe12 = [ 46, azoth_swipe13 ]
{
	ai_face ();
};
void () azoth_swipe14;
void () azoth_swipe13 = [ 47, azoth_swipe14 ]
{
	ai_face ();
};
void () azoth_swipe15;
void () azoth_swipe14 = [ 48, azoth_swipe15 ]
{
	ai_face ();
};
void () azoth_swipe16;
void () azoth_swipe15 = [ 49, azoth_swipe16 ]
{
	ai_face ();
};
void () azoth_swipe17;
void () azoth_swipe16 = [ 50, azoth_swipe17 ]
{
	ai_face ();
	self.takedamage = FALSE;
};
void () azoth_swipe17 = [ 51, azoth_s_run1 ]
{
	ai_face ();
	if (!(self.flags & FL_ONGROUND))
	{
		self.think = azoth_land2;
	}
};
void () azoth_deflect2;
void () azoth_deflect1 = [ 49, azoth_deflect2 ]
{
	ai_charge (26);
};
void () azoth_deflect3;
void () azoth_deflect2 = [ 50, azoth_deflect3 ]
{
	ai_charge (26);
	self.takedamage = FALSE;
};
void () azoth_deflect4;
void () azoth_deflect3 = [ 51, azoth_deflect4 ]
{
	ai_charge (26);
};
void () azoth_deflect5;
void () azoth_deflect4 = [ 30, azoth_deflect5 ]
{
	ai_charge (36);
	self.takedamage = FALSE;
};
void () azoth_deflect6;
void () azoth_deflect5 = [ 31, azoth_deflect6 ]
{
	ai_charge (24);
	self.takedamage = FALSE;
};
void () azoth_deflect7;
void () azoth_deflect6 = [ 32, azoth_deflect7 ]
{
	ai_charge (26);
	self.takedamage = FALSE;
};
void () azoth_deflect8;
void () azoth_deflect7 = [ 33, azoth_deflect8 ]
{
	ai_charge (20);
	self.takedamage = FALSE;
};
void () azoth_deflect9;
void () azoth_deflect8 = [ 34, azoth_deflect9 ]
{
	ai_charge (24);
	self.takedamage = FALSE;
};
void () azoth_deflect10;
void () azoth_deflect9 = [ 35, azoth_deflect10 ]
{
	ai_charge (SVC_INTERMISSION);
};
void () azoth_deflect11;
void () azoth_deflect10 = [ 36, azoth_deflect11 ]
{
	ai_charge (26);
	self.takedamage = FL_SWIM;
};
void () azoth_deflect11 = [ 37, azoth_run1 ]
{
	ai_charge (20);
};
void () azoth_hammer2;
void () azoth_hammer1 = [ 66, azoth_hammer2 ]
{
	ai_face ();
};
void () azoth_hammer3;
void () azoth_hammer2 = [ 67, azoth_hammer3 ]
{
	ai_face ();
};
void () azoth_hammer4;
void () azoth_hammer3 = [ 68, azoth_hammer4 ]
{
	ai_face ();
};
void () azoth_hammer5;
void () azoth_hammer4 = [ 69, azoth_hammer5 ]
{
	ai_charge (MOVETYPE_FLY);
};
void () azoth_hammer6;
void () azoth_hammer5 = [ 70, azoth_hammer6 ]
{
	ai_charge (15);
};
void () azoth_hammer6 = [ 71, azoth_hammer7 ]
{
	local vector delta;
	local float ldmg;
	ai_charge (35);
	if (!self.enemy)
	{
		return;
	}
	sound (self, FL_SWIM, "azoth/thud.wav", TRUE, TRUE);
	delta = self.enemy.origin - self.origin;
	if ((vlen (delta) > 150))
	{
		return;
	}
	if (!CanDamage (self.enemy, self))
	{
		return;
	}
	ldmg = SVC_INTERMISSION + (random () * 40);
	T_Damage (self.enemy, self, self, ldmg);
};
void () azoth_hammer8;
void () azoth_hammer7 = [ 72, azoth_hammer8 ]
{
	ai_charge (MOVETYPE_BOUNCE);
};
void () azoth_hammer9;
void () azoth_hammer8 = [ 73, azoth_hammer9 ]
{
	ai_charge (MOVETYPE_FLY);
};
void () azoth_hammer10;
void () azoth_hammer9 = [ 74, azoth_hammer10 ]
{
	ai_charge (MOVETYPE_FLY);
};
void () azoth_hammer10 = [ 75, azoth_run1 ]
{
	ai_charge (MOVETYPE_BOUNCE);
	if (!(self.flags & FL_ONGROUND))
	{
		self.think = azoth_land2;
	}
};
void () flame_burn =
{
	self.velocity = '0 0 100';
	self.solid = FALSE;
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	s_explode1 ();
};
void () flame_move =
{
	local vector o;
	local vector v;
	o = self.origin - '0 0 7';
	v = self.pos1;
	traceline ((o - (v * 0.5)), (o + v), FALSE, self);
	o = (trace_plane_normal * (v * trace_plane_normal)) - v;
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	self.velocity = ((o * -650) + '0 0 1');
	self.pos1 = normalize (self.velocity);
	self.nextthink = (time + 0.5);
	self.think = flame_burn;
};
void () flame_touch =
{
	if ((other.solid != MOVETYPE_STEP))
	{
		if (other.takedamage)
		{
			T_Damage (other, self, self.owner, FL_INWATER);
		}
		flame_burn ();
		return;
	}
	self.nextthink = (time + 0.05);
	self.think = flame_move;
	self.frame = FL_SWIM;
};
void () flame_2 =
{
	self.frame = FL_SWIM;
	self.nextthink = (time + 1.8);
	self.think = flame_burn;
};
void () flame_1 =
{
	self.frame = TRUE;
	self.nextthink = (time + 0.1);
	self.think = flame_2;
};
void (vector org, vector dir) launch_flame =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = FL_SWIM;
	newmis.angles = vectoangles (dir);
	newmis.touch = flame_touch;
	newmis.classname = "flame";
	newmis.think = flame_1;
	newmis.nextthink = (time + 0.1);
	setmodel (newmis, "progs/s_flame.spr");
	setsize (newmis, '0 0 -7', '0 0 16');
	setorigin (newmis, org);
	newmis.velocity = (dir * 950);
	newmis.pos1 = dir;
};
void (vector head) breathe_fire =
{
	makevectors ((self.angles + head));
	launch_flame (((self.origin + '0 0 100') + (v_forward * 34)), ((v_forward * 0.8) - ('0 0 3' * 0.2)));
};
void () azoth_fire1 = [ 52, azoth_fire2 ]
{
	ai_face ();
};
void () azoth_fire3;
void () azoth_fire2 = [ 53, azoth_fire3 ]
{
	ai_face ();
};
void () azoth_fire4;
void () azoth_fire3 = [ 54, azoth_fire4 ]
{
	ai_face ();
};
void () azoth_fire4 = [ 55, azoth_fire5 ]
{
	sound (self, FL_SWIM, "azoth/fire.wav", TRUE, TRUE);
	self.pos1 = (self.enemy.origin + (self.enemy.velocity * 0.7));
	self.ideal_yaw = vectoyaw ((self.pos1 - self.origin));
	ChangeYaw ();
};
void () azoth_fire5 = [ 56, azoth_fire6 ]
{
	self.ideal_yaw = vectoyaw ((self.pos1 - self.origin));
	ChangeYaw ();
};
void () azoth_fire6b;
void () azoth_fire6 = [ 57, azoth_fire6b ]
{
	breathe_fire ('0 -20 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire7;
void () azoth_fire6b = [ 57, azoth_fire7 ]
{
	breathe_fire ('0 -18 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire7b;
void () azoth_fire7 = [ 58, azoth_fire7b ]
{
	ai_forward (MOVETYPE_BOUNCE);
	breathe_fire ('0 -15 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire8;
void () azoth_fire7b = [ 58, azoth_fire8 ]
{
	breathe_fire ('0 -11 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire8b;
void () azoth_fire8 = [ 59, azoth_fire8b ]
{
	breathe_fire ('0 -8 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire9;
void () azoth_fire8b = [ 59, azoth_fire9 ]
{
	breathe_fire ('0 -4 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire9b;
void () azoth_fire9 = [ 60, azoth_fire9b ]
{
	breathe_fire (VEC_ORIGIN);
	self.nextthink = (time + 0.05);
};
void () azoth_fire10;
void () azoth_fire9b = [ 60, azoth_fire10 ]
{
	breathe_fire ('0 3 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire10b;
void () azoth_fire10 = [ 61, azoth_fire10b ]
{
	breathe_fire ('0 7 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire11;
void () azoth_fire10b = [ 61, azoth_fire11 ]
{
	breathe_fire ('0 11 0');
	self.nextthink = (time + 0.05);
};
void () azoth_fire12;
void () azoth_fire11 = [ 62, azoth_fire12 ]
{
	breathe_fire ('0 15 0');
};
void () azoth_fire13;
void () azoth_fire12 = [ 63, azoth_fire13 ]
{
	ai_face ();
};
void () azoth_fire14;
void () azoth_fire13 = [ 64, azoth_fire14 ]
{
	ai_charge (MOVETYPE_STEP);
};
void () azoth_fire14 = [ 65, azoth_run1 ]
{
	ai_charge (MOVETYPE_TOSS);
	if (!(self.flags & FL_ONGROUND))
	{
		self.think = azoth_land2;
	}
	else
	{
		if ((self.th_die == azoth_die))
		{
			self.think = azoth_swipe15;
		}
	}
};
void () skullearlymissiletouch =
{
	if (((other == self.owner) || (other == world)))
	{
		return;
	}
	T_RadiusDamage (self, self.owner, 50, world);
	sound (self, TRUE, "weapons/r_exp3.wav", TRUE, TRUE);
	WriteByte (FALSE, SVC_TEMPENTITY);
	WriteByte (FALSE, MOVETYPE_WALK);
	WriteCoord (FALSE, self.origin_x);
	WriteCoord (FALSE, self.origin_y);
	WriteCoord (FALSE, self.origin_z);
	if (self.goalentity)
	{
		remove (self.goalentity);
		self.goalentity = world;
	}
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = FALSE;
	s_explode1 ();
};
void () skullmissiletouch =
{
	if ((other == self.owner))
	{
		return;
	}
	T_RadiusDamage (self, self.owner, 50, world);
	sound (self, TRUE, "weapons/r_exp3.wav", TRUE, TRUE);
	WriteByte (FALSE, SVC_TEMPENTITY);
	WriteByte (FALSE, MOVETYPE_WALK);
	WriteCoord (FALSE, self.origin_x);
	WriteCoord (FALSE, self.origin_y);
	WriteCoord (FALSE, self.origin_z);
	if (self.goalentity)
	{
		remove (self.goalentity);
		self.goalentity = world;
	}
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = FALSE;
	s_explode1 ();
};
void () skull_makesolid =
{
	self.touch = skullmissiletouch;
	force_retouch = FL_SWIM;
};
void () azoth_throw_direct =
{
	local entity missile;
	local vector dir;
	local float r;
	makevectors (self.angles);
	r = vlen ((self.origin - self.enemy.origin));
	if ((self.enemy.origin_z > (self.origin_z + 20)))
	{
		dir = normalize (((((((self.enemy.origin + '0 0 15') - self.origin) - '0 0 160') - (v_forward * 14)) - (v_right * SVC_INTERMISSION)) + ((self.enemy.velocity - ('0 0 1' * self.enemy.velocity_z)) * (r / 800))));
	}
	else
	{
		dir = normalize (((((((self.enemy.origin - '0 0 15') - self.origin) - '0 0 160') - (v_forward * 14)) - (v_right * SVC_INTERMISSION)) + ((self.enemy.velocity - ('0 0 1' * self.enemy.velocity_z)) * (r / 800))));
	}
	sound (self, TRUE, "azoth/thwack.wav", TRUE, TRUE);
	missile = spawn ();
	missile.owner = self;
	missile.solid = FL_SWIM;
	missile.nextthink = (time + 0.2);
	missile.think = skull_makesolid;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/skull.mdl");
	setsize (missile, VEC_ORIGIN, VEC_ORIGIN);
	missile.origin = (((self.origin + '0 0 160') + (v_forward * 14)) + (v_right * SVC_INTERMISSION));
	missile.velocity = (dir * 800);
	missile.avelocity = '300 300 300';
	missile.touch = skullearlymissiletouch;
	self.angles_y = vectoyaw (dir);
};
void () skull_retarget =
{
	if ((other != self.goalentity))
	{
		return;
	}
	other.enemy = self.enemy;
	other.goalentity = world;
	self.nextthink = (time + 0.1);
	self.think = SUB_Remove;
	other.solid = FL_SWIM;
	setsize (other, '-4 -4 -4', '4 4 4');
};
void () skullhome =
{
	local vector dir;
	local vector vtemp;
	vtemp = self.enemy.origin + '0 0 10';
	if ((!IsAlive (self.enemy) && (self.enemy.classname != "homingpoint")))
	{
		if (self.goalentity)
		{
			remove (self.goalentity);
			self.goalentity = world;
		}
		remove (self);
		return;
	}
	dir = normalize ((vtemp - self.origin));
	if ((skill == MOVETYPE_WALK))
	{
		self.velocity = ((self.velocity * 0.4) + (dir * 300));
	}
	else
	{
		self.velocity = ((self.velocity * 0.5) + (dir * 225));
	}
	self.nextthink = (time + 0.2);
	self.think = skullhome;
};
void () skullhomemakesolid =
{
	self.solid = FL_SWIM;
	setsize (self, '-4 -4 -4', '4 4 4');
	self.nextthink = (time + 0.2);
	self.think = skullhome;
	force_retouch = FL_SWIM;
};
void () azoth_throw_indirect =
{
	local entity missile;
	local entity trigger;
	local vector pos;
	local float m;
	local float p;
	local float d;
	if ((self.th_die != azoth_phase7))
	{
		m = vectoyaw ((self.origin - tower));
		p = vectoyaw ((self.enemy.origin - tower));
		d = m - p;
		while ((d < -180))
		{
			d = d + 360;
		}
		while ((d > 180))
		{
			d = d - 360;
		}
		pos_y = m - (d * 0.5);
		makevectors (pos);
	}
	trigger = spawn ();
	missile = spawn ();
	trigger.solid = TRUE;
	trigger.classname = "homingpoint";
	setsize (trigger, '-16 -16 -16', '16 16 16');
	if ((self.th_die == azoth_phase7))
	{
		pos = ((self.enemy.origin * MOVETYPE_STEP) + self.origin) * 0.2;
		pos_z = 600;
		setorigin (trigger, pos);
	}
	else
	{
		setorigin (trigger, ((((v_forward * 1000) + tower) + (('0 0 1' * (self.enemy.origin_z + self.origin_z)) * 0.5)) + '0 0 24'));
	}
	trigger.touch = skull_retarget;
	trigger.enemy = self.enemy;
	trigger.goalentity = missile;
	missile.goalentity = trigger;
	trigger.health = 20;
	makevectors (self.angles);
	sound (self, TRUE, "azoth/thwack.wav", TRUE, TRUE);
	missile.owner = self;
	missile.solid = FALSE;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/skull.mdl");
	setsize (missile, '-4 -4 -4', '4 4 4');
	missile.origin = (((self.origin + '0 0 160') + (v_forward * 14)) + (v_right * SVC_INTERMISSION));
	if ((self.th_die == azoth_phase7))
	{
		missile.velocity = (v_up * 600);
	}
	else
	{
		missile.velocity = (v_forward * 800);
	}
	missile.avelocity = '300 300 300';
	missile.nextthink = (time + 0.3);
	missile.enemy = trigger;
	missile.think = skullhomemakesolid;
	missile.touch = skullmissiletouch;
	missile.classname = "skull";
};
void () azoth_throwindirect7;
void () azoth_throw2;
void () azoth_throw1 = [ 89, azoth_throw2 ]
{
	ai_face ();
};
void () azoth_throw3;
void () azoth_throw2 = [ 90, azoth_throw3 ]
{
	ai_back (MOVETYPE_WALK);
};
void () azoth_throw4;
void () azoth_throw3 = [ 91, azoth_throw4 ]
{
	ai_back (FL_SWIM);
};
void () azoth_throw5;
void () azoth_throw4 = [ 92, azoth_throw5 ]
{
	ai_back (FL_SWIM);
};
void () azoth_throw6;
void () azoth_throw5 = [ 93, azoth_throw6 ]
{
	ai_back (MOVETYPE_WALK);
};
void () azoth_throw7;
void () azoth_throw6 = [ 94, azoth_throw7 ]
{
	ai_back (MOVETYPE_WALK);
};
void () azoth_throw8;
void () azoth_throw7 = [ 95, azoth_throw8 ]
{
	if (!AzothCheckMissile ())
	{
		azoth_throwindirect7 ();
	}
	ai_face ();
};
void () azoth_throw9;
void () azoth_throw8 = [ 96, azoth_throw9 ]
{
	ai_face ();
};
void () azoth_throw10;
void () azoth_throw9 = [ 97, azoth_throw10 ]
{
	ai_face ();
};
void () azoth_throw11;
void () azoth_throw10 = [ 98, azoth_throw11 ]
{
	ai_face ();
	azoth_throw_direct ();
};
void () azoth_throw12;
void () azoth_throw11 = [ 99, azoth_throw12 ]
{
	ai_forward (SVC_TEMPENTITY);
};
void () azoth_throw13;
void () azoth_throw12 = [ 100, azoth_throw13 ]
{
	ai_forward (37);
};
void () azoth_throw14;
void () azoth_throw13 = [ 101, azoth_throw14 ]
{
	ai_forward (29);
};
void () azoth_throw15;
void () azoth_throw14 = [ 102, azoth_throw15 ]
{
	ai_charge (21);
};
void () azoth_throw16;
void () azoth_throw15 = [ 103, azoth_throw16 ]
{
	ai_charge (20);
};
void () azoth_throw17;
void () azoth_throw16 = [ 104, azoth_throw17 ]
{
	ai_charge (MOVETYPE_TOSS);
};
void () azoth_throw17 = [ 105, azoth_run1 ]
{
	ai_charge (MOVETYPE_FLY);
	if (!(self.flags & FL_ONGROUND))
	{
		self.think = azoth_land2;
	}
};
void () azoth_throwindirect7 = [ 95, azoth_throwindirect8 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
};
void () azoth_throwindirect8 = [ 96, azoth_throwindirect9 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
};
void () azoth_throwindirect9 = [ 97, azoth_throwindirect10 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
};
void () azoth_throwindirect10 = [ 98, azoth_throw11 ]
{
	self.ideal_yaw = (vectoyaw ((tower - self.origin)) + 180);
	ChangeYaw ();
	azoth_throw_indirect ();
};
void (float cel) azoth_fly =
{
	local vector d;
	local float r;
	if ((self.attack_finished < time))
	{
		azoth_land1 ();
		return;
	}
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	makevectors (self.angles);
	d = self.pos1 - self.origin;
	r = vlen (d);
	if ((r < 40))
	{
		if ((azoth_new_flightpoint () == TRUE))
		{
			return;
		}
	}
	self.velocity = ((2.1 * (cel / r)) * d);
	self.ideal_yaw = vectoyaw ((self.pos1 - self.origin));
	ChangeYaw ();
	self.velocity_x = ((self.velocity_x + (random () * SVC_INTERMISSION)) - 15);
	self.velocity_y = ((self.velocity_y + (random () * SVC_INTERMISSION)) - 15);
};
void () azoth_fly2;
void () azoth_fly1 = [ 136, azoth_fly2 ]
{
	azoth_fly (150);
	sound (self, FL_SWIM, "azoth/flap.wav", TRUE, FALSE);
};
void () azoth_fly3;
void () azoth_fly2 = [ 137, azoth_fly3 ]
{
	azoth_fly (150);
};
void () azoth_fly4;
void () azoth_fly3 = [ 138, azoth_fly4 ]
{
	azoth_fly (200);
};
void () azoth_fly5;
void () azoth_fly4 = [ 139, azoth_fly5 ]
{
	azoth_fly (130);
};
void () azoth_fly6;
void () azoth_fly5 = [ 140, azoth_fly6 ]
{
	azoth_fly (130);
};
void () azoth_fly7;
void () azoth_fly6 = [ 139, azoth_fly7 ]
{
	azoth_fly (130);
};
void () azoth_fly8;
void () azoth_fly7 = [ 138, azoth_fly8 ]
{
	azoth_fly (100);
};
void () azoth_fly8 = [ 137, azoth_fly1 ]
{
	azoth_fly (100);
};
void () azoth_fly_touch =
{
	if ((other.classname != "player"))
	{
		return;
	}
	self.velocity_z = 500;
};
void () azoth_leap2;
void () azoth_leap1 = [ 76, azoth_leap2 ]
{};
void () azoth_leap3;
void () azoth_leap2 = [ 77, azoth_leap3 ]
{};
void () azoth_leap4;
void () azoth_leap3 = [ 78, azoth_leap4 ]
{};
void () azoth_leap5;
void () azoth_leap4 = [ 79, azoth_leap5 ]
{};
void () azoth_leap5 = [ 80, azoth_fly1 ]
{
	self.lip = FALSE;
	self.movetype = MOVETYPE_FLY;
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	self.height = 170;
	azoth_fly (250);
	self.touch = azoth_fly_touch;
};
void () azoth_free =
{
	local vector d;
	d = normalize (((self.origin - tower) - (self.origin_z * '0 0 1')));
	self.velocity_x = (-300 * d_y);
	self.velocity_y = (300 * d_x);
	self.velocity_z = 175;
};
void () azoth_land3;
void () azoth_land1 = [ 81, azoth_land2 ]
{
	self.movetype = MOVETYPE_STEP;
	self.velocity = (self.velocity * 0.1);
	self.touch = SUB_Null;
};
void () azoth_land2 = [ 82, azoth_land2 ]
{
	if ((self.flags & FL_ONGROUND))
	{
		azoth_land3 ();
	}
	if ((self.velocity == VEC_ORIGIN))
	{
		azoth_free ();
	}
	AzothCheckAttack ();
};
void () azoth_land4;
void () azoth_land3 = [ 83, azoth_land4 ]
{};
void () azoth_land5;
void () azoth_land4 = [ 84, azoth_land5 ]
{};
void () azoth_land6;
void () azoth_land5 = [ 85, azoth_land6 ]
{};
void () azoth_land7;
void () azoth_land6 = [ 86, azoth_land7 ]
{};
void () azoth_land8;
void () azoth_land7 = [ 87, azoth_land8 ]
{};
void () azoth_land9;
void () azoth_land8 = [ 88, azoth_land9 ]
{};
void () azoth_land9 =
{
	self.attack_finished = (time - 0.2);
	self.th_run ();
};
void () azoth_dive3;
void () azoth_divecollide =
{
	if ((other == self.enemy))
	{
		azoth_dive3 ();
	}
};
void () azoth_dive2;
void () azoth_dive1 = [ 81, azoth_dive2 ]
{
	self.movetype = MOVETYPE_STEP;
	self.velocity = (self.velocity * 0.1);
	self.touch = azoth_divecollide;
	self.nextthink = (time + 0.4);
};
void () azoth_dive2b;
void () azoth_dive2 = [ 81, azoth_dive2b ]
{
	self.velocity = '0 0 -800';
};
void () azoth_dive2b = [ 82, azoth_dive2b ]
{
	if ((self.flags & FL_ONGROUND))
	{
		azoth_dive3 ();
	}
	if ((self.velocity == VEC_ORIGIN))
	{
		azoth_free ();
	}
	AzothCheckAttack ();
};
void () azoth_dive3 = [ 83, azoth_land4 ]
{
	local entity e;
	e = nextent (world);
	while ((e.classname == "player"))
	{
		if ((vlen (((self.origin - '0 0 24') - e.origin)) < 170))
		{
			T_Damage (e, self, self, SVC_KILLEDMONSTER);
		}
		e = nextent (e);
	}
	e = spawn ();
	e.origin = (self.origin - '0 0 18');
	setmodel (e, "progs/shockwav.mdl");
	e.think = s_explode2;
	e.nextthink = (time + 0.05);
	sound (self, FL_SWIM, "azoth/crunch.wav", TRUE, TRUE);
	self.touch = SUB_Null;
};
void () rift_open_start;
void (vector dir) rift_lightning =
{
	local vector org;
	makevectors ((self.angles_y * '0 1 0'));
	org = ((self.origin + (dir_x * v_forward)) - (dir_y * v_right)) + (dir_z * '0 0 1');
	WriteByte (FALSE, SVC_TEMPENTITY);
	WriteByte (FALSE, MOVETYPE_TOSS);
	WriteEntity (FALSE, self);
	WriteCoord (FALSE, org_x);
	WriteCoord (FALSE, org_y);
	WriteCoord (FALSE, org_z);
	WriteCoord (FALSE, rift.origin_x);
	WriteCoord (FALSE, rift.origin_y);
	WriteCoord (FALSE, rift.origin_z);
};
void () azoth_diec1 = [ 126, azoth_diec2 ]
{
	rift_lightning ('-9 5 150');
};
void () azoth_diec3;
void () azoth_diec2 = [ 127, azoth_diec3 ]
{
	rift_lightning ('-16 18 152');
};
void () azoth_diec4;
void () azoth_diec3 = [ 128, azoth_diec4 ]
{
	rift_lightning ('-12 12 154');
	self = rift;
	rift_open_start ();
};
void () azoth_diec5;
void () azoth_diec4 = [ 129, azoth_diec5 ]
{
	rift_lightning ('-5 -4 150');
};
void () azoth_diec6;

void () azoth_diec5 = [ 128, azoth_diec6 ]
{
	rift_lightning ('-9 5 150');
};
void () azoth_diec7;
void () azoth_diec6 = [ 127, azoth_diec7 ]
{};
void () azoth_died1;
void () azoth_diec7 = [ 126, azoth_died1 ]
{};
void (float cel) azoth_fly_death =
{
	local vector d;
	local float r;
	makevectors (self.angles);
	d = (((rift.origin - self.origin) - (self.height * '0 0 1')) + (26 * v_forward)) + (15 * v_right);
	r = vlen (d);
	if ((r < MOVETYPE_BOUNCE))
	{
		self.lip = TRUE;
	}
	self.velocity = ((1.6 * (cel / (r + TRUE))) * d);
};
void () azoth_died2;
void () azoth_died1 = [ 130, azoth_died2 ]
{};
void () azoth_died3;
void () azoth_died2 = [ 131, azoth_died3 ]
{};
void () azoth_died4;
void () azoth_died3 = [ 132, azoth_died4 ]
{};
void () azoth_died5;
void () azoth_died4 = [ 133, azoth_died5 ]
{};
void () azoth_died6;
void () azoth_died5 = [ 134, azoth_died6 ]
{};
void () azoth_diee1;
void () azoth_died6 = [ 135, azoth_diee1 ]
{
	self.lip = FALSE;
	self.movetype = FL_CLIENT;
	self.height = 170;
	azoth_fly_death (200);
};
void () azoth_diee2;
void () azoth_diee1 = [ 136, azoth_diee2 ]
{
	sound (self, FL_SWIM, "azoth/flap.wav", TRUE, FALSE);
	azoth_fly_death (100);
};
void () azoth_diee3;

void () azoth_diee2 = [ 137, azoth_diee3 ]
{
	azoth_fly_death (100);
};
void () azoth_diee4;

void () azoth_diee3 = [ 138, azoth_diee4 ]
{
	azoth_fly_death (150);
};
void () azoth_diee5;

void () azoth_diee4 = [ 139, azoth_diee5 ]
{
	azoth_fly_death (90);
};
void () azoth_diee6;
void () azoth_diee5 = [ 140, azoth_diee6 ]
{
	if (self.lip)
	{
		azoth_dief1 ();
	}
	else
	{
		azoth_fly_death (80);
	}
};
void () azoth_diee7;
void () azoth_diee6 = [ 139, azoth_diee7 ]
{
	azoth_fly_death (90);
};
void () azoth_diee8;
void () azoth_diee7 = [ 138, azoth_diee8 ]
{
	azoth_fly_death (70);
};

void () azoth_diee8 = [ 137, azoth_diee1 ]
{
	azoth_fly_death (70);
};
void () leg2;
void () leg1 = [ 1, leg2 ]
{};
void () leg3;
void () leg2 = [ 2, leg3 ]
{};
void () leg4;
void () leg3 = [ 3, leg4 ]
{};
void () leg5;
void () leg4 = [ 4, leg5 ]
{};
void () leg6;
void () leg5 = [ 5, leg6 ]
{};
void () leg7;
void () leg6 = [ 6, leg7 ]
{};
void () leg8;
void () leg7 = [ 7, leg8 ]
{};
void () leg9;
void () leg8 = [ 8, leg9 ]
{
	sound (self, FL_SWIM, "demon/dland2.wav", TRUE, FALSE);
};
void () leg10;
void () leg9 = [ 8, leg10 ]
{};
void () leg10 = [ 8, leg10 ]
{
	if ((coop == FL_SWIM))
	{
		Become_Corpse ();
	}
};
void () leg_touch =
{
	self.touch = SUB_Null;
	self.velocity = (self.velocity * 0.2);
	sound (self, FL_SWIM, "demon/dland2.wav", TRUE, FALSE);
	leg1 ();
};
void () rift_close;
void () azoth_dief2;
void () azoth_dief1 = [ 141, azoth_dief2 ]
{
	rift.think = rift_hold;
	azoth_fly_death (20);
	self.height = 170;
	rift.frame = 39;
};
void () azoth_dief3;
void () azoth_dief2 = [ 142, azoth_dief3 ]
{
	azoth_fly_death (20);
	self.height = 170;
	rift.frame = 38;
	sound (self, FL_SWIM, "azoth/pain.wav", TRUE, FALSE);
};
void () azoth_dief4;
void () azoth_dief3 = [ 143, azoth_dief4 ]
{
	azoth_fly_death (20);
	self.height = 170;
	rift.frame = 37;
};
void () azoth_dief5;
void () azoth_dief4 = [ 144, azoth_dief5 ]
{
	azoth_fly_death (20);
	self.height = 170;
	rift.frame = 36;
};
void () azoth_dief6;
void () azoth_dief5 = [ 145, azoth_dief6 ]
{
	azoth_fly_death (20);
	self.height = 170;
	rift.frame = 35;
};
void () azoth_dief7;
void () azoth_dief6 = [ 146, azoth_dief7 ]
{
	azoth_fly_death (20);
	self.height = 165;
	rift.frame = 34;
};
void () azoth_dief8;
void () azoth_dief7 = [ 147, azoth_dief8 ]
{
	azoth_fly_death (20);
	self.height = 165;
	rift.frame = 34;
};
void () azoth_dief9;
void () azoth_dief8 = [ 148, azoth_dief9 ]
{
	azoth_fly_death (20);
	self.height = 165;
	rift.frame = SVC_SELLSCREEN;
};
void () azoth_dief10;
void () azoth_dief9 = [ 149, azoth_dief10 ]
{
	azoth_fly_death (20);
	self.height = 160;
	rift.frame = 34;
};
void () azoth_dief11;
void () azoth_dief10 = [ 150, azoth_dief11 ]
{
	azoth_fly_death (20);
	self.height = 160;
	rift.frame = 35;
};
void () azoth_dief12;
void () azoth_dief11 = [ 151, azoth_dief12 ]
{
	azoth_fly_death (20);
	self.height = 155;
	rift.frame = 36;
};
void () azoth_dief13;
void () azoth_dief12 = [ 152, azoth_dief13 ]
{
	azoth_fly_death (20);
	self.height = 155;
	rift.frame = 37;
};
void () azoth_dief14;
void () azoth_dief13 = [ 153, azoth_dief14 ]
{
	azoth_fly_death (20);
	self.height = 155;
	rift.frame = 38;
};
void () azoth_dief15;
void () azoth_dief14 = [ 154, azoth_dief15 ]
{
	azoth_fly_death (20);
	self.height = 145;
	rift.frame = 39;
};
void () azoth_dief16;
void () azoth_dief15 = [ 155, azoth_dief16 ]
{
	azoth_fly_death (70);
	self.height = 140;
	rift.frame = 40;
};
void () azoth_dief17;
void () azoth_dief16 = [ 156, azoth_dief17 ]
{
	azoth_fly_death (70);
	self.height = 130;
	rift.frame = 40;
};
void () azoth_dief18;
void () azoth_dief17 = [ 157, azoth_dief18 ]
{
	azoth_fly_death (70);
	self.height = 120;
	rift.frame = 40;
};
void () azoth_dief19;
void () azoth_dief18 = [ 158, azoth_dief19 ]
{
	azoth_fly_death (70);
	self.height = 110;
	rift.frame = 40;
};
void () azoth_dief20;
void () azoth_dief19 = [ 159, azoth_dief20 ]
{
	azoth_fly_death (50);
	self.height = 100;
	rift.frame = 40;
};
void () azoth_dief21;
void () azoth_dief20 = [ 160, azoth_dief21 ]
{
	azoth_fly_death (20);
	self.height = 100;
	rift.frame = 39;
	sound (self, FL_SWIM, "azoth/awake.wav", TRUE, TRUE);
};
void () azoth_dief22;
void () azoth_dief21 = [ 161, azoth_dief22 ]
{
	azoth_fly_death (20);
	self.height = 100;
	rift.frame = 38;
};
void () azoth_dief23;
void () azoth_dief22 = [ 162, azoth_dief23 ]
{
	azoth_fly_death (20);
	self.height = 100;
	rift.frame = 37;
};
void () azoth_dief24;
void () azoth_dief23 = [ 163, azoth_dief24 ]
{
	azoth_fly_death (20);
	self.height = 100;
	rift.frame = 37;
};
void () azoth_dief25;
void () azoth_dief24 = [ 164, azoth_dief25 ]
{
	azoth_fly_death (20);
	self.height = 100;
	rift.frame = 34;
	rift.think = rift_close;
};
void () azoth_dief26;
void () azoth_dief25 = [ 165, azoth_dief26 ]
{
	azoth_fly_death (20);
	self.height = 100;
};
void () azoth_dief26 = [ 165, azoth_dief25 ]
{
	local entity gib;
	gib = spawn ();
	gib.origin = rift.origin;
	if ((coop == FL_SWIM))
	{
		gib.origin = self.origin;
	}
	gib.movetype = MOVETYPE_BOUNCE;
	setmodel (gib, "progs/azothgib.mdl");
	setsize (gib, '0 0 -108', VEC_ORIGIN);
	gib.velocity = '0 0 -20';
	gib.solid = TRUE;
	gib.touch = leg_touch;
	gib.angles = self.angles;
	sound (self, FL_SWIM, "player/udeath.wav", TRUE, FALSE);
	ThrowGib ("progs/gib1.mdl", -10);
	ThrowGib ("progs/gib2.mdl", -10);
	ThrowGib ("progs/gib3.mdl", -10);
	ThrowGib ("progs/gib1.mdl", -10);
	ThrowGib ("progs/gib2.mdl", -10);
	SUB_UseTargets ();
	killed_monster ();
	remove (self);
};
void () dummy_test =
{
	local entity dummy;
	local entity oself;
	local vector d;
	local float r;
	self.velocity = VEC_ORIGIN;
	dummy = self.trigger_field;
	d = self.origin - dummy.origin;
	dummy.angles = vectoangles (d);
	oself = self;
	self = dummy;
	r = vlen (d);
	if (!walkmove (self.angles_y, r))
	{
		while (walkmove (self.angles_y, MOVETYPE_BOUNCE))
		{
		}
		self = oself;
		setorigin (self, dummy.origin);
	}
	else
	{
		self = oself;
		remove (dummy);
		self.trigger_field = world;
	}
};
void () azoth_dieb1;
void () trigger_stairpoint =
{
	if ((other.movetarget == self))
	{
		if ((other.classname == "monster_azoth"))
		{
			other.goalentity = self.enemy;
			other.movetarget = self.enemy;
			remove (self);
			return;
		}
	}
};
void () stairpoint_think2 =
{
	self.solid = TRUE;
	setsize (self, '-16 -16 -32', VEC_HULL_MAX);
	force_retouch = FL_SWIM;
};
void () stairpoint_think =
{
	while (walkmove (75, MOVETYPE_BOUNCE))
	{
	}
	self.nextthink = (time + 0.1);
	self.think = stairpoint_think2;
};
void () SpawnStairWaypoint =
{
	local entity waypoint;
	local entity oself;
	if ((self.goalentity.classname == "stairpoint"))
	{
		return;
	}
	waypoint = spawn ();
	setorigin (waypoint, (self.origin + '0 128 32'));
	waypoint.solid = MOVETYPE_WALK;
	waypoint.classname = "stairpoint";
	waypoint.movetype = MOVETYPE_STEP;
	setsize (waypoint, '-16 -16 -32', VEC_HULL_MAX);
	oself = self;
	self = waypoint;
	droptofloor (0,0);
	self = oself;
	waypoint.touch = trigger_stairpoint;
	waypoint.nextthink = (time + 0.1);
	waypoint.think = stairpoint_think;
	waypoint.enemy = self.movetarget;
	self.goalentity = waypoint;
	self.movetarget = waypoint;
};
void () azoth_die2;
void () azoth_die1 = [ 107, azoth_die2 ]
{
	movetogoal (20);
	sound (self, FL_SWIM, "azoth/pain.wav", TRUE, TRUE);
};
void () azoth_die3;
void () azoth_die2 = [ 108, azoth_die3 ]
{
	movetogoal (MOVETYPE_FLY);
	if (self.trigger_field)
	{
		dummy_test ();
	}
};
void () azoth_die4;
void () azoth_die3 = [ 109, azoth_die4 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (MOVETYPE_BOUNCE);
	if (self.trigger_field)
	{
		dummy_test ();
	}
};
void () azoth_die5;
void () azoth_die4 = [ 110, azoth_die5 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (25);
	if (self.trigger_field)
	{
		dummy_test ();
	}
};
void () azoth_die6;
void () azoth_die5 = [ 111, azoth_die6 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (20);
	if (self.trigger_field)
	{
		dummy_test ();
	}
};
void () azoth_die7;
void () azoth_die6 = [ 112, azoth_die7 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (15);
	if (self.trigger_field)
	{
		dummy_test ();
	}
};
void () azoth_die8;
void () azoth_die7 = [ 113, azoth_die8 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (MOVETYPE_BOUNCE);
};
void () azoth_die9;
void () azoth_die8 = [ 114, azoth_die9 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (15);
};
void () azoth_die10;
void () azoth_die9 = [ 115, azoth_die10 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (20);
};
void () azoth_die11;
void () azoth_die10 = [ 116, azoth_die11 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (15);
};
void () azoth_die12;
void () azoth_die11 = [ 117, azoth_die12 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (15);
	if (self.lip)
	{
		self.lip = FALSE;
		self.think = azoth_dieb1;
	}
};
void () azoth_die13;
void () azoth_die12 = [ 118, azoth_die13 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (20);
	if (self.lip)
	{
		self.lip = FALSE;
		self.think = azoth_dieb1;
	}
};
void () azoth_die13 = [ 107, azoth_die2 ]
{
	if ((self.origin_z < 216))
	{
		SpawnStairWaypoint ();
	}
	movetogoal (20);
	if (self.lip)
	{
		self.lip = FALSE;
		self.think = azoth_dieb1;
	}
};
void () azoth_dieb2;
void () azoth_dieb1 = [ 107, azoth_dieb2 ]
{
	movetogoal (20);
};
void () azoth_dieb3;
void () azoth_dieb2 = [ 119, azoth_dieb3 ]
{};
void () azoth_dieb4;
void () azoth_dieb3 = [ 120, azoth_dieb4 ]
{};
void () azoth_dieb5;
void () azoth_dieb4 = [ 121, azoth_dieb5 ]
{};
void () azoth_dieb6;
void () azoth_dieb5 = [ 122, azoth_dieb6 ]
{};
void () azoth_dieb7;
void () azoth_dieb6 = [ 123, azoth_dieb7 ]
{};
void () azoth_dieb8;
void () azoth_dieb7 = [ 124, azoth_dieb8 ]
{};
void () azoth_dieb8 = [ 125, azoth_diec1 ]
{};
void () trigger_dieb =
{
	if ((other.movetarget == self))
	{
		if ((other.classname == "monster_azoth"))
		{
			other.lip = TRUE;
		}
	}
};
void () azoth_die =
{
	local entity waypoint;
	local entity dummy;
	local entity oself;
	self.target = self.deathtype;
	traceline (rift.origin, (rift.origin - '0 0 1024'), TRUE, rift);
	waypoint = spawn ();
	setorigin (waypoint, (trace_endpos + '0 0 16'));
	waypoint.solid = TRUE;
	waypoint.touch = trigger_dieb;
	setsize (waypoint, '-16 -16 -8', '16 16 8');
	azoth_die1 ();
	self.movetarget = waypoint;
	self.goalentity = waypoint;
	self.enemy = world;
	dummy = spawn ();
	dummy.owner = self;
	self.trigger_field = dummy;
	dummy.solid = MOVETYPE_WALK;
	dummy.movetype = MOVETYPE_STEP;
	setsize (dummy, VEC_HULL2_MIN, '32 32 160');
	setorigin (dummy, (waypoint.origin + '0 0 128'));
	oself = self;
	self = dummy;
	droptofloor (0,0);
	self = oself;
};
void () azoth_die_special =
{
	self.frame = 125;
	self.think = SUB_Null;
	self.solid = SOLID_TRIGGER;
	self.map = "start";
	self.touch = changelevel_touch;
};
void () azoth_phase1 =
{
	sound (self, FL_SWIM, "azoth/pain.wav", TRUE, TRUE);
	self.health = MTF_Monster_Health((1500 + (skill * 300)));
	self.th_run = azoth_run1;
	self.th_die = azoth_phase2;
	self.th_melee = azoth_hammer1;
	self.th_missile = azoth_fire1;
	self.state = FALSE;
	self.takedamage = FL_SWIM;
	SUB_AttackFinished (TRUE);
	azoth_run1 ();
};
void () azoth_phase2b =
{
	self.solid = MOVETYPE_WALK;
	setmodel (self, "progs/azoth.mdl");
	setsize (self, VEC_HULL2_MIN, '32 32 160');
	setorigin (self, self.origin);
	self.movetype = MOVETYPE_STEP;
	self.velocity = VEC_ORIGIN;
	self.health = MTF_Monster_Health((500 + (skill * 250)));
	self.th_run = azoth_s_run1;
	self.th_die = azoth_phase5;
	self.th_melee = azoth_swipe1;
	self.pos2 = gate;
	self.th_missile = SUB_Null;
	self.takedamage = FL_SWIM;
	self.attack_finished = (time + TRUE);
	azoth_land1 ();
};
void () azoth_phase2 =
{
	local vector spot;
	local vector vout;
	local vector vperp;
	if ((vlen ((self.origin - gate)) > 700))
	{
		sound (self, FL_SWIM, "azoth/pain.wav", TRUE, TRUE);
		if (((towerquadrant (self) == FL_SWIM) && (self.origin_z > 700)))
		{
			self.pos1 = '1600 -1728 1800';
		}
		else
		{
			if ((towerquadrant (self) == MOVETYPE_STEP))
			{
				self.pos1 = (gate + ('0 0 1' * self.origin_z));
			}
			else
			{
				vout = normalize (((self.origin - tower) - ('0 0 1' * self.origin_z)));
				vperp = ('-1 0 0' * vout_y) + ('1 0 0' * vout_x);
				spot = (800 * vout) + (100 * vperp);
				spot_z = 700;
				self.pos1 = (tower + spot);
			}
		}
		azoth_leap1 ();
		self.attack_finished = (time + 15);
		self.state = TRUE;
		self.solid = FALSE;
		return;
	}
	else
	{
		azoth_phase2b ();
		azoth_swipe15 ();
	}
};
void () azoth_tele2;
void () azoth_tele1 = [ 0, azoth_tele2 ]
{};
void () azoth_tele3;
void () azoth_tele2 = [ 1, azoth_tele3 ]
{};
void () azoth_tele4;
void () azoth_tele3 = [ 2, azoth_tele4 ]
{};
void () azoth_tele5;
void () azoth_tele4 = [ 3, azoth_tele5 ]
{};
void () azoth_tele6;
void () azoth_tele5 = [ 4, azoth_tele6 ]
{};
void () azoth_tele7;
void () azoth_tele6 = [ 5, azoth_tele7 ]
{};
void () azoth_tele8;
void () azoth_tele7 = [ 6, azoth_tele8 ]
{};
void () azoth_tele9;
void () azoth_tele8 = [ 7, azoth_tele9 ]
{};
void () azoth_tele10;
void () azoth_tele9 = [ 8, azoth_tele10 ]
{};
void () azoth_tele11;
void () azoth_tele10 = [ 9, azoth_tele11 ]
{};
void () azoth_tele11 = [ 10, azoth_tele1 ]
{
	if ((self.rad_time < time))
	{
		spawn_tfog (self.origin);
		sound (self, FL_SWIM, "misc/r_tele5.wav", TRUE, MOVETYPE_STEP);
		remove (self);
	}
};
void () azoth_flee2 =
{
	self.th_run = SUB_Null;
	azoth_tele1 ();
	SUB_UseTargets ();
	self.rad_time = (time + FL_SWIM);
};
void () azoth_flee =
{
	self.th_run = azoth_flee2;
	self.th_melee = SUB_Null;
	self.th_die = SUB_Null;
	self.th_missile = SUB_Null;
	self.target = self.deathtype;
	sound (self, FL_SWIM, "azoth/pain.wav", TRUE, FALSE);
	self.state = MOVETYPE_WALK;
	self.pos1 = (self.origin + '0 0 80');
	self.attack_finished = (time + MOVETYPE_FLY);
	self.movetype = FL_CLIENT;
	self.solid = FALSE;
	setmodel (self, "progs/azoth.mdl");
	setsize (self, '0 0 -24', VEC_ORIGIN);
	azoth_fly1 ();
	self.flags = (self.flags - (self.flags & FL_ONGROUND));
	self.velocity = '0 0 200';
};
void () azoth_phase5 =
{
	local float q;
	self.health = MTF_Monster_Health((1700 + (skill * 300)));
	self.th_run = azoth_run1;
	self.th_die = azoth_phase1;
	self.th_melee = azoth_swipe1;
	self.th_die = azoth_flee;
	self.th_missile = SUB_Null;
	self.takedamage = FL_SWIM;
	q = towerquadrant (self);
	Azoth_flytosecond ();
	self.pos1 = '2290 -1940 920';
	self.state = FALSE;
};
void () azoth_phase4 =
{
	self.health = MTF_Monster_Health((1700 + (skill * 300)));
	self.th_run = azoth_run1;
	self.th_die = azoth_phase1;
	self.th_melee = azoth_hammer1;
	self.th_die = azoth_phase5;
	self.th_missile = azoth_throw1;
	self.takedamage = FL_SWIM;
};
void () azoth_phase7b =
{
	self.solid = MOVETYPE_WALK;
	setmodel (self, "progs/azoth.mdl");
	setsize (self, VEC_HULL2_MIN, '32 32 160');
	self.movetype = MOVETYPE_STEP;
	self.velocity = VEC_ORIGIN;
	self.health = MTF_Monster_Health((500 + (skill * 250)));
	self.th_run = azoth_swipe15;
	self.th_die = azoth_die;
	self.th_melee = azoth_swipe1;
	self.th_missile = SUB_Null;
	traceline (rift.origin, (rift.origin - '0 0 2048'), TRUE, self);
	self.pos2 = trace_endpos;
	self.takedamage = FL_SWIM;
	SUB_AttackFinished (TRUE);
	azoth_land1 ();
};
void () azoth_phase7 =
{
	if ((vlen (((self.origin - rift.origin) + '0 0 500')) > 200))
	{
		sound (self, FL_SWIM, "azoth/pain.wav", TRUE, TRUE);
		azoth_leap1 ();
		self.attack_finished = (time + MOVETYPE_BOUNCE);
		self.state = MOVETYPE_FLY;
		azoth_new_flightpoint ();
		return;
	}
	else
	{
		azoth_phase7b ();
		azoth_swipe15 ();
	}
};
void () monster_azoth_restart_go =
{
	self.classname = "monster_azoth";
	if (deathmatch)
	{
		remove (self);
		return;
	}
	lightstyle (STAT_TOTALMONSTERS, "m");
	self.solid = MOVETYPE_WALK;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/azoth.mdl");
	setsize (self, VEC_HULL2_MIN, '32 32 160');
	self.health = MTF_Monster_Health((1700 + (skill * 300)));
	self.th_stand = azoth_stand1;
	self.th_walk = azoth_walk1;
	self.th_run = azoth_run1;
	self.th_die = azoth_phase7;
	self.th_melee = azoth_hammer1;
	self.th_missile = azoth_throw1;
	self.yaw_speed = 45;
	self.deathtype = self.target;
	self.target = string_null;
	walkmonster_start_go ();
	self.nextthink = (time + 0.1);
	self.enemy = activator;
	self.think = FoundTarget;
};
void () monster_azoth;
void () monster_azoth_restart =
{
	precache_model ("progs/azoth.mdl");
	precache_model ("progs/azothgib.mdl");
	precache_model ("progs/shockwav.mdl");
	precache_model ("progs/s_flame.spr");
	precache_sound ("azoth/thud.wav");
	precache_sound ("azoth/flap.wav");
	precache_sound ("azoth/fire.wav");
	precache_sound ("azoth/pain.wav");
	precache_sound ("azoth/awake.wav");
	precache_sound ("demon/dland2.wav");
	precache_sound ("azoth/portal.wav");
	precache_sound ("azoth/crunch.wav");
	precache_model ("progs/skull.mdl");
	precache_sound ("azoth/thwack.wav");
	self.use = monster_azoth_restart_go;
	total_monsters = total_monsters + TRUE;
	self.classname = "monster_azoth";
	self.netname = "Azoth";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_azoth;
	COOP_SetLives ();
};
void () monster_azoth =
{
	self.classname = "monster_azoth";
	if (deathmatch)
	{
		remove (self);
		return;
	}
	lightstyle (STAT_TOTALMONSTERS, "m");
	precache_model ("progs/azoth.mdl");
	precache_model ("progs/azothgib.mdl");
	precache_model ("progs/shockwav.mdl");
	precache_model ("progs/s_flame.spr");
	precache_sound ("azoth/thud.wav");
	precache_sound ("azoth/flap.wav");
	precache_sound ("azoth/fire.wav");
	precache_sound ("azoth/pain.wav");
	precache_sound ("azoth/awake.wav");
	precache_sound ("azoth/portal.wav");
	precache_sound ("demon/dland2.wav");
	precache_sound ("azoth/crunch.wav");
	precache_model ("progs/skull.mdl");
	precache_sound ("azoth/thwack.wav");
	self.netname = "Azoth";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_azoth;
	COOP_SetLives ();
	self.solid = MOVETYPE_WALK;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/azoth.mdl");
	setsize (self, VEC_HULL2_MIN, '32 32 160');
	if (mapname == "aopend")
		self.health = MTF_Monster_Health((2700 + (skill * 300)));
	else
		self.health = MTF_Monster_Health((1700 + (skill * 300)));
	self.deathtype = self.target;
	self.target = string_null;
	self.th_stand = azoth_stand1;
	self.th_walk = azoth_walk1;
	self.th_run = azoth_run1;
	if (mapname == "aopend")
			self.th_die = azoth_die_special;
	else
		self.th_die = azoth_phase2;
	self.th_melee = azoth_hammer1;
	self.th_missile = azoth_throw1;
	self.yaw_speed = 45;
	coop_walkmonster_start ();
	
	if (mapname == "aopend")
		self.lives = 0;
};
void (entity sky27) spawn_blacksky =
{
	setmodel (sky27, sky27.model);
};
void () nightfall3;
void () nightfall2 = [ 0, nightfall3 ]
{
	lightstyle (FALSE, "k");
};
void () nightfall4;
void () nightfall3 = [ 0, nightfall4 ]
{
	lightstyle (FALSE, "j");
};
void () nightfall5;
void () nightfall4 = [ 0, nightfall5 ]
{
	lightstyle (FALSE, "i");
};
void () nightfall6;
void () nightfall5 = [ 0, nightfall6 ]
{
	lightstyle (FALSE, "h");
};
void () nightfall6 = [ 0, SUB_Null ]
{
	lightstyle (FALSE, "g");
};
void () event_nightfall =
{
	local entity sky23a;
	lightstyle (FALSE, "l");
	sky23a = find (world, classname, "func_blacksky");
	while (sky23a)
	{
		spawn_blacksky (sky23a);
		sky23a = find (sky23a, classname, "func_blacksky");
	}
	self.nextthink = (time + 0.1);
	self.think = nightfall2;
};
void () func_blacksky =
{};
void () sky_open =
{
	local entity sky24;
	sky24 = spawn ();
	setmodel (sky24, "progs/sky.mdl");
	setorigin (sky24, self.origin);
	self.enemy = sky24;
};
void () rift_hold =
{
	local float r;
	self.nextthink = (time + 0.1);
	r = random ();
	if ((r < 0.35))
	{
		self.effects = FL_SWIM;
		lightstyle (FALSE, "k");
	}
	else
	{
		lightstyle (FALSE, "g");
	}
	self.think = rift_hold;
	self.skin = (TRUE - self.skin);
};
void () rift_close =
{
	local float r;
	lightstyle (FALSE, "e");
	if ((self.frame > FALSE))
	{
		self.frame = (self.frame - TRUE);
		self.nextthink = (time + 0.05);
	}
	else
	{
		SUB_UseTargets ();
		remove (self);
		return;
	}
	r = random ();
	if ((r < 0.35))
	{
		self.effects = FL_SWIM;
	}
	if ((self.frame == 20))
	{
		remove (self.enemy);
	}
	self.think = rift_close;
	self.skin = (TRUE - self.skin);
};
void () rift_open =
{
	local float r;
	if ((self.frame < 40))
	{
		self.frame = (self.frame + TRUE);
		self.nextthink = (time + 0.05);
	}
	else
	{
		self.nextthink = (time + 0.1);
	}
	r = random ();
	if ((r < 0.35))
	{
		self.effects = FL_SWIM;
		lightstyle (FALSE, "k");
	}
	else
	{
		lightstyle (FALSE, "g");
	}
	if ((self.frame == 20))
	{
		sky_open ();
	}
	self.think = rift_open;
	self.skin = (TRUE - self.skin);
};
void () rift_open_start =
{
	setmodel (self, "progs/rift.mdl");
	self.avelocity = '0 500 0';
	self.movetype = FL_CLIENT;
	self.frame = FALSE;
	self.nextthink = (time + 0.05);
	self.think = rift_open;
	sound (self, FL_SWIM, "azoth/portal.wav", TRUE, FALSE);
};
void () info_rift =
{
	precache_model ("progs/rift.mdl");
	precache_model ("progs/sky.mdl");
	self.use = rift_open_start;
	if (!rift)
	{
		rift = self;
	}
};
void () misc_mapmodel =
{
	if (!self.model)
	{
		dprint ("misc_mapmodel has no model key set\n");
		remove (self);
		return;
	}
	precache_model (self.model);
	setmodel (self, self.model);
	if ((self.spawnflags & TRUE))
	{
		makestatic (self);
	}
};//END
