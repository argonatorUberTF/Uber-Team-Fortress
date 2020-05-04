void() time_chunk =
{
	local entity	timeChunk;
	timeChunk = spawn();
	setmodel(timeChunk, "progs/timegib.mdl");
	timeChunk.solid = SOLID_NOT;
	timeChunk.movetype = MOVETYPE_TOSS;
	makevectors (self.owner.angles);
	setorigin ( timeChunk, self.owner.origin + v_forward*84 - v_up * 136);
	timeChunk.velocity = v_up * -50;
	timeChunk.avelocity = '300 300 300';
	timeChunk.angles = self.owner.angles;
	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NONE);
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord (MSG_MULTICAST, timeChunk.origin_x);
	WriteCoord (MSG_MULTICAST, timeChunk.origin_y);
	WriteCoord (MSG_MULTICAST, timeChunk.origin_z);
	multicast (timeChunk.origin, MUL_PHS);
	self.owner.frame = 1;
	timeChunk.think = SUB_Remove;
	timeChunk.nextthink = time + 5;
};
void() time_stop_shake =
{
	SUB_UseTargets();
	remove (self);
};
void() time_boom =
{
	local entity	stopShakeEnt;
	SUB_UseTargets();
	if(self.owner.health < 1250 && self.owner.frame > 0)
	{
		if ( self.owner.skin < 2)
		{
			self.owner.frame = 2;
			self.owner.skin = 2;
		}
	}
	else
	if(self.owner.health < 1500)
	{
		if ( self.owner.frame == 0 )
		{
			time_chunk();
			self.owner.frame = 1;
			self.owner.skin = 1;
		}
	}
	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NONE);
	if (random() < 0.5)
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_EXPLOSION);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MUL_PHS);
	}
	else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_EXPLOSION);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MUL_PHS);
	}
	BecomeExplosion();
	stopShakeEnt = spawn();
	stopShakeEnt.target = self.target;
	stopShakeEnt.think = time_stop_shake;
	stopShakeEnt.nextthink = time + 0.7;
};
void() time_fall =
{
	if (!self.pain_finished)
	{
		if ( self.origin_z < -20 )
		{
			WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
			WriteByte (MSG_MULTICAST, TE_LAVASPLASH);
			WriteCoord (MSG_MULTICAST, self.origin_x);
			WriteCoord (MSG_MULTICAST, self.origin_y);
			WriteCoord (MSG_MULTICAST, (self.origin_z - 80));
			multicast (self.origin, MUL_PHS);
			self.pain_finished = 1;
		}
		else
		if (random() < 0.3)
		{
			WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
			WriteByte (MSG_MULTICAST, TE_EXPLOSION);
			WriteCoord (MSG_MULTICAST, self.origin_x);
			WriteCoord (MSG_MULTICAST, self.origin_y);
			WriteCoord (MSG_MULTICAST, self.origin_z);
			multicast (self.origin, MUL_PHS);
		}
	}
	self.velocity_z = self.velocity_z - 5;
	self.nextthink = time + 0.1;
	self.think = time_fall;
};
void() time_crash =
{
	self.takedamage = DAMAGE_NO;
	self.movetype = MOVETYPE_FLY;
	self.solid = SOLID_NOT;
	self.velocity = '0 0 -50';
	self.avelocity = '15 0 5';
	setsize (self, '0 0 0', '0 0 0');
	self.think = time_fall;
	self.nextthink = time + 0.1;
	self.target = "timeramp";
	SUB_UseTargets();
};
void(entity attacker, float take) time_pain =
{	
	local entity	painEnt;
	local float 	painRnd;
	if ( self.health > 1100 )
		if ( self.pain_finished > time )
			return;
	painRnd = random();
	if(painRnd < 0.4)
	{
		self.pain_finished = time + 2;
		painRnd = random();
		makevectors ( self.angles );
		painEnt = spawn();
		if ( painRnd < 0.33 )
			painEnt.origin = self.origin + v_forward*80 - v_up*64;
		else if (painRnd < 0.66)
			painEnt.origin = self.origin + v_right*80 - v_up*24;
		else 
			painEnt.origin = self.origin + v_forward*64 - v_up*48 - v_right*48;
		painEnt.target = self.target;
		painEnt.owner = self;
		painEnt.think = time_boom;
		painEnt.nextthink = time + 0.2 + random() * 0.3;
	}
	if ( self.health < 1000 )
	{
		self.pain_finished = 0;
		self.th_pain = SUB_Null;
		self.th_die = SUB_Null;
		cutscene_running = 1;
		return;
	}
};
void() item_time_machine =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model("progs/timemach.mdl");
	precache_model("progs/timegib.mdl");
	setmodel(self, "progs/timemach.mdl");
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.health = 1600;
	self.takedamage = DAMAGE_YES;
	self.view_ofs = '0 0 25';
	self.movetype = MOVETYPE_FLY; 
	setsize(self, '-64 -64 -144', '64 64 0');
	self.avelocity = '0 60 0';
	self.flags = self.flags | FL_MONSTER;
	self.th_stand = SUB_Null;
	self.th_walk = SUB_Null;
	self.th_run = SUB_Null;
	self.th_die = time_pain;
	self.th_missile = SUB_Null;
	self.th_pain = time_pain;
	theMachine = self;
};
void() item_time_core =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	precache_model ("progs/timecore.mdl");
	setmodel(self, "progs/timecore.mdl");
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_FLY; 
	self.avelocity = '60 60 60';
};
//END
