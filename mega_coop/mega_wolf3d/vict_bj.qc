void(float dist) bj_walk =
{
	movedist = dist;
	movetogoal (dist);
};
void() bj_run1	=[	0,	bj_run1b	] {bj_walk(10.24);};	// 12 tics
void() bj_run1b	=[	0,	bj_run1s	] {self.nextthink = time + 0.0714; bj_walk(10.24);};	// 12 tics
void() bj_run1s	=[	0,	bj_run2	] {self.nextthink = time + 0.0429;};		//  3
void() bj_run2	=[	1,	bj_run2b	] {bj_walk(10.24);};	//  8
void() bj_run2b	=[	1,	bj_run3	] {self.nextthink = time + 0.0143; bj_walk(10.24);};	//  8
void() bj_run3	=[	2,	bj_run3b	] {bj_walk(10.24);};
void() bj_run3b	=[	2,	bj_run3s	] {self.nextthink = time + 0.0714; bj_walk(10.24);};
void() bj_run3s	=[	2,	bj_run4	] {self.nextthink = time + 0.0429;};
void() bj_run4	=[	3,	bj_run4b	] {bj_walk(10.24);};
void() bj_run4b	=[	3,	bj_run1	] {self.nextthink = time + 0.0143; bj_walk(10.24);};
void() bj_jump1	=[	4,	bj_jump1b	] {bj_walk(3.40);};		// 14 tics
void() bj_jump1b	=[	4,	bj_jump2	] {bj_walk(3.40);};		// 14 tics
void() bj_jump2	=[	5,	bj_jump2b	] {bj_walk(3.40);};
void() bj_jump2b	=[	5,	bj_jump3	] {bj_walk(3.40);};
void() bj_jump3	=[	6,	bj_jump3b	] {bj_walk(3.40); sound (self, CHAN_VOICE, "082.wav", 1, ATTN_NORM);};
void() bj_jump3b	=[	6,	bj_jump4	] {bj_walk(3.40);};
void() bj_jump4	=[	7,	bj_hang1	] {self.nextthink = time + 4.2857;};		// 300
void() bj_hang1	=[	7,	bj_hang1	]
{
	nextmap = "start";
	self.think = execute_changelevel;
	self.nextthink = time + 0.1;
};
void() bj_touch =
{
	other.think = bj_jump1;
	self.touch = SUB_Null;
};
void() path_bj =
{
	self.solid = SOLID_TRIGGER;
	self.touch = bj_touch;
	setsize (self, '-8 -8 -8', '8 8 8');
};
void() bj_spawn =
{
	local entity	pos, pl;
	if (deathmatch)
	{
		dremove(self);
		return;
	}
	self.ideal_yaw = self.angles * '0 1 0';
	self.yaw_speed = 20;
	intermission_running = 1;
	// find the intermission spot
	pos = find (world, classname, "info_intermission");
	if (!pos)
		error ("no info_intermission");
	WriteByte (MSG_ALL, SVC_FINALE);
	WriteString (MSG_ALL, "");
	pl = find (world, classname, "player");
	while (pl != world)
	{
		pl.view_ofs = '0 0 0';
		pl.angles = other.v_angle = pos.mangle;
		pl.fixangle = TRUE;		// turn this way immediately
		pl.map = self.map;
		pl.nextthink = time + 0.5;
		pl.takedamage = DAMAGE_NO;
		pl.solid = SOLID_NOT;
		pl.movetype = MOVETYPE_NONE;
		pl.modelindex = 0;
		setorigin (pl, pos.origin);
		pl = find (pl, classname, "player");
	}
	setmodel (self, "sprites/monsters/!bj.spr");
	setsize (self, '-16 -16 -32', '16 16 24');
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.origin_z = self.origin_z + 1;	// raise off floor a bit
	droptofloor();
	self.goalentity = self.movetarget = find(world, targetname, self.target);
	self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
	self.th_walk ();
	self.nextthink = time + 0.1;
};
void() monster_bj =
{	
	precache_model ("sprites/monsters/!bj.spr");
	precache_sound ("082.wav");	// yell
	self.th_walk = bj_run1b;
	self.use = bj_spawn;
};
//END
