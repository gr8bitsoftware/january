local Screen = {}

function Screen.load(game)
  Screen.game = game
  Screen.width, Screen.height = love.window.getDimensions()
  Screen.font = love.graphics.newFont(36)
end

function Screen.update(dt)
end

function Screen.draw()
  love.graphics.setFont(Screen.font)
  love.graphics.print(
    "Blocks Shooting Blocks",
    Screen.width / 4,
    Screen.height / 3
  )
end

function Screen.keypressed(key)
  Screen.game.screen = require "play_screen"
  Screen.game.screen.load(Screen.game)
  Screen.game = nil
end

return Screen
