# SPACE SNEK
## Description
A simple game made by [Axel Elmarsson](https://github.com/elmaxe) and [Lara Rostami](https://github.com/larasik) (former Lara Sheik) for the course [DD1349 Projektuppgift i introduktion till datalogi](https://www.kth.se/student/kurser/kurs/DD1349) at KTH in April/May 2018.<br>

We used the [LÖVE 2D Game Engine for .lua](https://love2d.org/).

## What is the game about?
**SPACE SNEK!**
Play as SNEK, A giant space snek who feeds on stars and planets is roaming the galaxy. Beware of the black holes! These holes will suck everything into itself, including SNEK! Take powerups to escape the wrath of the black holes, whilst trying to catch as many stars as possible!

![SpaceSnek menu](/screenshots/SpaceSnek_menu.png)
![SpaceSnek gameplay](/screenshots/SpaceSnek_gameplay.png)
![SpaceSnek gameplay2](/screenshots/SpaceSnek_gameplay2.png)

This game includes:
- Original artwork by Axel Elmarsson (and some art by Lara Rostami)
- Somewhat original music by Lara Rostami
- Original audio recordings
- No microtransactions!
- A beautiful credits screen
- Love <3

## Libraries
Libraries we use:

- The [Classic](https://github.com/rxi/classic) library, which adds the ability to create objects.
- The [TSerial](https://love2d.org/wiki/Tserial) library which allows us to save and load tables into text files. This is used for saving high score.

These are included in the repo in `src/libraries/`

## Installation
[LÖVE](https://love2d.org/) is required to run the game.

### Linux
Navigate to root game folder and run `love src/`

### Windows
#### Alternative 1
From bash command line:<br>
**Syntax:** `LovePath GameFolderPath`<br>
Example: `"C:\Program Files\LOVE\love.exe" "C:\games\mygame"`

#### Alternative 2
Run the .exe file in the exec folder. Include the .dll files!

### OSX

Launch the .app in the exec folder.


*This readme-file was rewritten in October 2019 before moving the repo to public github (a.k.a while procrastinating studying for exams). Yes, the code for this game is very bad and hard coded...*


