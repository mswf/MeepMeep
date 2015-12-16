
PresentationUI = class(PresentationUI, UIBase)

function PresentationUI:_createUI()
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

	local window = self.window

	window.displayTitle = false
	window.resizable = false
	window.movable = false

	window.width = 122
	window.height = 40
	window.y = Engine.ui.getScreenHeight() - 120
	window.x = 120

	local horizontal = window:addHorizontalLayout()

	local buttonLeft = horizontal:addButton()
	buttonLeft.text = "<<"
	buttonLeft.onPress = function() Log.steb("Left") end

	local mayhemButton = horizontal:addButton()
	mayhemButton.text = "mayhem"
	mayhemButton.onPress = function() Log.steb("Woop") end

	local buttonRight = horizontal:addButton()
	buttonRight.text = ">>"
	buttonRight.onPress = function() Log.steb("Left") end
end
