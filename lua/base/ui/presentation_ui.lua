
PresentationUI = class(PresentationUI, UIBase)

function PresentationUI:_createUI()
	self._currentSlide = self._currentSlide or 1

	if (self._isMayhem == nil) then
		self._isMayhem = false
	end

	local slides = self._params.slides or {
		"images/slides/Presentation 16-12-2015.png",
		"images/slides/Presentation 16-12-2015 (1).png",
		"images/slides/Presentation 16-12-2015 (2).png",
		"images/slides/Presentation 16-12-2015 (3).png",
		"images/slides/Presentation 16-12-2015 (4).png",
		"images/slides/Presentation 16-12-2015 (5).png",
		"images/slides/Presentation 16-12-2015 (6).png",
		"images/slides/Presentation 16-12-2015 (7).png",
		"images/slides/Presentation 16-12-2015 (8).png",
		"images/slides/Presentation 16-12-2015 (9).png",
		"images/slides/Presentation 16-12-2015 (10).png",
		"images/slides/Presentation 16-12-2015 (11).png",
		"images/slides/Presentation 16-12-2015 (12).png",
		"images/slides/Presentation 16-12-2015 (13).png"
	}
	self.specialSlides = self._params.specialSlides or {
		-- [1] = true,
		[11] = true
	}


	for i=1, #slides do
		Engine.importTexture( slides[i], true )
	end

	local presEntity = Entity()
	local renderer = MeshRenderer()

	local presModel = Engine.getModel("quad")
	renderer:setModel(presModel)
	presEntity:addComponent(renderer)
		-- presEntity:setScale(16/9, 1, 1)

	local presMaterial = Material()
	presMaterial:setDiffuseTexture(slides[self._currentSlide])
	presMaterial:makeQuadShader()
	renderer:setMaterial(presMaterial)

	Engine.getActiveCamera().entity:addChild(presEntity)
	presEntity:setPosition(0,0,1)
	presEntity:setYaw(0.5)
-- self._uiManager:setVisible(true)
	-- debugEntity(presEntity)

	self.entity = presEntity
	self.material = presMaterial
	self.slides = slides

	local window = self.window

	window.displayTitle = false
	window.resizable = false
	window.movable = false

	window.width = 122
	window.height = 40
	window.y = Engine.window.getHeight() - 60
	window.x = 80

	local horizontal = window:addHorizontalLayout()

	local buttonLeft = horizontal:addButton()
	buttonLeft.text = "<<"
	buttonLeft.onPress = function() self:_prevSlide() end

	local mayhemButton = horizontal:addButton()
	mayhemButton.text = "mayhem"
	mayhemButton.onPress = function()
		self:_updateMayhem(not self._isMayhem)
	end

	local buttonRight = horizontal:addButton()
	buttonRight.text = ">>"
	buttonRight.onPress = function() self:_nextSlide() end

	self.buttonRight = buttonRight
	self.buttonLeft = buttonLeft
	self.mayhemButton = mayhemButton

	self:_setSlide(self._currentSlide)
	self:_updateMayhem(self._isMayhem)
end

function PresentationUI:_nextSlide()
	self:_setSlide(self._currentSlide + 1)
end

function PresentationUI:_prevSlide()
	self:_setSlide(self._currentSlide - 1)
end

function EntityDebugUI:onWindowResized()
	self.window.y = Engine.window.getHeight() - 60
	self.window.x = 80
end

function PresentationUI:_setSlide(slideIndex)
	if (slideIndex > 0) and (slideIndex <= #self.slides) then
		self._currentSlide = slideIndex
	end


	self.material:setDiffuseTexture(self.slides[self._currentSlide])


	if (self.specialSlides[self._currentSlide]) then
		self.mayhemButton.visible = true
		self.window.width = 122

	else
		self.mayhemButton.visible = false
		self.window.width = 70

	end

end

function PresentationUI:update(dt)
	if (not self._isMayhem) then
		if (Input.keyUp(KeyCode.LEFT)) then
			self:_prevSlide()
		end
		if (Input.keyUp(KeyCode.RIGHT)) then
			self:_nextSlide()
		end
	end
end

function PresentationUI:_updateMayhem(isMayhem)
	if (isMayhem == true) then
		GlobalMainMenu.UIManager:setVisible(true)

		self._uiManager.tweener(6, self.entity, {setZ = -2, setY = 10}):setEasing("inQuad")
		-- self.entity:setPosition(0,0,10)

		self._uiManager:setVisible(true)


		-- Engine.playSound("sounds/circus_theme.wav")
	else
		GlobalMainMenu.UIManager:setVisible(false)

		if (self.specialSlides[self._currentSlide]) then
			self:_nextSlide()
		end

		self._uiManager.tweener(2, self.entity, {setZ = 1, setY = 0}):setEasing("outBounce")

		-- self.entity:setPosition(0,0,-1)

		self._uiManager:setVisible(false)
		self.window.visible = true
	end

	self._isMayhem = isMayhem
end
