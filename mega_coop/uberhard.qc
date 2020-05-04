// This mode is turned on/off for compilation in usecoop.pqc which is loaded first -arg
#ifdef mtfcoop_uberhardmode
void(entity targ, entity inflictor, entity attacker, float damage) T_Damage;
float uberhardmode;		// are we playing uberhardmode?
// uberhardmode_RemoveHealthTimer
// 
// if the player has died, remove the timer
//
void (entity p) uberhardmode_RemoveHealthTimer =
{
	local entity t;
	t = find (world, classname, "healthtimer");
	while (t != world)
	{
		if (t.owner == p)
			remove (t);
		t = find (t, classname, "healthtimer");
	}
};
// uberhardmode_ReducePlayerHealth
//
// if player has > 45 health, take away 5
// start next countdown to remove health
//
void () uberhardmode_ReducePlayerHealth =
{
	if (self.owner.health > 45)
		T_Damage (self.owner, self.owner, self.owner, 5);
	self.nextthink = time + 8;
};
// uberhardmode_SpawnHealthTimer
// 
//  spawns the entity that will control the player's health.
// 
void (entity p) uberhardmode_SpawnHealthTimer =
{
	local entity t;
	t = spawn ();
	t.owner = self;
	t.classname = "healthtimer";
	t.nextthink = time + 5;
	t.think = uberhardmode_ReducePlayerHealth;
};
#endif
//END
