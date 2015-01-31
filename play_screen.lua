require "constants"
require "player"
require "building"
require "projectile"

local Screen = {}

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

function Screen.load()
  math.randomseed(os.time())
  Screen.width, Screen.height = love.window.getDimensions()
  Screen.map = generateMap(Screen.width, Screen.height)
  Screen.players = generatePlayers(Screen.map)
  Screen.projectiles = {}
  Screen.FPS = 0
  Screen.font = love.graphics.newFont(12)
end

local function checkCollision(projectile, player)
  return (
    projectile.x < player.x + PLAYER_WIDTH and
    projectile.x + PROJECTILE_WIDTH > player.x and
    projectile.y < player.y + PLAYER_HEIGHT and
    projectile.y + PROJECTILE_HEIGHT > player.y
  )
end

local function updateProjectiles(dt)
  local bi, hit = 0, nil
  local toRemove = {}
  for i, projectile in ipairs(Screen.projectiles) do
    Projectile.update(projectile, dt)
    -- Check Player collisions
    for pi, player in ipairs(Screen.players) do
      if checkCollision(projectile, player) then
        table.insert(toRemove, i)
        player.health = player.health - math.random()
        if player.health <= 0 then
          table.remove(Screen.players, pi)
        end
        break
      end
    end
    if #toRemove > 0 then break end
    -- Check building collisions
    bi, hit = Building.search(Screen.map.buildings, projectile.x)
    if hit and hit.y <= projectile.y then
      hit = nil
      table.remove(Screen.map.buildings, bi)
      table.insert(toRemove, i)
    -- Check out of bounds
    elseif projectile.x + PROJECTILE_WIDTH < 0 or projectile.x > Screen.width then
      table.insert(toRemove, i)
    elseif projectile.y > Screen.height then
      table.insert(toRemove, i)
    end
  end
  table.sort(toRemove)
  for i = #toRemove, 1, -1 do
    table.remove(Screen.projectiles, toRemove[i])
  end
end

function Screen.update(dt)
  updateProjectiles(dt)
  Screen.FPS = 1 / dt
end

function Screen.draw()
  for _, building in ipairs(Screen.map.buildings) do
    Building.draw(building)
  end
  for _, player in ipairs(Screen.players) do
    Player.draw(player)
  end
  for _, projectile in ipairs(Screen.projectiles) do
    Projectile.draw(projectile)
  end

  love.graphics.setColor({255, 255, 255})
  love.graphics.setFont(Screen.font)
  love.graphics.print(Screen.FPS .. " fps", 0, 0)
end

function Screen.keypressed(key)
  if key == "r" then
    Screen.map = generateMap(love.window.getDimensions())
    Screen.players = generatePlayers(Screen.map)
  elseif key == "q" then
    love.event.quit()
  elseif key == "f" then
    table.insert(Screen.projectiles, Projectile.create(Screen.players[1], 50, -500))
  end
end

return Screen
