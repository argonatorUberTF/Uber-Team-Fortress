void (vector vec) spawn_borkedvigil =
{
	local entity head;
	head = spawn ();
	head.origin = vec;
	head.deathtype = "falling";
	head.think = borkedvigilthink;
	head.nextthink = (time + 0.1);
};

void () borkedvigilthink =
{
	local entity mark;
	dprint ("\n");
	mark = find (world, soul, "yes");
	while (mark)
	{
		if (visible (mark))
		{
			if (((mark.health > 0) && (mark.origin_z < -1530)))
			{
				T_Damage (mark, self, self, 9999);
			}
		}
		mark = find (mark, soul, "yes");
	}
	self.think = borkedvigilthink;
	self.nextthink = (time + 0.1);
};

//END
