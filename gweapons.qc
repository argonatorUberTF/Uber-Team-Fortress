#define GW_ALLOW_PICKUP_ITEM
#ifdef GW_ALLOW_PICKUP_ITEM
void(entity pickupee) ZG_FireItem;
void () ZG_ammobox_regen;
#endif
float(entity tester_e) IsBuilding =
{
	if (
		tester_e.classname == "building_sentrygun" ||
		tester_e.classname == "building_sentrygun_base" ||
		tester_e.classname == "building_tesla" ||
		tester_e.classname == "building_dispenser" ||
		tester_e.classname == "building_camera" ||
		tester_e.classname == "building_arawana" ||
		tester_e.classname == "building_teleporter"||
   		tester_e.classname == "building_fieldgen"||
		tester_e.classname == "building_sensor"
	   )
		return #TRUE;
	return #FALSE;
};
void (entity pickuper, float toss) zg_drop;
float (entity pickupee) zg_getpickupdist;
void (entity pickuper, entity pickupee, vector destt) zg_movetowards =
{
	local float vel, distfrompickuper;
	if (pickupee == world)
{
		bprint(2, "zg_movetowards: pickupee is world, so wtf?\n");
		return;
	}
	
	vel = vlen (pickupee.origin - destt);
	distfrompickuper = vlen(pickuper.origin - pickupee.origin);

	if (distfrompickuper > zg_getpickupdist(pickupee) + 32)
{
		pickupee.velocity = '0 0 0';
		zg_drop (pickuper, 2);
		return;
	}

	if (pickupee.origin != destt)
		pickupee.velocity = pickuper.velocity + ((normalize(destt - pickupee.origin) * vel) * 10);
	else
		pickupee.velocity = pickuper.velocity;
};
float (entity pickupee) zg_getpickupdist =
{
	local float sizex, sizey;
	if (pickupee.solid == SOLID_NOT || pickupee.solid == SOLID_TRIGGER || (!pickupee.mins_x && !pickupee.maxs_x))
		return #ZG_PICKUPDIST_EXTRA;

	sizex = pickupee.maxs_x + #ZG_PICKUPDIST_EXTRA;
	sizey = pickupee.maxs_y + #ZG_PICKUPDIST_EXTRA;
	if (sizex >= sizey)
		return sizex;
	else
		return sizey;
};
float (entity source, entity targ) zg_infront =
{
	local vector	vec;
	local float		dot;
	makevectors (source.angles);
	vec = normalize (targ.origin - source.origin);
	dot = vec * v_forward;
	if ( dot > 0.3)
	{
		return TRUE;
	}
	return FALSE;
};
float (entity tester_e, entity test) zg_invalidtarget =
{
	if (test.classname == "detpack")
		return FALSE;
	if (test.classname == "merchant")
		return TRUE;
	if (test.classname == "timer")
		return TRUE;
	else
	if (test.is_minion == 1)
		return TRUE;
#ifdef GW_ALLOW_PICKUP_ITEM
	if (test.flags & FL_ITEM)
{
		if (ZG_ItemType(test) > 0)
			return FALSE;
		return 3;
	}
#endif
	if (test.solid == SOLID_BSP || test == world || test.movetype == MOVETYPE_NONE || test.pickedupobject_hands == test)
		return TRUE;
	if (test.flags & FL_MONSTER || !zg_infront(tester_e, test))
		return TRUE;
	if (IsBuilding(test) && test.real_owner != tester_e)
		return 2;
#ifndef GW_ALLOW_PICKUP_ITEM
	if (test.flags & FL_ITEM)
		return 3;
#endif
	if (test.flags & FL_CLIENT)
		return TRUE;
	if (test.health > 0 && test.is_monster == 1)
		return TRUE;
	return FALSE;
};
entity (entity source) zg_findtarget =
{
	local entity radiusent;
	local float ret, badpickup;
	makevectors (source.v_angle);
	traceline (source.origin, (source.origin + '0 0 16') + v_forward*64, #TL_ANY_SOLID, source);
	if (trace_fraction != 1.0 && !(ret = zg_invalidtarget(source, trace_ent)))
		return trace_ent;
	if (ret > 1)
		badpickup = ret;
	radiusent = findradius (source.origin, 64);
	while (radiusent)
{
		if (!(ret = zg_invalidtarget(source, radiusent)))
			return radiusent;
		if (ret > 1)
			badpickup = ret;
		radiusent = radiusent.chain;
	}
	if (source.flags & FL_CLIENT)
	{
		if (badpickup == 2)
			sprint (source, PRINT_HIGH, "Sorry, only the owner can pickup his builds!\n");
#ifdef GW_ALLOW_PICKUP_ITEM
		else
		if (badpickup == 3)
			sprint (source, PRINT_HIGH, "You cannot pick up this item\n");
#else
		else
		if (badpickup == 3)
			sprint (source, PRINT_HIGH, "Sorry, picking up items is disabled!\n");
#endif
		else
			sprint (source, PRINT_HIGH, "There's nothing there to pickup\n");
	}
	return world;
};
void () zg_think =
{
	local entity pickuper, pickupee;
	pickuper = self.owner;
	pickupee = self.owner.pickedupobject_hands;
	if (pickupee == world)
		remove (self);
	if (pickuper.health <= 0 || (pickupee.takedamage && pickupee.health <= 0) || pickupee.model == "" || /*!pickuper.is_connected*/pickuper.has_disconnected)	// *
		zg_drop (pickuper, FALSE);

	makevectors (pickuper.v_angle);
#ifdef GW_ALLOW_PICKUP_ITEM
	if (ZG_ItemType(pickupee) > 0)
		trace_endpos = (pickuper.origin + '0 0 16') + v_forward*zg_getpickupdist(pickupee)*1.25;
	else
#endif
	trace_endpos = (pickuper.origin + '0 0 16') + v_forward*zg_getpickupdist(pickupee);

	zg_movetowards (pickuper, pickupee, trace_endpos);

	self.nextthink = time + 0.05;
};
void (entity pickuper, float toss) zg_drop =
{
	local entity pickupee, oldself;
	pickupee = pickuper.pickedupobject_hands;
	makevectors (pickuper.v_angle);
	if (pickuper.pickedupobject_hands == world)
		return;
	remove (pickuper.pickupthink_hands);
#ifdef GW_ALLOW_PICKUP_ITEM
	if (pickupee.flags & FL_ITEM)
{
		if (pickuper.health <= 0 || toss == 2)
{
			pickupee.movetype = 10;
			pickupee.velocity_z = pickupee.velocity_z + 10;
		}
		else
		if (ZG_ItemType(pickupee) == 1)
{
			ZG_FireItem (pickupee);
			if (pickupee.orig_origin != '0 0 0')
				pickupee.origin = pickupee.orig_origin;
			//pickupee.orig_origin = '0 0 0';
			pickupee.nextthink = time + 30;
			pickupee.mdl = pickupee.model;
			pickupee.model = string_null;
			pickupee.think = ZG_ammobox_regen;
			pickupee.th_fireball = pickupee.touch;
			pickupee.touch = SUB_Null;
		}
		else
		{
			pickupee.movetype = 10;
			pickupee.velocity = v_forward * 700;
		}
		pickuper.owner = pickuper._oldowner;
		pickuper.pickedupobject_hands = world;
		if (pickuper.health > 0)
		{
			oldself = self;
			self = pickuper;
			W_SetCurrentAmmo ();
			self = oldself;
		}
		return;
	}
#endif
	if (toss == 1)
	{
		pickupee.velocity = v_forward * 500;

		if (pickupee.oldmovetype != MOVETYPE_FLY && pickupee.oldmovetype != MOVETYPE_FLYMISSILE)
			pickupee.velocity = pickupee.velocity + v_up * 200;
	}
	else
		pickupee.velocity_z = pickupee.velocity_z + 10;	// *
	if (InSolid(pickupee))
{
		oldself = self;
		self = pickupee;
		self.velocity = '0 0 0';
		pickuper.owner = pickupee;
		droptofloor ();
		self = oldself;
	}
	pickuper.owner = pickuper._oldowner;
	pickupee.movetype = pickupee.oldmovetype;
	pickupee.pickedupobject_hands = world;			// *
	pickuper.pickedupobject_hands = world;
	if (pickuper.health > 0)
{
		oldself = self;
		self = pickuper;
		W_SetCurrentAmmo ();
		self = oldself;
	}
};
void (entity pickuper) zg_pickup =
{
	local entity thinker;
	trace_ent = zg_findtarget (pickuper);
	if (!trace_ent)
		return;
	if (pickuper.pickedupobject_hands != world)
		return;
	pickuper._oldowner = pickuper.owner;			// *
	pickuper.owner = trace_ent;					// *
	trace_ent.oldmovetype = trace_ent.movetype;
	trace_ent.movetype = MOVETYPE_FLY;
	trace_ent.pickedupobject_hands = trace_ent;		// * for knowing if it's picked up, FIXME: need to somehow know the pickuper entity
	trace_ent.flags = trace_ent.flags - FL_ONGROUND;	// *
	pickuper.pickedupobject_hands = trace_ent;
	thinker = spawn ();
	thinker.owner = pickuper;
	thinker.nextthink = time + 0.01;			// TODO: raise this?
	thinker.think = zg_think;
	pickuper.pickupthink_hands = thinker;
#ifdef GW_ALLOW_PICKUP_ITEM
	if (trace_ent.flags & FL_ITEM)
	{
		if (trace_ent.orig_origin == '0 0 0')
		{
			trace_ent.orig_origin = trace_ent.origin;
		}
	}
#endif
};
void (entity pickuper, float toss) zg_togglepickup =
{
	if (pickuper.pickedupobject_hands == world)
		zg_pickup (pickuper);
	else
		zg_drop (pickuper, toss);
};
#ifdef GW_ALLOW_PICKUP_ITEM
void () ZG_ExplosiveTouch;
float (entity test) ZG_ItemType =
{
	if (test.model == "maps/b_shell1.bsp" || test.model == "maps/b_shell0.bsp"
		|| test.model == "maps/b_nail1.bsp" || test.model == "maps/b_nail0.bsp"
		|| test.model == "maps/b_rock1.bsp" || test.model == "maps/b_rock0.bsp"
#ifdef mtf_coop_halloween
		|| test.model == "progs/pumpkin.mdl"
#endif
		|| test.model == "maps/b_batt1.bsp" || test.model == "maps/b_batt0.bsp" )
		return 1;
	if (test.model == "maps/b_bh25.bsp" || test.model == #MODEL_HEALTH_TEN
		|| test.model == #MODEL_HEALTH_HUNDRED)
		return 2;

	return 0;
};
void(entity pickupee) ZG_FireItem = 
{
	if (pickupee.model == "" || !pickupee.model)
		return;
	sound(self, TF_FLARE_OFF, "weapons/launch.wav", TF_FLARE_OFF, TF_FLARE_OFF);
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = 10;
	newmis.solid = 2;
	newmis.classname = "pipebomb";
	newmis.weapon = 5;
	newmis.classname = "grenade";
	newmis.skin = TF_FLARE_OFF;
	newmis.touch = ZG_ExplosiveTouch;
	newmis.nextthink = time + 2.5;
	makevectors(self.v_angle);
	if (self.v_angle_x)
	{
		newmis.velocity = v_forward * 1200 + v_up * 200 + crandom() * v_right * 10 + crandom() * v_up * 10;
	}
	else
	{
		newmis.velocity = aim(self, 10000);
		newmis.velocity = newmis.velocity * 1200;
		newmis.velocity_z = 200;
	}
	newmis.angles = vectoangles(newmis.velocity);
	newmis.think = ZG_ExplosiveTouch;
	setmodel(newmis, pickupee.model);
	setsize(newmis, '0 0 0', '0 0 0');
	setorigin(newmis, pickupee.origin);
};

void () ZG_ExplosiveTouch =
{
	local float damg;
	if ((pointcontents (self.origin) == -6.000000))
	{
		dremove (self);
		return;
	}
	damg = (300 + (random () * 20));
	deathmsg = self.weapon;
	if (other.health)
	{
		TF_T_Damage (other, self, self.owner, damg, 0.000000, 4);
	}
	T_RadiusDamage (self, self.owner, 250, other);
	self.origin = (self.origin - (8 * normalize (self.velocity)));
	WriteByte (4, 23);
	WriteByte (4, 3);
	WriteCoord (4, self.origin_x);
	WriteCoord (4, self.origin_y);
	WriteCoord (4, self.origin_z);
	multicast (self.origin, 1);
	BecomeExplosion ();
	dremove (self);
};

void () ZG_ammobox_regen =
{
	self.touch = self.th_fireball;
	if (self.orig_origin != '0 0 0')
{
		self.origin = self.orig_origin;
		//self.orig_origin = '0 0 0';
	}
	SUB_regen();
};
#endif
//END
