void () yield_items =
{
	if ((self.ammo_shells > 0))
	{
		throw_ammo (IT_SHELLS);
	}
	if ((self.ammo_cells > 0))
	{
		throw_ammo (IT_CELLS);
	}
	if ((self.ammo_nails > 0))
	{
		throw_ammo (IT_NAILS);
	}
	if ((self.ammo_rockets > 0))
	{
		throw_ammo (IT_ROCKETS);
	}
	if ((self.items & IT_QUAD))
	{
		throw_item (IT_QUAD);
	}
	if ((self.items & IT_SUPER_SHOTGUN))
	{
		throw_item (IT_SUPER_SHOTGUN);
	}
	if ((self.items & IT_AUTO_SHOTGUN))
	{
		throw_item (IT_AUTO_SHOTGUN);
	}
	if ((self.items & IT_SPROCKET))
	{
		throw_item (IT_SPROCKET);
	}
	if ((self.items & IT_SUPER_NAILGUN))
	{
		throw_item (IT_SUPER_NAILGUN);
	}
	if ((self.items & IT_GRENADE_LAUNCHER))
	{
		throw_item (IT_GRENADE_LAUNCHER);
	}
	if ((self.items & IT_ROCKET_LAUNCHER))
	{
		throw_item (IT_ROCKET_LAUNCHER);
	}
	if ((self.items & IT_LIGHTNING))
	{
		throw_item (IT_LIGHTNING);
	}
	if ((self.items & IT_SUPERHEALTH))
	{
		throw_item (IT_SUPERHEALTH);
	}
	if ((self.items & IT_FLIGHT))
	{
		throw_item (IT_FLIGHT);
	}
	if ((self.items & IT_SUIT))
	{
		throw_item (IT_SUIT);
	}
};
void () yield_armor =
{
	if ((self.armorvalue == 3))
	{
		throw_item (IT_ARMOR3);
		return;
	}
	if ((self.armorvalue == 2))
	{
		throw_item (IT_ARMOR2);
		return;
	}
	if ((self.armorvalue == 1))
	{
		throw_item (IT_ARMOR1);
		return;
	}
};
void (float num) precache_thrown =
{
	if ((num & IT_QUAD))
	{
		precache_model (#MODEL_QUAD);
		precache_sound ("items/damage.wav");
		precache_sound ("items/damage2.wav");
		precache_sound ("items/damage3.wav");
	}
	if ((num & IT_FLIGHT))
	{
		precache_model ("progs/flying.mdl");
		precache_sound ("items/inv1.wav");
		precache_sound ("items/inv2.wav");
		precache_sound ("items/inv3.wav");
	}
	if ((num & IT_SUIT))
	{
		precache_model ("progs/suit.mdl");
		precache_sound ("items/suit.wav");
		precache_sound ("items/suit2.wav");
	}
	if ((num & IT_SUPERHEALTH))
	{
		precache_model ("maps/b_bh25.bsp");
		precache_sound ("items/health1.wav");
	}
	precache_model ("progs/armor.mdl");
	if ((num & IT_SUPER_SHOTGUN))
	{
		precache_model ("progs/g_shot.mdl");
	}
	if ((num & IT_AUTO_SHOTGUN))
	{
		precache_model ("progs/mg_sh2.mdl");
	}
	if ((num & IT_NAILGUN))
	{
		precache_model ("progs/g_nail.mdl");
	}
	if ((num & IT_SUPER_NAILGUN))
	{
		precache_model ("progs/g_nail2.mdl");
	}
	if ((num & IT_GRENADE_LAUNCHER))
	{
		precache_model ("progs/g_rock.mdl");
	}
	if ((num & IT_ROCKET_LAUNCHER))
	{
		precache_model ("progs/g_rock2.mdl");
	}
	if ((num & IT_LIGHTNING))
	{
		precache_model ("progs/g_light.mdl");
	}
	if ((num & IT_SPROCKET))
	{
		precache_model ("progs/mg_rock2.mdl");
	}
};
void () precache_ammo =
{
	if ((self.ammo_shells > 0))
	{
		precache_model ("maps/b_shell0.bsp");
	}
	if ((self.ammo_nails > 0))
	{
		precache_model ("maps/b_nail0.bsp");
	}
	if ((self.ammo_rockets > 0))
	{
		precache_model ("maps/b_rock0.bsp");
	}
	if ((self.ammo_cells > 0))
	{
		precache_model ("maps/b_batt0.bsp");
	}
};
void (float num) throw_item =
{
	local entity item44;
	item44 = spawn ();
	item44.origin_x = (self.absmin_x + (random () * self.size_x));
	item44.origin_y = (self.absmin_y + (random () * self.size_y));
	item44.origin_z = (self.absmin_z + (random () * self.size_z));
	item44.velocity_z = 300;
	item44.velocity_x = (-100 + (random () * 200));
	item44.velocity_y = (-100 + (random () * 200));
	item44.flags = FL_ITEM;
	item44.solid = SOLID_TRIGGER;
	item44.movetype = MOVETYPE_TOSS;
	if ((num == IT_QUAD))
	{
		item44.touch = powerup_touch;
		item44.noise = "items/damage.wav";
		setmodel (item44, #MODEL_QUAD);
		item44.netname = "Quad Damage";
		item44.items = IT_QUAD;
		setsize (item44, VEC_HULL_MIN, VEC_HULL_MAX);
		return;
	}
	if ((num == IT_FLIGHT))
	{
		item44.classname = "item_artifact_flight";
		item44.touch = powerup_touch;
		item44.noise = "items/inv1.wav";
		setmodel (item44, "progs/flying.mdl");
		item44.netname = "the flying artifact";
		item44.items = IT_FLIGHT;
		setsize (item44, VEC_HULL_MIN, VEC_HULL_MAX);
		return;
	}
	if ((num == IT_SUIT))
	{
		item44.classname = "item_artifact_envirosuit";
		item44.event = "thrownsuit";
		item44.noise = "items/suit.wav";
		item44.touch = powerup_touch;
		setmodel (item44, "progs/suit.mdl");
		item44.netname = "Biosuit";
		item44.items = IT_SUIT;
		setsize (item44, VEC_HULL_MIN, VEC_HULL_MAX);
		return;
	}
	if ((num == IT_ARMOR1))
	{
		item44.classname = "item_armor1";
		item44.touch = armor_touch;
		setmodel (item44, "progs/armor.mdl");
		item44.skin = 0;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_ARMOR2))
	{
		item44.classname = "item_armor2";
		item44.touch = armor_touch;
		setmodel (item44, "progs/armor.mdl");
		item44.skin = 1;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_ARMOR3))
	{
		item44.classname = "item_armorInv";
		item44.touch = armor_touch;
		setmodel (item44, "progs/armor.mdl");
		item44.skin = FL_SWIM;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_SUPER_SHOTGUN))
	{
		item44.classname = "weapon_supershotgun";
		setmodel (item44, "progs/g_shot.mdl");
		item44.weapon = IT_SUPER_SHOTGUN;
		item44.netname = "Double Barrel Shotgun";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_AUTO_SHOTGUN))
	{
		item44.classname = "weapon_gshotgun";
		setmodel (item44, "progs/mg_sh2.mdl");
		item44.weapon = IT_AUTO_SHOTGUN;
		item44.netname = "Auto Shotgun";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_NAILGUN))
	{
		item44.classname = "weapon_nailgun";
		setmodel (item44, "progs/g_nail.mdl");
		item44.weapon = IT_NAILGUN;
		item44.netname = "Nailgun";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_SUPER_NAILGUN))
	{
		item44.classname = "weapon_supernailgun";
		setmodel (item44, "progs/g_nail2.mdl");
		item44.weapon = IT_SUPER_NAILGUN;
		item44.netname = "Super Nailgun";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_GRENADE_LAUNCHER))
	{
		item44.classname = "weapon_grenadelauncher";
		setmodel (item44, "progs/g_rock.mdl");
		item44.weapon = MOVETYPE_WALK;
		item44.netname = "Grenade Launcher";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_ROCKET_LAUNCHER))
	{
		item44.classname = "weapon_rocketlauncher";
		setmodel (item44, "progs/g_rock2.mdl");
		item44.weapon = MOVETYPE_WALK;
		item44.netname = "Rocket Launcher";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_LIGHTNING))
	{
		item44.classname = "weapon_lightning";
		setmodel (item44, "progs/g_light.mdl");
		item44.weapon = MOVETYPE_WALK;
		item44.netname = "Thunderbolt";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
	if ((num == IT_SPROCKET))
	{
		item44.classname = "weapon_sprocket";
		setmodel (item44, "progs/mg_rock2.mdl");
		item44.weapon = IT_SPROCKET;
		item44.netname = "Sprocket Launcher";
		item44.touch = weapon_touch;
		setsize (item44, '-16 -16 0', '16 16 56');
		return;
	}
};
void (float num) throw_ammo =
{
	local entity item22;
	item22 = spawn ();
	item22.origin_x = (self.absmin_x + (random () * self.size_x));
	item22.origin_y = (self.absmin_y + (random () * self.size_y));
	item22.origin_z = (self.absmin_z + (random () * self.size_z));
	item22.velocity_z = 300;
	item22.velocity_x = (-100 + (random () * 200));
	item22.velocity_y = (-100 + (random () * 200));
	item22.flags = FL_ITEM;
	item22.solid = SOLID_TRIGGER;
	item22.movetype = MOVETYPE_TOSS;
	if ((num == IT_SHELLS))
	{
		item22.classname = "item_shells";
		item22.touch = ammo_touch;
		setmodel (item22, "maps/b_shell0.bsp");
		item22.aflag = 20;
		item22.weapon = 1;
		item22.netname = "shells";
		setsize (item22, VEC_ORIGIN, '32 32 56');
		return;
	}
	if ((num == IT_NAILS))
	{
		item22.classname = "item_spikes";
		item22.touch = ammo_touch;
		setmodel (item22, "maps/b_nail0.bsp");
		item22.aflag = 25;
		item22.weapon = FL_SWIM;
		item22.netname = "nails";
		setsize (item22, VEC_ORIGIN, '32 32 56');
		return;
	}
	if ((num == IT_ROCKETS))
	{
		item22.classname = "item_rockets";
		item22.touch = ammo_touch;
		setmodel (item22, "maps/b_rock0.bsp");
		item22.aflag = MOVETYPE_FLY;
		item22.weapon = MOVETYPE_WALK;
		item22.netname = "rockets";
		setsize (item22, VEC_ORIGIN, '32 32 56');
		return;
	}
	item22.classname = "item_cells";
	item22.touch = ammo_touch;
	setmodel (item22, "maps/b_batt0.bsp");
	item22.aflag = MOVETYPE_TOSS;
	item22.weapon = MOVETYPE_STEP;
	item22.netname = "cells";
	setsize (item22, VEC_ORIGIN, '32 32 56');
};
//END