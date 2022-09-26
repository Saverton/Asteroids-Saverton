# PROJECT TITLE : Asteroids (My Version)

# PROJECT DESCRIPTION : 
  This application runs my recreation of the Arcade Classic 'Asteroids' (https://en.wikipedia.org/wiki/Asteroids_(video_game)). This was another self-assessment of my abilities in the LOVE2D framework that I made for my father's birthday. On starting the game, the player controls a spaceship using tank-controls (rotate left or right + move forward or backward) to dodge a swarm of asteroids flying across the screen. The screen wraps around itself, meaning any object that disappears off one end of the screen reappears on the other end. The player can also shoot the asteroids (and must do so to progress), causing them to split into two smaller pieces. After three splits, the asteroids dissolve into space dust, and are considered destroyed and no longer dangerous. When the player has destroyed all of the asteroids, a new level begins with slightly more asteroids. Every so often, an alien spaceship will appear, flying in a straight line across the screen and firing lasers at the player until it is defeated. If the player is hit at any time by an asteroid or alien laser, the player is destroyed and loses a life. If the player has at least one life remaining, he will respawn with around a second of invulnerability to any hits, decrementing his life count. When the player is out of lives, it is game over, and the player's score is displayed.

# HOW TO RUN : 
  Download the Love2d engine (https://love2d.org/) and find the folder that contains the application 'love.exe'. Using a command line interface or by dragging the project file onto the 'love.exe' application, run the project folder in 'love.exe'. Once the game is started, refer to the description of the game rules in the 'PROJECT DESCRIPTION' section.
  # CONTROLS
    - 'ws'/'up and down arrow keys' = move forward and backward
    - 'ad'/'left and right arrow keys' = rotate counterclockwise and clockwise (respectively)
    - 'space' = fire projectile
    - 'escape' = exit application
    
# CREDITS 
  - Implements built-in libraries from Love2d engine (https://love2d.org/)
  - OOP class library (https://github.com/vrld/hump)
  - 'push' library that resizes content to fit a window of a different scale than the scale used in game (https://github.com/Ulydev/push)
  - the knife timer management library (https://github.com/airstruck/knife)
  - a few classes written by Colton Ogden in his GD50 projects (https://cs50.harvard.edu/games/2018/)
  - music written by Tyler Tebo
  
# LICENSE
MIT License

Copyright (c) 2022 Scott Meadows

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
