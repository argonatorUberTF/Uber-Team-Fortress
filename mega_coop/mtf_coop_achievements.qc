string (float anum) Achievements_GetName =
{
	switch(anum)
	{
		case ACHIEVEMENT_BLADERUNNER:
			return "Blade Runner";
			break;
		case ACHIEVEMENT_HEAVYMETAL:
			return "Heavy Metal";
			break;
		case ACHIEVEMENT_LOOTBAGGER:
			return "Loot Bagger";
			break;
		case ACHIEVEMENT_BIGCANNON:
			return "Assault Junkie";
			break;
		case ACHIEVEMENT_COMPLETIONIST:
			return "Completionist";
			break;	
		case ACHIEVEMENT_FLAWLESS:
			return "Flawless Junkie";
			break;
		case ACHIEVEMENT_ATOMICPUNK:
			return "Atomic Punk";
			break;	
		case ACHIEVEMENT_KILLINGMACHINE:
			return "Killing Machine";
			break;
		case ACHIEVEMENT_HEADSHOT:
			return "Boom Headshot";
			break;
		case ACHIEVEMENT_BAT:
			return "Boink!";
			break;
		case ACHIEVEMENT_HEAL:
			return "Mr. Medkit";
			break;
		case ACHIEVEMENT_REPAIR:
			return "Mr. Fixit";
			break;
		case ACHIEVEMENT_RESURRECT:
			return "Helping Hand";
			break;
		case ACHIEVEMENT_LMS:
			return "Last Man Standing";
			break;
		case ACHIEVEMENT_SHAMBLER:
			return "Shambler Medic";
			break;
		case ACHIEVEMENT_MULTI:
			return "Combo Meal";
			break;
		case ACHIEVEMENT_MRGRINCH:
			return "Mr. Grinch";
			break;
		case ACHIEVEMENT_EPISODE1:
			return "Shareware Hippie (E1)";
			break;
		case ACHIEVEMENT_EPISODE2:
			return "Black Magic Woman (E2)";
			break;
		case ACHIEVEMENT_EPISODE3:
			return "Off To Never-Netherworld (E3)";
			break;
		case ACHIEVEMENT_EPISODE4:
			return "Fantastic Four (E4)";
			break;
		case ACHIEVEMENT_HELPER:
			return "Santa's Little Helper";
			break;
		case ACHIEVEMENT_JUGGLER:
			return "Court Bard";
			break;
		case ACHIEVEMENT_LEVELTWENTY:
			return "Master of Quake";
			break;
		case ACHIEVEMENT_GAMBLER:
			return "Gamblin' Man";
			break;
		case ACHIEVEMENT_TREASURE:
			return "Treasure Hunter (wolf3d)";
			break;
		case ACHIEVEMENT_SPEEDY:
			return "Speed Runner";
			break;
		case ACHIEVEMENT_RECORD:
			return "Record Setter";
			break;
		default:
			return "noname";
			break;
	}
	return "noname";
};
// How many points a player needs at least to earn an achievement
float (float anum) Achievements_CheckComplete =
{
	switch(anum)
	{
		case ACHIEVEMENT_BLADERUNNER:
			return 2000;
			break;
		case ACHIEVEMENT_HEAVYMETAL:
			return 500;
			break;
		case ACHIEVEMENT_LOOTBAGGER:
			return 50;
			break;
		case ACHIEVEMENT_BIGCANNON:
			return 1000;
			break;
		case ACHIEVEMENT_COMPLETIONIST:
			return 500;
			break;
		case ACHIEVEMENT_FLAWLESS:
			return 100;
			break;
		case ACHIEVEMENT_ATOMICPUNK:
			return 2500;
			break;
		case ACHIEVEMENT_KILLINGMACHINE:
			return 50000;
			break;
		case ACHIEVEMENT_HEADSHOT:
			return 2500;
			break;
		case ACHIEVEMENT_BAT:
			return 1500;
			break;
		case ACHIEVEMENT_HEAL:
			return 2500;
			break;
		case ACHIEVEMENT_REPAIR:
			return 2000;
			break;
		case ACHIEVEMENT_RESURRECT:
			return 5000;
			break;
		case ACHIEVEMENT_LMS:
			return 100;
			break;
		case ACHIEVEMENT_SHAMBLER:
			return 2000;
			break;
		case ACHIEVEMENT_MULTI:
			return 2500;
			break;
		case ACHIEVEMENT_MRGRINCH:
			return 200;
			break;
		case ACHIEVEMENT_EPISODE1:
			return 127;
			break;
		case ACHIEVEMENT_EPISODE2:
			return 127;
			break;
		case ACHIEVEMENT_EPISODE3:
			return 127;
			break;
		case ACHIEVEMENT_EPISODE4:
			return 127;
			break;
		case ACHIEVEMENT_HELPER:
			return 2000;
			break;
		case ACHIEVEMENT_JUGGLER:
			return 700;
			break;
		case ACHIEVEMENT_LEVELTWENTY:
			return 80;
			break;
		case ACHIEVEMENT_GAMBLER:
			return 100;
			break;
		case ACHIEVEMENT_TREASURE:
			return 511;
			break;
		case ACHIEVEMENT_SPEEDY:
			return 100;
			break;
		case ACHIEVEMENT_RECORD:
			return 100;
			break;
		default:
			return 50000;			// some insane amount.. because something is wack
			break;
	}
	return 5000;
};
// How much exp a player earns for completing an achievement
float ( float anum ) Achievements_GetExp =
{
	switch(anum)
	{
		case ACHIEVEMENT_BLADERUNNER:
			return 2500;
			break;
		case ACHIEVEMENT_HEAVYMETAL:
			return 4000;
			break;
		case ACHIEVEMENT_LOOTBAGGER:
			return 7500;
			break;
		case ACHIEVEMENT_BIGCANNON:
			return 1000;
			break;
		case ACHIEVEMENT_COMPLETIONIST:
			return 2500;
			break;		
		case ACHIEVEMENT_FLAWLESS:
			return 7500;
			break;
		case ACHIEVEMENT_ATOMICPUNK:
			return 2500;
			break;
		case ACHIEVEMENT_KILLINGMACHINE:
			return 10000;
			break;
		case ACHIEVEMENT_HEADSHOT:
			return 3000;
			break;
		case ACHIEVEMENT_BAT:
			return 2750;
			break;
		case ACHIEVEMENT_HEAL:
			return 4000;
			break;
		case ACHIEVEMENT_REPAIR:
			return 3050;
			break;
		case ACHIEVEMENT_RESURRECT:
			return 8500;
			break;
		case ACHIEVEMENT_LMS:
			return 4500;
			break;
		case ACHIEVEMENT_SHAMBLER:
			return 6500;
			break;
		case ACHIEVEMENT_MULTI:
			return 4750;
			break;
		case ACHIEVEMENT_MRGRINCH:
			return 1987;
			break;
		case ACHIEVEMENT_EPISODE1:
			return 5500;
			break;
		case ACHIEVEMENT_EPISODE2:
			return 6500;
			break;
		case ACHIEVEMENT_EPISODE3:
			return 7000;
			break;
		case ACHIEVEMENT_EPISODE4:
			return 7500;
			break;
		case ACHIEVEMENT_HELPER:
			return 7000;
			break;
		case ACHIEVEMENT_JUGGLER:
			return 4500;
			break;
		case ACHIEVEMENT_LEVELTWENTY:
			return 666;
			break;
		case ACHIEVEMENT_GAMBLER:
			return 10000;
			break;
		case ACHIEVEMENT_TREASURE:
			return 15000;
			break;
		case ACHIEVEMENT_SPEEDY:
			return 7500;
			break;
		case ACHIEVEMENT_RECORD:
			return 14000;
			break;
		default:
			return 2500;
			break;
	}
	return 2500;
};
// Either read the file or create the file for awards/achievements (called each time a player joins in client.pqc)
float (entity t_plyr) Achievements_Setup =
{
	local string a;
	local string filenamee, oopsname;
	local float filee;
	local float i;
	local string tstr;
	if ( t_plyr.connect_name == "" || !t_plyr.connect_name )
	{
		//self.#achievements = -1;
		return ( -1 );
	}
	filenamee = frik_strcat( "ranks/inv/", t_plyr.connect_name, "_awd.tfi" );
	filenamee = strzone(filenamee);
	if ( invalid_exp_name(filenamee) == 1 )
	{
		strunzone(filenamee);
		//self.#achievements = -1;
		return ( -1 );
	}
	achievements_enabled = #TRUE;
	if ( checkfilename(filenamee) != 1 )
	{	// done in C - makes sure the file name is writable
		strunzone(filenamee);
		//self.#achievements = -1;
		// make sure that the folder exists to be written to in the first place
		if (checkfilename( "ranks/inv/test" ) == #FALSE)
			achievements_enabled = #FALSE;
			bprint( 2, "WARNING: Folder /inv cannot be found! Server admin needs to create /fortress/ranks/inv/ folder!\n" );
		return ( -1 );
	}
	oopsname = frik_strcat( "ranks/inv/", self.connect_name, "_awd.tfi" );
	oopsname = strzone(oopsname);
	if (filenamee != oopsname || self.has_disconnected == 1)
	{
		bprint(2, "!!!!!!!!!!!!! AWARDS BUG ERROR IN READ!!! filenamee IS NOT THE SAME AS CONNECT NAME !!!!!!!!!!!!! \n");
		bprint(2, "CNAME: ");
		bprint(2, self.connect_name);
		bprint(2, " filenamee: ");
		bprint(2, filenamee);
		bprint(2, " oopsname: ");
		bprint(2, oopsname);
		bprint(2,"\n");
		strunzone(filenamee);
		strunzone(oopsname);
		return ( -1 );
	}
	strunzone(oopsname);
	filee = open (filenamee, 0);
	a = read (filee);	// lets see if the awards file exists for the player..
	if (!a)		// nope!
	{
		close(filee);
		filee = open (filenamee, 2);
		write (filee, "// MegaTF Coop awards and achievements Team Fortress Information file\n");
		write (filee, "// The three fields explained:\n");
		write (filee, "// First line is achievement name\n// Second line is player's progress in earning the achievement\n// Third line is how many of that achievement the player has\n");
		write (filee, "// ADDME: use this line for something?\n");
		while (i < MAXLINES_ACHIEVEMENTS + #FIRST_AWD_LINE)
		{
			tstr = Achievements_GetName(i);
			if (tstr == "noname")
				write (filee, "0\n");
			else
			if (tstr == "endname")
				break;
			else
			{
				write (filee, tstr);
				write (filee, "\n");
			}
			i++;
		}
		close (filee);
		strunzone(filenamee);	
		return ( 0 );
	}
	close (filee);
	strunzone(filenamee);
	return #TRUE;
};
// Print player's awards stats to self or other players (called from "cmd ach #" at the moment)
//0: Print to player only the awards he/she has earned
//1: Player says to other players the earned achievements
//2: Print to the player every achievement and their progress towards each respective one
void ( float p_type, entity t_plyr ) Achievements_Print =
{
	local float file, i, infa, infb;
	if (!t_plyr.connect_name)
		return;
	if (t_plyr.coop_exp == -1)
		return;
	if (p_type == 0)
		sprint(self, 2, "Your achievements:\n");
	else
	if (p_type == 1)
	{
		stuffcmd(self, "say \"My achievements\n");
	}
	else
	if (p_type == 2)
		sprint(self, 2, "Your achievements (detailed):\n");
	i = 1;
	file = open (frik_strcat( "ranks/inv/", t_plyr.connect_name, "_awd.tfi" ), 0);
	while ( i < (#MAXLINES_ACHIEVEMENTS + #FIRST_AWD_LINE + 1) )
	{
		if (i >= #FIRST_AWD_LINE)
		{
			if (Achievements_GetName(i - #FIRST_AWD_LINE) != "noname")
			{
				read(file);
				infa = stof( read(file) );
				infb = stof( read(file) );
				if (infb > 0)
				{
					if (p_type == 0)
					{
						sprint(self, 2, Achievements_GetName(i - #FIRST_AWD_LINE));
						sprint(self, 2, "(" );
						sprint(self, 2, ftos(infb));
						sprint(self, 2, ").\n");
					}
					else
					if (p_type == 1)
					{
						bprint(2, Achievements_GetName(i - #FIRST_AWD_LINE));
						bprint(2, "(" );
						bprint(2, ftos(infb));
						bprint(2, ") ");
					}
				}
				if (p_type == 2)
				{
					sprint(self, 2, Achievements_GetName(i - #FIRST_AWD_LINE));
					sprint(self, 2, "(" );
					sprint(self, 2, ftos(infb));
					sprint(self, 2, ") - your progress: ");
					sprint(self, 2, ftos(infa));
					sprint(self, 2, " of ");
					sprint(self, 2, ftos(Achievements_CheckComplete(i - #FIRST_AWD_LINE)));
					sprint(self, 2, ".\n");
				}
				i = i+2;
			}
			else
				read(file);
		}
		else
			read(file);
		i++;
	}
	close(file);
	if (p_type == 1)
		bprint(2, "\n");
};
void () Achievements_Set =
{
	local entity t_plyr, t_other, oself;
	local float s_type, a_type, a_var;
	local float new_achievement;
	local string a;
	local float ach_total;			// total achievement points, and also used for total times an achievement has been earned
	local float file, dummyfile;
	local float i;
	i=1;
	oself = self;
	t_plyr = self.owner;
	t_other = self.enemy;
	s_type = self.health;
	a_type = self.ammo_shells;
	a_var = self.armorvalue;
	if (t_plyr.coop_exp != -1 && t_plyr != other && t_plyr.has_disconnected != 1)
	{
	}
	else
	{
		bprint(2, "Achievements_Set: Tried to set on world or disconnected player or something\n");
		dremove(self);
		return;
	}
	file = open (frik_strcat( "ranks/inv/", t_plyr.connect_name, "_awd.tfi" ), 0);
	dummyfile = open ("dummy_awd.tfi", 2);
	while ( i < (#MAXLINES_ACHIEVEMENTS + #FIRST_AWD_LINE + 1) )
	{
		if (i == (#FIRST_AWD_LINE + a_type))
		{
			write( dummyfile, Achievements_GetName(a_type) );
			write( dummyfile, "\n" );
			read(file);
		}
		else
		if (i == (#FIRST_AWD_LINE + a_type + 1))
		{
			a = read(file);
			if (s_type == ACHIEVEMENTS_ADD)
			{
				ach_total = stof(a) + a_var;
				if (ach_total < 0)		// since you can add negatives
					ach_total = 0;
			}
			else
			if (s_type == ACHIEVEMENTS_ADDBIT)
			{
				ach_total = stof(a);
				if (!ach_total & a_var)
					ach_total += a_var;
				if (ach_total < 0)		// since you can add negatives
					ach_total = 0;
			}
			else
			if (s_type == ACHIEVEMENTS_SET)
			{
					ach_total = a_var;
			}
			else
				ach_total = 0;
			if (Achievements_CheckComplete(a_type) <= ach_total)
			{
				bprint(2, "‰‰‰ÎE× AÃHÉEÖEÍEÎT‰‰‰ ");
				bprint(2, t_plyr.connect_name);
				bprint(2, " has earned the achievement: ");
				bprint(2, Achievements_GetName(a_type) );
				bprint(2, "\n");
				ach_total = 0;
				new_achievement = 1;
				write( dummyfile, ftos( ach_total ) );
				write( dummyfile, "\n" );
				a = read(file);
				ach_total = stof(a) + 1;
				write( dummyfile, ftos( ach_total ) );
				write( dummyfile, "\n" );
				i++;
			}
			else
			{
				write( dummyfile, ftos( ach_total ) );
				write( dummyfile, "\n" );
			}
		}
		else
		{
			write( dummyfile, read(file) );
			write( dummyfile, "\n" );
		}
		i++;
	}
	close ( dummyfile );
	close (file);
	CopyFile( "dummy_awd.tfi", frik_strcat( "ranks/inv/", t_plyr.connect_name, "_awd.tfi" ), 0, string_null, #MAXLINES_ACHIEVEMENTS + #FIRST_AWD_LINE);
	if (new_achievement)
		MTF_Coop_AddServiceExp( t_plyr, world, Achievements_GetExp(a_type), #SRV_ACHIEVEMENT );
	dremove(self);
};
void ( entity t_plyr, entity t_other, float s_type, float a_type, float a_var ) Achievements_Change =
{
	local entity ach_ent, te;
	if (achievements_enabled == #FALSE)
		return;
	if (s_type == ACHIEVEMENTS_GLOBALADD)
	{			// add to every player in the game (used for flawless, completionist, lms, etc.)
		te = find ( world, classname, "player" );
		while (te)
		{
			if (te.coop_exp != -1 && te.has_disconnected != 1)
			{
				Achievements_Change( te, world, ACHIEVEMENTS_ADD, a_type, a_var );
			}
			te = find (te, classname, "player");
		}	
		return;
	}
	if (t_plyr == world && t_other == world)
		return;
	if (t_plyr.coop_exp == -1)
		return;
	ach_ent = spawn();
	ach_ent.owner = t_plyr;
	ach_ent.enemy = t_other;
	ach_ent.health = s_type;
	ach_ent.ammo_shells = a_type;
	ach_ent.armorvalue = a_var;
	ach_ent.think = Achievements_Set;
	ach_ent.nextthink = time + .6 + random();
};
float (string mpn) GetEP1MapBit = 
{
	if (mpn  == "e1m1")
		return 1;
	else
	if (mpn  == "e1m2")
		return 2;
	else
	if (mpn  == "e1m3")
		return 4;
	else
	if (mpn  == "e1m4")
		return 8;
	else
	if (mpn  == "e1m5")
		return 16;
	else
	if (mpn  == "e1m6")
		return 32;
	else
	if (mpn  == "e1m8")			// meh, forget e1m7 :D
		return 64;
		
	return -1;
};
float (string mpn) GetEP2MapBit = 
{
	if (mpn  == "e2m1")
		return 1;
	else
	if (mpn  == "e2m2")
		return 2;
	else
	if (mpn  == "e2m3")
		return 4;
	else
	if (mpn  == "e2m4")
		return 8;
	else
	if (mpn  == "e2m5")
		return 16;
	else
	if (mpn  == "e2m6")
		return 32;
	else
	if (mpn  == "e2m7")
		return 64;
	return -1;
};
float (string mpn) GetEP3MapBit = 
{
	if (mpn  == "e3m1")
		return 1;
	else
	if (mpn  == "e3m2")
		return 2;
	else
	if (mpn  == "e3m3")
		return 4;
	else
	if (mpn  == "e3m4")
		return 8;
	else
	if (mpn  == "e3m5")
		return 16;
	else
	if (mpn  == "e3m6")
		return 32;
	else
	if (mpn  == "e3m7")
		return 64;
	return -1;
};
float (string mpn) GetEP4MapBit = 
{
	if (mpn  == "e4m1")
		return 1;
	else
	if (mpn  == "e4m2")
		return 2;
	else
	if (mpn  == "e4m3")
		return 4;
	else
	if (mpn  == "e4m4")
		return 8;
	else
	if (mpn  == "e4m5")
		return 16;
	else
	if (mpn  == "e4m6")
		return 32;
	else
	if (mpn  == "e4m7")
		return 64;
	return -1;
};
float (string mpn) GetW3DMapBit = 
{
	if (mpn  == "e1f1")
		return 1;
	else
	if (mpn  == "e1f2")
		return 2;
	else
	if (mpn  == "e1f3")
		return 4;
	else
	if (mpn  == "e1f4")
		return 8;
	else
	if (mpn  == "e1f5")
		return 16;
	else
	if (mpn  == "e1f6")
		return 32;
	else
	if (mpn  == "e1f7")
		return 64;
	else
	if (mpn  == "e1f8")
		return 128;	
	else
	if (mpn  == "e1f9")
		return 256;
	return -1;
};
//END