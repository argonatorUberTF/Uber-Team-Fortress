void (string name, float amount) RockPieces =
{
	local entity rock;
	rock = spawn ();
	rock.origin_x = (self.absmin_x + (random () * self.size_x));
	rock.origin_y = (self.absmin_y + (random () * self.size_y));
	rock.origin_z = (self.absmin_z + (random () * self.size_z));
	setmodel (rock, name);
	setsize (rock, VEC_ORIGIN, VEC_ORIGIN);
	rock.velocity = VelocityForDamage ((amount * SPAWNFLAG_LASER));
	rock.movetype = MOVETYPE_BOUNCE;
	rock.solid = SOLID_NOT;
	rock.avelocity_x = (random () * 300);
	rock.avelocity_y = (random () * 300);
	rock.avelocity_z = (random () * 300);
	rock.think = SUB_Remove;
	rock.nextthink = ((time + 1.5) + (random () * SPAWNFLAG_SUPERSPIKE));
};
void () wall_touchie =
{
	sound (self, CHAN_WEAPON, "misc/crumble.wav", SPAWNFLAG_SUPERSPIKE, ATTN_NORM);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.absmin_x);
	WriteCoord (MSG_BROADCAST, self.absmin_y);
	WriteCoord (MSG_BROADCAST, self.absmin_z);
	self.movetype = MOVETYPE_NONE;
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	RockPieces ("progs/rubble1.mdl", self.health);
	RockPieces ("progs/rubble2.mdl", self.health);
	RockPieces ("progs/rubble3.mdl", self.health);
	remove (self);
};
void () exploding_object =
{
	precache_model ("progs/rubble1.mdl");
	precache_model ("progs/rubble2.mdl");
	precache_model ("progs/rubble3.mdl");
	precache_sound ("misc/crumble.wav");
	setmodel (self, self.model);
	if ((self.atomic_intensity == SPAWNFLAG_SUPERSPIKE))
	{
		self.takedamage = DAMAGE_NO;
	}
	else
	{
		self.takedamage = DAMAGE_YES;
	}
	self.health = 80;
	self.th_die = wall_touchie;
	self.classname = "e_oj";
	self.use = wall_touchie;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_PUSH;
};
void () walkthrough_object =
{
	setmodel (self, self.model);
	self.solid = SOLID_NOT;
	self.classname = "e_oj";
};
//END
