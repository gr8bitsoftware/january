Building = {}

Building.generate = function(x, y, w, h, color)
  return {x = x, y = y, width = w, height = h, color = color}
end

Building.draw = function(b)
  love.graphics.setColor(b.color)
  love.graphics.rectangle("fill", b.x, b.y, b.width, b.height)
end
