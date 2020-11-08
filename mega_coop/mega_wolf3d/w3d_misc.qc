void() ai_sprite_orient =
{
	local entity	clienta, closest_client;
	local float		tmpang, totang, best_client_dist;
		if (self.think != self.th_stand && (self.oframe != 8 && self.oframe != 16 && self.oframe != 24 && self.oframe != 32))
			if ( (coop) || (deathmatch) )
				return;
		best_client_dist = 9999;
		clienta = find(world, classname, "player");
		while (clienta)
		{
			if (coop_visible(self, clienta))
				break;
			if (vlen (self.origin - clienta.origin) < best_client_dist)
			{
				best_client_dist = vlen (self.origin - clienta.origin);
				closest_client = clienta;
			}
			clienta = find(clienta, classname, "player");
		}
		if (!clienta)
			if (!closest_client)
				return;
			else
				clienta = closest_client;
		tmpang = mathlib_anglemod(clienta.angles_y);
		totang = mathlib_anglemod(self.angles_y - tmpang);
		if (totang < 157.5 && totang >= 112.5)
			self.frame = self.frame + 1;
		else
		if (totang < 112.5 && totang >= 67.5)
			self.frame = self.frame + 2;
		else
		if (totang < 67.5 && totang >= 22.5)
			self.frame = self.frame + 3;
		else
		if (totang < 22.5 || totang >= 337.5)
			self.frame = self.frame + 4;
		else
		if (totang < 337.5 && totang >= 292.5)
			self.frame = self.frame + 5;
		else
		if (totang < 292.5 && totang >= 247.5)
			self.frame = self.frame + 6;
		else
		if (totang < 247.5 && totang >= 202.5)
			self.frame = self.frame + 7;
};
void(vector dir) FireMonsterBullets =
{
	local	vector	 org;
	local float		damg, hitchance, endist;
	local entity	sstemp;
	traceline (self.origin, self.origin + dir*2048, FALSE, self);
	if (trace_fraction == 1.0)
		return;
	if (trace_ent.takedamage && trace_ent.classname == "player")
	{
		endist = ai_distance(self.enemy);
		if (self.classname == "monster_ss" || self.classname == "monster_boss")
			endist = (endist*2) / 3;
		if (self.enemy.velocity_x >= 160 || self.enemy.velocity_x <= -160 || self.enemy.velocity_y >= 160 || self.enemy.velocity_y <= -160)
		{
			hitchance = 160;
		}
		else
		{
			hitchance = 256;
		}
		sstemp = self;
		self = self.enemy;
		if (infront(sstemp))
			hitchance = hitchance - (endist*16);
		else
			hitchance = hitchance - (endist*8);
		self = sstemp;
		org = trace_endpos - v_forward*4;
		if (random()*256 < hitchance)
		{
			if (endist < 2)
			{
				damg = rint(random()*64);
			}
			else
			if (endist < 4)
			{
				damg = rint(random()*32);
			}
			else
			{
				damg = rint(random()*16);
			}
			T_Damage (trace_ent, self, self, damg);
		}
	}
};
void(string muzspr, float muztime, float mzlfrm) ai_monster_fire =
{
	local	vector	dir;
	self.effects = self.effects | EF_MUZZLEFLASH;
	ai_face();
	if (self.classname == "monster_ss")
		sound (self, CHAN_WEAPON, "024.wav", 1, ATTN_NORM);	
	else
	if (self.classname == "monster_boss")
		sound (self, CHAN_WEAPON, "022.wav", 1, ATTN_NORM);	
	else
		sound (self, CHAN_WEAPON, "049.wav", 1, ATTN_NORM);	
	dir = normalize (self.enemy.origin - self.origin);
	FireMonsterBullets (dir);
};
void() DropAmmo =
{};
void() DropGun =
{};
void() DropKey =
{
	local entity item33;
	local	vector	item_org;
	if (deathmatch)
		return;
	item33 = spawn();
	item_org_x = floor(self.origin_x / 64)*64 + 32;
	item_org_y = floor(self.origin_y / 64)*64 + 32;
	item_org_z = self.origin_z;
	setorigin (item33, item_org);
	item33.solid = SOLID_TRIGGER;
	item33.movetype = MOVETYPE_TOSS;
	setmodel (item33, "sprites/items/!keys.spr");
	item33.netname = "gold key";
	item33.items = IT_KEY2;
	setsize (item33, '-16 -16 -32', '16 16 24');
	item33.classname = "backpack";
	item33.touch = key_touch;
};
void() trigger_area_touch =
{
	if (other.health <= 0)
		return;
	other.area = self.area;
};
void() trigger_area =
{
	if (deathmatch == 1)
	{
		dremove(self);
		return;
	}
	if (!self.area)
		self.area = 1;
	InitTrigger ();
	self.touch = trigger_area_touch;
};
void() treasure_touch =
{
	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
	if (self.frame == 1)
	{
		self.ammo_nails = 5;
		sound (other, CHAN_ITEM, "lsfx/036.wav", 1, ATTN_NORM);
	}
	else
	if (self.frame == 2)
	{
		self.ammo_nails = 10;
		sound (other, CHAN_ITEM, "lsfx/037.wav", 1, ATTN_NORM);
	}
	else
	if (self.frame == 3)
	{
		self.ammo_nails = 50;
		sound (other, CHAN_ITEM, "lsfx/045.wav", 1, ATTN_NORM);
	}
	else
	{
		self.ammo_nails = 1;
		sound (other, CHAN_ITEM, "lsfx/035.wav", 1, ATTN_NORM);
	}
	if (coop || deathmatch)
		T_Heal(other, 4, 1);
	if (!deathmatch)
	{
		other.ammo_nails = other.ammo_nails + self.ammo_nails;
		if (other.ammo_nails >= 400)
		{
			sound (other, CHAN_ITEM, "lsfx/044.wav", 1, ATTN_NORM);
			other.ammo_nails = other.ammo_nails - 400;
			if (!coop)
			{
				if (other.ammo_cells < 9)
					other.ammo_cells = other.ammo_cells + 1;
			}
		}
		other.armorvalue = other.ammo_nails;
	}
	stuffcmd (other, "bf\n");
	if (!deathmatch)
	{
		found_secrets = found_secrets + 1;
		WriteByte (MSG_ALL, SVC_FOUNDSECRET);
	}
	self.solid = SOLID_NOT;
	self.model = string_null;
	if (deathmatch)
	{
		self.nextthink = time + 30;
		self.think = SUB_regen;
	}
	activator = other;
	SUB_UseTargets();
};
void() item_treasure =
{
	precache_model("sprites/items/!treasure.spr");
	setmodel(self, "sprites/items/!treasure.spr");
//	precache_sound ("lsfx/035.wav");	//temporarily not caching to provide space to main weapons and sounds -arg
//	precache_sound ("lsfx/036.wav");	//temporarily not caching to provide space to main weapons and sounds -arg
//	precache_sound ("lsfx/037.wav");	//temporarily not caching to provide space to main weapons and sounds -arg
//	precache_sound ("lsfx/045.wav");	//temporarily not caching to provide space to main weapons and sounds -arg
	if (!self.frame)
		self.frame = 0;
	if (!deathmatch)
		total_secrets = total_secrets + 1;
	self.touch = treasure_touch;
	setsize (self, '-16 -16 -32', '16 16 24');
	StartItem ();
};
void() wammo_touch =
{
local entity	sstemp;
local float		best;
	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
	sstemp = self;
	self = other;
	best = W_BestWeapon();
	self = sstemp;
	if (other.ammo_shells >= 99)
		return;
	other.ammo_shells = other.ammo_shells + self.aflag;
	bound_other_ammo (other);
	sound (other, CHAN_ITEM, "lsfx/031.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");
	sstemp = self;
	self = other;
		self.currentammo = self.ammo_shells;
	self = sstemp;
	if (self.classname == "backpack")
		dremove(self);
	else
	{
		self.model = string_null;
		self.solid = SOLID_NOT;
		if (deathmatch >= 1)
		{
			self.nextthink = time + 30;
			self.think = SUB_regen;
		}
		activator = other;
		SUB_UseTargets();
	}
}; void() item_ammo =
{
	local float rs;
	rs = rint(random() * 4);
	self.weapon = rs;
	rs = rint(random() * 16 + 16);
	self.aflag = rs;
	self.touch = ammo_touch;
	precache_model( "sprites/items/!weapons.spr" );
	setmodel (self, "sprites/items/!weapons.spr");
	self.frame = 0;
	self.aflag = 8;
	self.netname = "bullets";
	setsize (self, '-16 -16 -32', '16 16 24');
	StartItem ();
};
void() wolf_decor =
{
	if (!self.model)
	{
		precache_model ("sprites/decor/!wolfdeco.spr");
		setmodel (self, "sprites/decor/!wolfdeco.spr");
	}
	else
	{
		precache_model (self.model);
		setmodel (self, self.model);
	}
	if (!self.frame)
		self.frame = 0;
	if (total_static_decor < 124)
{
		total_static_decor = total_static_decor + 1;
		makestatic (self);
	}
};
void() pushwall_done =
{
	self.state = STATE_TOP;
	found_secrets = found_secrets + 1;
	WriteByte (MSG_ALL, SVC_FOUNDSECRET);
	dremove(self.trigger_field);
};
void() pushwall_use =
{
	if (self.state == STATE_UP)
		return;	
	if (self.state == STATE_TOP)
		return;
	sound (self, CHAN_VOICE, "034.wav", 1, ATTN_NORM);
	self.state = STATE_UP;
	SUB_CalcMove (self.pos2, self.speed, pushwall_done);
};
void() pushwall_blocked =
{
	T_Damage (other, self, self, 35);
};
void() pushwall_killed =
{
	self.health = self.max_health;
	self.takedamage = DAMAGE_NO;
	pushwall_use ();
};
void() pushwall_trigger_touch =
{
	local vector	testingz;
	local entity	sstemp, testorz;
	if (other.health <= 0)
		return;
	if (other.flags & FL_MONSTER)
		return;
	if (other.classname == "player" && other.impulse != 15)
		return;
	if (time < self.attack_finished)
		return;
	self.attack_finished = time + 0.5;
	testingz_x = (self.owner.mins_x + self.owner.maxs_x) / 2;
	testingz_y = (self.owner.mins_y + self.owner.maxs_y) / 2;
	testingz_z = (self.owner.mins_z + self.owner.maxs_z) / 2;
	testorz = spawn();
	testorz.origin = testingz;
	sstemp = self;
	self = other;
	if (!infront(testorz))
		return;
	self = sstemp;
	dremove(testorz);
	activator = other;
	self = self.owner;
	pushwall_use ();
};
entity(vector fmins, vector fmaxs) spawn_pushwall_field =
{
	local entity	trigger;
	trigger = spawn();
	trigger.movetype = MOVETYPE_NONE;
	trigger.solid = SOLID_TRIGGER;
	trigger.owner = self;
	trigger.touch = pushwall_trigger_touch;
	if (self.movedir_x >= 1)
		setsize (trigger, fmins - '32 0 0', fmaxs - '64 0 0');
	else
if (self.movedir_x <= -1)
		setsize (trigger, fmins + '64 0 0', fmaxs + '32 0 0');
	else
if (self.movedir_y >= 1)
		setsize (trigger, fmins - '0 32 0', fmaxs - '0 64 0');
	else
if (self.movedir_y <= -1)
		setsize (trigger, fmins + '0 64 0', fmaxs + '0 32 0');
	else
		setsize (trigger, fmins - '32 32 0', fmaxs + '32 32 0');
	return (trigger);
};
void() pushwall_spawn_trigger =
{
	if (self.health)
		return;
	if (self.targetname)
		return;
	self.trigger_field = spawn_pushwall_field(self.mins, self.maxs);
};
void() func_pushwall =
{
//	precache_sound ("034.wav");		//temporarily not caching to provide space to main weapons and sounds -arg
	SetMovedir ();
	total_secrets = total_secrets + 1;
	self.max_health = self.health;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	setorigin (self, self.origin);	
	setmodel (self, self.model);
	self.classname = "pushwall";
	self.blocked = pushwall_blocked;
	self.use = pushwall_use;
	self.speed = 30;
	if (!self.lip)
		self.lip = 64;
	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir*(fabs(self.movedir*self.size) + self.lip);
	self.health = 1;
	if (self.health)
	{
		self.takedamage = DAMAGE_YES;
		self.th_die = pushwall_killed;
	}

	self.state = STATE_BOTTOM;
	self.think = pushwall_spawn_trigger;
	self.nextthink = self.ltime + 0.1;
};
void() item_key =
{
	if (deathmatch)
		dremove(self);
	precache_model ("sprites/items/!keys.spr");
//	precache_sound ("lsfx/012.wav");		//temporarily not caching to provide space to main weapons and sounds -arg
	setmodel (self, "sprites/items/!keys.spr");
	if (self.frame == 0)
	{
		self.netname = "gold key";
		self.items = IT_KEY2;
	}
	else
	{
		self.frame = 1;
		self.netname = "silver key";
		self.items = IT_KEY1;
	}
	self.touch = key_touch;
	setsize (self, '-16 -16 -32', '16 16 24');
	StartItem ();
};
void() life_touch =
{
	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
	sound (other, CHAN_ITEM, "lsfx/044.wav", 1, ATTN_NORM);
	if ( (coop) || (deathmatch) )
		other.health = 200;
	else
	{
		if (other.ammo_cells < 9)
			other.ammo_cells = other.ammo_cells + 1;
		other.health = 100;
	}
	other.ammo_shells = other.ammo_shells + 25;
	bound_other_ammo (other);
	other.currentammo = other.ammo_shells;
	stuffcmd (other, "bf\n");
	if (!deathmatch)
	{
		found_secrets = found_secrets + 1;
		WriteByte (MSG_ALL, SVC_FOUNDSECRET);
	}
	self.model = string_null;
	self.solid = SOLID_NOT;
	if (deathmatch)
	{
		self.nextthink = time + 30;
		self.think = SUB_regen;
	}
	activator = other;
	SUB_UseTargets();
};
void() item_life =
{
	precache_model("sprites/items/life.spr");
	setmodel(self, "sprites/items/life.spr");
	self.frame = 0;
	if (!deathmatch)
		total_secrets = total_secrets + 1;
	self.touch = life_touch;
	setsize (self, '-16 -16 -32', '16 16 24');
	StartItem ();
};
void() wolfdoor_go_down;
void() wolfdoor_go_up;
void() wolfdoor_blocked =
{
	if (self.wait >= 0)
	{
		if (self.state == STATE_DOWN)
			wolfdoor_go_up ();
		else
			wolfdoor_go_down ();
	}
};
void() wolfdoor_hit_top =
{
	self.state = STATE_TOP;
	self.think = wolfdoor_go_down;
	self.nextthink = self.ltime + self.wait;
};
void() wolfdoor_hit_bottom =
{
	dremove(self.oldenemy);
	self.state = STATE_BOTTOM;
};
void() wolfdoor_go_down =
{
	local vector	testingz;
	local entity	head;
	if (intermission_running)
	{
		self.wait = -1;
		return;
	}
	testingz_x = (self.mins_x + self.maxs_x) / 2;
	testingz_y = (self.mins_y + self.maxs_y) / 2;
	testingz_z = (self.mins_z + self.maxs_z) / 2;
	head = findradius(testingz, 24);
	while (head)
	{
		if ((head.flags & FL_MONSTER) || (head.classname == "player"))
		{
			if (head.health <= 0)
				self.wait = -1;
			self.nextthink = self.ltime + 1.5;
			self.think = wolfdoor_go_down;
			return;
		}
		if (head)
			head = head.chain;
	}
	sound (self, CHAN_VOICE, "007.wav", 1, ATTN_NORM);
	if (self.max_health)
	{
		self.takedamage = DAMAGE_YES;
		self.health = self.max_health;
	}
	self.state = STATE_DOWN;
	SUB_CalcMove (self.pos1, self.speed, wolfdoor_hit_bottom);
};
void() wolfdoor_checker =
{
	local entity	head;
	if (self.owner == world)
		if (self.real_owner)
			self.owner = self.real_owner;
	if (self.owner.state == STATE_BOTTOM)
	{
		head = nextent(world);
		while (head != world)
		{
			if ( (head.health > 0) && (head.solid == SOLID_SLIDEBOX) )
			{
				if (head.temparea & self.owner.area1)
					head.temparea = head.temparea - (head.temparea & self.owner.area1);
				if (head.temparea & self.owner.area2)
					head.temparea = head.temparea - (head.temparea & self.owner.area2);
			}
			head = nextent(head);
		}
		return;
	}
	head = nextent(world);
	while (head != world)
	{
		if ( (head.health > 0) && (head.solid == SOLID_SLIDEBOX) )
		{
			if ( (head.area == self.owner.area1) || (head.area == self.owner.area2) )
			{
				head.temparea = head.temparea | self.owner.area1 | self.owner.area2;
				head.area_finished = time + 0.15;
			}
		}
		head = nextent(head);
	}
	self.nextthink = time + 0.1;
};
void() wolfdoor_go_up =
{
	if (self.state == STATE_UP)
		return;	
	if (self.state == STATE_TOP)
	{
		return;
	}
	if ( (self.state != STATE_DOWN) && (self.area1) )
	{
		newmis = spawn ();
		newmis.owner = self;
		newmis.origin = '0 0 0';
		newmis.nextthink = time + 0.1;
		newmis.think = wolfdoor_checker;
		self.oldenemy = newmis;
	}
	sound (self, CHAN_VOICE, "010.wav", 1, ATTN_NORM);
	self.state = STATE_UP;
	SUB_CalcMove (self.pos2, self.speed, wolfdoor_hit_top);
	SUB_UseTargets();
};
void() wolfdoor_fire =
{
	if (self.state == STATE_TOP && activator.classname == "player")
	{
		wolfdoor_go_down ();
		return;
	}
	wolfdoor_go_up ();
};
void() wolfdoor_use =
{
	self.message = "";	
	wolfdoor_fire ();
};
void() wolfdoor_trigger_touch =
{
	local vector	testingz;
	local entity	sstemp, testorz;
	if (self.real_owner != self.owner)
		self.owner = self.real_owner;
	if (other.health <= 0)
		return;
	if (other.classname == "monster_dog")
		return;
	if ((other.flags & FL_MONSTER) && (!other.goalentity))
		return;
	if (time < self.attack_finished)
		return;
	self.attack_finished = time + 0.1;
	testingz_x = (self.owner.mins_x + self.owner.maxs_x) / 2;
	testingz_y = (self.owner.mins_y + self.owner.maxs_y) / 2;
	testingz_z = (self.owner.mins_z + self.owner.maxs_z) / 2;
	testorz = spawn();
	testorz.origin = testingz;
	testorz.classname = "testorz";
	sstemp = self;
	self = other;
	if (!infront(testorz))
	{
		dremove(testorz);
		return;
	}
	self = sstemp;
	dremove(testorz);
	if ( (self.owner.items & other.items) != self.owner.items)
	{
		if (!deathmatch)
		{
			if (other.classname == "player")
				sound (other, CHAN_VOICE, "lsfx/006.wav", 1, ATTN_NORM);
			return;
		}
	}
	if (self.owner.items)
		self.owner.items = self.owner.items - (self.owner.items & self.owner.items);
	activator = other;
	self = self.owner;
	wolfdoor_use ();
};
void() wolfdoor_killed =
{
	self.health = self.max_health;
	self.takedamage = DAMAGE_NO;
	wolfdoor_use ();
};
void() wolfdoor_touch =
{
	if (other.classname != "player")
		return;
	if (self.attack_finished > time)
		return;
	self.attack_finished = time + 1.9;
	if (self.message != "")
	{
		centerprint (other, self.message);
	}
};
void() WolfLinkDoors;
void() func_wolfdoor =
{
//	precache_sound ("010.wav");		//temporarily not caching to provide space to main weapons and sounds -arg
//	precache_sound ("007.wav");		//temporarily not caching to provide space to main weapons and sounds -arg
//	precache_sound ("lsfx/006.wav");//temporarily not caching to provide space to main weapons and sounds -arg
	SetMovedir ();
	self.max_health = self.health;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
	setorigin (self, self.origin);	
	setmodel (self, self.model);
	self.classname = "door";
	self.blocked = wolfdoor_blocked;
	self.use = wolfdoor_use;
	if (self.spawnflags & DOOR_SILVER_KEY)
		self.items = IT_KEY1;
	if (self.spawnflags & DOOR_GOLD_KEY)
		self.items = IT_KEY2;
	if (!self.speed)
		self.speed = 65;
	if (!self.wait)
		self.wait = 4.2857;
	if (!self.lip)
		self.lip = 0;
	if (!self.dmg)
		self.dmg = 2;
	if (deathmatch == 1)
	{
		self.area1 = 0;
		self.area2 = 0;
	}
	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir*(fabs(self.movedir*self.size) - self.lip);
	if (self.spawnflags & DOOR_START_OPEN)
	{
		setorigin (self, self.pos2);
		self.pos2 = self.pos1;
		self.pos1 = self.origin;
	}
	self.state = STATE_BOTTOM;
	if (self.health)
	{
		self.takedamage = DAMAGE_YES;
		self.th_die = wolfdoor_killed;
	}
	self.touch = wolfdoor_touch;
	self.think = WolfLinkDoors;
	self.nextthink = self.ltime + 0.1;
};
void() WolfLinkDoors =
{
	if (self.health)
		return;
	if (self.targetname)
		return;
	self.trigger_field = spawn_field(self.mins, self.maxs);
};
//END