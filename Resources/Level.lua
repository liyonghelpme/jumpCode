require "Tile"
require "Player"
require "Layer"
require "Gem"
Level = class()
function Level:update(diff)
    self:scrollCamera()
    self:createChunk()
    self:clearChunk()
end
function Level:createChunk()
    local director = CCDirector:sharedDirector()
    local vsize = director:getVisibleSize()
    local lchunk = math.floor(self.cameraPosition/(StaticTile.Width*20))
    local rchunk = math.floor((self.cameraPosition+vsize.width)/(StaticTile.Width*20))
    lchunk = lchunk-1
    lchunk = math.max(lchunk, 0)
    rchunk = rchunk+1


    --[[
    local data = require "map"
    self.width = #data[1]
    self.height = #data
    for y=1, self.height, 1 do
        for x=1, self.width, 1 do
            local tileType = string.sub(data[y], x, x)
            --print('tileType', tileType)
            local tile = self:loadTile(tileType, x, y)
            self.tiles[self:getKey(x-1, self.height-y)] = tile
        end
    end
    --]]
    if self.chunks[rchunk] == nil then
        print("createChunk", rchunk)
        --local data = require "SingleMap"
        local data = self.allMap[math.random(1, #self.allMap)]
        for y = 1, self.height, 1 do
            for x = 1, 20, 1 do
                local tileType = string.sub(data[y], x, x)
                local tx = x+self.width
                local tile = self:loadTile(tileType, tx, y)
                self.tiles[self:getKey(tx-1, self.height-y)] = tile
            end
        end
        self.width = self.width+20
        self.chunks[rchunk] = true
    end
end
--每个chunk 20个tile 宽度
function Level:clearGem(chunkId)
    local i = 1
    while i <= #self.gems do
        local gem = self.gems[i]
        local x = math.floor(gem.basePosition.x/StaticTile.Width)
        local cid = math.floor(x / 20)
        if cid <= chunkId then
            table.remove(self.gems, i)
            gem.bg:removeFromParentAndCleanup(true)
        else
            i = i + 1
        end
    end
end
function Level:clearChunk()
    local director = CCDirector:sharedDirector()
    local vsize = director:getVisibleSize()
    local lchunk = math.floor(self.cameraPosition/(StaticTile.Width*20))
    local rchunk = math.floor((self.cameraPosition+vsize.width)/(StaticTile.Width*20))
    lchunk = lchunk-1
    if lchunk >= 0 and self.chunks[lchunk] ~= nil then
        local startWidth = lchunk*20
        for y = 1, self.height, 1 do
            for x = 1, 20, 1 do
                local tx = x+startWidth
                local key = self:getKey(tx-1, self.height-y)
                local tile = self.tiles[key]
                if tile.bg ~= nil then
                    tile.bg:removeFromParentAndCleanup(true)
                    tile.bg = nil
                end
                self.tiles[key] = nil
            end
        end
        self:clearGem(lchunk)
        self.chunks[lchunk] = nil
        self.minWidth = startWidth+20
    end
end
--读取文件 生成块 加载每个小块
--走到前面不能回头minWidth
--cameraPos
function Level:ctor(scene)
    self.scene = scene
    self.start = nil
    self.allMap = require "AllMap"
    self.score = 0
    self.width = 0
    self.minWidth = 0
    self.height = 0
    self.tiles = {}
    self.chunks = {}
    self.layers = {}
    self.player = nil
    self.gems = {}
    self.enemies = {}
    self.invalidPosition = {-1, -1}
    self.cameraPosition = 0
    self.bg = CCNode:create()
    self.freeNode = CCNode:create()
    self.freeNode:setVisible(false)
    self.bg:addChild(self.freeNode)
    local function onEnterOrExit(tag)
        if tag.name == "enter" then
            self.scene:updateScore(self.score)
            local function updateState(diff)
                self:update(diff)
            end
            self.updateEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateState)
        elseif tag.name == "exit" then
            CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.updateEntry)
        end
    end
    self.bg:registerScriptHandler(onEnterOrExit)
    self:loadBackground()
    self:loadTiles()
end
function Level:getKey(x, y)
    return x*10000+y
end
function Level:getXY(key)
    return math.floor(key/10000), math.floor(key%10000)
end
function Level:loadBackground()
    --[[
    local b0 = CCSprite:create("Layer0_0.png")
    b0:setAnchorPoint(ccp(0, 0))
    b0:setPosition(ccp(0, 0))
    local b1 = CCSprite:create("Layer1_0.png")
    b1:setAnchorPoint(ccp(0, 0))
    b1:setPosition(ccp(0, 0))
    local b2 = CCSprite:create("Layer2_0.png")
    b2:setAnchorPoint(ccp(0, 0))
    b2:setPosition(ccp(0, 0))
    self.bg:addChild(b0)
    self.bg:addChild(b1)
    self.bg:addChild(b2)
    --]]
    local b0 = Layer.new(self, "Layer0", 0.2) 
    local b1 = Layer.new(self, "Layer1", 0.5) 
    local b2 = Layer.new(self, "Layer2", 0.8) 
    self.bg:addChild(b0.bg)
    self.bg:addChild(b1.bg)
    self.bg:addChild(b2.bg)
    table.insert(self.layers, b0)
    table.insert(self.layers, b1)
    table.insert(self.layers, b2)
end
--卷动屏幕 调整 level node的位置
--生成新的 cameraPosition 
--viewMargin
function Level:scrollCamera()
    local viewMargin = 0.35
    local director = CCDirector:sharedDirector()
    local vsize = director:getVisibleSize()
    local marginWidth = vsize.width*viewMargin
    local marginLeft = self.cameraPosition+marginWidth
    local marginRight = self.cameraPosition+vsize.width-marginWidth

    local cameraMovement = 0
    local ppx, ppy = self.player.bg:getPosition()
    if ppx < marginLeft then
        cameraMovement = ppx-marginLeft
    elseif ppx > marginRight then
        cameraMovement = ppx-marginRight
    end
    local maxCameraPosition = StaticTile.Width*(self.width-1) - vsize.width
    self.cameraPosition = math.min(math.max(self.cameraPosition+cameraMovement, self.minWidth*StaticTile.Width), maxCameraPosition)
    
    --print("cameraPosition", self.cameraPosition)
    self.bg:setPosition(ccp(-self.cameraPosition, 0))
    --将要显示出来的tile 添加到bg 上面不显示的 添加到free 上面去
end

function Level:loadTiles()
    local data = require "map"
    self.width = #data[1]
    self.height = #data
    print("loadTiles", self.width, self.height)
    for y=1, self.height, 1 do
        for x=1, self.width, 1 do
            local tileType = string.sub(data[y], x, x)
            --print('tileType', tileType)
            local tile = self:loadTile(tileType, x, y)
            self.tiles[self:getKey(x-1, self.height-y)] = tile
        end
    end
    self.chunks[0] = true
    self.chunks[1] = true
end
function Level:loadTile(tileType, x, y)
    local tile
    --player 所在tile 是可通过的
    --player 站在格子的 中心点位置
    if tileType == '1' then
        self.start = {x-1+0.5, self.height-y}
        self.player = Player.new(self, self.start[1], self.start[2])
        self.bg:addChild(self.player.bg, 1)
        tile = Tile.new(self, '.', x, y)
    elseif tileType == 'G' then
        local bounds = self:getBounds(x-1, self.height-y)
        local px, py = bounds:getMidX(), bounds:getMidY()
        local gem = Gem.new(self, px, py)
        self.bg:addChild(gem.bg)
        table.insert(self.gems, gem)
        tile = Tile.new(self, '.', x, y)
    else
        tile = Tile.new(self, tileType, x, y)
    end
    if tile.bg ~= nil then
        tile.bg:setAnchorPoint(ccp(0, 0))
        self.bg:addChild(tile.bg)
        --self.freeNode:addChild(tile.bg)
        tile.bg:setPosition(ccp(40*(x-1), 32*(self.height-y)))
    end
    return tile
end
function Level:loadExitTile(x, y)
end

function Level:getCollision(x, y)
    if x < self.minWidth or x >= self.width-1 then
        return 'Impassable'
    end
    if y < -2 then
        return 'Impassable'
    end
    if y < 0 or y >= self.height then
        return 'Passable'
    end
    return self.tiles[self:getKey(x, y)].collision
end
function Level:getBounds(x, y)
    --print("getBounds", x, y, StaticTile.Width, StaticTile.Height)
    return CCRectMake(x*StaticTile.Width, y*StaticTile.Height, StaticTile.Width, StaticTile.Height)
end
function Level:onGemCollected(gem)
    for i = 0, #self.gems, 1 do
        if self.gems[i] == gem then
            self.score = self.score+1
            self.scene:updateScore(self.score)
            table.remove(self.gems, i)
            break
        end
    end
end
function Level:onPlayerKilled(enemy)
    self.player:onKilled(enemy)
end
function Level:startNewLife()
    self.player:reset(self.start[1], self.start[2])
end
function Level:getTile(x, y)
    return self.tiles[self:getKey(x, y)]
end
