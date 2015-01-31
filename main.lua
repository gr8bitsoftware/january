local Game = {}

function love.load()
  Game.screen = require "start_screen"
  Game.screen.load(Game)
end

function love.update(dt)
  Game.screen.update(dt)
end

function love.draw()
  Game.screen.draw()
end

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  end
  Game.screen.keypressed(key)
end

