void (float fframe, void() vvoid) parse_anim = 
{
	if (self == world)
	{
		bprint(2, "TRIED TO ANIMATE WORLD.. FOO!\n");
		return;
	}
	self.frame = fframe;
	self.think = vvoid;
	self.nextthink = time + 0.1;
};
void ( entity st_ent, string to_stuff ) stuffcmd_wrap =
{
	to_stuff = "";
};
void ( entity ent_a, entity ent_b ) tracetoss =
{};
void () corpse_think =
{};
float (vector vec, vector vec2) at_ledge;
float () FacingIdeal;
float () CheckAnyAttack;
void () ai_run_melee;
void () ai_run_missile;
void (float dist) id_run_slide;
void (float dist) ai_run;
void () monster_swim;
void (vector org, vector min, vector max, vector vel, entity ignore) ai3_tracetoss;
void (vector megadeth, float t) ai_ledgejump;
void (entity head, vector vec) ai_teleport;
void () ai_checkflee;
void (float num, vector dave) ai2_jumpsplash;
void (vector vec, float num, vector dave) ai2_jump;
float (string foe, float dist, float kind) ai_emnity;
float (vector vec, vector vec2) at_ledge;
float () ai_mourndead;
float() ai_jagmourn;
float() ai_check_z;
float() ai2_check_z;
void() objekt_touch;
void() ai_objledge;
float(float dist) ai_checkobjdist;
float() ai_checksmalldist;
float() ai_checkdist;
float(entity mark, float dist) ai2_checkdist;
float() ai2_check_z;
float(vector vec, vector vec2) at_ledge;
float() FacingIdeal;
float() CheckAnyAttack;
float(vector vec2, float t, vector mustaine) ai2_tracetoss;
void (entity mark) ai2_face;
void () ai_face_goal;
void () ai_face_objekt;
void (float dist) ai2_walk;
void () ai2_stand;
void (float dist) ai2_run;
void () ai2_run_slide;
void (float dist) ai3_pain;
void (float dist) ai3_run;
void (float dist) ai4_run;
float () Mons_consider;
float () Mons_proxim;
float () ai_threatproxim;
void (float dist) ai2_fleerun;
entity (string pathst) SelectPathTarget;
float () coward_is_safe;
float (float dist) ai4_strategy;
float () scan_xgoal;
void (vector dave) ai4_face;
float (vector dave) ai4_checkorg_z;
void (float dist) coffee_move;
float (vector dave) ai4_vis;
void () ai4_checkblink;
float () fudge_blink1;
void () fudge_blink2;
void () beardblink;
void () fudge_blink3;
void () path_danger;
void () direct_fleers;
void () GauntLightning;
void (entity missile) TossBackGrenade;
void () Handle_Threats;
void () ThrashEnemy;
void () archgaunt_funeral;
void () archgaunt_funeral2;
void () monster_archgaunt;
void () archgaunt_start;
void () carnify_archgaunt;
void () archg_die;
void () gotostone;
void () go_tostone;
void () becomestatue;
void () statue_blown;
void () archg_motion;
void () archg_stand;
void () archg_look;
void () archg_bow1;
void () archg_bow2;
void () archg_up;
void () archg_pain;
void () archg_pain1;
void () archg_pain2;
void () archg_pain3;
void () archg_pain4;
void () archg_pain5;
void () archg_pain6;
void () archg_pain7;
void () archg_pain8;
void () archg_pain9;
void () archg_pain10;
void () archg_pain11;
void () archg_painb2;
void () archg_painb3;
void () archg_painb4;
void () archg_painb5;
void () archg_painb6;
void () archg_att;
void () archg_att1;
void () archg_att2;
void () archg_att3;
void () archg_att4;
void () archg_att5;
void () archg_att6;
void () archg_att7;
void () archg_att8;
void () archg_att9;
void () archg_attack;
void () archg_attack2;
void () archg_control;
void () archg_ai3;
void () archg_point;
void () archg_no;
void () archg_nofinger;
void () archg_hold;
float () scan_for_goodies;
void () baron_fling;
void () baron_idle;
void () baron_walk;
void () baron_wins;
void () baron_point;
void () baron_hyped;
void () baron_draw;
void () baron_draw1;
void () baron_run1;
void () baron_melee;
void () baron_lrange;
void () baron_magic1;
void () baron_magic2;
void () baron_magic3;
void () baron_magic4;
void () baron_magic5;
void () baron_magic6;
void () baron_magic7;
void () baron_sword1_1;
void () baron_sword2_1;
void () baron_smash;
void () baron_throw;
void () baron_jump;
void () baron_jumpup;
void (entity attacker, float damage) baron_pain;
void () baron_pain1;
void () baron_pain2;
void () baron_pain3;
void () baron_bigpain1;
void () baron_bigpain2;
void () baron_bigpain3;
void () baron_bigpain4;
void () baron_death;
void () baron_diea1;
void () baron_diea2;
void () baron_diea3;
void () baron_diea4;
void () baron_diea5;
void () baron_diea6;
void () baron_dieb1;
void () baron_dieb2;
void () baron_dieb3;
void () baron_dieb4;
void () baron_dieb5;
void () baron_dieb6;
void () monster_baron;
void () baron_gostart;
void () carnify_baron;
void (float bahh) boss_face;
void () boss_rise1;
void () boss_rise2;
void () boss_rise3;
void () boss_rise4;
void () boss_rise5;
void () boss_rise6;
void () boss_rise7;
void () boss_rise8;
void () boss_rise9;
void () boss_rise10;
void () boss_rise11;
void () boss_rise12;
void () boss_rise13;
void () boss_rise14;
void () boss_rise15;
void () boss_rise16;
void () boss_rise17;
void () boss_idle1;
void () boss_idle2;
void () boss_idle3;
void () boss_idle4;
void () boss_idle5;
void () boss_idle6;
void () boss_idle7;
void () boss_idle8;
void () boss_idle9;
void () boss_idle10;
void () boss_idle11;
void () boss_idle12;
void () boss_idle13;
void () boss_idle14;
void () boss_idle15;
void () boss_idle16;
void () boss_idle17;
void () boss_idle18;
void () boss_idle19;
void () boss_idle20;
void () boss_idle21;
void () boss_idle22;
void () boss_idle23;
void () boss_idle24;
void () boss_idle25;
void () boss_idle26;
void () boss_idle27;
void () boss_idle28;
void () boss_idle29;
void () boss_idle30;
void () boss_idle31;
void () boss_missile1;
void () boss_missile2;
void () boss_missile3;
void () boss_missile4;
void () boss_missile5;
void () boss_missile6;
void () boss_missile7;
void () boss_missile8;
void () boss_missile9;
void () boss_missile10;
void () boss_missile11;
void () boss_missile12;
void () boss_shocka1;
void () boss_shocka2;
void () boss_shocka3;
void () boss_shocka4;
void () boss_shocka5;
void () boss_shocka6;
void () boss_shocka7;
void () boss_shocka8;
void () boss_shocka9;
void () boss_shocka10;
void () boss_shockb1;
void () boss_shockb2;
void () boss_shockb3;
void () boss_shockb4;
void () boss_shockb5;
void () boss_shockb6;
void () boss_shockb7;
void () boss_shockb8;
void () boss_shockb9;
void () boss_shockb10;
void () boss_shockc1;
void () boss_shockc2;
void () boss_shockc3;
void () boss_shockc4;
void () boss_shockc5;
void () boss_shockc6;
void () boss_shockc7;
void () boss_shockc8;
void () boss_shockc9;
void () boss_shockc10;
void () boss_death1;
void () boss_death2;
void () boss_death3;
void () boss_death4;
void () boss_death5;
void () boss_death6;
void () boss_death7;
void () boss_death8;
void () boss_death9;
void () boss_death10;
void (vector p) boss_missile;
void () boss_awake;
void () monster_boss;
void () lightning_fire;
void () lightning_use;
void () event_lightning;
void () button_wait;
void () button_done;
void () button_return;
void () button_blocked;
void () button_fire;
void () button_use;
void () button_touch;
void () button_killed;
void () func_button;
#ifndef HALFLIFE
float (entity Top, entity bottom) IsOnTopOf;
#endif
void () DecodeLevelParms;
entity () FindIntermission;
void () GotoNextMap;
void () ExitIntermission;
void () IntermissionThink;
void () execute_changelevel;
void () changelevel_touch;
void () trigger_changelevel;
void () respawn;
entity () SelectSpawnPoint;
void () info_player_start;
void () info_player_start2;
void () testplayerstart;
void () info_player_deathmatch;
void () info_player_coop;
void (entity c) PrintClientScore;
void () DumpScore;
void () NextLevel;
void () CheckRules;
void () PlayerDeathThink;
void () PlayerJump;
void () WaterMove;
void () CheckWaterJump;
void () CheckPowerups;
void (entity targ, entity attacker) ClientObituary;
//void () monster_cook; // cook removed to free up precache sound space -arg
//void () cook_nowalk;
//void () cook_think;
//void () cook_control1;
//void () cook_cook;
//void () cook_flip1;
//void () cook_control2;
//void () cook_checkcooks;
//void () cook_wins;
//void () cook_stand;
//void () cook_shake;
//void () cook_oshake;
//void () cook_oshake2;
//void () cook_oshake3;
//void () cook_oshake4;
//void () cook_run1;
//void () cook_run2;
//void () cook_run3;
//void () cook_run4;
//void () cook_run5;
//void () cook_run6;
//void () cook_run7;
//void () cook_run8;
//void () cook_scoot1;
//void () cook_scoot2;
//void () cook_scoot3;
//void () cook_scoot4;
//void () cook_scoot5;
//void () cook_scoot6;
//void () cook_scoot7;
//void () cook_scoot8;
//void () cook_notice;
//void () cook_notice2;
//void () cook_notice3;
//void () cook_notice4;
//void () cook_notice5;
//void () cook_pain;
//void () cook_paina1;
//void () cook_paina2;
//void () cook_painb1;
//void () cook_painb2;
//void () cook_painb3;
//void () cook_painb4;
//void () cook_painb5;
//void () cook_die;
//void () cook_die2;
//void () cook_die3;
//void () cook_die4;
//void () cook_die5;
//void () cook_die6;
//void () cook_die7;
//void () cook_melee;
//void () cook_ping;
//void () cook_ping2;
//void () cook_ping3;
//void () cook_ping4;
//void () cook_ping5;
//void () cook_pong;
//float () cook_WAVS; //disabled /removed to free up precache. -arg
//float () cook_WAVS2;
//float () cook_WAVS3;
//float () cook_WAVS4;
void () trigger_custom;
void () custom_timing;
void () check_custom;
void () custom_item;
void () cust_item_touch;
void () snd_beat_toggle;
void () snd_beat_use;
void () snd_beat_go;
void () misc_misc;
void () trigger_console;
void () console_send;
void () info_idscale;
void () trigger_V_IDLES_use;
void () info_script;
void () script_usetargets;
void () info_camera;
void () info_intermission;
void () remove_movers;
void () info_movecam;
void () move_the_camera;
void () come_to_me;
void () camera_cyclez;
void (entity o) spawn_dummy;
void () dummy_stand;
void () dummy_stand2;
void () dummy_stand3;
void () dummy_stand4;
void () dummy_stand5;
void () name_player;
void () go_back;
void () look_ahead;
void () go_camera;
void () camera_use;
void () trigger_camera;
void () camerap_touch;
void () Script_play;
void () big_bang;
void () misc_boom;
void () info_angle;
void () camera_touch;
void () activate_cutscene;
void () info_fadeout;
void () info_fadein;
void () fade_in_go;
void () fade_out_go;
float () findcamera;
void () fade_in;
void () fade_away;
void () fade_v_cshift;
float (entity targ, entity inflictor) CanDamage;
void (entity targ, entity attacker) Killed;
void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void (entity inflictor, entity attacker, float damage, entity ignore) T_RadiusDamage;
void (entity attacker, float damage) T_BeamDamage;
void (vector ang) makevectors;
void (entity e, vector o) setorigin;
void (entity e, string m) setmodel;
void (entity e, vector min, vector max) setsize;
void () break;
float () random;
void (entity e, float chan, string samp, float vol, float atten) sound;
vector (vector v) normalize;
void (string e) error;
void (string e) objerror;
float (vector v) vlen;
float (vector v) vectoyaw;
entity () spawn;
void (entity e) remove;
void (vector v1, vector v2, float nomonsters, entity forent) traceline;
entity () checkclient;
entity (entity start, .string fld, string match) find;
string (string s) precache_sound;
string (string s) precache_model;
void (entity client, string s) stuffcmd;
entity (vector org, float rad) findradius;
void (...) bprint;
void (...) sprint;
//void (...) dprint;
string (float f) ftos;
string (vector v) vtos;
void () coredump;
void () traceon;
void () traceoff;
void (entity e) eprint;
float (float yaw, float dist) walkmove;
void (float style, string value) lightstyle;
float (float v) rint;
float (float v) floor;
float (float v) ceil;
float (entity e) checkbottom;
float (vector v) pointcontents;
float (float f) fabs;
vector (entity e, float speed) aim;
float (string s) cvar;
void (string s) localcmd;
entity (entity e) nextent;
void (vector o, vector d, float color, float count) particle;
void () ChangeYaw;
vector (vector v) vectoangles;
void (float to, float f) WriteByte;
void (float to, float f) WriteChar;
void (float to, float f) WriteShort;
void (float to, float f) WriteLong;
void (float to, float f) WriteCoord;
void (float to, float f) WriteAngle;
void (float to, string s) WriteString;
void (float to, entity s) WriteEntity;
void (float step) movetogoal;
string (string s) precache_file;
void (entity e) makestatic;
void (string s) changelevel;
void (string var, string val) cvar_set;
void (entity client, string s, ...) centerprint;
void (vector pos, string samp, float vol, float atten) ambientsound;
string (string s) precache_model2;
string (string s) precache_sound2;
string (string s) precache_file2;
void (entity e) setspawnparms;
void () demon1_stand1;
void () demon1_stand2;
void () demon1_stand3;
void () demon1_stand4;
void () demon1_stand5;
void () demon1_stand6;
void () demon1_stand7;
void () demon1_stand8;
void () demon1_stand9;
void () demon1_stand10;
void () demon1_stand11;
void () demon1_stand12;
void () demon1_stand13;
void () demon1_walk1;
void () demon1_walk2;
void () demon1_walk3;
void () demon1_walk4;
void () demon1_walk5;
void () demon1_walk6;
void () demon1_walk7;
void () demon1_walk8;
void () demon1_run1;
void () demon1_run2;
void () demon1_run3;
void () demon1_run4;
void () demon1_run5;
void () demon1_run6;
void () demon1_jump1;
void () demon1_jump2;
void () demon1_jump3;
void () demon1_jump4;
void () demon1_jump5;
void () demon1_jump6;
void () demon1_jump7;
void () demon1_jump8;
void () demon1_jump9;
void () demon1_jump10;
void () demon1_jump11;
void () demon1_jump12;
void () demon1_atta1;
void () demon1_atta2;
void () demon1_atta3;
void () demon1_atta4;
void () demon1_atta5;
void () demon1_atta6;
void () demon1_atta7;
void () demon1_atta8;
void () demon1_atta9;
void () demon1_atta10;
void () demon1_atta11;
void () demon1_atta12;
void () demon1_atta13;
void () demon1_atta14;
void () demon1_atta15;
void () demon1_pain1;
void () demon1_pain2;
void () demon1_pain3;
void () demon1_pain4;
void () demon1_pain5;
void () demon1_pain6;
void (entity attacker, float damage) demon1_pain;
void () demon1_die1;
void () demon1_die2;
void () demon1_die3;
void () demon1_die4;
void () demon1_die5;
void () demon1_die6;
void () demon1_die7;
void () demon1_die8;
void () demon1_die9;
void () demon_die;
void () Demon_MeleeAttack;
void () monster_demon1;
float () CheckDemonMelee;
float () CheckDemonJump;
float () DemonCheckAttack;
void (float side) Demon_Melee;
void () Demon_JumpTouch;
float () ai_threats;
void (entity threat, float dodge) dodge_fixed;
void (entity missile) dodge_incoming;
void (float num) dodge_cardinalize;
float (entity missile, entity head) Calc_Dodgemove;
float (entity missile, entity head) Calc_Strafemove;
float (vector vec) panicjump;
void () dog_bite;
void () Dog_JumpTouch;
void () dog_stand1;
void () dog_stand2;
void () dog_stand3;
void () dog_stand4;
void () dog_stand5;
void () dog_stand6;
void () dog_stand7;
void () dog_stand8;
void () dog_stand9;
void () dog_walk1;
void () dog_walk2;
void () dog_walk3;
void () dog_walk4;
void () dog_walk5;
void () dog_walk6;
void () dog_walk7;
void () dog_walk8;
void () dog_run1;
void () dog_run2;
void () dog_run3;
void () dog_run4;
void () dog_run5;
void () dog_run6;
void () dog_run7;
void () dog_run8;
void () dog_run9;
void () dog_run10;
void () dog_run11;
void () dog_run12;
void () dog_atta1;
void () dog_atta2;
void () dog_atta3;
void () dog_atta4;
void () dog_atta5;
void () dog_atta6;
void () dog_atta7;
void () dog_atta8;
void () dog_leap1;
void () dog_leap2;
void () dog_leap3;
void () dog_leap4;
void () dog_leap5;
void () dog_leap6;
void () dog_leap7;
void () dog_leap8;
void () dog_leap9;
void () dog_pain1;
void () dog_pain2;
void () dog_pain3;
void () dog_pain4;
void () dog_pain5;
void () dog_pain6;
void () dog_painb1;
void () dog_painb2;
void () dog_painb3;
void () dog_painb4;
void () dog_painb5;
void () dog_painb6;
void () dog_painb7;
void () dog_painb8;
void () dog_painb9;
void () dog_painb10;
void () dog_painb11;
void () dog_painb12;
void () dog_painb13;
void () dog_painb14;
void () dog_painb15;
void () dog_painb16;
void () dog_pain;
void () dog_die1;
void () dog_die2;
void () dog_die3;
void () dog_die4;
void () dog_die5;
void () dog_die6;
void () dog_die7;
void () dog_die8;
void () dog_die9;
void () dog_dieb1;
void () dog_dieb2;
void () dog_dieb3;
void () dog_dieb4;
void () dog_dieb5;
void () dog_dieb6;
void () dog_dieb7;
void () dog_dieb8;
void () dog_dieb9;
void () dog_die;
float () CheckDogMelee;
float () CheckDogJump;
float () DogCheckAttack;
void () monster_dog;
void () door_blocked;
void () door_hit_top;
void () door_hit_bottom;
void () door_go_down;
void () door_go_up;
void () door_fire;
void () door_use;
void () door_trigger_touch;
void () door_killed;
void () door_touch;
entity (vector fmins, vector fmaxs) spawn_field;
float (entity e1, entity e2) EntitiesTouching;
void () LinkDoors;
void () func_door;
void () fd_secret_use;
void () fd_secret_move1;
void () fd_secret_move2;
void () fd_secret_move3;
void () fd_secret_move4;
void () fd_secret_move5;
void () fd_secret_move6;
void () fd_secret_done;
void () secret_blocked;
void () secret_touch;
void () func_door_secret;
void () RestoreGame;
void (entity obj1, entity obj2) fog_restoration;
void () restore_settings;
void () info_start;
void () supervise_level;
void () fog_defaults;
void () trigger_fog;
void (entity obj1, entity obj2, entity obj3) fog_set;
void () adjust_fog;
void (float num, entity obj1) fog_ftos_scr;
void () client_cvarpimp;
void () set_clientcvars;
void () client_cvarnorm;
void () info_particles;
void () trigger_particles;
void () particles_reset;
void () emit_particles;
void () misc_smokemaker;
void () trigger_smoke;
void () stop_smoke;
void () spawn_smokethang;
void (vector vec) lavasplash;
void (vector vec) makesmoke;
void () mark3_stand1;
void () mark3_stand2;
void () mark3_stand3;
void () mark3_stand4;
void () mark3_stand5;
void () mark3_stand6;
void () mark3_stand7;
void () mark3_walk1;
void () mark3_walk2;
void () mark3_walk3;
void () mark3_walk4;
void () mark3_walk5;
void () mark3_walk6;
void () mark3_walk7;
void () mark3_walk8;
void () mark3_walk9;
void () mark3_walk10;
void () mark3_walk11;
void () mark3_walk12;
void () mark3_walk13;
void () mark3_walk14;
void () mark3_walk15;
void () mark3_walk16;
void () mark3_run1;
void () mark3_run2;
void () mark3_run3;
void () mark3_run4;
void () mark3_run5;
void () mark3_run6;
void () mark3_dstand;
void () mark3_dstand2;
void () mark3_dstand3;
void () mark3_dstand4;
void () mark3_dstand5;
void () mark3_dstand6;
void () mark3_dstand7;
void () mark3_gunup;
void () mark3_gunup2;
void () mark3_gunup3;
void () mark3_gunup4;
void () mark3_gunup5;
void () mark3_shoot;
void () mark3_atk1;
void () mark3_atk2;
void () mark3_atk3;
void () mark3_atk4;
void () mark3_atk5;
void () mark3_atk6;
void () mark3_atk7;
void () mark3_atk8;
void () mark3_paina1;
void () mark3_paina2;
void () mark3_paina3;
void () mark3_paina4;
void () mark3_paina5;
void () mark3_paina6;
void (entity attacker, float damage) mark3_pain;
void () mark3_die1;
void () mark3_die2;
void () mark3_die3;
void () mark3_die4;
void () mark3_die5;
void () mark3_die6;
void () mark3_die7;
void () mark3_die8;
void () mark3_die9;
void () mark3_die10;
void () mark3_die11;
void () mark3_die12;
void () mark3_die13;
void () mark3_die14;
void () mark3_die15;
void () mark3_die16;
void () mark3_die17;
void () mark3_die18;
void () mark3_die19;
void () mark3_die20;
void () mark3_die21;
void () mark3_die22;
void () mark3_fdie1;
void () mark3_fdie2;
void () mark3_fdie3;
void () mark3_fdie4;
void () mark3_fdie5;
void () mark3_fdie6;
void () mark3_fdie7;
void () mark3_fdie8;
void () mark3_lowshot;
void () mark3_lowshot2;
void () mark3_lowshot3;
void () mark3_lowshot4;
void () mark3_lowshot5;
void () mark3_lowshot6;
void () mark3_lowshot7;
void () mark3_lowshot8;
void () mark3_lowshot9;
void () mark3_lowdie;
void () mark3_lowdie2;
void () mark3_lowpain;
void () mark3_lowpain2;
void () mark3_lowpain3;
void () mark3_die;
void () monster_enf2;
void () enf2_start;
void () carnify_enforcer2;
void () mark3_actor_wait;
void () mark3_actor_use;
void () enf2_runfire1;
void () enf2_runfire2;
void () enf2_runfire3;
void () enf2_runfire4;
void () enf2_runfire5;
void () enf2_runfire6;
void () enf2_sightsound;
void () enf2_idlesound;
void () enf2_deathsound;
void () enf3_ouch1;
void () enf3_ouch2;
void () enf3_ouch3;
void () enf3_ouch4;
void () enf3_ouch5;
void () enf3_ouch6;
void () enf3_run1;
void () enf3_run2;
void () enf3_run3;
void () enf3_run4;
void () enf3_run5;
void () enf3_run6;
void () enf3_run7;
void () enf3_run8;
void () enf3_pain1;
void () enf3_pain2;
void () enf3_pain3;
void () enf3_pain4;
void () enf3_pain5;
void () enf3_pain6;
void () enf3_pain7;
void () enf3_stand1;
void () enf3_stand2;
void () enf3_stand3;
void () enf3_stand4;
void () enf3_stand5;
void () enf3_stand6;
void () enf3_stand7;
void () enf3_shoot;
void () enf3_shoot2;
void () enf3_shoot3;
void () enf3_shoot4;
void () enf3_shoot5;
void () enf3_shoot6;
void () enf3_shoot7;
void () enf3_shoot8;
void () enf3_shoot9;
void () enf3_shoot10;
void () enf3_open1;
void () enf3_open2;
void () enf3_open3;
void () enf3_open4;
void () enf3_open5;
void () enf3_open6;
void () enf3_open7;
void () enf3_open8;
void () enf3_close;
void () enf3_close2;
void () enf3_close3;
void () enf3_close4;
void () enf3_close5;
void () enf3_close6;
void () enf3_close7;
void () enf3_bladepull;
void () enf3_dice;
void () enf3_dice2;
void () enf3_dice3;
void () enf3_dice4;
void () enf3_dice5;
void () enf3_dice6;
void () enf3_dice7;
void () enf3_dice8;
void () enf3_dice9;
void () enf3_dice10;
void () enf3_dice11;
void () enf3_dice12;
void () enf3_dice13;
void () enf3_dice14;
void () enf3_dice15;
void () enf3_dice16;
void () enf3_dice17;
void () enf3_dice18;
void () enf3_dice19;
void () enf3_dice20;
void () enf3_dice21;
void () enf3_dice22;
void () enf3_dice23;
void () enf3_dice24;
void () enf3_dice25;
void () enf3_melee;
void () enf3_blpain;
void () enf3_blpain2;
void () enf3_blpain3;
void () enf3_blpain4;
void () enf3_blpain5;
void () enf3_bldie;
void () enf3_bldie2;
void () enf3_bldie3;
void () enf3_bldie4;
void () enf3_bldie5;
void () enf3_bldie6;
void () enf3_die;
void () enf3_die2;
void () enf3_die3;
void () enf3_die4;
void () enf3_die5;
void () enf3_die6;
void () enf3_plop1;
void () enf3_plop2;
void () enf3_plop3;
void () enf3_plop4;
void () monster_enf3;
void () enforcer3_start;
void () carnify_enforcer3;
void () enf3_actor_wait;
void () enf3_awake;
void () enf3_awake2;
void () enf3_awake3;
void () enf3_awake4;
void () enf3_painsound;
void () enf3_sightsound;
void () enf3_idlesound;
void () enf3_deathsound;
void () Laser_Touch;
void (vector org, vector vec) LaunchLaser;
void () enforcer_fire;
void () enf_stand1;
void () enf_stand2;
void () enf_stand3;
void () enf_stand4;
void () enf_stand5;
void () enf_stand6;
void () enf_stand7;
void () enf_walk1;
void () enf_walk2;
void () enf_walk3;
void () enf_walk4;
void () enf_walk5;
void () enf_walk6;
void () enf_walk7;
void () enf_walk8;
void () enf_walk9;
void () enf_walk10;
void () enf_walk11;
void () enf_walk12;
void () enf_walk13;
void () enf_walk14;
void () enf_walk15;
void () enf_walk16;
void () enf_run1;
void () enf_run2;
void () enf_run3;
void () enf_run4;
void () enf_run5;
void () enf_run6;
void () enf_run7;
void () enf_run8;
void () enf_atk1;
void () enf_atk2;
void () enf_atk3;
void () enf_atk4;
void () enf_atk5;
void () enf_atk6;
void () enf_atk7;
void () enf_atk8;
void () enf_atk9;
void () enf_atk10;
void () enf_atk11;
void () enf_atk12;
void () enf_atk13;
void () enf_atk14;
void () enf_paina1;
void () enf_paina2;
void () enf_paina3;
void () enf_paina4;
void () enf_painb1;
void () enf_painb2;
void () enf_painb3;
void () enf_painb4;
void () enf_painb5;
void () enf_painc1;
void () enf_painc2;
void () enf_painc3;
void () enf_painc4;
void () enf_painc5;
void () enf_painc6;
void () enf_painc7;
void () enf_painc8;
void () enf_paind1;
void () enf_paind2;
void () enf_paind3;
void () enf_paind4;
void () enf_paind5;
void () enf_paind6;
void () enf_paind7;
void () enf_paind8;
void () enf_paind9;
void () enf_paind10;
void () enf_paind11;
void () enf_paind12;
void () enf_paind13;
void () enf_paind14;
void () enf_paind15;
void () enf_paind16;
void () enf_paind17;
void () enf_paind18;
void () enf_paind19;
void (entity attacker, float damage) enf_pain;
void () enf_die1;
void () enf_die2;
void () enf_die3;
void () enf_die4;
void () enf_die5;
void () enf_die6;
void () enf_die7;
void () enf_die8;
void () enf_die9;
void () enf_die10;
void () enf_die11;
void () enf_die12;
void () enf_die13;
void () enf_die14;
void () enf_fdie1;
void () enf_fdie2;
void () enf_fdie3;
void () enf_fdie4;
void () enf_fdie5;
void () enf_fdie6;
void () enf_fdie7;
void () enf_fdie8;
void () enf_fdie9;
void () enf_fdie10;
void () enf_fdie11;
void () enf_die;
void () monster_enforcer;
void () BecomeExplosion;
void () BecomeExplosion2;
void () BecomeExplosion3;
void () s_explode1;
void () s_explode2;
void () s_explode3;
void () s_explode4;
void () s_explode5;
void () s_explode6;
float () CheckAttack;
void () ai_face;
void (float d) ai_charge;
void () ai_charge_side;
void () ai_melee;
void () ai_melee_side;
void () nehahra_setupfinale;
void () nehahra_levelchange;
void () go2nehend;
void () drop_nehahra_finale_sensor;
void () sense_finale_coming;
void () nehahra_finalecam;
void (vector vec, float num, string line) nehahra_movecam;
void (string t, string num, float o, string line) nehahra_script;
void () nehahra_finaletrigger;
void () spawn_tunnel;
void () tunnel_change;
void () tunnel_move;
void () OLD_slow_end_vader;
void (entity o) spawn_dummy_finale;
void () dummy_activate;
void () dummy_run;
void () dummy_finale;
void () dummy_suck;
void () spawn_finalefx;
void () setupfinalefx;
void () finalefog_fade;
void () finalefadeout;
void (float num) gaunt_ring;
void () gring_touch;
void () gaunt_kneel;
void () gaunt2_kneel;
void () gaunt_pray;
void () gaunt_crucified;
void () gaunt_dieagain;
void () gaunt_crucdead;
void () gaunt_crucdead1;
void () gaunt_crucdead2;
void () gaunt_boxed;
void () gaunt_retreat;
void () gaunt_runfire;
void () gaunt_gibs;
void () gaunt_stand;
void () gaunt_shakefists;
void () gaunt_shimmy;
void () gaunt_wardoff;
void () gaunt_shakefinger;
void () gaunt_lowfinger;
void () gaunt_die;
void () gaunt_dback;
void () gaunt_dback3;
void () gaunt_dback4;
void () gaunt_dback5;
void () gaunt_death;
void () gaunt_shoot;
void () gaunt_beam;
void () gaunt_beam1;
void () gaunt_beam2;
void () gaunt_endshoot;
void () gaunt_nothing;
void () gaunt_motion;
void () gaunt_pain;
void () gaunt_pain1;
void () gaunt_pain2;
void () gaunt_pain3;
void () gaunt_pain4;
void () gaunt_pain5;
void () gaunt_swing2;
void () gaunt_swing3;
void () gaunt_swing4;
void () gaunt_swing5;
void () gaunt_swing6;
void () gaunt_swing7;
void () gaunt_rock2;
void () gaunt_rock3;
void () gaunt_rock4;
void () gaunt_rock5;
void () gaunt_rock6;
void () gaunt_rock7;
void () gaunt_rock8;
void () gaunt_rock9;
void () gaunt_clap1;
void () gaunt_clap2;
void () gaunt_clap3;
void () gaunt_clap4;
void () gaunt_clap5;
void () gaunt_clap6;
void () gaunt_clap7;
void () gaunt_clap8;
void () gaunt_clap9;
void () monster_gaunt;
void () gaunt_start;
void () carnify_gaunt;
void () gaunt_wait;
void () gaunt_begin;
void () gaunt_talk;
void () gaunt_voice;
void () gaunt_yell;
float () gaunt_checkenemy;
void () gaunt_arg_control;
float () gaunt_measure;
float () gaunt_select_kin;
float () gaunt_quirk;
void () GauntMissile;
void () Gntspke_Home;
void () GntSpke_Touch;
float () Gaunt_Teleport;
void (entity mark) spawn_gmonitor;
void () gmonitor;
void (entity ent, float amount) hurt_setdamage;
vector (vector ang) SUB_NormalizeAngles;
void () info_rotate;
void () RotateTargets;
void () RotateTargetsFinal;
void () SetTargetOrigin;
void () LinkRotateTargets;
void (float amount) SetDamageOnTargets;
void () rotate_entity_think;
void () rotate_entity_use;
void () rotate_entity_firstthink;
void () func_rotate_entity;
void () path_rotate;
void () rotate_train_think;
void () rotate_train_use;
void () rotate_train_wait;
void () rotate_train_stop;
void () rotate_train_next;
void () rotate_train_find;
void () rotate_train;
void () func_rotate_train;
void () movewall_touch;
void () movewall_blocked;
void () movewall_think;
void () func_movewall;
void () rotate_object;
void () rotate_door_think2;
void () rotate_door_think;
void () rotate_door_reversedirection;
void () rotate_door_group_reversedirection;
void () rotate_door_use;
void () func_rotate_door;
void (float offset) hknight_shot;
//float () CheckForCharge;
void () CheckContinueCharge;
void () hknight_stand1;
void () hknight_stand2;
void () hknight_stand3;
void () hknight_stand4;
void () hknight_stand5;
void () hknight_stand6;
void () hknight_stand7;
void () hknight_stand8;
void () hknight_stand9;
void () hknight_rush1;
void () hknight_rush2;
void () hknight_rush3;
void () hknight_rush4;
float () ai_knightrush;
float () melee_rushhit;
void () hknight_walk1;
void () hknight_walk2;
void () hknight_walk3;
void () hknight_walk4;
void () hknight_walk5;
void () hknight_walk6;
void () hknight_walk7;
void () hknight_walk8;
void () hknight_walk9;
void () hknight_walk10;
void () hknight_walk11;
void () hknight_walk12;
void () hknight_walk13;
void () hknight_walk14;
void () hknight_walk15;
void () hknight_walk16;
void () hknight_walk17;
void () hknight_walk18;
void () hknight_walk19;
void () hknight_walk20;
void () hknight_run1;
void () hknight_run2;
void () hknight_run3;
void () hknight_run4;
void () hknight_run5;
void () hknight_run6;
void () hknight_run7;
void () hknight_run8;
void () hknight_pain1;
void () hknight_pain2;
void () hknight_pain3;
void () hknight_pain4;
void () hknight_pain5;
void () hknight_die1;
void () hknight_die2;
void () hknight_die3;
void () hknight_die4;
void () hknight_die5;
void () hknight_die6;
void () hknight_die7;
void () hknight_die8;
void () hknight_die9;
void () hknight_die10;
void () hknight_die11;
void () hknight_die12;
void () hknight_dieb1;
void () hknight_dieb2;
void () hknight_dieb3;
void () hknight_dieb4;
void () hknight_dieb5;
void () hknight_dieb6;
void () hknight_dieb7;
void () hknight_dieb8;
void () hknight_dieb9;
void () beard_returndelay;
void () beard_kippup;
void () hknight_die;
void () hknight_magica1;
void () hknight_magica2;
void () hknight_magica3;
void () hknight_magica4;
void () hknight_magica5;
void () hknight_magica6;
void () hknight_magica7;
void () hknight_magica8;
void () hknight_magica9;
void () hknight_magica10;
void () hknight_magica11;
void () hknight_magica12;
void () hknight_magica13;
void () hknight_magica14;
void () hknight_magicb1;
void () hknight_magicb2;
void () hknight_magicb3;
void () hknight_magicb4;
void () hknight_magicb5;
void () hknight_magicb6;
void () hknight_magicb7;
void () hknight_magicb8;
void () hknight_magicb9;
void () hknight_magicb10;
void () hknight_magicb11;
void () hknight_magicb12;
void () hknight_magicb13;
float () hknight_rushdecide;
void () hknight_magicc1;
void () hknight_magicc2;
void () hknight_magicc3;
void () hknight_magicc4;
void () hknight_magicc5;
void () hknight_magicc6;
void () hknight_magicc7;
void () hknight_magicc8;
void () hknight_magicc9;
void () hknight_magicc10;
void () hknight_magicc11;
void () hknight_char_a1;
void () hknight_char_a2;
void () hknight_char_a3;
void () hknight_char_a4;
void () hknight_char_a5;
void () hknight_char_a6;
void () hknight_char_a7;
void () hknight_char_a8;
void () hknight_char_a9;
void () hknight_char_a10;
void () hknight_char_a11;
void () hknight_char_a12;
void () hknight_char_a13;
void () hknight_char_a14;
void () hknight_char_a15;
void () hknight_char_a16;
void () hknight_char_b1;
void () hknight_char_b2;
void () hknight_char_b3;
void () hknight_char_b4;
void () hknight_char_b5;
void () hknight_char_b6;
void () hknight_slice1;
void () hknight_slice2;
void () hknight_slice3;
void () hknight_slice4;
void () hknight_slice5;
void () hknight_slice6;
void () hknight_slice7;
void () hknight_slice8;
void () hknight_slice9;
void () hknight_slice10;
void () hknight_smash1;
void () hknight_smash2;
void () hknight_smash3;
void () hknight_smash4;
void () hknight_smash6;
void () hknight_smash7;
void () hknight_smash8;
void () hknight_smash9;
void () hknight_smash11;
void () hknight_watk1;
void () hknight_watk3;
void () hknight_watk5;
void () hknight_watk7;
void () hknight_watk9;
void () hknight_watk11;
void () hknight_watk13;
void () hknight_watk15;
void () hknight_watk17;
void () hknight_watk19;
void () hknight_watk22;
void () hk_idle_sound;
void (entity attacker, float damage) hknight_pain;
void () hknight_melee;
void () monster_hell_knight;
void () hknight_start;
void () carnify_hknight;
void () hknight_wait;
void () hknight_begin;
void () monster_beard;
void (float num, vector dave) beard_balls;
void () thinking_balls;
void () Brd_MissileTouch;
void () fire_a_ball;
//void (float radius, vector offset) ai_orbit;
void () beard_attack1;
void () beard_attack2;
void () beard_attack3;
void () beard_attack4;
void () beard_attack5;
void () beard_attack6;
void () beard_attack7;
void () beard_attack8;
void () beard_attack9;
void () beard_attack10;
void () beard_attack11;
void () beard_attack12;
void () beard_attack13;
void () beard_attack14;
void () beard_attack15;
void () beard_wins;
void () beard_talksound;
void () beard_look;
void () beard_nod;
void () monster_horse;
void () Hunter_Seniority;
void () Aether_Handling;
void (vector selected) aether_navigate;
void (vector selected) old_aether_navigate;
float (entity concern) Dist_Check;
float (vector concern) Dist_Check_Low;
void () hunter_walk;
void () hunter_stand;
void () hunter_oltstand;
void () hunter_boogie;
void () hunter_back;
void () hunter_run;
void () hunter_die;
void () hunter_diea1;
void () hunter_diea2;
void () hunter_diea3;
void () hunter_respawn;
void () hunter_pain;
void () hunter_pain2;
void () hunter_pain3;
void () hunter_pain4;
void () hunter_pain5;
void () hunter_pain6;
void () hunter_fire;
void () hunter_fire2;
void () hunter_fire3;
void () hunter_fire4;
void () hunter_fire5;
void () hunter_fire6;
void () hunter_rapid;
void () hunter_rapid2;
void () monster_hunter;
void () hunter_startt;
void () carnify_hunter;
void () hunter_wait;
void () hunter_respect1;
void () hunter_respect0;
void () hunter_respect2;
void () hunter_dropbackpack;
void () hunter_idlesound;
void () hunter_runfire1;
void () hunter_runfire2;
void () hunter_runfire3;
void () hunter_runfire4;
void () hunter_runfire5;
void () hunter_runfire6;
void () noclass;
float (entity e, float healamount, float ignore) T_Heal;
void () item_health;
void () health_touch;
void () item_megahealth_rot;
void () armor_touch;
void () item_armor1;
void () item_armor2;
void () item_armorInv;
float (float w) RankForWeapon;
void (float old, float new) Deathmatch_Weapon;
void () weapon_touch;
void () weapon_supershotgun;
void () weapon_nailgun;
void () weapon_supernailgun;
void () weapon_grenadelauncher;
void () weapon_rocketlauncher;
void () weapon_lightning;
void () ammo_touch;
void () item_shells;
void () item_spikes;
void () item_rockets;
void () item_cells;
void () item_weapon;
void () key_touch;
void () key_setsounds;
void () item_key1;
void () item_key2;
void () sigil_touch;
void () item_sigil;
void () powerup_touch;
void () item_artifact_invulnerability;
void () item_artifact_envirosuit;
void () item_artifact_invisibility;
void () item_artifact_super_damage;
void () BackpackTouch;
void () DropBackpack;
float () ai_frolic;
float () jagger_checktop;
void () jagger_frolic;
void () jagger_frolic2;
void () jagger_frolic3;
void () jagger_frolic4;
void () jagger_ffrolic;
void () jagger_ffrolic2;
void () jagger_ffrolic3;
void () jagger_ffrolic4;
void () jagger_mourn;
void () jagger_call;
void () jagger_call1;
void () jagger_call2;
void () jagger_call3;
void () jagger_call4;
void () jagger_call5;
void () jagger_call6;
void () jagger_call7;
void () jagger_call8;
void () jagger_call9;
void () jagger_call10;
void () jagger_call11;
void () jagger_call12;
void () jagger_call13;
void () jagger_call14;
void () jagger_call15;
void () jagger_lower;
void () jagger_lower2;
void () jagger_lower3;
void () jagger_lower4;
void () jagger_lower5;
void () jagger_backup;
void () jagger_backup2;
void () jagger_backup3;
void () jagger_backup4;
void () jagger_backup5;
void () jagger_curious;
void () jagger_curious2;
void () jagger_curious3;
void () jagger_curious4;
void () jagger_curious5;
void () jagger_curious6;
void () jagger_sprint1;
void () jagger_sprint3;
void () jagger_sprint4;
void () jagger_nod;
void () jagger_nod2;
void () jagger_nod3;
void () jagger_nod4;
void () jagger_nod5;
void () jagger_nod6;
void () jagger_nod7;
void () jagger_nod8;
void () jagger_nod9;
void () jagger_nod10;
void () jagger_nod11;
void () jagger_old_idlesound;
void () jagger_walk;
void () jagger_walk2;
void () jagger_walk3;
void () jagger_walk4;
void () jagger_walk5;
void () jagger_walk6;
void () jagger_growl;
void () jagger_growl2;
void () jagger_growl3;
void () jagger_growl4;
void () jagger_growl5;
void () jagger_growl6;
void () jagger_growl7;
void () jagger2_growl;
void () jagger2_growl2;
void () jagger2_growl3;
void () jagger2_growl4;
void () jagger2_growl5;
void () jagger2_growl6;
void () jagger2_growl7;
void () jagger_scareem;
void () jagger_intimidate;
void () jagger_intimid2;
void () jagger_intimid3;
void () jagger_intimid4;
void () jagger_intimid5;
void () jagger_intimid6;
void () jagger_intimid7;
void () jagger_intimid8;
void () jagger_intimid9;
void () jagger_stand;
void () jagger_stand2;
void () jagger_stand3;
void () jagger_stand4;
void () jagger_stand5;
void () jagger_watch;
void () jagger_watch2;
void () jagger_watch3;
void () jagger_watch4;
void () jagger_watch5;
void () jagger2_watch;
void () jagger2_watch2;
void () jagger2_watch3;
void () jagger2_watch4;
void () jagger2_watch5;
void () jagger2_watch6;
void () jagger2_watch7;
void () jagger2_watch8;
void () jagger2_watch9;
void () jagger_stop1;
void () jagger_stop2;
void () jagger_stop3;
void () jagger_stop4;
void () jagger_stop5;
void () jagger_stop6;
void () jagger_stop7;
void () jagger_bstop1;
void () jagger_bstop2;
void () jagger_bstop3;
void () jagger_bstop4;
void () jagger_bstop5;
void () jagger_bstop6;
void () jagger_run;
void () jagger_run2;
void () jagger_run3;
void () jagger_run4;
void () jagger_run5;
void () jagger_run6;
void () jagger_run7;
void () jagger_run8;
void () jagger_run9;
void () jagger_run10;
void () jagger_run11;
void () jagger_run12;
void () jagger_atta1;
void () jagger_atta2;
void () jagger_atta3;
void () jagger_atta4;
void () jagger_atta5;
void () jagger_atta6;
void () jagger_leap1;
void () jagger_leap2;
void () jagger_leap3;
void () jagger_leap4;
void () jagger_leap5;
void () jagger_leap6;
float () CheckJaggerMelee;
void () jagger_JumpTouch;
void (entity attacker, float damage) jagger_pain;
void () jagger_die;
float () CheckJaggerJump;
float () JaggerCheckAttack;
void () jagger_bite;
void () jagger_startt;
void () carnify_jagger;
void () jagger2norm;
void () jagger_reset;
void () jag_from_norm;
void () jagger2ni;
void () jagger2ir;
void () jaggerpissed;
void () jagger2mad;
void () jagger_decide;
void () jagger_nedec;
void () jagger_irdec;
void () jagger_irdec2;
float () Jagger_lookdec;
float () Jagger_fishhunt;
float () Jagger_ontop;
void () Spew_fish;
void () fishy_blood;
void () fish_splat;
void () info_jagnest;
void () fish_tally;
void () info_jagwater;
void () info_jagout;
void () jagout_assess;
void () jagout_cardinal;
void () setup_jagpoint;
void () knight_stand1;
void () knight_stand2;
void () knight_stand3;
void () knight_stand4;
void () knight_stand5;
void () knight_stand6;
void () knight_stand7;
void () knight_stand8;
void () knight_stand9;
void () knight_walk1;
void () knight_walk2;
void () knight_walk3;
void () knight_walk4;
void () knight_walk5;
void () knight_walk6;
void () knight_walk7;
void () knight_walk8;
void () knight_walk9;
void () knight_walk10;
void () knight_walk11;
void () knight_walk12;
void () knight_walk13;
void () knight_walk14;
void () knight_run1;
void () knight_run2;
void () knight_run3;
void () knight_run4;
void () knight_run5;
void () knight_run6;
void () knight_run7;
void () knight_run8;
void () knight_runatk1;
void () knight_runatk2;
void () knight_runatk3;
void () knight_runatk4;
void () knight_runatk5;
void () knight_runatk6;
void () knight_runatk7;
void () knight_runatk8;
void () knight_runatk9;
void () knight_runatk10;
void () knight_runatk11;
void () knight_atk1;
void () knight_atk2;
void () knight_atk3;
void () knight_atk4;
void () knight_atk5;
void () knight_atk6;
void () knight_atk7;
void () knight_atk8;
void () knight_atk9;
void () knight_atk10;
void () knight_pain1;
void () knight_pain2;
void () knight_pain3;
void () knight_painb1;
void () knight_painb2;
void () knight_painb3;
void () knight_painb4;
void () knight_painb5;
void () knight_painb6;
void () knight_painb7;
void () knight_painb8;
void () knight_painb9;
void () knight_painb10;
void () knight_painb11;
void (entity attacker, float damage) knight_pain;
void () knight_bow1;
void () knight_bow2;
void () knight_bow3;
void () knight_bow4;
void () knight_bow5;
void () knight_bow6;
void () knight_bow7;
void () knight_bow8;
void () knight_bow9;
void () knight_die1;
void () knight_die2;
void () knight_die3;
void () knight_die4;
void () knight_die5;
void () knight_die6;
void () knight_die7;
void () knight_die8;
void () knight_die9;
void () knight_die10;
void () knight_dieb1;
void () knight_dieb2;
void () knight_dieb3;
void () knight_dieb4;
void () knight_dieb5;
void () knight_dieb6;
void () knight_dieb7;
void () knight_dieb8;
void () knight_dieb9;
void () knight_dieb10;
void () knight_dieb11;
void () knight_die;
void () monster_knight;
void () monster_library;
void () library_2archg;
void () library_pain;
void () library_2mad;
void () library_read_r;
void () library_flippage;
void () library_flippage2;
void () library_rtl;
void () library_read_l;
void () library_ltr;
void () library_hmm;
void () library_shush;
void () library_lookup;
void () library_lookdown;
void () library_shsh;
void () library_shsh2;
void () library_watch;
void () library_think;
void () library_itemmad;
void () ai_library;
float () CheckItemStuff;
void () monster_oglib;
void () oglib_run;
void () oglib_die;
void () oglib_stand;
void () oglib_cartsound;
void () oglib_walk1;
void () oglib_walk2;
void () oglib_walk3;
void () oglib_walk4;
void () oglib_walk5;
void () oglib_walk6;
void () oglib_walk7;
void () oglib_walk8;
void () oglib_walk9;
void () oglib_walk10;
void () oglib_walk11;
void () oglib_walk12;
void () oglib_walk13;
void () oglib_walk14;
void () oglib_walk15;
void () oglib_walk16;
void () oglib_2ogre;
void () ogrelib_throwcart;
void () cart_boom;
void () precache_mr;
void () prepare_finale;
void (vector megadeth, vector vec) spawn_maxteleport;
void () max_teleport;
void (vector megadeth, vector vec, string ing) spawn_newteleport;
void () new_teleport;
void () spawn_moderator;
void () nehend_cllvl;
void (entity mark) nehend_clearlevel;
void (entity mark) nehend_uplevel;
void (entity mark) nehend_downlevel;
float (entity mark) nehend_checklevel;
void (vector vec, float num, vector megadeth, vector dave, vector spot) spawn_movepoint;
void () movepoint_touch;
float (vector megadeth, vector dave, entity head) situation;
void (vector vec, float num) spawn_downpoint;
void () spawn_platpoint;
void () platpoint_plat;
void (entity head) switchmethod;
void () maxnewteles;
void () ai_maxrun;
float () findjumppath;
void () spawn_mister;
void () max_begin;
void () max_stand;
void () max_squint;
void () max_look;
void () max_look2;
void () max_look3;
void () max_look4;
void () max_stroll;
void () max_attack;
void () max_gauntrang1;
void () max_gauntrang2;
void () max_gauntrang3;
void () max_gauntrang4;
void () max_gauntrang5;
void () max_gauntrang6;
void () max_gauntrang7;
void () max_gauntrang8;
void () max_backorcharge;
void () max_light1;
void () max_light2;
void () max_light3;
void () max_light4;
void () max_light5;
void () max_light6;
void () max_light7;
void () max_light8;
void () max_light9;
void () max_shalrath1;
void () max_shalrath2;
void () max_shalrath3;
void () max_shalrath4;
void () max_shalrath5;
void () max_shalrath6;
void () max_shalrath7;
void () max_shalrath8;
void () max_run;
void () max_die;
void () max_pain;
void () max_pain2;
void () max_pain3;
void () max_pain4;
void () max_diea1;
void () max_diea2;
void () max_getup;
void () max_getup2;
void () max_getup3;
void () max_getup4;
void () max_diec1;
void () max_diec2;
void () max_recover;
void () max_recover2;
void () max_recover3;
void () max_throw;
void () Max_teleportsys;
void () max_survival;
void () MaxRedLightning;
void () max_s_light1;
void () max_s_light2;
void () max_s_light3;
void () max_s_light4;
void () max_s_light5;
void () max_s_light6;
void () max_s_light7;
void () max_s_light8;
void () max_s_light9;
void () max_rapidfire1;
void () max_rapidfire2;
void () max_rapidfire3;
void () max_rapidfire4;
void () max_rapidfire5;
void () max_rapidfire6;
void () max_rapidfire7;
void () max_rapidfire8;
void (float dm) ThrowSprocket;
void () spftouch;
void () max_is_dead;
void () free_a_soul;
void () maxcorpse;
float () max_quadfudge;
void () max_qwait;
void () spawn_finalerubble;
void () setup_finalerubble;
void (vector vec) spawn_rubblefall;
void () throwsomerub;
void () finalesnds;
void () spawn_lightshow;
void () fogflash;
void () spawn_maxcontrol;
void () comment_think;
void () becomeearthquake;
void () comment_waiting;
float () comment_blunder;
void () comment_case1;
void () comment_case2;
void () comment_case3;
void () comment_final;
void () ending1;
void () remove_max;
void () make_comment;
void () spawn_openshit;
void () openshit_dammit;
void () maxstep;
void () max_painsound;
void () max_painsound1;
void () max_painsound2;
void () info_null;
void () info_notnull;
void () light_use;
void () light;
void () light_fluoro;
void () light_fluorospark;
void () light_globe;
void () FireAmbient;
void () light_torch_small_walltorch;
void () light_flame_large_yellow;
void () light_flame_small_yellow;
void () light_flame_small_white;
void () light_lantern;
void () light_swinging_lantern;
void () light_candle_t;
void () light_candle_w;
void () light_candleth;
void () light_candlews;
void () misc_fireball;
void () fire_fly;
void () fire_touch;
void () misc_slime_ball;
void () slime_fly;
void () slime_touch;
void () barrel_explode;
void () sbarrel_explode;
void () misc_barrel;
void () misc_explobox;
void () misc_explobox2;
void () box_think;
void () misc_corpse;
void () corpsesplat;
void () spikeshooter_use;
void () shooter_think;
void () trap_spikeshooter;
void () trap_shooter;
void () air_bubbles;
void () make_bubbles;
void () bubble_split;
void () bubble_remove;
void () bubble_bob;
void () func_wall_use;
void () func_wall;
void () func_illusionary;
void () func_episodegate;
void () func_bossgate;
void () ambient_suck_wind;
void () ambient_fan_blowing;
void () ambient_drone;
void () ambient_flouro_buzz;
void () ambient_drip;
void () ambient_comp_hum;
void () ambient_light_buzz;
void () ambient_swamp1;
void () ambient_swamp2;
void () ambient_secj;
void () play_secj;
void () ambient_sound;
void () ambient_humming;
void () ambient_eerie;
void () play_sound_looped;
void () playloopsnd;
void () start_loopsnd;
void () stop_loopsnd;
void () play_sound_use;
void () PlaySoundThink;
void () play_sound_triggered;
void () play_sound;
void () Seekoutwall;
void () ambient_thunder;
void () floating_gibs;
void () fgib_touch;
void (string gibname, float dm) spawn_fgib;
void () fgib_think;
void () trigger_gibs;
void () fgib_spawn;
void () fgib_die;
void () misc_motel;
void () misc_sign;
void () misc_tree;
void () misc_vend;
void () vend_blows;
void () misc_fscreen;
void () fscreen_think;
void () fscreen_trigger1;
void () fscreen_think2;
void () fscreen_trigger2;
void () fscreen_error;
void () misc_valve;
void () valve_turn;
void () misc_car;
void () monster_use;
void () monster_death_use;
void () walkmonster_start;
void () flymonster_start_go;
void () flymonster_start;
void () swimmonster_start_go;
void () swimmonster_start;
void () dead_stay_dead;
void () corpse_think;
void (entity monster) spawn_irritant;
void () irritate_monster;
float () borkfactor1;
void () wizspike_touch;
void () knightspike_touch;
void (vector p1, vector p2, entity from, float damage) LightningDamage;
void (vector p1, vector p2, entity from, float damage) ClientLightningDamage;
void (vector org, vector dir) launch_rocket;
void () M_MissileTouch;
void () MGrenadeExplode;
void () MGrenadeTouch;
void () Mons_fire_grenade;
void () Mons_fire_sprocket;
void () Mons_fire_rocket;
void () Mons_fire_shotgun;
void () Mons_fire_shotgun2;
void () Mons_fire_nails;
void (vector org, vector dir) mons_spike;
void () monspike_touch;
vector (float t) mindcrime_lead;
void () nehahra_checkvolume;
void () monster_nehahra;
void (float dist) nehahra_motion;
void () nehahra_damage;
void () nehahra_bspdamage;
float () nehahra_checkhit;
void () nehahra_field_goal;
void () nehahra_stand;
void () nehahra_missile;
void () nehahra_spitting;
void () nehahra_bspspit;
void () nehahra_squashing;
void () nehahra_goal;
void () nehahra_melee;
void () nehahra_sounds;
void () nehahra_smash1;
void () nehahra_smash2;
void () nehahra_smash3;
void () nehahra_smash4;
void () nehahra_smash5;
void () nehahra_smash6;
void () nehahra_smash7;
void () nehahra_smash8;
void () nehahra_smash9;
void () nehahra_smash10;
void () nehahra_smash11;
void () nehahra_smash12;
void () nehbsp_smash1;
void () nehbsp_smash2;
void () nehbsp_smash3;
void () nehbsp_smash4;
void () nehbsp_smash5;
void () nehbsp_smash6;
void () nehbsp_smash7;
void () nehbsp_smash8;
void () nehbsp_smash9;
void () nehbsp_smash10;
void () nehbsp_smash11;
void () nehbsp_smash12;
void () nehahra_handlebsp;
void () nehahra_kick1;
void () nehahra_kick2;
void () nehahra_kick3;
void () nehahra_kick4;
void () nehahra_kick5;
void () nehahra_kick6;
void () nehahra_kick7;
void () nehahra_kick8;
void () nehahra_kick9;
float (entity targ) visible_bsp;
void (entity targ) face_bsp;
void (float offset) nehahra_bspfire;
float () neh_findbsp;
void () nehahra_wreckbsp;
void () nehahra_carnify_body;
void () nehahra_carnify_head;
void (entity attacker, float damage) bod_neh_pain;
void () nehahra_frame;
void () kill_nehahra;
void () nehahra_die;
void () n_die2;
void () n_die3;
void () n_die4;
void () n_die5;
void () n_die6;
void () n_die7;
void () n_die8;
void () n_die9;
void () n_die10;
void () n_die11;
void () n_die12;
void () n_die13;
void () n_die14;
void () n_die15;
void () n_die16;
void () n_die17;
void () n_die18;
void () n_die19;
void () n_die20;
void () n_die21;
void () n_die22;
void () n_die23;
void () n_die24;
void () n_die25;
void () n_die26;
void () n_die27;
void () n_die28;
void () n_die29;
void () n_die30;
void () n_die31;
void (string gibname, float dm) ThrowGibstorm;
void () throwgibs;
void () nehjet;
void () nehahra_deathbeams;
void () OgreGrenadeExplode;
void () OgreGrenadeTouch;
void () OgreFireGrenade;
void (float side) chainsaw;
void () ogre_stand1;
void () ogre_stand2;
void () ogre_stand3;
void () ogre_stand4;
void () ogre_stand5;
void () ogre_stand6;
void () ogre_stand7;
void () ogre_stand8;
void () ogre_stand9;
void () ogre_walk1;
void () ogre_walk2;
void () ogre_walk3;
void () ogre_walk4;
void () ogre_walk5;
void () ogre_walk6;
void () ogre_walk7;
void () ogre_walk8;
void () ogre_walk9;
void () ogre_walk10;
void () ogre_walk11;
void () ogre_walk12;
void () ogre_walk13;
void () ogre_walk14;
void () ogre_walk15;
void () ogre_walk16;
void () ogre_run1;
void () ogre_run2;
void () ogre_run3;
void () ogre_run4;
void () ogre_run5;
void () ogre_run6;
void () ogre_run7;
void () ogre_run8;
void () ogre_swing1;
void () ogre_swing2;
void () ogre_swing3;
void () ogre_swing4;
void () ogre_swing5;
void () ogre_swing6;
void () ogre_swing7;
void () ogre_swing8;
void () ogre_swing9;
void () ogre_swing10;
void () ogre_swing11;
void () ogre_swing12;
void () ogre_swing13;
void () ogre_swing14;
void () ogre_smash1;
void () ogre_smash2;
void () ogre_smash3;
void () ogre_smash4;
void () ogre_smash5;
void () ogre_smash6;
void () ogre_smash7;
void () ogre_smash8;
void () ogre_smash9;
void () ogre_smash10;
void () ogre_smash11;
void () ogre_smash12;
void () ogre_smash13;
void () ogre_smash14;
void () ogre_nail1;
void () ogre_nail2;
void () ogre_nail3;
void () ogre_nail4;
void () ogre_nail5;
void () ogre_nail6;
void () ogre_nail7;
void () ogre_pain1;
void () ogre_pain2;
void () ogre_pain3;
void () ogre_pain4;
void () ogre_pain5;
void () ogre_painb1;
void () ogre_painb2;
void () ogre_painb3;
void () ogre_painc1;
void () ogre_painc2;
void () ogre_painc3;
void () ogre_painc4;
void () ogre_painc5;
void () ogre_painc6;
void () ogre_paind1;
void () ogre_paind2;
void () ogre_paind3;
void () ogre_paind4;
void () ogre_paind5;
void () ogre_paind6;
void () ogre_paind7;
void () ogre_paind8;
void () ogre_paind9;
void () ogre_paind10;
void () ogre_paind11;
void () ogre_paind12;
void () ogre_paind13;
void () ogre_paind14;
void () ogre_paind15;
void () ogre_paind16;
void () ogre_paine1;
void () ogre_paine2;
void () ogre_paine3;
void () ogre_paine4;
void () ogre_paine5;
void () ogre_paine6;
void () ogre_paine7;
void () ogre_paine8;
void () ogre_paine9;
void () ogre_paine10;
void () ogre_paine11;
void () ogre_paine12;
void () ogre_paine13;
void () ogre_paine14;
void () ogre_paine15;
void (entity attacker, float damage) ogre_pain;
void () ogre_die1;
void () ogre_die2;
void () ogre_die3;
void () ogre_die4;
void () ogre_die5;
void () ogre_die6;
void () ogre_die7;
void () ogre_die8;
void () ogre_die9;
void () ogre_die10;
void () ogre_die11;
void () ogre_die12;
void () ogre_die13;
void () ogre_die14;
void () ogre_bdie1;
void () ogre_bdie2;
void () ogre_bdie3;
void () ogre_bdie4;
void () ogre_bdie5;
void () ogre_bdie6;
void () ogre_bdie7;
void () ogre_bdie8;
void () ogre_bdie9;
void () ogre_bdie10;
void () ogre_die;
void () ogre_melee;
void () monster_ogre;
void () monster_ogre_marksman;
void () old_idle1;
void () old_idle2;
void () old_idle3;
void () old_idle4;
void () old_idle5;
void () old_idle6;
void () old_idle7;
void () old_idle8;
void () old_idle9;
void () old_idle10;
void () old_idle11;
void () old_idle12;
void () old_idle13;
void () old_idle14;
void () old_idle15;
void () old_idle16;
void () old_idle17;
void () old_idle18;
void () old_idle19;
void () old_idle20;
void () old_idle21;
void () old_idle22;
void () old_idle23;
void () old_idle24;
void () old_idle25;
void () old_idle26;
void () old_idle27;
void () old_idle28;
void () old_idle29;
void () old_idle30;
void () old_idle31;
void () old_idle32;
void () old_idle33;
void () old_idle34;
void () old_idle35;
void () old_idle36;
void () old_idle37;
void () old_idle38;
void () old_idle39;
void () old_idle40;
void () old_idle41;
void () old_idle42;
void () old_idle43;
void () old_idle44;
void () old_idle45;
void () old_idle46;
void () old_thrash1;
void () old_thrash2;
void () old_thrash3;
void () old_thrash4;
void () old_thrash5;
void () old_thrash6;
void () old_thrash7;
void () old_thrash8;
void () old_thrash9;
void () old_thrash10;
void () old_thrash11;
void () old_thrash12;
void () old_thrash13;
void () old_thrash14;
void () old_thrash15;
void () old_thrash16;
void () old_thrash17;
void () old_thrash18;
void () old_thrash19;
void () old_thrash20;
void () finale_1;
void () finale_2;
void () finale_3;
void () finale_4;
void () monster_oldone;
void () plat_spawn_inside_trigger;
void () plat_hit_top;
void () plat_hit_bottom;
void () plat_go_down;
void () plat_go_up;
void () plat_center_touch;
void () plat_outside_touch;
void () plat_trigger_use;
void () plat_crush;
void () plat_use;
void () func_plat;
void () train_blocked;
void () train_use;
void () train_wait;
void () train_next;
void () func_train_find;
void () func_train;
void () misc_teleporttrain;
void () player_stand1;
void () player_run;
void () player_shot1;
void () player_shot2;
void () player_shot3;
void () player_shot4;
void () player_shot5;
void () player_shot6;
void () player_axe1;
void () player_axe2;
void () player_axe3;
void () player_axe4;
void () player_axeb1;
void () player_axeb2;
void () player_axeb3;
void () player_axeb4;
void () player_axec1;
void () player_axec2;
void () player_axec3;
void () player_axec4;
void () player_axed1;
void () player_axed2;
void () player_axed3;
void () player_axed4;
void () player_nail1;
void () player_nail2;
void () player_light1;
void () player_light2;
void () player_rocket1;
void () player_rocket2;
void () player_rocket3;
void () player_rocket4;
void () player_rocket5;
void () player_rocket6;
void () PainSound;
void () player_pain1;
void () player_pain2;
void () player_pain3;
void () player_pain4;
void () player_pain5;
void () player_pain6;
void () player_axpain1;
void () player_axpain2;
void () player_axpain3;
void () player_axpain4;
void () player_axpain5;
void () player_axpain6;
void () player_pain;
void () DeathBubblesSpawn;
void (float num_bubbles) DeathBubbles;
void () DeathSound;
void () PlayerDead;
vector (float dm) VelocityForDamage;
void (string gibname, float dm) ThrowGib;
void (string gibname, float dm) ThrowHead;
void () GibPlayer;
void () PlayerDie;
void () set_suicide_frame;
void () player_diea1;
void () player_diea2;
void () player_diea3;
void () player_diea4;
void () player_diea5;
void () player_diea6;
void () player_diea7;
void () player_diea8;
void () player_diea9;
void () player_diea10;
void () player_diea11;
void () player_dieb1;
void () player_dieb2;
void () player_dieb3;
void () player_dieb4;
void () player_dieb5;
void () player_dieb6;
void () player_dieb7;
void () player_dieb8;
void () player_dieb9;
void () player_diec1;
void () player_diec2;
void () player_diec3;
void () player_diec4;
void () player_diec5;
void () player_diec6;
void () player_diec7;
void () player_diec8;
void () player_diec9;
void () player_diec10;
void () player_diec11;
void () player_diec12;
void () player_diec13;
void () player_diec14;
void () player_diec15;
void () player_died1;
void () player_died2;
void () player_died3;
void () player_died4;
void () player_died5;
void () player_died6;
void () player_died7;
void () player_died8;
void () player_died9;
void () player_diee1;
void () player_diee2;
void () player_diee3;
void () player_diee4;
void () player_diee5;
void () player_diee6;
void () player_diee7;
void () player_diee8;
void () player_diee9;
void () player_die_ax1;
void () player_die_ax2;
void () player_die_ax3;
void () player_die_ax4;
void () player_die_ax5;
void () player_die_ax6;
void () player_die_ax7;
void () player_die_ax8;
void () player_die_ax9;
void () experiment_push;
void () func_pushable;
void () info_weight_switch;
void () weight_switch_think;
void () main_weight_switch;
void () mweight_think;
float () Wsensor_checkothers;
void () weight_sensor;
void (float side, float damg) kguard_firing;
void () kguard_stand1;
void () kguard_stand2;
void () kguard_stand3;
void () kguard_stand4;
void () kguard_stand5;
void () kguard_stand6;
void () kguard_stand7;
void () kguard_stand8;
void () kguard_stand9;
void () kguard_walk1;
void () kguard_walk2;
void () kguard_walk3;
void () kguard_walk4;
void () kguard_walk5;
void () kguard_walk6;
void () kguard_back;
void () kguard_run1;
void () kguard_run2;
void () kguard_run3;
void () kguard_run4;
void () kguard_run5;
void () kguard_run6;
void () kguard_run7;
void () kguard_atta1;
void () kguard_atta4;
void () kguard_atta5;
void () kguard_atta6;
void () kguard_atta7;
void () kguard_atta8;
void () kguard_pain1;
void () kguard_pain2;
void () kguard_pain3;
void () kguard_pain4;
void () kguard_pain5;
void () kguard_pain6;
void () kguard_pain;
void () kguard_die1;
void () kguard_die2;
void () kguard_die3;
void () kguard_die4;
void () kguard_die5;
void () kguard_die6;
void () kguard_die7;
void () kguard_die8;
void () kguard_die9;
void () kguard_die10;
void () kguard_die11;
void () kguard_dieb1;
void () kguard_dieb2;
void () kguard_dieb3;
void () kguard_dieb4;
void () kguard_dieb5;
void () kguard_dieb6;
void () kguard_dieb7;
void () kguard_dieb8;
void () kguard_dieb9;
void () kguard_die;
void () monster_qguy;
void () qguy_start;
void () carnify_qguy;
void () kguard_actor_wait;
void () kguard_actor_use;
void () kguard_shoot;
float () TargetBadGuys;
float () qguy_tolerance;
void (float dist) ai_retreat;
void () flee_options;
vector (float num, vector t) checkfleepath;
void () vispts;
void () shal_stand;
void () shal_walk1;
void () shal_walk2;
void () shal_walk3;
void () shal_walk4;
void () shal_walk5;
void () shal_walk6;
void () shal_walk7;
void () shal_walk8;
void () shal_walk9;
void () shal_walk10;
void () shal_walk11;
void () shal_walk12;
void () shal_run1;
void () shal_run2;
void () shal_run3;
void () shal_run4;
void () shal_run5;
void () shal_run6;
void () shal_run7;
void () shal_run8;
void () shal_run9;
void () shal_run10;
void () shal_run11;
void () shal_run12;
void () shal_attack1;
void () shal_attack2;
void () shal_attack3;
void () shal_attack4;
void () shal_attack5;
void () shal_attack6;
void () shal_attack7;
void () shal_attack8;
void () shal_attack9;
void () shal_attack10;
void () shal_attack11;
void () shal_pain1;
void () shal_pain2;
void () shal_pain3;
void () shal_pain4;
void () shal_pain5;
void () shal_death1;
void () shal_death2;
void () shal_death3;
void () shal_death4;
void () shal_death5;
void () shal_death6;
void () shal_death7;
void () shalrath_pain;
void () shalrath_die;
void () ShalMissile;
void () ShalHome;
void () ShalMissileTouch;
void () monster_shalrath;
float () shal_clearance;
void () sham_stand1;
void () sham_walk1;
void () sham_walk2;
void () sham_walk3;
void () sham_walk4;
void () sham_walk5;
void () sham_walk6;
void () sham_walk7;
void () sham_walk8;
void () sham_walk9;
void () sham_walk10;
void () sham_walk11;
void () sham_walk12;
void () sham_run1;
void () sham_run2;
void () sham_run3;
void () sham_run4;
void () sham_run5;
void () sham_run6;
void () sham_smash1;
void () sham_smash2;
void () sham_smash3;
void () sham_smash4;
void () sham_smash5;
void () sham_smash6;
void () sham_smash7;
void () sham_smash8;
void () sham_smash9;
void () sham_smash10;
void () sham_smash11;
void () sham_smash12;
void (float side) ShamClaw;
void () sham_swingl1;
void () sham_swingl2;
void () sham_swingl3;
void () sham_swingl4;
void () sham_swingl5;
void () sham_swingl6;
void () sham_swingl7;
void () sham_swingl8;
void () sham_swingl9;
void () sham_swingr1;
void () sham_swingr2;
void () sham_swingr3;
void () sham_swingr4;
void () sham_swingr5;
void () sham_swingr6;
void () sham_swingr7;
void () sham_swingr8;
void () sham_swingr9;
void () sham_melee;
void () CastLightning;
void () sham_magic1;
void () sham_magic2;
void () sham_magic3;
void () sham_magic4;
void () sham_magic5;
void () sham_magic6;
void () sham_magic9;
void () sham_magic10;
void () sham_magic11;
void () sham_magic12;
void () sham_pain1;
void () sham_pain2;
void () sham_pain3;
void () sham_pain4;
void () sham_pain5;
void () sham_pain6;
void (entity attacker, float damage) sham_pain;
void () sham_death1;
void () sham_death2;
void () sham_death3;
void () sham_death4;
void () sham_death5;
void () sham_death6;
void () sham_death7;
void () sham_death8;
void () sham_death9;
void () sham_death10;
void () sham_death11;
void () sham_die;
void () monster_shambler;
void () army_stand1;
void () army_stand2;
void () army_stand3;
void () army_stand4;
void () army_stand5;
void () army_stand6;
void () army_stand7;
void () army_stand8;
void () army_lleft1;
void () army_lleft2;
void () army_lleft3;
void () army_lleft4;
void () army_lleft5;
void () army_lright1;
void () army_lright2;
void () army_lright3;
void () army_lright4;
void () army_lright5;
void () army_walk1;
void () army_walk2;
void () army_walk3;
void () army_walk4;
void () army_walk5;
void () army_walk6;
void () army_walk7;
void () army_walk8;
void () army_walk9;
void () army_walk10;
void () army_walk11;
void () army_walk12;
void () army_walk13;
void () army_walk14;
void () army_walk15;
void () army_walk16;
void () army_walk17;
void () army_walk18;
void () army_walk19;
void () army_walk20;
void () army_walk21;
void () army_walk22;
void () army_walk23;
void () army_walk24;
void () army_onground1;
void () army_onground2;
void () army_flop1;
void () army_flop2;
void () army_flop3;
void () army_flop4;
void () army_flop5;
void () army_flop6;
void () army_flop7;
void () army_flop8;
void () army_flop9;
void () army_flop10;
void () army_flop11;
void () army_deth;
void () army_deth2;
void () army_deth3;
void () army_run1;
void () army_run2;
void () army_run3;
void () army_run4;
void () army_run5;
void () army_run6;
void () army_run7;
void () army_run8;
void () army_boogie;
void () army_atk1;
void () army_atk2;
void () army_atk3;
void () army_atk4;
void () army_atk5;
void () army_atk6;
void () army_atk7;
void () army_atk8;
void () army_atk9;
void () army_shootup1;
void () army_shootup2;
void () army_shootup3;
void () army_pain1;
void () army_pain2;
void () army_pain3;
void () army_pain4;
void () army_pain5;
void () army_pain6;
void () army_painb1;
void () army_painb2;
void () army_painb3;
void () army_painb4;
void () army_painb5;
void () army_painb6;
void () army_painb7;
void () army_painb8;
void () army_painb9;
void () army_painb10;
void () army_painb11;
void () army_painb12;
void () army_painb13;
void () army_painb14;
void () army_painc1;
void () army_painc2;
void () army_painc3;
void () army_painc4;
void () army_painc5;
void () army_painc6;
void () army_painc7;
void () army_painc8;
void () army_painc9;
void () army_painc10;
void () army_painc11;
void () army_painc12;
void () army_painc13;
void (entity attacker, float damage) army_pain;
void () army_fire;
void () army_die1;
void () army_die2;
void () army_die3;
void () army_die4;
void () army_die5;
void () army_die6;
void () army_die7;
void () army_die8;
void () army_die9;
void () army_die10;
void () army_cdie1;
void () army_cdie2;
void () army_cdie3;
void () army_cdie4;
void () army_cdie5;
void () army_cdie6;
void () army_cdie7;
void () army_cdie8;
void () army_cdie9;
void () army_cdie10;
void () army_cdie11;
void () army_die;
void () army_begin;
void () army_wait;
void () monster_army2;
void () monster_army3;
void () monster_army4;
void () monster_army5;
void () army_blahblah;
void () monster_army;
void () soldier_startt;
void () carnify_soldier;
void () army_2normal;
void () army_ouch;
void () army_crun;
void () army_cidle1;
void () army_cidle2;
void () army_cidle3;
void () army_cidle4;
void () army_cidle5;
void () army_cidle6;
void () army_con1;
void () army_con2;
void () army_look;
void () army_look2;
void () army_look3;
void () army_look4;
void () army_dropbackpack;
void () army_runshot1;
void () army_runshot2;
void () army_runshot3;
void () army_runshot4;
void () army_runshot5;
void () army_runshot6;
void () army_runshot7;
void () army_runshot8;
void () monster_qforge;
void () qforge_spiel_go;
void () qforge_begin;
void () qforge_wait;
void () qforge_stir;
void () qforge_lookup;
void () qforge_uptalk;
void () qforge_die;
void () qforge_die2;
void () qforge_die3;
void () qforge_die4;
void () qforge_die5;
void () qforge_die6;
void () spawn_qforgespeak;
void () qforge_talk;
void () monster_labguy;
void () lab_idle;
void () lab_idleaction;
void () lab_looking;
void () lab_looking2;
void () lab_lookdown;
void () lab1_control;
void () lab1_control2;
void () lab2_control;
void () lab2_control2;
void () lab_walk;
void () lab_die;
void () lab_die2;
void () lab_run;
void (float dist) npc_walk;
void () npc_stand;
float () npc_threats;
void () SUB_Null;
void () SUB_Remove;
void () SetMovedir;
void () InitTrigger;
void (entity ent, vector tdest, float tspeed, void() func) SUB_CalcMoveEnt;
void (vector tdest, float tspeed, void() func) SUB_CalcMove;
void () SUB_CalcMoveDone;
void (entity ent, vector destangle, float tspeed, void() func) SUB_CalcAngleMoveEnt;
void (vector destangle, float tspeed, void() func) SUB_CalcAngleMove;
void () SUB_CalcAngleMoveDone;
void () DelayThink;
void () SUB_UseTargets;
void (float normal) SUB_AttackFinished;
void (void() thinkst) SUB_CheckRefire;
vector (entity mark) Sub_CalcOrigin;
void () tbaby_stand1;
void () tbaby_hang1;
void () tbaby_walk1;
void () tbaby_walk2;
void () tbaby_walk3;
void () tbaby_walk4;
void () tbaby_walk5;
void () tbaby_walk6;
void () tbaby_walk7;
void () tbaby_walk8;
void () tbaby_walk9;
void () tbaby_walk10;
void () tbaby_walk11;
void () tbaby_walk12;
void () tbaby_walk13;
void () tbaby_walk14;
void () tbaby_walk15;
void () tbaby_walk16;
void () tbaby_walk17;
void () tbaby_walk18;
void () tbaby_walk19;
void () tbaby_walk20;
void () tbaby_walk21;
void () tbaby_walk22;
void () tbaby_walk23;
void () tbaby_walk24;
void () tbaby_walk25;
void () tbaby_run1;
void () tbaby_run2;
void () tbaby_run3;
void () tbaby_run4;
void () tbaby_run5;
void () tbaby_run6;
void () tbaby_run7;
void () tbaby_run8;
void () tbaby_run9;
void () tbaby_run10;
void () tbaby_run11;
void () tbaby_run12;
void () tbaby_run13;
void () tbaby_run14;
void () tbaby_run15;
void () tbaby_run16;
void () tbaby_run17;
void () tbaby_run18;
void () tbaby_run19;
void () tbaby_run20;
void () tbaby_run21;
void () tbaby_run22;
void () tbaby_run23;
void () tbaby_run24;
void () tbaby_run25;
void () Tar_JumpTouch;
void () tbaby_fly1;
void () tbaby_fly2;
void () tbaby_fly3;
void () tbaby_fly4;
void () tbaby_jump1;
void () tbaby_jump2;
void () tbaby_jump3;
void () tbaby_jump4;
void () tbaby_jump5;
void () tbaby_jump6;
void () tbaby_die1;
void () tbaby_die2;
void () monster_tarbaby;
void () yield_items;
void () yield_armor;
void (float num) precache_thrown;
void () precache_ammo;
void (float num) throw_item;
void (float num) throw_ammo;
void () trigger_spawnmonster;
void () trigger_reactivate;
void () multi_wait;
void () multi_trigger;
void () multi_killed;
void () multi_use;
void () multi_touch;
void () trigger_multiple;
void () trigger_once;
void () trigger_relay;
void () trigger_secret;
void () counter_use;
void () trigger_counter;
void () play_teleport;
void (vector org) spawn_tfog;
void () tdeath_touch;
void (vector org, entity death_owner) spawn_tdeath;
void () teleport_touch;
void () info_teleport_destination;
void () teleport_use;
void () trigger_teleport;
void () trigger_skill_touch;
void () trigger_setskill;
void () trigger_onlyregistered_touch;
void () trigger_onlyregistered;
void () hurt_on;
void () hurt_touch;
void () trigger_hurt;
void () trigger_push_touch;
void () trigger_push;
void () trigger_monsterjump_touch;
void () trigger_monsterjump;
void () qteleport_touch;
void () trigger_qtele;
void () skubremove_touch;
void () func_remove;
void () abyss_touch;
void (vector vec) spawn_borkedvigil;
void () borkedvigilthink;
void () monster_vomitus;
void () vomit_ouchie;
void () vomit_flat;
void () vomit_dead;
void () vomit_rise;
void () vomit_riseup;
void () vomit_idle;
void () vomit_motion;
void () vomit_vomit;
void () vomit_barf1;
void () vomit_barf2;
void () vomit_die;
void () vomit_deflate;
void () vomit_chunks;
void (vector st) blow_chunks;
void () Anglechecking;
void () setup_explodable;
void () func_cover;
void () func_pain;
void () pain_deathtype;
void () painz_touch;
void (string gibname, float dm) ThrowRubble;
void () exploding_wall_use;
void () wall_killed;
void () Rubblesets;
void () info_throw_rubble;
void () throwrub;
void () func_explodable;
void () func_quakedmg;
void () func_sobject;
void () exploding_wall;
void () func_bobbingobject;
void () bobber_on;
void () bobber_off;
void () spawn_mchsnd;
void () mchsnd_think;
void () func_mindcrime;
void () object_fall;
void () wait_to_die;
void () player_push2;
void () squish_touch;
void () squish_touch2;
void () func_object;
void () mindcrime_throw;
void () func_earthquake;
void () initiate_quake;
void () quakenoise;
void () quake_n_shake;
void () efx_lightning;
void () efx1_Attack;
void () efx_snow;
void () efx3_spawn;
void (vector FlakeOrg) MakeFlake;
void () FlakeFloat;
float (float min, float max) RandomRange;
void () func_bobbingwater;
void () rain_touch;
void () rain_think;
void () check4liquid;
void () func_raining;
void () begin_rain;
void () func_floating;
void () func_drift;
void () drift_trigger;
void () brush_drift;
void () W_Precache;
float () crandom;
void () W_FireAxe;
void (vector org, vector vel) SpawnMeatSpray;
void (float damage) spawn_touchblood;
void (vector org, vector vel) SpawnChunk;
void () ClearMultiDamage;
void () ApplyMultiDamage;
void (entity hit, float damage) AddMultiDamage;
void (float damage, vector dir) TraceAttack;
void (float shotcount, vector dir, vector spread) FireBullets;
void () W_FireShotgun;
void () W_FireSuperShotgun;
void () T_MissileTouch;
void () W_FireRocket;
void () W_FireLightning;
void () GrenadeExplode;
void () GrenadeTouch;
void () W_FireGrenade;
void (vector org, vector dir) launch_spike;
void () spike_touch;
void () superspike_touch;
void () W_SetCurrentAmmo;
float () W_BestWeapon;
float () W_CheckNoAmmo;
void () W_Attack;
void () W_ChangeWeapon;
void () CycleWeaponCommand;
void () ImpulseCommands;
void () W_WeaponFrame;
void () SuperDamageSound;
vector () nehahra_lead;
void (float offset) nehahra_spitfire;
void (float offset) max_shootfire;
void (vector org, vector dir) WeldFire;
void () WeldExplode1;
void () WeldExplode2;
void () WeldExplode3;
void () WeldTouch;
void () BurnMakeBubble;
void (float num_bubbles) BurnSteam;
void () BurnThink;
void (entity victim, entity attacker) BurnSetOnFire;
void () BurnPainSound;
void (entity missile, float mspeed, float accuracy) LaunchMissile;
float () WizardCheckAttack;
void () WizardAttackFinished;
void () Wiz_FastFire;
void () Wiz_StartFast;
void () Wiz_idlesound;
void () wiz_stand1;
void () wiz_stand2;
void () wiz_stand3;
void () wiz_stand4;
void () wiz_stand5;
void () wiz_stand6;
void () wiz_stand7;
void () wiz_stand8;
void () wiz_walk1;
void () wiz_walk2;
void () wiz_walk3;
void () wiz_walk4;
void () wiz_walk5;
void () wiz_walk6;
void () wiz_walk7;
void () wiz_walk8;
void () wiz_side1;
void () wiz_side2;
void () wiz_side3;
void () wiz_side4;
void () wiz_side5;
void () wiz_side6;
void () wiz_side7;
void () wiz_side8;
void () wiz_run1;
void () wiz_run2;
void () wiz_run3;
void () wiz_run4;
void () wiz_run5;
void () wiz_run6;
void () wiz_run7;
void () wiz_run8;
void () wiz_run9;
void () wiz_run10;
void () wiz_run11;
void () wiz_run12;
void () wiz_run13;
void () wiz_run14;
void () wiz_fast1;
void () wiz_fast2;
void () wiz_fast3;
void () wiz_fast4;
void () wiz_fast5;
void () wiz_fast6;
void () wiz_fast7;
void () wiz_fast8;
void () wiz_fast9;
void () wiz_fast10;
void () wiz_pain1;
void () wiz_pain2;
void () wiz_pain3;
void () wiz_pain4;
void () wiz_death1;
void () wiz_death2;
void () wiz_death3;
void () wiz_death4;
void () wiz_death5;
void () wiz_death6;
void () wiz_death7;
void () wiz_death8;
void () wiz_die;
void (entity attacker, float damage) Wiz_Pain;
void () Wiz_Missile;
void () monster_wizard;
void () worldspawn;
void () bodyque;
void () InitBodyQue;
void (entity ent) CopyToBodyQue;
float () wraith_checkenemy;
void () wraith_2normal;
void () wraith_2inv;
void () wraith_inv_idle;
void () wraith_inv_motion;
void () wraith_comeback;
void () wraith_comeback2;
void () wraith_attack1;
void () wraith_attack2;
void () wraith_goinv;
void () wraith_goinv2;
void () wraith_inv_souls;
void () wraith_inv_souls2;
void () Wraith_Move;
void (float offset) wraith_spike;
void () wraith_invisible;
void () wraith_idle1;
void () wraith_idle2;
void () wraith_motion;
void () Spawn_Wraithgunk;
void () wraith_throws_gunk;
void () wraith_unform;
void () wraith_dissipate;
void () monster_wraith;
void () death_aura;
void () wraith_wait;
void () wraith_begin;
void () wraith_pain;
void () wraith_pain2;
void () wraith_pain3;
void () wraith_pain4;
void () wraith_pain5;
void () wraith_pain6;
void () wraith_pain7;
void () wraith_special;
void () wraith_zeda;
void () wraith_zeda1;
void () wraith_zeda2;
void () wraith_zeda3;
void () wraith_zeda4;
void () wraith_zeda5;
void () wraith_zeda6;
void () wraith_zeda7;
void () wraith_zeda8;
void () wraith_soulcheck;
void () wraith_xeda2;
void () wraith_xeda3;
void () wraith_souls;
void (entity mark) Soul_to_take;
void () Soul_Think;
float () Seek_out_soul;
float () Wraith_Find_Orphans;
void () wraith_soul_proxim;
void (entity mark) spawn_soulsound;
void () make_soulsound;
void () zombie_stand1;
void () zombie_cruc1;
void () zombie_cruc2;
void () zombie_cruc3;
void () zombie_cruc4;
void () zombie_cruc5;
void () zombie_cruc6;
void () zombie_walk1;
void () zombie_walk2;
void () zombie_walk3;
void () zombie_walk4;
void () zombie_walk5;
void () zombie_walk6;
void () zombie_walk7;
void () zombie_walk8;
void () zombie_walk9;
void () zombie_walk10;
void () zombie_walk11;
void () zombie_walk12;
void () zombie_walk13;
void () zombie_walk14;
void () zombie_walk15;
void () zombie_walk16;
void () zombie_walk17;
void () zombie_walk18;
void () zombie_walk19;
void () zombie_run1;
void () zombie_run2;
void () zombie_run3;
void () zombie_run4;
void () zombie_run5;
void () zombie_run6;
void () zombie_run7;
void () zombie_run8;
void () zombie_run9;
void () zombie_run10;
void () zombie_run11;
void () zombie_run12;
void () zombie_run13;
void () zombie_run14;
void () zombie_run15;
void () zombie_run16;
void () zombie_run17;
void () zombie_run18;
void () ZombieGrenadeTouch;
void (vector st) ZombieFireGrenade;
void () zombie_atta1;
void () zombie_atta2;
void () zombie_atta3;
void () zombie_atta4;
void () zombie_atta5;
void () zombie_atta6;
void () zombie_atta7;
void () zombie_atta8;
void () zombie_atta9;
void () zombie_atta10;
void () zombie_atta11;
void () zombie_atta12;
void () zombie_atta13;
void () zombie_attb1;
void () zombie_attb2;
void () zombie_attb3;
void () zombie_attb4;
void () zombie_attb5;
void () zombie_attb6;
void () zombie_attb7;
void () zombie_attb8;
void () zombie_attb9;
void () zombie_attb10;
void () zombie_attb11;
void () zombie_attb12;
void () zombie_attb13;
void () zombie_attb14;
void () zombie_attc1;
void () zombie_attc2;
void () zombie_attc3;
void () zombie_attc4;
void () zombie_attc5;
void () zombie_attc6;
void () zombie_attc7;
void () zombie_attc8;
void () zombie_attc9;
void () zombie_attc10;
void () zombie_attc11;
void () zombie_attc12;
void () zombie_missile;
void () zombie_paina1;
void () zombie_paina2;
void () zombie_paina3;
void () zombie_paina4;
void () zombie_paina5;
void () zombie_paina6;
void () zombie_paina7;
void () zombie_paina8;
void () zombie_paina9;
void () zombie_paina10;
void () zombie_paina11;
void () zombie_paina12;
void () zombie_painb1;
void () zombie_painb2;
void () zombie_painb3;
void () zombie_painb4;
void () zombie_painb5;
void () zombie_painb6;
void () zombie_painb7;
void () zombie_painb8;
void () zombie_painb9;
void () zombie_painb10;
void () zombie_painb11;
void () zombie_painb12;
void () zombie_painb13;
void () zombie_painb14;
void () zombie_painb15;
void () zombie_painb16;
void () zombie_painb17;
void () zombie_painb18;
void () zombie_painb19;
void () zombie_painb20;
void () zombie_painb21;
void () zombie_painb22;
void () zombie_painb23;
void () zombie_painb24;
void () zombie_painb25;
void () zombie_painb26;
void () zombie_painb27;
void () zombie_painb28;
void () zombie_painc1;
void () zombie_painc2;
void () zombie_painc3;
void () zombie_painc4;
void () zombie_painc5;
void () zombie_painc6;
void () zombie_painc7;
void () zombie_painc8;
void () zombie_painc9;
void () zombie_painc10;
void () zombie_painc11;
void () zombie_painc12;
void () zombie_painc13;
void () zombie_painc14;
void () zombie_painc15;
void () zombie_painc16;
void () zombie_painc17;
void () zombie_painc18;
void () zombie_paind1;
void () zombie_paind2;
void () zombie_paind3;
void () zombie_paind4;
void () zombie_paind5;
void () zombie_paind6;
void () zombie_paind7;
void () zombie_paind8;
void () zombie_paind9;
void () zombie_paind10;
void () zombie_paind11;
void () zombie_paind12;
void () zombie_paind13;
void () zombie_paine1;
void () zombie_paine2;
void () zombie_paine3;
void () zombie_paine4;
void () zombie_paine5;
void () zombie_paine6;
void () zombie_paine7;
void () zombie_paine8;
void () zombie_paine9;
void () zombie_paine10;
void () zombie_paine11;
void () zombie_paine12;
void () zombie_paine13;
void () zombie_paine14;
void () zombie_paine15;
void () zombie_paine16;
void () zombie_paine17;
void () zombie_paine18;
void () zombie_paine19;
void () zombie_paine20;
void () zombie_paine21;
void () zombie_paine22;
void () zombie_paine23;
void () zombie_paine24;
void () zombie_paine25;
void () zombie_paine26;
void () zombie_paine27;
void () zombie_paine28;
void () zombie_paine29;
void () zombie_paine30;
void () zombie_die;
void (entity attacker, float take) zombie_pain;
void () monster_zombie;
float () shal_clearance =
{
	local vector end;
	end = self.origin + '0 0 250';
	traceline (self.origin, end, TRUE, self);
	if ((trace_fraction == 1))
	{
		return (1);
	}
	else
	{
		dprint ("\n");
		return (0);
	}
};
void () play_secj =
{
	sound (self, CHAN_AUTO, "ambience/secj.wav", 1, ATTN_NONE);
	self.think = play_secj;
	self.nextthink = (time + 25);
};
void () ambient_secj =
{
	precache_sound2 ("ambience/secj.wav");
	self.think = play_secj;
	self.nextthink = (time + 0.5);
};
void () box_think =
{
	if ((self.watertype == CONTENT_LAVA))
	{
		barrel_explode ();
		return;
	}
	if ((pointcontents (self.origin) < CONTENT_SOLID))
	{
		return;
	}
	self.think = box_think;
	self.nextthink = (time + 0.2);
};
void () misc_slime_ball =
{
	precache_model ("progs/slime.mdl");
	self.classname = "slimeball";
	self.nextthink = (time + (random () * MOVETYPE_FLY));
	self.think = slime_fly;
	if (!self.speed)
	{
	}
};
void () slime_fly =
{
	local entity fireball;
	fireball = spawn ();
	fireball.solid = SOLID_TRIGGER;
	fireball.movetype = MOVETYPE_TOSS;
	fireball.velocity = '0 0 1000';
	fireball.velocity_x = ((random () * 100) - 50);
	fireball.velocity_y = ((random () * 100) - 50);
	fireball.velocity_z = (100 + (random () * 200));
	fireball.classname = "slime";
	setmodel (fireball, "progs/slime.mdl");
	setsize (fireball, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (fireball, self.origin);
	fireball.nextthink = (time + MOVETYPE_FLY);
	fireball.think = SUB_Remove;
	fireball.touch = slime_touch;
	self.nextthink = ((time + (random () * MOVETYPE_FLY)) + MOVETYPE_WALK);
	self.think = slime_fly;
};
void () slime_touch =
{
	T_Damage (other, self, self, 10);
	remove (self);
};
void () misc_barrel =
{
	local float oldz;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	precache_model ("progs/barrel.mdl");
	precache_model ("progs/bartop.mdl");
	precache_model ("progs/slime.mdl");
	setmodel (self, "progs/barrel.mdl");
	if (!self.frame)
	{
		setsize (self, VEC_HULL_MIN, '10 10 10');
		self.health = 30;
	}
	else
	{
		if ((self.frame == 1))
		{
			setsize (self, VEC_HULL_MIN, '10 10 10');
			self.health = 40;
		}
		else
		{
			if ((self.frame == 2))
			{
				setsize (self, VEC_HULL_MIN, '12 12 12');
				self.health = 50;
			}
			else
			{
				dprint ("removed barrel with invalid frame\n");
				remove (self);
				return;
			}
		}
	}
	precache_sound ("weapons/r_exp3.wav");
	self.health = 20;
	self.th_die = sbarrel_explode;
	self.takedamage = DAMAGE_AIM;
	self.event = "metal";
	self.touch = player_push2;
	self.origin_z = (self.origin_z + FL_SWIM);
	oldz = self.origin_z;
	droptofloor ();
	if (((oldz - self.origin_z) > 250))
	{
		dprint ("item fell out of level at ");
		dprint (vtos (self.origin));
		dprint ("\n");
		remove (self);
	}
	self.think = box_think;
	self.nextthink = (time + 0.3);
};
void () Spawn_Wraithgunk =
{
	self.cnt = (self.cnt + 1);
	if ((self.cnt > 30))
	{
		self.think = SUB_Remove;
		self.nextthink = (time + 0.01);
		return;
	}
	self.nextthink = (time + 0.05);
};
void () wraith_throws_gunk2 =
{
	local entity gunk;
	local float n;
	n = 0;
	gunk = find (world, classname, "gunk");
	while (gunk)
	{
		n = n + 1;
		gunk = find (gunk, classname, "gunk");
	}
	if ((n > 3))
	{
		return;
	}
	gunk = spawn ();
	gunk.origin = (self.origin + '0 0 24');
	if ((self.classname == "monster_wraith"))
	{
		gunk.classname = "gunk";
	}
	gunk.velocity_z = 300;
	gunk.velocity_x = (-100 + (random () * 200));
	gunk.velocity_y = (-100 + (random () * 200));
	gunk.solid = SOLID_NOT;
	gunk.cnt = 0;
	gunk.movetype = MOVETYPE_TOSS;
	gunk.nextthink = (time + 0.01);
	gunk.think = Spawn_Wraithgunk;
};
void () sbarrel_explode =
{
	self.takedamage = DAMAGE_NO;
	self.classname = "slime_barrel";
	T_RadiusDamage (self, self, 60, world);
	sound (self, CHAN_VOICE, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin_z = (self.origin_z + FL_MONSTER);
	slime_fly ();
	wraith_throws_gunk2 ();
	slime_fly ();
	if ((random () < 0.2))
	{
		ThrowGib ("progs/bartop.mdl", self.health);
		ThrowGib ("progs/slime.mdl", self.health);
	}
	ThrowGib ("progs/slime.mdl", self.health);
	ThrowGib ("progs/slime.mdl", self.health);
	WriteByte(4, 23);
	WriteByte(4, 3);
	WriteCoord(4, self.origin_x);
	WriteCoord(4, self.origin_y);
	WriteCoord(4, self.origin_z + 32);
	multicast(self.origin, TF_FLARE_OFF);
	BecomeExplosion ();
};
float (entity Top, entity bottom) IsOnTopOf =
{
	if ((Top.absmin_z < (bottom.absmax_z - 3)))
	{
		return (0);
	}
	if ((Top.absmin_z > (bottom.absmax_z + 2)))
	{
		return (0);
	}
	if ((Top.absmin_y > bottom.absmax_y))
	{
		return (0);
	}
	if ((Top.absmax_y < bottom.absmin_y))
	{
		return (0);
	}
	if ((Top.absmin_x > bottom.absmax_x))
	{
		return (0);
	}
	if ((Top.absmax_x < bottom.absmin_x))
	{
		return (0);
	}
	return (1);
};
void () misc_car =
{
	local float oldz;
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_STEP;
	precache_model ("progs/hummer.mdl");
	setmodel (self, "progs/hummer.mdl");
	setsize (self, '-29 -66 -15', '31 67 41');
	self.origin_z = (self.origin_z + FL_SWIM);
	oldz = self.origin_z;
	droptofloor ();
	if (((oldz - self.origin_z) > 250))
	{
		dprint ("misc_car fell out of level at ");
		dprint (vtos (self.origin));
		dprint ("\n");
		remove (self);
	}
};
void () misc_vend =
{
	local float oldz;
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_NONE;
	precache_model ("progs/frubble1.mdl");
	precache_model ("progs/frubble2.mdl");
	precache_model ("progs/frubble3.mdl");
	precache_model ("progs/vending.mdl");
	setmodel (self, "progs/vending.mdl");
	setsize (self, '-20 -27 -26', '20 29 60');
	precache_sound ("weapons/r_exp3.wav");
	self.health = 40;
	self.th_die = vend_blows;
	self.takedamage = DAMAGE_AIM;
	self.origin_z = (self.origin_z + FL_SWIM);
	oldz = self.origin_z;
	droptofloor ();
	if (((oldz - self.origin_z) > 250))
	{
		dprint ("vending machine fell out of level at ");
		dprint (vtos (self.origin));
		dprint ("\n");
		remove (self);
	}
};
void () misc_motel =
{
	precache_model ("progs/motel.mdl");
	setmodel (self, "progs/motel.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_SLIDEBOX;
};
void () misc_sign =
{
	precache_model ("progs/route.mdl");
	setmodel (self, "progs/route.mdl");
	setsize (self, VEC_HULL_MIN, '10 10 45');
	self.movetype = MOVETYPE_NONE;
	if ((self.frame == 0))
	{
		if ((self.cnt == 1))
		{
			self.solid = SOLID_TRIGGER;
		}
		else
		{
			self.solid = SOLID_SLIDEBOX;
		}
		return;
	}
	self.solid = SOLID_NOT;
};
void () misc_tree =
{
	if (!self.model)
	{
		self.model = "progs/tree1.mdl";
	}
	if ((self.model == "progs/tree1.mdl"))
	{
		self.frame = 0;
	}
	precache_model (self.model);
	setmodel (self, self.model);
	setsize (self, VEC_HULL_MIN, '10 10 45');
	self.movetype = MOVETYPE_NONE;
	if ((self.cnt == 1))
	{
		self.solid = SOLID_NOT;
	}
	else
	{
		self.solid = SOLID_SLIDEBOX;
	}
};
void () vend_blows =
{
	ThrowRubble ("progs/frubble1.mdl", self.health);
	ThrowRubble ("progs/frubble2.mdl", self.health);
	ThrowRubble ("progs/frubble1.mdl", self.health);
	ThrowRubble ("progs/frubble2.mdl", self.health);
	ThrowRubble ("progs/frubble3.mdl", self.health);
	BecomeExplosion ();
};
void () abyss_touch =
{
	if ((other.classname == "camera"))
	{
		return;
	}
	if ((other.classname == "player"))
	{
		return;
	}
	if (((other.solid == SOLID_SLIDEBOX) || (other.solid == SOLID_BBOX)))
	{
		remove (other);
	}
};
void () skubremove_touch =
{
	if ((other.classname == "player"))
	{
		return;
	}
	if ((other.solid == SOLID_BBOX))
	{
		if ((other.classname != "func_mindcrime"))
		{
			return;
		}
	}
	else
	{
		if ((other.solid != SOLID_SLIDEBOX))
		{
			return;
		}
	}
	SUB_UseTargets ();
	if ((self.spawnflags & FL_GODMODE))
	{
		spawn_tfog (other.origin);
	}
	dprint ("something removed via func_remove\n");
	remove (other);
};
void () func_remove =
{
	InitTrigger ();
	if (((self.spawnflags & FL_NOTARGET) || (world.model == "maps/nehend.bsp")))
	{
		self.touch = abyss_touch;
	}
	else
	{
		self.touch = skubremove_touch;
	}
};
void () misc_corpse =
{
	if (deathmatch)
	{
		remove (self);
		return;
	}
	self.soul = "yes";
	if ((self.cnt < 0))
	{
		self.cnt = 0;
	}
	if ((self.cnt < 5))
	{
		precache_model ("progs/player.mdl");
		setmodel (self, "progs/player.mdl");
	}
	else
	{
		if ((self.cnt < 7))
		{
			precache_model ("progs/soldier.mdl");
			setmodel (self, "progs/soldier.mdl");
		}
		else
		{
			if ((self.cnt < 9))
			{
				precache_model ("progs/mark3.mdl");
				setmodel (self, "progs/mark3.mdl");
			}
			else
			{
				objerror ("*cnt* of misc_corpse set to unsupported number\n");
			}
		}
	}
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;
	if ((self.cnt == 0))
	{
		self.frame = 60;
	}
	if ((self.cnt == 1))
	{
		self.frame = 69;
	}
	if ((self.cnt == 2))
	{
		self.frame = 84;
	}
	if ((self.cnt == 3))
	{
		self.frame = 93;
	}
	if ((self.cnt == 4))
	{
		self.frame = 102;
	}
	if ((self.cnt == 5))
	{
		self.frame = 17;
	}
	if ((self.cnt == 6))
	{
		self.frame = 28;
	}
	if ((self.cnt == 7))
	{
		self.frame = 22;
	}
	if ((self.cnt == 8))
	{
		self.frame = 85;
	}
	self.use = corpsesplat;
};
void () corpsesplat =
{
	if ((random () < 0.5))
	{
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
	}
	else
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NONE);
	}
	ThrowGib ("progs/gib1.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);
	ThrowHead ("progs/h_player.mdl", self.health);
	self.use = SUB_Null;
};
void () play_sound_looped =
{
	precache_sound (self.noise);
	if (((self.volume == 0) || (self.volume > 1)))
	{
		self.volume = 1;
	}
	if ((self.wait == 0))
	{
		bprint (2, "PLAY_SOUND_LOOPED, no 'wait' field set\n");
		remove (self);
		return;
	}
	if (self.targetname)
	{
		if ((self.cnt == 1))
		{
			self.use = start_loopsnd;
			return;
		}
		else
		{
			self.use = stop_loopsnd;
		}
	}
	self.think = playloopsnd;
	self.nextthink = (time + self.wait);
};
void () playloopsnd =
{
	sound (self, CHAN_AUTO, self.noise, self.volume, ATTN_IDLE);
	self.think = playloopsnd;
	self.nextthink = (time + self.cnt);
};
void () start_loopsnd =
{
	self.use = stop_loopsnd;
	playloopsnd ();
};
void () stop_loopsnd =
{
	self.use = start_loopsnd;
	self.think = SUB_Null;
	self.nextthink = (time + 9999);
};
void () misc_valve =
{
	precache_sound2 ("forge/turnme.wav");
	if (!self.target)
	{
		bprint ("MISC_VALVE NEEDS A TARGET\n");
	}
	precache_model ("progs/valve.mdl");
	setmodel (self, "progs/valve.mdl");
	self.movetype = MOVETYPE_NOCLIP;
	self.solid = SOLID_TRIGGER;
	self.frame = 0;
	self.cnt = 0;
	self.origin = (self.origin - '0 0 10');
	self.touch = valve_turn;
	setsize (self, '-16 -16 0', '16 16 56');
};
void () misc_fscreen =
{
	precache_sound2 ("forge/alarm.wav");
	precache_sound2 ("sets/set2_4.wav");
	precache_model ("progs/fscreen.mdl");
	setmodel (self, "progs/fscreen.mdl");
	setsize (self, VEC_HULL_MIN, '10 10 45');
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;
	self.use = fscreen_trigger1;
	self.think = fscreen_think;
	self.nextthink = (time + 1);
};
void () fscreen_think =
{
	if ((self.skin == 0))
	{
		self.skin = 1;
	}
	else
	{
		self.skin = 0;
	}
	self.think = fscreen_think;
	self.nextthink = (time + 1);
};
void () fscreen_trigger1 =
{
	SUB_UseTargets ();
	sound (self, CHAN_AUTO, "sets/set2_4.wav", 1, ATTN_NONE);
	self.use = fscreen_trigger2;
	self.think = fscreen_think2;
	self.nextthink = (time + 0.5);
};
void () fscreen_think2 =
{
	if ((self.skin == 3))
	{
		self.skin = 1;
	}
	else
	{
		self.skin = 3;
	}
	if ((self.pain_finished > time))
	{
		self.think = fscreen_think2;
		self.nextthink = (time + 0.5);
		return;
	}
	sound (self, CHAN_AUTO, "forge/alarm.wav", 1, ATTN_NORM);
	self.pain_finished = (time + 1);
	self.think = fscreen_think2;
	self.nextthink = (time + 0.5);
};
void () fscreen_trigger2 =
{
	self.use = SUB_Null;
	self.think = fscreen_error;
	self.nextthink = (time + 0.7);
};
void () fscreen_error =
{
	if ((self.skin == 1))
	{
		self.skin = 2;
	}
	else
	{
		self.skin = 1;
	}
	if ((self.pain_finished > time))
	{
		self.think = fscreen_error;
		self.nextthink = (time + 0.7);
		return;
	}
	sound (self, CHAN_AUTO, "forge/alarm.wav", 1, ATTN_NORM);
	self.pain_finished = (time + 1);
	self.think = fscreen_error;
	self.nextthink = (time + 0.7);
};
void () floating_gibs =
{
	precache_model ("progs/fgib1.mdl");
	precache_model ("progs/fgib2.mdl");
	precache_model ("progs/fgib3.mdl");
	self.cnt = 0;
	if ((self.delay < 1))
	{
		self.delay = 10;
	}
	if ((self.count < 1))
	{
		self.count = 3;
	}
	if (self.targetname)
	{
		self.use = trigger_gibs;
		return;
	}
	self.think = fgib_spawn;
	self.nextthink = (time + self.delay);
};
void () fgib_touch =
{
	if ((other.classname != "player"))
	{
		return;
	}
	self.velocity_x = (other.velocity_x + (10 * random ()));
	self.velocity_y = (other.velocity_y + (10 * random ()));
	if ((other.velocity_z < 0))
	{
		self.velocity_z = (other.velocity_z * 0.5);
	}
};
void (string gibname, float dm) spawn_fgib =
{
	local entity fgib;
	fgib = spawn ();
	fgib.origin = self.origin;
	setmodel (fgib, gibname);
	setsize (self, '-16 -16 0', '16 16 56');
	fgib.velocity = VelocityForDamage (dm);
	fgib.classname = "fgib";
	fgib.takedamage = DAMAGE_AIM;
	fgib.health = 20;
	fgib.avelocity_x = (random () * 3);
	fgib.avelocity_y = (random () * 3);
	fgib.avelocity_z = (random () * 3);
	fgib.movetype = MOVETYPE_FLYMISSILE;
	fgib.solid = SOLID_BBOX;
	fgib.touch = fgib_touch;
	fgib.think = fgib_think;
	fgib.nextthink = (time + 0.1);
	fgib.th_die = fgib_die;
	setorigin (fgib, self.origin);
};
void () fgib_think =
{
	local vector spot;
	local vector spot2;
	self.touch = fgib_touch;
	spot = self.origin + '0 0 4';
	spot2 = self.origin + '0 0 2';
	if ((pointcontents (spot) == CONTENT_EMPTY))
	{
		self.velocity_z = -10;
	}
	else
	{
		if ((((pointcontents (spot) == CONTENT_WATER) || (pointcontents (spot) == CONTENT_SLIME)) || (pointcontents (spot2) == CONTENT_SOLID)))
		{
			self.velocity_z = 10;
		}
		else
		{
			if ((pointcontents (spot) == CONTENT_EMPTY))
			{
				if (((pointcontents (spot2) == CONTENT_WATER) || (pointcontents (spot2) == CONTENT_SLIME)))
				{
					self.velocity_x = rint ((2 * random ()));
					self.velocity_y = rint ((2 * random ()));
					if ((random () < 0.5))
					{
						self.velocity_x = (self.velocity_x * -1);
					}
					else
					{
						self.velocity_y = (self.velocity_y * -1);
					}
					if ((self.velocity_z != 0))
					{
						self.velocity_z = 0;
					}
				}
			}
		}
	}
	if ((random () < 0.3))
	{
		self.angles_y = (self.angles_y - 1);
	}
	else
	{
		self.angles_y = (self.angles_y + 1);
	}
	SUB_NormalizeAngles (self.angles);
	self.think = fgib_think;
	self.nextthink = (time + 0.1);
};
void () qteleport_touch =
{
	local entity t;
	local vector org;
	if (self.targetname)
	{
		if ((self.nextthink < time))
		{
			return;
		}
	}
	if (((other.health <= 0) || (other.solid != SOLID_SLIDEBOX)))
	{
		return;
	}
	SUB_UseTargets ();
	t = find (world, targetname, self.target);
	if (!t)
	{
		objerror ("couldn't find target");
	}
	makevectors (t.mangle);
	org = t.origin + (FL_MONSTER * v_forward);
	spawn_tdeath (t.origin, other);
	if (!other.health)
	{
		other.origin = t.origin;
		other.velocity = ((v_forward * other.velocity_x) + (v_forward * other.velocity_y));
		return;
	}
	setorigin (other, t.origin);
	other.angles = t.mangle;
	if ((other.classname == "player"))
	{
		other.fixangle = 1;
		other.teleport_time = (time + 0.7);
		if ((other.flags & FL_ONGROUND))
		{
			other.flags = (other.flags - FL_ONGROUND);
		}
		other.velocity = (v_forward * 300);
	}
	other.flags = (other.flags - (other.flags & FL_ONGROUND));
};
void () trigger_qtele =
{
	InitTrigger ();
	self.touch = qteleport_touch;
	if (!self.target)
	{
		objerror ("no target");
	}
	self.use = teleport_use;
};
void () trigger_gibs =
{
	self.use = SUB_Null;
	self.think = fgib_spawn;
	self.nextthink = (time + self.delay);
};
void () fgib_spawn =
{
	local float t;
	t = random ();
	if ((t < 0.2))
	{
		spawn_fgib ("progs/fgib1.mdl", (random () * -100));
	}
	else
	{
		if ((t < 0.6))
		{
			spawn_fgib ("progs/fgib2.mdl", (random () * -100));
		}
		else
		{
			spawn_fgib ("progs/fgib3.mdl", (random () * -100));
		}
	}
	self.cnt = (self.cnt + 1);
	if ((self.cnt > self.count))
	{
		remove (self);
		return;
	}
	self.think = fgib_spawn;
	self.nextthink = (time + self.delay);
};
void () fgib_die =
{
	ThrowGib ("progs/zom_gib.mdl", self.health);
	ThrowGib ("progs/zom_gib.mdl", self.health);
	ThrowGib ("progs/zom_gib.mdl", self.health);
	remove (self);
};
void () Seekoutwall =
{
	local entity blah;
	blah = find (world, classname, "func_quakedmg");
	if ((blah == world))
	{
		return;
	}
	T_Damage (blah, self, self.owner, 7000);
};
vector (entity mark) Sub_CalcOrigin =
{
	local vector spot;
	spot = mark.absmin + ((mark.absmax - mark.absmin) * 0.5);
	return (spot);
};
void () light_swinging_lantern =
{
	precache_model ("progs/lantern.mdl");
	setmodel (self, "progs/lantern.mdl");
	FireAmbient ();
	makestatic (self);
};
void () light_candle_t =
{
	precache_model ("progs/candle_t.mdl");
	setmodel (self, "progs/candle_t.mdl");
	FireAmbient ();
	makestatic (self);
};
void () light_candle_w =
{
	precache_model ("progs/candle_w.mdl");
	setmodel (self, "progs/candle_w.mdl");
	FireAmbient ();
	makestatic (self);
};
void () light_candleth =
{
	precache_model ("progs/candleth.mdl");
	setmodel (self, "progs/candleth.mdl");
	FireAmbient ();
	makestatic (self);
};
void () light_candlews =
{
	precache_model ("progs/candlews.mdl");
	setmodel (self, "progs/candlews.mdl");
	FireAmbient ();
	makestatic (self);
};
void (entity monster) spawn_irritant =
{
	local entity head;
	head = spawn ();
	head.objekt = monster;
	head.think = irritate_monster;
	head.nextthink = (time + 0.2);
};
void () irritate_monster =
{
	self.objekt.enemy = find (world, classname, "player");
	if ((self.objekt.enemy != world))
	{
		T_Damage (self.objekt, self.objekt.enemy, self.objekt.enemy, 1);
		remove (self);
	}
	self.think = irritate_monster;
	self.nextthink = (time + 0.5);
};
float () borkfactor1 =
{
	if ((self.health < 1))
	{
		dprint ("borkfactor1: rare bug\n");
		self.th_die ();
		return (1);
	}
	return (0);
};
void () dead_stay_dead =
{
	self.th_stand = SUB_Null;
	self.th_walk = SUB_Null;
	self.th_run = SUB_Null;
	self.th_melee = SUB_Null;
	self.th_missile = SUB_Null;
	self.th_runfire = SUB_Null;
	self.th_die = SUB_Null;
	self.th_pain = SUB_Null;
	self.use = SUB_Null;
};
void () valve_turn =
{
	if ((other.classname != "player"))
	{
		return;
	}
	self.cnt = (self.cnt + 1);
	if ((self.cnt > 50))
	{
		SUB_UseTargets ();
		self.touch = SUB_Null;
		return;
	}
	self.origin_z = (self.origin_z + 0.2);
	self.frame = (self.frame + 1);
	if ((self.frame > 10))
	{
		self.frame = 0;
	}
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 0.3);
	sound (self, CHAN_AUTO, "forge/turnme.wav", 1, ATTN_NORM);
};
void () trigger_spawnmonster =
{
	if ((self.style == 1))
	{
		spawn_tfog (self.origin);
	}
	spawn_tdeath (self.origin, self);
};
void () BecomeExplosion2 =
{
	BecomeExplosion ();
};
void () BecomeExplosion3 =
{
	BecomeExplosion ();
};
// AI
void (float dist) ai_run_slide2 =
{
	local float ofs;
	movedist = dist;
	self.ideal_yaw = enemy_yaw;
	ChangeYaw ();
	if (self.lefty)
	{
		ofs = 90;
	}
	else
	{
		ofs = -90;
	}
	if (walkmove ((self.ideal_yaw + ofs), movedist))
	{
		return;
	}
	self.lefty = (1 - self.lefty);
	walkmove ((self.ideal_yaw - ofs), movedist);
	ai_face ();
};
void (float dist) id_run_slide =
{
	if (((self.enemy.angles_y > -30) && (self.enemy.angles_y < 20)))
	{
		walkmove ((self.angles_y + 180), dist);
		return;
	}
	if ((self.enemy.angles_y > 340))
	{
		movetogoal (dist);
	}
};
void () monster_swim =
{
	local float num;
	local vector start;
	local vector end;
	local entity head;
	local entity head2;
	local float t;
	local float num1;
	local float num2;
	makevectors (self.angles);
	if ((self.flags & FL_SWIM))
	{
		t = self.origin_z - self.enemy.origin_z;
		if ((t > 45))
		{
			t = 45;
		}
		if ((t < -45))
		{
			t = -45;
		}
		num1 = pointcontents (self.origin);
		num2 = pointcontents (self.enemy.origin);
		if ((self.classname != "fish"))
		{
			if ((num1 > CONTENT_WATER))
			{
				self.flags = (self.flags - FL_SWIM);
				self.angles_x = 0;
			}
			else
			{
				if ((num1 == num2))
				{
					self.angles_x = (t * -1);
				}
				else
				{
					if ((num2 > num1))
					{
						self.angles_x = 0;
						self.angles_z = 0;
					}
				}
			}
		}
		if (!walkmove (0, 0))
		{
			head = spawn ();
			head.origin = (self.origin - '0 0 600');
			head.think = SUB_Remove;
			head.nextthink = (time + 0.1);
			head2 = self.enemy;
			self.enemy = head;
			movetogoal (10);
			self.enemy = head2;
			return;
		}
	}
	if (!(self.flags & FL_ONGROUND))
	{
		if ((self.flags & FL_WATERJUMP))
		{
			self.velocity = ((v_forward * 20) + '0 0 300');
			self.flags = (self.flags - FL_WATERJUMP);
		}
		else
		{
			if ((pointcontents ((self.origin - '0 0 50')) < CONTENT_SOLID))
			{
				num = self.velocity_z;
				self.velocity = (v_forward * 20);
				self.velocity_z = (num * 1.1);
			}
		}
	}
	if ((pointcontents (self.origin) < CONTENT_SOLID))
	{
		self.flags = (self.flags | FL_SWIM);
	}
	else
	{
		if ((self.flags & FL_SWIM))
		{
			self.flags = (self.flags - FL_SWIM);
			return;
		}
	}
	makevectors (self.angles);
	start = self.origin;
	start_z = start_z + FL_CLIENT;
	v_forward_z = 0;
	normalize (v_forward);
	end = start + (v_forward * 24);
	traceline (start, end, 1, self);
	if ((trace_fraction < 1))
	{
		start_z = (start_z + self.maxs_z) - FL_CLIENT;
		end = start + (v_forward * 24);
		self.movedir = (trace_plane_normal * -50);
		traceline (start, end, 1, self);
		if ((trace_fraction == 1))
		{
			self.flags = (self.flags - FL_SWIM);
			self.flags = (self.flags | FL_WATERJUMP);
			self.velocity_z = 300;
			self.angles_x = 0;
			self.teleport_time = (time + FL_SWIM);
		}
	}
};
//END