
require "base/base"
require "application/logging"


Game = Game or {}


function Game.main()
	Log.steb("Game.main called")

end

function Game.update(dt)
	Log.steb("update the game at dt: " .. tostring(dt))

end



function Game.onShutdown()
	Log.steb("Shutting down the game")
end



function Game.onFocusLost()
end

function Game.onFocusGained()
end



--When logging 'nil' there's a fallback string that gets printed
Log.steb()
Log.bobn()
Log.tinas()
Log.gwebl()
Log.waka()

Log.steb("-")

createEnum("TestEnum", "One", "Two", "Three")
Log.steb(TestEnum)

Log.steb("-")
local test = TestEnum.One
Log.steb(test)


local tween = Tween()
