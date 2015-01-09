require "constants"

Player = {}

local function alignPlayer(building)
  local buildingCenter = (2 * building.x + building.width) / 2
  return buildingCenter - (PLAYER_WIDTH / 2)
end

Player.generate = function(map, color)
  local playerX = math.random(0, map.width)
  for _, building in ipairs(map.buildings) do
    if playerX > building.x and playerX < building.x + building.width then
      return {x = alignPlayer(building), y = building.y - PLAYER_HEIGHT, color = color}
    end
  end
end

Player.draw = function(p)
  love.graphics.setColor(p.color)
  love.graphics.rectangle("fill", p.x, p.y, PLAYER_WIDTH, PLAYER_HEIGHT)
end
