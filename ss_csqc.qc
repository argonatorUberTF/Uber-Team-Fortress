void (entity t_plyr, float etime) CSQC_SendReloadBar =
{
	if (!t_plyr.csqc_client)
		return;
	stuffcmd( t_plyr, "cmd showprogress " );
	stuffcmd( t_plyr, ftos(etime-time) );
	stuffcmd( t_plyr, "\n" );
};
void (entity t_plyr, float mons_currhp, float mons_maxhp) CSQC_SendMonsterbar =
{
	if (!t_plyr.csqc_client)
		return;
	stuffcmd( t_plyr, "cmd monsbar " );
	stuffcmd( t_plyr, ftos(mons_currhp) );
	stuffcmd( t_plyr, " " );
	stuffcmd( t_plyr, ftos(mons_maxhp) );
	stuffcmd( t_plyr, "\n" );
};

void (entity t_plyr, float t_menu, float mflg_one, float mflg_two) CSQC_SendMenu =
{
	if (!t_plyr.csqc_client)
		return;
	stuffcmd( t_plyr, "cmd loadmenu " );
	stuffcmd( t_plyr, ftos(t_menu) );
	stuffcmd( t_plyr, " " );
	stuffcmd( t_plyr, ftos(mflg_one) );
	stuffcmd( t_plyr, " " );
	stuffcmd( t_plyr, ftos(mflg_two) );
	stuffcmd( t_plyr, "\n" );
}
#ifdef decemberween
void (entity t_plyr, float gibtype, vector giborigin, float veracity) CSQC_SendGibs =
{
	local entity te;
	
	if (t_plyr == world)		// send to all players with CSQC capabilities
	{
		te = find(world, classname, "player");
		while (te) {
			if (te.csqc_client) {
				CSQC_SendGibs(te, gibtype, giborigin, veracity);
			}
			te = find(te, classname, "player");
		}
		return;
	}
	else if (!t_plyr.csqc_client)
		return;
	stuffcmd( t_plyr, "cmd spawngibs " );
	stuffcmd( t_plyr, ftos(gibtype) );
	stuffcmd( t_plyr, " " );
	stuffcmd( t_plyr, ftos(giborigin_x) );
	stuffcmd( t_plyr, " " );
	stuffcmd( t_plyr, ftos(giborigin_y) );
	stuffcmd( t_plyr, " " );
	stuffcmd( t_plyr, ftos(giborigin_z) );
	stuffcmd( t_plyr, " " );
	stuffcmd( t_plyr, ftos(veracity) );
	stuffcmd( t_plyr, "\n" );
};
#endif
//END