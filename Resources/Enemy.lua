Enemy = class()
function Enemy:initAnimation()
    if self.idleAnimation == nil then
        local animation 
        local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
        cache:addSpriteFramesWithFile("monster/Idle.plist")
        local frames = CCArray:create()
        for i = 0, 10, 1 do
            local frame = cache:spriteFrameByName("m0Idle"..i..".png")
            frames:addObject(frame)
        end
        animation = CCAnimation:createWithSpriteFrames(frames, 0.1)
        self.idleAnimation = CCRepeatForever:create(CCAnimate:create(animation))

        cache:addSpriteFramesWithFile("monster/Run.plist")
        local frames = CCArray:create()
        for i = 0, 9, 1 do
            local frame = cache:spriteFrameByName("m0Run"..i..".png")
            frames:addObject(frame)
        end
        animation = CCAnimation:createWithSpriteFrames(frames, 0.1)
        self.runAnimation = CCRepeatForever:create(CCAnimate:create(animation))
        
        self.idleAnimation:retain()
        self.runAnimation:retain()
    end
end
function Enemy:clearAnimation()
    self.idleAnimation:release()
    self.runAnimation:release()
    self.idleAnimation = nil
    self.runAnimation = nil
end
function Enemy:runAction(act)
    if self.curAction ~= act then
        if self.curAction ~= nil then
            self.bg:stopAction(self.curAction)
        end
        self.curAction = act
        self.bg:runAction(act)
    end
end
function Enemy:loadContent()
    self:runAction(self.idleAnimation)    
end
function Enemy:ctor(level, px, py)
    self.level = level
    self.width = 29
    self.height = 60
    self.moveSpeed = 64
    self.direction = -1
    self.waitTime = 0
    self.maxWaitTime = 0.5
    self.curAction = nil

    self.bg = CCSprite:create()
    self.bg:setPosition(ccp(px, py))
    self.bg:setAnchorPoint(ccp(0.5, 0))
    self:loadContent()
    
    local function onEnterOrExit(tag)
        if tag == "enter" then
            self:initAnimation()
            local function updateState(diff)
                self:update(1/60)
            end
            self.updateEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateState, 0, false)
        elseif tag == 'exit' then
            CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.updateEntry)
            self:clearAnimation()
        end
    end
    
    self.bg:registerScriptHandler(onEnterOrExit)
end
function Enemy:getBoundBox()
    local px, py = self.bg:getPosition()
    local left = px-self.width/2
    local bottom = py
    return CCRectMake(left, bottom, self.width, self.height)
end

--general moving enemy
function Enemy:update(diff)
    local elapsed = diff
    local x, y = self.bg:getPosition()
    local posX = x+self.width/2*self.direction
    local tileX = math.floor(posX/StaticTile.Width)-self.direction
    local tileY = math.floor(y/StaticTile.Height)
    if self.waitTime > 0 then
        self.waitTime = math.max(0, self.waitTime-elapsed)
        if self.waitTime <= 0 then
            self.direction = -self.direction
        end
    else
        local collision0 = self.level:getCollision(tileX+self.direction, tileY-1)
        local collision1 = self.level:getCollision(tileX+self.direction, tileY)
        if collision1 == 'Impassable' or collision1 == 'Block' or collision0 == 'Passable' then
            self.waitTime = self.maxWaitTime
        else
            if self.level.player.isAlive then
                local vx = self.direction*self.moveSpeed*elapsed
                local vy = 0
                self.bg:setPosition(ccp(x+vx, y))
            end
        end

    end
    if not self.level.player.isAlive or self.waitTime > 0 then
        self:runAction(self.idleAnimation)
    else
        self:runAction(self.runAnimation)
    end
    if self.direction > 0 then
        self.bg:setFlipX(true)
    else
        self.bg:setFlipX(false)
    end

    local bounds = self:getBoundBox()
    local playerBounds = self.level.player:getBoundBox()
    if bounds:intersectsRect(playerBounds) then
        self.level:onPlayerKilled(self)
    end

    --超出摄像机一定距离
    --应该再所有操作之后 再删除对象
    if x < self.level.cameraPosition-800 then
        self:clearSelf()
    end
end
--out of cameraPosition
function Enemy:clearSelf()
    self.bg:removeFromParentAndCleanup(true)
    local enemies = self.level.enemies
    for i = 1, #enemies, 1 do
        if enemies[i] == self then
            table.remove(enemies, i)
            break
        end
    end
end



