vector (vector veca, float scale, vector vecb, vector vecc) VectorMA =
{
	vecc_x = veca_x + scale*vecb_x;
	vecc_y = veca_y + scale*vecb_y;
	vecc_z = veca_z + scale*vecb_z;
	
	return vecc;
};
void WriteVector (float msg, vector org) =
{
	WriteCoord (msg, org_x);
	WriteCoord (msg, org_y);
	WriteCoord (msg, org_z);
};
#ifndef mtf_coop_halflife
void () hl_rotating =
{
	local float mvspd, realmvspd;
	mvspd = 180;
	if (!self.speed)
		realmvspd = 300;
	else
		realmvspd = self.speed;
	if (self.spawnflags & 2)
		mvspd = mvspd * -1;
	if (self.spawnflags & 4)
		self.pos1_z += mvspd;
	else if (self.spawnflags & 8)
		self.pos1_x += mvspd;
	else {
		self.pos1_y += mvspd;
	}
	SUB_CalcAngleMove (self.pos1, realmvspd, hl_rotating);
};
void () func_rotating_use =
{
	if (self.has_tesla == 0) {
		hl_rotating();
		self.has_tesla = 1;
	}
	else
	{
		self.avelocity = '0 0 0';
		self.think = SUB_Null;
		self.has_tesla = 0;
	}
};
void() rot_crush =
{
	T_Damage (other, self, self, 1);
};
void () func_rotating =
{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_PUSH;
	self.blocked = rot_crush;
	if (self.spawnflags & 64)
	{
		self.solid = 0;
	}
	else
	{
		self.solid = 4;
	}
	
	if (mapname == "c3a1a")
		if (self.speed == 35)
			self.solid = 0;
	if (mapname == "c1a1f" && self.classname == "func_rotating")
		self.solid = SOLID_NOT;
	setmodel(self, self.model);
	if (self.spawnflags & 1) {	// start on
		func_rotating_use();
	}
	self.use = func_rotating_use;
};
#endif
void () target_laser_think =
{
	local entity 	ignore;
	local vector	start;
	local vector	end;
	local vector	point;
	local vector	last_movedir;
	local float		cout;
	if (self.spawnflags & 1)
		cout = 8;
	else
		cout = 4;

	if (self.enemy)
	{
		last_movedir = self.movedir;
		point = VectorMA(self.enemy.absmin, 0.5, self.enemy.size, point);
		self.movedir = point - self.origin;
		normalize (self.movedir);
		if (self.movedir != last_movedir)
			self.spawnflags = 1;
	}
	ignore = self;
	start = self.origin;
	end = VectorMA (start, 2048, self.movedir, end);
	while(1)
	{
		traceline(start, end, 0, ignore);
		if ((trace_ent.classname == "player") || trace_ent.takedamage /*&& !(trace_ent.flags & FL_IMMUNE_LASER)*/)
			T_Damage (trace_ent, self, self, self.dmg);
		else
		{
			if (self.spawnflags & 1)
			{
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_LIGHTNING1);
	WriteEntity (MSG_MULTICAST, self/*ent*/);
	WriteVector (MSG_MULTICAST, start);
	WriteVector (MSG_MULTICAST, trace_endpos);
	multicast (start, MULTICAST_PHS);
			}
			break;
		}

		ignore = trace_ent;
		start = trace_endpos;
	}
	self.nextthink = time + .3/*FRAMETIME*/;
};
void () target_laser_on =
{
	if (!activator)
		activator = self;
	self.spawnflags = 1;
	self.think = target_laser_think;
	target_laser_think ();
};
void () target_laser_off =
{
	self.spawnflags = 0;
	self.think = SUB_Null;
	self.nextthink = 0;
};
void () target_laser_use =
{
	if (self.spawnflags & 1)
		target_laser_off ();
	else
		target_laser_on ();
};

void () target_laser_start =
{
	local entity ent;
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;
	if (self.spawnflags & 64)
		self.frame = 16;
	else
		self.frame = 4;
	if (!self.enemy)
	{
		if (self.target)
		{
			ent = find (world,targetname,self.target);
			if (!ent)
				bprint(2,"quake 2 says badness\n");
			self.enemy = ent;
		}
		else
		{
			SetMovedir();
		}
	}
	self.use = target_laser_use;
	self.think = target_laser_think;
	if (!self.dmg)
		self.dmg = 1;
	self.mins = '-8 -8 -8';
	self.maxs = '8 8 8';
	if (self.spawnflags & 1)
		target_laser_on ();
	else
		target_laser_off ();
};
void () target_laser =
{
	self.think = target_laser_start;
	self.nextthink = time + 1;
};
#ifdef mtf_coop_halflife
void() func_door_rotating_q2 =
#else
float DOOR_REVERSE		= 2;
float DOOR_X_AXIS		= 64;
float DOOR_Y_AXIS		= 128;
void() func_door_rotating =
#endif
{
	local vector blah;
   if ( (CheckExistence () == 0.000) ) {
      dremove (self);
      return ;
   }
	if (world.worldtype == 0)
	{
		precache_sound ("doors/medtry.wav");
		precache_sound ("doors/meduse.wav");
		self.noise3 = "doors/medtry.wav";
		self.noise4 = "doors/meduse.wav";
	}
	else if (world.worldtype == 1)
	{
		precache_sound ("doors/runetry.wav");
		precache_sound ("doors/runeuse.wav");
		self.noise3 = "doors/runetry.wav";
		self.noise4 = "doors/runeuse.wav";
	}
	else if (world.worldtype == 2)
	{
		precache_sound ("doors/basetry.wav");
		precache_sound ("doors/baseuse.wav");
		self.noise3 = "doors/basetry.wav";
		self.noise4 = "doors/baseuse.wav";
	}
	else
	{
		dprint ("no worldtype set!\n");
	}
	if (self.sounds == 0)
	{
		precache_sound ("misc/null.wav");
		precache_sound ("misc/null.wav");
		self.noise1 = "misc/null.wav";
		self.noise2 = "misc/null.wav";
	}
	if (self.sounds == 1)
	{
		precache_sound ("doors/drclos4.wav");
		precache_sound ("doors/doormv1.wav");
		self.noise1 = "doors/drclos4.wav";
		self.noise2 = "doors/doormv1.wav";
	}
	if (self.sounds == 2)
	{
		precache_sound ("doors/hydro1.wav");
		precache_sound ("doors/hydro2.wav");
		self.noise2 = "doors/hydro1.wav";
		self.noise1 = "doors/hydro2.wav";
	}
	if (self.sounds == 3)
	{
		precache_sound ("doors/stndr1.wav");
		precache_sound ("doors/stndr2.wav");
		self.noise2 = "doors/stndr1.wav";
		self.noise1 = "doors/stndr2.wav";
	}
	if (self.sounds == 4)
	{
		precache_sound ("doors/ddoor1.wav");
		precache_sound ("doors/ddoor2.wav");
		self.noise1 = "doors/ddoor2.wav";
		self.noise2 = "doors/ddoor1.wav";
	}
	if (self.spawnflags & DOOR_X_AXIS)
		self.movedir_z = 1.0;
	else if (self.spawnflags & DOOR_Y_AXIS)
		self.movedir_x = 1.0;
	else // Z_AXIS
		self.movedir_y = 1.0;
	if (self.spawnflags & DOOR_REVERSE)
		self.movedir = '0 0 0' - self.movedir;
	self.max_health = self.health;
	self.solid = 4.000;
	self.movetype = 7.000;
	setorigin (self, self.origin);  
	setmodel (self, self.model);
	self.classname = "door_rotating";
	self.blocked = door_blocked;
	self.use = door_use;
	if (self.spawnflags & 16.000)
		self.items = 131072;
	if (self.spawnflags & 8.000)
		self.items = 262144;
	if (!self.speed)
		self.speed = 100;
	if (!self.wait)
		self.wait = 3;
	if (!self.lip)
		self.lip = 8;
	if (!self.dmg)
		self.dmg = 2;
	self.pos1 = self.angles;
	self.pos2 = self.angles + self.movedir * self.distance;
	if (self.spawnflags & 1.000)
	{
		blah = self.angles;
		self.angles = self.pos2;
		self.pos2 = blah;
		self.pos1 = self.angles;			// 10/24/10: maybe good, maybe not?
		self.spawnflags -= 1;
	}
	self.state = 1.000;
	if (self.health)
	{
		self.takedamage = 1.000;
		self.th_die = door_killed;
	}
	if (self.items)
		self.wait = -1;
	self.touch = door_touch;
	self.think = LinkDoors;
	self.nextthink = self.ltime + 0.1;
};
void () func_timer_preuse;
void () func_timer_execute =
{
	SUB_UseTargets();
	self.think = func_timer_execute;
	self.nextthink = time + self.wait;
};
void () func_timer_pause =
{
	self.think = SUB_Null;
	self.nextthink = 0;
	
	self.use = func_timer_preuse;
};
void () func_timer_preuse =
{
	local float nt;
	nt = 0;
	self.use = func_timer_pause;
	if (self.delay) {
		nt = self.delay;
	}
	if (nt) {
		self.think = func_timer_execute;
		self.nextthink = time + nt;
	}
	else 
		func_timer_execute ();
};
void () func_timer =
{
	if (!self.target) {
		bprint(2, "func_timer without target\n");
		dremove(self);
		return;
	}
	
	if (!self.wait)
		self.wait = 1;		// not sure about this tbh, i need to look at actual q2 code some day..
	self.use = func_timer_preuse;
	if (self.spawnflags & 1) {	// start on
		if (self.pausetime) {
			self.think = func_timer_preuse;
			self.nextthink = time + self.pausetime;
			self.pausetime = 0;
		}
		else 
			func_timer_preuse ();
	}
};

#ifndef mtf_coop_halflife
void () ladder_touch_old =
{
	local vector pvec;
	if (other.classname != "player")
		return;
	makevectors (other.v_angle);
	pvec = v_forward;
	pvec = (pvec * 250);
	if (other.button2)		// jump off the ladder
		other.velocity = pvec;
	else
		other.velocity_z = pvec_z;
};
void() func_ladder =
{
	InitTrigger();
	self.touch = ladder_touch_old;
};
#endif
void () target_explosion_explode =
{
	local float		save;
	WriteByte(4, 23);
	WriteByte(4, 3);
	WriteCoord(4, self.origin_x);
	WriteCoord(4, self.origin_y);
	WriteCoord(4, self.origin_z);
	multicast(self.origin, TF_FLARE_OFF);
	T_RadiusDamage(self, activator, self.dmg+40, world);
	save = self.delay;
	self.delay = 0;
	SUB_UseTargets();
	self.delay = save;
};
void () use_target_explosion =
{
	if (!self.delay)
	{
		target_explosion_explode ();
		return;
	}

	self.think = target_explosion_explode;
	self.nextthink = time + self.delay;
};

void () target_explosion =
{
	self.use = use_target_explosion;
};
void () key_power_cube_use =
{
	bprint(2, self.netname);
	bprint(2," has been extracted\n");
	SUB_UseTargets();
	dremove(self);
};

void () key_power_cube =
{
	precache_model2("progs/v_spike.mdl");
	setmodel(self, "progs/v_spike.mdl");
	if (self.classname == "key_pyramid")
		self.netname = "pyramid key";
	else
		self.netname = "power cube";
	self.solid = SOLID_BBOX;
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.touch = key_power_cube_use;
};
void () key_pyramid =
{
	key_power_cube ();
};

void () func_explosive =
{
	func_explodable(); // from nehahra
};

void () target_changelevel =
{
	trigger_changelevel ();
};
void () func_water =
{
	func_wall(); 		// yes, because as we all know water is really solid
};

void () target_help_use =
{
	bprint(2,self.message);
	bprint(2,"\n");
};
void () target_help = 
{
	self.use = target_help_use;
};
void () target_lightramp =
{
	trigger_once ();
};

void () misc_teleporter =
{
	local vector _l_6970;
	setmodel(self, "");
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_TRIGGER;
	setsize (self, VEC_HULL_MIN, '16 16 40');
	setorigin(self, self.origin);	
	self.netname = "red keycard";
	self.touch = teleport_touch;
	if (!self.target)
	{
		objerror("no target");
	}
	self.use = teleport_use;
	if (!(self.spawnflags & 2.000000))
	{
		precache_sound ("ambience/hum1.wav");
		_l_6970 = (self.mins + self.maxs) * 0.500000;
		ambientsound (_l_6970, "ambience/hum1.wav", 0.500000, 3.000000);
	}
};

void () misc_teleporter_dest =
{
	info_teleport_destination ();
};

void () trigger_teleporter =
{
	trigger_teleport();
};

void () key_remove =
{
	if (other.classname != "player")
		return;
	bprint(2, self.netname);
	bprint(2," has been retrieved\n");
	self.has_tesla = 1;					// IE i'm activated
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	setmodel(self, string_null);
	self.think = SUB_Null;
};

void () nkey_think =
{
	local entity saf;
	if (self.frame == 0)
		self.frame = 1;
	else
		self.frame = 0;
	saf = findradius (self.origin, 40);		// orig 30 worked ok, but on ome maps was meh
	while (saf)
	{
		if (saf.classname == "player" && saf.health >= 1) {
			other = saf;
			key_remove();
		}
		saf = saf.chain;
	}
	self.nextthink = time + 0.2;
};
void () key_red_key =
{
	precache_model("progs/rkey.spr");
	setmodel(self, "progs/rkey.spr");
	self.movetype = MOVETYPE_BOUNCE;
	self.solid = SOLID_BBOX;
	setorigin(self, self.origin + '0 0 16');	
	setsize (self, '0 0 -30', '1 1 1');
	self.netname = "red keycard";
	self.touch = key_remove;
	self.think = nkey_think;
	self.nextthink = time + 0.2;
};

void () key_blue_key =
{
	precache_model("progs/bkey.spr");
	setmodel(self, "progs/bkey.spr");
	self.movetype = MOVETYPE_BOUNCE;
	self.solid = SOLID_BBOX;
	setorigin(self, self.origin + '0 0 16');	
	setsize (self, '0 0 -30', '1 1 1');
	self.netname = "blue keycard";
	self.touch = key_remove;
	self.think = nkey_think;
	self.nextthink = time + 0.2;
};

void () key_pass =
{
	precache_model("progs/ykey.spr");
	setmodel(self, "progs/ykey.spr");
	self.movetype = MOVETYPE_BOUNCE;
	self.solid = SOLID_BBOX;
	setorigin(self, self.origin + '0 0 16');	
	setsize (self, '0 0 -30', '1 1 1');
	self.netname = "yellow keycard";
	self.touch = key_remove;
	self.think = nkey_think;
	self.nextthink = time + 0.2;
};

void () trigger_key_use =
{
	local entity te;
	local float found_solid;
	te = find(world,classname,self.item);
	while (te) {
		if (te.solid != SOLID_NOT)
			found_solid = TRUE;
		if (te.has_tesla == 1) {
			te.has_tesla = 0;
			multi_use();
			bprint(2,"A door has been unlocked using the ");
			bprint(2, te.netname);
			bprint(2, "\n");
			dremove(self);
			return;
		}
		te = find(te,classname,self.item);
	}
	if (!found_solid) {			// no key exists for this door, so just open it
		multi_use();
		bprint(2,"A door has been opened\n");
		dremove(self);
		return;
	}

};

void () trigger_key =
{
	trigger_once ();
	if (#DOOM_MAP) {
		self.use = trigger_key_use;
		self.touch = SUB_Null;
	}
};

void () point_combat =
{
	path_corner ();
};

void () target_secret =
{
	self.classname = "trigger_secret";
	trigger_secret();
};

void () trigger_always =
{
	if (self.delay < 0.2)
		self.delay = 0.2;
	self.think = SUB_UseTargets;
	self.nextthink = time + .2;		// give a slight delay i guess
};

void () target_crosslevel_target =
{
	trigger_always ();			// xavior is teh lazy
};
#include "mega_quake2\infantry.qc"
#include "mega_quake2\soldier_light.qc"
#include "mega_quake2\berserk.qc"
#include "mega_quake2\bigtank.qc"
void () monster_soldier =
{
	if (#DOOM_MAP)
		monster_dsold();
	else
		monster_enf2();
};
void () monster_jorg =
{
	if (#DOOM_MAP)
		monster_spdemon();
};
void () monster_boss2 =
{
	if (#DOOM_MAP)
		monster_cdemon();
};
void () monster_chick =
{
	if (#DOOM_MAP)
		if (#DOOM2_MAP)
			monster_revenant();
		else
			monster_pinky();
};

void () monster_hover =
{
	if (#DOOM_MAP)
		monster_lsoul();
};

void () monster_gladiator =
{
	if (#DOOM_MAP)
		if (#DOOM2_MAP)
			monster_mancubus();
		else
			monster_pinky();
	else
		monster_cyberdemon ();
};
void () monster_medic =
{
	if (#DOOM_MAP)
		monster_caco();
	else
		monster_vomitus();
};
void () monster_soldier_ss =
{
	if (#DOOM_MAP)
		monster_dimp();
	else
		monster_axegrunt();
};
void () monster_parasite =
{
	monster_pinky();
};
void () monster_gunner =
{
	if (#DOOM_MAP)
		if (#DOOM2_MAP)
			monster_hgunner();
		else
			monster_sargeant();
	else
		monster_enf3();
};
void () monster_floater =
{
	if (#DOOM_MAP)
		monster_caco();
	else
		monster_wizard();
};
void () monster_flyer =
{
	if (#DOOM_MAP)
		monster_caco();
	else
		monster_wizard();
};
void () monster_brain =
{
	if (#DOOM_MAP)
		monster_dbaron();
};
void () monster_mutant =
{
	if (#DOOM_MAP) {
		self.has_tesla = 1;
		monster_pinky();
	}
	else
		monster_demon ();
};
void () monster_tank_commander =
{
	if (#DOOM_MAP) {
		if (#DOOM2_MAP)
			monster_arachnotron();
		else
			monster_spdemon();
	}
	else
		monster_demon ();
};
void () item_armor_combat =
{
	item_armor2 ();
};
void () target_goal =
{
	dremove(self);
};
void () target_splash =
{
	dremove(self);
};
void () target_spawner =
{};
//END
