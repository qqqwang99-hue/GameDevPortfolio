# Olivia Wang Game Dev Portfolio 

## Term 1 Projects 

### OOP ChipmunkGame

![ChipmunkGame2027](https://github.com/qqqwang99-hue/gamedevportfolio2027/blob/main/images/chipmunkGame.png)

[Link To Source Code](https://github.com/qqqwang99-hue/gamedevportfolio2027/tree/main/src/ChipmunkGame)

## Game Overview
The main goal of the game is to destroy snakes before they move past the bottom of the screen or overlap with you while getting power ups to increase health, missile speed, and turret count.  

## How to Run
Built with Processing.
Processing version: 4.0.1
Main sketch and project folder: ChipmunkGame
Required libraries, if any: Sound (from Processing) and GifAnimator

Click the Link to Source Code to open the game.

## Controls
Left mouse click shoots projectiles.
WASD keys for up, left, down, right movement of the player.
Any key to start the game. 

## Required Foundation — 2 Points

### Three Power-Up Types
1. Health(h) — Adds 1 health to the player's health
2. Speed(s) — Increases the speed of the missiles fired by 10 frames
3. Turret(t) — Gives the player one more turret that also shoots missiles on left mouse click

### Levels
Levels are not currently in place but gaining powerups will allow the player to shoot faster and with more turrets. 

## My Chosen Additional Systems
Choose at least two:
- Game statistics
- Game-over screen with saved results

My choices:
1. Game statistics - Keep track of health, score, how many snakes currently on screen, and how many snakes have passed beyond the bottom of the screen 
2. Game over screen with saved results - Final score is shown on the game over screen, the high score over all games played, and an option to play again or the exit. 

## Testing
Test actions: Lose the game to make the game over screen appear

Expected result: Shows white text on top of the background saying GAME OVER and the high score and current score as well as the option to play again.

Actual result: Shows white text on top of the background saying GAME OVER and the high score and current score as well as the option to play again.

## Project Files and Assets
ChipmunkGame.pde, Chipmunk.pde, Boss.pde, PowerUp.pde, Projectile.pde, Snake.pde, Timer.pde, 
backgroundmusic.mp3, explosion.mp3, gameover.mp3, snakedie.mp3, highscore.txt

Asset credits:
player.png, missile.png, Start_screen.png, powerup.png, background.png

## Known Issues
The boss currently doesn't do anything and will not show up on the screen. 

## Next Development Task
Implementing levels and the boss
