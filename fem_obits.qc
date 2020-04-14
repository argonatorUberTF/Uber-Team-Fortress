void(entity targ, entity attacker) FemaleClientObituary = 
{
	local float rnum;
	local string deathstring;
	local string deathstring2;
	rnum = random();
#ifdef mtf_coop
	if (targ.classname == "player" || targ.is_monster == 1)
#else
	if (targ.classname == "player")
#endif
	{
#ifdef mtf_coop_expsys
	if (attacker.coop_exp != -1 && attacker.classname == "player" && targ.is_monster == 1) {
		attacker.coop_exp += 10;
		MTF_Coop_AddExperience ( attacker, targ, FALSE );
		MTF_Coop_PreWriteExperience( attacker, attacker.connect_name, attacker.coop_exp );
	}
#endif
		if (attacker.classname == "teledeath")
		{
#ifdef mtf_coop
			if (targ.is_monster)
				bprint(TF_FLARE_OFF, GetMonsterPowers(targ, 0));
#endif
			bprint(TF_FLARE_OFF, targ.netname);
			bprint(TF_FLARE_OFF, " got in the way of ");
			bprint(TF_FLARE_OFF, attacker.owner.netname);
			bprint(TF_FLARE_OFF, "\n");
			if (attacker.owner.team_no != targ.team_no || attacker.owner.team_no < TF_FLARE_OFF)
			{
				attacker.owner.real_frags = attacker.owner.real_frags + TF_FLARE_OFF;
			}
			if (!(toggleflags & 128))
			{
				attacker.owner.frags = attacker.owner.real_frags;
			}
			return;
		}
		if (attacker.classname == "teledeath2")
		{
			bprint(TF_FLARE_OFF, "Satan's power deflects ");
			bprint(TF_FLARE_OFF, targ.netname);
			bprint(TF_FLARE_OFF, "'s telefrag\n");
			targ.real_frags = targ.real_frags - TF_FLARE_OFF;
			if (!(toggleflags & 128))
			{
				targ.frags = targ.real_frags;
			}
			logfrag(targ, targ);
			return;
		}
		if (attacker.classname == "info_tfgoal")
		{
			if (attacker.deathtype != "")
			{
				bprint(TF_FLARE_OFF, targ.netname);
				bprint(TF_FLARE_OFF, attacker.deathtype);
			}
			logfrag(targ, targ);
			return;
		}
#ifdef minipets
		if (attacker.classname == "player" || attacker.classname == "bot" || attacker.classname == "minifiend" || attacker.classname == "trip_bomb")
#else
		if (attacker.classname == "player" || attacker.classname == "bot")
#endif
		{
			if (targ == attacker)
			{
				attacker.real_frags = attacker.real_frags - TF_FLARE_OFF;
				if (!(toggleflags & 128))
				{
					attacker.frags = attacker.real_frags;
				}
				bprint(TF_FLARE_OFF, targ.netname);
				if (deathmsg == 8)
				{
					deathstring = " grenades herself.\n";
				}
				else
				{
				// BTF SELF-KILL DMSG
																if ((deathmsg == 65))
																{
																	deathstring = " Has no sense of direction.\n";
																}
																else
																{
												if ((deathmsg == 58))
												{
													deathstring = " Examines her torpedo too closely.\n";
												}
												else
												{
				// HELO Self-Kill MSGS
				if ((deathmsg == 69))
				{
					deathstring = " tries to ride a meteor.\n";
				}
				else
				{
				if ((deathmsg == 68))
				{
					deathstring = " Didnt get far enough from her bomb.\n";
				}
				else
				{
				if ((deathmsg == 55))
				{
					deathstring = " Had a stinger turn on her.\n";
				}
				else
				{
				if ((deathmsg == 50))
				{
					deathstring = " gets too close to her laser trip wire!\n";
				}
				else
				{
				if ((deathmsg == 59))
				{
					deathstring = " caught a chunk of shrapnel.\n";
				}
				else
				{
				if ((deathmsg == 67))
				{
					deathstring = " Had a sidewinder turn on her.\n";
				}
				else
				{

					if (deathmsg == 52)
					{
						deathstring = " tries to fly with her turretizing tesla.\n";
					}
					else
					{
					if (deathmsg == 43)
					{
						deathstring = " has herself bombed.\n";
					}
					else
					{
						if (deathmsg == 45)
						{
							deathstring = " hugs her proximity grenade.\n";
						}
						else
						{
							if (deathmsg == 9)
							{
								deathstring = " nails herself.\n";
							}
							else
							{
								if (deathmsg == 10)
								{
									deathstring = " is blown to bits.\n";
								}
								else
								{
									if (deathmsg == 11)
									{
										deathstring = " pipebombs herself...\nWhat a dumb-ass!\n";
									}
									else
									{
										if (deathmsg == 24)
										{
											deathstring = " gags on her own gas... pew!\n";
										}
										else
										{
											if (deathmsg == 30)
											{
												deathstring = " nukes her own ammo.\n";
											}
											else
											{
												if (deathmsg == 35)
												{
													deathstring = " flash grenade herself to death.\n";
												}
												else
												{
													if (deathmsg == 31)
													{
														deathstring = " detonates an ammo box too close to herself.\n";
													}
													else
													{
														if (deathmsg == 12)
														{
															deathstring = " detpacks herself\n That was smart!\n";
														}
														else
														{
															if (deathmsg == 13)
															{
																deathstring = " died impossibly!\n";
															}
															else
															{
																if (deathmsg == 6 || deathmsg == 59)
																{
																	if (rnum <= 0.5)
																	{
																		deathstring = " checks if her weapon is loaded,\n";
																	}
																	else
																	{
																		deathstring = " hates herself.\n";
																	}
																}
																else
																{
																	if (deathmsg == 41)
																	{
																		deathstring = "'s Laser Drone malfunctioned.\n";
																	}
																	else
																	{
																		if (deathmsg == 33)
																		{
																			deathstring = " chars herself with an incendiary rocket.\n";
																		}
																		else
																		{
																			if (deathmsg == 5)
																			{
																				deathstring = " tries to put the pin back in.\n";
																			}
																			else
																			{
																				if (deathmsg == 15)
																				{
																					if (attacker.playerclass == TF_FLARE_OFF)
																					{
																						deathstring = "'s JetPack malfunctions.\n";
																					}
																					else
																					{
																						deathstring = " bakes herself.\n";
																					}
																				}
																				else
																				{
																					if (deathmsg == 7 && targ.waterlevel > TF_FLARE_LIT)
																					{
																						bprint(TF_FLARE_OFF, " shocks herself to death.\n");
																						return;
																					}
																					else
																					{
																						if (deathmsg == 40)																					
																						{
																							deathstring = " couldn't outrun her air spam.\n";																							
																						}
																						else
																						{
																							if (deathmsg == 201)
																							{
																								deathstring = " used her dispenser for all the wrong reasons.\n";																								
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				} } } }	// BTF self-kill msgs
				} } } } }	// BTF Helo self-kill msgs
				}	// LTB
				bprint(TF_FLARE_OFF, deathstring);
				return;
			}
			else
			{
				if (teamplay && attacker.team_no == targ.team_no && attacker.team_no > 0)
				{
					if (attacker.team_no > 0 && attacker.team_no == targ.team_no)
					{
						attacker.real_frags = attacker.real_frags - TF_FLARE_OFF;
					}
					else
					{
						attacker.real_frags = attacker.real_frags + TF_FLARE_OFF;
					}
					if (!(toggleflags & 128))
					{
						attacker.frags = attacker.real_frags;
					}
					if (rnum < 0.25)
					{
						deathstring = " mows down a teammate.\n";
					}
					else
					{
						if (rnum < 0.5)
						{
							deathstring = " checks her glasses.\n";
						}
						else
						{
							if (rnum < 0.75)
							{
								deathstring = " gets a frag for the other team.\n";
							}
							else
							{
								deathstring = " loses another friend.\n";
							}
						}
					}
					if (deathmsg == 23)
					{
						bprint(TF_FLARE_OFF, targ.netname);
						bprint(TF_FLARE_OFF, " didn't survive the operation.\n");
						return;
					}
					bprint(TF_FLARE_OFF, attacker.netname);
					bprint(TF_FLARE_OFF, deathstring);
					return;
				}
				else
				{
					attacker.real_frags = attacker.real_frags + TF_FLARE_OFF;
					logfrag(attacker, targ);
					if (!(toggleflags & 128))
					{
						attacker.frags = attacker.real_frags;
					}
#ifdef mtf_coop
					if (deathmsg == 449)
					{
						deathstring = " was shredded by ";
						deathstring2 = "'s chainsaw.\n";
					}
#endif
					if (deathmsg == 43)
					{
						deathstring = " was bombed by ";
						deathstring2 = "'s air strike call.\n";
					}
					if (deathmsg == 59)
					{
						deathstring = " blows up with ";
						deathstring2 = " for king and country!\n";
					}
					// AAGUN
					if ((deathmsg == 65))
					{
						deathstring = " feels the hot lead of ";
						deathstring2 = "'s AAGUN.\n";
					}
// Gen deathMSG
					// BTF Kill MSG (VEHICLES)
					if ((deathmsg == 58))
					{
						deathstring = " Is made into fish chum by ";
						deathstring2 = "'s torpedo.\n";
					}
					// BTF Helo Kill
					if ((deathmsg == 57))
					{
						deathstring = " got too close to ";
						deathstring2 = "'s rotor blade.\n";
					}
					if ((deathmsg == 56))
					{
						deathstring = " eats too much lead from ";
						deathstring2 = "'s 30mm rotary cannon.\n";
					}
					if ((deathmsg == 55))
					{
						deathstring = " was stung by ";
						deathstring2 = "'s stinger.\n";
					}
					if ((deathmsg == 68))
					{
						deathstring = " was pounded by ";
						deathstring2 = "'s bomb.\n";
					}
					if (((deathmsg == 67) || (deathmsg == 66)))
					{
						deathstring = " was caught by ";
						deathstring2 = "'s sidewinder.\n";
					}
					if ((deathmsg == 50))
					{
						deathstring = " is smeared all over the walls by ";
						deathstring2 = "'s laser trip wire!\n";
					}
					if (deathmsg == 45)
					{
						deathstring = " gets too friendly with ";
						deathstring2 = "'s Proxi grenade.\n";
					}
					if (deathmsg == 46)
					{
						deathstring = " gets shredded by ";
						deathstring2 = "'s 20mm cannon.\n";
					}
					if (deathmsg == 446)
					{
						deathstring = " has the crap beaten out of him by ";
						deathstring2 = "'s bat.\n";
					}
					if (deathmsg == 447)
					{
						deathstring = " is taken out gangsta style by ";
						deathstring2 = ".\n";
					}
					if ((deathmsg == 44.000000))
					{
						deathstring = "'s forgot to say adios to ";
						deathstring2 = "'s auto sentry gun.\n";
					}
					if ((deathmsg == 202))
					{
						deathstring = "'s ass was clamped off by ";
						deathstring2 = "'s bear trap.\n";
					}
					if ((deathmsg == 203))
					{
						deathstring = "'s chokes to death on ";
						deathstring2 = "'s bad ass queefs.\n";
					}					
					if ((deathmsg == 204))
					{
						deathstring = "'s was torn to shreds by ";
						deathstring2 = "'s gravity well.\n";
					}
					if (deathmsg == 8)
					{
						deathstring = " tries to hatch ";
						deathstring2 = "'s grenade.\n";
					}
					if (deathmsg == 100)
					{
						deathstring = " is fried by ";
						deathstring2 = "'s lightning gun.\n";
					}
					else
					{
						if (deathmsg == 9)
						{
							deathstring = " gets perforated by ";
							deathstring2 = "'s nail grenade.\n";
						}
						else
						{
							if (deathmsg == 10)
							{
								deathstring = " gets juiced by ";
								deathstring2 = "'s Mirv grenade.\n";
							}
							else
							{
								if (deathmsg == 40)
								{
									deathstring = " is shreaded by ";
									deathstring2 = "'s AirMirv.\n";
								}
								else
								{
									if (deathmsg == 11)
									{
										deathstring = " is shreded by ";
										deathstring2 = "'s pipebomb trap.\n";
									}
									else
									{
										if (deathmsg == 24)
										{
											deathstring = " sniffs to much of ";
											deathstring2 = "'s glue.\n";
										}
										else
										{
											if (deathmsg == 30)
											{
												deathstring = "'s gets vaporized by ";
												deathstring2 = "'s EMP grenade.\n";
											}
											else
											{
												if (deathmsg == 35)
												{
													deathstring = "'s brain is fried by ";
													deathstring2 = "'s flash grenade.\n";
												}
												else
												{
													if (deathmsg == 31)
													{
														deathstring = " stands near some ammo as ";
														deathstring2 = "'s EMP nukes it.\n";
													}
													else
													{
														if (deathmsg == 12)
														{
															deathstring = " is nuked by ";
															deathstring2 = "'s detpack.\n";
														}
														else
														{
															if (deathmsg == 16)
															{
																deathstring = " cut the red wire of ";
																deathstring2 = "'s detpack.\n";
															}
															else
															{
																if (deathmsg == 13)
																{
																	deathstring = " dies from ";
																	deathstring2 = "'s social disease.\n";
																	sound(targ, 0, "player/mpain6.wav", TF_FLARE_OFF, TF_FLARE_OFF);
																}
																else
																{
																	if (deathmsg == 14)
																	{
																		deathstring = " escapes infection from ";
																		deathstring2 = " by dying first.\n";
																	}
																	else
																	{
																		if (deathmsg == 5)
																		{
																			deathstring = " swallows ";
																			deathstring2 = "'s grenade.\n";
																			if (targ.health < -40)
																			{
																				deathstring = " was split in half by ";
																				deathstring2 = "'s grenade.\n";
																			}
																		}
																		else
																		{
																			if (deathmsg == 6)
																			{
																				deathstring = " is reamed by ";
																				deathstring2 = "'s rocket.\n";
																				if (targ.health < -40)
																				{
																					deathstring = "'s bunghole was ripped by ";
																					deathstring2 = "'s rocket.\n";
																				}
																			}
																			else
																			{
																				if (deathmsg == 41)
																				{
																					deathstring = " was killed by ";
																					deathstring2 = "'s Laser Drone.\n";
																					if (targ.health < -40)
																					{
																						deathstring = " was vaporized by ";
																						deathstring2 = "'s Laser Drone.\n";
																					}
																				}
																				else
																				{
																					if (deathmsg == 42)
																					{
																						deathstring = " was torn up by an enemy Rottweiler";
																						deathstring2 = ".\n";
																					}
																					else
																					{
																						if (deathmsg == 44)
																						{
																							deathstring = " was lethally demoralized by an enemy autoturret";
																							deathstring2 = ".\n";
																						}
																						else
																						{
																							if (deathmsg == 15)
																							{
																								if (rnum < 0.2)
																								{
																									deathstring = " burns to death by ";
																									deathstring2 = "'s flame.\n";
																								}
																								else
																								{
																									if (rnum < 0.4)
																									{
																										deathstring = " is fried by ";
																										deathstring2 = "'s fire.\n";
																									}
																									else
																									{
																										if (rnum < 0.6)
																										{
																											deathstring = " is boiled alive by ";
																											deathstring2 = "'s heat.\n";
																										}
																										else
																										{
																											if (rnum < 0.8)
																											{
																												deathstring = " is cremated by ";
																												deathstring2 = "'s incinerator.\n";
																											}
																											else
																											{
																												deathstring = " is grilled by ";
																												deathstring2 = "'s BBQ.\n";
																											}
																										}
																									}
																								}
																							}
																							else
																							{
																								if (deathmsg == 17)
																								{
																									if (attacker.playerclass == 8)
																									{
																										deathstring = " was stabbed by ";
																									}
																									else
																									{
																										deathstring = " was slit open by ";
																									}
																									deathstring2 = ".\n";
																								}
																								else
																								{
																									if (deathmsg == 32)
																									{
																										deathstring = " was spanner-whacked by ";
																										deathstring2 = ".\n";
																									}
																									else
																									{
																										if (deathmsg == TF_FLARE_OFF)
																										{
																											deathstring = " was swiss-cheesed by ";
																											deathstring2 = "'s bird gun.\n";
																										}
																										else
																										{
																											if (deathmsg == 2)
																											{
																												deathstring = "'s head is popped by ";
																												deathstring2 = "'s shotgun.\n";
																											}
																											else
																											{
																												if (deathmsg == 3)
																												{
																													deathstring = " was bustacapped by ";
																													deathstring2 = ".\n";
																												}
																												else
																												{
																													if (deathmsg == 4)
																													{
																														deathstring = " was perforated by ";
																														deathstring2 = "'s lava nailgun.\n";
																													}
																													else
																													{
																														if (deathmsg == 7)
																														{
																															deathstring = " swims with ";
																															deathstring2 = "'s toaster.\n";
																														}
																														else
																														{
																															if (deathmsg == 21)
																															{
																																deathstring = " grappled with ";
																																deathstring2 = ".\n";
																															}
																															else
																															{
																																if (deathmsg == 18)
																																{
																																	if (rnum <= 0.3)
																																	{
																																		deathstring = " gets a sucking chest wound from ";
																																		deathstring2 = ".\n";
																																	}
																																	else
																																	{
																																		if (rnum <= 0.6)
																																		{
																																			deathstring = "'s liver is blown out by ";
																																			deathstring2 = ".\n";
																																		}
																																		else
																																		{
																																			deathstring = "'s chest explodes from ";
																																			deathstring2 = "'s sniper round.\n";
																																		}
																																	}
																																}
																																else
																																{
																																	if (deathmsg == 29)
																																	{
																																		if (rnum <= 0.5)
																																		{
																																			deathstring = " is beheaded by ";
																																			deathstring2 = "'s round.\n";
																																		}
																																		else
																																		{
																																			deathstring = "'s labotomized by ";
																																			deathstring2 = "'s sniper round.\n";
																																		}
																																	}
																																	else
																																	{
																																		if ((deathmsg == 51))
																																		{
																																			if ((rnum <= 0.5))
																																			{
																																				deathstring = " was shocked to death by ";
																																				deathstring2 = "'s tesla coil.\n";
																																			}
																																			else
																																			{
																																				deathstring = "'s was obliterated by ";
																																				deathstring2 = "'s tesla coil.\n";
																																			}
																																		} else {
																																										if ((deathmsg == 52))
																																										{
																																											if ((rnum < 0.5))
																																											{
																																												deathstring = " is disintegrated by ";
																																												deathstring2 = "'s Sentry Point Defense System.\n";
																																											}
																																											else
																																											{
																																												deathstring = " is obliterated by ";
																																												deathstring2 = "'s sentry gun.\n";
																																											}
																																										}
#ifdef mtf_coop																																									
	else if (deathmsg == 1124)
	{
		deathstring = " is pinned by ";
		deathstring2 = "'s needler.\n";
	}
	else {
// megatf coop new weapons death messages
#elseif
																																										else {
#endif																																										
																																		if (deathmsg == 28)
																																		{
																																			if (rnum <= 0.5)
																																			{
																																				deathstring = " is neutered by ";
																																				deathstring2 = ".\n";
																																			}
																																			else
																																			{
																																				deathstring = "'s legs explode open from ";
																																				deathstring2 = "'s shot.\n";
																																			}
																																		}
																																		else
																																		{
																																			if (deathmsg == 19)
																																			{
																																				deathstring = " enjoys ";
																																				deathstring2 = "'s machinegun.\n";
																																			}
																																			else
																																			{
																																				if (deathmsg == 20)
																																				{
																																					deathstring = " torso is removed by ";
																																					deathstring2 = ".\n";
																																				}
																																				else
																																				{
																																					if (deathmsg == 22)
																																					{
																																						deathstring = " is ass-knifed by ";
																																						deathstring2 = ".\n";
																																						sound(targ, 0, "player/mpain6.wav", TF_FLARE_OFF, TF_FLARE_OFF);
																																					}
																																					else
																																					{
																																						if (deathmsg == 25)
																																						{
																																							deathstring = " is over-dosed by ";
																																							deathstring2 = "'s ludes.\n";
																																						}
																																						else
																																						{
																																							if (deathmsg == 26)
																																							{
																																								deathstring = " spews juice thru holes from ";
																																								deathstring2 = "'s railgun.\n";
																																							}
																																							else
																																							{
																																								if (deathmsg == 33)
																																								{
																																									deathstring = " gets cooked by ";
																																									deathstring2 = "'s incendiary rocket.\n";
																																								} 
																																								else
																																								{
																																									if (deathmsg == 200)
																																									{
																																										deathstring = "'s leg was amputated by ";
																																										deathstring2 = "'s spike.\n";
																																									}
																																									else
																																									{
																																										if (deathmsg == 201)
																																										{
																																											deathstring = " thought ";
																																											deathstring2 = "'s dispenser was a mechanical bull.\n";
																																										}
																																									}
																																								}
																																							}
																																						}
																																					}
																																				}
																																			}
																																		}
																																	}
																																}
																															}
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						} } }
					}
#ifdef mtf_coop
					if (targ.is_monster)
						bprint(TF_FLARE_OFF, GetMonsterPowers(targ, 0));
#endif
					bprint(TF_FLARE_OFF, targ.netname);
#ifdef mtf_coop
					if (targ.is_monster)
						if (targ.lives > 0) {
							bprint(2, "(");
							bprint(2, ftos(targ.lives));
							bprint(2, ")");
						}
#endif
					bprint(TF_FLARE_OFF, deathstring);
#ifdef mtf_coop
					if (attacker.is_monster)
						bprint(TF_FLARE_OFF, GetMonsterPowers(attacker, 0));
#endif
#ifdef mtf_coop
// dual kill code (yes i know there's a separate endif here.. it's for reminders' sake :p)
					if (targ.is_monster == 1 && targ.#other_attacker != world && targ.#other_attacker != attacker && targ.#other_attacker.classname == "player")
					{
						bprint(TF_FLARE_OFF, targ.#other_attacker.connect_name);
						bprint(TF_FLARE_OFF, " and ");
						targ.#other_attacker = world;
					}
#endif
					bprint(TF_FLARE_OFF, attacker.netname);
					bprint(TF_FLARE_OFF, deathstring2);
				}
			}
			return;
		}
		else
		{
			if (((attacker.classname == "building_sentrygun") || (attacker.classname == "building_tesla")))
			{
				if (targ == attacker.real_owner)
				{
					if ((deathmsg == 34))
					{
						deathstring = " gets wasted by her sentry gun\nDumb-ass!\n";
					}
					else
					{
						if ((deathmsg == 27))
						{
							deathstring = " crossed her sentry gun's line of fire.\n";
						}
						else
						{
							if ((deathmsg == 52))
							{
								deathstring = " was electrocuted by her own tesla coil.\n";
							}
						}
					}
					bprint(TF_FLARE_OFF, targ.netname);
					bprint(TF_FLARE_OFF, deathstring);
				}
				else
				{
					attacker.real_owner.real_frags = attacker.real_owner.real_frags + TF_FLARE_OFF;
					logfrag(attacker.real_owner, targ);
					if (!(toggleflags & 128))
					{
						attacker.real_owner.frags = attacker.real_owner.real_frags;
					}
					if (deathmsg == 34)
					{
						deathstring = " is creamed by ";
						deathstring2 = "'s sentry gun.\n";
					}
					else
					{
						if (deathmsg == 27)
						{
							deathstring = "'s spine is extracted by ";
							deathstring2 = "'s sentry gun.\n";
						}
					}
#ifdef mtf_coop
local entity te;
				if (targ.is_monster != 1 && attacker.is_monster == 1 || attacker.classname == "monster_boss") {
	te = find ( world, classname, "monster_score" );
	if (te.netname == "Monsters") {
		te.frags += 1;
		svcUpdateFrags (te.fClientNo, te.frags);
	}
				}
#ifdef mtf_coop_expsys
	if (attacker.real_owner.coop_exp != -1 && attacker.real_owner.classname == "player" && targ.is_monster == 1) {
		attacker.real_owner.coop_exp = attacker.real_owner.coop_exp + 10;
		MTF_Coop_AddExperience ( attacker.real_owner, targ, FALSE );
		MTF_Coop_PreWriteExperience( attacker.real_owner, attacker.real_owner.connect_name, attacker.real_owner.coop_exp );
	}
#endif
					if (targ.is_monster)
						bprint(TF_FLARE_OFF, GetMonsterPowers(targ, 0));
#endif
					bprint(TF_FLARE_OFF, targ.netname);
					bprint(TF_FLARE_OFF, deathstring);
					bprint(TF_FLARE_OFF, attacker.real_owner.netname);
					bprint(TF_FLARE_OFF, deathstring2);
				}
			}
			else
			{
				logfrag(targ, targ);
#ifdef mtf_coop
				if (attacker.is_monster != 1)
					targ.real_frags = targ.real_frags - TF_FLARE_OFF;
#else
				targ.real_frags = targ.real_frags - TF_FLARE_OFF;
#endif
				if (!(toggleflags & 128))
				{
					targ.frags = targ.real_frags;
				}
				rnum = targ.watertype;
#ifdef mtf_coop
				if (targ.is_monster == 1)
					bprint(2, GetMonsterPowers(targ, 1));
				else
#endif
				bprint(2, targ.netname);
				if (rnum == -3)
				{
					if (random() < 0.5)
					{
						deathstring = " can't swim worth a crap!\n";
					}
					else
					{
						deathstring = " can't breathe water.\n";
					}
				}
				else
				{
					if (rnum == -4)
					{
						if (random() < 0.5)
						{
							deathstring = " gulped a load of Mt. Dew.\n";
						}
						else
						{
							deathstring = " took a dive in the Texas trucker mattress squeezings.\n";
						}
					}
					else
					{
						if (rnum == -5)
						{
							if (targ.health < -15)
							{
								deathstring = " burst into flames.\n";
							}
							else
							{
								if (random() < 0.5)
								{
									deathstring = " turned into hot slag.\n";
								}
								else
								{
									deathstring = " visits the Hell fires.\n";
								}
							}
						}
						else
						{
							if (attacker.classname == "monster_dog")
							{
								deathstring = " was mauled by a Rottweiler.\n";
							}
							else
							{
								if (attacker.classname == "explo_box")
								{
									deathstring = " blew up.\n";
								}
								else
								{
									if (attacker.solid == 4 && attacker != world)
									{
										deathstring = " was crushed.\n";
									}
									else
									{
										if (targ.deathtype == "falling")
										{
											targ.deathtype = "";
											deathstring = " fell to her death.\n";
										}
										else
										{
											if (attacker.classname == "trap_shooter" || attacker.classname == "trap_spikeshooter")
											{
												deathstring = " was shot.\n";
											}
											else
											{
												if (attacker.classname == "fireball")
												{
													deathstring = " ate a lavaball.\n";
												}
												else
												{
												if (deathmsg == 69)
												{
													deathstring = " tried to ride a meteor.\n";
												}
												else
												{
												if (deathmsg == 59)
												{
													deathstring = " caught a chunk of shrapnel.\n";
												}
												else
												{
													if (attacker.classname == "trigger_changelevel")
													{
														deathstring = " tried to leave.\n";
													}
#ifndef mtf_coop
													if (attacker.classname == "monster_shambler")
													{
														deathstring = " was shambled baby!\n";	
													}
#endif
													else
													{
#ifdef mtf_coop
														if (attacker.classname == "func_monsterkill") {
															if (attacker.netname_broadcast != "none")
																deathstring = attacker.netname_broadcast;
														}
														else if (targ.classname != "player") {
															if (random() > .5) {	
																deathstring = strcat(" died in an unfortunate gardening accident (", attacker.classname);
																deathstring = strcat(deathstring, ").\n");
															}
															else if (random() > .5) {
																deathstring = strcat(" flew into a wall and went splat :(  (", attacker.classname);
																deathstring = strcat(deathstring, ").\n");
															}
															else if (random() > .5) {
																deathstring = strcat(" drove her chevy THROUGH the levy (", attacker.classname);
																deathstring = strcat(deathstring, ").\n");
															}
															else {
																deathstring = strcat(" got a BSOD (", attacker.classname);
																deathstring = strcat(deathstring, ").\n");
															}
														}
														else
															deathstring = " died.\n";
#else
														deathstring = " died.\n";
#endif
													}
												} } }
											}
										}
									}
								}
							}
						}
					}
				}
#ifdef mtf_coop
				if (targ.is_monster != 1 && attacker.is_monster == 1 || attacker.classname == "monster_boss") {
	te = find ( world, classname, "monster_score" );
	if (te.netname == "Monsters") {
		if (targ.deathtype != "monster_respawn") {
			te.frags += 1;
			svcUpdateFrags (te.fClientNo, te.frags);
		}
	}
				}
				if (targ.deathtype == "monster_respawn") {
					deathstring = strcat(" was telefragged by a ", GetMonsterPowers(attacker, 2));
					targ.deathtype = string_null;
				}
				else if (targ.deathtype == "monster_respawn") {
					deathstring = attacker.netname_broadcast;
					targ.deathtype = string_null;
				}
				else if (attacker.classname == "monster_army")
					deathstring = strcat(" was shot by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_demon1")
					deathstring = strcat(" was eviscerated by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_dog")
					deathstring = strcat(" was mauled by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_dragon")
					deathstring = strcat(" was fried by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_enforcer")
					if (attacker.weapon & 16)//#MWEAPON_SNIPER)
						deathstring = strcat(" was blasted by a ", GetMonsterPowers(attacker, 2));
					else
						deathstring = strcat(" was blasted by an ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_fish")
					deathstring = strcat(" was fed to the ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_hell_knight")
					deathstring = strcat(" was slain by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_knight")
					deathstring = strcat(" was slashed by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_ogre" || attacker.classname == "monster_ogre_marksman")
					deathstring = strcat(" was destroyed by an ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_boss")
					deathstring = " burns in the flames of chthon\n";
				else if (attacker.classname == "monster_killable_boss")
					deathstring = " burns in the flames of uber chthon\n";
				else if (attacker.classname == "monster_oldone")
					deathstring = " became one with Shub-Niggurath\n";
				else if (attacker.classname == "monster_shalrath")
					deathstring = strcat(" was exploded by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_shambler")
					deathstring = strcat(" was smashed by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_tarbaby")
					deathstring = strcat(" was slimed by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_vomit")
					deathstring = strcat(" was vomited on by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_wizard")
					deathstring = strcat(" was scragged by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_zombie")
					deathstring = strcat(" joins the ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_azoth")
deathstring = strcat(" was vanquished by ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_vermis")
deathstring = strcat(" was eradicated by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_spider")
deathstring = strcat(" was desiccated by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_juggernaut")
deathstring = strcat(" was crushed by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_ubs")
deathstring = strcat(" was uberscragged by an ", GetMonsterPowers(attacker, 2));
				if ((attacker.classname == "monster_gaunt"))
				{
					if ((attacker.enemy.deathtype == "swoop"))
					{
						deathstring = strcat(" died in the clutches of a ", GetMonsterPowers(attacker, 2));
					}
					else
					{
						deathstring = strcat(" was charred by a ", GetMonsterPowers(attacker, 2));
					}
				}
				else if (attacker.classname == "monster_voreling")
					deathstring = strcat(" was violated by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_deathguard")
					deathstring = strcat(" was slaughtered by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_death_lord")
					deathstring = strcat(" was executed by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_polyp")
					deathstring = strcat(" was popped by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_drole")
					deathstring = strcat(" was decimated by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_gug")
					deathstring = strcat(" was obliterated by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.classname == "monster_bob")
					deathstring = strcat(" was zapped by a ", GetMonsterPowers(attacker, 2));
#endif
#ifdef mtf_coop_hipnotic
			else if (attacker.classname == "monster_gremlin")
deathstring = strcat("  was outsmarted by a ", GetMonsterPowers(attacker, 2));
			bprint ("Gremlin.\n");
			else if (attacker.classname == "monster_scourge")
deathstring = strcat(" was stung by a ", GetMonsterPowers(attacker, 2));
				bprint ("Centroid.\n");
            else if (attacker.classname == "monster_armagon")
deathstring = strcat(" was outgunned by ", GetMonsterPowers(attacker, 2));
				bprint ("Armagon.\n");
			else if (attacker.classname == "trap_spike_mine")
deathstring = strcat(" was blasted by a ", GetMonsterPowers(attacker, 2));
#endif
#ifdef mtf_coop_rogue
				else if ((attacker.classname == "monster_eel"))
				{
deathstring = strcat(" was electrified by an ", GetMonsterPowers(attacker, 2));
				}
				else if ((attacker.classname == "monster_wrath"))
				{
deathstring = strcat(" was disintegrated by a ", GetMonsterPowers(attacker, 2));
				}
				else if ((attacker.classname == "monster_super_wrath"))
				{
deathstring = strcat(" was obliterated by an ", GetMonsterPowers(attacker, 2));
				}
				else if ((attacker.classname == "monster_sword"))
				{
deathstring = strcat(" was slit open by a ", GetMonsterPowers(attacker, 2));
				}
				else if ((attacker.classname == "monster_lava_man"))
				{
deathstring = strcat(" fries in the fury of ", GetMonsterPowers(attacker, 2));
				}
				else if ((attacker.classname == "monster_morph"))
				{
deathstring = strcat(" was crushed by a ", GetMonsterPowers(attacker, 2));
				}
				else if ((attacker.classname == "monster_mummy"))
				{
deathstring = strcat(" was was mummified by a ", GetMonsterPowers(attacker, 2));
				}
#endif
#ifdef mtf_coop
				else if (attacker.classname == "monster_cyberdemon")
					deathstring = strcat(" was shot into Doom II by a ", GetMonsterPowers(attacker, 2));
				else if (attacker.netname != "" && attacker != world && deathstring == " died\n")
				{
					deathstring = GetMonsterDeathstring(attacker.classname);
					deathstring = strcat(deathstring, GetMonsterPowers(attacker, 2));
				}
				else if (deathstring == " died\n") {
					deathstring = frik_strcat(" met an uncertain fate (", attacker.classname, ").\n");
					targ.ammo_cells = 666;	// hackish, but so we know the player died by a trigger_hurt for survival mode dummy
				}
#endif
				bprint(TF_FLARE_OFF, deathstring);
			}
		}
	}
	else
	{
		if (((targ.classname == "building_sentrygun") || (targ.classname == "building_tesla")))
		{
			if ((attacker.classname == "teledeath"))
			{
				bprint (TF_FLARE_OFF, targ.real_owner.netname);
				bprint (TF_FLARE_OFF, "'s sentrygun was telefragged by ");
				bprint (TF_FLARE_OFF, attacker.owner.netname);
				bprint (TF_FLARE_OFF, ".\n");
				return;
			}
			if ((attacker.classname == "player"))
			{
				if ((attacker == targ.real_owner))
				{
					bprint (TF_FLARE_OFF, targ.real_owner.netname);
					bprint (TF_FLARE_OFF, " self destructs her sentrygun.\n");
					return;
				}
				bprint (TF_FLARE_OFF, targ.real_owner.netname);
				if ((targ.classname == "building_sentrygun"))
				{
					bprint (TF_FLARE_OFF, "'s sentrygun was no match for ");
				}
				else
				{
					bprint (TF_FLARE_OFF, "'s tesla coil was no match for ");
				}
				bprint (TF_FLARE_OFF, attacker.netname);
				bprint (TF_FLARE_OFF, ".\n");
				logfrag (attacker, targ.real_owner);
				if (((attacker.team_no > TF_FLARE_LIT) && (attacker.team_no != targ.real_owner.team_no)))
				{
					attacker.real_frags = (attacker.real_frags + TF_FLARE_OFF);
					logfrag (attacker, targ.real_owner);
					if (!(toggleflags & 128))
					{
						attacker.frags = attacker.real_frags;
					}
				}
				return;
			}
		}
	}
};
//END
