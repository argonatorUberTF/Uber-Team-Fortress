//mtf_coop_score.qc
//	by: XavioR
// Controls monster scoreboard
void (float clientno, float clientid, float clientshirt, float clientpants, string clientname, float botteam, float botskin) svcUpdateUserInfo;
void (float clientno, float cliententertime) svcUpdateEnterTime;
void (float clientno, float clientping) svcUpdatePing;
void (float clientno, float clientfrags) svcUpdateFrags;
void (entity mnst) Monster_Stats_Send_Full;
void (float clientno) clientSetUsed2;
float () clientNextAvailable2;
// Hack a monster score count into the QW scoreboard (logs monster frags)
void () Monster_Stats_Create =
{
	local float clientno;
	local entity uself;
	local entity monster_score;
	monster_score = spawn();
	monster_score.team_no = 2;	// red
	monster_score.classname = "monster_score";
	monster_score.netname = "Monsters";
	monster_score.fEnterTime = time;
	clientno = clientNextAvailable2 ();
	uself = self;
	if (((clientno == -1) || (clientno >= fMaxClients2/*stof (infokey (world, "maxclients"))*/)))
	{
		bprint (2, "Unable to connect a bot, server is full.\n");
		return;
	}
	clientSetUsed2 (clientno);
	monster_score.fClientNo = clientno;
	self = monster_score;
	self.ishuman = 2;
	ClientInRankings2 ();
	self.ishuman = 0;
	self = uself;
	monster_score.fClientNo = fMaxClients2 + 1;
	Monster_Stats_Send_Full( monster_score );
};
void (entity mnst) Monster_Stats_Send_Full =
{
	local float num;
	num = (TeamFortress_TeamGetColor (mnst.team_no) - 1);
	if (mnst.classname != "monster_score")
	{
		bprint(2,"DEV!!! BUG!! look at this!!:\n");
		bprint(2,ftos(mnst.fClientNo)); 
		bprint(2,"\n");
		bprint(2,ftos(mnst.fUserID));
		bprint(2,"\n");
		return;
	}
	svcUpdatePing (mnst.fClientNo, 666);
	svcUpdateEnterTime (mnst.fClientNo, (time - mnst.fEnterTime));
	svcUpdateUserInfo (mnst.fClientNo, mnst.fUserID, num, num, mnst.netname, mnst.team_no, 1/*mnst.skin*/);
	svcUpdateFrags (mnst.fClientNo, mnst.frags);
};
void (float clientno, float clientfrags) svcUpdateFrags =
{
	#CheckScoreCVAR
	WriteByte (2, 14);
	WriteByte (2, clientno);
	WriteShort (2, clientfrags);
};
void (float clientno, float clientping) svcUpdatePing =
{
	#CheckScoreCVAR
	WriteByte (2, 36);
	WriteByte (2, clientno);
	WriteShort (2, clientping);
};
void (float clientno, float cliententertime) svcUpdateEnterTime =
{
	#CheckScoreCVAR
	WriteByte (2, 37);
	WriteByte (2, clientno);
	WriteLong (2, cliententertime);
};
void (float clientno, float clientid, float clientshirt, float clientpants, string clientname, float botteam, float botskin) svcUpdateUserInfo =
{
	#CheckScoreCVAR
	WriteByte (2, 40);
	WriteByte (2, clientno);
	WriteLong (2, clientid);
	WriteByte (2, 92);
	WriteByte (2, 109);
	WriteByte (2, 115);
	WriteByte (2, 103);
	WriteByte (2, 92);
	WriteByte (2, 49);
	WriteByte (2, 92);
	WriteByte (2, 114);
	WriteByte (2, 97);
	WriteByte (2, 116);
	WriteByte (2, 101);
	WriteByte (2, 92);
	WriteByte (2, 53);
	WriteByte (2, 48);
	WriteByte (2, 48);
	WriteByte (2, 48);
	WriteByte (2, 92);
	WriteByte (2, 119);
	WriteByte (2, 95);
	WriteByte (2, 115);
	WriteByte (2, 119);
	WriteByte (2, 105);
	WriteByte (2, 116);
	WriteByte (2, 99);
	WriteByte (2, 104);
	WriteByte (2, 92);
	WriteByte (2, 50);
	WriteByte (2, 92);
	WriteByte (2, 98);
	WriteByte (2, 95);
	WriteByte (2, 115);
	WriteByte (2, 119);
	WriteByte (2, 105);
	WriteByte (2, 116);
	WriteByte (2, 99);
	WriteByte (2, 104);
	WriteByte (2, 92);
	WriteByte (2, 50);
	WriteByte (2, 92);
	WriteByte (2, 110);
	WriteByte (2, 111);
	WriteByte (2, 97);
	WriteByte (2, 105);
	WriteByte (2, 109);
	WriteByte (2, 92);
	WriteByte (2, 48);
	WriteByte (2, 92);
	WriteByte (2, 115);
	WriteByte (2, 112);
	WriteByte (2, 101);
	WriteByte (2, 99);
	WriteByte (2, 116);
	WriteByte (2, 97);
	WriteByte (2, 116);
	WriteByte (2, 111);
	WriteByte (2, 114);
	WriteByte (2, 92);
	WriteByte (2, 48);
	WriteByte (2, 92);
	WriteByte (2, 112);
	WriteByte (2, 109);
	WriteByte (2, 111);
	WriteByte (2, 100);
	WriteByte (2, 101);
	WriteByte (2, 108);
	WriteByte (2, 92);
	WriteByte (2, 49);
	WriteByte (2, 51);
	WriteByte (2, 56);
	WriteByte (2, 52);
	WriteByte (2, 53);
	WriteByte (2, 92);
	WriteByte (2, 101);
	WriteByte (2, 109);
	WriteByte (2, 111);
	WriteByte (2, 100);
	WriteByte (2, 101);
	WriteByte (2, 108);
	WriteByte (2, 92);
	WriteByte (2, 54);
	WriteByte (2, 57);
	WriteByte (2, 54);
	WriteByte (2, 55);
	WriteByte (2, 92);
	WriteByte (2, 98);
	WriteByte (2, 111);
	WriteByte (2, 116);
	WriteByte (2, 116);
	WriteByte (2, 111);
	WriteByte (2, 109);
	WriteByte (2, 99);
	WriteByte (2, 111);
	WriteByte (2, 108);
	WriteByte (2, 111);
	WriteByte (2, 114);
	WriteByte (2, 92);
	if ((clientpants > 9))
	{
		WriteByte (2, 49);
		WriteByte (2, (38 + clientpants));
	}
	else
	{
		WriteByte (2, (48 + clientpants));
	}
	WriteByte (2, 92);
	WriteByte (2, 116);
	WriteByte (2, 111);
	WriteByte (2, 112);
	WriteByte (2, 99);
	WriteByte (2, 111);
	WriteByte (2, 108);
	WriteByte (2, 111);
	WriteByte (2, 114);
	WriteByte (2, 92);
	if ((clientshirt > 9))
	{
		WriteByte (2, 49);
		WriteByte (2, (38 + clientshirt));
	}
	else
	{
		WriteByte (2, (48 + clientshirt));
	}
	WriteByte (2, 92);
	WriteByte (2, 116);
	WriteByte (2, 101);
	WriteByte (2, 97);
	WriteByte (2, 109);
	WriteByte (2, 92);
	if ((botteam == 1))
	{
		WriteByte (2, 98);
		WriteByte (2, 108);
		WriteByte (2, 117);
		WriteByte (2, 101);
	}
	else
	{
		if ((botteam == 2))
		{
			WriteByte (2, 114);
			WriteByte (2, 101);
			WriteByte (2, 100);
		}
	}
	WriteByte (2, 92);
	WriteByte (2, 115);
	WriteByte (2, 107);
	WriteByte (2, 105);
	WriteByte (2, 110);
	WriteByte (2, 92);
	if ((botskin == 1))
	{
		WriteByte (2, 116);
		WriteByte (2, 102);
		WriteByte (2, 95);
		WriteByte (2, 115);
		WriteByte (2, 99);
		WriteByte (2, 111);
		WriteByte (2, 117);
		WriteByte (2, 116);
	}
	else
	{
		if ((botskin == 2))
		{
			WriteByte (2, 116);
			WriteByte (2, 102);
			WriteByte (2, 95);
			WriteByte (2, 115);
			WriteByte (2, 110);
			WriteByte (2, 105);
			WriteByte (2, 112);
			WriteByte (2, 101);
		}
		else
		{
			if ((botskin == 3))
			{
				WriteByte (2, 116);
				WriteByte (2, 102);
				WriteByte (2, 95);
				WriteByte (2, 115);
				WriteByte (2, 111);
				WriteByte (2, 108);
				WriteByte (2, 100);
			}
			else
			{
				if ((botskin == 4))
				{
					WriteByte (2, 116);
					WriteByte (2, 102);
					WriteByte (2, 95);
					WriteByte (2, 100);
					WriteByte (2, 101);
					WriteByte (2, 109);
					WriteByte (2, 111);
				}
				else
				{
					if ((botskin == 5))
					{
						WriteByte (2, 116);
						WriteByte (2, 102);
						WriteByte (2, 95);
						WriteByte (2, 109);
						WriteByte (2, 101);
						WriteByte (2, 100);
						WriteByte (2, 105);
						WriteByte (2, 99);
					}
					else
					{
						if ((botskin == 6))
						{
							WriteByte (2, 116);
							WriteByte (2, 102);
							WriteByte (2, 95);
							WriteByte (2, 104);
							WriteByte (2, 119);
							WriteByte (2, 103);
							WriteByte (2, 117);
							WriteByte (2, 121);
						}
						else
						{
							if ((botskin == 7))
							{
								WriteByte (2, 116);
								WriteByte (2, 102);
								WriteByte (2, 95);
								WriteByte (2, 112);
								WriteByte (2, 121);
								WriteByte (2, 114);
								WriteByte (2, 111);
							}
							else
							{
								if ((botskin == 8))
								{
									WriteByte (2, 116);
									WriteByte (2, 102);
									WriteByte (2, 95);
									WriteByte (2, 115);
									WriteByte (2, 112);
									WriteByte (2, 121);
								}
								else
								{
									if ((botskin == 9))
									{
										WriteByte (2, 116);
										WriteByte (2, 102);
										WriteByte (2, 95);
										WriteByte (2, 101);
										WriteByte (2, 110);
										WriteByte (2, 103);
									}
									else
									{
										WriteByte (2, 98);
										WriteByte (2, 97);
										WriteByte (2, 115);
										WriteByte (2, 101);
									}
								}
							}
						}
					}
				}
			}
		}
	}
	WriteByte (2, 92);
	WriteByte (2, 110);
	WriteByte (2, 97);
	WriteByte (2, 109);
	WriteByte (2, 101);
	WriteByte (2, 92);
	WriteString (2, clientname);
};
float (float clientno) clientBitFlag2 =
{
	local float bitflag;
	bitflag = 1.000000;
	while ((clientno > 0.000000))
	{
		bitflag = bitflag * 2.000000;
		clientno = clientno - 1.000000;
	}
	return (bitflag);
};
void (float clientno) clientSetFree2 =
{
	PLAYER_COUNT = PLAYER_COUNT - 1.000000;
	if ((clientno > 16.000000))
	{
		fActiveClients2 = fActiveClients2 - (fActiveClients2 & clientBitFlag2 ((clientno - 16.000000)));
	}
	else
	{
		fActiveClients1 = fActiveClients1 - (fActiveClients1 & clientBitFlag2 (clientno));
	}
};
void (float clientno) clientSetUsed2 =
{
	if ((clientno > 16.000000))
	{
		fActiveClients2 = fActiveClients2 | clientBitFlag2 (clientno - 16);
	}
	else
	{
		fActiveClients1 = fActiveClients1 | clientBitFlag2 (clientno);
	}
};
void (float clientno) botInvalidClientNo2 =
{
	local entity bot;
	bot = find (world, classname, "player");
	while (bot)
	{
		if (((bot.fClientNo == clientno) && !bot.ishuman))
		{
		bprint(2,"DEV! BAD #1\n");
			bot.fClientNo = -1.000000;
			//botDisconnect (bot);	// xavior: ADDME
			return;
		}
		bot = find (bot, classname, "player");
	}
};
void () ClientInRankings2 =
{
	local float cno;
	userid2 = userid2 + 1.000000;
	self.fUserID = userid2;
	if ((self.ishuman == 2.000000))
	{
		self.ishuman = 0.000000;
		return;
	}
	PLAYER_COUNT = PLAYER_COUNT + 1;
	cno = self.colormap - 1;
	botInvalidClientNo2 (cno);
	clientSetUsed2 (cno);
	self.fClientNo = cno;
	self.ishuman = 1;
};
float (float clientno) clientIsActive2 =
{
	if ((clientno > 16.000000))
	{
		if ((fActiveClients2 & clientBitFlag2 ((clientno - 16.000000))))
		{
			return (1.000000);
		}
	}
	else
	{
		if ((fActiveClients1 & clientBitFlag2 (clientno)))
		{
			return (1.000000);
		}
	}
	return (0.000000);
};
float () clientNextAvailable2 =
{
	local float clientno;
	clientno = 0;
	while (clientno < fMaxClients2)
	{
		if (!clientIsActive2 (clientno))
		{
			return (clientno);
		}
		clientno = clientno + 1;
	}
	return (-1);
};
void ( entity ment ) Coop_ClientFixRankings =
{
	ment.fUserID = ment.fUserID + 1;
};
//END
