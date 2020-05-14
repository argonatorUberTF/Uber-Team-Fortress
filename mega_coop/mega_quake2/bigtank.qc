$cd /raid/quake/id1/models/tank3
$origin 0 -24 24
$base base
$skin skin
$frame stand01 stand02 stand03 stand04 stand05 stand06 stand07 stand08
$frame stand09 stand10 stand11 stand12 stand13 stand14 stand15 
$frame walk01 walk02 walk03 walk04 walk05 walk06 walk07 walk08 walk09
$frame walk10 walk11 walk12 walk13 walk14 walk15 walk16 walk17
$frame triarm01 triarm02 triarm03 triarm04 triarm05 triarm06 triarm07 triarm08 triarm09
$frame triarm10 triarm11 triarm12 triarm13 triarm14 triarm15 triarm16 triarm17 triarm18
$frame triarm19 triarm20 triarm21
$frame hammer01 hammer02 hammer03 hammer04 hammer05 hammer06 hammer07 hammer08 hammer09
$frame hammer10 hammer11 hammer12 hammer13 hammer14 hammer15 hammer16 hammer17 hammer18
$frame hammer19 hammer20 hammer21 hammer22 hammer23 hammer24 hammer25 hammer26 hammer27
$frame hammer28 hammer29 hammer30 hammer31 hammer32 hammer33 hammer34 hammer35 hammer36
$frame hammer37
$frame launch01 launch02 launch03 launch04 launch05 launch06 launch07 launch08 launch09
$frame launch10 launch11 launch12 launch13 launch14 launch15 launch16 launch17 launch18
$frame launch19 launch20 launch21 launch22 launch23 launch24 launch25 launch26 launch27
$frame launch28 launch29 launch30 launch31 launch32 launch33 launch34 launch35 launch36
$frame launch37 launch38 launch39 launch40 launch41 launch42 launch43 launch44 launch45
$frame launch46 launch47 launch48 launch49 launch50 launch51 launch52 launch53 launch54
$frame sweep01 sweep02 sweep03 sweep04 sweep05 sweep06 sweep07 sweep08 sweep09
$frame sweep10 sweep11 sweep12 sweep13 sweep14 sweep15 sweep16 sweep17 sweep18
$frame sweep19 sweep20 sweep21 sweep22 sweep23 sweep24 sweep25 sweep26 sweep27
$frame sweep28 sweep29 
$frame pain101 pain102 pain103 pain104
$frame pain201 pain202 pain203 pain204 pain205
$frame pain301 pain302 pain303 pain304 pain305 pain306 pain307 pain308
$frame pain309 pain310 pain311 pain312 pain313 pain314 pain315 pain316
$frame death101 death102 death103 death104 death105 death106 death107 death108
$frame death109 death110 death111 death112 death113 death114 death115 death116
$frame death117 death118 death119 death120 death121 death122 death123 death124
$frame death125 death126 death127 death128 death129 death130 death131 death132
void()  bigtank_stand1     =[      $stand01,        bigtank_stand2     ] {COOP_Idle();
if(self.ltime < time)
 {
  sound (self, CHAN_VOICE, "bigtank/tnkidle1.wav", 0.5, ATTN_NORM);
  self.ltime = time + 2.8;
 }
};
void()  bigtank_stand2     =[      $stand02,        bigtank_stand3     ] {COOP_Idle();};
void()  bigtank_stand3     =[      $stand03,        bigtank_stand4     ] {COOP_Idle();};
void()  bigtank_stand4     =[      $stand04,        bigtank_stand5     ] {COOP_Idle();};
void()  bigtank_stand5     =[      $stand05,        bigtank_stand6     ] {COOP_Idle();};
void()  bigtank_stand6     =[      $stand06,        bigtank_stand7     ] {COOP_Idle();};
void()  bigtank_stand7     =[      $stand07,        bigtank_stand8     ] {COOP_Idle();};
void()  bigtank_stand8     =[      $stand08,        bigtank_stand9     ] {COOP_Idle();};
void()  bigtank_stand9     =[      $stand09,        bigtank_stand10    ] {COOP_Idle();};
void()  bigtank_stand10    =[      $stand10,        bigtank_stand11    ] {COOP_Idle();};
void()  bigtank_stand11    =[      $stand11,        bigtank_stand12    ] {COOP_Idle();};
void()  bigtank_stand12    =[      $stand12,        bigtank_stand13    ] {COOP_Idle();};
void()  bigtank_stand13    =[      $stand13,        bigtank_stand14    ] {COOP_Idle();};
void()  bigtank_stand14    =[      $stand14,        bigtank_stand15    ] {COOP_Idle();};
void()  bigtank_stand15    =[      $stand15,        bigtank_stand1     ] {COOP_Idle();};
void()  bigtank_walk1      =[      $walk01, bigtank_walk2] {COOP_Walk(6);sound (self, CHAN_VOICE, "bigtank/step.wav", 1, ATTN_IDLE);};
void()  bigtank_walk2      =[      $walk02, bigtank_walk3] {COOP_Walk(5);};
void()  bigtank_walk3      =[      $walk03, bigtank_walk4] {COOP_Walk(4);};
void()  bigtank_walk4      =[      $walk04, bigtank_walk5] {COOP_Walk(3);};
void()  bigtank_walk5      =[      $walk05, bigtank_walk6] {COOP_Walk(2);};
void()  bigtank_walk6      =[      $walk06, bigtank_walk7] {COOP_Walk(6);};
void()  bigtank_walk7      =[      $walk07, bigtank_walk8] {COOP_Walk(5);};
void()  bigtank_walk8      =[      $walk08, bigtank_walk9] {COOP_Walk(4);};
void()  bigtank_walk9      =[      $walk09, bigtank_walk10] {COOP_Walk(3);sound (self, CHAN_VOICE, "bigtank/step.wav", 1, ATTN_IDLE);};
void()  bigtank_walk10     =[      $walk10, bigtank_walk11] {COOP_Walk(2);};
void()  bigtank_walk11     =[      $walk11, bigtank_walk12] {COOP_Walk(6);};
void()  bigtank_walk12     =[      $walk12, bigtank_walk13] {COOP_Walk(5);};
void()  bigtank_walk13     =[      $walk13, bigtank_walk14] {COOP_Walk(4);};
void()  bigtank_walk14     =[      $walk14, bigtank_walk15] {COOP_Walk(3);};
void()  bigtank_walk15     =[      $walk15, bigtank_walk16] {COOP_Walk(2);};
void()  bigtank_walk16     =[      $walk16, bigtank_walk17] {COOP_Walk(6);};
void()  bigtank_walk17     =[      $walk17, bigtank_walk1] {COOP_Walk(5);};
void()  bigtank_run1      =[      $walk01, bigtank_run2] {COOP_Run(6);};
void()  bigtank_run2      =[      $walk02, bigtank_run3] {COOP_Run(5);};
void()  bigtank_run3      =[      $walk03, bigtank_run4] {COOP_Run(4);};
void()  bigtank_run4      =[      $walk04, bigtank_run5] {COOP_Run(3);};
void()  bigtank_run5      =[      $walk05, bigtank_run6] {COOP_Run(2);};
void()  bigtank_run6      =[      $walk06, bigtank_run7] {COOP_Run(6);};
void()  bigtank_run7      =[      $walk07, bigtank_run8] {COOP_Run(5);};
void()  bigtank_run8      =[      $walk08, bigtank_run9] {COOP_Run(4);};
void()  bigtank_run9      =[      $walk09, bigtank_run10] {COOP_Run(3);};
void()  bigtank_run10     =[      $walk10, bigtank_run11] {COOP_Run(2);sound (self, CHAN_VOICE, "bigtank/step.wav", 1, ATTN_IDLE);};
void()  bigtank_run11     =[      $walk11, bigtank_run12] {COOP_Run(6);};
void()  bigtank_run12     =[      $walk12, bigtank_run13] {COOP_Run(5);};
void()  bigtank_run13     =[      $walk13, bigtank_run14] {COOP_Run(4);};
void()  bigtank_run14     =[      $walk14, bigtank_run15] {COOP_Run(3);};
void()  bigtank_run15     =[      $walk15, bigtank_run16] {COOP_Run(2);};
void()  bigtank_run16     =[      $walk16, bigtank_run17] {COOP_Run(6);};
void()  bigtank_run17     =[      $walk17, bigtank_run1] {COOP_Run(5);sound (self, CHAN_VOICE, "bigtank/step.wav", 1, ATTN_IDLE);};
void(float attype, float off) bigtank_fire;
void()  bigtank_gatk1       =[ $triarm01, bigtank_gatk2  ] {COOP_Turn();};
void()  bigtank_gatk2       =[ $triarm02, bigtank_gatk3  ] {COOP_Turn();};
void()  bigtank_gatk3       =[ $triarm03, bigtank_gatk4  ] {COOP_Turn();};
void()  bigtank_gatk4       =[ $triarm04, bigtank_gatk5  ] {COOP_Turn();};
void()  bigtank_gatk5       =[ $triarm05, bigtank_gatk6  ] {COOP_Turn();};
void()  bigtank_gatk6       =[ $triarm06, bigtank_gatk7  ] {COOP_Turn();};
void()  bigtank_gatk7       =[ $triarm07, bigtank_gatk8  ] {COOP_Turn();};
void()  bigtank_gatk8       =[ $triarm08, bigtank_gatk9  ] {COOP_Turn();};
void()  bigtank_gatk9       =[ $triarm09, bigtank_gatk10 ] {COOP_Turn();};
void()  bigtank_gatk10      =[ $triarm10, bigtank_gatk11 ] {COOP_Turn();bigtank_fire(3, 0);};  // was 0 ratbert
void()  bigtank_gatk11      =[ $triarm11, bigtank_gatk12 ] {COOP_Turn();};
void()  bigtank_gatk12      =[ $triarm12, bigtank_gatk13 ] {COOP_Turn();SUB_CheckRefire(bigtank_gatk9);};
void()  bigtank_gatk13      =[ $triarm13, bigtank_gatk14 ] {COOP_Turn();};
void()  bigtank_gatk14      =[ $triarm14, bigtank_gatk15 ] {COOP_Turn();};
void()  bigtank_gatk15      =[ $triarm15, bigtank_gatk16 ] {COOP_Turn();};
void()  bigtank_gatk16      =[ $triarm16, bigtank_gatk17 ] {COOP_Turn();};
void()  bigtank_gatk17      =[ $triarm17, bigtank_gatk18 ] {COOP_Turn();};
void()  bigtank_gatk18      =[ $triarm18, bigtank_gatk19 ] {COOP_Turn();};
void()  bigtank_gatk19      =[ $triarm19, bigtank_gatk20 ] {COOP_Turn();};
void()  bigtank_gatk20      =[ $triarm20, bigtank_gatk21 ] {COOP_Turn();};
void()  bigtank_gatk21      =[ $triarm21, bigtank_run1 ] {COOP_Turn();};
void()  bigtank_fatk1       =[ $sweep01, bigtank_fatk2  ] {COOP_Turn();};
void()  bigtank_fatk2       =[ $sweep02, bigtank_fatk3  ] {COOP_Turn();};
void()  bigtank_fatk3       =[ $sweep03, bigtank_fatk4  ] {COOP_Turn();};
void()  bigtank_fatk4       =[ $sweep04, bigtank_fatk5  ] {COOP_Turn();};
void()  bigtank_fatk5       =[ $sweep05, bigtank_fatk6  ] {COOP_Turn();bigtank_fire(1, 5);};
void()  bigtank_fatk6       =[ $sweep06, bigtank_fatk7  ] {COOP_Turn();bigtank_fire(1, 4);};
void()  bigtank_fatk7       =[ $sweep07, bigtank_fatk8  ] {COOP_Turn();bigtank_fire(1, 3);};
void()  bigtank_fatk8       =[ $sweep08, bigtank_fatk9  ] {COOP_Turn();bigtank_fire(1, 2);};
void()  bigtank_fatk9       =[ $sweep09, bigtank_fatk10 ] {COOP_Turn();bigtank_fire(1, 1);};
void()  bigtank_fatk10      =[ $sweep10, bigtank_fatk11 ] {COOP_Turn();bigtank_fire(1, 0);};
void()  bigtank_fatk11      =[ $sweep11, bigtank_fatk12 ] {COOP_Turn();bigtank_fire(1, -1);};
void()  bigtank_fatk12      =[ $sweep12, bigtank_fatk13 ] {COOP_Turn();bigtank_fire(1, -2);};
void()  bigtank_fatk13      =[ $sweep13, bigtank_fatk14 ] {COOP_Turn();bigtank_fire(1, -3);};
void()  bigtank_fatk14      =[ $sweep14, bigtank_fatk15 ] {COOP_Turn();bigtank_fire(1, -4);};
void()  bigtank_fatk15      =[ $sweep15, bigtank_fatk16 ] {COOP_Turn();bigtank_fire(1, -5);};
void()  bigtank_fatk16      =[ $sweep16, bigtank_fatk17 ] {COOP_Turn();bigtank_fire(1, -4);};
void()  bigtank_fatk17      =[ $sweep17, bigtank_fatk18 ] {COOP_Turn();bigtank_fire(1, -3);};
void()  bigtank_fatk18      =[ $sweep18, bigtank_fatk19 ] {COOP_Turn();bigtank_fire(1, -2);};
void()  bigtank_fatk19      =[ $sweep19, bigtank_fatk20 ] {COOP_Turn();bigtank_fire(1, -1);};
void()  bigtank_fatk20      =[ $sweep20, bigtank_fatk21 ] {COOP_Turn();bigtank_fire(1, 0);};
void()  bigtank_fatk21      =[ $sweep21, bigtank_fatk22 ] {COOP_Turn();bigtank_fire(1, 1);};
void()  bigtank_fatk22      =[ $sweep22, bigtank_fatk23 ] {COOP_Turn();bigtank_fire(1, 2);};
void()  bigtank_fatk23      =[ $sweep23, bigtank_fatk24 ] {COOP_Turn();bigtank_fire(1, 3);};
void()  bigtank_fatk24      =[ $sweep24, bigtank_fatk25 ] {COOP_Turn();bigtank_fire(1, 4);SUB_CheckRefire(bigtank_fatk5);};
void()  bigtank_fatk25      =[ $sweep25, bigtank_fatk26 ] {COOP_Turn();};
void()  bigtank_fatk26      =[ $sweep26, bigtank_fatk27 ] {COOP_Turn();};
void()  bigtank_fatk27      =[ $sweep27, bigtank_fatk28 ] {COOP_Turn();};
void()  bigtank_fatk28      =[ $sweep28, bigtank_fatk29 ] {COOP_Turn();};
void()  bigtank_fatk29      =[ $sweep29, bigtank_run1 ] {COOP_Turn();};
void()  bigtank_ratk1       =[ $launch01, bigtank_ratk2 ] {COOP_Turn();};
void()  bigtank_ratk2       =[ $launch02, bigtank_ratk3 ] {COOP_Turn();};
void()  bigtank_ratk3       =[ $launch03, bigtank_ratk4 ] {COOP_Turn();};
void()  bigtank_ratk4       =[ $launch04, bigtank_ratk5 ] {COOP_Turn();};
void()  bigtank_ratk5       =[ $launch05, bigtank_ratk6 ] {COOP_Turn();};
void()  bigtank_ratk6       =[ $launch06, bigtank_ratk7 ] {COOP_Turn();};
void()  bigtank_ratk7       =[ $launch07, bigtank_ratk8 ] {COOP_Turn();};
void()  bigtank_ratk8       =[ $launch08, bigtank_ratk9 ] {COOP_Turn();};
void()  bigtank_ratk9       =[ $launch09, bigtank_ratk10 ] {COOP_Turn();};
void()  bigtank_ratk10      =[ $launch10, bigtank_ratk11 ] {COOP_Turn();};
void()  bigtank_ratk11      =[ $launch11, bigtank_ratk12 ] {COOP_Turn();};
void()  bigtank_ratk12      =[ $launch12, bigtank_ratk13 ] {COOP_Turn();};
void()  bigtank_ratk13      =[ $launch13, bigtank_ratk14 ] {COOP_Turn();};
void()  bigtank_ratk14      =[ $launch14, bigtank_ratk15 ] {COOP_Turn();};
void()  bigtank_ratk15      =[ $launch15, bigtank_ratk16 ] {COOP_Turn();};
void()  bigtank_ratk16      =[ $launch16, bigtank_ratk17 ] {COOP_Turn();};
void()  bigtank_ratk17      =[ $launch17, bigtank_ratk18 ] {COOP_Turn();};
void()  bigtank_ratk18      =[ $launch18, bigtank_ratk19 ] {COOP_Turn();};
void()  bigtank_ratk19      =[ $launch19, bigtank_ratk20 ] {COOP_Turn();};
void()  bigtank_ratk20      =[ $launch20, bigtank_ratk21 ] {COOP_Turn();};
void()  bigtank_ratk21      =[ $launch21, bigtank_ratk22 ] {COOP_Turn();};
void()  bigtank_ratk22      =[ $launch22, bigtank_ratk23 ] {COOP_Turn();};
void()  bigtank_ratk23      =[ $launch23, bigtank_ratk24 ] {COOP_Turn();};
void()  bigtank_ratk24      =[ $launch24, bigtank_ratk25 ] {COOP_Turn();};
void()  bigtank_ratk25      =[ $launch25, bigtank_ratk26 ] {COOP_Turn();bigtank_fire(2, 0);};
void()  bigtank_ratk26      =[ $launch26, bigtank_ratk27 ] {COOP_Turn();};
void()  bigtank_ratk27      =[ $launch27, bigtank_ratk28 ] {COOP_Turn();};
void()  bigtank_ratk28      =[ $launch28, bigtank_ratk29 ] {COOP_Turn();bigtank_fire(2, 0);};
void()  bigtank_ratk29      =[ $launch29, bigtank_ratk30 ] {COOP_Turn();};
void()  bigtank_ratk30      =[ $launch30, bigtank_ratk31 ] {COOP_Turn();};
void()  bigtank_ratk31      =[ $launch31, bigtank_ratk32 ] {COOP_Turn();bigtank_fire(2, 0);};
void()  bigtank_ratk32      =[ $launch32, bigtank_ratk33 ] {COOP_Turn();};
void()  bigtank_ratk33      =[ $launch33, bigtank_ratk34 ] {COOP_Turn();};
void()  bigtank_ratk34      =[ $launch34, bigtank_ratk35 ] {COOP_Turn();};
void()  bigtank_ratk35      =[ $launch35, bigtank_ratk36 ] {COOP_Turn();};
void()  bigtank_ratk36      =[ $launch36, bigtank_ratk37 ] {COOP_Turn();};
void()  bigtank_ratk37      =[ $launch37, bigtank_ratk38 ] {COOP_Turn();};
void()  bigtank_ratk38      =[ $launch38, bigtank_ratk39 ] {COOP_Turn();};
void()  bigtank_ratk39      =[ $launch39, bigtank_ratk40 ] {COOP_Turn();};
void()  bigtank_ratk40      =[ $launch40, bigtank_ratk41 ] {COOP_Turn();};
void()  bigtank_ratk41      =[ $launch41, bigtank_ratk42 ] {COOP_Turn();};
void()  bigtank_ratk42      =[ $launch42, bigtank_ratk43 ] {COOP_Turn();SUB_CheckRefire(bigtank_ratk18);};
void()  bigtank_ratk43      =[ $launch43, bigtank_ratk44 ] {COOP_Turn();};
void()  bigtank_ratk44      =[ $launch44, bigtank_ratk45 ] {COOP_Turn();};
void()  bigtank_ratk45      =[ $launch45, bigtank_ratk46 ] {COOP_Turn();};
void()  bigtank_ratk46      =[ $launch46, bigtank_ratk47 ] {COOP_Turn();};
void()  bigtank_ratk47      =[ $launch47, bigtank_ratk48 ] {COOP_Turn();};
void()  bigtank_ratk48      =[ $launch48, bigtank_ratk49 ] {COOP_Turn();};
void()  bigtank_ratk49      =[ $launch49, bigtank_ratk50 ] {COOP_Turn();};
void()  bigtank_ratk50      =[ $launch50, bigtank_ratk51 ] {COOP_Turn();};
void()  bigtank_ratk51      =[ $launch51, bigtank_ratk52 ] {COOP_Turn();};
void()  bigtank_ratk52      =[ $launch52, bigtank_ratk53 ] {COOP_Turn();};
void()  bigtank_ratk53      =[ $launch53, bigtank_ratk54 ] {COOP_Turn();};
void()  bigtank_ratk54      =[ $launch54, bigtank_run1 ] {COOP_Turn();};
void()  bigtank_pain1      =[      $pain101,         bigtank_pain2      ] {};
void()  bigtank_pain2      =[      $pain102,         bigtank_pain3      ] {};
void()  bigtank_pain3      =[      $pain103,         bigtank_pain4      ] {};
void()  bigtank_pain4      =[      $pain104,         bigtank_run5      ] {};
void()  bigtank_painb1      =[      $pain201,         bigtank_painb2      ] {};
void()  bigtank_painb2      =[      $pain202,         bigtank_painb3      ] {};
void()  bigtank_painb3      =[      $pain203,         bigtank_painb4      ] {};
void()  bigtank_painb4      =[      $pain204,         bigtank_painb5      ] {};
void()  bigtank_painb5      =[      $pain205,         bigtank_run5      ] {};
void()  bigtank_painc1=[   $pain301,       bigtank_painc2     ] {};
void()  bigtank_painc2=[   $pain302,       bigtank_painc3     ] {};
void()  bigtank_painc3=[   $pain303,       bigtank_painc4     ] {};
void()  bigtank_painc4=[   $pain304,       bigtank_painc5     ] {};
void()  bigtank_painc5=[   $pain305,       bigtank_painc6     ] {};
void()  bigtank_painc6=[   $pain306,       bigtank_painc7     ] {};
void()  bigtank_painc7=[   $pain307,       bigtank_painc8     ] {};
void()  bigtank_painc8=[   $pain308,       bigtank_painc9     ] {};
void()  bigtank_painc9=[   $pain309,       bigtank_painc10] {};
void()  bigtank_painc10=[  $pain310,       bigtank_painc11] {};
void()  bigtank_painc11=[  $pain311,       bigtank_painc12] {};
void()  bigtank_painc12=[  $pain312,       bigtank_painc13] {ai_pain(2);};
void()  bigtank_painc13=[  $pain313,       bigtank_painc14] {};
void()  bigtank_painc14=[  $pain314,       bigtank_painc15] {};
void()  bigtank_painc15=[  $pain315,       bigtank_painc16] {};
void()  bigtank_painc16=[  $pain316,       bigtank_run5       ] {};
void()  bigtank_die1      =[      $death101,       bigtank_die2      ] {};
void()  bigtank_die2      =[      $death102,       bigtank_die3      ] {ai_back(5);};
void()  bigtank_die3      =[      $death103,       bigtank_die4      ] {};
void()  bigtank_die4      =[      $death104,       bigtank_die5      ] {ai_back(13);};
void()  bigtank_die5      =[      $death105,       bigtank_die6      ] {ai_back(3);};
void()  bigtank_die6      =[      $death106,       bigtank_die7      ] {ai_back(4);};
void()  bigtank_die7      =[      $death107,       bigtank_die8      ] {};
void()  bigtank_die8      =[      $death108,       bigtank_die9      ] {};
void()  bigtank_die9      =[      $death109,       bigtank_die10     ] {};
void()  bigtank_die10     =[      $death110,       bigtank_die11     ] {};
void()  bigtank_die11     =[      $death111,       bigtank_die12     ] {};
void()  bigtank_die12     =[      $death112,       bigtank_die13     ] {};
void()  bigtank_die13     =[      $death113,       bigtank_die14     ] {};
void()  bigtank_die14     =[      $death114,       bigtank_die15     ] {};
void()  bigtank_die15     =[      $death115,       bigtank_die16     ] {};
void()  bigtank_die16     =[      $death116,       bigtank_die17     ] {};
void()  bigtank_die17     =[      $death117,       bigtank_die18     ] {};
void()  bigtank_die18     =[      $death118,       bigtank_die19     ] {};
void()  bigtank_die19     =[      $death119,       bigtank_die20     ] {};
void()  bigtank_die20     =[      $death120,       bigtank_die21     ] {};
void()  bigtank_die21     =[      $death121,       bigtank_die22     ] {};
void()  bigtank_die22     =[      $death122,       bigtank_die23     ] {};
void()  bigtank_die23     =[      $death123,       bigtank_die24     ] {};
void()  bigtank_die24     =[      $death124,       bigtank_die25     ] {};
void()  bigtank_die25     =[      $death125,       bigtank_die26     ] {};
void()  bigtank_die26     =[      $death126,       bigtank_die27     ] {};
void()  bigtank_die27     =[      $death127,       bigtank_die28     ] {self.solid = SOLID_NOT; ai_back(4);};
void()  bigtank_die28     =[      $death128,       bigtank_die29     ] {};
void()  bigtank_die29     =[      $death129,       bigtank_die30     ] {};
void()  bigtank_die30     =[      $death130,       bigtank_die31     ] {};
void()  bigtank_die31     =[      $death131,       bigtank_die32     ] {sound (self, CHAN_VOICE, "bigtank/thud.wav", 1, ATTN_NORM);};
void()  bigtank_die32     =[      $death132,       bigtank_die32     ] {MonsterCorpse();};
void(entity attacker, float damage)     bigtank_pain =
{
	local float r;
	if (self.health <= 0)
		return;         // allready dying, don't go into pain frame
	if(self.health < 1000) { self.skin = 1; }
		if (random()*400 > damage)
			return;         // didn't flinch
	if (self.pain_finished > time)
		return;
	r = random();
	if (r < 0.2)
	{
		self.pain_finished = time + 2;
		bigtank_pain1 ();
		sound (self, CHAN_VOICE, "bigtank/pain.wav", 1, ATTN_NORM);
	}
	else if (r < 0.6)
	{
		self.pain_finished = time + 2;
		bigtank_painb1 ();
		sound (self, CHAN_VOICE, "bigtank/pain.wav", 1, ATTN_NORM);
	}
	else
	{
		self.pain_finished = time + 2;
		bigtank_painc1 ();
		sound (self, CHAN_VOICE, "bigtank/tnkpain2.wav", 1, ATTN_NORM);
	}
};
void(vector org, float damage, float dt, string ctyp) BigTankFireGrenade =
{
	local	entity missile;
	muzzleflash ();
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	makevectors (self.angles);
	missile.velocity = normalize(self.enemy.origin - org);
	missile.velocity = missile.velocity * 600;
	missile.velocity_z = missile.velocity_z + 200;
	missile.avelocity = '300 300 300';
	missile.angles = vectoangles(missile.velocity);
	missile.classname = ctyp;
    missile.touch = GrenadeTouch;
	missile.nextthink = time + 2.5;
	missile.think = GrenadeExplode;
	setmodel (missile, "progs/grenade.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
	setorigin (missile, org);
};
void() TankFireBombKaboom =
{
	local entity e;
	if(pointcontents(self.origin) == CONTENT_SOLID || /*self.cnt >= self.ccnt ||*/ !walkmove(self.old_movetype, 50))
	{
		GrenadeExplode();
		return;
	}
	if(pointcontents(self.origin) == CONTENT_SKY)
		 remove(self);
	self.cnt = self.cnt + 1;
	sound(self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.nextthink = time + 0.2;
	self.think = TankFireBombKaboom;
	T_RadiusDamage (self, self.owner, self.dmg, self.owner);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	e = spawn();
	setorigin(e, self.origin);
	e.think = BecomeExplosion;
	e.nextthink = time + 0.01;
};
void(vector org, float dir) bigtank_groundcrash =
{
	newmis = spawn();
	newmis.solid = SOLID_NOT;
	newmis.takedamage = DAMAGE_NO;
	newmis.movetype = MOVETYPE_STEP;
	setorigin(newmis, org);
	setsize(newmis, VEC_ORIGIN, VEC_ORIGIN);
	newmis.old_movetype = dir;
	newmis.owner = self;
	newmis.enemy = self;
	newmis.dmg =  99;
	newmis.classname = "grenade";
	newmis.touch = SUB_Null;
	newmis.think = TankFireBombKaboom;
	newmis.nextthink = time + 0.2;
};
void(vector org, vector dir) testlaunch_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.touch = sham_Flamer_stream_touch;//sham_Napalm_touch;
	newmis.classname = "flame";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN); 	
	setorigin (newmis, org);
	newmis.velocity = dir * 2000; // WK was 1000
};
void(float offset, vector orgn) bigtank_fireflame =
{
	local	vector	offang;
	local	vector	vec;
	offang = vectoangles (self.enemy.origin - self.origin);
	offang_y = offang_y + offset * 6;
	makevectors (offang);
	vec = normalize (v_forward);
	vec_z = 0 - vec_z + (random() - 0.5)*0.1;
	 testlaunch_spike (orgn, vec);
	newmis.classname = "flamespike";
	precache_model2("progs/medexp.spr");
	setmodel (newmis, "progs/medexp.spr");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	newmis.velocity = vec*300;
	sound (self, CHAN_WEAPON, "hknight/attack1.wav", 1, ATTN_NORM);
	 newmis.think = s2_explode1;
	 newmis.nextthink = time + 0.1;
	 newmis.effects = newmis.effects | EF_DIMLIGHT;
};
void(vector org) bigtank_rocket =
{
	local vector dir;
	local entity en;
	en = self.enemy;
	dir = en.origin - en.velocity*0.2;
	dir = normalize (dir - org);
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	launch_spike(org, dir);
	newmis.classname = "missile";
	newmis.enemy = self.enemy;
	newmis.velocity = dir * 1400;	
	setmodel(newmis, "progs/missile.mdl");
	setsize(newmis, '0 0 0', '0 0 0');
	newmis.nextthink = time + 6;
	newmis.think = SUB_Remove;
	newmis.touch = T_MissileTouch; //GrenadeExplode;
};
void(float attype, float off) bigtank_fire =
{
	local vector org, dir;
	local entity en;
	makevectors(self.angles);
	en = self.enemy;
	dir = en.origin - en.velocity*0.2;
	dir = normalize (dir - self.origin);
		org = self.origin + v_forward * 20 + v_right * -20 + '0 0 16';
		if (attype == 1)
		{
			  org = self.origin + v_forward * 16 + v_right * 20 + '0 0 24';
			  bigtank_fireflame(off, org);
		}
		else
		if (attype == 2)
		{
			org = self.origin + v_forward * 16 + v_right * 24 + '0 0 48';
			bigtank_rocket(org);
		}
		else if (attype == 3)
		{
			org = self.origin + v_forward * 16 + v_right * -24 + '0 0 -22';
			bigtank_groundcrash(org, self.angles_y);
		}
};
void() bigtank_decfire =
{
		  local float d;
		local float r;
		r = random();
		d = vlen (self.enemy.origin - self.origin);
		if ((d > 300 && d < 400 && (self.enemy.origin_z > self.origin_z)) || d < 120)
		{
			bigtank_fatk1();
		}
		else if((d < 400 && d > 120) || ((d < 600 && d > 90) && self.enemy.origin_z < self.origin_z))
		{
			bigtank_gatk1();
		}
		else
		{
			bigtank_ratk1();
		}
};
void() bigtank_die =
{
	DropPowerBackPack(2);
	if (self.health < -40)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowGibC("progs/gib3.mdl", -40, TRUE, 0, GIB1_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -80, TRUE, 0, GIB2_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -40, TRUE, 0, GIB3_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -80, TRUE, 0, GIB1_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -40, TRUE, 0, GIB2_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -80, TRUE, 0, GIB3_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -40, TRUE, 0, GIB1_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -80, TRUE, 0, GIB2_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -40, TRUE, 0, GIB3_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -80, TRUE, 0, GIB1_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -40, TRUE, 0, GIB2_KGS, FALSE);
		ThrowGibC("progs/gib3.mdl", -80, TRUE, 0, GIB3_KGS, FALSE);
		remove (self);
		return;
	}
	sound (self, CHAN_VOICE, "bigtank/death.wav", 1, ATTN_NORM);
	bigtank_die1 ();
};
//END