# UPE-2024-Project


This is a multi-character battle simulation video game based on the race to the Goblet of Fire in the book "Harry Potter and the Goblet of Fire". I designed the graphical images for the male and female characters for the two opposing teams (the Order of the Phoenix and the Death Eaters), selected audio clips for sound effects and casting spells, created a user editable maze obstacle course, and designed battle strategy options for each of the individual characters which could act independently based on the enemy placements and obstacles in their surroundings. The user gets to experiment with different numbers of characters and location placements to see how that would change the tide of battle. For example, the Order of the Phoenix characters would start in defense or patrol mode; however, if an opponent initiated an attack or was within a certain range, then they would switch to attack mode. If a character sustained too much damage to their health or ran out of magical energy, it would change their battle mode and the types of spells they could cast. On the other hand, Death Eaters would start in approach mode to move further into the maze, and then switch to attack mode when near Order of the Phoenix characters unless they were close to the center of the maze where the prize sat. The game would only end when either the Order of the Phoenix characters reached the prize or only one team was left. I programmed in triumphant music and graphics for an Order of the Phoenix victory, and the spell “Morsmordre” summoned the Dark Mark image in the sky while eerie sound effects played in the case of a Death Eater victory.


Set Up:
1. Download NetLogo 6.1.1 (https://ccl.northwestern.edu/netlogo/6.1.1/).
2. Download the "Harry Potter Game" Folder and the "HarryPotterMazeGame.nlogo" file to your Desktop.
3. Open the "HarryPotterMazeGame.nlogo" file and click on the "Code" tab and scroll down to the "Setup" function (you can also use Ctrl + f "path" and it should be the second instance of find).
4. In the line that says:
      set path "C:\\Users\\sydney\\Desktop\\Harry Potter Game\\"
   change the path to whatever path your laptop/computer uses.
5. Go back to the Interface tab (by clicking on it).
6. You're ready to play!


How To Operate The Game:
1. Click the "Setup" button.
2. Once the "Setup" button is no longer black (which means it's still executing it's commands) you can change the "Time_Limit" using the slider, the "Character_Type" and "Character_Gender" using the drop down menus.
3. To make characters after setting the "Character_Type" and "Character_Gender" simply click on the "makeCharacter" button and using your mouse click anywhere on the maze in order to make an instance of that character there
4. After you're satisfied with the characters you've made and the "Time_Limit" that you've chosen click the "play" button.


Extra Tidbits:
1. There's a "Character_Gender" option because there's a sound effect for each gender (it's characters from the movies casting spells)
2. Each character has health and mana stats, depending on how much of each they have that'll change what spells they can cast (if they run out of health they die)
3. They can't just float over hedges/stone/physical material, so if you're playing and it seems like they're just yelling "Bombarda!" over and over again and there's no Death Eater or Phoenix member in sight, they're blasting through the maze to try and get to the center

(I lost a bet with a friend)
