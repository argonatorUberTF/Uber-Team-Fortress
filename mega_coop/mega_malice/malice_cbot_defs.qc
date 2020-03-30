float SEARCH    = 2;
float CAMPER    = 4;
float WITHDRAW    = 8;
float OTFATTACK    = 16;
float ATTACK    = 32;
float JUMP    = 64;
float modelindex_eyes/*    = 0*/;
float modelindex_player;
float cbotnum;
.float goal_status;
.float botmode;
.entity origin_save;
.string oldgoalname;
.vector old_posn;
.float watchdog_time;
.float prioritise_time;
.float other_item_time;
.float camp_time;
//.float blasttime;  //unused -arg
.float sighted_time;
//.float ideal_pitch; //unused -arg
.float pi1;
.float pi2;
.float pi3;
.float pi4;
.float pi5;
.float pi6;
.float pi7;
.float pi8;
.float pi9;
void (entity me) CBot_Create;

void () CN_Client_Init_Think =
{
};

string () choosename =
{
	if ((cbotnum == MSG_BROADCAST))
	{
		return ("One");
	}
	else
	{
		if ((cbotnum == AS_STRAIGHT))
		{
			return ("Two");
		}
		else
		{
			if ((cbotnum == SEARCH))
			{
				return ("Three");
			}
			else
			{
//				return;
				return("Zero");
			}
		}
	}
};
//end