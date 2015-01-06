require "constants"

Player = {}

Player.generate = function(map, color)
  return {x = math.random(0, map.width), y = math.random(0, map.height), color = color}
end

Player.draw = function(p)
  love.graphics.setColor(p.color)
  love.graphics.rectangle("fill", p.x, p.y, PLAYER_WIDTH, PLAYER_HEIGHT)
end
