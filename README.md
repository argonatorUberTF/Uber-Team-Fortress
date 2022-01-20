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

Supported on Windows, Linux, and Mac iOS clients.  If your machine can run Quakeworld, Fuhquake, EZQuake, Fortress One,
FTE Quake Client, or Dark Places. You can connect to an Uber TF server and download the upgraded client files.
 
However, it is much faster to get the client files as one .zip file from here.

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

It still gets into warnings on the console when there are more precached than it's limit on some maps
but still a minimum has been increased.

Added two whole pounds of semicolons at the end of functions to not spazz out modern compilers. -arg
It worked ok in 2008-2015 for that old compiler, but not by today's standards.

Fixed grenade allocation at spawn based on 3 X ammo attribute with a minimum of 3 of each type.

Now you can plant a prox at even newb levels regardless of ammo pack settings within each map.

Edited player monster summon  interval time, damage, quantity, and summoned lifespan based on the players attribute of summon.

Fixed the attribute saving feature for each player name logged on.
It's important to remember your exact Quakeworld user name with special characters.

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
 
# 10-31-2020 - Added support for teleporters to transport just about anything through or fired missiles/lasers.

Shotgun fire and harpoon does not travel through teleporters.  Neither does the lightning gun.

The Engineer gravity gun will all you to pickup beartraps, auto sentry guns, and Engineer built items and place them into the transporter to areas that need them.

The trick is run towards the teleporter and release the item, but do not go through with the item.  Otherwise you might telefrag yourself or the item.

It should land on the destination telepad or a short distance away.

Monsters and fired weapons at you will chase you through teleporters.

Grenades will fly and bounce through, so will the Reaper Drone.

Backpacks will go through teleporters. So will dropped packs and loose ammo from discard. 

Maps deisgned with ammo packs, painkeep items or weapons will transport through the teleporters.
(Are you fighting a big boss and not enough ammo/toys there? Not anymore.)

# Quirks:
Summoned monsters might only target the RED team if monster maps are selected.

Beartraps stick where you place them and cannot be shot off you once clamped.
They will eventually die, but if you stand still you don't take damage.

The Engineer with the grav gun can pickup or move them or trap opponents with them.

Beartraps will follow you through the teleporters once clamped.

Regular sentry guns and tesla coils envy the auto sentry guns and will target them as an enemy on your team.

This prevent someone just ganging a huge armada of sentry guns of both types along with the auto sentry guns.

Auto sentry guns are waterproof and cannot be toastered.

The toaster model updated with toaster.mdl and looks suspiciously like the After Dark toaster.

The following monsters were removed  to free up precache for sounds and models:
Ogre cook, Vermis(lame), eel, and gremlin which didn't work.

The minipet is superflous since you can "cmd summon" and the code needs work. Removed.
			
# BUGS:
If the map is designed properly with a lower amount of spawns, the limit of 512 entities should not be broken.
However, it is not a fatal error, you can restart a map or the server to try again.
A fix is in progress to address this and the limit on the number of sound effects precached.
The mega health box dropped by monster adds 100 health regardless of your health amount. It also cures infections. Previously it wouldn't help until you were below 250 health.

New bugs can be submitted to Github for tracking and resolution be unbiased.
Volunteer devs of code/fixes/features gladly accepted.
Special thanks to Agent for fixing the player fob and FuhQuake support.

# TODO:
Clean up source code for easy compiliation in fteccgui and 64bit versions. - 99.9% -arg

Add Painkeep explosive shotgun ammo when you pick up a pack from monsters. A few shells with rekt most monsters in a few shots.
If possible upgrade the lightning gun to the painkeep chain lightning gun.

Adjust starting armor and speeds to rebalance things.

All players start with at least 3 of each type of the two kinds of grenades. So drops require two type 2 work from the spawn on any map regardless for faster combat action. Besides some maps didn't have grenade ammo or some of the backpacks did not give grenades.
This makes it possible to plant a prox mine from the start as soldier for example.

The bear traps, spikes, caltrops, and auto sentry guns should slow down combat movement speed as it halts bunny hoppers.

Bunny hopping was a cheese and a hax to begin with, it destroys playability with balanced teams. Not every class can bunny hop easily.

Add another weapon to the Pyro for even more destructive backup. multi pyro rockets?
Allow the lightning gun to be toggled with the single barrel shotgun even though there is no shotgun ammo handy.

Add Ratbert's nuke grenades to drop4 for demoman or pyro. ? Perhaps.
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
At level 80 you get the Xav Needler gun.  Use impulse 9 to toggle between shotguns and needler/electric gun.

The lightning gun weapon comes up by selecting 2 and having the ammo masters skill at attribute 7 or higher.

Fastest completion time for flawless ending saved per map.

Achievement system similar to Xbox for bragging rights just like MegaTF COOP was.

Scout class has a bat for the axe, jetpack uses less cells, a bit more fire damage.

The sniper class had little changed. Already powerful and deadly enough. 

The soldier class gets a bit more dangerous with the upgraded amounts of grenades. The attributes system can boost this class to very powerful levels.

The Demoman gets sticky pipebombs and laser trip bombs added. Impulse 4 for sticky pipebombs and drop3 for laser trip bombs.

Medic can heal with cmd aura regardless of level, and further distance than players can with attribute of masters of healing.
Medic gets an upgrade of the super nailgun with lava nails. More damage per nail fired.

Heavy Weapons Guy can spool up assault cannon a bit faster, and uses less ammo per shot on 20mm mode.

Pyro can fire faster flame rockets, has a chainsaw, and gets results. He might get the lightning gun by default soon.

The Spy has a grappling hook that uses less cells, and can "poon" enemies for gibs. Just like in Pain Keep.

The Engineer can launch drones in a shorter timeframe, does a bit more damage per beam.

The Engineer gets a gravity gun, and can have a Tesla and Sentry built at the same time. Stack the death dealing high, rawhide!

All classes can buy weapon upgrades, powerups, and inventory then with the merchant and used them with "cmd inv".

Custom skins are possible. Not restricted per class. Use "cmd customskin" Frag with your favorite character on.

Deployment of client and server files see releases.  New maps, models, and sound effects added from Frag Friday map designers Agent,
and K3vin. 

If you suicide after fighting, you will be punished 5 additional frags for denying your opponent their prey.

Another new combat rule. Doing a "cmd beg" in non-survival mode punishes you for teleporting for no purpose to the start spawn to prevent spamming of ammo and once again denying the opponent their prey.

If you take battle damage and suicide, you will be punished for a total of six points for avoiding a fight. If you are at full health you only take 1 point subtraction.
Moral is, fight till you die, you might get a frag in 
In survival mode you are not punished for the use of "cmd beg". If there are multiple human teams involved, that is for the admin or mod to police abuse. It can be set to punish if you were in combat and teleporting to home for no good reason.

# Releases:

https://github.com/argonatorUberTF/Uber-Team-Fortress/releases
Server and Client packs.

email: forgetitanyway@gmail.com

Discord: argonator#1511

Coders see addtional.pqc for notes and references.
Two new model filess included:
thedot.spr  The colored player fob to identify which team is for a possibly customskinned player
toaster.mdl A real toaster similar to After Dark for a homage.

Added compiled sound, model, and map packs as separate updates from 2020-2021 for new maps.
