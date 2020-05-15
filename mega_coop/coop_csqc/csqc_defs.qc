entity		self;
entity		other;
entity		world;
float		time;
float		frametime;      //time since last CSQC_UpdateView;
float		player_localentnum;     //the entnum (can change when svc_setview is received. 0 is unknown)
float		player_localnum;        //the playernum (0 to maxclients-1)
float		maxclients;     //a constant filled in by the engine. gah, portability eh?
float		clientcommandframe;     //player movement (getinputstate(clientcommandframe-1) is the most recent available full frame)
float		servercommandframe;     //clientframe echoed off the server. By the time the client receives this, the command has been applied. Thus the first frame that needs predicting is servercommandframe+1. If this is 0, then prediction is not supported in the current network protocol (demos, legacy server - depends how csqc is authorised).
string		mapname;        //the map as found in the map command. Will not contain non-filename charactures. (expected to be used with fopen type things). Contains no directory or extension information.
vector		v_forward, v_up, v_right;
vector		view_angles;	//set at the start of each frame to state the current view angles.
// set by traceline / tracebox
float		trace_allsolid;
float		trace_startsolid;
float		trace_fraction;
vector		trace_endpos;
vector		trace_plane_normal;
float		trace_plane_dist;
entity		trace_ent;
float		trace_inopen;
float		trace_inwater;
//retrieved from the current movement commands (read by player physics), set via getinputstate
float		input_timelength;
vector		input_angles;
vector		input_movevalues;       //forwards, right, up.
float		input_buttons;          //attack, use, jump (default physics only uses jump)
float		input_impulse;
//CSQC Field Variables:
//
// system fields (*** = do not set in prog code, maintained by C code)
//
.float		modelindex; 	// *** model index in the precached list
.vector		absmin, absmax;	// *** origin + mins / maxs
.float		entnum;	// *** the ent number as on the server
.float		drawmask;
.void()		predraw;
.float		renderflags; //See RF constants
.float		movetype;	//FIXME: should this be implemented?
.float		solid;
.vector		origin;		// *** use setorigin to change this.
.vector		oldorigin;
.vector		velocity;
.vector		angles;
.vector		avelocity;
.float		pmove_flags;	//used for prediction. Its contents must be preserved between calls. And reset whenever prediction is reverted.
.string		classname;	// for debugging engines. not really required.
.string		model;
.float		frame;
.float		frame2;
.float		lerpfrac;	//this is how much of frame2 should be used.
.float		skin;
.vector		mins, maxs; // bounding box extents reletive to origin
.vector		size; // maxs - mins
.void()		touch;
.void()		think;
.void()		blocked;	// for doors or plats, called when can't push other
.float		nextthink;
.entity		chain;
.entity		enemy;
.float		flags;
.float		colormap;
.entity		owner; // who launched a missile
//CSQC Constants:
//renderflags field uses these:
float RF_VIEWMODEL = 1;
/*
	The entity is never drawn in mirrors. In engines with realtime lighting, it casts no shadows.
	It is drawn on the screen in the center, where the weapon would normally be.
	View model bobbing is applied to this entity.
*/
float RF_EXTERNALMODEL = 2;
/*
	The entity is appears in mirrors but not in the normal view. It does still cast shadows in engines with realtime lighting.
*/
float RF_DEPTHHACK = 4;
/*
	The entity appears closer to the view than normal, either by scaling it wierdly or by just using a depthrange. This will usually be found in conjunction with RF_VIEWMODEL
*/
float RF_USEAXIS = 16;
/*
	When set, the entity will use the v_forward, v_right and v_up globals instead of it's angles field for orientation. Angles will be ignored compleatly.
	Note that to use this properly, you'll need to use the predraw function to set the globals, or to add the models individually.
	An engine only needs to implement this if tags are supported.
*/

//3d scene management:
void() clearscene = #300;
/*
	Clear the scene, reset the view values to default.
*/
	
void(float mask) addentities = #301;
/*
	Add all entities according to a drawmask (added if they match).
	Acts as if R_AddEntity was called for each one of them.
	For each entity added, the predraw of that entity function will be called before being any fields are read.
*/
void(entity e) addentity = #302;
/*
	Add a single entity to the scene. It's fields are copied out immediatly. This allows for repeated calling.
	Does NOT call the predraw function. This is useful for adding the entity within a predraw function from addentitymask without recursion. (think Quad shells).
*/
float(float propertyindex, ...) setviewprop = #303;
/*
	Change a property of the 3d view.
	Returns 0 if the property id wasn't recognised or was invalid, and returns non-zero if it was applied.
	EngineHackers: Extension property indexes can be added using the same ranges as for builtins (IE: DP should add at 400+).
	Valid parameters in any compliant engine:
#define VF_MIN		1 // (vector) // (top left of the screen)
#define VF_MIN_X		2 // (float)
#define VF_MIN_Y		3 // (float)
#define VF_SIZE		4 // (vector) // (game view width/height)
#define VF_SIZE_Y		5 // (float)
#define VF_SIZE_X		6 // (float)
#define VF_VIEWPORT		7 // (vector, vector)
#define VF_FOV		8 // (vector) // (changes both fovx and fovy)
#define VF_FOVX		9 // (float) // (changes the horizontal fov. be careful with this)
#define VF_FOVY		10 // (float)
#define VF_ORIGIN		11 // (vector)	(current view origin. default is player' origin + STAT_VIEWHEIGHT)
#define VF_ORIGIN_X		12 // (float)
#define VF_ORIGIN_Y		13 // (float)
#define VF_ORIGIN_Z		14 // (float)
#define VF_ANGLES		15 // (vector) // (the angles that entity is looking on, acording to the wow resource.
#define VF_ANGLES_X		16 // (float)
#define VF_ANGLES_Y		17 // (float)
#define VF_ANGLES_Z		18 // (float)
#define VF_DRAWWORLD		19 // (float) // (defaults to enabled. if set to 0 disables particles.)
#define VF_DRAWENGINESBAR		20 // (float)
#define VF_DRAWCROSSHAIR		21 // (float)
*/
//stats 0-31 are filled by the engine.
//they are for the 'fixed function' stuff, that works without requiring csqc.
//these stats need to be standardized amoung engines, so you're not allowed to mod them, so nur.
#define STAT_HEALTH 0
#define STAT_WEAPONMODEL 2	//weapon model index, as evalutated by server code.
#define STAT_AMMO 3
#define STAT_ARMOR	 4
#define STAT_WEAPONFRAME	 5
#define STAT_SHELLS 6
#define STAT_NAILS 7
#define STAT_ROCKETS 8
#define STAT_CELLS 9
#define STAT_ACTIVEWEAPON 10	//the one shown on the hud
#define STAT_ITEMS 15
//stats 32 onwards are filled by the csqc.
enum
{
	VF_MIN = 1,
	VF_MIN_X = 2,
	VF_MIN_Y = 3,
	VF_SIZE = 4,
	VF_SIZE_X = 5,
	VF_SIZE_Y = 6,
	VF_VIEWPORT = 7,
	VF_FOV = 8,
	VF_FOVX = 9,
	VF_FOVY = 10,
	VF_ORIGIN = 11,
	VF_ORIGIN_X = 12,
	VF_ORIGIN_Y = 13,
	VF_ORIGIN_Z = 14,
	VF_ANGLES = 15,
	VF_ANGLES_X = 16,
	VF_ANGLES_Y = 17,
	VF_ANGLES_Z = 18,
	VF_DRAWWORLD = 19,
	VF_DRAWENGINESBAR = 20,
	VF_DRAWCROSSHAIR = 21,
	VF_PERSPECTIVE = 200
};
enumflags
{
	RF_VIEWMODEL,
	RF_EXTERNALMODEL,
	RF_DEPTHHACK,
	RF_ADDATIVE,
	RF_USEAXIS
};
float	MASK_ENGINE		= 1;	//this is special. Any entities known by the engine but not the csqc will be added.
//you can add any other masks below, remember, use bits.
float	MASK_NORMAL		= 2;

float(float propertyindex) getviewpropf = #309;
vector(float propertyindex) getviewpropv = #309;
/*
	propertyindex is as described above in setviewprop.
	Return type is dictated by propertyindex. Ensure you use the correct form.
	Paranoid engines are fully within their rights to return '0 0 0' for VF_ORIGIN (and sub componants). 
*/
void(vector org, float radius, vector rgb) adddynamiclight = #305;
/*
	Adds a light to the scene with the specified properties.
	Engines without coloured lighting can average out the light colours.
*/
void() renderscene = #304;
/*
	Invokes the renderer to actually draw the scene inside the call.
	Does not clear the display lists.
*/
float(string s) precache_model = #20;
/*
	Precaches a model for clientside usage. If the server qc already precached it, reuse that instead.
	Some protocols allow precaching mid-level. This may require two lists of model indexes. The indexes from the server *must* match the server at all times. It is possible that a model can end up on both lists if the server precaches mid-level. This builtin must favour the server's index over any local index.
	This can be called at any time.
	The return value is the modelindex of the specified model.
	Note that this is the same builtin as the server, but the return value is different, in order to be more useful.
	If the model does not exist, an engine may trigger a download request and load the model when it arrives (with a valid index returned), or may return 0.
*/
vector (vector v) unproject            = #310;
/*
	Converts from 2d-space to 3d-space. Uses the currently set viewport, origin, angles, and projection info from the current view properties (setviewprop).
	Note that 2d space contains depth info, in the range of 0 to 1.
*/
vector (vector v) project              = #311;
/*
	Converts from 3d-space to 2d space. Uses the currently set viewport, origin, angles, and projection info from the current view properties (setviewprop).
	Note that 2d space contains depth info, in the range of 0 to 1.
*/
/*
2d display:
2d display Note that the vectors only use the first two componants, the third is ignored. With texture names, should the csqc leave off the filename extension, The engine should scan through all the extensions that it supports. The engine must support lmp files, and 32bit bottom up tgas should be supported, pngs and jpegs are just bonuses.
Images without paths may be obtained from the gfx.wad.
*/
void(vector pos, vector size, float paletteindex) drawfillpal = #314;
/*
	Draws a single block of colour.
	Obtains the pixel colour from the palette. If no palette could be loaded, use an r3g3b2 palette (FIXME: sane?).
*/
float(string name) is_cached_pic = #316;
/*
	Returns true only if an image is already cached.
	An engine which doesn't support unloading may attempt to cache the image before checking.
	To see if a picture is valid, drawgetimagesize instead.
*/
void(string name) precache_pic = #317;
/*
	Attempts to precache an image without drawing it.
*/
vector(string picname) drawgetimagesize = #318;
/*
	Retrieves the size of an image that the engine believes it to be.
	Note that image replacement on hud elements may do inaccurate things to image scale. If a replacement image is used, it is unspecified whether the size comes from a lmp or a replacement png.
	Returns '0 0 0' if the image failed to load (FIXME: DP replaces with a replacement image, with size 64*64, this is incompatible with that).
*/
void(string name) free_pic = #319;
/*
	Un-caches an image.
	An engine is not required to implement this - can be a no-op.
*/
void(vector pos, float char, vector size, vector rgb, float alpha) drawcharacter = #320;
/*
	Draws a quake character using the quake font.
	A software rendering engine is not required to honour the size, rgb, or alpha parameters, size may be forced to '8 8 0'.
*/
void(vector pos, string text, vector size, vector rgb, float alpha) drawstring = #321;
/*
	Draws a text string using the quake font. Size is per-characture.
	A software rendering engine is not required to honour the size, rgb, or alpha parameters, size may be forced to '8 8 0'.
*/
void(vector pos, string picname, vector size, vector rgb, float alpha) drawpic = #322;
/*
	Draws an image.
	A software rendering engine is permitted to ignore size, rgb, and alpha parameters.
	Alpha testing or blending from transparencies in lmp files must be supported.
*/
void(vector pos, vector size, vector rgb, float alpha) drawfillrgb = #323;
/*
	Draws a single block of colour.
	A software renderer is not required to implement this function.
*/

void(entity e, float modelindex) setmodelindex = #333;
/*
	Sets an entity's model according to a modelindex.
	This is useful when transfering modelindexes across the network but otherwise should not be used.
*/
string(float modelindex) modelnameforindex = #334;
/*
	Retrieves the modelname from an assosiated modelindex, as a tempstring.
*/
void(float scale) setsensitivityscaler = #346;
/*
	Scales the user's sensitivity by the parameter.
	Useful for sniper zoom.
	There is no way to retrieve the value currently set.
	It is not reset by the engine until the csprogs is closed.
	The default is 1.
*/
void(string s, ...) cprint = #338;
/*
	Directs the engine to draw centered text over the screen using it's regular code as if responding to the server.
	This is a convienience function. Does not trigger CSQC_Parse_CenterPrint.
	FIXME: under which conditions is centerprint text shown? Part of hud, or world, or a new viewprop?
*/
void(string s, ...) print = #339;
/*
	print text on the console and notifiction lines. Like dprint, but doesn't need developer set.
void(float effectnum, vector org, vector vel, float countmultiplier) pointparticles = #337;
/*
	Spawns particles in the style of an ef_efname effect.
	Doesn't play sound. Doesn't spawn a dynamic light.
	The normal 'particle' builtin also works, and should be used in that event.
*/
void(float effectnum, entity ent, vector start, vector end) trailparticles = #336;
/*
	Spawns particles in the style of an ef_efname effect.
	Doesn't play sound. Doesn't spawn a dynamic light.
	The normal 'particle' builtin also works, and should be used in that event.
	The ent parameter is used to track trail states (eg: sparse trails and high framerates). You can use 'world' if you want an independant non-progressive beam.
*/
float(string efname) particleeffectnum = #335;
/*
	Returns an effect number which can be passed into one of the particle effect spawn functions.
	Returns 0 if the effect name was not recognised (or was not loaded/supported).
	Do not assume all engines will return the same values. Engines with fully scriptable effects will not do so, do not assume that the same engine will always return the same indexes either.
	These are the non-extended names that should be supported:
               te_explosion (rockets), te_tarexplosion (tarbaby), te_gunshot, te_wizspike, te_knightspike, te_spike, te_superspike, te_teleport, te_lavasplash
*/
float(float framenum) getinputstate = #345;
/*
	Reads view-angles and other properties into csqc's input_* globals.
	Returns false if the framenum is out-of-date (failure).
	This forms part of the prediction support.
	The servercommandframe global contains the last input frame acknowledged by the server, while clientcommandframe contains the most recent frame generated by the client.
	Thus frames (servercommandframe+1) to (clientcommandframe-1), inclusive, must be applied to the player's entity state in order for prediction to work.
*/

void(entity ent) runplayerphysics = #347;
/*
	Runs the engine's standard prediction algorithms.
	Can do nothing if the engine doesn't want to provide one (but must be present).
	Exact physics behaviour is up to the implementation. Behaviour should be consistant between alternate implementations of the same network protocol.
	Reads input_* globals.
	Changes origin, velocity, pmove_flags. Triggers touch functions.
*/
float() isdemo = #349;
/*
	Returns non-zero if playing a demo.
*/
float() isserver = #350;
/*
	Returns true if the mod can communicate with the server via cvars and console commands and things (eg: map).
	This is intended for admin/single-player purposes. A mod with full voting will not want to use this.
*/

string(float keynum) keynumtostring = #340;
/*
	Retrieves the name of a key (as used by the bind console command)
*/
float(string keyname) stringtokeynum = #341;
/*
	Finds the key number of the named keyboard/mouse/joystick button/key.
*/
string(float keynum) getkeybind = #342;
/*
	Obtains the full command that a button is bound to.
	To set the key binding, use localcmd with the bind console command, preferably do not force it.
*/
void(vector origin, vector forward, vector right, vector up) setlistener = #351;
/*
	Updates the sound listener origin and orientation.
	Should be done once per frame. Failure to do so will revert to the engine's default, which will be inaccurate if you're using player prediction.
*/
void(string model, void(float isnew) updatefunc, float flags) deltalisten = #371;
/*
	Registers a function to be called whenever a delta entity with a model matching the given name would be linked.
	This gives a way to expose delta entities to the csqc filtered by name.
	If model is "*", this registers all models (can be overwrite previous registrations. Use a null updatefunc to unregister.).
	Flags must be one of:
		RSES_NOLERP=1	disables origin/angles lerping of the entity. This is vital for player entities which will be predicted.
		RSES_NOROTATE=2 disables auto-rotate based on effects. FIXME: do rotate as part of addentity instead?
		RSES_NOTRAILS=4	disables the addition of rocket trails. FIXME: part of addentity instead?
		RSES_NOLIGHTS=8 disables dlights. FIXME: part of addentity instead?
	Fields set each frame before the registered updatefunc is called are:
		modelindex
		origin
		angles
		velocity (if known, unchanged if not)
		skin
		effects
		colormap
		frame
		frame2
		lerpfrac
		frame1time
		frame2time
	Warning: Additional fields may be set depending on network protocol.
	Warning: If this builtin is used, entities can be spawned and removed as part of addentities.
	Warning: If the modelindex changed, the ent may have lingering (custom) fields from the previous ent type.
*/
#define RSES_NOLERP 1	//only really for use on predicted player entities
#define RSES_AUTOROTATE 0
#define RSES_NOROTATE 2
#define RSES_AUTOTRAILS 0
#define RSES_NOTRAILS 4
#define RSES_AUTOLIGHTS 0
#define RSES_NOLIGHTS 8
float() readbyte = #360;
float() readchar = #361;
float() readshort = #362;
float() readlong = #363;
float() readcoord = #364;
float() readangle = #365;
string() readstring = #366;
float() readfloat = #367;
float() readentitynum = #368;
/*
	Reads a part of a network message.
	Note that these builtins are only valid when the engine directs the csqc to start reading. Valid only during that call.
	In the case of readstring, it is returned within a temporary string.
	It is up to the engine exactly how big coords and angles are, so the csqc must ensure correct matching.
	For entities, readentitynum reads only an entity number. This must be matched to an entity with a matching .entnum field. The given entity may not always be known, so matching up in the parse function may not be advantageous.
*/
float(float statnum) getstatf = #330;
/*
	Returns the floating point value of a client stat.
	It is not recommended to use this builtin for STAT_ITEMS due to overflowing floats, but is fine for any of the other standard stats.
*/
float(float statnum) getstati = #331;
float(float statnum, float first, float count) getstati_bits = #331;
/*
	Returns the client stat value rounded to an integer. This may give additional precision.
	If first and count are used, retrieves only the bits specified and shifts down (this is used for sigils in the STAT_ITEMS stat)
	FIXME: Is it sane that this returns a float when its obtaining an int?
*/
string(float statnum) getstats = #332;
/*
	Returns a client stat string. String stats have independant stat indexes from numerical stats.
	This will return a temp string.
*/
string(float playernum, string keyname) getplayerkey = #348;
/*
	Obtains various player specific things. Items that must be supported are:
	name, frags, bottomcolor, topcolor.
	This info is required for scoreboards.
	Negative player indexes are interpreted as frag-sorted. -1 is the leading player, -2 is the second best player. There is no explicit teamplay support.
	This is akin to quakeworld's infokey builtin with a player number.
	Note: QuakeWorld engines normally provide a team field. NQ engines typically use bottomcolor.
*/
string(string key) serverkey = #354;
/*
	Obtains various server related things. Items that must be supported are:
	ip.
	This is akin to quakeworld's infokey builtin with serverinfo.
*/
string() getentitytoken = #355;
/*
	This builtin is valid only inside CSQC_WorldLoaded.
	It returns the next token from the bsp.
	Entities take the form
{ key value }
	Each return is a tempstring, of which there will be at least two alternating tempstrings.
	Returns the null string when there are no more tokens. This is distinct from an empty string.
	Tokenizing rules match the server loading.
*/
void(string name, string value) registercvar = #93;
void(string str) registercommand = #352;
/*
	Registers a console command. Any commands that are registered will cause CSQC_ConsoleCommand to be called any time the user tries using the command. The command should have top-most priority, above even aliases.
*/
float() wasfreed = #353;
/*
	Returns true if the entity was recently freed with the remove builtin, and hasn't been reused yet. Note that at the start of a map this builtin can be unreliable. Otherwise it should have 2 seconds to be reliable (before the entity is reused). This makes the physics code with touch/think functions easier.
	Avoid using this builtin unless you know the entity was valid before a function was called.
*/
//void(vector org, vector forward, vector right, vector up) setlistener = #351;
/*
	This builtin allows the csqc to position the 'listener'. This will affect the volume of sounds playing nearby. The directions are required for correct audio spacialisation (just use makevectors).
*/
void(string evname, string evargs, ...) sendevent = #359;
/*
	When called, sends an event to the server gamecode.
	On the server, a function named Cmd_evname_EVARGS will be called with the args passed in.
	evargs specifies the types of the additional arguments.
	Only f: float, e: entity, v: vector, and s: string are supported.
	If e is used, the entity's entnum field is used instead for sending. If anything is invalid or freed, the server qc will receive 'world' instead.
	If s is used, the server will receive a tempstring.
	This function is limited to 6 custom arguments.
	There is nothing stopping you from packing multiple floats into a vector if you need more arguments.
*/
// More builtins
void(...) localcmd = #46;
float(string s) tokenize = #441;
string(float argnum) argv = #442;
float(string s) cvar = #45;						// return cvar.value
float(string s) stof	= #81;
string(float f) ftos				= #26;
float(string st) strlen = #114;
entity() spawn						= #14;
string(string s) cvar_string = #448;
string (vector v) vtos = #27; 
string(string s, float start, float length) substring = #116;
void (entity e) remove = #15; 
float (vector v) vlen = #12; 
float () random = #7; 
// Misc
#define TRUE	1
#define FALSE	0
float csqc_sent;				// tell the server that we support csqc
entity monsterbar;
// GiffE's status bar stuff
float vid_conwidth, vid_conheight;
float progress;
// TF reload status bar
float reloadtime_begin, reloadtime_end;
float cltime;
float cgrentimer;
float coop_exp;
float illegalclasses, illegal_team_classes;
// CSQC GUI
float in_menu, menu_selected, menu_impulse, mouse_branch;
float global_bt_no, global_menu_flags;
vector mousepos, testsize_one;
.string bt_text, bt_cmd, bt_img;
.float bt_flags, bt_no;
float () MouseInBox;
void (string menu_name, float menu_flags) InitMenu;
void (string button_text, string button_cmd, vector button_spawnpos, string button_image, vector button_size, float button_flags) CreateButton;
#define MENU_CLASS_SELECT		3
#define MENU_TEST1 				666
#define MENU_TEST_DROPDOWN		663
// global menu flags
#define MFG_NOCURSOR			1
#define MFG_KEYBOARDINPUT		2
// menu flags
#define MENUFLAG_DISABLED		1
#define MENUFLAG_BRANCH			2
vector p_org;
vector pmove_org;
vector p_ang;
void (entity e, vector o) setorigin = #2; 
void (entity e, string m) setmodel = #3; 
void (entity e, vector min, vector max) setsize = #4; 
#define ODE_PHYSICS
#ifdef ODE_PHYSICS
float physics_cleanup_time;
.float physics_time;			// amount of time an object should stay in the world
//DP_PHYSICS
float SOLID_PHYSICS_BOX = 32;
float SOLID_PHYSICS_SPHERE = 33;
float SOLID_PHYSICS_CAPSULE = 34;
const float SOLID_PHYSICS_TRIMESH = 35;
float MOVETYPE_PHYSICS = 32;
.float mass, jointtype;
#define JOINTTYPE_POINT 1
#define JOINTTYPE_HINGE 2
#define JOINTTYPE_SLIDER 3
#define JOINTTYPE_UNIVERSAL 4
#define JOINTTYPE_HINGE2 5
#define JOINTTYPE_FIXED -1
.entity aiment;
.vector movedir;
.float bouncefactor;
.float bouncestop;
void (vector ang) makevectors = #1; 
void (float isnew) RefreshGrunt;
.entity ragmodel;
#endif
//END