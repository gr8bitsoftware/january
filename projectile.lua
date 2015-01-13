require 'constants'

Projectile = {}

Projectile.update = function(p, dt)
  p.x = p.x + p.velX * dt
  p.y = p.y + p.velY * dt + 0.5 * GRAVITY * dt * dt
  p.velY = p.velY + GRAVITY * dt
end

Projectile.draw = function(p)
  love.graphics.setColor({255, 255, 0})
  love.graphics.rectangle("fill", p.x, p.y, PROJECTILE_WIDTH, PROJECTILE_HEIGHT)
end

Projectile.create = function(player, velX, velY)
  return {
    x = player.x + PLAYER_WIDTH - PROJECTILE_WIDTH,
    y = player.y - PROJECTILE_HEIGHT,
    velX = velX,
    velY = velY,
  }
end

