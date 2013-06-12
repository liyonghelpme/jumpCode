Tile = class()
--Tile.Width = 40
--Tile.Height = 32
function Tile:ctor(level, t, x, y)
    self.level = level
    self.tileType = t
    self.width = 40
    self.height = 32
    self.collision = nil
    if t == '.' then
        self.bg = nil
        self.collision = 'Passable'
    elseif t == '-' then
        self.bg = CCSprite:create("Platform.png")
        self.collision = 'Platform'
    elseif t == '#' then
        local index = math.random(0, 6)
        self.bg = CCSprite:create("BlockA"..index..".png")
        self.collision = 'Impassable'
    elseif t == 'A' then
        local index = math.random(0, 1)
        self.bg = CCSprite:create("BlockB"..index..".png")
        self.collision = 'Block'
    elseif t == 'B' then
        self.bg = CCSprite:create("box.png")
        self.collision = "Break"
    else
        self.bg = nil
        self.collision = 'Passable'
    end

    --敌人需要检测是否和 player碰撞
    --[[
    if t == 'A' then
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
    end
    --]]
end
function Tile:getBoundBox()
    local x, y = self.bg:getPosition()
    local left = x
    local bottom = y
    return CCRectMake(left, bottom, self.width, self.height)
end
--block collider with player 
function Tile:update(diff)
    if self.level.player.isAlive and self:getBoundBox():intersectsRect(self.level.player:getBoundBox()) then
        self.level:onPlayerKilled(self)
    end
end

StaticTile = {}
StaticTile.Width = 40
StaticTile.Height = 32
