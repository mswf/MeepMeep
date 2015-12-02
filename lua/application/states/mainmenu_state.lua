
require "lua/application/ui/mainmenu/mainmenu_ui"
require "lua/application/ui/test_ui"
require "lua/application/ui/option_ui"

MainMenuState = class(MainMenuState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)


createPrivateEnum(MainMenuState, "Events",
	"OpenOptions",
	"CloseOptions"
)

function MainMenuState:update(dt)
	-- Log.steb("updating the MainMenuState")

end

function MainMenuState:__onReload()
	Log.steb("MainMenuState reloaded")

	-- self.window.title = "Anything"

	-- Log.steb("changed broadcaster reload")
end

function MainMenuState:exit(transitionType, args)
	if (args.instruction == "NEWGAME") then
		GlobalData:createGameNew()
	elseif (args.instruction == "LOADGAME") then
		GlobalData:createGameFromSave(args.saveData)
	else
		GlobalData:createGameNew()
	end
end

function MainMenuState:enter(transitionType, args)
	self._mainMenuUI = MainMenuUI(self.UIManager)

	self._optionUI = OptionUI(self.UIManager, {visible = false})

	self._testUI2 = TestUI(self.UIManager, {title = "Test 2"})
	self._testUI = TestUI(self.UIManager, {title = "Test 1"})



	Log.bobn("plsdfff")
	Log.bobn(Engine.system.contentPath)

	local model = Engine.loadModel("objects/Rabbit/Rabbit.obj");
	local rabbit = Entity()
	local renderer = MeshRenderer()
	renderer:setModel(model)

	rabbit:addComponent(renderer)

	rabbit:setPosition(0,0,0)

	rabbit.update = function(self, delta)
		self:yaw(1)
	end

	model = Engine.loadModel("objects/icy_snowman.obj");
	local snowman = Entity()
	renderer = MeshRenderer()
	renderer:setModel(model)

	snowman:addComponent(renderer)

	snowman:setPosition(-1,-1,-1)

	snowman.update = function(self, delta)
		self:roll(1)
	end

	rabbit:addChild(snowman)
end
