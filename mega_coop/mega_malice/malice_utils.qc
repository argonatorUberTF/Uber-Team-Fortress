void () Util_Precache =
{
	precache_sound ("utils/send.wav");
	precache_sound ("utils/receive.wav");
	precache_sound ("utils/hoveron.wav");
	precache_sound ("utils/hovrboot.wav");
	precache_sound ("utils/hovrjmp8.wav");
	precache_sound ("utils/hoveroff.wav");
	precache_sound ("utils/paraland.wav");
	precache_sound ("utils/pullcord.wav");
	precache_sound ("utils/putout.wav");
	precache_model ("progs/probe.mdl");
};
void () util_touch =
{
	if ((other.classname != "player"))
	{
		return;
	}
	if (((other.tools == (other.tools | self.tools)) && (self.tools != UT_SCUBA)))
	{
		return;
	}
	if ((other.health <= MSG_BROADCAST))
	{
		return;
	}
	if ((other.classname == "player"))
	{
		sprint (other, self.netname);
		sprint (other, " acquired\n");
		stuffcmd (other, "bf\n");
	}
	if ((deathmatch && (self.netname != "Atom Smasher")))
	{
		self.mdl = self.model;
		self.nextthink = (time + 60);
		self.think = SUB_regen;
	}
	sound (other, CHAN_AUTO, "utils/pickup.wav", AS_STRAIGHT, ATTN_NORM);
	self.model = string_null;
	self.solid = SOLID_NOT;
	activator = other;
	SUB_UseTargets ();
};
void () utility_parachute =
{
	self.touch = util_touch;
	precache_model ("progs/shute.mdl");
	precache_sound ("items/damage.wav");
	setmodel (self, "progs/shute.mdl");
	self.netname = "Chute";
	self.tools = UT_CHUTE;
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	StartItem ();
};
void () utility_probe =
{
	self.touch = util_touch;
	precache_model ("progs/probemod.mdl");
	precache_sound ("items/damage.wav");
	setmodel (self, "progs/probemod.mdl");
	self.netname = "Probe";
	self.tools = UT_PROBE;
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	StartItem ();
};
void () utility_hoverboard =
{
	self.touch = util_touch;
	precache_model ("progs/hoverbrd.mdl");
	setmodel (self, "progs/hoverbrd.mdl");
	self.netname = "Hoverboard";
	self.tools = UT_HOVER;
	self.frame = AS_STRAIGHT;
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	StartItem ();
};
void () utility_scuba =
{
	self.touch = util_touch;
	precache_model ("progs/scuba.mdl");
	setmodel (self, "progs/scuba.mdl");
	self.netname = "Scuba Gear";
	self.tools = UT_SCUBA;
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	StartItem ();
};
void () bigassgun =
{
remove(self);
};
void () HoverBoard =
{
	if ((self.hover_active == AS_STRAIGHT))
	{
		stuffcmd (self, "v_idlescale 0\n");
		stuffcmd (self, "cl_rollangle 2\n");
		stuffcmd (self, "cl_forwardspeed 360\n");
		stuffcmd (self, "cl_bob 0.01\n");
		self.hover_active = MSG_BROADCAST;
		self.angles_x = MSG_BROADCAST;
		self.angles_z = MSG_BROADCAST;
		self.fixangle = TRUE;
		self.modelindex = modelindex_player;
		sound (self, CHAN_VOICE, "utils/hoveroff.wav", AS_STRAIGHT, ATTN_NORM);
	}
	else
	{
		if ((self.tools == (self.tools | UT_BIGASSGUN)))
		{
			return;
		}
		stuffcmd (self, "v_idlescale 12\n");
		stuffcmd (self, "cl_rollangle 4\n");
		stuffcmd (self, "cl_forwardspeed 600\n");
		stuffcmd (self, "cl_bob 0\n");
		self.hover_active = AS_STRAIGHT;
		self.modelindex = modelindex_hover;
		self.angles_x = MSG_BROADCAST;
		self.angles_z = MSG_BROADCAST;
		self.fixangle = TRUE;
		sound (self, CHAN_VOICE, "utils/hoveron.wav", AS_STRAIGHT, ATTN_NORM);
	}
};
void () exit_vehicle;
void () eco1 = [ 0, eco2 ]
{};
void () eco2 = [ 1, eco3 ]
{};
void () eco3 = [ 2, eco4 ]
{};
void () eco4 = [ 3, eco5 ]
{};
void () eco5 = [ 4, SUB_Remove ]
{};
void () Douse_Flame =
{
	if ((other.health <= MSG_BROADCAST))
	{
		return;
	}
	if ((other.classname != "player"))
	{
		return;
	}
	other.burning = MSG_BROADCAST;
	other.extinguished = WEAPON_SHOTGUN;
	other.effects = (other.effects - (other.effects & EF_DIMLIGHT));
};
void () WhoFarted =
{
	local entity co2;
	co2 = spawn ();
	co2.movetype = MOVETYPE_NOCLIP;
	co2.solid = SOLID_TRIGGER;
	makevectors (self.angles);
	setorigin (co2, ((self.origin + (v_forward * 19)) + '0 0 18'));
	co2.velocity = (v_forward * 200);
	co2.velocity_z = -60;
	co2.nextthink = time;
	co2.touch = Douse_Flame;
	co2.think = eco1;
	setmodel (co2, "progs/s_co2.spr");
	setsize (co2, VEC_ORIGIN, VEC_ORIGIN);
};
void () extinguisher_touch =
{
	if ((other.health <= MSG_BROADCAST))
	{
		return;
	}
	if ((other.classname != "player"))
	{
		return;
	}
	if ((co2_spread < time))
	{
		co2_spread = (time + 0.1);
		WhoFarted ();
	}
	if ((self.co2_flag < time))
	{
		self.co2_flag = (time + 0.3);
		sound (self, CHAN_AUTO, "utils/putout.wav", WEAPON_SHOTGUN, ATTN_NORM);
	}
	droptofloor ();
};
void () fire_extinguisher =
{
	precache_model ("progs/extngshr.mdl");
	precache_model ("progs/s_co2.spr");
	setmodel (self, "progs/extngshr.mdl");
	self.solid = SOLID_BBOX;
	self.classname = "ext_1";
	setsize (self, '-16 -16 0', '16 16 60');
	self.touch = extinguisher_touch;
	StartItem ();
};

void () fire_extinguisher2 =
{
	precache_model ("progs/extngshr.mdl");
	precache_model ("progs/s_co2.spr");
	setmodel (self, "progs/extngshr.mdl");
	self.solid = SOLID_BBOX;
	self.classname = "ext_2";
	setsize (self, '-16 -16 0', '16 16 60');
	self.touch = extinguisher_touch;
	self.angles_y = (self.angles_y + 180);
	self.fixangle = TRUE;
	StartItem ();
};
void () compresser_touch =
{
	if ((other.health <= MSG_BROADCAST))
	{
		return;
	}
	if ((other.classname != "player"))
	{
		return;
	}
	if (!(other.tools == (other.tools | UT_SCUBA)))
	{
		return;
	}
	if ((other.armorvalue < TE_LIGHTNING3))
	{
		other.armorvalue = (other.armorvalue + WEAPON_SHOTGUN);
	}
};
void () air_compresser =
{
	precache_model ("progs/extngshr.mdl");
	precache_model ("progs/s_co2.spr");
	setmodel (self, "progs/extngshr.mdl");
	self.solid = SOLID_BBOX;
	setsize (self, '-16 -16 0', '16 16 60');
	self.touch = compresser_touch;
	StartItem ();
};
//END
