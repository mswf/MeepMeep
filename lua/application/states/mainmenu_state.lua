
require "lua/application/ui/mainmenu/mainmenu_ui"
require "lua/application/ui/test_ui"
require "lua/application/ui/option_ui"

-- require "lua/base/ui/presentation_ui"


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

function MainMenuState:enter(transitionType, args)
	Engine.importModel("objects/Rabbit/Rabbit.obj")
	Engine.importModel( "objects/icy_snowman.obj" )
	Engine.importTexture( "objects/snowman.png", true )
	Engine.importTexture( "objects/object_group_test/checker_1.png" )
	Engine.importTexture( "objects/object_group_test/checker_2.png" )

	self._mainMenuUI = MainMenuUI(self.UIManager)

	self._optionUI = OptionUI(self.UIManager, {visible = false})

	-- self._testUI2 = TestUI(self.UIManager, {title = "Test 2"})
	-- self._testUI = TestUI(self.UIManager, {title = "Test 1"})

	local model = Engine.getModel("objects/Rabbit/Rabbit.obj");
	local rabbit = Entity()
	local renderer = MeshRenderer()
	renderer:setModel(model)

	rabbit:addComponent(renderer)
	rabbit:setPosition(0,0,5)

	local lightEntity = Entity()
	local light = Light()
	light:setIntensity(0.1)
	light:setColor(1,0,1,1)
	lightEntity:addComponent(light)

	lightEntity:setPitch(0.547)
	lightEntity:setYaw(0.337)
	lightEntity:setRoll(0.895)

	GlobalLight = lightEntity

	-- debugEntity(lightEntity)

	-- light.entity.update = function(self, dt)
	-- 	self:yaw(1)
	-- end

	--[[
	for i=1, 10 do
		model = Engine.getModel("objects/icy_snowman.obj");
		local snowman = Entity()
		local renderer = MeshRenderer()
		renderer:setModel(model)

		snowman:addComponent(renderer)

		local snowmanMat = Material();
		snowmanMat:setDiffuseTexture("objects/snowman.png")

		snowman.meshRenderer:setMaterial(snowmanMat)

		snowman:setPosition(-1,-1,-1)

		snowman.update = function(self, dt)
			self:roll(1)
		end
		snowman:roll(math.random()*1100)

		rabbit:addChild(snowman)
	end
	]]--

	local lineEntity = Entity()
	lineEntity:addComponent(DebugRenderer())
	lineEntity.debugRenderer:addLine(0,0,0, 2,0,0, 1,0,0)
	lineEntity.debugRenderer:addLine(0,0,0, 0,2,0, 0,1,0)
	lineEntity.debugRenderer:addLine(0,0,0, 0,0,2, 0,0,1)

	local cameraEntity = Entity()
	local camera = Camera()
	cameraEntity:addComponent(camera);
	cameraEntity:setPosition(0,0,0)

	camera:setProjectionType(Camera.ProjectionType.PERSPECTIVE)
	camera:makeActive()
	camera:setAspectRatio(Engine.ui.getScreenWidth()/Engine.ui.getScreenHeight())


	-- local cameraMoveSpeed = 10
	-- cameraEntity.update = function(self, dt)
	-- 	if (Input.binding("moveUp")) then
	-- 		self:addY(cameraMoveSpeed*dt)
	-- 	end
	--
	-- 	if (Input.binding("moveDown")) then
	-- 		self:addY(-cameraMoveSpeed*dt)
	-- 	end
	--
	-- 	if (Input.binding("moveLeft")) then
	-- 		self:addX(-cameraMoveSpeed*dt)
	-- 	end
	--
	-- 	if (Input.binding("moveRight")) then
	-- 		self:addX(cameraMoveSpeed*dt)
	-- 	end
	-- end

	cameraEntity:setPosition(10,10,20)
	cameraEntity:setPitch(0.5);
	cameraEntity:setRoll(0.5);

	self.camera = cameraEntity
	GlobalCamera = cameraEntity.camera
	-- debugEntity(cameraEntity)

	-- EntityDebugUI(self.UIManager, {entity = cameraEntity})

	-- if (not PREZZY) then
	-- 	PREZZY = PresentationUI()
	-- end
	-- PREZZY._uiManager = self.UIManager
	-- PREZZY:_updateMayhem(false)

	GlobalStateManager:doTransition(Transitions.MainMenuToGame, {instruction = "NEWGAME"})
end

function MainMenuState:exit(transitionType, args)
	-- self.camera:destroy()

	if (args.instruction == "NEWGAME") then
		GlobalData:createGameNew()
	elseif (args.instruction == "LOADGAME") then
		GlobalData:loadGame(args.saveHandle)
	else
		GlobalData:createGameNew()
	end
end
