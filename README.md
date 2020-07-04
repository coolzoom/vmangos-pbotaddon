# vmangos-pbotaddon
  just a very simple bot ui for vmangos, 
  if you close it, re-open from main menu(esc), or the vmangos icon beside the minimap.
  
  vmangos core is Progressive Vanilla Core aimed at all versions from 1.2 to 1.12
  https://github.com/vmangos/core
![UI](https://github.com/coolzoom/vmangos-pbotaddon/blob/master/bots.jpg)

# how to install
- download and rename folder name to vbots
- copy and paste it into yourwowfolder/Interface/Addon
  final path would like yourwowfolder/Interface/Addon/vbots
- enable it from lower left corner the login screen

- for bots premade gear and spec, please select bots, and click the question mark to retrive the available gear/spec, then click the number to apply the gear/spec set


# other notice
- Notice, you have to be GM level 6 to use all commands
- I'm not good at addon, i just added 32 buttons for each, if you know there is a better way to set the gear/spec template welcome to make PR
- partybot add paladin is for alliance only, shaman is for horde only, you can change the source PlayerBotMgr.cpp line 806 and 814

else if (option == "paladin" && pPlayer->GetTeam() == ALLIANCE)

else if (option == "shaman" && pPlayer->GetTeam() == HORDE)
