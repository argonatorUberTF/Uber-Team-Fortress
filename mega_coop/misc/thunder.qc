void () trig_target =
{
	activator = self;
	SUB_UseTargets ();
	return;
};
void () come_back_for_more =
{
	if ((FLASH_ON > TRUE))
	{
		COUNT_ON = (COUNT_ON - TRUE);
		if ((COUNT_ON < TRUE))
		{
			FLASH_ON = TRUE;
			trig_target ();
		}
	}
	if ((COUNT_THUNDER > TRUE))
	{
		COUNT_THUNDER = (COUNT_THUNDER - TRUE);
	}
	if ((((random () * 10000) + OFFSET_RAND) < 60))
	{
		if ((FLASH_ON < FL_SWIM))
		{
			trig_target ();
			FLASH_ON = FL_SWIM;
			COUNT_ON = ((random () * MOVETYPE_BOUNCE) + MOVETYPE_BOUNCE);
		}
		if ((COUNT_THUNDER < FL_SWIM))
		{
			COUNT_THUNDER = 100;
			CHOOSE_ATMOS = (random () * FL_CLIENT);
			if ((CHOOSE_ATMOS > MOVETYPE_STEP))
			{
				OFFSET_RAND = MOVETYPE_BOUNCE;
				sound (self, CHAN_VOICE, "ambience/light1.wav", TRUE, ATTN_NONE);
			}
			else
			{
				OFFSET_RAND = SVC_INTERMISSION;
				sound (self, CHAN_VOICE, "ambience/light2.wav", TRUE, ATTN_NONE);
			}
		}
	}
	self.think = come_back_for_more;
	self.nextthink = FL_SWIM;
};
void () amb_thunder =
{
	setmodel (self, self.model);
	precache_sound ("ambience/light1.wav");
	precache_sound ("ambience/light2.wav");
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_NONE;
	self.think = come_back_for_more;
	self.nextthink = FL_SWIM;
};
//END
