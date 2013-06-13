require "Circle"
require "Tile"
Gem = class()
function Gem:ctor(level, px, py, powerUp)
    self.level = level
    self.bounce = 0
    self.passTime = 0
    self.basePosition = ccp(px, py)
    self.isPowerUp = powerUp
    if self.isPowerUp then
        self.color = ccc3(255, 0, 0)
    else
        self.color = ccc3(255, 255, 0)
    end

    self.bg = CCSprite:create("Gem.png")
    self.bg:setPosition(self.basePosition)
    self.bg:setColor(self.color)
    SimpleAudioEngine:sharedEngine():preloadEffect("music/GemCollected.mp3")
    local size = self.bg:getContentSize()
    self.origin = ccp(size.width/2, size.height/2)

    local function onEnterOrExit(tag)
        if tag == "enter" then
            local function updateState(diff)
                self:update(diff)
            end
            self.updateEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateState, 0, false)
        elseif tag == "exit" then
            CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.updateEntry)
        end
    end
    self.bg:registerScriptHandler(onEnterOrExit)
end
function Gem:getBoundCircle()
    local px, py = self.bg:getPosition()
    return Circle.new(ccp(px, py), StaticTile.Width/3)
end
--pass Frame collected gem
function Gem:update(diff)
    local bounceHeight = 0.18
    local bounceRate = 3
    local bounceSync = -0.75
    local x = self.basePosition.x
    self.passTime = self.passTime + diff
    local t = self.passTime*bounceRate + x*bounceSync
    local size = self.bg:getContentSize()
    self.bounce = math.sin(t)*bounceHeight*size.height
    --print("bounce", self.bounce)
    self.bg:setPosition(ccp(x, self.basePosition.y+self.bounce))
    
    local boundCircle = self:getBoundCircle()
    if boundCircle:intersects(self.level.player:getBoundBox()) then
        if self.isPowerUp then
            self.level:onPowerUp(self)
            self.bg:removeFromParentAndCleanup(true)
            SimpleAudioEngine:sharedEngine():playEffect("music/GemCollected.mp3")
        else
            self.level:onGemCollected(self)
            self.bg:removeFromParentAndCleanup(true)
            SimpleAudioEngine:sharedEngine():playEffect("music/GemCollected.mp3")
        end
    end
end
