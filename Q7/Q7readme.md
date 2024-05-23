# OTClient Jump Game

This script implements a simple 'jump game' in OTClient where a button moves left across a window. The goal is to click the button before it resets back to the right side of the window and moves again.

## Overview

- A UI window is created with a button that moves from right to left.
- The button changes its position vertically at random upon each reset or click. 
- The button's movement is continuous and resets once it reaches the left edge of the window.

## Global Variables

- `jumpgameWindow`: The main window of the jump game.
- `jumpButton`: The button object within the window.
- `windowWidth`, `windowHeight`: Dimensions of the main window.
- `buttonWidth`, `buttonHeight`: Dimensions of the button.
- `speed`: Speed of the button movement in pixels per second.
- `movingLeft`: Boolean indicating the direction of movement (always true for left).
- `moveButtonEvent`: The scheduled event for moving the button.
