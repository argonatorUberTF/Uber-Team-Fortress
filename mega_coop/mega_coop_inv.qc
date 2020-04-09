float (string nname) MTF_Coop_SetupInventory =
{	
	local string a;
	local string filenamee, oopsname;
	local float filee;
	nname = strzone(nname);
	if (nname != self.connect_name)
	{
		bprint(2, "ERROR RETRIEVING INVENTORY FROM ");
		bprint(2, self.netname);
		bprint(2, " - please reconnect. (connect name: ");
		bprint(2, self.connect_name);
		bprint(2, ")\n");
	}
	if ( nname == "" || !nname ) {
		self.#gold = -1;
		return ( -1 );
	}
	filenamee = frik_strcat( "ranks/inv/", nname, "_inv.tfi" );
	filenamee = strzone(filenamee);
	if ( invalid_exp_name(filenamee) == 1 ) {
		strunzone(nname);
		strunzone(filenamee);
		self.#gold = -1;
		return ( -1 );
	}
	if ( checkfilename(filenamee) != 1 ) {	// done in C - makes sure the file name is writable
		strunzone(nname);
		strunzone(filenamee);
		self.#gold = -1;
		// make sure that the folder exists to be written to in the first place
		if (checkfilename( "ranks/inv/test" ) == #FALSE)
			bprint( 2, "WARNING: Folder /inv cannot be found! Server admin needs to create /fortress/ranks/inv/ folder!\n" );
		
		return ( -1 );
	}
	oopsname = frik_strcat( "ranks/inv/", self.connect_name, "_inv.tfi" );
	oopsname = strzone(oopsname);
	if (filenamee != oopsname || self.has_disconnected == 1)
	{
		bprint(2, "!!!!!!!!!!!!! INV BUG ERROR IN READ!!! filenamee IS NOT THE SAME AS CONNECT NAME !!!!!!!!!!!!! \n");
		bprint(2, "CNAME: ");
		bprint(2, self.connect_name);
		bprint(2, " filenamee: ");
		bprint(2, filenamee);
		bprint(2, " oopsname: ");
		bprint(2, oopsname);
		bprint(2,"\n");
		strunzone(filenamee);
		strunzone(oopsname);
		self.#gold = -1;
		return ( -1 );
	}
	strunzone(oopsname);
	filee = open (filenamee, 0);
	a = read (filee);
	if (!a)
	{
		close(filee);
		filee = open (filenamee, 2);
		self.#max_inv = #MAX_INV_START;
		write (filee, "// MegaTF Coop inventory system Team Fortress Information file\n");
		write (filee, "// Player's Gold:\n");
		write (filee, "0\n");
		write (filee, "// Player's Max Inventory Slots:\n");
		write (filee, "#MAX_INV_START\n");
		write (filee, "// Player's Inventory Items:\n");
		write (filee, "0\n");
		write (filee, "0\n");
		write (filee, "0\n");
		write (filee, "0\n");
		close (filee);
		strunzone(filenamee);
		strunzone(nname);
		return ( 0 );
	}
	a = read (filee);
	a = read (filee);
	self.#gold = stof(a);
	a = read (filee);
	a = read (filee);
	self.#max_inv = stof(a);
	close (filee);
	strunzone(nname);
	strunzone(filenamee);
	return #TRUE;
};
float ( float item_no ) Inventory_ItemIsValidPickup =
{
	if (item_no == 8)
		return #FALSE;
	if (item_no == 0)
		return #TRUE;		// shows up blank
	if (item_no < 21)
		return #TRUE;
	if (item_no > 670)
		return #TRUE;
	if (item_no == 1 || item_no == 2)
		return #TRUE;
	return #FALSE;
};
string ( float item_no ) Inventory_GetItemName =
{
	local string r_str;
	if ( Inventory_ItemIsValidPickup( item_no ) == #FALSE )
		return "Invalid/Unknown Item";
	if ( item_no == 670 + #RUNE_VAMPRIC )
		return "Vampric Rune";
	else if ( item_no == 670 + #RUNE_RESISTANCE )
		return "Greater Resistance Rune";
	else if ( item_no == 670 + #RUNE_BERSERKER )
		return "Berserker Rune";
	else if ( item_no == 670 + #RUNE_EXPBONUS )
		return "Double Experience Rune";
	else if ( item_no == 670 + #RUNE_AMMO )
		return "Infinite Ammo Rune";
	else if ( item_no == 670 + #RUNE_EXPLOSIVE )
		return "Triple Explosive Rune";
	else if ( item_no == 670 + #RUNE_UBEREXP )
		return "Quad EXP Rune";
	else if ( item_no == 670 + #RUNE_ARMOR )
		return "Armor Steal Rune";
	else if ( item_no == 670 + #RUNE_ELERESIST )
		return "Elemental Resistance Rune";
	else if ( item_no == 1)		// QUAD
		return "Quad Damage";
	else if ( item_no == 2)	
		return "Invisibility Ring";
	else if ( item_no == 3)	
		return "Yellow Armor";
	else if ( item_no == 4)
		return "Megahealth";
	else if ( item_no == 5)	
		return "Red Armor";
	else if ( item_no == 6)	
		return "Medium Health Pack";
	else if ( item_no == 7)	
		return "Pentagram";
	else if ( item_no == 9)	
		return "Small Inventory Pocket";
	else if ( item_no == 10)	
		return "Medium Inventory Pocket";
	else if ( item_no == 11)	
		return "Large Inventory Pocket";
	else if ( item_no == 12)	
		return "JUMBO (best) Inventory Pocket";
	else if ( item_no == 13)	
		return "Medium Ammo Pack";
	else if ( item_no == 14)	
		return "Jumbo Ammo Pack";
	else if ( item_no == 15)	
		return "Extra Grenades Pack (+2 +2)";
	else if ( item_no == 16)
		return "Rocket Upgrade: Ricochet";
	else if ( item_no == 17)
		return "Item Pickup (adds the next picked up item into your inventory)";
	else if ( item_no == 18)
		return "Uber Railgun Upgrade";
	else if ( item_no == 19)
		return "Lightning Gun (Replaces SG)";
	else if ( item_no == 20)
		return "Resurrection Cube";
	else if ( item_no == 0)
		return "";
	r_str = frik_strcat( "Item ", ftos( item_no ) );
	return r_str;
};
float ( float item_no ) Inventory_GetItemPrice =
{
	if (item_no == 1)		// QUAD
		return 500;
	else if (item_no == 3)
		return 250;
	else if (item_no == 4)
		return 600;
	else if (item_no == 5)
		return 350;
	else if (item_no == 6)
		return 200;
	else if (item_no == 7)
		return 1200;
	else if (item_no == 9)
		return 5000;
	else if (item_no == 10)
		return 10000;
	else if (item_no == 11)
		return 20000;
	else if (item_no == 12)
		return 50000;
	else if (item_no == 13)
		return 100;
	else if (item_no == 14)
		return 165;
	else if (item_no == 15)
		return 100;
	else if (item_no == 16)
		return 425;
	else if (item_no == 17)
		return 250;
	else if (item_no == 18)
		return 450;
	else if (item_no == 19)
		return 400;
	else if (item_no == 20)
		return 6000;
	else if (item_no == 670 + #RUNE_AMMO)
		return 800;
	else if (item_no == 670 + #RUNE_UBEREXP)
		return 500;
	else if (item_no == 670 + #RUNE_BERSERKER)
		return 550;
	return 400;			// default value
};
void ( string nname, float print_type ) Inventory_PrintItems =
{
	local float i;
	local string a;
	local string filename;
	local float file;
	if (self.#gold < 0)
		return;
	nname = strzone(nname);
	filename = frik_strcat( "ranks/inv/", nname, "_inv.tfi" );
	filename = strzone(filename);	
	file = open (filename, 0);
	a = read (file);
	if (!a)
	{
		close( file );
		return;
	}
	a = read (file);
	a = read (file);
	a = read (file);
	a = read (file);
	a = read (file);
	i = 1;
	while (i < self.#max_inv + 1) {
		a = read (file);
		a = strzone(a);
		if (print_type == #P_TO_SELF || print_type == #P_TO_SELF_W_VALUE) {
			sprint( self, 2, ftos(i) );
			sprint( self, 2, ") " );
			sprint( self, 2, Inventory_GetItemName( stof(a) ) );
			if (print_type == #P_TO_SELF_W_VALUE) {
				if (a != "0" && a != string_null) {
					sprint( self, 2, " (צבלץו: " );
					sprint( self, 2, ftos( ceil(.75 * Inventory_GetItemPrice(stof(a))) ) );
					sprint( self, 2, ")" );
				}
			}
			sprint( self, 2, "\n" );
		}
		strunzone(a);
		i++;
	}
	close (file);
	strunzone(nname);
	strunzone(filename);
	return;
};
void ( entity t_plyr, float gold_amnt ) Inventory_AddGold =
{
	if (t_plyr.#gold < 0)
		return;
	if (t_plyr == world || t_plyr.classname != "player")
		return;
	if (t_plyr.has_disconnected == 1)
		return;
	if (!t_plyr.connect_name)
		return;
	t_plyr.#gold = t_plyr.#gold + gold_amnt;
	CopyFile( frik_strcat( "ranks/inv/", t_plyr.connect_name, "_inv.tfi" ),  
				"dummy_inv.tfi",			// i just hope peoples' inventories don't get switched around
					3,			// this is the line that's getting edited
						ftos(t_plyr.#gold),		// this is the data that's getting added in there
							6 + t_plyr.#max_inv);	// and this is how many lines should be copied
	CopyFile( "dummy_inv.tfi", frik_strcat( "ranks/inv/", t_plyr.connect_name, "_inv.tfi" ), 0, string_null,  6 + t_plyr.#max_inv);
};
void ( entity t_plyr ) Inventory_SaveMaxInv =
{
		CopyFile( frik_strcat( "ranks/inv/", t_plyr.connect_name, "_inv.tfi" ),  
					"dummy_inv.tfi",
						5,			// this is the line that's getting edited
							ftos(t_plyr.#max_inv),		// this is the data that's getting added in there
								6 + t_plyr.#max_inv);	// and this is how many lines should be copied
		CopyFile( "dummy_inv.tfi", frik_strcat( "ranks/inv/", t_plyr.connect_name, "_inv.tfi" ), 0, string_null,  6 + t_plyr.#max_inv);
};
void () Inventory_ClingToMonster =
{
	if ( self.owner == world || self.owner.health > 0 || !self.owner.classname )
		dremove( self );
	setorigin( self, self.owner.origin );
	self.nextthink = time + .2;
};
void ( entity monster, entity mkiller ) MTF_Monster_DropInventory =
{
	local float gd_chance;			// Gold Drop Chance
	local entity t_item;
	if (monster.#gold == 0)		// if monster drops 0 gold for whatever reason (IE minion)
		return;
	gd_chance = .35;
	if ( random() > gd_chance )
		return;
	t_item = spawn();
	t_item.#rune_time = 30;		// TODO: dynamize this so that misc attrib makes em last longer
	t_item.weapon = 8;			// Gold drop
	if (monster.#gold > 0) {
		t_item.#gold = monster.#gold;			// monster gold drop based on exp
		monster.#gold = 0;
	}
	else
		t_item.#gold = 5;
	t_item.touch = PreMonsterItemTouch;
	t_item.solid = 1;
	t_item.origin = (monster.origin);
	if (mkiller.classname != "player")
		if (mkiller.owner != world)
			t_item.#loot_owner = mkiller.owner;
		else
			t_item.#loot_owner = mkiller;
	else
		t_item.#loot_owner = mkiller;
	t_item.#loot_owner_time = time + 10;		// amount of time the monster killer has to claim his loot
	
	t_item.owner = monster;
	t_item.think = Inventory_ClingToMonster;
	t_item.nextthink = time + .2;
	t_item.owner.effects = EF_RED;
#ifndef mtf_coop_halflife
	if (cvar("sv_map_halflife") == 1 || #DOOM_MAP) {
		t_item.owner.effects = 0;
	}
#endif
};
float ( entity t_plyr, float item_no, float item_cost ) Inventory_AddItem =
{
	local float free_slot;
	if ( Inventory_ItemIsValidPickup( item_no ) == #FALSE )
	{
		sprint( t_plyr, 2, "Item number " );
		sprint( t_plyr, 2, ftos( item_no ) );
		sprint( t_plyr, 2, " is unavailable or invalid.\n" );
		return #FALSE;
	}
	if ( item_no == 0 )
		return #FALSE;
	free_slot = Inventory_GetItem ( t_plyr.connect_name, 0, #RETURN_FREE_SLOT );		// find a free slot.. if we have one
	if ( free_slot == 0 ) {
		sprint( t_plyr, 2, "You need to free up an inventory slot before acquiring a new item.\n" );
		return #FALSE;
	}
	
	if ( item_cost > t_plyr.#gold ) {
		sprint( t_plyr, 2, "You need more gold to purchase this item.\n" );
		return #FALSE;
	}
	Inventory_AddGold( t_plyr, (item_cost * -1) );
	CopyFile( frik_strcat( "ranks/inv/", t_plyr.connect_name, "_inv.tfi" ),  
				"dummy_inv.tfi",			// i just hope peoples' inventories don't get switched around
					6 + free_slot,				// this is the line that's getting edited
						ftos(item_no),		// this is the data that's getting added in there
							6 + t_plyr.#max_inv);	// and this is how many lines should be copied
	CopyFile( "dummy_inv.tfi", frik_strcat( "ranks/inv/", t_plyr.connect_name, "_inv.tfi" ), 0, string_null,  6 + t_plyr.#max_inv);
	sprint( t_plyr, 2, Inventory_GetItemName( item_no ) );
	sprint( t_plyr, 2, " was added to your inventory slot #" );
	sprint( t_plyr, 2, ftos(free_slot) );
	sprint( t_plyr, 2, ".\n" );
	return #TRUE;
};
void () Merchant_SayWares;
void () Merchant_SayWares =
{
	if ( self.#merchant_type == 1 )
		bprint(2, "Quakeguy Merchant is somewhere in the map!\n" );
	if ( self.#merchant_type == 2 )
		bprint(2, "Weapons Merchant is lookin' to sell some good stuff!\n" );
	if ( self.#merchant_type == 3 )
		bprint(2, "Shambler Merchant's got some cool stuff for sale!\n" );
	
	self.nextthink = time + 100 * rint(random() * 5);
};
void () Merchant_Touch =
{
	local vector lookdir;
	if (other.classname != "player")
		return;
	if (other.health < 0)
		return;
	if (self.#item1 == 0 && self.#item2 == 0 && self.#item3 == 0 && self.#item4 == 0) {
		bprint(2, "Merchant: See ya later!\n");
		dremove(self);
		return;
	}
	lookdir = vectoangles(other.origin - self.origin);		// face the buyer
	lookdir_x = (self.v_angle_x) * -0.533;
	self.angles = lookdir;
	if (!other.current_menu)
		other.current_menu = 43;
};
float () Merchant_SetrRandomItem =
{
	local float ittype, i;
	ittype = 1;
		if (merchant.#merchant_type == 1) {
		i = rint(random() * 7);
		ittype = i;
		if (random() < .15)
			ittype = 9;
		if (random() < .05)
			ittype = 10;
		if (random() < .03)
			ittype = 17;
	}
	else if (merchant.#merchant_type == 2) {
		i = rint(random() * 10);
		if (i == 1)
				ittype = 13;
		if (i == 2)
				ittype = 14;
		if (i == 3)
				ittype = 15;
		if (i == 4)
				ittype = 670 + #RUNE_AMMO;
		if (i == 5)
				ittype = 670 + #RUNE_EXPLOSIVE;
		if (i == 6)
				ittype = 16; // rocket ricochet upgrade
		if (i == 7)
				ittype = 1;
		if (i == 8)
				ittype = 17;
		if (i == 9)
				ittype = 18; // uber railgun upgrade
		if (i == 10)
				ittype = 19; // lightning gun upgrade
		if (random() < .09)
			ittype = 10;
		if (random() < .04)
			ittype = 11;
	}
	else if (merchant.#merchant_type == 3) {
		i = rint(random() * 12);
		if (i == 10)
			ittype = 2;
		else if (i == 11)
			ittype = 7;
		else if (i == 12)
			ittype = 4;
		else
			ittype = 670 + i;
		if (random() < .07)
			ittype = 11;
		if (random() < .04)
			ittype = 12;
		if (random() < .04)
			ittype = 17;
		if (ittype == 670)
			ittype = 679;
	}
	return ittype;
};
void () Inventory_SetupMerchant =
{
	local float rndm, i, maxmerchants, m_type;
	maxmerchants = 3;		// # of different merchant types possible
	m_type = 0;
	i = rint(random() * maxmerchants);
	while (m_type == 0)
	{		
		rndm = random();
		if ( rndm < (1 / maxmerchants) )
			m_type = i;
			if (i >= maxmerchants)
			i = 1;
		else
			i++;
	}
	if ( m_type == 3 )
		if (checkmodelprecache("progs/shambler.mdl") == #FALSE )
			m_type = 1;
	if ( m_type == 2 )
		if (checkmodelprecache("progs/enforcer.mdl") == #FALSE )
			m_type = 1;
	if ( m_type == 1 ) {
		bprint( 2, "QuakeGuy Merchant is looking to sell his wares.\n" );
		merchant.#gold = 1000;
	}
	else if ( m_type == 2 ) {
		bprint( 2, "Weapons Merchant is looking to sell some weapons upgrades.\n" );
		merchant.#gold = 2500;
	}
	else if ( m_type == 3 ) {
		bprint( 2, "Shambler Merchant is looking to sell some mystic powers.\n" );
		merchant.#gold = 5000;
	}
	merchant.#merchant_type = m_type;
	
	if (m_type == 1) {		// player merchant
		setmodel( merchant, "progs/player.mdl" );
		merchant.frame = 13;
	}
	else if (m_type == 2) {		// weapons merchant
		setmodel( merchant, "progs/enforcer.mdl" );
	}
	else if (m_type == 3) {		// shambler merchant
		setmodel( merchant, "progs/shambler.mdl" );
	}
	else {
		bprint(2, "MERCHANT ERROR! INVALID MERCHANT TYPE ");
		bprint(2, ftos(m_type));
		bprint(2, "\n");
		dremove(merchant);
	}
	merchant.#item1 = Merchant_SetrRandomItem();
	merchant.#item2 = Merchant_SetrRandomItem();
	merchant.#item3 = Merchant_SetrRandomItem();
	merchant.#item4 = Merchant_SetrRandomItem();
	merchant.#item5 = Merchant_SetrRandomItem();
#ifdef mtf_coop_quests
	merchant.#questid = 1;
#endif
	merchant.think = Merchant_SayWares;
	merchant.nextthink = time + 120;
	merchant.touch = Merchant_Touch;
};
void () Merchant_GenerateEntity ;
void ( vector m_org ) Inventory_SpawnMerchant =
{
	if (random() < .02)
		return;
	if (merchant != world)
		return;
#ifdef mtf_coop_lms
	if (lms_entity != world)
		return;
#endif
	merchant = spawn ();
	newmis = spawn();
	newmis.origin = m_org;
	newmis.think = Merchant_GenerateEntity;
	newmis.nextthink = time + 1;
};

void () Merchant_GenerateEntity =
{
	merchant.classname = "merchant";
	merchant.origin = (self.origin - '0 0 24');
	merchant.velocity_z = 3000;
	merchant.velocity_x = (-100 + (random () * 2000));
	merchant.velocity_y = (-100 + (random () * 2000));
	merchant.solid = 1;
	merchant.movetype = MOVETYPE_BOUNCE;
	setsize (merchant, '-16 -16 -24', '16 16 32');
	merchant.effects = #EF_GREEN;
	dremove(self);
	Inventory_SetupMerchant();
};
//END
