require "Level"
GameScene = class()
local LevelZ = 1
local MenuZ = 2
function GameScene:ctor()
    self.bg = CCScene:create()
    self.levelIndex = 0
    self.numberOfLevels = 3   
    self.status = nil

    local function onEnterOrExit(tag)
        if tag.name == "enter" then
            local function updateState(diff)
                self:update(diff)
            end
            self.updateEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateState)
        elseif tag.name == "exit" then
            CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.updateEntry)
        end
    end
    self.bg:registerScriptHandler(onEnterOrExit)
    self.layer = CCLayer:create()
    self.bg:addChild(self.layer)

    local function onTouch(eventType, x, y)
        if eventType == CCTOUCHBEGAN then
            self:onTouchBegan(x, y)
            return true
        elseif eventType == CCTOUCHENDED then
            self:onTouchEnded(x, y)
        elseif eventType == CCTOUCHMOVED then
            self:onTouchMoved(x, y)
        end
    end
    self.layer:setTouchEnabled(true)
    self.layer:registerScriptTouchHandler(onTouch)

    self:loadLevel()
    self.menu = CCNode:create()
    self.bg:addChild(self.menu, MenuZ)

    self.score = CCLabelTTF:create("0", "", 24)
    self.score:setColor(ccc3(255, 255, 0))
    self.shadowScore = CCLabelTTF:create("0", "", 24)
    self.shadowScore:setColor(ccc3(0, 0, 0))
    self.menu:addChild(self.shadowScore)
    self.menu:addChild(self.score)

    local director = CCDirector:sharedDirector()
    local vSize = director:getVisibleSize()
    self.score:setPosition(ccp(10, vSize.height-10))
    self.score:setAnchorPoint(ccp(0, 1))
    self.shadowScore:setPosition(ccp(11, vSize.height-11))
    self.shadowScore:setAnchorPoint(ccp(0, 1))
end
function GameScene:updateScore(score)
    self.score:setString(""..score)
    self.shadowScore:setString(""..score)
end

function GameScene:loadLevel() 
    self.level = Level.new(self)
    self.bg:addChild(self.level.bg, LevelZ)
end
function GameScene:update(diff)
    if self.status == nil then
        local status = nil
        if self.level.player.isAlive == false then
            status = CCSprite:create("you_died.png")
        end
        if status ~= nil then
            local viewSize = CCDirector:sharedDirector():getVisibleSize()
            status:setPosition(ccp(viewSize.width/2, viewSize.height/2))
            self.status = status
            self.menu:addChild(self.status)
        end
    end
end
--对照loadLevel 删除level 信息
function GameScene:onTouchBegan(x, y)
    if not self.level.player.isAlive then
        self.level:startNewLife()
        self.status:removeFromParentAndCleanup(true)
        self.status = nil
        self.level.bg:removeFromParentAndCleanup(true)
        self:loadLevel()
    end
end
function GameScene:onTouchMoved(x, y)
end
function GameScene:onTouchEnded(x, y)

end
