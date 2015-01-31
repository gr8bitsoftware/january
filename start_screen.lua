local Screen = {}
local TITLE = [[ Blocks Shooting Blocks ]]
local INSTRUCTIONS = [[
Press any key to Start
'Q' to Quit
]]

function Screen.load(game)
  Screen.game = game
  Screen.width, Screen.height = love.window.getDimensions()
  Screen.titleFont = love.graphics.newFont(36)
  Screen.instructionsFont = love.graphics.newFont(18)
  love.keyboard.setTextInput(false)
end

function Screen.update(dt)
end

function Screen.draw()
  love.graphics.setFont(Screen.titleFont)
  love.graphics.print(TITLE, Screen.width / 4, Screen.height / 3)

  love.graphics.setFont(Screen.instructionsFont)
  love.graphics.print(INSTRUCTIONS, Screen.width / 3, Screen.height * 2 / 3)
end

function Screen.keypressed(key)
  Screen.game.setScreen("input_screen")
  Screen.game = nil
end

return Screen
