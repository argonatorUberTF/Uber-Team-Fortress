// Parse stuff from here, do stuff elsewhere
//This QC function is called by the engine when the csqc is first loaded.
void() CSQC_Init =
{
	local entity testmenu;
	precache_pic("progs/csqc/grenclock01.tga");
	precache_pic("progs/csqc/grenclock02.tga");
	precache_pic("progs/csqc/grenclock03.tga");
	precache_pic("progs/csqc/grenclock04.tga");
	precache_pic("progs/csqc/grenclock05.tga");
	precache_pic("progs/csqc/xp.tga");
	precache_pic("progs/csqc/gold.tga");
	precache_pic("progs/csqc/csqcguiback.tga");
	//precache_pic("progs/csqc/mtfn.jpg");
	precache_pic("progs/csqc/tsbanner_600.png");
	registercvar("c_grenadetimer","1");
	progress = FALSE; // By default we want our progress bar to not be on
	registercommand("showprogress"); // This command turns on and off the progress bar
	registercvar("c_progressbar","0"); // This cvar is the percent of the progress bar you would like to be filled
	registercommand("spawnbox");
	registercommand("test2");
	registercommand("testmenu");
	registercommand("testmenu2");
// Menu stuff (now less ugly)
	registercvar("csqcgui_menu","0");			// info on the current menu
   /*
   registercvar("csqcgui_menu_1","0");
   registercvar("csqcgui_menu_2","0");
   registercvar("csqcgui_menu_3","0");
   registercvar("csqcgui_menu_4","0");
   */
#ifdef ODE_PHYSICS
	precache_model("progs/snow_gib1.mdl");
	precache_model("progs/snow_gib2.mdl");
	precache_model("progs/h_snowman.mdl");
	precache_model("progs/phys/ragsold_legsout.md5mesh");
	precache_model("progs/phys/ragsold_torsoout.md5mesh");
	precache_model("progs/phys/ragsold_upperout.md5mesh");
	precache_model("progs/phys/ragsold_legs.mdl");
	precache_model("progs/phys/ragsold_torso.mdl");
	precache_model("progs/phys/ragsold_upper_p1.mdl");
	precache_model("progs/phys/ragsold_upper_p2.mdl");
	precache_model("progs/phys/ragsold_larm.mdl");
	precache_model("progs/phys/ragsold_rarm.mdl");
	precache_model("progs/phys/ragsold_gun.mdl");
	precache_model("progs/phys/phys_sphere.mdl");
	precache_model("progs/phys/phys_ball.mdl");
	registercommand("spawnrag");
	registercommand("spawnball");
	deltalisten("progs/soldier_neh.mdl", RefreshGrunt, RSES_NOROTATE);
#endif
	//deltalisten("progs/player.mdl", RefreshPlayer, /*RSES_NOLERP|*/RSES_NOROTATE);	//animate players/player-corpses
};
//Called when the csqc is shutting down cleanly (not called if there was some sort of error).
void() CSQC_Shutdown =
{};
void() CSQC_WorldLoaded =
{};
float (float t_menu, float meflag_a, float meflag_b) SetupMenu =
{
	if (in_menu == t_menu)
		return TRUE;
	CSQCGUI_ClearMenu();		// Clear the current menu
	in_menu = t_menu;
	if (in_menu == MENU_CLASS_SELECT)
		Menu_ClassSelect(meflag_a, meflag_b);
	else if (in_menu == 12)
		Menu_SpySpecial();
	else if (in_menu == 13)
		Menu_SpyChangeSkin();
	else if (in_menu == 14)
		Menu_SpyChangeColor();
	else if (in_menu == 20)
		Menu_MegaTF();
	else {
		CSQCGUI_ClearMenu();
	}
	return TRUE;
};
void ( float expadded ) ShowAddedEXP =
{
	local entity newexp;
	newexp = spawn();
	newexp.bt_no = expadded;
	newexp.classname = "show_exp";
	newexp.origin_y = vid_conheight * 0.45;
	newexp.origin_x = vid_conwidth * 0.51;
	newexp.alpha = 1.45;
	//print("Added new exp with val", ftos(expadded), "\n");
};
#ifdef ODE_PHYSICS
void () physobj_touch =
{
	if (other == world)
		return;
	//print(other.classname);
	//print("hehe\n");
};
void (float objtype, string objmodel, vector obj_org, vector obj_vel ) SpawnPhysObj =
{
	local entity physobj;
	// ADDME: objtype
	physobj = spawn();
	setmodel(physobj, objmodel);
	setorigin(physobj, obj_org);
	physobj.drawmask = MASK_NORMAL;
	physobj.solid = SOLID_PHYSICS_SPHERE;
	physobj.movetype = MOVETYPE_PHYSICS;
	physobj.velocity = obj_vel;
	physobj.touch = physobj_touch;
	physobj.owner = self;
	physobj.classname = "object_physics";
	physobj.physics_time = time + 5 + random()*10;
};
#endif
float(string cmd) ParseCommand =
{
	local float args;
#ifdef ODE_PHYSICS
	local float gibtype;
	local vector spawnorg, blowup;
#endif
	args = tokenize(cmd);
	if (argv(1) == "showprogress") {
		if (argv(2) != "") {
			reloadtime_begin = cltime;
			reloadtime_end = cltime + stof(argv(2));
		}
		return TRUE;
	}
	else if (argv(1) == "grentimer") {
		if (argv(2) != "") {
			cgrentimer = cltime + stof(argv(2)) + 1;
		}
		return TRUE;
	}
#ifdef ODE_PHYSICS
	else if (argv(1) == "spawngibs") {
		
		gibtype = stof(argv(2));
		spawnorg_x = stof(argv(3));
		spawnorg_y = stof(argv(4));
		spawnorg_z = stof(argv(5));
		if (!gibtype) {
			print("warning: spawngibs called without any arguments\n");
			return TRUE;
		}
		if (!spawnorg) {
			print("warning: spawngibs called without enough vectors\n");
			return TRUE;
		}
		if (random() < .5)
			blowup_z = stof(argv(6)) * (2*random()) * -1;
		else
			blowup_z = stof(argv(6)) * (2*random());
		if (random() < .5)
			blowup_y = stof(argv(6)) * (2*random()) * -1;
		else
			blowup_y = stof(argv(6)) * (2*random());
		blowup_x = stof(argv(6)) * -1;
		if (gibtype == 1) {			// snowman
			SpawnPhysObj( 1, "progs/snow_gib1.mdl", spawnorg, blowup );
			SpawnPhysObj( 1, "progs/snow_gib2.mdl", spawnorg + '0 0 20', blowup );
			SpawnPhysObj( 1, "progs/h_snowman.mdl", spawnorg + '0 0 50', blowup );
		}
		return TRUE;
	}
#endif
	else if (argv(1) == "setexp") {
		if (!csqc_sent) {
			localcmd("cmd csqc_client\n");
			csqc_sent = TRUE;
		}
		if (argv(2) != "") {
			ShowAddedEXP ( stof(argv(2)) - coop_exp );
			coop_exp = stof(argv(2));
			//print(argv(2)," arg2\n");
			//cgrentimer = cltime + stof(argv(2)) + 1;
		}
		return TRUE;
	}
	else if (argv(1) == "monsbar") {
		if (monsterbar == world)
			monsterbar = spawn();
		monsterbar.alpha = 2;
		monsterbar.bt_no = stof(argv(2)) / stof(argv(3));
		//print(argv(2), " and ", argv(3), "\n");
	}
	else if (argv(1) == "loadmenu") {
		if (argv(2) == "clear" || stof(argv(2)) < 1) {
			CSQCGUI_ClearMenu();
		}
		if (argv(2) != "") {
			SetupMenu( stof(argv(2)), stof(argv(3)), stof(argv(4)) );
		}
		return TRUE;
	}
	return FALSE;
};
float (string cpt) CSQC_Parse_CenterPrint =
{
	local float args;
	args = tokenize(cpt);
	//print("
	if (in_menu)
		return TRUE;
	return FALSE;
};
//Called whenever the engine receives an svc_stuffcmd. Instead of executing it immediatly on the console, it is instead passed to the csqc for correct handling. This could be passed on to localcmd, for example (the string includes a new line, and could be multiple lines).
void(string cmd) CSQC_Parse_StuffCmd =
{
	if (ParseCommand(cmd) == TRUE)
		return;
	localcmd(cmd);
	localcmd("\n");
};
#ifdef ODE_PHYSICS
entity (vector entorg, string entmodel, float turnangle, float entmass, float x) Bone_MakeCloth =
{
	local entity tent2;
	tent2 = spawn();
	setmodel(tent2, entmodel);
	setorigin(tent2, entorg);
	tent2.angles_y += turnangle;
	tent2.drawmask = MASK_NORMAL;
	if (!entmass)
		tent2.mass = .2;
	else
		tent2.mass = entmass;
	tent2.solid = SOLID_PHYSICS_BOX;
	//tent2.movetype = 0;
	if (x == 1) {
		print("NOMOVE\n");
		tent2.movetype = 0;
	}
	else
		tent2.movetype = MOVETYPE_PHYSICS;
	//tent2.movetype = 0;
	//tent2.bouncefactor = 1000;
	//tent2.bouncestop = 1000;
	return tent2;
};
entity (vector entorg, string entmodel, float turnangle, float entmass) Bone_MakeBone =
{
	local entity tent2;
	tent2 = spawn();
	setmodel(tent2, entmodel);
	setorigin(tent2, entorg);
	tent2.angles_y += turnangle;
	tent2.drawmask = MASK_NORMAL;
	if (!entmass)
		tent2.mass = .2;
	else
		tent2.mass = entmass;
	tent2.solid = SOLID_PHYSICS_BOX;
//tent2.movetype = 0;
	tent2.movetype = MOVETYPE_PHYSICS;
	//tent2.bouncefactor = 1000;
	//tent2.bouncestop = 1000;
	return tent2;
};
entity (vector jointorg, vector jointoffset, string jointmodel, entity attach1, entity attach2, float yforce, float zforce) Joint_MakeJoint =
{
	local entity joint1;
	local vector joffset_fix, joffset;
	joint1 = spawn();
	setmodel(joint1, jointmodel);
	joint1.drawmask = MASK_NORMAL;
	makevectors(attach1.angles);
	joffset = (v_forward * jointoffset_x) + (v_right * (jointoffset_y * -1)) + (v_up * jointoffset_z);
	//print(vtos(joffset), "is joffset\n");
	setorigin(joint1, jointorg + joffset);
	joint1.jointtype = JOINTTYPE_UNIVERSAL;
	joint1.movetype = 0;
	joint1.aiment = attach1;
	joint1.enemy = attach2;
	//joint1.origin = jointorg;
	joint1.movedir_x = 22;
	if (yforce)
		joint1.movedir_y = yforce;
	else
		joint1.movedir_y = 2000;
	if (zforce)
		joint1.movedir_z = zforce;
	else
		joint1.movedir_z = .3;
	print(vtos(joint1.origin), "is origin of joint\n");
	return joint1;
};
//#define zstyle
#define MAX_CLOTH				107
entity cloth [#MAX_CLOTH]; 
void (vector topleft_org) Make_Cloth =
{
	local float x, y, x_width, y_width, i, x_pos, y_pos;
	local float jointpos;
	local entity flag_sphere, joint, point1, point2;
	local vector point_org;
	x = 9;						// horizontal rows
	y = 9;						// vertical rows
	x_width = 10;				// horizontal spacing between joints
	y_width = 10;				///
	i=0;
	while (i < #MAX_CLOTH) {
		cloth[i] = world;
		i++;
	}
	// Create the points
	i=0;
	while (i < x*y) {
		point_org = topleft_org;
		point_org_z -= y_width * y_pos;
		point_org_x += x_width * x_pos;
		if (i < x)
			flag_sphere = Bone_MakeCloth(point_org, "progs/phys/phys_sphere.mdl", 0, 0.3, 1);
		else
			flag_sphere = Bone_MakeCloth(point_org, "progs/phys/phys_sphere.mdl", 0, 0.3, 0);
		cloth[i] = flag_sphere;
		x_pos++;
		if (x_pos >= x) {
			x_pos = 0;
			y_pos++;
		}
		
		if (x_pos > x || y_pos > y)
			break;
		i++;
	}
	x_pos = 	0;
	y_pos = 	0;
	x_width = 	0;
	y_width = 	0;
	// Create the joints
		//print(vtos(cloth[0].origin), " org 1\n");
		//print(vtos(cloth[1].origin), " org 2\n");
	//joint = Joint_MakeJoint( cloth[jointpos].origin, cloth[jointpos+1].origin, "progs/dot1.spr", cloth[jointpos], cloth[jointpos+1], 100, 1.7 );
	//joint = Joint_MakeJoint( cloth[jointpos].origin, cloth[jointpos+1+(y_pos*(x+1))].origin, "", cloth[jointpos], cloth[jointpos+1+(y_pos*(x+1))], 100, 1.7 );
	i=0;
	while (i < x*y) {
		jointpos = x_pos + y_pos*x;
	
		if (cloth[jointpos+1] == world)
			break;
		jointpos = i;
#ifdef zstyle
		// attach to join on side " - "
		if (x_pos < x && cloth[jointpos+1] != world) 
			joint = Joint_MakeJoint( cloth[jointpos].origin, (cloth[jointpos].origin-cloth[jointpos+1].origin), "", cloth[jointpos], cloth[jointpos+1], 500, 0.1 );
// attach to join diagonally downwards  "\..
		//print(ftos(i)," aye 2\n");
		//if (cloth[jointpos+x+1] == world)
			//print("NAAAHHH\n");
		if (cloth[jointpos+x+1] != world)
			joint = Joint_MakeJoint( cloth[jointpos].origin, (cloth[jointpos].origin-cloth[jointpos+x+1].origin), "", cloth[jointpos], cloth[jointpos+x+1], 500, 0.1 );
#else
		if (x_pos < 8 && cloth[jointpos+x+1] != world) {
			point1 = cloth[jointpos];
			point2 = cloth[jointpos+x+1];
			joint = Joint_MakeJoint( point1.origin, ((point2.origin-point1.origin)*0.5), "", point1, point2, 500, 0.1 );
			point1 = cloth[jointpos+1];
			point2 = cloth[jointpos+(x)];
			joint = Joint_MakeJoint( point1.origin, ((point2.origin-point1.origin)*0.5), "", point1, point2, 500, 0.1 );
			point1 = cloth[jointpos];
			point2 = cloth[jointpos+1];
			joint = Joint_MakeJoint( point1.origin, ((point2.origin-point1.origin)*0.5), "", point1, point2, 500, 0.1 );
		}
/*
		// attach to join on side " - "
		if (x_pos < 8 && cloth[jointpos+1] != world) 
			joint = Joint_MakeJoint( cloth[jointpos].origin, (cloth[jointpos].origin-cloth[jointpos+1].origin), "", cloth[jointpos], cloth[jointpos+1], 500, 0.1 );
			
		if (y_pos < 8 && cloth[jointpos+x] != world) 
			joint = Joint_MakeJoint( cloth[jointpos].origin, (cloth[jointpos].origin-cloth[jointpos+x].origin), "", cloth[jointpos], cloth[jointpos+x], 500, 0.1 );	
*/			
#endif		
		// attach to join diagonally downwards  "\..
		
		//print(ftos(i)," aye 2\n");
		//if (cloth[jointpos+x+1] == world)
			//print("NAAAHHH\n");

		//if (cloth[jointpos+x+1] != world)
		//	joint = Joint_MakeJoint( cloth[jointpos].origin, (cloth[jointpos].origin-cloth[jointpos+x+1].origin), "", cloth[jointpos], cloth[jointpos+x+1], 500, 0.1 );
		
		//if (cloth[jointpos] != world)
		//	cloth[jointpos].velocity_x = random()*-100000;
		
		
		x_pos++;
		if (x_pos >= x) {
			x_pos = 0;
			y_pos++;
		}
	
		i++;
	}
	
};
#endif
float CSQC_ConsoleCommand(string strMessage) =
{
	local float args;
#ifdef ODE_PHYSICS
	local float bone_angle;
	local entity tent, tent2, tent3, tent4, tent5, tent6, tent7, tent8, joint1, joint2, joint3, joint4, joint5, joint6, joint7;
#endif
	args = tokenize(strMessage);
	
	if (argv(0) == "testmenu") {
		if (in_menu) {
			CSQCGUI_ClearMenu();
			return TRUE;
		}
		CSQCGUI_ClearMenu();		// Clear the current menu
		in_menu = MENU_TEST1;
		Menu_TestMenu();
		
	}
	
	if (argv(0) == "clearmenu") {
		if (in_menu) {
			CSQCGUI_ClearMenu();
			return TRUE;
		}
	}
	else if (argv(0) == "testmenu2") {
		CSQCGUI_ClearMenu();		// Clear the current menu
		in_menu = MENU_TEST_DROPDOWN;
		//print(argv(1)," eyyy\n");
		Menu_DropdownMenu(stof(argv(1)));
		
	}
	if (argv(0) == "test2")
		cprint(ftos(time));
	if (argv(0) == "showprogress") {
		if (argv(1) != "") {
			reloadtime_begin = cltime;
			reloadtime_end = cltime + stof(argv(1));
		}
		return 1;
	}
	if (argv(0) == "spawnbox") {
		if (argv(1) != "") {
		}
		return 1;
	}
#ifdef ODE_PHYSICS
	if (argv(0) == "spawnrag") {
		Make_Cloth('624 320 104');
		/*
		bone_angle = 86;
		// legs
		tent = Bone_MakeBone('624 320 24', "progs/phys/ragsold_rleg.mdl", bone_angle, 0.3);
		tent7 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_lleg.mdl", bone_angle, 0.3);
		// torso
		tent2 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_torso.mdl", bone_angle, 0.4);
		// upper body
		tent3 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_upper_p1.mdl", bone_angle, 0.5);
		tent8 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_upper_p2.mdl", bone_angle, 0.5);
			//tent4 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_gun.mdl");
		// arms
		tent5 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_larm.mdl", bone_angle, 0.3);
		tent6 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_rarm.mdl", bone_angle, 0.3);
		// -=============== JOINTS ==============-
		// lower legs
		joint1 = Joint_MakeJoint( tent.origin, (-1*'4 6 5'), "", tent, tent2, 100, 1.7 );
		joint6 = Joint_MakeJoint( tent.origin, (-1*'4 -5 5'), "", tent7, tent2, 100, 1.7 );
		// torso/mid-body
		joint2 = Joint_MakeJoint( tent.origin, ('0 0 9'), "", tent2, tent3, 800, 0.1 );
		joint7 = Joint_MakeJoint( tent.origin, ('-4 0 17'), "progs/dot3.spr", tent3, tent8, 400, 1.1 );
		// arms
		joint4 = Joint_MakeJoint( tent.origin, ('-6 8 21'), "", tent8, tent5, 200, 1.7 );
		joint5 = Joint_MakeJoint( tent.origin, ('-6 -8 21'), "", tent8, tent6, 100, 1.7 );
		
		tent2.velocity_x = random()*-100000;
		*/
		// "progs/dot3.spr"
		/*
	joint1 = spawn();
	setmodel(joint1, "progs/dot1.spr");
	joint1.drawmask = MASK_NORMAL;
	setorigin(joint1, tent.origin);
	joint1.jointtype = JOINTTYPE_UNIVERSAL;
	joint1.movetype = 0;
	joint1.aiment = tent;
	joint1.enemy = tent2;
	joint1.origin = joint1.origin - '0 0 5';
	joint1.movedir_x = 22;
	joint1.movedir_y = 2000;
	joint1.movedir_z = .3;
	joint2 = spawn();
	setmodel(joint2, "progs/dot2.spr");
	joint2.drawmask = MASK_NORMAL;
	setorigin(joint2, tent.origin);
	joint2.jointtype = JOINTTYPE_UNIVERSAL;
	joint2.movetype = 0;
	joint2.aiment = tent2;
	joint2.enemy = tent3;
	joint2.origin = joint2.origin + '0 0 9';
	joint2.movedir_x = 22;
	joint2.movedir_y = 2000;
	joint2.movedir_z = .3;
	tent.bouncefactor = 1000;
	tent.bouncestop = 1000;
	tent2.bouncefactor = 1000;
	tent2.bouncestop = 1000;	
	tent3.bouncefactor = 1000;
	tent3.bouncestop = 1000;
	*/
		//tent.velocity_x = random()*300;
		
		print("RAG SPAWNED\n");
	}
	else if (argv(0) == "spawnball") {
	print("heyyy\n");
		tent = Bone_MakeBone(getviewpropv(VF_ORIGIN) + '0 0 24', "progs/phys/phys_ball.mdl", 0, 50);
		makevectors(getviewpropv(VF_ANGLES));
		tent.velocity = v_forward * 2000;
	}
#endif
	
	return 0;
};
#ifdef ODE_PHYSICS
entity () RagSoldier =
{
	local float bone_angle;
	local entity tent, tent2, tent3, tent4, tent5, tent6, tent7, tent8, joint1, joint2, joint3, joint4, joint5, joint6, joint7;
	bone_angle = self.angles_y;
	print(vtos(self.origin), " iS MEIN ORIGIN\n");
	// legs
	tent = Bone_MakeBone(self.origin, "progs/phys/ragsold_rleg.mdl", bone_angle);
	tent7 = Bone_MakeBone(self.origin, "progs/phys/ragsold_lleg.mdl", bone_angle);
	// torso
	tent2 = Bone_MakeBone(self.origin, "progs/phys/ragsold_torso.mdl", bone_angle);
	// upper body
	tent3 = Bone_MakeBone(self.origin, "progs/phys/ragsold_upper_p1.mdl", bone_angle);
	tent8 = Bone_MakeBone(self.origin, "progs/phys/ragsold_upper_p2.mdl", bone_angle);
	//tent4 = Bone_MakeBone('624 320 24', "progs/phys/ragsold_gun.mdl");
	// arms
	tent5 = Bone_MakeBone(self.origin, "progs/phys/ragsold_larm.mdl", bone_angle);
	tent6 = Bone_MakeBone(self.origin, "progs/phys/ragsold_rarm.mdl", bone_angle);
	// -=============== JOINTS ==============-
	// lower legs
	joint1 = Joint_MakeJoint( tent.origin, (-1*'4 6 5'), "", tent, tent2, 2000, 0.3 );
	joint6 = Joint_MakeJoint( tent.origin, (-1*'4 -5 5'), "", tent7, tent2, 2000, 0.3 );
	// torso/mid-body
	joint2 = Joint_MakeJoint( tent.origin, ('0 0 9'), "", tent2, tent3, 2000, 0.5 );
	joint7 = Joint_MakeJoint( tent.origin, ('-4 0 17'), "progs/dot3.spr", tent3, tent8, 1000, 0.9 );
	// arms
	joint4 = Joint_MakeJoint( tent.origin, ('-6 8 21'), "", tent8, tent5, 1000, 4 );
	joint5 = Joint_MakeJoint( tent.origin, ('-6 -8 21'), "", tent8, tent6, 1000, 4 );
	makevectors(self.angles);
	tent2.velocity = -1 * (v_forward * 5000);
	tent2.velocity_z += 300;
	return tent;
};
void() Soldier_Animate =
{
	local entity ragme;
	if (self.frame == 8 || self.frame == 18) {
		print("INSERT RAGDOLL HERE\n");
		if (self.ragmodel == world)
			self.ragmodel = RagSoldier();
	}
};
void (float isnew) RefreshGrunt =
{
	self.drawmask = MASK_NORMAL;
	self.predraw = Soldier_Animate;
//	self.drawmask = 0;
	setmodel(self,"");
};
#endif
//END