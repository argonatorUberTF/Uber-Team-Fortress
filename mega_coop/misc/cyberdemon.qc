$origin 0 0 64
$base base     
$skin skin
$frame stand1 stand2 stand3 stand4 stand5 stand6
$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7
$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6 shoot7 shoot8
void(float xco, float yco, float zco) SpawnExplosion;
void () CyberDemonT_MissileTouch= {
   local float damg;
   if ( (other == self.owner) ) {
      return ;
   }
   if ( (pointcontents (self.origin) == #CONTENT_SKY) ) {
      remove (self);
      return ;
   }
   damg = 150 + 150 * random ();
   T_Damage (other, self, self.owner, damg );
   T_RadiusDamage (self, self.owner, damg, other);
   self.origin = (self.origin - (FL_CLIENT * normalize (self.velocity)));
#ifdef DEMO_STUFF
   if (self.enemy)
      CamProjectileLockOff();
#endif
    WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
    WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
    WriteCoord (#MSG_BROADCAST, self.origin_x);
    WriteCoord (#MSG_BROADCAST, self.origin_y);
    WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
    multicast (self.origin, #MULTICAST_PHS);
    dremove(self);
#else
    BecomeExplosion ();
#endif
};
void() CyberDemonFireMissile =
{
   local entity missile;
   local vector org;
   muzzleflash ();
   sound (self, #CHAN_WEAPON, "cyber/cybfire.wav", 1, #ATTN_NORM);
   missile = spawn ();
   missile.owner = self;
   missile.movetype = MOVETYPE_FLYMISSILE;
   missile.solid = #SOLID_BBOX;
   makevectors (self.angles);
   org = self.origin + '0 0 30' + (v_right * -22);
   missile.velocity = normalize((self.enemy.origin + '0 0 20') - org);
   missile.velocity = missile.velocity * 2200;  // was 600
   missile.angles = vectoangles(missile.velocity);
   missile.touch = CyberDemonT_MissileTouch;
   missile.nextthink = time + 7;
   missile.think = SUB_Remove;
   setmodel  (missile, "progs/missile.mdl");
   setsize   (missile, '0 0 0', '0 0 0');
   setorigin (missile, self.origin + '0 0 30' + (v_right * -22) );
};
void() cyber_stand1   =[ $stand1, cyber_stand1 ] {ai_stand();};
void() cyber_walk1 =[ $walk1,     cyber_walk2  ] {ai_walk(8);};
void() cyber_walk2 =[ $walk2,     cyber_walk3  ] {ai_walk(7);};
void() cyber_walk3 =[ $walk3,     cyber_walk4  ] 
   {  ai_walk(7);
      sound (self, #CHAN_WEAPON, "cyber/cybmet.wav", 1, #ATTN_NORM);
   };
void() cyber_walk4 =[ $walk4,     cyber_walk5  ] {ai_walk(7);};
void() cyber_walk5 =[ $walk5,     cyber_walk6  ] 
   {  ai_walk(7);
      sound (self, #CHAN_WEAPON, "cyber/cybhoof.wav", 1, #ATTN_NORM);
   };
void() cyber_walk6 =[ $walk6,     cyber_walk7  ] {ai_walk(9);};
void() cyber_walk7 =[ $walk7,     cyber_walk1  ] {ai_walk(8);};
void() cyber_run1 =[ $walk1,     cyber_run2  ] {ai_run(13);};
void() cyber_run2 =[ $walk2,     cyber_run3  ] {ai_run(12);};
void() cyber_run3 =[ $walk3,     cyber_run4  ] 
   {  ai_run(12);
      sound (self, #CHAN_WEAPON, "cyber/cybmet.wav", 1, #ATTN_NORM);
   };
void() cyber_run4 =[ $walk4,     cyber_run5  ] {ai_run(12);};
void() cyber_run5 =[ $walk5,     cyber_run6  ] 
   {
      sound (self, #CHAN_WEAPON, "cyber/cybhoof.wav", 1, #ATTN_NORM);
      ai_run(12);
   };
void() cyber_run6 =[ $walk6,     cyber_run7  ] {ai_run(15);};
void() cyber_run7 =[ $walk7,     cyber_run1  ] {ai_run(13);};
void() cyber_missile21; // To make jumping to last frames possible
void() cyber_missile1  =[ $shoot1,     cyber_missile2  ] {ai_face();};
void() cyber_missile2  =[ $shoot2,     cyber_missile3  ] {ai_face();};
void() cyber_missile3  =[ $shoot3,     cyber_missile4  ]
{
   ai_face();
   makevectors (self.angles);
   traceline (self.origin + '0 0 30' + v_right * -22, self.enemy.origin + '0 0 20', #FALSE, self);
   if (trace_ent != self.enemy)
      cyber_missile21 ();
   if (self.enemy.health <= 0)
      cyber_missile21 ();
};
void() cyber_missile4  =[ $shoot4,     cyber_missile5  ] {ai_face();CyberDemonFireMissile();};
void() cyber_missile5  =[ $shoot5,     cyber_missile6  ] {ai_face();};
void() cyber_missile6  =[ $shoot6,     cyber_missile7  ] {ai_face();};
void() cyber_missile7  =[ $shoot7,     cyber_missile8  ] {ai_face();};
void() cyber_missile8  =[ $shoot8,     cyber_missile9  ] {ai_face();};
void() cyber_missile9  =[ $shoot3,     cyber_missile10 ] 
{
   ai_face();
   makevectors (self.angles);
   traceline (self.origin + '0 0 30' + v_right * -22, self.enemy.origin + '0 0 20', #FALSE, self);
   if (trace_ent != self.enemy)
      cyber_missile21 ();
   if (self.enemy.health <= 0)
      cyber_missile21 ();
};
void() cyber_missile10 =[ $shoot4,     cyber_missile11 ] {ai_face();CyberDemonFireMissile();};
void() cyber_missile11 =[ $shoot5,     cyber_missile12 ] {ai_face();};
void() cyber_missile12 =[ $shoot6,     cyber_missile13 ] {ai_face();};
void() cyber_missile13 =[ $shoot7,     cyber_missile14 ] {ai_face();};
void() cyber_missile14 =[ $shoot8,     cyber_missile15 ] {ai_face();};
void() cyber_missile15 =[ $shoot3,     cyber_missile16 ]
{
   ai_face();
   makevectors (self.angles);
   traceline (self.origin + '0 0 30' + v_right * -22, self.enemy.origin + '0 0 20', #FALSE, self);
   if (trace_ent != self.enemy)
      cyber_missile21 ();
   if (self.enemy.health <= 0)
      cyber_missile21 ();
};
void() cyber_missile16 =[ $shoot4,     cyber_missile17 ] {ai_face();CyberDemonFireMissile();};
void() cyber_missile17 =[ $shoot5,     cyber_missile18 ] {ai_face();};
void() cyber_missile18 =[ $shoot6,     cyber_missile19 ] {ai_face();};
void() cyber_missile19 =[ $shoot7,     cyber_missile20 ] {ai_face();};
void() cyber_missile20 =[ $shoot8,     cyber_missile21 ] {ai_face();};
void() cyber_missile21 =[ $shoot3,     cyber_missile22 ] {ai_face();};
void() cyber_missile22 =[ $shoot2,     cyber_missile23 ] {ai_face();};
void() cyber_missile23 =[ $shoot1,     cyber_run1 ]
{
   ai_face();
};
void(entity attacker, float damage) cyber_pain =
{
   if (self.pain_finished > time)
      return;
   if (random() < 0.1)
      sound (self, CHAN_VOICE, "cyber/cybpain.wav", 1, #ATTN_NORM);    

   self.pain_finished = time + 2;
};
void(float xco, float yco, float zco) SpawnExplosion = 
{
   WriteByte  (#MSG_BROADCAST, #SVC_TEMPENTITY);
   WriteByte  (#MSG_BROADCAST, #TE_EXPLOSION);
   WriteCoord (#MSG_BROADCAST, xco);
   WriteCoord (#MSG_BROADCAST, yco);
   WriteCoord (#MSG_BROADCAST, zco);
};
void()   cyber_die1   =[ $walk1, cyber_die2   ] 
   { 
      sound (self, 7, "cyber/cybdie.wav", 1, #ATTN_NORM);
      ai_pain(3);
   };
void()   cyber_die2   =[ $walk2, cyber_die3   ] {ai_pain(3);};
void()   cyber_die3   =[ $walk3, cyber_die4   ] {ai_pain(3);};
void()   cyber_die4   =[ $walk4, cyber_die5   ] {ai_pain(3);};
void()   cyber_die5   =[ $walk5, cyber_die6   ] {ai_pain(3);};
void()   cyber_die6   =[ $walk6, cyber_die7   ] {ai_pain(3);};
void()   cyber_die7   =[ $walk7, cyber_die8   ] {ai_pain(3);};
void()   cyber_die8   =[ $walk1, cyber_die9   ] 
   {
     ai_pain(3);
     sound (self, 5, "cyber/servo.wav", 1, #ATTN_NORM);
   };
void()   cyber_die9   =[ $shoot1, cyber_die10   ] 
   { ai_pain(3);
     SpawnExplosion (self.origin_x, self.origin_y + 20, self.origin_z + 60);
     sound (self, 1, "weapons/r_exp3.wav", 0.4, #ATTN_NORM);
   };
void()   cyber_die10   =[ $shoot2, cyber_die11  ] {ai_pain(3);};
void()   cyber_die11   =[ $shoot2, cyber_die12   ] 
   { ai_pain(3);
     SpawnExplosion (self.origin_x, self.origin_y - 20, self.origin_z + 40);
     sound (self, 2, "weapons/r_exp3.wav", 0.4, #ATTN_NORM);
   };
void()   cyber_die12   =[ $shoot3, cyber_die13   ]
   { sound (self, CHAN_VOICE, "cyber/cybdie.wav", 1, #ATTN_NORM);
     ai_pain(3);
   };
void()   cyber_die13   =[ $shoot3, cyber_die14   ] 
   { sound (self, 3, "weapons/r_exp3.wav", 0.4, #ATTN_NORM);
     SpawnExplosion (self.origin_x - 20, self.origin_y, self.origin_z+20);
     SpawnExplosion (self.origin_x + 20, self.origin_y, self.origin_z+20);
     SpawnExplosion (self.origin_x, self.origin_y - 20, self.origin_z+20);
     SpawnExplosion (self.origin_x, self.origin_y + 20, self.origin_z+20);
     ai_pain(3);
   };
void()   cyber_die14   =[ $shoot3, cyber_die15   ]  {ai_pain(3);};
void()   cyber_die15   =[ $shoot2, cyber_die16   ] 
   { SpawnExplosion (self.origin_x - 20, self.origin_y, self.origin_z+40);
     SpawnExplosion (self.origin_x + 20, self.origin_y, self.origin_z+40);
     SpawnExplosion (self.origin_x, self.origin_y - 20, self.origin_z+40);
     SpawnExplosion (self.origin_x, self.origin_y + 20, self.origin_z+40);
     ai_pain(2);
   };
void()   cyber_die16   =[ $shoot2, cyber_die17   ] {ai_pain(3);};
void()   cyber_die17   =[ $shoot3, cyber_die18   ] 
   { ai_pain(1);
     SpawnExplosion (self.origin_x - 10, self.origin_y, self.origin_z+70);
     SpawnExplosion (self.origin_x + 10, self.origin_y, self.origin_z+70);
     SpawnExplosion (self.origin_x, self.origin_y - 10, self.origin_z+70);
     SpawnExplosion (self.origin_x, self.origin_y + 10, self.origin_z+70);
   };
void()   cyber_die18   =[ $shoot3, SUB_Remove   ] 
   {
      SpawnExplosion (self.origin_x - 10, self.origin_y, self.origin_z+40);
      SpawnExplosion (self.origin_x + 10, self.origin_y, self.origin_z+40);
      SpawnExplosion (self.origin_x, self.origin_y - 10, self.origin_z+40);
      SpawnExplosion (self.origin_x, self.origin_y + 10, self.origin_z+40);
      sound (self, 4, "weapons/r_exp3.wav", 1, #ATTN_NORM);
      sound (self, 5, "cyber/boom.wav", 1, #ATTN_NORM);
      ThrowHead ("progs/h_cyber.mdl",  -100 - (random()*50));
	  ThrowGib("progs/leg_gib.mdl", -60);
      ThrowGib("progs/gib3.mdl"   , -150);
      ThrowGib("progs/gib3.mdl"   , -100);
      ThrowGib("progs/gib1.mdl"   , -150);
      ThrowGib("progs/gib3.mdl"   , -100);
      ThrowGib("progs/gib3.mdl"   , -100);
      ThrowGib("progs/gib3.mdl"   , -70 );
      ThrowGib("progs/gib3.mdl"   , -120);  
      remove (self);
      return;
   };
void() cyber_die =
{
   cyber_die1 ();
};
void() cyber_melee =
{  
   cyber_missile1 ();
};
float() _CyberOnSight =
{
	sound (self, CHAN_VOICE, "shambler/ssight.wav", 1, #ATTN_NORM);
	return #TRUE;
};

void () monster_cyberdemon1 =
{
   self.solid    = SOLID_SLIDEBOX;
   self.movetype = MOVETYPE_STEP;
   self.mdl = "progs/h_cyber.mdl";
   setmodel (self, "progs/cyber.mdl");
   setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
   self.health = MTF_Monster_Health(600);
   self.th_stand   = cyber_stand1;
   self.th_walk    = cyber_walk1;
   self.th_run     = cyber_run1;
   self.th_die     = cyber_die;
   self.th_melee   = cyber_melee;
   self.th_missile = cyber_missile1;
   self.th_pain    = cyber_pain;
   self.netname = "cyberdemon";
   self.monsterweight = #MWEIGHT_LARGE;
   self.monsterflags = #MFLAG_NOBREATHING;
   coop_walkmonster_start();
};
void() monster_cyberdemon =
{
   if (deathmatch)
   {
      remove(self);
      return;
   }
   self.classname = "monster_cyberdemon";
     precache_model ("progs/cyber.mdl");
     precache_model ("progs/h_cyber.mdl");
     precache_model ("progs/leg_gib.mdl");
     precache_sound ("cyber/cybsee.wav");
     precache_sound ("cyber/cybdie.wav");
     precache_sound ("cyber/cybhoof.wav");
     precache_sound ("cyber/cybpain.wav");
     precache_sound ("cyber/cybmet.wav");
     precache_sound ("cyber/cybfire.wav");
     precache_sound ("cyber/boom.wav");
     precache_sound ("cyber/servo.wav");
	self.netname = "cyberdemon";
	self.monsterweight = #MWEIGHT_NORMAL;
	self.monsterflags = #MFLAG_HASWEAPON | #MFLAG_HUMANOID;
	self.#monsterflag = #STRFLAG_MONSTER;
	self.#npc_origangle = self.angles;
	self.#npc_spawndelay = 30;
	self.#npc_spawnfunc = monster_cyberdemon1;
	COOP_SetLives ();
	monster_cyberdemon1 ();
};
//END
