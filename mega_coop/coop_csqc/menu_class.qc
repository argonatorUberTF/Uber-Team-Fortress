float(float pc, float meflag_a, float meflag_b) IsLegalClass = 
{
	local float bit;
	if (pc == 1)
	{
		bit = 1;
	}
	else
	{
		if (pc == 2)
		{
			bit = 2;
		}
		else
		{
			if (pc == 3)
			{
				bit = 4;
			}
			else
			{
				if (pc == 4)
				{
					bit = 8;
				}
				else
				{
					if (pc == 5)
					{
						bit = 16;
					}
					else
					{
						if (pc == 6)
						{
							bit = 32;
						}
						else
						{
							if (pc == 7)
							{
								bit = 64;
							}
							else
							{
								if (pc == 8)
								{
									bit = 256;
								}
								else
								{
									if (pc == 9)
									{
										bit = 512;
									}
									else
									{
										if (pc == 10)
										{
											bit = 128;
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
	if (meflag_a & bit || meflag_b & bit)
	{
		return MENUFLAG_DISABLED;
	}
	return 0;
};
void (float meflag_a, float meflag_b) Menu_ClassSelect =
{
	local vector men;
	local vector but_size;
	local float class_enabled;
	men_x = vid_conwidth*0.1;
	men_y = vid_conheight*0.15;
	but_size = '120 35 0';
	
	if (meflag_a == 666)
{		// hehe, civ menu :)
		CreateButton( "1. Civilian!", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled);
		return;
	}
	
	InitMenu( "menu_class_select", 0 );
	class_enabled = IsLegalClass(1, meflag_a, meflag_b);
	CreateButton( "1. Scout", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(2, meflag_a, meflag_b);
	CreateButton( "2. Sniper", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(3, meflag_a, meflag_b);
	CreateButton( "3. Soldier", 		"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(4, meflag_a, meflag_b);
	CreateButton( "4. Demoman", 		"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(5, meflag_a, meflag_b);
	CreateButton( "5. Medic", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(6, meflag_a, meflag_b);
	CreateButton( "6. HWGuy", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(7, meflag_a, meflag_b);
	CreateButton( "7. Pyro", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(8, meflag_a, meflag_b);
	CreateButton( "8. Spy", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(9, meflag_a, meflag_b);
	CreateButton( "9. Engineer", 		"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled); men_y+=but_size_y;
	class_enabled = IsLegalClass(10, meflag_a, meflag_b);
	CreateButton( "0. Random", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, class_enabled);
};
void () Menu_SpySpecial =
{
	local vector men;
	local vector but_size;
	men_x = 0;
	men_y = vid_conheight*0.2;
	but_size = '160 35 0';
	InitMenu( "menu_spy_special", 0 );
	CreateButton( "1. Change Skin", 		"default", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "2. Change Color", 		"default", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "3. Start Feigning", 		"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "4. Nothing", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
};
void () Menu_SpyChangeColor =
{
	local vector men;
	local vector but_size;
	men_x = 0;
	men_y = vid_conheight*0.2;
	but_size = '160 35 0';
	
	InitMenu( "menu_spy_special_cc", 0 );
	CreateButton( "1. Change Skin", 		"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "2. Change Color >", 		"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "3. Start Feigning", 		"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "4. Nothing", 			"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	
	men_y-=but_size_y*3;
	men_x+=but_size_x;
	CreateButton( "1. Team Blue", 			"impulse 1", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "2. Team Red", 			"impulse 2", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
};
void () Menu_SpyChangeSkin =
{
	local vector men;
	local vector but_size;
	men_x = 0;
	men_y = vid_conheight*0.2;
	but_size = '160 35 0';
	
	InitMenu( "menu_spy_special_cs", 0 );
	CreateButton( "1. Change Skin >", 		"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "2. Change Color", 		"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "3. Start Feigning", 		"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	CreateButton( "4. Nothing", 			"special", men, "progs/csqc/csqcguiback.tga", but_size, MENUFLAG_BRANCH); men_y+=but_size_y;
	men_y-=but_size_y*4;
	men_x+=but_size_x;
	CreateButton( "1. Scout", 			"impulse 1", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "2. Sniper", 			"impulse 2", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "3. Soldier", 		"impulse 3", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "4. Demoman", 		"impulse 4", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "5. Medic", 			"impulse 5", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "6. HEGuy", 			"impulse 6", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "7. Pyro", 			"impulse 7", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "8. Spy", 			"impulse 8", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "9. Engineer", 		"impulse 9", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
};
void (float cno, vector text_startpos) TF_Class_Info =
{
	local string l1,l2,l3,l4,l5,l6,l7,l8;
	switch (cno)
{
		case 1:
			l1 = "The scout is maneuverable and fast.";
			l2 = "This class is primarily used for flag";
			l3 = "capture and confusing the enemy.";
			l4 = "";
			l5 = "\sWeapons:\s Shotgun, Nailgun";
			l6 = "\sGrenades:\s Flash (gren1), Conc (gren2)";
			l7 = "\sSpecial:\s None";
			break;
		case 2:
			l1 = "The sniper is the the ideal class for";
			l2 = "long-distance defense, but his lack of";
			l3 = "close-range weaponry means he's got";
			l4 = "trouble if the opponent should get";
			l5 = "within range.";
			l7 = "\sWeapons:\s Shotgun, Sniper Rifle";
			l8 = "\sGrenades:\s Flash (gren1), Conc (gren2)";
			break;
		case 3:
			l1 = "The Soldier class is the basis of a UberTF";
			l2 = "team. He moves slower than most";
			l3 = "classes, but makes up for it with the";
			l4 = "weaponry and armor he carries.";
			l6 = "\sWeapons:\s Shotgun, SSG, Rocket Launcher";
			l7 = "\sGrenades:\s Flash (gren1), Conc (gren2)";
			break;
	}
	drawstring(text_startpos, l1, '8 8 0', '1 1 1', 1);
	drawstring(text_startpos + '0 8 0', l2, '8 8 0', '1 1 1', 1);
	drawstring(text_startpos + '0 16 0', l3, '8 8 0', '1 1 1', 1);
	drawstring(text_startpos + '0 24 0', l4, '8 8 0', '1 1 1', 1);
	drawstring(text_startpos + '0 32 0', l5, '8 8 0', '1 1 1', 1);
	drawstring(text_startpos + '0 40 0', l6, '8 8 0', '1 1 1', 1);
	drawstring(text_startpos + '0 48 0', l7, '8 8 0', '1 1 1', 1);
	drawstring(text_startpos + '0 56 0', l8, '8 8 0', '1 1 1', 1);
};
void () Menu_TestMenu =
{
	local vector men;						// position of the first menu button
	local vector but_size;					// size of all the buttons
	local string buttonback;				// Button image
	but_size = '160 35 0';
	men_x = (vid_conwidth*0.5) - (but_size_x*0.5);		// first button will be displayed in the dead center of the horizontal area
	men_y = vid_conheight*0.2;							// first button will be displayed 20% of the vertical value from the top of the screen
	buttonback = "progs/csqc/csqcguiback.tga";
	InitMenu( "menu_testme", 0 );
	CreateButton( "Fire!", 				"+attack\n;testmenu",  									men, buttonback, but_size, 0); men_y+=but_size_y;
	CreateButton( "Jump!", 				"+jump\n;testmenu",		 								men, buttonback, but_size, 0); men_y+=but_size_y;
	CreateButton( "Say Cheese!", 		"say cheese\n;testmenu", 			 					men, buttonback, but_size, 0); men_y+=but_size_y;
	CreateButton( "Go Apes**t!", 		"cl_yawspeed 2000\n;+right\n;testmenu", 				men, buttonback, but_size, 0); men_y+=but_size_y;
	CreateButton( "Back to normal!!", 	"cl_yawspeed 5\n;-right\n;-jump\n;-attack\n;testmenu", 	men, buttonback, but_size, 0); men_y+=but_size_y;
};
void (float mn_flags) Menu_DropdownMenu =
{
	local vector men;						// position of the first menu button
	local vector but_size;					// size of all the buttons
	local string buttonback;				// Button image
	local float button_flag;
	if (mn_flags > 0)
		button_flag = MENUFLAG_DISABLED;		// disable the other buttons when the drop-down menu is active
	but_size = '145 35 0';
	men_x = vid_conwidth*0.1;
	men_y = vid_conheight*0.2;							// first button will be displayed 20% of the vertical value from the top of the screen
	buttonback = "progs/csqc/csqcguiback.tga";
	
	InitMenu( "menu_dropdown", 0 );
	CreateButton( "Say This!", 			"say this!\n;clearmenu",men, buttonback, but_size, 				button_flag); 		men_x+=but_size_x;
	CreateButton( "Say That!", 			"say that!\n;clearmenu",men, buttonback, but_size, 				button_flag); 		men_x+=but_size_x;
	CreateButton( "More Options", 		"nothing", 				men, buttonback, but_size - '25 0 0', 	MENUFLAG_DISABLED); men_x+=but_size_x - 25;
	if (mn_flags > 0)
		CreateButton( "-",			"testmenu2",			men, buttonback, '25 35 0',				MENUFLAG_BRANCH);
	else
		CreateButton( "+",			"testmenu2 1",			men, buttonback, '25 35 0',				MENUFLAG_BRANCH);	
	if (mn_flags > 0)
{
		men_x-=(but_size_x - 25);	//
		men_y+=but_size_y;			// draw new menu items below the "More Options" button
	}
	else
		men = -2*but_size;		// spawn menus off the screen
		
	CreateButton( "Fire!", 	"+attack\n;testmenu",  	men, buttonback, but_size, 0); men_y+=but_size_y;
	CreateButton( "Jump!", 	"+jump\n;testmenu",		men, buttonback, but_size, 0); men_y+=but_size_y;
};
//END
