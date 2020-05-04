// Generic projectile spawning code (PRJ) ---
// projectile effect enumerator
enum {
	PE_NONE,
	PE_SPIKE,
	PE_SUPERSPIKE,
	PE_WIZSPIKE,
	PE_KNIGHTSPIKE,
	PE_GUNSHOT,
	PE_EXPLOSION,
	PE_EXPLOSIONGROUND,
	PE_LASER,
	PE_ZOMBIEGIB
};
.void() proj_touch, proj_think;
.float damage_direct, damage_exp, expire_time, mod_direct, radius_exp, proj_effect, proj_think_time;
// functions used only by this QC file
float() _PRJ_Bounce =
{
	if (other.takedamage == DAMAGE_AIM)
		return 0; // explode
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);  // bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	return 1; // keep bouncing
};
float() _PRJ_Remove =
{
	remove(self);
	return 1; // stop execution within touch function
};
float() _PRJ_Stop =
{
	if (other.takedamage)
		return 0;
	sound (self, CHAN_WEAPON, "zombie/z_miss.wav", 1, ATTN_NORM); // bounce sound
	self.velocity = '0 0 0';
	self.avelocity = '0 0 0';
	self.proj_touch = _PRJ_Remove;
	return 1; // keep the entity alive
};
void() _PRJ_Touch =
{
	local entity ignore;
// check validity of projectile
	if (other == self.owner)
		return; // don't explode on owner
	if (self.voided) {
		return;
	}
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
// handle custom touch
	if (other != self) // didn't expire
		if (self.proj_touch) // is valid function
			if (self.proj_touch())
				return;
// void projectile
	self.voided = 1;
	// do projectile damage
	ignore = self;
	if (other.health >= 1 && self.damage_direct)
	{
		T_Damage (other, self, self.owner, self.damage_direct);
		ignore = other;
	}
	if (self.radius_exp)
		T_RadiusDamage (self, self.owner, self.damage_exp, ignore);
// run projectile effect
	remove(self);
};
void() _PRJ_Expire =
{
	other = self;
	_PRJ_Touch();	
};
void() _PRJ_Think =
{
	if (self.expire_time > time)
	{
		_PRJ_Expire();
		return;
	}
	self.nextthink = time + self.proj_think_time;
	self.proj_think(); // projectile could remove itself here
};
// functions used by outside QC files
// set bouncy projectile function
void() PRJ_SetBouncyProjectile =
{
	newmis.proj_touch = _PRJ_Bounce;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.avelocity = '300 300 300';
};
// set tossed projectile (zombie gib) function
void() PRJ_SetTossedProjectile =
{
	newmis.proj_touch = _PRJ_Stop;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.avelocity = '3000 1000 2000';
};
// set radius damage function
void(float damg, float damgrad, float damgmod) PRJ_SetRadiusDamage =
{
	newmis.damage_exp = damg;
	newmis.radius_exp = damgrad;
};
// extra think function, should always be called ONCE after the main spawn function
void(void() thinkfunc, float thinktimeinit, float thinkres) PRJ_SetThink =
{
	newmis.think = _PRJ_Think;
	newmis.nextthink = time + thinktimeinit;
	newmis.proj_think = thinkfunc;
	newmis.proj_think_time = thinkres;
};
// extra touch function
void(float() touchfunc) PRJ_SetTouch =
{
	newmis.proj_touch = touchfunc;
};
// main spawning function
void(entity parent, string modl, vector org, vector vel, float effect, float damg, float damgmod, float expiretime) PRJ_FireProjectile =
{
	newmis = spawn ();
	newmis.owner = parent;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.velocity = vel;
	newmis.damage_direct = damg;
	newmis.mod_direct = damgmod;
	newmis.proj_effect = effect;
	newmis.touch = _PRJ_Touch;
	newmis.expire_time = time + expiretime;
	newmis.think = _PRJ_Expire;
	newmis.nextthink = time + expiretime;
	newmis.angles = vectoangles(newmis.velocity);
	setmodel (newmis, modl);
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);             
	setorigin (newmis, org);
};
//END
