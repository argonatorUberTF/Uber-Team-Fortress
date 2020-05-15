void ( string fname_a, string fname_b, float changeline, string changecontext, float lines ) CopyFile =
{
	local float file, dummyfile;
	local float i;
	i=1;
	file = open (fname_a, 0);
	dummyfile = open (fname_b, 2);
	while ( i < lines + 1 )
{
		if (i == changeline)
{
			write( dummyfile, changecontext );
			write( dummyfile, "\n" );
			read(file);
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
};
float ( string fromme, string str_section, string str_value, float str_valueno ) TFI_GetLine =
{
	local float file;
	local float i, i2, sectioned;
	local string a;
	if (str_section == string_null)
		sectioned = 1;
	if (!fromme || validatefile(fromme) == #FALSE)
	{
		bprint( 2, ( frik_strcat( "TFI_GetLine: No such file: ", fromme ) ) );
		return -1;
	}
	if (!str_value)
	{
		bprint( 2, ( frik_strcat( "TFI_GetLine: Invalid String Value", str_value ) ) );
		return -1;
	}
	i=1;
	file = open (fromme, 0);
	while ( i < #TFI_MAXLINES )
	{
		a = read(file);
		a = strzone(a);
		if (sectioned)
			if (a == str_value)
			{
				strunzone(a);
				if (str_valueno == 0)
				{
					close (file);
					return i;
				}
				while (i2 < (str_valueno + 1) )
				{
					i2++;
					a = read(file);
					if (i2 >= str_valueno)
					{
						close (file);
						return (i + i2);
					}
				}
			}
		if (a == str_section)
			sectioned = 1;
		strunzone(a);
		i++;
	}
	if (i > #TFI_MAXLINES)
{
		bprint( 2, "TFI_GetLine: TFI_MAXLINES exceeded in file\n" );
		close (file);
		return -1;
	}
	close (file);
	bprint(2, "TFI_GetLine: Nothing Found.\n");
	return -1;
};
void ( string fromme, string str_section, string str_value, float str_valueno, string valstr ) TFI_WriteValueFor =
{
	local float ln, tln;		// line, total lines
	ln = TFI_GetLine ( fromme, str_section, str_value, str_valueno );
	if ( ln < 0 )
		return;
	tln = TFI_GetLine ( fromme, string_null, "//end", 0 );
	if (tln == -1)
{
		bprint( 2, "TFI_WriteValueFor: File " );
		bprint( 2, fromme );
		bprint( 2, " has no \"//end\" for a last line\n" );
		tln = 50;
	}
	CopyFile( fromme,  
				"dummy_quest.tfi",			// this is the name of the dummy file we write to
					ln,					// this is the line that's getting edited
						valstr,				// this is the data that's getting added in there
							tln);				// and this is how many lines should be copied
	CopyFile( "dummy_quest.tfi", fromme, 0, string_null, tln);
};
float (string fname ) TFI_ValidFileName =
{
	local float rtype;
	if ( validatefile ( fname ) )	// if the file already exists, we can obviously write to it
		return #TRUE;
	if ( checkfilename( fname ) == 1 )
		rtype = 2;
	else
		rtype = 0;
	return ( rtype );
};
//END
