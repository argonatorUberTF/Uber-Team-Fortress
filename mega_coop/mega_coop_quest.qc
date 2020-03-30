//
//	MegaTF:United Coop Quest system (linked to inventory system's merchant)
//		by XavioR
//
//	- requires xavior's mvdsv to work properly but
//	  can be hacked to work with FRIK_FILE by changing
//	  the extension #s of the read/write/open defs.
//
//
// The point of this system is to allow for the addition of user-made quests via
// .tfi files instead of making all quests hardcoded. Quests are read from files
// and can be a simple one stage quest or retain the ability to be executed in
// multiple stages linked to each other.



#define QUESTLISTPATH			ranks/quests/questlist
#define QUESTSPATH				ranks/quests

void ( entity qplayer ) Quest_WriteStats;

// Grab some info from the quest itself based on the owner's progress
string ( float grabtype, float quest_id, entity qowner ) Quest_GetValueFor =
{
	local string desc_str, t_desc_str, qfname, qstage;
	local float i;
	i = 1;
//
	if (quest_id == 0)
	{
		bprint(2, "Merchant Quest Error: Merchant requested invalid quest id # for description\n");
		return "Invalid Quest";
	}
	qfname = frik_strcat( "#QUESTLISTPATH/quest", ftos(quest_id), ".tfi" );
//	
	if (qowner.#questid == quest_id)
		qstage = frik_strcat( "//Stage", ftos(qowner.#queststage) );
	else
		qstage = "//Stage1";
//		
	if (grabtype == #QUESTINFO_DESCRIPTION)
		desc_str = TFI_GetValueFor( qfname, "//Description", 1, qstage );
	else if (grabtype == #QUESTINFO_DIALOGUE) {
// getting dialogue is a bit more complicated because it can be multiple lines
		while (i < 6) { // max of 5 lines (6 crashes the server for some reason)
			t_desc_str = TFI_GetValueFor( qfname, "//Dialogue", i, qstage );
			if ( t_desc_str == "//Rules" )
				break;
			desc_str = frik_strcat( desc_str, "\n", t_desc_str );
			i++;
		}
	}
	else if (grabtype == #QUESTINFO_VARS1 )
		desc_str = TFI_GetValueFor( qfname, "//QuestVar1", 1, qstage );
	else if (grabtype == #QUESTINFO_VARS2 )
		desc_str = TFI_GetValueFor( qfname, "//QuestVar2", 1, qstage );	
	else if (grabtype == #QUESTINFO_VARS3 )
		desc_str = TFI_GetValueFor( qfname, "//QuestVar3", 1, qstage );
//		
	return (desc_str);
};

// set a NEW quest for player
void ( entity qplayer, float quest_id ) Quest_SetFor =
{
	if ( qplayer.#questid == -1 ) {
		// can't write any stats for this player
		return;
	}
//
	sprint( qplayer, 2, "You are now engaged in the quest: " );
	sprint( qplayer, 2, Quest_GetValueFor( #QUESTINFO_DESCRIPTION, quest_id, qplayer ) );
	sprint( qplayer, 2, ".\n" );
	qplayer.#questid = quest_id;
	qplayer.#queststage = 1;
	qplayer.#questvar1 = stof( Quest_GetValueFor( #QUESTINFO_VARS1, quest_id, qplayer ) );
	qplayer.#questvar2 = stof( Quest_GetValueFor( #QUESTINFO_VARS2, quest_id, qplayer ) );
	qplayer.#questvar3 = stof( Quest_GetValueFor( #QUESTINFO_VARS3, quest_id, qplayer ) );
//	
	Quest_WriteStats ( qplayer );
};

// This is called when the player connects and we set up his files/info
void ( entity qplayer ) Quest_SetupPlayer =
{
	local string filenamee;
	local float filee, newfile;
//	
	if (!qplayer.connect_name) {
		qplayer.#questid = -1;
		return;
	}
//	
// make sure that the folder exists to be written to in the first place
	filee = open ("#QUESTLISTPATH/test", 2);
	close(filee);
	if (checkfilename( "#QUESTLISTPATH/test" ) == #FALSE) {
		bprint( 2, "WARNING: Folder #QUESTLISTPATH cannot be found! Server admin needs to create #QUESTLISTPATH folder!\n" );
		qplayer.#questid = -1;
		return;
	}
//	
	filenamee = frik_strcat( "#QUESTSPATH/", qplayer.connect_name, "_quest.tfi" );
	filenamee = strzone(filenamee);
//
//
	newfile = TFI_ValidFileName( filenamee );
	if ( newfile == #FALSE ) {
		qplayer.#questid = -1;
		strunzone( filenamee );
		return;
	}
//	
// Now all checks are done, and we now know that the player's file can be written to!
//
//newfile 2 means it was created by the TFI_ValidFileName check
	if ( newfile == 2 ) {
		filee = open (filenamee, 2);
//
		self.#questid = 0;
//	
		write (filee, "// MegaTF Coop Quest Status file\n");
		write (filee, "//QuestID\n");
		write (filee, "0\n");
		write (filee, "//QuestStage\n");
		write (filee, "0\n");
		write (filee, "//QuestVars\n");
		write (filee, "0\n");
		write (filee, "0\n");
		write (filee, "0\n");
		write (filee, "//end\n");
		close (filee);
		strunzone(filenamee);
		return;
	}
	else {
		self.#questid = stof( TFI_GetValueFor( filenamee, "//QuestID", 1, string_null ) );
		self.#queststage = stof( TFI_GetValueFor( filenamee, "//QuestStage", 1, string_null ) );
		self.#questvar1 = 0;//stof( TFI_GetValueFor( filenamee, "//QuestVars", 1, string_null ) );
		self.#questvar2 = 0;//stof( TFI_GetValueFor( filenamee, "//QuestVars", 2, string_null ) );
		self.#questvar3 = 0;//stof( TFI_GetValueFor( filenamee, "//QuestVars", 3, string_null ) );
//		
//		bprint(2, ftos(self.#questid) );
//		bprint(2, ftos(self.#queststage) );
//		bprint(2, ftos(self.#questvar1) );
//		bprint(2, ftos(self.#questvar2) );
//		bprint(2, ftos(self.#questvar3) );
//		bprint(2, "\n");
	}
//
	strunzone(filenamee);
};

void ( entity qplayer ) Quest_WriteStats =
{
	local string filenamee;
//
	if ( qplayer.#questid == -1 ) {
		// can't write any stats for this player
		return;
	}
//	
	filenamee = frik_strcat( "#QUESTSPATH/", qplayer.connect_name, "_quest.tfi" );
	filenamee = strzone(filenamee);
//	
	TFI_WriteValueFor( filenamee, string_null, "//QuestID", 1, ftos(qplayer.#questid) );
	TFI_WriteValueFor( filenamee, string_null, "//QuestStage", 1, ftos(qplayer.#queststage) );
	TFI_WriteValueFor( filenamee, string_null, "//QuestVars", 1, ftos(qplayer.#questvar1) );
	TFI_WriteValueFor( filenamee, string_null, "//QuestVars", 2, ftos(qplayer.#questvar2) );
	TFI_WriteValueFor( filenamee, string_null, "//QuestVars", 3, ftos(qplayer.#questvar3) );
};

// Checks to see if any progress is made in a player's quest
void ( entity qplayer, float qvtype, entity qvent ) Quest_ProgressUpdate =
{
	local float quest_rules, quest_v_a, quest_v_b, i, pstat_var, progressok;
	local string qstage, qfname, quest_v_c, quest_v_d;
//
	if ( qplayer.classname != "player" )
		return;
	if ( qplayer.#questid < 1 )
		return;
//	
// Dont call this function too much or else an infinite loop will have our asses on a stick..
	if ( qplayer.#quest_nextwrite > time )
		return;
	qplayer.#quest_nextwrite = time + .1;
//
	qstage = frik_strcat( "//Stage", ftos(qplayer.#queststage) );
	qstage = strzone(qstage);
	qfname = frik_strcat( "#QUESTLISTPATH/quest", ftos(qplayer.#questid), ".tfi" );
	qfname = strzone(qfname);
//	
	quest_rules = stof( TFI_GetValueFor( qfname, "//Rules", 1, qstage ) );
//	
	i = 1;
	while ( i < 4 ) {
		bprint(2,"TEST3\n");
		quest_v_a = stof( TFI_GetValueFor( qfname, frik_strcat( "//QuestVar", ftos(i) ), 1, qstage ) );
		quest_v_b = stof( TFI_GetValueFor( qfname, frik_strcat( "//QuestVar", ftos(i) ), 2, qstage ) );
		quest_v_c = TFI_GetValueFor( qfname, frik_strcat( "//QuestVar", ftos(i) ), 3, qstage );
		quest_v_c = strzone(quest_v_c);
		if ( qvtype & quest_v_a && quest_v_a != 0 ) {
			if (i == 1)
				pstat_var = qplayer.#questvar1;
			else if (i == 2)
				pstat_var = qplayer.#questvar2;
			else
				pstat_var = qplayer.#questvar3;
				
			if ( pstat_var < quest_v_b ) {
//			
				if (quest_v_a & #QVAR_KILLMONSTER)
					if (quest_v_c == qvent.classname)
						progressok = 1;
				if (quest_v_a & #QVAR_KILLMONSTERANY)
					if (qvent.is_monster == 1)
						progressok = 1;
//			
				if ( progressok ) {
					pstat_var += 1;
					quest_v_d = TFI_GetValueFor( qfname, frik_strcat( "//QuestVar", ftos(i) ), 4, qstage );
//					
					if ( quest_v_d )
						sprint( qplayer, 2, frik_strcat( quest_v_d, ".\n" ) );
//						
					if (i == 1)
						qplayer.#questvar1 = pstat_var;
					else if (i == 2)
						qplayer.#questvar2 = pstat_var;
					else
						qplayer.#questvar3 = pstat_var;
					if ( pstat_var == quest_v_b ) {		// this section of the quest is over
						// ADD FINISHED CODE HERE?
						sprint( qplayer, 2, "You have completed something!\n" );
					}
					Quest_WriteStats ( qplayer );
				}
			}
		}
		strunzone(quest_v_c);
		i++;
	}
	strunzone(qstage);
	strunzone(qfname);
};

//END
