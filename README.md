# UberTeam Fortress
Uber Team Fortress. A four player teams, capture the flag, coop against monsters, or just death match. For Quakeworld servers.

# Check releases for the deploy.zip pack for Fortress One clients and other Quakeworld clients.

# Uber Team Fortress - Open Sourced from:
 Author: Avirox (a.k.a. XavioR) up to 1-2015 with many others.
 Mega Team Fortress, Coop vs monsters.

 Design document. 3/30/2020 Argonator

 Uber TF 4 player Team Fortress, deathmatch, or COOP against monsters with teams, Survival mode COOP against monsters with
 teams, and Last Man Standing against monsters.

 # Credits:
 Original MegaTeam Fortress Programmers: Ambush, Plexi, mod3m, Plasticity 1997
 Additional addons by Ratbert, Argonator, Agent, Pablo, Cloud, Doc 2010-2019, Often, Aberrant.
 Credits also to Hipnotic, Mega Team Fortress PTY LTD, Gold, Sh1thead. 
 Special thanks to Kevin(server admin), Shark, Alissa(original MEGATF CE code, deadly sniper).
 Special thanks to Human[RUS](lotric) for remote testing server and hosting for bug sweeping.
 Cheers to fortressone.org for breathing new life into the client and server engines.
 Added painkeep weapons and impulse bindings from pk666 thanks to NIB and Shithead (SH), DOC (painkeep).
 Beartraps, gravity well, can of pork n beans, auto sentry guns added.  
 Original credit for Painkeep from Team Evolve. Also available for Quake 3.


# GOAL
 Make it tougher to last to capture the flag with faster action, heinous
 amounts of weapons. Forcing the team to play as a team, not solo runners or rambos
 that take advantage of the bunny hop. Or just plain deathmatch fun with at least 2 teams.
 You can load any non-coop map and just frag or CTF.
 You can even CTF/deathmatch on "coop" maps by not loading the .ENT file for that map. Hence no monsters included.
 Use "cmd help" for extensive list of features within the game on the client side.

# Changes to original source
cmd changeteam blue, red, green, and yellow always enabled. You can fight alongside the monsters or summon more.
precache models and sounds missing fixed. 

It still gets unto warnings on the console when there are more precached than it's limit on some maps
but still a minimum has been increased.

Removed sounds for taunts, yells. In order to add weapons and sound effects.

Added two whole pounds of semicolons at the end of functions to not spazz out modern compilers. -arg
It worked ok in 2008-2015 for that old compiler, but not by today's standards.

Fixed grenade allocation at spawn based on 3 X ammo attribute with a minimum of 3 of each type.

Now you can plant a prox at even newb levels regardless of ammo pack settings within each map.

Edited monster summon time, damage, quantity based on attribute summon.

Fixed the attribute saving feature for each player name logged on.
It's important to remember your Quake name with special characters.

Removed packet transmission to central hub for sharing of user profiles across multiple
servers. Since Uber TF is not similar to Mega TF COOP, they shouldn't talk with each other.
So experience and attributes are not shared across multiple servers with a central hub.
Which was known to timeout, or exploited for exp changes.

In survival mode, if you get disconnected or dropped, you can "cmd beg" to be let back in because,
sometimes other players can't find or see your corpse. Or your player died and fell into an unobtainable area.
Even if you use the resurrection cube, sometimes the player would spawn and just die again. 

Updated gibs to be tossed out (pk666), upgraded shotgun damage for tough monsters/players. More pellets.
Added splash effects for dropped entities/models into lava and water. addtosplash() .

Fixed missing precached models, sounds, added VWEP support for Painkeep and Mega TF weapons.
Typos and grammar of text notifications cleaned by unknown, and argonator.
Addons and variables used by some modules that are commented out but need to be declared after defs.pqc
Also added on painkeep vars for their modules of .qc code for functions.
All in one reference section at the start so one could code a new function referencing everything else,
not affecting the compilation over.

Use "cmd changeteam (color)" to join any 4 teams. You can load any non-coop map and just frag or CTF.
You can even CTF/deathmatch on "coop" maps by not loading the .ENT file for that map.

Regular deathmatch is possible by just loading a map without monsters. Pick opposing teams.
The medic class cam heal with masters skill "cmd aura" when spawned. Regardless of masters level of the
health attribute.							
 
# Quirks:
Summoned monsters might only target the RED team if monster maps are selected.

Beartraps stick where you place them and cannot be shot off you once clamped.

Beartraps will follow you through the teleporters once clamped.

Regular sentry guns and tesla coils envy the auto sentry guns and will target them as an enemy on your team.
This prevent someone just ganging a huge armada of sentry guns of both types along with the

Auto sentry guns are waterproof and cannot be toastered.

The following monsters were removed  to free up precache for sounds and models:
Ogre cook, Vermis(lame), eel, and gremlin which didn't work.

The minipet is superflous since you can cmd summon and the code needs work. Removed.
			
# BUGS:
The obituary messages need an overhaul and sometimes cause the server to spew word salad.
The problem starts when a large amount of frags against monsters beyond 16-24 and causes a message flood.

New bugs can be submitted to Github for tracking and resolution be unbiased.
Volunteer devs of code/fixes/features gladly accepted.

# TODO:
Clean up source code for easy compiliation in fteccgui and 64bit versions. - 99% -arg
Down to 7-13 warnings on ftegccui compiler in Windows. 

Submit said source to github for Open Source under GNU/GPL. - here now -arg

Add Painkeep explosive shotgun ammo when you pick up a pack from monsters. A few shells with rekt most monsters in a few shots.
If possible upgrade the lightning gun to the painkeep chain lightning gun.

Not tested on FTE or Prozac server yet. Volunteers ? 

Upgrade medic nail gun to lava nails ala rogue. - done -arg.

Adjust starting armor and speeds to rebalance things.

Put in an anti-bunny hopping system to remove the game glitch of angled bouncing.
It was never intended in the design and unbalances gameplay. A cheese.
It is nowhere fair when a hwguy can move as fast as a scout or a soldier passing a scout.
(Possibly add this as an anti-cheat system)

Add another weapon to the Pyro for even more destructive backup. multi pyro rockets?
Allow the lightning gun to be toggled with the single barrel shotgun.

Add Ratbert's nuke grenades to drop4 for demoman or pyro. ?
Add Prozac/Ratbert's mini sentry guns of differing types. Some monsters/players are affected more
by plasma or fire damage than blast/nail damage.

Tame down the survival mode with less extra monster spawns to stay under the 512 entities limit.
Then again, the map makers should be aware of this and not use so many spawns.

Finish HALF-LIFE map support. ?

# Changes to existing classes:
All classes spawn with a minimum of 3 type 1, and 3 type 2 grenades at level 0 newb starter.
If a map doesn't have ammo bags that give grenades, fix the maps.
Amount of grenades is 3X your ammo attribute gained from experience.

All classes get bonus health, armor, ammo, reload time, summoning etc from the 
attribute system based on experience points gained from frags and captures.
At level 80 you get the Xav Needler gun and lightning gun weapons.
Achievement system similar to Xbox for bragging rights just like MegaTF COOP was.

Scout class has a bat for the axe, jetpack uses less cells, a bit more fire damage.

The sniper class had little changed. Already powerful and deadly enough. 
The soldier class gets a bit more dangerous with the upgraded amounts of grenades. The attributes system can boost this class to very powerful levels.

The Demoman gets sticky pipebombs and laser trip bombs added.

Medic can heal with cmd aura regardless of level, further than players can with attribute of masters of healing.
Medic gets an upgrade of the super nailgun with lava nails.

Heavy Weapons Guy can spool up assault cannon a bit faster, and uses less ammo per shot on 20mm mode.

Pyro can fire faster flame rockets, has a chainsaw, and gets results.

The Spy has a grappling hook that uses less cells, and can "poon" enemies for gibs. Just like in Pain Keep.

The Engineer can launch drones in a shorter timeframe, does a bit more damage per beam.
The Engineer gets a gravity gun, and can have a Tesla and Sentry built at the same time. Stack the death dealing high, rawhide!

All classes can buy weapon upgrades, powerups, and inventory then with the merchant and used them with "cmd inv".

Custom skins are possible. Not restricted per class. Use "cmd customskin" Frag with your favorite character on.

Deployment of client and server files see releases.

Donations glady accepted by bitcoin to address: 3J2nKrotxfP7mqQgTBotn4rgAvRqVhD1hh

email: forgetitanyway@gmail.com

Discord: argonator#1511

Coders see addtional.pqc for notes and references.
