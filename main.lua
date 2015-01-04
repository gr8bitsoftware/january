local map, players

local function generateMap(width, height)
  local maxWidth = 0.10 * width
  local maxHeight = 0.75 * height
  map = {width = width, height = height}
  map.buildings = {}
  table.insert(map.buildings, {
    width = math.random(0, maxWidth),
    height = math.random(0, maxHeight),
    x = math.random(0, width),
    y = math.random(0, height)
  })

  return map
end

local function generatePlayers(map)
  return {
    {x = math.random(0, map.width), y = math.random(0, map.height)},
    {x = math.random(0, map.width), y = math.random(0, map.height)},
  }
end

function love.load()
  math.randomseed(os.time())
  local width, height = love.graphics.getDimensions()
  map = generateMap(width, height)
  players = generatePlayers(map)
end

function love.update(dt)
end

local function drawPlayer(player)
  love.graphics.rectangle("fill", player.x, player.y, 50, 50)
end

local function drawBuilding(building)
  love.graphics.rectangle("fill", building.x, building.y, building.width, building.height)
end

function love.draw()
  for _, building in ipairs(map.buildings) do
    drawBuilding(building)
  end
  for _, player in ipairs(players) do
    drawPlayer(player)
  end
end

function love.keyreleased(key)
  if key == "r" then
    map = generateMap(love.window.getDimensions())
    players = generatePlayers(map)
  end
end

function love.quit()
end
