local Game = {}

function Game.setScreen(screen)
  Game.screen = require(screen)
  Game.screen.load(Game)
end

function love.load()
  Game.setScreen("start_screen")
end

function love.update(dt)
  Game.screen.update(dt)
end

function love.draw()
  Game.screen.draw()
end

function love.textinput(text)
  Game.screen.textinput(text)
end

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  end
  Game.screen.keypressed(key)
end

