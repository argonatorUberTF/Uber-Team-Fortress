// other menus
void () Menu_MegaTF =
{
	local vector men;
	local vector but_size;
	
	men_x = 0;
	men_y = vid_conheight*0.1;
	but_size = '160 35 0';
	
	InitMenu( "menu_megatf", MFG_NOCURSOR + MFG_KEYBOARDINPUT );
	CreateButton( "1. Drop #1", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "2. Toaster", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "3. Drop #3", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "4. Holograph", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "5. Nightvision", 		"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "6. Lay Mode", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "7. Taunt Menu", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "8. Yell Menu", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "9. Vote Menu", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0); men_y+=but_size_y;
	CreateButton( "0. Nothing", 			"default", men, "progs/csqc/csqcguiback.tga", but_size, 0);
};
//END
