require "constants"
require "player"
require "building"
require "projectile"

local map, players, projectiles, FPS, WIDTH, HEIGHT

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
  io.stdout:setvbuf("no") -- Prints out to console, remove for release
  local width, height = love.graphics.getDimensions()
  map = generateMap(width, height)
  players = generatePlayers(map)
  projectiles = {}
  FPS = 0
  WIDTH, HEIGHT = love.window.getDimensions()
end

function love.update(dt)
  local bi, hit = 0, nil
  local toRemove = {}
  for i, projectile in ipairs(projectiles) do
    Projectile.update(projectile, dt)
    bi, hit = Building.search(map.buildings, projectile.x)
    if hit and hit.y <= projectile.y then
      hit = nil
      table.remove(map.buildings, bi)
      table.insert(toRemove, i)
    elseif projectile.x + PROJECTILE_WIDTH < 0 or projectile.x > WIDTH then
      table.insert(toRemove, i)
    elseif projectile.y > HEIGHT then
      table.insert(toRemove, i)
    end
  end
  table.sort(toRemove)
  for i = #toRemove, 1, -1 do
    table.remove(projectiles, toRemove[i])
  end
  FPS = 1 / dt
end

function love.draw()
  for _, building in ipairs(map.buildings) do
    Building.draw(building)
  end
  for _, player in ipairs(players) do
    Player.draw(player)
  end
  for _, projectile in ipairs(projectiles) do
    Projectile.draw(projectile)
  end

  love.graphics.setColor({255, 255, 255})
  love.graphics.print(FPS .. " fps", 0, 0)
end

function love.keyreleased(key)
  if key == "r" then
    map = generateMap(love.window.getDimensions())
    players = generatePlayers(map)
  elseif key == "q" then
    love.event.push("quit")
  elseif key == "f" then
    table.insert(projectiles, Projectile.create(players[1], 50, -500))
  end
end

function love.quit()
end
