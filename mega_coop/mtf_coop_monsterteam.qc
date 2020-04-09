void ( float attack_duration, float sframe, float eframe, void() atck, float attack_frame, float attack_special ) monster_run_attack;
void () monster_stand1;
void () monster_stand2 =
{
	if ((self.velocity_x || self.velocity_y))
	{
		self.frame = 29;
		player_run ();
		return;
	}
	monster_stand1();
};
void () monster_stand1 =
{
	if (self.monster_type == 6) {
		if (self.walkframe >= 16)
		{
			self.walkframe = 0.000000;
		}
		self.walkframe++;
	}
	else if (self.monster_type == 7) {
		if (self.walkframe >= 12)
		{
			self.walkframe = 0.000000;
		}
		self.walkframe++;
	}
	parse_anim( self.walkframe, monster_stand2 );
};
void () monster_run;
void() monster_run2 =
{
	if (!(self.velocity_x) && !(self.velocity_y))
	{
		self.walkframe = TF_FLARE_LIT;
		player_stand1();
		return;
	}
	monster_run();
};
void () monster_run =
{
	if (self.monster_type == 6) {
		if (self.monsterframe < 17 || self.frame < 17)
		{
			self.frame = 17;
			self.monsterframe = 17;
		}
		if (self.monsterframe >= 27)
		{
			self.monsterframe = 17;
		}
		self.monsterframe++;
	}
	else if (self.monster_type == 7) {
		if (self.monsterframe < 21 || self.frame < 21)
		{
			self.frame = 21;
			self.monsterframe = 21;
		}
		if (self.monsterframe >= 26)
		{
			self.monsterframe = 21;
		}
		self.monsterframe++;
	}
	self.frame = self.monsterframe;
	parse_anim( self.monsterframe, monster_run2 );
};
void () monster_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	if (self.monster_type == 6) {
		sound (self, CHAN_VOICE, "shambler/shurt2.wav", true, ATTN_NORM);
		monster_run_attack ( .5, 77, 82, SUB_Null, 0, 0 );
		self.pain_finished = time + 1;
	}
	if (self.monster_type == 7) {
		sound (self, CHAN_VOICE, "demon/dpain1.wav", true, ATTN_NORM);
		monster_run_attack ( .5, 39, 44, SUB_Null, 0, 0 );
		self.pain_finished = time + 1.5;
	}
};
void () monster_die =
{
	if (self.monster_type == 6) {
		if ( self.health < -60 )
		{
			sound (self, CHAN_VOICE, "player/udeath.wav", true, ATTN_NORM);
			ThrowHead ("progs/h_shams.mdl", self.health);
			ThrowGib ("progs/gib1.mdl", self.health);
			ThrowGib ("progs/gib2.mdl", self.health);
			ThrowGib ("progs/gib3.mdl", self.health);
		}
		else {
			sound (self, CHAN_VOICE, "shambler/sdeath.wav", true, ATTN_NORM);
			monster_run_attack ( 0, 83, 93, SUB_Null, 0, 1 );
		}
	}
	if (self.monster_type == 7) {
		if ( self.health < -80 )
		{
			sound (self, CHAN_VOICE, "player/udeath.wav", true, ATTN_NORM);
			ThrowHead (mtf_savemodel("progs/h_demon.mdl"), self.health);
			ThrowGib ("progs/gib1.mdl", self.health);
			ThrowGib ("progs/gib1.mdl", self.health);
			ThrowGib ("progs/gib1.mdl", self.health);
		}
		else {
			sound (self, CHAN_VOICE, "demon/ddeath.wav", true, ATTN_NORM);
			monster_run_attack ( 0, 45, 53, SUB_Null, 0, 1 );
		}
	}
	TeamFortress_SetupRespawn(TF_FLARE_LIT);
};
void () psham_smash =
{
	local vector source;
	local vector org;
	local float ldmg;
	makevectors (self.v_angle);
	source = (self.origin + '0 0 16');
	traceline (source, (source + (v_forward * 64)), 0.000000, self);
	if ((trace_fraction == 1))
	{
		return;
	}
	org = (trace_endpos - (v_forward * 4));
	if (trace_ent.takedamage)
	{
		ldmg = (((random () + random ()) + random ()) * 40);
		T_Damage (trace_ent, self, self, ldmg);
		sound (self, CHAN_VOICE, "shambler/smack.wav", true, ATTN_NORM);
		SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), ((crandom () * 100) * v_right));
		SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), ((crandom () * 100) * v_right));
	}
};
void ( float side ) psham_slash =
{
	local float ldmg;
	local vector source;
	local vector org;
	makevectors (self.v_angle);
	source = (self.origin + '0 0 16');
	traceline (source, (source + (v_forward * 64)), 0.000000, self);
	if ((trace_fraction == 1))
	{
		return;
	}
	org = (trace_endpos - (v_forward * 4));
	if (trace_ent.takedamage)
	{
		ldmg = (((random () + random ()) + random ()) * 20);
		T_Damage (trace_ent, self, self, ldmg);
		sound (self, CHAN_VOICE, "shambler/smack.wav", true, ATTN_NORM);
		if (side)
		{
			makevectors (self.angles);
			SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), (side * v_right));
		}
	}
};
void () psham_swingr1 =
{
	psham_slash(-250);
};
void () psham_swingl1 =
{
	psham_slash(250);
};
void () pCastLightning =
{
	local vector org, source;
	muzzleflash ();
	makevectors (self.v_angle);
	source = (self.origin + '0 0 40');
	traceline (source, (source + (v_forward * 600)), 1, self);
	WriteByte (4, 23);
	WriteByte (4, 6);
	WriteEntity (4, self);
	WriteCoord (4, source_x);
	WriteCoord (4, source_y);
	WriteCoord (4, source_z);
	WriteCoord (4, trace_endpos_x);
	WriteCoord (4, trace_endpos_y);
	WriteCoord (4, trace_endpos_z);
	multicast (org, 1);
	LightningDamage (source, (trace_endpos + (v_forward * 4)), self, 30);
};
void () psham_magic =
{
	local entity o;
	self.velocity = '0 0 0';
	if (self.frame == 67) {
		self.nextthink = (self.nextthink + 0.2);
		muzzleflash ();
		self.gen_east = spawn ();
		o = self.gen_east;
		setmodel (o, "progs/s_light.mdl");
		setorigin (o, self.origin);
		o.angles = self.angles;
		o.nextthink = (time + 0.7);
		o.think = SUB_Remove;
	}
	else if (self.frame == 68) {
		self.gen_east.frame = true;
	}
	else if (self.frame == 69) {
		self.gen_east.frame = FL_SWIM;
	}
	else if (self.frame == 70) {
		sound (self, CHAN_WEAPON, "shambler/sboom.wav", true, ATTN_NORM);
		pCastLightning();
	}
	else if (self.frame == 71) {
		pCastLightning();
	}
	else if (self.frame == 72) {
		pCastLightning();
	}
};
void ( float side ) pDemon_Melee =
{
	local float ldmg;
	local vector source;
	local vector org;
	makevectors (self.v_angle);
	source = (self.origin + '0 0 16');
	traceline (source, (source + (v_forward * 64)), 0.000000, self);
	if ((trace_fraction == 1))
	{
		return;
	}
	org = (trace_endpos - (v_forward * 4));
	if (trace_ent.takedamage)
	{
		if (side == -666) {
			ldmg = (MOVETYPE_BOUNCE + (MOVETYPE_FLY * random ())) * .5;
			SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), (1 * v_right));
		}
		else {
			ldmg = (MOVETYPE_BOUNCE + (MOVETYPE_FLY * random ()));
			SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), (side * v_right));
		}
		sound (self, CHAN_WEAPON, "demon/dhit2.wav", true, ATTN_NORM);
		T_Damage (trace_ent, self, self, ldmg);
		SpawnMeatSpray ((self.origin + (v_forward * FL_INWATER)), (side * v_right));
	}
};

void () pdemon_attack =
{
	self.velocity = '0 0 0';
	if (self.frame == 58) {
		pDemon_Melee (200);
	}
	if (self.frame == 64) {
		pDemon_Melee (-200);
	}
};
void () pdemon_jump =
{
	if (self.frame == 30) {
		makevectors (self.angles);
		self.velocity = ((v_forward * 600) + '0 0 250');
	}
	if (self.frame > 30)
		pDemon_Melee(-666);
};
void () monster_attack_go =
{
	if (self.monsterframe >= self.walkframe)
	{
		if (self.bubble_count == 1) {
			PlayerDead();
			return;
		}
		player_stand1();
		return;
	}
	if (self.bubble_count == 2)
		psham_magic();
	else if (self.bubble_count == 3)
		pdemon_attack();
	else if (self.bubble_count == 4)
		pdemon_jump();
	parse_anim( self.monsterframe, monster_attack_go );
	if (self.fly_sound == self.monsterframe)
		self.th_fireball();
	self.monsterframe++;
};
void ( float attack_duration, float sframe, float eframe, void() atck, float attack_frame, float attack_special ) monster_run_attack =
{
	Attack_Finished( attack_duration );
	self.monsterframe = sframe;
	self.frame = sframe;
	self.walkframe = eframe;	// end frame
	self.fly_sound = attack_frame;	// run an attack at this frame
	self.th_fireball = atck;	// attack to run at the specified frame
	self.bubble_count = attack_special;	// special instructions for attack
	monster_attack_go();
};
void () monster_attack =
{
	local float chance;
	chance = random ();
	if ((time < self.attack_finished))
	{
		return;
	}
	if (self.monster_type == 6) {
		if (self.current_weapon == 16) {		// Shammy lightning
			sound (self, CHAN_WEAPON, "shambler/sattck1.wav", true, ATTN_NORM);
			monster_run_attack( 1.75, 65, 76, SUB_Null, 41, 2 );
		}
		else {									// Shammy melee
			if (((chance > 0.6)))
			{
				sound (self, CHAN_VOICE, "shambler/melee1.wav", true, ATTN_NORM);
				monster_run_attack( 1, 35, 46, psham_smash, 41, 0 );
			}
			else
			{
				if ((chance > 0.3))
				{
					sound (self, CHAN_VOICE, "shambler/melee1.wav", true, ATTN_NORM);
					monster_run_attack( 1, 47, 55, psham_swingr1, 51, 0 );
				}
				else
				{
					sound (self, CHAN_VOICE, "shambler/melee2.wav", true, ATTN_NORM);
					monster_run_attack( 1, 56, 64, psham_swingl1, 60, 0 );
				}
			}
		}
	}
	else if (self.monster_type == 7) {
		if (self.current_weapon == 16) {
			monster_run_attack( 1.75, 27, 38, SUB_Null, 0, 4 );		// jump attack
		}
		else {
			monster_run_attack( 1.25, 54, 67, SUB_Null, 0, 3 );		// slash attack
		}
	}
};
//end
