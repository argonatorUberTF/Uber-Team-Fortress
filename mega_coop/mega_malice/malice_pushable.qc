void () crate_push =
{
	local vector t_;
	local vector t_2;
	local vector t__left;
	local vector t__right;
	local entity head;
	if ((other == world))
	{
		return;
	}
	if ((other.origin_z > (self.origin_z + SVC_INTERMISSION)))
	{
		return;
	}
	if ((other.classname == "player"))
	{
		droptofloor ();
		makevectors (other.v_angle);
		t__x = (self.origin_x + (v_forward_x * TE_TELEPORT));
		t__y = (self.origin_y + (v_forward_y * TE_TELEPORT));
		t__z = self.origin_z;
		if ((self.classname == "small"))
		{
			t_2 = (self.origin + (v_forward * 60));
			t__left = ((self.origin + (v_forward * SVC_INTERMISSION)) + (v_right * -20));
			t__right = ((self.origin + (v_forward * SVC_INTERMISSION)) + (v_right * 20));
		}
		else
		{
			t_2 = (self.origin + (v_forward * 80));
			t__left = ((self.origin + (v_forward * 40)) + (v_right * -40));
			t__right = ((self.origin + (v_forward * 40)) + (v_right * 40));
		}
		head = findradius (t_2, 40);
		while (head)
		{
			if ((((head.classname == "crate_small") || (head.classname == "crate_large")) && (head != self)))
			{
				return;
			}
			head = head.chain;
		}
		if ((((pointcontents (t_2) != CONTENT_SOLID) && (pointcontents (t__left) != CONTENT_SOLID)) && (pointcontents (t__right) != CONTENT_SOLID)))
		{
			SUB_CalcMove (t_, 100, SUB_Null);
			if ((self.punish_eject > TE_LIGHTNING3))
			{
				sound (self, CHAN_BODY, "misc/crate.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
				self.punish_eject = MSG_BROADCAST;
			}
			self.punish_eject = (self.punish_eject + SPAWNFLAG_SUPERSPIKE);
		}
		return;
	}
};

void () thing_crate1 =
{
	local float oldz;
	precache_model ("progs/crate.bsp");
	precache_sound ("misc/crate.wav");
	setmodel (self, "progs/crate.bsp");
	self.classname = "crate_small";
	self.touch = crate_push;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	self.velocity = VEC_ORIGIN;
	self.origin_z = (self.origin_z + TE_LIGHTNING2);
	oldz = self.origin_z;
	if (!droptofloor ())
	{
		dprint ("Item 'crate' fell out of level at ");
		dprint (vtos (self.origin));
		dprint ("\n");
		remove (self);
		return;
	}
};

void () thing_crate2 =
{
	local float oldz;
	precache_model ("progs/crate2.bsp");
	precache_sound ("misc/crate.wav");
	setmodel (self, "progs/crate2.bsp");
	self.classname = "crate_large";
	self.touch = crate_push;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	self.velocity = VEC_ORIGIN;
	self.origin_z = (self.origin_z + TE_LIGHTNING2);
	oldz = self.origin_z;
	if (!droptofloor ())
	{
		dprint ("Item 'crate' fell out of level at ");
		dprint (vtos (self.origin));
		dprint ("\n");
		remove (self);
		return;
	}
};

void () thing_barrel =
{
	local float oldz;
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_NONE;
	precache_model ("progs/barrel.mdl");
	setmodel (self, "progs/barrel.mdl");
	self.classname = "barrel";
	self.health = 120;
	self.th_die = barrel_explode;
	self.takedamage = DAMAGE_YES;
	self.origin_z = (self.origin_z + SPAWNFLAG_LASER);
	oldz = self.origin_z;
	droptofloor ();
	if (((oldz - self.origin_z) > 250))
	{
		dprint ("item fell out of level at ");
		dprint (vtos (self.origin));
		dprint ("\n");
		remove (self);
	}
};

void () thing_barrel2 =
{
	local float oldz;

	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_NONE;
	precache_model ("progs/barrel2.mdl");
	setmodel (self, "progs/barrel2.mdl");
	self.classname = "barrel";
	self.health = 120;
	self.th_die = barrel_explode;
	self.takedamage = DAMAGE_YES;
	self.origin_z = (self.origin_z + SPAWNFLAG_LASER);
	oldz = self.origin_z;
	droptofloor ();
	if (((oldz - self.origin_z) > 250))
	{
		dprint ("item fell out of level at ");
		dprint (vtos (self.origin));
		dprint ("\n");
		remove (self);
	}
};
//END
