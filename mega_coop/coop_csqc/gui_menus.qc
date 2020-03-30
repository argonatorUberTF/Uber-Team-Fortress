// Handle GUI events in menu-specific manners
// Essentially this keeps tf_coop_hud.qc free of clutter.

// A button is clicked..
void ( entity t_button ) CSQC_GUI_ButtonClick =
{
	switch(in_menu) {
		default:
			if (!menu_impulse) {			// if the menu didn't already send the reply to the server regarding the menu..
				menu_impulse = TRUE;
				if (t_button.bt_flags & MENUFLAG_BRANCH) 
					mouse_branch = TRUE;
				if (t_button.bt_cmd == "default")
					localcmd("impulse ", ftos(t_button.bt_no), "\n");
				else {
					//print(t_button.bt_cmd, " is the cmd\n");
					localcmd(t_button.bt_cmd, "\n");
				}
			}
	}
};

// When a mouse hovers over a button, apply this effect..
void (string button_image, vector button_position, vector button_size, string button_text, float selected_button) CSQC_GUI_MouseOverButton =
{
	local float /*selected_button, */stl;
	//selected_button = MouseInBox();
	
	switch(in_menu) {
		case MENU_CLASS_SELECT:
			stl = strlen(button_text);
			drawstring('260 180 0', substring(button_text , 2, stl), '12 12 0', '1 1 .5', 1);
			TF_Class_Info(selected_button, '272 242 0');
			
			drawpic(button_position, button_image, button_size, '1 1 1', .4);
			drawstring(button_position + '10 12 0', button_text, '8 8 0', '1 1 1', 1);
		default:
			drawpic(button_position, button_image, button_size, '1 1 1', .4);
			drawstring(button_position + '10 12 0', button_text, '8 8 0', '1 1 1', 1);
			break;
	}
};

// Called before the menu buttons are rendered
void () CSQC_GUI_MenuBackground =
{
	local vector menback_pos, menback_size;
	
	switch(in_menu) {
		case MENU_CLASS_SELECT:
			//drawpic('254 18 0', "progs/csqc/mtfn.jpg", '332 85 0', '1 1 1', 1);						// MegaTF logo
			drawpic('254 18 0', "progs/csqc/tsbanner_600.png", '332 125 0', '1 1 1', 1);					// TastySpleen logo
			drawpic('254 169 0', "progs/csqc/csqcguiback.tga", '126 36 0', '1 1 .5', .2);			// Small text box (class name)
			drawpic('254 224 0', "progs/csqc/csqcguiback.tga", '332 184 0', '1 1 .5', .2);			// Large text box (class info)
			break;
		case MENU_TEST1:
			// individual button size: '160 35 0'
			menback_pos_x = ((vid_conwidth*0.5) - (160*0.5)) - 20; 
			menback_pos_y = (vid_conheight*0.2) - 20;
			menback_size_x = 200;				// Since we're overlapping 20 on each side, add 40 to 160.
			menback_size_y = (35*5)+40;			// There are 5 buttons in a row vertically, so compensate for that and add 40
			drawpic(menback_pos, "progs/csqc/csqcguiback.tga", menback_size, '1 1 .5', .2);			// Large text box (class info)
			break;
		default:			// No default background image
			break;
	}
};

// Called after the menu buttons are rendered
void () CSQC_GUI_MenuForeground =
{
	switch(in_menu) {
		default:			// No default foreground image
			break;
	}
};