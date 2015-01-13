Building = {}

Building.generate = function(x, y, w, h, color)
  return {x = x, y = y, width = w, height = h, color = color}
end

Building.draw = function(b)
  love.graphics.setColor(b.color)
  love.graphics.rectangle("fill", b.x, b.y, b.width, b.height)
end

local function bsearch(t, v, lo, hi)
  local i = math.floor((hi - lo) / 2) + lo
  if t[i].x <= v and t[i].x + t[i].width > v then
    return i, t[i]
  elseif lo >= hi then
    return 0, nil
  elseif t[i].x < v then
    return bsearch(t, v, i + 1, hi)
  else
    return bsearch(t, v, lo, i - 1)
  end
end

Building.search = function(buildings, x)
  return bsearch(buildings, x, 1, #buildings)
end
