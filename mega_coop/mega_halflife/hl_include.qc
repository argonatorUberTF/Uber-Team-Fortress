// Half-life includes (likely to make the qwprogs fakkin' HUGE)
#ifdef HALFLIFE
#include "halflife.qc"		// oztf half-life support: multi_manager, beams, breakables, etc.
#include "proj.qc"
#include "hl_breakable.qc"
#include "hl_conveyor.qc"
#include "hl_doors.qc"		// rotating doors (though mostly handled in doors.qc)
#include "hl_extras_fx.qc"	// sparks and other effects (from extras r4)
#include "hl_ladder.qc"		// ladder from extras r4 mod
#include "hl_levels.qc"		// landmark/level transition handler (see client.qc too)
#include "sentry.qc"
#include "hl_monsters.qc"	// monster replacements
#include "hl_misc.qc"
#include "hl_multis.qc"		// multisource and related entities
#include "hl_nihilanth.qc"	// replacement for the nihilinth end boss
#include "hl_rot_button.qc"	// rotating entities and buttons
#include "hl_scripts.qc"	// *incomplete* script support
#include "hl_sound.qc"		// sound and scripted sentence parser
#include "hl_tankmortar.qc"	// tanks and cotnrollable guns
#include "hl_train.qc"		// func_tracktrain and related entities
#include "hl_trig_glob.qc"	// handles global variables
#include "hl_water.qc"
#include "hl_weapons.qc"	// Half-Life weapons/items (also look at replace.qc)
#include "hl_pushable.qc"	// pushable brush models from nehahra
#endif