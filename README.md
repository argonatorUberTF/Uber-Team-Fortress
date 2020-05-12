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

"cmd help" and "cmd help misc" updated with more command references. Some new, some binds, some already there but never mentioned.

It still gets into warnings on the console when there are more precached than it's limit on some maps
but still a minimum has been increased.

Removed sounds for taunts, yells. In order to add weapons and sound effects.

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
Some "coop" maps can have no monsters or you can remove the .ent file for no monsters on some.

The medic class can heal with masters skill "cmd aura" when spawned. Regardless of masters level of the
health attribute.							
 
# Quirks:
Summoned monsters might only target the RED team if monster maps are selected.

Beartraps stick where you place them and cannot be shot off you once clamped.

If you move they do more damage. Stand your ground or fight it out.

Beartraps will follow you through the teleporters once clamped.

Regular sentry guns and tesla coils envy the auto sentry guns and will target them as an enemy on your team.
This prevent someone just ganging a huge armada of sentry guns of both types along with the

Auto sentry guns are waterproof and cannot be toastered.

The following monsters were removed  to free up precache for sounds and models:
Ogre cook, Vermis(lame), eel, and gremlin which didn't work.

The minipet is superflous since you can cmd summon and the code needs work. Removed.
			
# BUGS:

New bugs can be submitted to Github for tracking and resolution be unbiased.
Volunteer devs of code/fixes/features gladly accepted.

# TODO:
Clean up source code for easy compiliation in fteccgui and 64bit versions. - 99% -arg
Down to 4 warnings on ftegccui compiler in Windows. It's the grappling hook, and it works. 

Submit said source to github for Open Source under GNU/GPL. - here now -arg

Add Painkeep explosive shotgun ammo when you pick up a pack from monsters. A few shells with rekt most monsters in a few shots.
If possible upgrade the lightning gun to the painkeep chain lightning gun.

Not tested on FTE or Prozac server yet. Volunteers ? The united code switches are not complete dealing with engine hooks.

Upgraded medic nail gun to nails with more damage, similar to the lava nails, but not quad damage. - done -arg.

Adjust starting armor and speeds to rebalance things.

Added the original caltrops from original Team Fortress. The scout, medic and spy can drop them separatly with impulse 121 or with drop 1 as a combo. 

All players start with at least 3 of each type of the two kinds of grenades. So drops require two type 2 work from the spawn on any map regardless for faster combat action. Besides some maps didn't have grenade ammo or some of the backpacks did not give grenades.
This makes it possible to plant a prox mine from the start as soldier for example.

Possibly put in an anti-bunny hopping system to remove the game glitch of angled bouncing.
It was never intended in the design and unbalances gameplay. A cheese.
It is nowhere fair when a hwguy can move as fast as a scout or a soldier passing a scout.
(Possibly add this as an anti-cheat system)

Add another weapon to the Pyro for even more destructive backup. multi pyro rockets?
Allow the lightning gun to be toggled with the single barrel shotgun.

Add Ratbert's nuke grenades to drop4 for demoman or pyro. ? Perhaps.
Add Prozac/Ratbert's mini sentry guns of differing types. Some monsters/players are affected more
by plasma or fire damage than blast/nail damage.

Tame down the survival mode with less extra monster spawns to stay under the 512 entities limit.
Then again, the map makers should be aware of this and not use so many spawns.
Add monsters to a map with a .ent file so regular MegaTF/UberTF matches can be done on the same map.

Finish HALF-LIFE map support. ?


# Changes to existing classes:
Since custom player skin can be uploaded to the server, it's hard to identify which team is which player.
Also the spy can ue custom skins, change colors, and top/bottom pants colors. So be on the lookout.
The spy was minimized and nerfed with auto ID ON. So you have to check yourself now.
Auto ID just tells you the name of the player or whose sentry gun/tesla built.
Each player gets a colored spot fob representing their team color that meanders nearby that player.

All classes spawn with a minimum of 3 type 1, and 3 type 2 grenades at level 0 newb starter.

If a map doesn't have ammo bags that give grenades, fix the maps.

Some monsters drop misc ammo and a few Painkeep items in the backpacks now.

Player dropped backpacks are different and include even more Painkeep items and misc ammo not related to their actual amount(randomly).

Amount of grenades is 3X your ammo attribute gained from experience. If you spend your attribute points gained on the "ammo" category, you get more grenades when spawned.

All classes get bonus health, armor, ammo, reload time, summoning etc from the 
attribute system based on experience points gained from frags and captures.
At level 80 you get the Xav Needler gun.  Use impulse 9 to toggle between shotguns and needler/electric gun.

The lightning gun weapon comes up by selecting 2 and having the ammo masters skill(level 7).
Achievement system similar to Xbox for bragging rights just like MegaTF COOP was.

Scout class has a bat for the axe, jetpack uses less cells, a bit more fire damage. He can deploy caltrops with flash mines on drop1 or impulse 121.

The sniper class had little changed. Already powerful and deadly enough. 
The soldier class gets a bit more dangerous with the upgraded amounts of grenades. The attributes system can boost this class to very powerful levels.

The Demoman gets sticky pipebombs and laser trip bombs added. Impulse 4 for sticky pipebombs and drop3 for laser trip bombs.

Medic can heal with cmd aura regardless of level, and further distance than players can with attribute of masters of healing.
Medic gets an upgrade of the super nailgun with lava nails. More damage per nail fired. Medics can drop caltrops with impulse 121 or the needler with drop1.

Heavy Weapons Guy can spool up assault cannon a bit faster, and uses less ammo per shot on 20mm mode.
The HWGUY got tungsten slugs and shotgun pellets for his higher pressured "sasha".

It packs a heftier punch and 20mm range has been extended. New slugs and higher pressure guns are a thing now. 

Pyro can fire faster flame rockets, has a chainsaw, and gets results. He might get the lightning gun by default soon.

The Spy has a grappling hook that uses less cells, and can "poon" enemies for gibs. Just like in Pain Keep.
The spy can sprinkle caltrops with the ammo trap, and impulse 121.

The Engineer can launch drones in a shorter timeframe, does a bit more damage per beam.
Be aware the drop carries a detpack for self destruction.

The Engineer spanner attack adds concussion to their enemies and sometimes himself/herself as the heavy tool bounces back.

The Engineer spanner also reduces armor on the opponent and the attacker gets misc cells from the players ammo vest that is ripped off with the tool. 

The Engineer gets a gravity gun, and can have a Tesla and Sentry built at the same time. Stack the death dealing high, rawhide!

All classes can buy weapon upgrades, powerups, and inventory then with the merchant and used them with "cmd inv" in the console.

Custom skins are possible. Not restricted per class. Use "cmd customskin" Frag with your favorite character on.
You can color your stock skin as you like, complete perfidy is impossible since the color dotted playerfob that shows your real team is visible.

Deployment of client and server files see releases.

A new combat rule. If you fight, you fight to the death.

If you suicide after fighting or while fighting, you will be punished 5 additional frags for denying your opponent their prey.
If you splash damage yourself dead, you might be punished for playing sloppily. However, if you are good overall, you will get points back and average out the misfortunes.  Be aware of the triple damage explosive rune, it can bite back. Ratbert calls it "A a showoff stunt once in a while. As you can gib yourself with it."

If you get stuck in a ditch/lava/slime or your teammates in survival mode cannot find or get to your body you can rescue yourself with "cmd beg".  If you disconnect or error out and come back shortly thereafter, you can "cmd beg" to rejoin the game.
Another new combat rule. Doing a "cmd beg" in NON-survival mode punishes you for teleporting for no purpose to the start spawn to prevent spamming of ammo and once again denying the opponent their prey.

In survival mode you are not punished for the use of "cmd beg". If there are multiple human teams involved, that is for the admin or mod to police abuse. It can be set to punish if you were in combat and teleporting to home for no good reason.

Donations glady accepted by bitcoin to address: 3J2nKrotxfP7mqQgTBotn4rgAvRqVhD1hh

email: forgetitanyway@gmail.com

Discord: argonator#1511

Coders see addtional.pqc for notes and references.
New code additions get their variables documented and comments for functions greatly appreciated to create some form of library spanning the different server platforms. That is what the purpose of United was, and shall be upheld.
