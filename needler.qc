void () NeedleExplode =
{
	self.enemy.needles -= 1;
	self.owner = self.real_owner;
	if (self.enemy.team_no != self.team_no)
		T_Damage (self.enemy, self, self.owner, 25);
		deathmsg = 1124;
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	dremove(self); // was remove(self), maybe this helps. -arg
};
void () NeedlePreExplode =
{
	local vector m_height;
	m_height_x = self.armorvalue;
	if (self.enemy.health <= 0)
	{
		remove(self);
		return;
	}
	if (time > self.health)
	{
		NeedleExplode();
		return;
	}
	self.origin = self.enemy.origin + m_height;
	self.nextthink = time + .02;
};
void ( entity f_plyr, entity t_plyr, float at_height ) Add_Needle =
{
	local entity needle;
	local float f_p_height;
	f_p_height = at_height - t_plyr.origin_x;
	if (other == world)
	{
		bprint( 2, "Add_Needle: Cannot assign to world! FIX!!\n");
		return;
	}
	if (other.health <= 0)
		return;
	t_plyr.needles += 1;
	if (t_plyr.needles >= 7)
	{
		t_plyr.needles -= 7;
		if (t_plyr.team_no != f_plyr.team_no)
			T_Damage (t_plyr, self, f_plyr, 150);
		deathmsg = 1124;
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_EXPLOSION);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
		dremove(self);  //was remove -arg
		return;
	}
	needle = spawn();
	needle.classname = "needle";
	needle.touch = SUB_Null;
	needle.solid = SOLID_NOT;
	needle.movetype = MOVETYPE_FLY;
	needle.health = time + 3;
	needle.armorvalue = f_p_height;
	needle.enemy = t_plyr;
	needle.owner = f_plyr;
	needle.team_no = f_plyr.team_no;
	needle.real_owner = f_plyr;
	setmodel (needle, "progs/flare.mdl");
	needle.think = NeedlePreExplode;
	needle.nextthink = time;
};
void () Needler_Touch =
{
	self.owner = self.real_owner;
	if (other.takedamage != FALSE && other.health > 0)
		{
			if (other.team_no != self.team_no)
				T_Damage (other, self, self.owner, 10);	//was 7 -arg
			deathmsg = 1124;
			Add_Needle(self.owner, other, self.origin_x);
		}
	else
		if (self.lives > 0)
			{
				Bounce_Off_Walls ();
				self.lives -= 1;
				self.armorvalue = self.armorvalue -1;
				return;
			}
	if (self.armorvalue < time)
		{
			dremove(self); //was remove, prevents needles from flying forever and overloading ents causing the monsters falling through floor I bet -arg
		}
	// there was a remove here, added extra not sure if it needs to be here or as dremove -arg
};
void() NeedlerHome =
{
	local vector dir, vtemp, wantdir;
	local entity te;
	local float maxmove;
	maxmove = 55;		// maximum xyz value we're allowed to change in mid-air
	if (self.enemy != world && self.enemy.health > 0)
	{
		vtemp = (self.enemy.origin + '0 0 10');
		dir = normalize ((vtemp - self.origin));
		wantdir = (dir * 550);
		wantdir_x = wantdir_x - self.velocity_x;
		if (wantdir_x > maxmove)
			wantdir_x = maxmove;
		if (wantdir_x < -maxmove)
			wantdir_x = -maxmove;
		wantdir_y = wantdir_y - self.velocity_y;
		if (wantdir_y > maxmove)
			wantdir_y = maxmove;
		if (wantdir_y < -maxmove)
			wantdir_y = -maxmove;
		wantdir_z = wantdir_z - self.velocity_z;
		if (wantdir_z > maxmove)
			wantdir_z = maxmove;
		if (wantdir_z < -maxmove)
			wantdir_z = -maxmove;
		self.velocity += wantdir;//(dir * 550);
	}
	else
	{
		te = findradius(self.origin, 950);
		while (te)
		{
			if ( (te.classname == "player" || te.flags & FL_MONSTER) && te.health > 0 && te != self.owner && visible2(te, self))	// 2012: added if visible code..
			{
				self.enemy = te;
			}
			te = te.chain;
		}
	}
	self.angles = vectoangles (self.velocity);
	self.nextthink = (time + 0.5);
	self.think = NeedlerHome;
};
void() W_FireNeedler =
{
	local entity fshell;
	local vector spread;
	sound (self, CHAN_WEAPON, "buttons/airbut1.wav", 1, ATTN_NORM); 
	spread = '0.04 0.04 0';
	self.needler_heat += 1;
	self.ammo_shells -= 1;
	self.currentammo = (self.ammo_shells);
	fshell = spawn ();
	fshell.classname = "needles";
	fshell.owner = self;
	fshell.real_owner = self;
	fshell.team_no = self.team_no;
	fshell.movetype = 9;
	fshell.solid = 2;
	makevectors (self.v_angle);
	fshell.velocity = v_forward + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
	fshell.velocity = (fshell.velocity * 550);
	fshell.velocity = fshell.velocity + (fshell.velocity * MTF_Coop_AttribGain(self, #ATTRIB_PROJECTILE));
	fshell.angles = vectoangles (fshell.velocity);
	fshell.touch = Needler_Touch;
	fshell.armorvalue = time + 15;		// amount of time the needler projectile should stay alive
	fshell.nextthink = (time + 0.2);
	fshell.think = NeedlerHome;
	fshell.lives = 2;					// number of times the needle will bounce off walls
	setmodel (fshell, "progs/flare.mdl");
	setsize (fshell, '0 0 0', '0 0 0');
	setorigin (fshell, ((self.origin + (v_forward * 8)) + '0 0 16'));  //setorigin (fshell, ((self.origin + (v_forward * 8)) + '0 0 16'));
};
//END