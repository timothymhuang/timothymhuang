
# Scoreboard

This program is used to keep the score of up to 9 different players for various things, including games like scrabble. This program was made on a TI-84 Plus CE. It is not an executable, so it still works without jailbreaking your calculator.

  

## Instalation and Startup

To install it, plug your calculator into your computer and put the SCORE.8xp file into your calculator files. To run it, press [prgm], then select SCORE. Press [enter] again to run it.

When you first start it you will see 2 players named "Player 1" and "Player 2", each with 0 points. Read the instructions below to learn how to use it.

  

## Operating Instructions

  

### Change player scores

1. Press the number that cooresponds to the player name. A * will apear next to that name once selected.

2. Enter the number of points you want to give that player. This will add to their current points.

3. The points will be updated.

4. If you want to remove points, enter a negative number with the negative [(-)] button. Do NOT use the minus [-] button.

### Enter Settings

1. Press any button other than the numbers that coorespond to the player names.

2. Select an item from the menu. See below.

#### Resume

This will bring you back to play.

#### Player Amount
1. Enter the number of players you want. Enter a number between 0-9. If you select 0 you won't see any players on the scoreboard.
2. If the amount of players you selected is less than the number of players currently active, an alert will pop up asking if you want to "clear removed players".
	a. Selecting NO will only hide the players. They will retain their names and scores.
	b. Selected YES will clear the hidden players' names and scores.
	
#### Player Names
1. Press the number that cooresponds to the player name you want to change.
2. Enter a new name. It can include letters.
3. Press any other key to go back to the settings.
4. 
#### Reset Scores
This will reset the score of all players including players that are currently not visible.

#### Exit
Exit the program.

## Other Notes
The scores and amount of players is stored in the list ⌊SCORE

The player names are stored in strings Str1, Str 2, ..., Str9.

Don't enter an imaginary number into the scoreboard. It will break it and prevent it from running. If you do try this, you will need to delete the ⌊SCORE to restore functionality.
