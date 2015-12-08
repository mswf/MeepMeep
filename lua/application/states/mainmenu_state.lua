
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
		GlobalData:loadGame(args.saveHandle)
	else
		GlobalData:createGameNew()
	end
end

function MainMenuState:enter(transitionType, args)
	self._mainMenuUI = MainMenuUI(self.UIManager)

	self._optionUI = OptionUI(self.UIManager, {visible = false})

	-- self._testUI2 = TestUI(self.UIManager, {title = "Test 2"})
	self._testUI = TestUI(self.UIManager, {title = "Test 1"})



	Log.bobn("plsdfff")
	Log.bobn(Engine.system.contentPath)

	local model = Engine.getModel("objects/Rabbit/Rabbit.obj");
	local rabbit = Entity()
	local renderer = MeshRenderer()
	renderer:setModel(model)

	rabbit:addComponent(renderer)

	rabbit:setPosition(0,0,0)
--[[
	rabbit.update = function(self, dt)
		-- Log.steb(dt)
		if (Input.key(KeyCode.w)) then
			self:addZ(1*dt)
		end

		if (Input.key(KeyCode.s)) then
			self:addZ(-1*dt)
		end

		if (Input.key(KeyCode.a)) then
			self:addX(1*dt)
		end

		if (Input.key(KeyCode.d)) then
			self:addX(-1*dt)
		end
		-- self:yaw(1)
	end
]]--
	model = Engine.getModel("objects/icy_snowman.obj");
	local snowman = Entity()
	renderer = MeshRenderer()
	renderer:setModel(model)

	snowman:addComponent(renderer)

	snowman:setPosition(-1,-1,-1)

	snowman.update = function(self, dt)
		self:roll(1)
	end

	rabbit:addChild(snowman)

	local testMat = Material();
	testMat:setDiffuseTexture("objects/snowman.png");
	rabbit.meshRenderer:setMaterial(testMat);


	local lineEntity = Entity()
	lineEntity:addComponent(DebugRenderer())
	lineEntity.debugRenderer:addLine(0,0,0, 2,0,0, 1,0,0)
	lineEntity.debugRenderer:addLine(0,0,0, 0,2,0, 0,1,0)
	lineEntity.debugRenderer:addLine(0,0,0, 0,0,2, 0,0,1)

	Engine.getModel('lol');
	Engine.getMaterial('lol');

	local cameraEntity = Entity()
	local camera = Camera()
	cameraEntity:addComponent(camera);
	cameraEntity:setPosition(0,0,0)

	camera:setProjectionType("orthographic")
	camera:makeActive()

	cameraEntity.update = function(self, dt)
		-- Log.steb(dt)
		if (Input.key(KeyCode.w)) then
			self:addZ(1*dt)
		end

		if (Input.key(KeyCode.s)) then
			self:addZ(-1*dt)
		end

		if (Input.key(KeyCode.a)) then
			self:addX(1*dt)
		end

		if (Input.key(KeyCode.d)) then
			self:addX(-1*dt)
		end
		-- self:yaw(1)
	end



	-- EntityDebugUI(self.UIManager, {entity = lineEntity})
end
