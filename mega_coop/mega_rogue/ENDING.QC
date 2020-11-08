entity theActor;
entity theMachine;
float actorStage;
void (entity thePlayer) spawn_actor;
void () actor_control;
void (entity playerEnt) move_camera;
void () time_crash;
void () ending_remove_stuff;
void () ending_for_coop =
{
	intermission_exittime = (time + 10000000);
	intermission_running = 1;
	self.model = "";
	self.yaw_speed = 20;
	self.view_ofs = '0 0 0';
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	setorigin (self, (self.origin + '0 0 48'));
	WriteByte (MSG_ALL, SVC_FINALE);
	WriteString (MSG_ALL, "You have destroyed Quake's\nTemporal Teleporter. His assault\non Time has been defeated.\n\nUse CMD votemap rstart, hipstart,\n or start to play more coop");
	ending_remove_stuff ();
	theMachine.think = time_crash;
	theMachine.nextthink = (time + 0.1);
};
void () xpackEnding =
{
	local entity cameraview;
	if (coop)
	{
		ending_for_coop ();
		return;
	}
	intermission_exittime = (time + 10000000);
	intermission_running = 1;
	cameraview = find (world, targetname, "cameraview");
	if ((cameraview == world))
	{
		ending_for_coop ();
		return;
	}
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	spawn_actor (self);
	move_camera (self);
};
void () track_camera =
{
	local vector cameraAngle;
	cameraAngle = (theActor.origin - self.origin);
	cameraAngle_z = (0 - cameraAngle_z);
	self.angles = vectoangles (cameraAngle);
	self.v_angle = self.angles;
	self.think = track_camera;
	self.nextthink = (time + 0.1);
};
void (entity playerEnt) move_camera =
{
	local entity cameraPoint;
	local vector cameraAngle;
	cameraPoint = find (world, targetname, "cameraview");
	if ((cameraPoint == world))
	{
		objerror ("Could not find camerapoint!");
	}
	self.model = "";
	self.yaw_speed = 20;
	self.view_ofs = '0 0 0';
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	setorigin (self, cameraPoint.origin);
	cameraAngle = (theActor.origin - self.origin);
	self.angles = vectoangles (cameraAngle);
	self.v_angle = self.angles;
	self.think = track_camera;
	self.nextthink = (time + 0.05);
};
void () ending_remove_stuff =
{
	local entity curEnt;
	curEnt = find (world, classname, "ltrail_start");
	while (curEnt)
	{
		dremove (curEnt);
		curEnt = find (world, classname, "ltrail_start");
	}
	curEnt = find (world, classname, "item_time_core");
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord (MSG_MULTICAST, curEnt.origin_x);
	WriteCoord (MSG_MULTICAST, curEnt.origin_y);
	WriteCoord (MSG_MULTICAST, curEnt.origin_z);
	multicast (curEnt.origin, MUL_PHS);
	if (curEnt != world)
	{
		curEnt.think = SUB_Remove;
		curEnt.nextthink = (time + 0.1);
	}
};
void () actor_run =
{
	local vector dist;
	local entity pointOne;
	if ((pointcontents (self.origin) == CONTENT_LAVA))
	{
		pointOne = find (world, targetname, "point1");
		if ((pointOne != world))
		{
			setorigin (self, pointOne.origin);
		}
	}
	if ((self.goalentity.targetname == "endpoint1"))
	{
		actorStage = STAGE_AT_POINT1;
		self.think = actor_control;
		self.nextthink = (time + 0.1);
		return;
	}
	if ((self.goalentity.targetname == "endpoint2"))
	{
		actorStage = STAGE_AT_POINT2;
		self.think = actor_control;
		self.nextthink = (time + 0.1);
		return;
	}
	self.frame = (self.frame + 1);
	if ((self.frame > 11))
	{
		self.frame = 6;
	}
	dist = (self.goalentity.origin - self.origin);
	movetogoal (15);
	self.think = actor_run;
	self.nextthink = (time + 0.1);
};
void () actor_fire1 = [ 107, actor_fire2 ]
{
	self.goalentity = theMachine;
	theMachine.th_pain = time_crash;
	theMachine.th_die = time_crash;
	theMachine.health = 1;
	self.angles = vectoangles ((self.goalentity.origin - self.origin));
	self.v_angle = self.angles;
	self.v_angle_x = (0 - self.angles_x);
	self.effects = EF_MUZZLEFLASH;
	W_FireRocket ();
	WriteByte (MSG_ALL, SVC_FINALE);
	WriteString (MSG_ALL, "\nFinally, Quake's Temporal Teleporter\nyields to your assault. A high\npitched scream emits from the\ndevastated device as stressed steel\nblasts outward to rock the cavern.\nThe machine is devoured by molten lava.\n\nThe ground shudders as reality shi...");
};
void () actor_fire2 = [ 108, actor_fire3 ]
{
	self.v_angle_x = 0;
	self.angles_x = 0;
	self.nextthink = (time + 0.15);
};
void () actor_fire3 = [ 109, actor_fire4 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire4 = [ 110, actor_fire5 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire5 = [ 111, actor_fire6 ]
{
	self.nextthink = (time + 0.15);
	ending_remove_stuff ();
	if ((theMachine.health > 0))
	{
		theMachine.think = time_crash;
		theMachine.nextthink = (time + 0.1);
	}
};
void () actor_fire6 = [ 112, actor_fire7 ]
{
	self.effects = 0;
	self.nextthink = (time + 0.15);
};
void () actor_fire7 = [ 12, actor_fire8 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire8 = [ 13, actor_fire9 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire9 = [ 14, actor_fire10 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire10 = [ 15, actor_fire11 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire11 = [ 16, actor_fire12 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire12 = [ 12, actor_fire13 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire13 = [ 13, actor_fire14 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire14 = [ 14, actor_fire15 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire15 = [ 15, actor_fire16 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire16 = [ 16, actor_fire17 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire17 = [ 12, actor_fire18 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire18 = [ 13, actor_fire19 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire19 = [ 14, actor_fire20 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire20 = [ 15, actor_fire21 ]
{
	self.nextthink = (time + 0.15);
};
void () actor_fire21 = [ 16, actor_control ]
{
	self.nextthink = (time + 0.15);
	actorStage = STAGE_TO_POINT2;
};
void () actor_teleport =
{
	spawn_tfog (self.origin);
	self.model = string_null;
	self.think = SUB_Null;
	self.nextthink = (time + 999999);
};
void () actor_control =
{
	if ((actorStage == STAGE_START))
	{
		self.target = "point1";
		self.movetarget = find (world, targetname, self.target);
		self.goalentity = self.movetarget;
		if ((self.goalentity == world))
		{
			objerror ("End Sequence point1 placing screwed up!");
		}
		self.frame = 6;
		self.think = actor_run;
		self.nextthink = (time + 0.1);
		actorStage = STAGE_TO_POINT1;
	}
	else
	{
		if ((actorStage == STAGE_AT_POINT1))
		{
			self.target = "machine";
			self.movetarget = find (world, targetname, self.target);
			self.goalentity = self.movetarget;
			if ((self.goalentity == world))
			{
				objerror ("End Sequence machine placing screwed up!");
			}
			actorStage = STAGE_FIRING;
			self.think = actor_fire1;
			self.nextthink = (time + 0.1);
		}
		else
		{
			if ((actorStage == STAGE_AT_POINT2))
			{
				self.frame = 12;
				self.think = actor_teleport;
				self.nextthink = (time + 2);
			}
			else
			{
				if ((actorStage == STAGE_TO_POINT2))
				{
					self.target = "timepod";
					SUB_UseTargets ();
					self.target = "point2";
					self.movetarget = find (world, targetname, self.target);
					self.goalentity = self.movetarget;
					if ((self.goalentity == world))
					{
						objerror ("End Sequence point2 placing screwed up!");
					}
					self.frame = 6;
					self.think = actor_run;
					self.nextthink = (time + 0.1);
				}
			}
		}
	}
};
void (entity thePlayer) spawn_actor =
{
	local entity pointOne;
	theActor = spawn ();
	theActor.owner = self;
	theActor.classname = "actor";
	theActor.health = 100;
	theActor.solid = SOLID_SLIDEBOX;
	theActor.movetype = MOVETYPE_STEP;
	theActor.frame = self.frame;
	setmodel (theActor, "progs/player.mdl");
	setorigin (theActor, self.origin);
	setsize (theActor, VEC_HULL_MIN, VEC_HULL_MAX);
	theActor.view_ofs = '0 0 22';
	theActor.angles = self.angles;
	theActor.ideal_yaw = (theActor.angles * '0 1 0');
	if (!theActor.yaw_speed)
	{
		theActor.yaw_speed = 20;
	}
	theActor.view_ofs = '0 0 25';
	theActor.flags = (theActor.flags | FL_MONSTER);
	if ((pointcontents (theActor.origin) == CONTENT_LAVA))
	{
		pointOne = find (world, targetname, "point1");
		if ((pointOne != world))
		{
			setorigin (theActor, pointOne.origin);
		}
	}
	theActor.think = actor_control;
	theActor.nextthink = (time + 0.1);
};

