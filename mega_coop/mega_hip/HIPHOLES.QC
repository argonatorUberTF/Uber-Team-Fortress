void() wallsprite =
{
	if ( !self.model )
		{
		self.model = "progs/s_blood1.spr";
		}
	precache_model( self.model );
	setmodel (self, self.model );
	if (self.angles == '0 -1 0')
		self.angles = '-90 0 0';
	else if (self.angles == '0 -2 0')
		self.angles = '90 0 0';
	makevectors(self.angles);
	setorigin( self, self.origin - ( v_forward * 0.2 ) );
	makestatic (self);
};
void() InitBulletHoles =
{
	precache_model ("progs/s_bullet.spr");
	bulletholes = nullentity;
	lastbullet = nullentity;
	numbulletholes = 0;
};
void() remove_bullethole =
{
	local entity ent;
	if ( bulletholes == nullentity )
	{
		objerror("remove_bullethole: bulletholes == nullentity! " );
	}
	ent = bulletholes;
	if ( ent.classname != "bullethole" )
	{
		objerror("remove_bullethole: Tried to remove non-bullethole!" );
	}
	bulletholes = bulletholes.lastvictim;
	remove( ent );
	if ( lastbullet == ent )
	{
		lastbullet = nullentity;
	}
	numbulletholes = numbulletholes - 1;
};
void( vector pos ) placebullethole =
{
bprint(2, "DEV, this is being called.. not good! :D\n");
};
//END
