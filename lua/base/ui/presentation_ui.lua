
PresentationUI = class(PresentationUI, UIBase)

function PresentationUI:_createUI()
	self._currentSlide = self._currentSlide or 1

	if (self._isMayhem == nil) then
		self._isMayhem = false
	end

	local slides = self._params.slides

	slides = {
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

	for i=1, #slides do
		Engine.importTexture( slides[i], false )
	end

	local presModel = Engine.getModel("quad")
	local presEntity = Entity()
	local renderer = MeshRenderer()
	renderer:setModel(presModel)
	presEntity:addComponent(renderer)

	local presMaterial = Material()
	presMaterial:setDiffuseTexture(slides[self._currentSlide])
	presMaterial:makeQuadShader()
	renderer:setMaterial(presMaterial)

	presEntity:setPosition(0,0,-1)

	self.entity = presEntity
	self.material = presMaterial
	self.slides = slides

	local window = self.window

	window.displayTitle = false
	window.resizable = false
	window.movable = false

	window.width = 122
	window.height = 40
	window.y = Engine.ui.getScreenHeight() - 80
	window.x = 120

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

function PresentationUI:_setSlide(slideIndex)
	if (slideIndex > 0) and (slideIndex <= #self.slides) then
		self._currentSlide = slideIndex
	end


	self.material:setDiffuseTexture(self.slides[self._currentSlide])


	if (self._currentSlide == 11) then
		self.mayhemButton.visible = true
		self.window.width = 122

	else
		self.mayhemButton.visible = false
		self.window.width = 70

	end

end

function PresentationUI:_updateMayhem(isMayhem)
	if (isMayhem == true) then
		self.entity:setPosition(0,0,10)

		self._uiManager:setVisible(true)

		Engine.playSound("sounds/circus_theme.wav")
	else
		self.entity:setPosition(0,0,-1)

		self._uiManager:setVisible(false)
		self.window.visible = true
	end

	self._isMayhem = isMayhem
end
