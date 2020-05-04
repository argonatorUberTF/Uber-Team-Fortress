void drawline(vector center_ofs, vector linesize, vector do_rgb, float do_alpha, float do_flags, float posflag)
{
   local vector barpos;
   barpos_x = vid_conwidth;
   barpos_y = vid_conheight;
   barpos = barpos*0.5 + center_ofs;
  barpos_y += 175;
   drawfillrgb(barpos, linesize, do_rgb, do_alpha/*, do_flags*/);
};
void DrawProgressEmpty(void)
{
   drawline(' -200 -2 0 ', '400 1 0', '1 0.91 0.51', 0.7, 0, 1); // Top
   drawline(' -200 -2 0 ', '1 9.5 0', '1 0.91 0.51', 0.7, 0, 1); // Left
   drawline(' -200 7 0 ', '400 0.5 0', '1 0.91 0.51', 0.7, 0, 1); // Bottom
   drawline(' 200 -2 0 ', '1 9.5 0', '1 0.91 0.51', 0.7, 0, 1); // Right
};
void DrawProgress(void)
{
   local vector barpos, fillsize;
   local float progrs;
   progrs = (cltime - reloadtime_begin)/(reloadtime_end - reloadtime_begin)*100;
   DrawProgressEmpty(); // Draw an empty box
   fillsize_x  = (progrs*396) / 100; // This finds the correct % of our fill
   fillsize_y = 6; // Give it a hieght of 6
   barpos_x = vid_conwidth;
   barpos_y = vid_conheight;
   barpos = barpos*0.5 - '198 -175.25 0'; // center the progress bar on the screen
   drawfillrgb(barpos, fillsize, '1 0.91 0.51', 0.7/*, 0*/); // The Fill //'396 6 0'
};
void(float width, float height) grentimer =
{
	local vector barpos, iconsize;
	local float iconalpha;
	barpos_x = width - 43;
	barpos_z = 45;
	iconalpha = .5;
	iconsize = '45 45 0';
	if (cgrentimer-cltime > 4) 
		drawpic(barpos, "progs/csqc/grenclock04.tga", iconsize, '1 0.91 0.51', iconalpha);
	else if (cgrentimer-cltime > 3) 
		drawpic(barpos, "progs/csqc/grenclock03.tga", iconsize, '1 0.91 0.51', iconalpha);
	else if (cgrentimer-cltime > 2) 
		drawpic(barpos, "progs/csqc/grenclock02.tga", iconsize, '1 0.91 0.51', iconalpha);
	else if (cgrentimer-cltime > 1) 
		drawpic(barpos, "progs/csqc/grenclock01.tga", iconsize, '1 0.91 0.51', iconalpha);
	else if (cgrentimer-cltime > 0) 
		drawpic(barpos, "progs/csqc/grenclock05.tga", iconsize, '1 0.91 0.51', iconalpha);
};
void(float width, float height) DrawExperience =
{
	local vector textpos, textsize;
	local float textalpha;
	local vector picpos;
	if (cvar("c_grenadetimer") > 0 && cgrentimer-cltime > 0)		// Don't display while a grenade is being primed
		return;
	if (coop_exp == -666) // my hack telling the server not to draw exp so I can use the same csprogs fro coop/reg
		return;
	textalpha = .5;
	textsize = '10 10 0';
	textpos_x = width - 27;
	textpos_y = 3;
	textpos_x -= strlen(ftos(coop_exp))*textsize_x;
	picpos_x = width - 26;
	picpos_y = -5;
	drawpic(picpos, "progs/csqc/xp.tga", textsize + '15 15 0', '1 0.91 0.51', textalpha);
	drawstring(textpos, ftos(coop_exp), textsize, '1 0.91 0.51', textalpha);
};
void (vector boxpos, vector boxsize, string boxtext, vector boxrgb, float boxalpha) spawnbox =
{
	drawpic(boxpos, "progs/csqc/csqcguiback.tga", boxsize, boxrgb, boxalpha);
	drawstring(boxpos + '10 12 0', boxtext, '8 8 0', boxrgb, 1);
};
void () CSQCGUI_ClearMenu =
{
	local entity button;
	button = find(world, classname, "gui_button");
	while (button)
	{
		remove(button);
		button = find(button, classname, "gui_button");
	}
	global_bt_no = 0;		// clear globally assigned button #s
	menu_selected = 0;
	in_menu = 0;
	menu_impulse = 0;
	if (!mouse_branch) {
		mousepos_x = vid_conwidth*.5;
		mousepos_y = vid_conheight*.5;
	}
	else
		mouse_branch = FALSE;
};
void () CSQCGUI_Render =
{
	local float args, boxno, i, mouse_box;
	entity button;
	if (!in_menu)
		return;
	cprint("\n");			// clear the currently printed menu
	CSQC_GUI_MenuBackground ();
	mouse_box = MouseInBox();
	button = find(world, classname, "gui_button");
	while (button)
	{
		boxno = button.bt_no;
		if (mouse_box == boxno) {
			CSQC_GUI_MouseOverButton( button.bt_img, button.origin, button.size, button.bt_text, mouse_box );
			if (menu_selected) {
				CSQC_GUI_ButtonClick( button );
			}
		}
		else {
			if (button.bt_flags & MENUFLAG_DISABLED)
				spawnbox(button.origin, button.size, button.bt_text, '.4 .4 .4', .2);
			else
				spawnbox(button.origin, button.size, button.bt_text, '1 1 1', .2);
		}
			
		button = find(button, classname, "gui_button");
	}
	CSQC_GUI_MenuForeground ();
	if (!(global_menu_flags & MFG_NOCURSOR))
		drawstring(mousepos, "X", '8 8 0', '1 0.91 0.51', .6);		// Draw the "cursor"
};
void (string menu_name, float menu_flags) InitMenu =
{
	localcmd("csqcgui_menu ", menu_name, " ", ftos(menu_flags), "\n");
	global_menu_flags = menu_flags;
};
void (string button_text, string button_cmd, vector button_spawnpos, string button_image, vector button_size, float button_flags) CreateButton =
{
	local entity newbutton;
	global_bt_no++;
	newbutton = spawn();
	newbutton.classname = "gui_button";
	newbutton.origin = button_spawnpos;
	newbutton.size = button_size;
	newbutton.bt_img = button_image;
	newbutton.bt_text = button_text;
	newbutton.bt_cmd = button_cmd;
	newbutton.bt_flags = button_flags;
	newbutton.bt_no	= global_bt_no;
};
float () MouseInBox =
{
	float in_box, boxval;
	entity button;
	button = find(world, classname, "gui_button");
	while (button)
	{
		if (mousepos_y >= button.origin_y && mousepos_y <= button.origin_y+button.size_y) 
			if (mousepos_x >= button.origin_x && mousepos_x <= button.origin_x+button.size_x) {
				if (!button.bt_flags & MENUFLAG_DISABLED)
					boxval = button.bt_no;
				break;
			}
		button = find(button, classname, "gui_button");
	}
	return boxval;
};
entity ( entity possible_best_button, entity current_best_button, vector findpos ) BestDistanceEnt =
{
	float total_dist;
	if ( current_best_button == world )
		return possible_best_button;
	total_dist = vlen( current_best_button.origin - findpos );
	if ( vlen( possible_best_button.origin - findpos ) < total_dist )
		return possible_best_button;
	return current_best_button;
};
entity (vector find_from, float find_type, float in_box) FindClosestButton =
{
	float best_distance;
	entity button, best_distance_ent;
	if (find_from != '0 0 0') {
		button = find(world, classname, "gui_button");
		while (button)
		{
			if (button.bt_no == in_box) {
				find_from = button.origin;
				break;
			}
			button = find(button, classname, "gui_button");
		}
	}
	
	button = find(world, classname, "gui_button");
	while (button)
	{
		if (!button.bt_flags & MENUFLAG_DISABLED && button.bt_no != in_box && button.origin_x >= 0 && button.origin_y >= 0) {
			if (find_type == 0)								// find value higher than X
				if (button.origin_x > find_from_x)
					best_distance_ent = BestDistanceEnt( button, best_distance_ent, find_from );
			if (find_type == 1)								// find value LOWER than X
				if (button.origin_x < find_from_x) 
					best_distance_ent = BestDistanceEnt( button, best_distance_ent, find_from );
			if (find_type == 2)								// find value higher than Y
				if (button.origin_y > find_from_y)
					best_distance_ent = BestDistanceEnt( button, best_distance_ent, find_from );
			if (find_type == 3)								// find value LOWER than Y
				if (button.origin_y < find_from_y)
					best_distance_ent = BestDistanceEnt( button, best_distance_ent, find_from );
		}
		button = find(button, classname, "gui_button");
	}
	
	return best_distance_ent;
};
float(float eventtype, float param1, float param2) CSQC_InputEvent =
{
	local entity but_ent;
	local float in_box;
	if ( in_menu ) {
		if (eventtype == 0)	{//keypress down inputs
			if (global_menu_flags & MFG_KEYBOARDINPUT) {
				in_box = MouseInBox();
				if (param1 >= 128 && param1 <= 131) {
					if (!in_box) {					// Nothing is selected so lets look for a button from the top-left of the screen
						but_ent = FindClosestButton( '0 0 0', 0, in_box );
						if (but_ent == world)
							but_ent = FindClosestButton( '0 0 0', 2, in_box );
					}
					else {
						if (param1 == 128)				// up
							but_ent = FindClosestButton( mousepos, 3, in_box );
						else if (param1 == 129) 		// down
							but_ent = FindClosestButton( mousepos, 2, in_box );
						else if (param1 == 130) 		// left
							but_ent = FindClosestButton( mousepos, 1, in_box );
						else if (param1 == 131) 		// right
							but_ent = FindClosestButton( mousepos, 0, in_box );
					}
					if (but_ent != world)
						mousepos = but_ent.origin+ '1 1 0';
					return TRUE;
				}
				else if (param1 == 13)					// enter is pressed
					if (in_box) {
						menu_selected = in_box;
						return TRUE;
					}
			}
			if (param1 == 512 && !(global_menu_flags & MFG_NOCURSOR)) {		// Left Click
				if (MouseInBox())
				{
					menu_selected = MouseInBox();			// Actual menu selection is handled in CSQCGUI_Render() for modability purposes
					//print("You clicked box number ", ftos(MouseInBox()), "\n");
				}
				return TRUE;
			}
			else if (param1 == 513) {			// Right click
				print(vtos(mousepos),"\n");
			}
			else if (param1 == 514) {			// Middle click
				if (testsize_one == '0 0 0')
					testsize_one = mousepos;
				else {
					print(vtos(mousepos-testsize_one),"\n");
					testsize_one = '0 0 0';
				}
			}
		}
		if (eventtype == 2 && !(global_menu_flags & MFG_NOCURSOR))	//mouse
		{
			mousepos_x += param1;
			mousepos_y += param2;
			if (mousepos_x < 0)
				mousepos_x = 0;
			if (mousepos_y < 0)
				mousepos_y = 0;
			if (mousepos_x > vid_conwidth)
				mousepos_x = vid_conwidth;
			if (mousepos_y > vid_conheight)
				mousepos_y = vid_conheight;				
			return TRUE;
		}
	}
	return FALSE;
};
void () DrawAddedExperience =
{
	local entity newexp;
	newexp = find(world, classname, "show_exp");
	while (newexp) {
		newexp.alpha -= .01;
		newexp.origin_y -= .24;
		//print(ftos(newexp.bt_no), "HEHE\n");
		if (newexp.alpha <= 0) {
			remove(newexp);
			return;
		}
		else
			if (newexp.bt_no > 0)
				drawstring(newexp.origin, ftos(newexp.bt_no), '20 20 15', '0.4 0.4 0.95', newexp.alpha);
		
		newexp = find(newexp, classname, "show_exp");
	}
};
void () DrawMonsterBar =
{
	local vector barpos, barsize, sbarpos, sbarsize;
	if (monsterbar.alpha > 0 && monsterbar.bt_no > 0) {
		barsize_x = vid_conwidth * .1;
		barsize_y = vid_conheight * .03;
		barpos_x = vid_conwidth - barsize_x;
		barpos_y = vid_conheight * .1;// - barsize_y;
		sbarpos_x = barpos_x + 3;
		sbarpos_y = barpos_y + 3;
		sbarsize_y = barsize_y - 6;
		sbarsize_x = (barsize_x - 6) * monsterbar.bt_no;
		drawpic(barpos, "progs/csqc/csqcguiback.tga", barsize, '.2 .2 .2', monsterbar.alpha);
		drawpic(sbarpos, "progs/csqc/csqcguiback.tga", sbarsize, '0.95 .2 0.2', monsterbar.alpha);
		monsterbar.alpha -= .01;
	}
};
void (float width, float height) HUD_Render =
{
	if (getstati(STAT_HEALTH) < 1) {
		reloadtime_end = 0;
		return;
	}
	if (cvar("c_grenadetimer") > 0)
		grentimer(width, height);
	
	if(reloadtime_end > cltime)
		DrawProgress(); 
		DrawExperience(width, height);
	DrawAddedExperience();
	DrawMonsterBar();
	CSQCGUI_Render();
};
#ifdef ODE_PHYSICS
void () Physics_Cleanup =
{
	local entity physobj;
	if (physics_cleanup_time > time)
		return;
	physics_cleanup_time = time + 1;
	physobj = find(world, classname, "object_physics");
	while (physobj) {
		if (physobj.physics_time < time)
			remove(physobj);		// ADDME: fade?
		physobj = find(physobj, classname, "object_physics");
	}
};
#endif
void(float width, float height, float menushown) CSQC_UpdateView =
{
	clearscene();       //wipe the scene, and apply the default rendering values.
   vid_conwidth = width;
   vid_conheight = height;
	setviewprop(VF_MIN_X, 0);	//set the left of the view
	setviewprop(VF_MIN_Y, 0);	//set the top of the view
	setviewprop(VF_SIZE_X, width);	//set how wide the view is (full width)
	setviewprop(VF_SIZE_Y, height); //set how high the view is (full height)
	
	setviewprop(VF_DRAWENGINESBAR, 1);
	if (!in_menu || global_menu_flags & MFG_NOCURSOR)
		setviewprop(VF_DRAWCROSSHAIR, 1);
	addentities(4|1|2);
	renderscene();
	HUD_Render(width, height);
#ifdef ODE_PHYSICS
	Physics_Cleanup();
#endif
};
void(float isnew) RefreshPlayer =
{
	p_org = self.origin;
	p_ang = self.angles;
	setmodel(self, "");
};
//END
