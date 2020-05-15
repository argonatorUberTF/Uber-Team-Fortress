#ifdef mtf_coop_bloodmod
float MAX_t_dropS    = 74;
#else
float MAX_t_dropS    = 12;
#endif
void () streak;
void () WIPE_UP_BLOOD =
{
	num_blooddrops = (num_blooddrops - SPAWNFLAG_SUPERSPIKE);
	remove (self);
};
void () bd =
{
	if (self.aqua_sound)
	{
		self.think = bd;
		self.nextthink = (time + 0.8);
		self.frame = (self.frame + SPAWNFLAG_SUPERSPIKE);
		if ((self.frame > TE_LIGHTNING2))
		{
			WIPE_UP_BLOOD ();
		}
	}
	else
	{
		self.think = bd;
		self.nextthink = (time + 0.2);
		self.frame = (self.frame - SPAWNFLAG_SUPERSPIKE);
		if ((self.frame <= self.warp_factor))
		{
			self.aqua_sound = SPAWNFLAG_SUPERSPIKE;
			self.nextthink = (time + SPAWNFLAG_SUPERSPIKE);
		}
	}
#ifdef mtf_coop_bloodmod
		SpawnBlood (self.origin, 0);
#endif
};
void () blooddrops =
{
	local vector spot;
	local entity t_drop;
	random ();
	if ((random () > ((0.8 * (MAX_t_dropS - num_blooddrops)) / MAX_t_dropS)))
	{
		return;
	}
	t_drop = spawn ();
	num_blooddrops = (num_blooddrops + SPAWNFLAG_SUPERSPIKE);
	traceline (self.origin, '0 0 -4096', TRUE, self);
	spot_x = (trace_endpos_x + (crandom () * TE_LIGHTNING2));
	spot_y = (trace_endpos_y + (crandom () * TE_LIGHTNING2));
	spot_z = trace_endpos_z;
	setorigin (t_drop, spot);
	t_drop.angles = vectoangles (trace_plane_normal);
	t_drop.angles_x = (t_drop.angles_x - 90);
	setmodel (t_drop, "progs/bdrop.mdl");
	setsize (t_drop, VEC_ORIGIN, VEC_ORIGIN);
	t_drop.solid = SOLID_NOT;
	t_drop.movetype = MOVETYPE_BOUNCE;
	t_drop.owner = self;
	t_drop.frame = TE_LIGHTNING2;
	t_drop.aqua_sound = MSG_BROADCAST;
	t_drop.warp_factor = floor ((random () * 6.99));
	t_drop.think = bd;
	t_drop.nextthink = time;
};
void () wallsplat =
{
	local vector dir;
#ifdef mtf_coop_bloodmod
	local vector dir2, dir3;
#endif
	local vector direction;
	local float bcount;
	local entity t_drop;
	if ((random () < 0.2))
	{
		streak ();
		return;
	}
	dir = ((self.origin + '0 0 40') - (damage_attacker.origin + '0 0 20'));
#ifdef mtf_coop_bloodmod
	dir2 = ((damage_attacker.origin + '0 0 20') - (self.origin + '0 0 40'));
	dir3 = ((self.origin + '0 0 40') - ((damage_attacker.origin + '0 0 20')*random()));
#endif
	makevectors (dir);
	bcount = floor (((SPAWNFLAG_LASER * (MAX_t_dropS - num_blooddrops)) / AS_MELEE));
#ifdef mtf_coop_bloodmod
	bcount = floor (self.health / 12);
#endif
	while ((bcount > MSG_BROADCAST))
	{
		if ((num_blooddrops >= MAX_t_dropS))
		{
			return;
		}
#ifdef mtf_coop_bloodmod
		if (random() < 0.5)
{
			direction = ((dir3 + ((crandom ()*2 * SVC_INTERMISSION) * v_right)) + ((crandom ()*2 * SVC_INTERMISSION) * v_up));
		}
		else
if (random() < 0.5)
{
			direction = ((dir2 + ((crandom ()*2 * SVC_INTERMISSION) * v_right)) + ((crandom ()*2 * SVC_INTERMISSION) * v_up));
		}
		else
			direction = ((dir + ((crandom ()*2 * SVC_INTERMISSION) * v_right)) + ((crandom ()*2 * SVC_INTERMISSION) * v_up));
#else
		direction = ((dir + ((crandom () * SVC_INTERMISSION) * v_right)) + ((crandom () * SVC_INTERMISSION) * v_up));
#endif
		traceline (self.origin, (direction * IT_CELLS), TRUE, self);
		if (trace_fraction < 1 && !trace_ent)
{
			t_drop = spawn ();
			num_blooddrops = (num_blooddrops + SPAWNFLAG_SUPERSPIKE);
			setorigin (t_drop, (trace_endpos + trace_plane_normal));
			setmodel (t_drop, "progs/bdrop.mdl");
			setsize (t_drop, VEC_ORIGIN, VEC_ORIGIN);
			t_drop.solid = SOLID_NOT;
			t_drop.movetype = MOVETYPE_NONE;
			t_drop.owner = self;
			t_drop.frame = floor ((random () * 6.99));
			t_drop.angles = vectoangles (trace_plane_normal);
			t_drop.angles_x = (t_drop.angles_x - 90);
			t_drop.think = bd;
			t_drop.aqua_sound = SPAWNFLAG_SUPERSPIKE;
			t_drop.nextthink = ((time + SPAWNFLAG_SUPERSPIKE) + random ());
		}
		bcount = (bcount - SPAWNFLAG_SUPERSPIKE);
	}
};
void () streak =
{
	local vector dir;
	local vector direction;
	local vector spiral;
	local vector UP;
	local vector RIGHT;
	local float bcount;
	local float tightness;
	local float hypo;
	local entity t_drop;
	tightness = (SVC_INTERMISSION + (crandom () * SVC_SETVIEWPORT));
	if ((random () < 0.5))
	{
		tightness = (MSG_BROADCAST - tightness);
	}
	hypo = (SVC_CUTSCENE + (crandom () * SVC_SETVIEWPORT));
	dir = ((self.origin + '0 0 40') - (damage_attacker.origin + '0 0 20'));
	makevectors (dir);
	UP = v_up;
	RIGHT = v_right;
	bcount = MSG_BROADCAST;
	while ((bcount < TE_WIZSPIKE))
	{
		if ((num_blooddrops >= MAX_t_dropS))
		{
			return;
		}
		makevectors (spiral);
		spiral_y = (spiral_y + tightness);
		direction = ((dir + ((hypo * RIGHT) * v_forward_x)) + ((hypo * UP) * v_forward_y));
		traceline (self.origin, (direction * IT_CELLS), TRUE, self);
		t_drop = spawn ();
		num_blooddrops = (num_blooddrops + SPAWNFLAG_SUPERSPIKE);
		setorigin (t_drop, (trace_endpos + trace_plane_normal));
		setmodel (t_drop, "progs/bdrop.mdl");
		setsize (t_drop, VEC_ORIGIN, VEC_ORIGIN);
		t_drop.solid = SOLID_NOT;
		t_drop.movetype = MOVETYPE_NONE;
		t_drop.owner = self;
		t_drop.frame = bcount;
		t_drop.angles = vectoangles (trace_plane_normal);
		t_drop.angles_x = (t_drop.angles_x - 90);
		t_drop.think = bd;
		t_drop.aqua_sound = SPAWNFLAG_SUPERSPIKE;
		t_drop.nextthink = ((time + SPAWNFLAG_SUPERSPIKE) + random ());
		bcount = (bcount + SPAWNFLAG_SUPERSPIKE);
	}
};
#ifdef mtf_coop_bloodmod
void () SpawnMeatSprayBloody_Touch =
{
	local entity datk;
	datk = spawn();
	datk.origin = self.orig_origin;
	damage_attacker = datk;
	wallsplat();
	dremove(datk);
};
#endif
//END
