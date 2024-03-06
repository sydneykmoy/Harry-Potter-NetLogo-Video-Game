; By Sydney K. Moy
; March 5th, 2024

extensions [sound]

;Character Breeds

breed [deathEaters deathEater]
deathEaters-own [
  maxMana
  currentMana
  maxMovement
  currentMovement
  maxHealth
  currentHealth
  control ;user vs. computer
  stunnedCounter
  gender ;male vs female
  defenseModeCountdown
  actionMode
  modeCounter]


breed [phoenixes phoenix]
phoenixes-own [
  maxMana
  currentMana
  maxMovement
  currentMovement
  maxHealth
  currentHealth
  control ;user vs. computer
  stunnedCounter
  gender ;male vs female
  defenseModeCountdown
  actionMode
  modeCounter]


;Spell Breeds

breed [spellStupefys spellStupefy]
spellStupefys-own [alignment spellDistanceCountdown] ;light vs. dark

breed [spellReductos spellReducto]
spellReductos-own [alignment spellDistanceCountdown] ;light vs. dark

breed [spellBombardas spellBombarda]
spellBombardas-own [alignment spellDistanceCountdown] ;light vs. dark

breed [spellCrucios spellCrucio]
spellCrucios-own [alignment spellDistanceCountdown] ;light vs. dark

breed [spellSectumsempras spellSectumsempra]
spellSectumsempras-own [alignment spellDistanceCountdown] ;light vs. dark


;Patch Characterstics

patches-own [
  phoenixWin deathEaterWin obstacleType materialCountdown;stone hedge illusion goblet openspace
]

globals [path stopGame characterX characterY]


to makeDeathEater [ x y max_Mana max_Movement max_Health deathEaterGender action_Mode]
  create-deathEaters 1 [
    set xcor x
    set ycor y
    set maxMana max_Mana
    set currentMana max_Mana
    set maxMovement max_Movement
    set currentMovement max_Movement
    set maxHealth max_Health
    set currentHealth max_Health
    set control "computer"
    set stunnedCounter 0
    set gender deathEaterGender
    set actionMode action_Mode ;guard v. attacker v. defense
    set modeCounter 0
    set shape "deathEater"
    set color red
    set size 30]
end


to makePhoenix [ x y max_Mana max_Movement max_Health phoenixGender]
  create-phoenixes 1 [
    set xcor x
    set ycor y
    set maxMana max_Mana
    set currentMana max_Mana
    set maxMovement max_Movement
    set currentMovement max_Movement
    set maxHealth max_Health
    set currentHealth max_Health
    set control "computer"
    set stunnedCounter 0
    set gender phoenixGender
    set actionMode "mission" ;mission followRight followLeft defense
    set modeCounter 0
    set shape "phoenix"
    set color white
    set size 30]
end


to makeCharacter
  let characterCreated false
  reset-timer

  while [timer < 30 and characterCreated = false ]

  [wait 0.2
    show (word "Time Remaining: " (30 - timer))

    if mouse-down? [

      ifelse Character_Type = "Phoenix Rescuer"
      [create-phoenixes 1 [
       set characterCreated true
       set xcor mouse-xcor
       set ycor mouse-ycor
       set maxMana 50
       set currentMana maxMana
       set maxMovement 2
       set currentMovement maxMovement
       set maxHealth 20
       set currentHealth maxHealth
       set control "computer"
       set stunnedCounter 0
       set gender Character_Gender
       set actionMode "mission" ;mission followRight followLeft defense
       set modeCounter 0
       set shape "phoenix"
       set color white
        set size 30]]

      [ifelse Character_Type = "Death Eater Guard"
        [create-deathEaters 1 [
         set characterCreated true
         set xcor mouse-xcor
         set ycor mouse-ycor
         set maxMana 50
         set currentMana maxMana
         set maxMovement 2
         set currentMovement maxMovement
         set maxHealth 20
         set currentHealth maxHealth
         set control "computer"
         set stunnedCounter 0
         set gender Character_Gender
         set actionMode "guard" ;guard v. attacker v. defense
         set modeCounter 0
         set shape "deathEater"
         set color red
         set size 30]]

        [ifelse Character_Type = "Death Eater Attacker"
          [create-deathEaters 1 [
           set characterCreated true
           set xcor mouse-xcor
           set ycor mouse-ycor
           set maxMana 50
           set currentMana maxMana
           set maxMovement 2
           set currentMovement maxMovement
           set maxHealth 20
           set currentHealth maxHealth
           set control "computer"
           set stunnedCounter 0
           set gender Character_Gender
           set actionMode "attacker" ;guard v. attacker v. defense
           set modeCounter 0
           set shape "deathEater"
           set color red
           set size 30]]

          [show "Error: No such character exists."]]]]]
end


;Utilitie Functions

to-report testColor [patchColor RGBcolor]
  ifelse (( abs ( (item 0 patchColor) - (item 0 RGBcolor) ) + abs ((item 1 patchColor) - (item 1 RGBcolor) ) + abs ( (item 2 patchColor) - (item 2 RGBcolor) ) ) / 3.0) < 2.0
  [report true]
  [report false]
end

to Setup
  ca
  set path "C:\\Users\\sydne\\Desktop\\Harry Potter Game\\"
  resize-world -300 300 -300 300
  set-patch-size 1
  import-pcolors-rgb (word path "Ending_Phoenix.png")
  ask patches [set phoenixWin pcolor]
  import-pcolors-rgb (word path "Ending_DarkMark.png")
  ask patches [set deathEaterWin pcolor]
  import-pcolors-rgb (word path "maze-pixilart.png")
  set Time_Limit 100
  playSound "Maze_Intro.wav"
  wait 20
  ask patches [
    (ifelse
    (testColor pcolor (list 0 0 0)) [set obstacleType "openspace" set materialCountdown 0]
    (testColor pcolor (list 158 158 158)) [set obstacleType "stone" set materialCountdown 10]
    (testColor pcolor (list 27 94 32)) [set obstacleType "hedge" set materialCountdown 5]
    (testColor pcolor (list 139 195 74)) [set obstacleType "illusion" set materialCountdown 0]
    (testColor pcolor (list 255 235 59)) [set obstacleType "goblet" set materialCountdown 20]
    (testColor pcolor (list 255 193 7)) [set obstacleType "goblet" set materialCountdown 20]
    (testColor pcolor (list 255 152 0)) [set obstacleType "goblet" set materialCountdown 20]
    (testColor pcolor (list 255 255 255)) [set obstacleType "goblet" set materialCountdown 20]
      [set obstacleType "openspace"])]
  set stopGame false
end


;to-report getHeading [deltax deltay]
 ; report atan deltax deltay
;end

to-report getHeadingChange [x1 x2 y1 y2]
  if is-list? x1 [ifelse length x1 > 0 [set x1 (item 0 x1)] [set x1 0] ]
  if is-list? x2 [ifelse length x2 > 0 [set x2 (item 0 x2)] [set x2 0] ]
  if is-list? y1 [ifelse length y1 > 0 [set y1 (item 0 y1)] [set y1 0] ]
  if is-list? y2 [ifelse length y2 > 0 [set y2 (item 0 y2)] [set y2 0] ]

  report atan (x1 - x2) (y1 - y2)
end

to playSound [filename]
  sound:play-sound-later (word path filename) 1
end

to playSoundLater [filename]
  sound:play-sound-later (word path filename) 1
end

to castSpell [spellName originX originY spellHeading casterAlignment casterGender]
  (ifelse

    spellName = "Stupefy" and casterGender = "Male"
    [hatch-spellStupefys 1 [
      set shape "Stupefy"
      set color red
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      set spellDistanceCountdown 20
      sound:play-sound (word path "Harry_Stupefy.wav")]]

    spellName = "Stupefy" and casterGender = "Female"
    [hatch-spellStupefys 1 [
      set shape "Stupefy"
      set color red
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Hermione_Stupefy.wav")
      set spellDistanceCountdown 20]]

    spellName = "Reducto" and casterGender = "Male"
    [hatch-spellReductos 1 [
      set shape "Reducto"
      set color orange
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Harry_Reducto.wav")
      set spellDistanceCountdown 25]]

    spellName = "Reducto" and casterGender = "Female"
    [hatch-spellReductos 1 [
      set shape "Reducto"
      set color orange
      set size 10
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Ginny_Reducto.wav")
      set spellDistanceCountdown 25]]

    spellName = "Bombarda" and casterGender = "Female"
    [hatch-spellBombardas 1 [
      set shape "Bombarda"
      set color green
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Hermione_Bombarda.wav")
      set spellDistanceCountdown 35]]

    spellName = "Bombarda" and casterGender = "Male"
    [hatch-spellBombardas 1 [
      set shape "Bombarda"
      set color green
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Hermione_Bombarda.wav")
      set spellDistanceCountdown 35]]

    spellName = "Crucio" and casterGender = "Male"
    [hatch-spellCrucios 1 [
      set shape "Crucio"
      set color blue
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Moody_Crucio.wav")
      set spellDistanceCountdown 10]]

    spellName = "Crucio" and casterGender = "Female"
    [hatch-spellCrucios 1 [
      set shape "Crucio"
      set color blue
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Moody_Crucio.wav")
      set spellDistanceCountdown 10]]

    spellName = "Sectumsempra" and casterGender = "Male"
    [hatch-spellSectumsempras 1 [
      set shape "Sectumsempra"
      set color violet
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Harry_Sectumsempra.wav")
      set spellDistanceCountdown 15]]

    spellName = "Sectumsempra" and casterGender = "Female"
    [hatch-spellSectumsempras 1 [
      set shape "Sectumsempra"
      set color violet
      set size 100
      set alignment casterAlignment
      set xcor originX
      set ycor originY
      set heading spellHeading
      sound:play-sound (word path "Harry_Sectumsempra.wav")
      set spellDistanceCountdown 15]]

    [show (word "Error: Undefined Spell " gender spellName)])
end


to characterMaintenance
  let healthFactor .00001
  let magicFactor .06
  ask phoenixes [
    if currentMana < maxMana [set currentMana ( (maxMana * magicFactor) + currentMana)]
    if currentHealth < maxHealth [set currentHealth ( (maxHealth * healthFactor) + currentHealth)]
    if stunnedCounter > 0 [set stunnedCounter (stunnedCounter - 1)]
    if defenseModeCountdown > 0 [set defenseModeCountdown (defenseModeCountdown - 1)]
    if modeCounter > 0 [set modeCounter (modeCounter - 1)]]
  ask deathEaters [
    if currentMana < maxMana [set currentMana ( (maxMana * magicFactor) + currentMana)]
    if currentHealth < maxHealth [set currentHealth ( (maxHealth * healthFactor) + currentHealth)]
    if stunnedCounter > 0 [set stunnedCounter (stunnedCounter - 1)]
    if defenseModeCountdown > 0 [set defenseModeCountdown (defenseModeCountdown - 1)]
    if modeCounter > 0 [set modeCounter (modeCounter - 1)]]
end


to playSpell
  let place (patch-at 0 0)
  let counter 5
  let stunTime 10
  let reductoHealthDamage 6
  let reductoMaterialDamage 5
  let bombardaHealthDamage 8
  let bombardaMaterialDamage 7
  let sectumsempraHealthDamage 4
  let sectumsempraMaterialDamage 3
  let crucioHealthDamage 8
  let crucioTime 5
  let defenseIncrement 10

  ask spellStupefys [
    set counter 5
    while [counter > 0]
    [set counter (counter - 1)
    fd 1
    set spellDistanceCountdown (spellDistanceCountdown - 1)
    if spellDistanceCountdown < 0 [die]
    set place patch-here
    if [obstacleType] of place = "stone" [die]
    if [obstacleType] of place = "hedge" [die]
    if [obstacleType] of place = "goblet" [die]
    if [obstacleType] of place = "illusion" [set obstacleType "openspace" set pcolor (list 0 0 0) ]
    if alignment = "light" [ask deathEaters in-radius 1 [show "Stupefy hit DeathEater." set stunnedCounter (stunnedCounter + stunTime) set defenseModeCountdown (defenseModeCountdown + defenseIncrement)] ask spellStupefys-here [die]]]]

  ask spellReductos [
    set counter 5
    while [counter > 0]
    [set counter (counter - 1)
    fd 1
    set spellDistanceCountdown (spellDistanceCountdown - 1)
    if spellDistanceCountdown < 0 [die]
    set place patch-here
    if ([obstacleType] of place) = "stone" [die set materialCountdown (materialCountdown - reductoMaterialDamage)]
    if [obstacleType] of place = "hedge" [die set materialCountdown (materialCountdown - reductoMaterialDamage)]
    if [obstacleType] of place = "goblet" [die]
    if ([obstacleType] of place) = "illusion" [set obstacleType "openspace" set pcolor (list 0 0 0) ]
    if alignment = "light" [ask deathEaters in-radius 1 [show "Reducto hit DeathEater." set currentHealth (currentHealth - reductoHealthDamage) if actionMode = "guard" [set actionMode "defense" show "Death Eater switching to defense."]] ask spellReductos-here [die]]
    if alignment = "dark" [ask phoenixes in-radius 1 [show "Reducto hit Phoenix." set currentHealth (currentHealth - reductoHealthDamage) set defenseModeCountdown (defenseModeCountdown + defenseIncrement) show "Phoenix switching to defense."] ask spellReductos-here [die]]]]

  ask spellBombardas [
    set counter 5
    while [counter > 0]
    [set counter (counter - 1)
    fd 1
    set spellDistanceCountdown (spellDistanceCountdown - 1)
    if spellDistanceCountdown < 0 [die]
    set place patch-here
    if [obstacleType] of place = "stone" [die set materialCountdown (materialCountdown - bombardaMaterialDamage)]
    if [obstacleType] of place = "hedge" [die set materialCountdown (materialCountdown - bombardaMaterialDamage)]
    if [obstacleType] of place = "goblet" [die]
    if [obstacleType] of place = "illusion" [set obstacleType "openspace" set pcolor (list 0 0 0) ]
    if alignment = "light" [ask deathEaters in-radius 1 [show "Bombarda hit DeathEater." set currentHealth (currentHealth - bombardaHealthDamage) set defenseModeCountdown (defenseModeCountdown + defenseIncrement)] ask spellBombardas-here [die]]]]

  ask spellSectumsempras [
    set counter 5
    while [counter > 0]
    [set counter (counter - 1)
    fd 1
    set spellDistanceCountdown (spellDistanceCountdown - 1)
    if spellDistanceCountdown < 0 [die]
    set place patch-here
    if [obstacleType] of place = "stone" [die set materialCountdown (materialCountdown - sectumsempraMaterialDamage)]
    if [obstacleType] of place = "hedge" [die set materialCountdown (materialCountdown - sectumsempraMaterialDamage)]
    if [obstacleType] of place = "goblet" [die]
    if [obstacleType] of place = "illusion" [set obstacleType "openspace" set pcolor (list 0 0 0) ]
    if alignment = "dark" [ask phoenixes in-radius 1 [show "Sectumsempra hit Phoenix." set currentHealth (currentHealth - sectumsempraHealthDamage) set defenseModeCountdown (defenseModeCountdown + defenseIncrement)] ask spellSectumsempras-here [die]]]]

  ask spellCrucios [
    set counter 5
    while [counter > 0]
    [set counter (counter - 1)
    fd 1
    set spellDistanceCountdown (spellDistanceCountdown - 1)
    if spellDistanceCountdown < 0 [die]
    set place patch-here
    if [obstacleType] of place = "stone" [die]
    if [obstacleType] of place = "hedge" [die]
    if [obstacleType] of place = "goblet" [die]
    if [obstacleType] of place = "illusion" [set obstacleType "openspace" set pcolor (list 0 0 0) ]
    if alignment = "dark" [ask phoenixes in-radius 1 [set stunnedCounter (stunnedCounter + crucioTime) set currentHealth (currentHealth - crucioHealthDamage) set defenseModeCountdown (defenseModeCountdown + defenseIncrement)] ask spellCrucios-here [die]]]]
end


to spellDamage
  ask phoenixes [
    if currentHealth < 1 [die] ]
  ask deathEaters [
    if currentHealth < 1 [die] ]
  ask patches with [materialCountdown < 1 and obstacleType != "illusion"] [set pcolor black set obstacleType "openspace"]
end


to phoenixStrategies
  let stupefyCost 2
  let reductoCost 3
  let bombardaCost 5


  ask phoenixes [
  (ifelse stunnedCounter > 0

    [set shape "phoenixProstrate"]

    defenseModeCountdown > 0
     [set shape "phoenix"
      ifelse count deathEaters in-radius 5 > 0
       [let target (deathEaters with-max [currentMana] in-radius 5)
        if currentMana >= stupefyCost
         [castSpell "Stupefy" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "light" gender set currentMana (currentMana - stupefyCost)]]

       [ifelse count deathEaters in-radius 10 > 0
        [let target (deathEaters with-max [currentMana] in-radius 10)
          if currentMana >= stupefyCost
          [castSpell "Stupefy" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "light" gender set currentMana (currentMana - stupefyCost)]]

        [ifelse count deathEaters in-radius 15 > 0
          [let target (deathEaters with-max [currentMana] in-radius 15)
            if currentMana >= stupefyCost
            [castSpell "Stupefy" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "light" gender set currentMana (currentMana - stupefyCost)]]

          [ifelse count deathEaters in-radius 20 > 0
            [let target (deathEaters with-max [currentMana] in-radius 20)
              if currentMana >= stupefyCost
              [castSpell "Stupefy" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "light" gender set currentMana (currentMana - stupefyCost)]]

            [ifelse count deathEaters in-radius 25 > 0
              [let target (deathEaters with-max [currentMana] in-radius 15)
                if currentMana >= stupefyCost
                [castSpell "Reducto" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "light" gender set currentMana (currentMana - reductoCost)]]

              [if count deathEaters in-radius 30 > 0
                [let target (deathEaters with-max [currentMana] in-radius 30)
                  if currentMana >= stupefyCost
                  [castSpell "Bombarda" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "light" gender set currentMana (currentMana - bombardaCost)]]]]]]]]

    actionMode = "mission"
    [set shape "phoenix"
     set heading (getHeadingChange 0 xcor 0 ycor)
      ifelse [obstacleType] of patch-ahead 1 = "openspace"
      [fd 1
          if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
      [ifelse [obstacleType] of (patch-left-and-ahead 90 1) = "openspace"
        [set heading (heading - 90) fd 1 set actionMode "followLeft" set modeCounter 15]
        [ifelse [obstacleType] of (patch-right-and-ahead 90 1) = "openspace"
          [set heading (heading + 90) fd 1 set actionMode "followRight" set modeCounter 15]
          [set actionMode "blast" show "Phoenix switching to blast mode."]]]]

    actionMode = "followLeft"
    [set shape "phoenix"
     if modeCounter < 1 [set actionMode "blast" show "Phoenix switching to blast mode."]
      ifelse [obstacleType] of patch-ahead 1 = "openspace"
      [fd 1
        if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
      [if [obstacleType] of (patch-left-and-ahead 90 1) = "openspace"
        [set heading (heading - 90) fd 1]]]

    actionMode = "followRight"
    [set shape "phoenix"
     if modeCounter < 1 [set actionMode "blast" show "Phoenix switching to blast mode."]
      ifelse [obstacleType] of patch-ahead 1 = "openspace"
      [fd 1
        if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
      [if [obstacleType] of (patch-right-and-ahead 90 1) = "openspace"
        [set heading (heading + 90) fd 1]]]

    actionMode = "blast"
    [set shape "phoenix"
      set heading (getHeadingChange 0 xcor 0 ycor)
      ifelse [obstacleType] of patch-ahead 1 = "openspace"
      [fd 1
        if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
      [ifelse currentMana >= bombardaCost
        [ifelse random 1 = 0
          [castSpell "Bombarda" xcor ycor heading "light" gender set currentMana (currentMana - bombardaCost)]
          [castSpell "Reducto" xcor ycor heading "light" gender set currentMana (currentMana - reductoCost)]]
        [if currentMana >= reductoCost [castSpell "Reducto" xcor ycor heading "light" gender] set currentMana (currentMana - reductoCost)]]]

   [show "Error: Invalid Phoenix Mode."]) ]
end


to deathEaterStrategies
  let sectumsempraCost 3
  let reductoCost 3
  let crucioCost 7

  ask deathEaters [
    (ifelse

      stunnedCounter > 0
      [set shape "deathEaterProstrate"]

      defenseModeCountdown > 0
      [set shape "deathEater"
        ifelse count phoenixes in-radius 5 > 0
         [let target (phoenixes with-min [currentHealth] in-radius 5)
          ifelse currentMana >= crucioCost
              [ifelse random 1 = 0
                [castSpell "Crucio" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - crucioCost)]
                [castSpell "Sectumsempra" xcor ycor ((getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor)) "dark" gender set currentMana (currentMana - sectumsempraCost)]]
            [if currentMana >= sectumsempraCost [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]]

         [ifelse count phoenixes in-radius 10 > 0
          [let target (phoenixes with-min [currentHealth] in-radius 10)
           ifelse currentMana >= crucioCost
              [ifelse random 1 = 0
                [castSpell "Crucio" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - crucioCost)]
                  [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]
            [if currentMana >= sectumsempraCost [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]]

          [ifelse count phoenixes in-radius 15 > 0
            [let target (phoenixes with-min [currentHealth] in-radius 15)
              if currentMana >= sectumsempraCost
              [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]

            [ifelse count phoenixes in-radius 20 > 0
              [let target (phoenixes with-min [currentHealth] in-radius 20)
                if currentMana >= reductoCost
                [castSpell "Reducto" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - reductoCost)]]

              [if count phoenixes in-radius 25 > 0
                [let target (phoenixes with-min [currentHealth] in-radius 25)
                  if currentMana >= reductoCost
                [castSpell "Reducto" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - reductoCost)]]] ]]]]

      actionMode = "attacker"
      [set shape "deathEater"
        ifelse count phoenixes in-radius 5 > 0
         [let target (phoenixes with-min [currentHealth] in-radius 5)
          set heading (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor)
          if [obstacleType] of patch-ahead 1 = "openspace"
            [fd 1
            if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
          ifelse currentMana >= crucioCost
              [ifelse random 1 = 0
                [castSpell "Crucio" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - crucioCost)]
                [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]
              [if currentMana >= sectumsempraCost [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]]

         [ifelse count phoenixes in-radius 10 > 0
          [let target (phoenixes with-min [currentHealth] in-radius 10)
           set heading (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor)
           if [obstacleType] of patch-ahead 1 = "openspace"
            [fd 1
            if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
            ifelse currentMana >= crucioCost
              [ifelse random 1 = 0
                [castSpell "Crucio" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - crucioCost)]
                [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]
            [if currentMana >= sectumsempraCost [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]]

          [ifelse count phoenixes in-radius 15 > 0
            [let target (phoenixes with-min [currentHealth] in-radius 15)
             set heading getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor
             if [obstacleType] of patch-ahead 1 = "openspace"
              [fd 1
              if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
              if currentMana >= sectumsempraCost
              [castSpell "Sectumsempra" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - sectumsempraCost)]]

            [ifelse count phoenixes in-radius 20 > 0
              [let target (phoenixes with-min [currentHealth] in-radius 20)
               set heading getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor
               if [obstacleType] of patch-ahead 1 = "openspace"
                [fd 1
                if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
                if currentMana >= reductoCost
                [castSpell "Reducto" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - reductoCost)]]

              [if count phoenixes in-radius 25 > 0
                [let target (phoenixes with-min [currentHealth] in-radius 25)
                  set heading getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor
                 if [obstacleType] of patch-ahead 1 = "openspace"
                  [fd 1
                  if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]]
                  if currentMana >= reductoCost
                  [castSpell "Reducto" xcor ycor (getHeadingChange ([xcor] of target) xcor ([ycor] of target) ycor) "dark" gender set currentMana (currentMana - reductoCost)]]
      ]]]]]

      actionMode = "guard"
      [ while [[obstacleType] of patch-ahead 1 != "openspace"]
        [ifelse random 1 = 0 [lt random 30] [rt random 30] ]

        if [obstacleType] of patch-ahead 1 = "openspace" [fd 1]
        if count phoenixes in-radius 30 > 0 [ set actionMode "attacker" show "Death Eater switching to attack mode."]]

      [show "Error: Invalid DeathEater Mode."])]
end

to paintPhoenix
  let span 300
  let indexX (- span)
  let indexY span
  hatch 1
  [hide-turtle
    while [indexY > (- span)]
    [while [indexX < span]
      [set xcor indexX
        set ycor  indexY
        ask patch-here [set pcolor phoenixWin]
        set indexX (indexX + 1)]
      set indexX (- span)
      set indexY (indexY - 1)] die]
end

to paintDarkMark
  let span 300
  let indexX (- span)
  let indexY span
  hatch 1
  [hide-turtle
    while [indexY > (- span)]
    [while [indexX < span]
      [set xcor indexX
        set ycor  indexY
        ask patch-here [set pcolor deathEaterWin]
        set indexX (indexX + 1)]
      set indexX (- span)
      set indexY (indexY - 1)] die]
end

to play
  while
  [Time_Limit > 0]
  ;[count phoenixes > 0 and (count phoenixes with [([obstacleType] of patch-here = "goblet")]) = 0 and stopGame = false]
  [set Time_Limit (Time_Limit - 1)
   show Time_Limit
   characterMaintenance
   playSpell
   spellDamage
   phoenixStrategies
   deathEaterStrategies
    ask phoenixes [
     if [obstacleType] of patch-here = "goblet" [
        paintPhoenix
        playSoundLater "Fawkes.wav"
        show "The Order Of The Phoenix Wins." set Time_Limit 0]
    ]
    if not any? phoenixes [
      paintDarkMark
      playSoundLater "DarkEnding.wav"
      show "Morsmorde: The Death Eaters Win." set Time_Limit 0
    ]
  ]
end


to-report phoenixNumber
  report count phoenixes
end

to-report deathEaterNumber
  report count deathEaters
end

to-report phoenixHealth
  report mean [currentHealth] of phoenixes
end

to-report deathEaterHealth
  report mean [currentHealth] of deathEaters
end





@#$#@#$#@
GRAPHICS-WINDOW
210
10
819
620
-1
-1
1.0
1
10
1
1
1
0
1
1
1
-300
300
-300
300
0
0
1
ticks
30.0

BUTTON
9
88
111
121
Setup
Setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
10
137
73
170
play
ask turtles [play]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
11
193
115
238
Phoenixes
phoenixNumber
17
1
11

MONITOR
11
257
140
302
DeathEaters
deathEaterNumber
17
1
11

MONITOR
12
322
115
367
phoenixHealth
phoenixHealth
17
1
11

MONITOR
13
390
131
435
deathEaterHealth
deathEaterHealth
17
1
11

CHOOSER
13
471
187
516
Character_Type
Character_Type
"Phoenix Rescuer" "Death Eater Guard" "Death Eater Attacker"
2

CHOOSER
13
528
151
573
Character_Gender
Character_Gender
"Male" "Female"
0

SLIDER
8
33
180
66
Time_Limit
Time_Limit
100
1000
100.0
25
1
NIL
HORIZONTAL

BUTTON
13
597
138
630
makeCharacter
makeCharacter
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bombarda
true
0
Rectangle -13840069 true false 90 90 210 180

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

crucio
true
0
Rectangle -13791810 true false 75 135 255 180

cylinder
false
0
Circle -7500403 true true 0 0 300

deatheater
false
0
Polygon -1 true false 30 120 45 150 75 195 60 195 60 195 45 165
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -16777216 true false 90 120 150 15 210 120 180 0 120 0
Polygon -2674135 true false 120 90 105 90 60 195 90 210 120 165 90 285 105 300 195 300 210 285 180 165 210 210 240 195 195 90
Polygon -7500403 true true 135 90 120 90 150 135 180 90 165 90 150 105
Line -7500403 true 195 90 150 135
Line -7500403 true 105 90 150 135
Polygon -16777216 true false 135 90 150 105 165 90
Line -16777216 false 120 45 135 90
Line -16777216 false 180 45 165 90
Rectangle -16777216 true false 105 75 120 90
Rectangle -16777216 true false 180 75 195 90
Polygon -16777216 true false 30 75 30 60
Polygon -16777216 true false 30 60
Rectangle -16777216 true false 120 75 135 90
Rectangle -16777216 true false 105 60 120 75
Rectangle -16777216 true false 165 75 180 90
Line -16777216 false 135 45 165 75
Line -16777216 false 165 45 135 90
Circle -16777216 false false 30 60 0

deatheaterprostrate
false
0
Polygon -1 true false 120 270 150 255 195 225 195 240 195 240 165 255
Circle -7500403 true true 5 110 80
Rectangle -7500403 true true 79 128 94 173
Polygon -16777216 true false 120 210 15 150 120 90 0 120 0 180
Polygon -2674135 true false 90 180 90 195 195 240 210 210 165 180 285 210 300 195 300 105 285 90 165 120 210 90 195 60 90 105
Polygon -7500403 true true 90 165 90 180 135 150 90 120 90 135 105 150
Line -7500403 true 90 105 135 150
Line -7500403 true 90 195 135 150
Polygon -16777216 true false 90 165 105 150 90 135
Line -16777216 false 45 180 90 165
Line -16777216 false 45 120 90 135
Rectangle -16777216 true false 75 180 90 195
Rectangle -16777216 true false 75 105 90 120
Polygon -16777216 true false 75 270 60 270
Polygon -16777216 true false 60 270
Rectangle -16777216 true false 75 165 90 180
Rectangle -16777216 true false 60 180 75 195
Rectangle -16777216 true false 75 120 90 135
Line -16777216 false 45 165 75 135
Line -16777216 false 45 135 90 165
Circle -16777216 false false 60 270 0

dot
false
0
Circle -7500403 true true 90 90 120

dumbles
false
0
Polygon -1 true false 45 165 85 213 90 195 75 180 75 180 30 150
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -10899396 true false 90 30 105 45 195 30 180 0 120 -15
Polygon -7500403 true true 120 90 105 90 75 180 90 195 120 165 90 285 105 300 195 300 210 285 180 165 210 210 225 180 195 90
Polygon -16777216 true false 135 90 120 90 150 135 180 90 165 90 150 105
Line -16777216 false 195 90 150 225
Line -16777216 false 105 90 180 300
Polygon -7500403 true true 135 90 150 105 165 90
Polygon -1 true false 120 60 180 60 210 105 150 90 90 120 120 60

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

harrypotter
false
0
Polygon -1 true false 45 150 45 165 60 195 75 195 60 180 45 135
Circle -1 true false 110 5 80
Rectangle -1 true false 127 79 172 94
Polygon -6459832 true false 105 30 150 15 195 30 165 -15 120 0
Polygon -16777216 true false 120 90 105 90 60 180 90 195 120 150 90 270 120 255 180 255 210 270 180 150 210 195 240 180 195 90
Polygon -1184463 true false 135 90 120 90 150 135 180 90 165 90 150 105
Line -2674135 false 195 90 150 135
Line -2674135 false 105 90 150 135
Polygon -1 true false 135 90 150 105 165 90
Rectangle -2674135 true false 120 255 150 270
Rectangle -16777216 true false 105 270 150 285
Rectangle -2674135 true false 150 255 180 270
Rectangle -16777216 true false 150 270 195 285
Rectangle -1184463 true false 165 120 180 135
Rectangle -1184463 true false 120 75 135 90
Rectangle -1184463 true false 150 75 165 90
Rectangle -2674135 true false 135 75 150 90
Rectangle -2674135 true false 165 75 180 90
Rectangle -2674135 true false 120 90 135 105
Rectangle -1184463 true false 120 105 135 120
Line -16777216 false 150 15 135 30
Line -16777216 false 150 45 135 30
Line -16777216 false 150 45 135 60

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person graduate
false
0
Circle -16777216 false false 39 183 20
Polygon -1 true false 50 203 85 213 118 227 119 207 89 204 52 185
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -8630108 true false 90 19 150 37 210 19 195 4 105 4
Polygon -8630108 true false 120 90 105 90 60 195 90 210 120 165 90 285 105 300 195 300 210 285 180 165 210 210 240 195 195 90
Polygon -1184463 true false 135 90 120 90 150 135 180 90 165 90 150 105
Line -2674135 false 195 90 150 135
Line -2674135 false 105 90 150 135
Polygon -1 true false 135 90 150 105 165 90
Circle -1 true false 104 205 20
Circle -1 true false 41 184 20
Circle -16777216 false false 106 206 18
Line -2674135 false 208 22 208 57

phoenix
false
0
Polygon -1 true false 30 120 45 150 75 195 60 195 60 195 45 165
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -8630108 true false 90 120 150 15 210 120 180 0 120 0
Polygon -8630108 true false 120 90 105 90 60 195 90 210 120 165 90 285 105 300 195 300 210 285 180 165 210 210 240 195 195 90
Polygon -7500403 true true 135 90 120 90 150 135 180 90 165 90 150 105
Line -7500403 true 195 90 150 135
Line -7500403 true 105 90 150 135
Polygon -16777216 true false 135 90 150 105 165 90

phoenixprostrate
false
0
Polygon -1 true false 180 30 150 45 105 75 105 60 105 60 135 45
Circle -7500403 true true 215 110 80
Rectangle -7500403 true true 206 127 221 172
Polygon -8630108 true false 180 90 285 150 180 210 300 180 300 120
Polygon -8630108 true false 210 120 210 105 105 60 90 90 135 120 15 90 0 105 0 195 15 210 135 180 90 210 105 240 210 195
Polygon -7500403 true true 210 135 210 120 165 150 210 180 210 165 195 150
Line -7500403 true 210 195 165 150
Line -7500403 true 210 105 165 150
Polygon -16777216 true false 210 135 195 150 210 165

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

reducto
true
0
Rectangle -955883 true false 135 135 165 165

sectumsempra
true
0
Circle -7500403 true true 135 135 30

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

stupefy
true
0
Rectangle -2674135 true false 75 195 120 240

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
