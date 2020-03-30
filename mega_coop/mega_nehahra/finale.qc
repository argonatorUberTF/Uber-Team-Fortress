void () nehahra_setupfinale =
{
	if (coop)
	{
		nehahra_levelchange ();
		return;
	}
	nehahra_finaletrigger ();
	nehahra_finalecam ();
	spawn_tunnel ();
	nehahra_movecam ('99 -167 -142', 3, "xmove_1");
	nehahra_movecam ('99 -167 656', 5, "xmove_2");
	nehahra_script ("91", "92", 2, "");
	nehahra_script ("92", "93", 4, "xmove_1");
	nehahra_script ("93", "94", 4, "xtunnel");
	nehahra_script ("94", "95", 1, "");
	nehahra_script ("95", "96", 1, "xmove_2");
	nehahra_script ("96", "97", 1, "xtunnel");
	nehahra_script ("97", "98", 17, "xactor");
	nehahra_script ("98", "0", 0, "");
};

void () nehahra_levelchange =
{
	local entity head;
	head = spawn ();
	head.think = go2nehend;
	head.nextthink = (time + 4);
};

void () go2nehend =
{
	changelevel ("nehend");
	remove (self);
};

void () drop_nehahra_finale_sensor =
{
	local entity new;
	new = spawn ();
	new.origin = self.origin;
	new.target = "xnehahra_finale";
	new.think = sense_finale_coming;
	new.nextthink = (time + 0.2);
};

void () sense_finale_coming =
{
	local entity head;
	head = find (world, classname, "player");
	if ((head != world))
	{
		if ((head.origin_z > -676.5))
		{
			if ((head.flags & FL_ONGROUND))
			{
				if (((head.groundentity != world) && (head.groundentity.targetname == "end_vader")))
				{
					self.target = "xnehahra_finale";
					SUB_UseTargets ();
					remove (self);
					return;
				}
			}
		}
	}
	self.think = sense_finale_coming;
	self.nextthink = (time + 0.2);
};

void () nehahra_finalecam =
{
	local entity head;
	head = spawn ();
	head.angles = '90 45 0';
	head.mangle = '90 45 0';
	head.classname = "info_camera";
	head.targetname = "maxwantsyou";
	head.use = camera_cyclez;
	setorigin (head, '99 -167 500');
};

void (vector vec, float num, string line) nehahra_movecam =
{
	local entity head;
	head = spawn ();
	head.origin = vec;
	head.targetname = line;
	head.classname = "info_movecam";
	head.speed = num;
	head.use = move_the_camera;
};

void (string t, string num, float o, string line) nehahra_script =
{
	local entity head;
	head = spawn ();
	head.origin = '99 -167 600';
	head.classname = "info_script";
	head.target = line;
	head.script_num = t;
	head.next_script = num;
	head.script_delay = o;
};

void () nehahra_finaletrigger =
{
	local entity head;
	head = spawn ();
	setsize (head, VEC_HULL_MIN, '16 16 40');
	setorigin (head, '150 -167 405');
	head.solid = SOLID_TRIGGER;
	head.movetype = MOVETYPE_NONE;
	head.modelindex = 0;
	head.model = "";
	head.delay = 0.1;
	head.targetname = "xnehahra_finale";
	head.target = "maxwantsyou";
	head.script = "91";
	head.script_delay = 2;
	head.touch = camera_touch;
	head.use = camera_use;
};

void () spawn_tunnel =
{
	local entity head;
	sound (self, CHAN_AUTO, "vondur/fan1.wav", 0.8, ATTN_NONE);
	sound (self, CHAN_AUTO, "ambience/class2.wav", 1, ATTN_NONE);
	head = spawn ();
	setsize (head, VEC_HULL_MIN, VEC_HULL_MAX);
	head.solid = SOLID_NOT;
	head.targetname = "xtunnel";
	head.origin = '99 -167 957';
	head.movetype = MOVETYPE_NOCLIP;
	head.state = 0;
	head.cnt = 0;
	head.blink = 0;
	head.use = tunnel_change;
};

void () tunnel_change =
{
	self.state = (self.state + 1);
	if ((self.state == 1))
	{
		self.alpha = 0.1;
		setmodel (self, "maps/finale1.bsp");
		self.think = tunnel_move;
		self.nextthink = (time + 0.2);
		return;
	}
};

void () tunnel_move =
{
	if ((self.state == 1))
	{
		if ((self.origin_z > -150))
		{
			self.origin_z = (self.origin_z - 15);
		}
	}
	else
	{
		if ((self.origin_z < 1200))
		{
			self.origin_z = (self.origin_z + 8);
			self.objekt = find (world, classname, "dummy");
			if ((self.objekt != world))
			{
				self.objekt.origin_z = (self.objekt.origin_z + 15);
				if ((self.alpha < 1))
				{
					self.alpha = (self.alpha + 0.01);
				}
				else
				{
					self.alpha = 1;
				}
			}
		}
	}
	setorigin (self, self.origin);
	self.angles_y = (self.angles_y + 36);
	if ((self.angles_y >= 360))
	{
		self.angles_y = 0;
		self.blink = (self.blink + 1);
		if ((self.blink > 20))
		{
			self.blink = 0;
			if ((self.cnt < 5))
			{
				self.cnt = (self.cnt + 1);
				sound (self, CHAN_AUTO, "cuts1/flf1.wav", 1, ATTN_NONE);
			}
			else
			{
				sound (self, CHAN_AUTO, "cuts1/flf2.wav", 1, ATTN_NONE);
			}
		}
	}
	self.think = tunnel_move;
	self.nextthink = time;
};

void () OLD_slow_end_vader =
{
	local entity mark;
	mark = find (world, targetname, "end_vader");
	if ((mark != world))
	{
		mark.speed = (mark.speed * 0.2);
	}
};

void (entity o) spawn_dummy_finale =
{
	local entity sa;
	o.origin_x = 96;
	o.origin_y = -163;
	o.origin = (o.origin + '0 0 50');
	sound (self, 1/*CHAN_ENDER*/, "sets/set2_3.wav", 1, ATTN_NONE);
	if ((deathmatch || coop))
	{
		return;
	}
	sa = spawn ();
	sa.origin = o.origin;
	sa.velocity = o.velocity;
	sa.angles = o.angles;
	sa.health = o.health;
	sa.weapon = o.weapon;
	sa.owner = o;
	sa.classname = "dummy";
	sa.targetname = "xactor";
	sa.movetype = MOVETYPE_NONE;
	sa.solid = SOLID_SLIDEBOX;
	sa.weaponmodel = o.weaponmodel;
	sa.flags = o.flags;
	setsize (sa, VEC_HULL_MIN, VEC_HULL_MAX);
	setorigin (sa, o.origin);
	setmodelu (sa, "progs/player1.mdl");
	sa.frame = 6;
	sa.flags = (sa.flags - (sa.flags & FL_ONGROUND));
	sa.use = dummy_activate;
	sa.think = dummy_run;
	sa.nextthink = (time + 0.1);
};

void () dummy_activate =
{
	self.state = 2424;
};

void () dummy_run =
{
	sound (self, 1/*CHAN_DAMAUL*/, "sets/set2_5.wav", 1, ATTN_NONE);
	self.think = dummy_finale;
	self.nextthink = (time + 0.1);
};

void () dummy_finale =
{
	if ((self.state == 2424))
	{
		self.movetype = MOVETYPE_NONE;
		self.solid = SOLID_NOT;
		parse_anim ( 50, dummy_suck );
		spawn_finalefx ();
		return;
	}
	if ((self.walkframe >= 5))
	{
		self.walkframe = 0;
	}
	parse_anim ( 12, dummy_finale );
	self.frame = (12 + self.walkframe);
	self.walkframe = (self.walkframe + 1);
};

void () dummy_suck =
{
	self.frame = 50;
	self.angles_y = (self.angles_y - 10);
	if ((self.angles_y <= 0))
	{
		self.angles_y = 360;
	}
	self.think = dummy_suck;
	self.nextthink = (time + 0.001000);
};

void () spawn_finalefx =
{
	local entity mark;
	sound (self, 1/*CHAN_BODY*/, "sets/set2_5.wav", 1, ATTN_NONE);
	mark = spawn ();
	mark.origin = self.origin;
	mark.think = setupfinalefx;
	mark.nextthink = (time + 0.1);
};

void () setupfinalefx =
{
	local entity head;

	head = find (world, classname, "camera");
	if ((head != world))
	{
		self.objekt = head;
	}
	else
	{
		remove (self);
	}
	self.fog_density = 0.05;
	stuffcmd_wrap (self.objekt, "gl_fogred 1\n");
	stuffcmd_wrap (self.objekt, "gl_fogblue 0\n");
	stuffcmd_wrap (self.objekt, "gl_foggreen 0\n");
	stuffcmd_wrap (self.objekt, "gl_fogdensity 0.05\n");
	stuffcmd_wrap (self.objekt, "gl_fogenable 1\n");
	self.think = finalefog_fade;
	self.nextthink = (time + 0.01);
};

void () finalefog_fade =
{
	self.fog_density = (self.fog_density + 0.05);
	if ((self.fog_density >= 0.5))
	{
		self.fog_red = 1;
		self.think = finalefadeout;
		self.nextthink = (time + 1);
		return;
	}
	stuffcmd_wrap (self.objekt, "gl_fogdensity ");
	stuffcmd_wrap (self.objekt, ftos (self.fog_density));
	stuffcmd_wrap (self.objekt, "\n");
	self.think = finalefog_fade;
	self.nextthink = (time + 0.05);
};

void () finalefadeout =
{
	stuffcmd_wrap (self.objekt, "gl_fogred ");
	stuffcmd_wrap (self.objekt, ftos (self.fog_red));
	stuffcmd_wrap (self.objekt, "\n");
	self.fog_red = (self.fog_red - 0.05);
	if ((self.fog_red <= 0))
	{
		nextmap = "nehend";
		self.objekt.think = execute_changelevel;
		self.objekt.nextthink = (time + 0.5);
		remove (self);
	}
	stuffcmd_wrap (self.objekt, "gl_fogred ");
	stuffcmd_wrap (self.objekt, ftos (self.fog_red));
	stuffcmd_wrap (self.objekt, "\n");
	self.think = finalefadeout;
	self.nextthink = (time + 0.05);
};

//END
