// Half-Life 1 definitions and such
#ifdef mtf_coop_halflife
#define SVEN_COOP				// tells quakelife not to rely on landmarks and utilize sven coop map configs/spawn entities
#define COOP_HAX				// sigh, stuff I need to "hack" to get working due to lack of FTE features
// sprites
//#define ALLOW_HL_SPRITES		// ADDME: when engines besides FTE support HL1 sprites I will re-enable this.

void () HalfLife_DoRender;			// Half-Life 1
void () SetSpawnObject;				// Half-Life 1

// timers
void ( string to_trigger, float trig_delay ) Delayed_Timer;

#define START_ONFX		1

.void() hl_use;				// half-life 1 Use properties

//void(vector tdest, float destangle, float tspeed, float angspeed, void() func) SUB_CalcMoveAndRotate;

// half life 1 master stuff

float ( entity t_ent ) has_master; // half life 1 master stuff
float ( entity t_ent ) activate_master; // half life 1 master stuff

// Landmarks
float () HalfLife_UseLandmark;		//Landmark stuff for half life 1.

void ( entity rt_ent, float rt_dir, float traveltime, float rtate, float rt_fps ) CreateRotator;
void () HalfLife_SetupLandmark;

//Doors stuff
void() door_use;
void() door_touch;
void() door_killed;
void () Delayed_Use;
void () ladder_touch;
#define ROTATE_X		0
#define ROTATE_Y		1
#define ROTATE_Z		2
#ifdef COOP_HAX
#define HL_MAP		cvar("sv_map_halflife") == 1
#else
#define HL_MAP		cvar("halflifebsp") == 1
#endif
void() liquid_touch;
.void() monstertype;					// monster spawner
.void() th_sight;				// misc monsters
string(string n) cvar_string;// = #448;
void(vector v1, vector min, vector max, vector v2, float nomonsters, entity forent) tracebox = #90;
void(string s, string eh) changelevel_save = #70;
string(string s) strtoupper = #481;			// DARKPLACES
string(float ccase, float redalpha, float redchars, string str, ...) strconv = #224;		// FTE
float (float n) sin = #60;
float (float n) cos = #61;
#define SOLID_LADDER			20

// hacks
.string sentence;						// hacks half-life1
string ( string cstr ) hl_script_str;	// hacks half-life1
float MOD_HLIFE =			666;		// hacks half-life1

// hldprint: I only used this function for testing various things. You may find calls to it throughout the code, but they are useless now.
//#define HLDPM

void (float nno, string msg) hldprint =
{
#ifdef HLDM
	bprint( nno, msg );
#endif
};
void () compiler_likes_me_so_much_yay =
{
	//empty_float = 0;
	self.maxspeed = 0;
	self.light_lev = 0;
	//self.wad = "";
};

void () changelevel_touch;
void () info_landmark;
void () trigger_relay_use;

#ifdef COOP_HAX
void (entity useOwner, vector useOrigin) Create_Useme;
#endif

#endif#endif
//END
