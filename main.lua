local player1, player2, projectile, width, height
local PLAYER_HEIGHT, PLAYER_WIDTH = 50, 50

local function makePlayer(px, py)
  return {
    x = px,
    y = py,
    width = PLAYER_WIDTH,
    height = PLAYER_HEIGHT,
    health = 100
  }
end

function love.load()
  math.randomseed(os.time())
  width, height = love.graphics.getDimensions()
  player1 = makePlayer(math.random(0, width - PLAYER_WIDTH), math.random(0, height - PLAYER_HEIGHT))
  player2 = makePlayer(math.random(0, width - PLAYER_WIDTH), math.random(0, height - PLAYER_HEIGHT))
end

function love.update(dt)
end

function love.draw()
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
  love.graphics.setColor(0, 0, 255, 255)
  love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
end

function love.keyreleased(key)
  if key == "r" then
    player1 = makePlayer(math.random(0, width - PLAYER_WIDTH), math.random(0, height - PLAYER_HEIGHT))
    player2 = makePlayer(math.random(0, width - PLAYER_WIDTH), math.random(0, height - PLAYER_HEIGHT))
  end
end

function love.quit()
end
