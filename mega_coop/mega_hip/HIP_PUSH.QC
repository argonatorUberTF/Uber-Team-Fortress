void() push_use =
{
	local vector delta;
	local float x;
	local float y;
	makevectors(other.angles);
	x = fabs( other.velocity_x );
	y = fabs( other.velocity_y );
	dprint( ftos( x ) );
	dprint( ", " );
	dprint( ftos( y ) );
	if ( x > y )
	{
		dprint( " x move\n\n\n\n" );
		if ( other.velocity_x > 0 )
		{
			walkmove ( 0, 16 * frametime);
		}
		else
		{
			walkmove( 180, 16 * frametime );
		}
	}
	else
	{
		dprint( " y move\n\n\n\n" );
		if ( other.velocity_y > 0 )
		{
			walkmove ( 90, 16 * frametime);
		}
		else
		{
			walkmove( 270, 16 * frametime );
		}
	}
	delta = self.origin - self.oldorigin;
	setorigin (self.owner, self.owner.oldorigin + delta );
};
//END
