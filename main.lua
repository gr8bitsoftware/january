require "constants"
require "player"
require "building"

local map, players

local function generateMap(width, height)
  local maxWidth = 0.10 * width
  local maxHeight = 0.75 * height
  local buildingHeight
  local buildingX = 0

  local map = {width = width, height = height}
  map.buildings = {}

  for i = 1, width / BUILDING_MIN_WIDTH do
    if buildingX > width then break end

    buildingHeight = math.random(BUILDING_MIN_HEIGHT, maxHeight)
    table.insert(map.buildings, Building.generate(
      buildingX,
      height - buildingHeight,
      math.random(BUILDING_MIN_WIDTH, maxWidth),
      buildingHeight,
      {0, math.random(0, 100), math.random(100, 255)}
    ))
    buildingX = map.buildings[i].x + map.buildings[i].width
  end

  return map
end

local function generatePlayers(map)
  return Player.generate(map, {{255, 0, 0}, {0, 255, 0}})
end

function love.load()
  math.randomseed(os.time())
  local width, height = love.graphics.getDimensions()
  map = generateMap(width, height)
  players = generatePlayers(map)
end

function love.update(dt)
end

function love.draw()
  for _, building in ipairs(map.buildings) do
    Building.draw(building)
  end
  for _, player in ipairs(players) do
    Player.draw(player)
  end
end

function love.keyreleased(key)
  if key == "r" then
    map = generateMap(love.window.getDimensions())
    players = generatePlayers(map)
  elseif key == "q" then
    love.event.push("quit")
  end
end

function love.quit()
end
