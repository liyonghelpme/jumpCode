
-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
	print("begin")
	-- avoid memory leak
	collectgarbage("setpause", 100)
	collectgarbage("setstepmul", 5000)
	math.randomseed(os.time()) 
	
	local cclog = function(...)
	    print(string.format(...))
	end
	require "Class"
    require "GameScene"

    local scene = GameScene.new()
    CCDirector:sharedDirector():runWithScene(scene.bg)
	
end

xpcall(main, __G__TRACKBACK__)
