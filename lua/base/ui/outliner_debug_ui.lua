

OutlinerDebugUI = class(OutlinerDebugUI, UIBase)

function OutlinerDebugUI:_createUI()
	local parentEntity = self._params.parentEntity
	local window = self.window
	window.title = "Outliner UI"

	window.width = 600
	window.x = 0
	window.y = 0
	window.height = Engine.ui.getScreenHeight()

	local children = parentEntity:getChildren()
	for i=1,#children do
		local tree = window:addTree()
		tree.label = children[i]
	end
end


function OutlinerDebugUI:_listChildren(uiContainer, parentEntity, nestedLevel)
	nestedLevel = nestedLevel or 0
	nestedLevel = nestedLevel + 1


	local row = uiContainer:addHorizontalLayout()
	row.offset = 250 + nestedLevel*30
	row.spacing = -1.0

	local tree = row:addTree()
	tree.opened = false
	tree.onCollapse = function (treeInstance)
		treeInstance:removeChildren()
		-- remove children
	end

end
