local simpleJson = require "SimpleJson"
RectangleExtensions = {}
--CCSize
function RectangleExtensions.getIntersectionDepth(rectA, rectB)
    local halfWidthA = rectA.size.width/2
    local halfHeightA = rectA.size.height/2
    local halfWidthB = rectB.size.width/2
    local halfHeightB = rectB.size.height/2
    --print("halfWidthA halfHeight", halfWidthA, halfHeightA, halfWidthB, halfHeightB)

    local centerA = {rectA:getMinX()+halfWidthA, rectA:getMinY()+halfHeightA}
    local centerB = {rectB:getMinX()+halfWidthB, rectB:getMinY()+halfHeightB}
    --print("centerA centerB", simpleJson:encode(centerA), simpleJson:encode(centerB))
    local distanceX = centerA[1]-centerB[1]
    local distanceY = centerA[2]-centerB[2]
    local minDistanceX = halfWidthA+halfWidthB
    local minDistanceY = halfHeightA+halfHeightB
    --print("distanceX distanceY", distanceX, distanceY, minDistanceX, minDistanceY)

    if math.abs(distanceX) >= minDistanceX or math.abs(distanceY) >= minDistanceY then
        return ccp(0, 0)
    end

    local depthX
    if distanceX > 0 then
        depthX = minDistanceX-distanceX
    else
        depthX = -minDistanceX-distanceX
    end
    local depthY
    if distanceY > 0 then
        depthY = minDistanceY-distanceY
    else
        depthY = -minDistanceY-distanceY
    end
    return ccp(depthX, depthY) 
end
