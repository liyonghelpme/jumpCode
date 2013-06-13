require "Tile"
require "RectangleExtensions"
Player = class()
--hold idleAnimation runAnimation

function Player:initAnimation()
    if self.idleAnimation == nil then
        local animation = CCAnimation:create()
        animation:addSpriteFrameWithFileName("Idle.png")
        animation:setDelayPerUnit(1)
        self.idleAnimation = CCAnimate:create(animation)
        
        local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
        cache:addSpriteFramesWithFile("Run.plist")
        local frames = CCArray:create()
        for i = 0, 9, 1 do
            local frame = cache:spriteFrameByName("run"..i..".png")
            frames:addObject(frame)
        end
        animation = CCAnimation:createWithSpriteFrames(frames, 0.1)
        self.runAnimation = CCRepeatForever:create(CCAnimate:create(animation))
        --self.runAnimation = CCAnimate:create(animation)


        cache:addSpriteFramesWithFile("Jump.plist")
        local frames = CCArray:create()
        for i =0, 10, 1 do
            local frame = cache:spriteFrameByName("jump"..i..".png")
            frames:addObject(frame)
        end
        animation = CCAnimation:createWithSpriteFrames(frames, 0.1)
        self.jumpAnimation = CCAnimate:create(animation)

        cache:addSpriteFramesWithFile("Die.plist")
        local frames = CCArray:create()
        for i = 0, 11, 1 do
            local frame = cache:spriteFrameByName("die"..i..".png")
            frames:addObject(frame)
        end
        animation = CCAnimation:createWithSpriteFrames(frames, 0.1)
        self.dieAnimation = CCAnimate:create(animation)

        self.idleAnimation:retain()
        self.runAnimation:retain()
        self.jumpAnimation:retain()
        self.dieAnimation:retain()
    end
end
function Player:clearAnimation()
    if self.powerUpSound ~= nil then
        SimpleAudioEngine:sharedEngine():stopEffect(self.powerUpSound)
    end
    self.idleAnimation:release()
    self.runAnimation:release()
    self.jumpAnimation:release()
    self.dieAnimation:release()
    self.idleAnimation = nil
    self.runAnimation = nil
    self.jumpAnimation = nil
    self.dieAnimation = nil
end
function Player:ctor(level, x, y)
    self.width = 29
    self.height = 60
    self.level = level
    self.bg = CCSprite:create()
    self.layer = CCLayer:create()
    self.bg:addChild(self.layer)--接受屏幕touch事件
    self.stateNode = nil
    --self.debug = true
    self.curAction = nil
    self.inTouch = false
    self.inMove = 0
    self.isAlive = true
    self.maxPowerUpTime = 6
    self.powerUpTime = 0
    self.powerUpColors = {ccc3(255, 0, 0), ccc3(0, 0, 255), ccc3(255, 127, 80), ccc3(255, 255, 0)}
    self.powerUpSound = nil

    SimpleAudioEngine:sharedEngine():preloadEffect("music/PlayerKilled.mp3")
    SimpleAudioEngine:sharedEngine():preloadEffect("music/PlayerFall.mp3")
    SimpleAudioEngine:sharedEngine():preloadEffect("music/PlayerJump.mp3")
    SimpleAudioEngine:sharedEngine():preloadEffect("music/Powerup.mp3")
    
    local function onEnterOrExit(tag)
        --print("onEnterOrExit", tag.name)
        if tag == "enter" then
            self:initAnimation()
            local function updateState(diff)
                --print("update")
                --保持30frame
                --[[
                if diff > 1/30 then
                    return
                end
                --]]
                --diff = math.min(diff, 1/30)
                --print("updateState", diff)
                self:update(1/60)
            end
            --print("schedule update")
            self.updateEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateState, 0, false)
        elseif tag == "exit" then
            self:clearAnimation()
            CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.updateEntry)
        end
    end
    self.bg:registerScriptHandler(onEnterOrExit)
    local function onTouch(eventType, x, y)
        if eventType == "began" then
            self:onTouchBegan(x, y)
            return true
        elseif eventType == "ended" then
            self:onTouchEnded(x, y)
        elseif eventType == "moved" then
            self:onTouchMoved(x, y)
        end
    end
    self.layer:setTouchEnabled(true)
    self.layer:registerScriptTouchHandler(onTouch, false, 0, false)

    self.bg:setAnchorPoint(ccp(0.5, 0))

    self.velocity = ccp(0, 0)
    
    --水平移动
    self.moveAcceleration = 13000
    self.maxMoveSpeed = 1750
    self.groundDragFactor = 0.48
    self.airDragFactor = 0.58

    --垂直移动
    self.maxJumpTime = 0.35
    self.jumpLaunchVelocity = 3500
    self.gravityAcceleration = -3400--重力向下计算碰撞冲突
    self.maxFallSpeed = 550
    self.jumpControlPower = 0.14
    
    self.isOnGround = true
    self.movement = 0
    self.isJumping = false
    self.wasJumping = false
    self.jumpTime = 0
    self.previousBottom = 0
    self.previousRight = 0

    self.localBounds = CCRectMake(0, 0, 0, 0)
    self:initAnimation()
    self:reset(x, y)


end
function Player:getBoundBox()
    local px, py = self.bg:getPosition()
    local left = px-self.width/2
    local bottom = py
    return CCRectMake(left, bottom, self.width, self.height)
end
function Player:runAction(act)
    if self.curAction ~= act then
        if self.curAction ~= nil then
            self.bg:stopAction(self.curAction)
        end
        self.curAction = act
        self.bg:runAction(act)
    end
end
function Player:reset(x, y)
    --self.previousBottom = y*32
    self.isAlive = true
    self.bg:setPosition(ccp(x*40, y*32)) 
    self:runAction(self.idleAnimation)
    --self.bg:setTexture("Idle.png")
    local bounds = self:getBoundBox()
    self.previousBottom = bounds:getMinY()
    self.previousRight = bounds:getMaxX()
end

function boolToNum(b)
    if b then
        return 1
    else
        return 0
    end
end
--poll key pad state
function Player:update(diff)
    --print("update Player", diff)
    if self.isAlive then
        self.movement = 1
    end
    if self.isAlive and self.inTouch then
        --self.movement = self.inMove
        self.isJumping = true
    end
    self:applyPhysics(diff) 
    if self.powerUpTime > 0 then
        self.powerUpTime = math.max(0, self.powerUpTime-diff)
        local t = math.floor(self.powerUpTime/self.maxPowerUpTime * 20) 
        local ci = t%#self.powerUpColors
        local c = self.powerUpColors[ci+1]
        self.bg:setColor(c)
    else
        self.bg:setColor(ccc3(255, 255, 255))
        if self.powerUpSound ~= nil then
            --SimpleAudioEngine:sharedEngine():stopEffect(self.powerUpSound)
            self.powerUpSound = nil
        end
    end
    if self.velocity.x > 0 then
        self.bg:setFlipX(true)
    elseif self.velocity.x < 0 then
        self.bg:setFlipX(false)
    end
    if self.isAlive and self.isOnGround then
        if math.abs(self.velocity.x) - 0.02 > 0 then
            self:runAction(self.runAnimation)
        else
            self:runAction(self.idleAnimation)
        end
    end
    if self.debug then
        if self.stateNode ~= nil then
            self.stateNode:removeFromParentAndCleanup(true)
        end
        self.stateNode = CCNode:create()
        self.level.scene.menu:addChild(self.stateNode)
        self.stateNode:setPosition(ccp(100, 100))
        local px, py = self.bg:getPosition()
        local temp = CCLabelTTF:create(string.format("%.2f %.2f %d %d %d %.2f %.2f %.2f ", self.velocity.x, self.velocity.y, boolToNum(self.isOnGround), boolToNum(self.isJumping), boolToNum(self.wasJumping), self.jumpTime, px, py), "", 30)
        temp:setAnchorPoint(ccp(0, 0.5))
        self.stateNode:addChild(temp)
        local temp = CCLabelTTF:create(string.format("chunks %d", #self.level.chunks), "", 30)
        temp:setPosition(ccp(0, 50))
        self.stateNode:addChild(temp)

        local temp = CCLabelTTF:create(string.format("gems %d", #self.level.gems), "", 30)
        temp:setPosition(ccp(0, 100))
        self.stateNode:addChild(temp)
    end
    self.movement = 0
    self.isJumping = false
end
function round(v)
    local t
    if v >= 0 then
        t = math.ceil(v)
        if (t-v) > 0.5 then
            t = t - 1.0
        end
    else
        t = math.ceil(-v)
        if (t+v) > 0.5 then
            t = t - 1.0
        end
        t = -t
    end
    return t
end
--计算物理效果
function Player:applyPhysics(diff)
    local elapsed = diff
    local x, y = self.bg:getPosition()
    local vx, vy
    --掉到坑里面

    vx = self.velocity.x + self.movement*self.moveAcceleration*elapsed
    vy = math.min(math.max(self.velocity.y+self.gravityAcceleration*elapsed, -self.maxFallSpeed), self.maxFallSpeed)
    --print("applyPhysics", self.velocity.y, vy, diff)
    self.velocity.y = self:doJump(vy, diff)
    if self.isOnGround then
        vx = vx * self.groundDragFactor
    else
        vx = vx * self.airDragFactor
    end
    self.velocity.x = math.min(math.max(vx, -self.maxMoveSpeed), self.maxMoveSpeed) 
    
    local newX, newY = x+self.velocity.x*diff, y+self.velocity.y*elapsed
    newX = round(newX)
    newY = round(newY)
    self.bg:setPosition(newX, newY)
    self:handleCollisions()
    local nx, ny = self.bg:getPosition()
    if nx == x then
        self.velocity.x = 0
    end
    if ny == y then
        self.velocity.y = 0
    end

    if ny < 0 then
        if self.isAlive then
            self.level:onPlayerKilled(nil)
        end
    end
end
--detect all collision between player and neibor tiles
--when collision player pushed away alone one axis prevent overlapping
--Y axis handle platforms behave differently depend on direction
function Player:handleCollisions()
    --CCSizeMake
    local bounds = self:getBoundBox()
    --print("bounds is", bounds:getMinX(), bounds:getMinY(), bounds:getMaxX(), bounds:getMaxY())
    local leftTile = math.floor(bounds:getMinX()/StaticTile.Width)
    local rightTile = math.ceil(bounds:getMaxX()/StaticTile.Width)-1
    local topTile = math.ceil(bounds:getMaxY()/StaticTile.Height)-1
    local bottomTile = math.floor(bounds:getMinY()/StaticTile.Height)
    --print("bottomTile topTile", bounds:getMinY(), bounds:getMaxY(), bottomTile, topTile)
    --print("leftTile rightTile", bounds:getMinX(), bounds:getMaxX(), leftTile, rightTile)

    self.isOnGround = false
    for y = bottomTile, topTile, 1 do
        for x = leftTile, rightTile, 1 do
            local collision = self.level:getCollision(x, y)
            --print("handleCollisions", x, y, collision)
            if collision ~= 'Passable' then
                local tileBounds = self.level:getBounds(x, y)
                --print("tileBounds", tileBounds, tileBounds.size)
                --print("tileBounds", tileBounds:getMinX(), tileBounds.size.width)
                local depth = RectangleExtensions.getIntersectionDepth(bounds, tileBounds) 
                --print("depth ", depth.x, depth.y)
                if depth.x ~= 0 or depth.y ~= 0 then
                    local absDepthX = math.abs(depth.x)
                    local absDepthY = math.abs(depth.y)
                    --print("absDepthX", absDepthX, absDepthY)
                    --print("previousBottom", self.previousBottom, tileBounds:getMaxY())
                    --相交的Y 大于 X 方向 或者是站立的地面
                    --absDepthY 

                    --impassable Y 方向的移动
                    --站在一个平台上面 or collision == 'Platform'
                    --跳到平台上面 水平撞击平台 直接传过去么
                    --垂直撞击 平台
                    if absDepthY < absDepthX and collision == 'Platform' then
                        local isOnPlatform = false
                        if self.previousBottom >= tileBounds:getMaxY() then
                            isOnPlatform = true
                            self.isOnGround = true
                        end
                        if isOnPlatform then
                            local oldX, oldY = self.bg:getPosition()
                            self.bg:setPosition(oldX, oldY+depth.y)
                            bounds = self:getBoundBox()
                        end
                    elseif absDepthY < absDepthX and collision == 'Block' then
                        local isOnBlock = false
                        if self.previousBottom >= tileBounds:getMaxY() then
                            isOnBlock = true
                            self.isOnGround = true
                        end
                        if not isOnBlock then
                            if self.isAlive then
                                self.level:onPlayerKilled(self.level:getTile(x, y))
                            end
                        end

                        local oldX, oldY = self.bg:getPosition()
                        self.bg:setPosition(oldX, oldY+depth.y)
                        bounds = self:getBoundBox()

                    elseif absDepthY < absDepthX and collision == 'Impassable' then
                        local isOnImpassable = false
                        if self.previousBottom >= tileBounds:getMaxY() then
                            self.isOnGround = true
                            isOnImpassable = true
                        end
                        --不可穿过的建筑物 则向上移动一定像素
                        --block 类似platformer 水平碰撞上立即死亡 
                        --dead 站在当前平台上面
                        --if collision == 'Block' and not isOnBlock then
                        --    self.level:onPlayerKilled(self.level:getTile(x, y))
                        --else
                        --Block 混合了敌人 和 平台的特性 从下往上撞到也会死掉
                        if isOnImpassable then
                            local oldX, oldY = self.bg:getPosition()
                            self.bg:setPosition(oldX, oldY+depth.y)
                            bounds = self:getBoundBox()
                        end
                    --不能穿过的建筑物
                    elseif collision == "Impassable" then
                        local oldX, oldY = self.bg:getPosition()
                        self.bg:setPosition(oldX+depth.x, oldY)
                        bounds = self:getBoundBox()
                    -- 从左边撞到 会撞死水平撞到一个平台上面
                    elseif collision == 'Block' then
                        local oldX, oldY = self.bg:getPosition()
                        self.bg:setPosition(oldX+depth.x, oldY)
                        bounds = self:getBoundBox()
                        --从左边撞击
                        if self.previousRight < tileBounds:getMinX() then
                            if self.isAlive then
                                self.level:onPlayerKilled(self.level:getTile(x, y))
                            end
                        end
                    --水平不用修正撞击
                    elseif collision == 'Platform' then
                         
                    elseif collision == 'Break' then
                        local tile = self.level:getTile(x, y)
                        if tile.bg ~= nil then
                            tile.bg:removeFromParentAndCleanup(true)
                            tile.bg = nil
                        end
                    end


                end
            end
        end
    end
    self.previousBottom = bounds:getMinY()
    self.previousRight = bounds:getMaxX()
end

--计算y方向速度 根据 跳跃 和动画
--动画手动控制 自己的animation
function Player:doJump(vel, diff)
    --wasJumping 防止多次跳跃
    if self.isJumping then
        --begin or continue
        if (not self.wasJumping and self.isOnGround) or self.jumpTime > 0 then
            if self.jumpTime == 0 then
                SimpleAudioEngine:sharedEngine():playEffect("music/PlayerJump.mp3", false)
            end
            self.jumpTime = self.jumpTime+ diff
            self:runAction(self.jumpAnimation)
        end
        --上升阶段使用 power 函数
        --上升阶段使用 power 函数
        if 0 < self.jumpTime and self.jumpTime <= self.maxJumpTime then
            vel = self.jumpLaunchVelocity*(1.0 - math.pow(self.jumpTime/self.maxJumpTime, self.jumpControlPower)) 
        else
            self.jumpTime = 0
        end
    else
        self.jumpTime = 0
    end
    self.wasJumping = self.isJumping
    return vel
end

--加入事件队列
function Player:onTouchBegan(x, y)
    if self.isAlive then
        self.inTouch = true
        if x >= 400 then
            self.inMove = 1
        else
            self.inMove = -1
        end
    end
end
function Player:onTouchMoved(x, y)
end
function Player:onTouchEnded(x, y)
    self.inTouch = false
    self.inMove = 0
end

function Player:getIsPowerUp()
    return self.powerUpTime > 0
end
function Player:onKilled(enemy)
    --first dead
    if self.isAlive then
        if enemy == nil then
            SimpleAudioEngine:sharedEngine():playEffect("music/PlayerFall.mp3", false)
        else
            SimpleAudioEngine:sharedEngine():playEffect("music/PlayerKilled.mp3", false)
        end
    end
    self.isAlive = false
    self:runAction(self.dieAnimation)
end
--add tint color animation
function Player:onPowerUp()
    self.powerUpTime = self.maxPowerUpTime
    --音效本身6s
    if self.powerUpSound == nil then
        self.powerUpSound = SimpleAudioEngine:sharedEngine():playEffect("music/Powerup.mp3", false)
    end
end
