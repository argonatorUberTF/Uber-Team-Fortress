void() elvtr_button_wait;
void() elvtr_button_return;
void() elvtr_button_wait =
{
	ELV_BUTN_DIR = 0;
	if (self.spawnflags & ELVTR_DOWN)
		ELV_BUTN_DIR = -1;
	else
		ELV_BUTN_DIR = 1;
	self.state = STATE_TOP;
	self.nextthink = self.ltime + self.wait;
	self.think = elvtr_button_return;
	activator = self.enemy;
	SUB_UseTargets();
	self.frame = 1;			// use alternate textures
};
void() elvtr_button_done =
{
	self.state = STATE_BOTTOM;
};
void() elvtr_button_return =
{
	self.state = STATE_DOWN;
	SUB_CalcMove (self.pos1, self.speed, elvtr_button_done);
	self.frame = 0;			// use normal textures
	if (self.health)
		self.takedamage = DAMAGE_YES;	// can be shot again
};
void() elvtr_button_blocked =
{};
void() elvtr_button_fire =
{
	if (self.state == STATE_UP || self.state == STATE_TOP)
		return;
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	self.state = STATE_UP;
	SUB_CalcMove (self.pos2, self.speed, elvtr_button_wait);
};
void() elvtr_button_use =
{
	self.enemy = activator;
	elvtr_button_fire ();
};
void() elvtr_button_touch =
{
	if (other.classname != "player")
		return;
	self.enemy = other;
	elvtr_button_fire ();
};

void() elvtr_button_killed =
{
	self.enemy = damage_attacker;
	self.health = self.max_health;
	self.takedamage = DAMAGE_NO;	// wil be reset upon return
	elvtr_button_fire ();
};
void() func_elvtr_button =
{
	if (self.sounds == 0)
	{
		precache_sound ("buttons/airbut1.wav");
		self.noise = "buttons/airbut1.wav";
	}
	if (self.sounds == 1)
	{
		precache_sound ("buttons/switch21.wav");
		self.noise = "buttons/switch21.wav";
	}
	if (self.sounds == 2)
	{
		precache_sound ("buttons/switch02.wav");
		self.noise = "buttons/switch02.wav";
	}
	if (self.sounds == 3)
	{
		precache_sound ("buttons/switch04.wav");
		self.noise = "buttons/switch04.wav";
	}
	
	SetMovedir ();
	self.movetype = MOVETYPE_PUSH;
	self.solid = SOLID_BSP;
	setmodel (self, self.model);
	self.blocked = elvtr_button_blocked;
	self.use = elvtr_button_use;
	if (self.health)
	{
		self.max_health = self.health;
		self.th_die = elvtr_button_killed;
		self.takedamage = DAMAGE_YES;
	}
	else
		self.touch = elvtr_button_touch;
	if (!self.speed)
		self.speed = 40;
	if (!self.wait)
		self.wait = 1;
	if (!self.lip)
		self.lip = 4;
	self.state = STATE_BOTTOM;
	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir*(fabs(self.movedir*self.size) - self.lip);
};
//END
