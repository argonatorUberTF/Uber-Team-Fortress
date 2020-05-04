void() lavaspike_touch;	
void(vector org, vector dir) launch_lava_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.touch = lavaspike_touch;
	newmis.classname = "lava_spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/lspike.mdl");	
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	setorigin (newmis, org);
	newmis.velocity = dir * 1000;
};
void() W_FireSuperLavaSpikes =
{
	local vector	dir;
	sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
	self.attack_finished = time + 0.2;
	self.currentammo = self.ammo_lava_nails = self.ammo_lava_nails - 2;
	UpdateAmmoCounts (self);
	dir = aim (self, 1000);
	launch_lava_spike (self.origin + '0 0 16', dir);
	newmis.touch = superlavaspike_touch;
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	self.punchangle_x = -2;
};
void(float ox) W_FireLavaSpikes =
{
	local vector	dir;
	makevectors (self.v_angle);
	if (self.ammo_lava_nails >= 2 && self.weapon == 8192)
	{
		W_FireSuperLavaSpikes ();
		return;
	}
	if (self.ammo_lava_nails < 1)
	{
		sprint (self, "Out of Lava Nails.\n");
		self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
	self.attack_finished = time + 0.2;
	self.currentammo = self.ammo_lava_nails = self.ammo_lava_nails - 1;
	UpdateAmmoCounts (self);
	dir = aim (self, 1000);
	launch_lava_spike (self.origin + '0 0 16' + v_right*ox, dir);
	self.punchangle_x = -2;
};
void() lavaspike_touch =
{
local float old_armortype;
local float old_armorvalue;
local float old_armormask;
	if (other == self.owner)
		return;
	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	if (other.takedamage)
	{
		spawn_touchblood (9);
		if(other.classname == "player")
		{
			old_armortype = other.armortype;
			old_armorvalue = other.armorvalue;
			old_armormask = other.items2 & (IT2_ARMOR1|IT2_ARMOR2|IT2_ARMOR3);
			other.armortype = 0;
			other.armorvalue = 0;
			T_Damage (other, self, self.owner, 9);
			other.armortype = old_armortype;
			other.armorvalue = old_armorvalue;
			other.items2 = other.items2 | old_armormask;
		}
		else		// is a monster
		{
			if ( other.classname != "monster_lava_man")
			{
				T_Damage (other, self, self.owner, 15);
			}
		}
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		
		if (self.classname == "wizspike")
			WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
		else if (self.classname == "knightspike")
			WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
		else
			WriteByte (MSG_BROADCAST, TE_SPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}
	remove(self);
};
void() superlavaspike_touch =
{
local float old_armortype;
	if (other == self.owner)
		return;
	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	if (other.takedamage)
	{
		spawn_touchblood (18);
		if(other.classname == "player")
		{
			old_armortype = other.armortype;
			other.armortype = other.armortype * 0.5;
			T_Damage (other, self, self.owner, 18);
			if(other.armortype != 0)
			{
				other.armortype = old_armortype;
			}
		}
		else		// is a monster, do 50% more damage
		{
			if ( other.classname != "monster_lava_man")
			{
				T_Damage (other, self, self.owner, 30);
			}
		}
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_SUPERSPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}
	remove(self);
};
//END