void () trigger_void_touch =
{
	if ((other.classname == "monster_vermis"))
	{
		return;
	}
	if (other.takedamage)
	{
		if ((other.shield == TRUE))
		{
			T_Damage (other, self, self, ((other.health * FL_SWIM) + TRUE));
		}
		else
		{
			T_Damage (other, self, self, (other.health + TRUE));
		}
		if ((other.flags & FL_MONSTER))
		{
			remove (other);
			force_retouch = FL_SWIM;
			return;
		}
	}
	if (((((other.classname == "gib") || (other.classname == "grenade")) || (other.classname == "spike")) || (other.classname == "missile")))
	{
		remove (other);
		force_retouch = FL_SWIM;
		return;
	}
	if ((other.flags & FL_ITEM))
	{
		remove (other);
	}
	force_retouch = FL_SWIM;
};
void () trigger_void =
{
	InitTrigger ();
	self.touch = trigger_void_touch;
};
//END
