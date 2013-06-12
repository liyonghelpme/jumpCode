Layer = class()
function Layer:ctor(level, pic, scrollRate)
    self.level = level
    self.scrollRate = scrollRate
    self.textures = {}
    self.bg = CCNode:create()
    self.freeNode = CCNode:create()
    self.bg:addChild(self.freeNode)
    self.freeNode:setVisible(false)
    self.showNode = CCNode:create()
    self.bg:addChild(self.showNode)
    for i = 0, 2, 1 do
        local sp = CCSprite:create(pic.."_"..i..".png")
        print("layer sprite", sp)
        table.insert(self.textures, sp)
        self.freeNode:addChild(sp)
    end
    print("self.textures", #self.textures)

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
function Layer:update(diff)
    local segmentSize = self.textures[1]:getContentSize() 
    local segmentWidth = segmentSize.width
    local x = self.level.cameraPosition*self.scrollRate
    local leftSegment = math.floor(x/segmentWidth)
    local rightSegment = leftSegment+1
    x = (x/segmentWidth-leftSegment)*-segmentWidth
    local lt = leftSegment%#self.textures
    local rt = rightSegment%#self.textures
    self.showNode:removeFromParentAndCleanup(true)
    self.showNode = CCNode:create()
    self.bg:addChild(self.showNode)
    local ls = CCSprite:createWithTexture(self.textures[lt+1]:getTexture())
    local rs = CCSprite:createWithTexture(self.textures[rt+1]:getTexture())
    self.showNode:addChild(ls)
    self.showNode:addChild(rs)
    ls:setAnchorPoint(ccp(0, 0))
    rs:setAnchorPoint(ccp(0, 0))
    --screen position not level localposition
    ls:setPosition(ccp(x+self.level.cameraPosition, 0))
    rs:setPosition(ccp(x+segmentWidth+self.level.cameraPosition, 0))
    --print("leftSegment rightSegment", lt, rt, x, segmentWidth, leftSegment, rightSegment)
end
