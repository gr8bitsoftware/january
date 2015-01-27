require "constants"

Player = {}

local function alignPlayer(building)
  local buildingCenter = building.x + (building.width / 2)
  return buildingCenter - (PLAYER_WIDTH / 2)
end

local function inTable(t, v)
  for _, tv in ipairs(t) do
    if v == tv then return true end
  end
  return false
end

local function pickRandomBuilding(buildings, ignoredValues)
  local randomIndex = math.random(2, #buildings - 1)
  while inTable(ignoredValues, randomIndex) do
    randomIndex = math.random(2, #buildings - 1)
  end
  return randomIndex, buildings[randomIndex]
end

Player.generate = function(map, colors)
  local buildingsUsed = {}
  local buildingIdx, building = nil, nil
  local players = {}

  for _, color in ipairs(colors) do
    buildingIdx, building = pickRandomBuilding(map.buildings, buildingsUsed)
    table.insert(buildingsUsed, buildingIdx)
    table.insert(players, {
      x = alignPlayer(building),
      y = building.y - PLAYER_HEIGHT,
      color = color,
      width = PLAYER_WIDTH,
      height = PLAYER_HEIGHT,
      health = 1.0,
    })
  end

  return players
end

Player.draw = function(p)
  love.graphics.setColor(p.color)
  love.graphics.rectangle("fill", p.x, p.y, PLAYER_WIDTH, PLAYER_HEIGHT)
  
  love.graphics.setColor({255, 255, 255})
  love.graphics.rectangle("line", p.x, p.y - PLAYER_HEIGHT - HEALTH_BAR_HEIGHT, PLAYER_WIDTH, HEALTH_BAR_HEIGHT)
  love.graphics.rectangle("fill", p.x, p.y - PLAYER_HEIGHT - HEALTH_BAR_HEIGHT, PLAYER_WIDTH * p.health, HEALTH_BAR_HEIGHT)
end
