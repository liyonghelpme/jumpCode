Circle = class()
--CCPoint
function Circle:ctor(pos, radius)
    self.center = pos
    self.radius = radius
end
--CCRect
function Circle:intersects(rectangle)
    local vx = math.min(math.max(self.center.x, rectangle:getMinX()), rectangle:getMaxX())
    local vy = math.min(math.max(self.center.y, rectangle:getMinY()), rectangle:getMaxY())
    local dx = self.center.x-vx
    local dy = self.center.y-vy
    local distance = dx*dx+dy*dy
    return distance > 0 and distance < self.radius*self.radius
end
