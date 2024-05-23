-- Global variables
local jumpgameWindow = nil
local jumpButton = nil
local windowWidth = 300
local windowHeight = 300
local buttonWidth = 50
local buttonHeight = 30
local speed = 100 -- speed of button movement (pixels per second)
local movingLeft = true
local moveButtonEvent = nil

-- Function to initialize the module
function init()
  -- Load the UI
  g_ui.importStyle('jumpgame.otui')
  jumpgameWindow = g_ui.createWidget('JumpGameWindow', rootWidget)
  jumpButton = jumpgameWindow:recursiveGetChildById('buttonCancel')

  -- Ensure button is visible
  jumpButton:setVisible(true)

  -- Connect button click
  jumpButton.onClick = onButtonClick

  -- Start moving the button from the right
  startMovingButton()
end

-- Function to terminate the module
function terminate()
  -- Cleanup UI and stop any ongoing events
  if moveButtonEvent then
    removeEvent(moveButtonEvent)
    moveButtonEvent = nil
  end
  if jumpgameWindow then
    jumpgameWindow:destroy()
    jumpgameWindow = nil
    jumpButton = nil
  end
end

-- Function to start moving the button
function startMovingButton()
  if moveButtonEvent then
    removeEvent(moveButtonEvent)
  end

  -- Get the position of the module window relative to the game window
  local parentPos = jumpgameWindow:getPosition()

  -- Reset to the right and move left
  movingLeft = true

  -- Initial button position within the module window at random y position
  local startX = parentPos.x + windowWidth - buttonWidth - 20  -- Offset a bit to prevent clipping
  local startY = parentPos.y + math.random(0, windowHeight - buttonHeight)
  jumpButton:setPosition({x = startX, y = startY})

  -- Schedule the first move with a delay
  moveButtonEvent = scheduleEvent(moveButton, 100)
end

-- Function to move the button
function moveButton()
  if not jumpButton then return end

  -- Get the current and parent positions
  local parentPos = jumpgameWindow:getPosition()
  local currentPos = jumpButton:getPosition()

  -- Calculate local X position within the window
  local localXPos = currentPos.x - parentPos.x

  -- Update position moving left
  localXPos = localXPos - (speed * 0.1)
  if localXPos <= 0 then
    localXPos = windowWidth - buttonWidth - 20  -- Offset a bit to prevent clipping
    currentPos.y = parentPos.y + math.random(0, windowHeight - buttonHeight)
    movingLeft = true -- Ensures always moving left
  end

  -- Convert back to global position and set
  local newXPos = parentPos.x + localXPos
  jumpButton:setPosition({x = newXPos, y = currentPos.y})

  -- Print for debugging
  print(string.format("Button position - x: %d, y: %d", newXPos, currentPos.y))

  -- Schedule the next move
  moveButtonEvent = scheduleEvent(moveButton, 100)
end

-- Function called when the button is clicked
function onButtonClick()
  if not jumpButton then return end

  -- Get the current and parent positions
  local parentPos = jumpgameWindow:getPosition()
  local currentPos = jumpButton:getPosition()

  -- Ensure always reset to the right side and move left
  movingLeft = true

  -- Calculate new X position (initialize at the right side with offset)
  local newXPos = parentPos.x + windowWidth - buttonWidth - 20  -- Offset a bit to prevent clipping

  -- Calculate new random Y position within the module window
  local randomY = parentPos.y + math.random(0, windowHeight - buttonHeight - 30)

  -- Set new position
  jumpButton:setPosition({x = newXPos, y = randomY})

  -- Print for debugging
  print(string.format("Button clicked - new position - x: %d, y: %d", newXPos, randomY))

  -- Restart button movement
  startMovingButton()
end
