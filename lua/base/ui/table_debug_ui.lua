
local function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
			-- if (type(key) == "number") then
      --   table.insert(  orderedIndex, tostring(key))
			--
			-- else
				table.insert( orderedIndex, key)
			-- end
    end
    table.sort( orderedIndex, function(a, b)
			local aType, bType = type(a), type(b)
			if (aType == bType) then
				if (aType == "table") then
					return tostring(a) < tostring(b)
				else
					return a < b
				end
			elseif (aType == "string") then
				return false
			elseif (bType == "string") then
				return true
			else
				return a < b
			end
		end)
    return orderedIndex
end

local function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    local key = nil
    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        rawset(t, "__orderedIndex", __genOrderedIndex( t ))
        key = t.__orderedIndex[1]
    else
        -- fetch the next value
        for i = 1,table.getn(t.__orderedIndex) do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
		rawset(t, "__orderedIndex", nil)

    return
end

local function orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end


TableDebugUI = class(TableDebugUI, UIBase)

local ignoreFunctions = {
	__concat = true,
	__onReload = true,
	__tostring = true,
	init = true,
	is_a = true
}

function TableDebugUI:_listTable(uiContainer, debugTable, nestedLevel)
	nestedLevel = nestedLevel or 0
	nestedLevel = nestedLevel + 1

	for k,v in orderedPairs(debugTable) do
		if not (ignoreFunctions[tostring(k)] == true) then

		-- else

			local row = uiContainer:addHorizontalLayout()
			row.offset = 250 + nestedLevel*30
			row.spacing = -1.0

			local tree = row:addTree()
			tree.opened = false
			tree.onCollapse = function (treeInstance)
				treeInstance:removeChildren()
				-- remove children
			end

			local keyType = type(k)
			if (keyType == "table") then
				tree.label = tostring(k)


			elseif (keyType == "function") then
				tree.label = tostring(k)


			elseif (keyType == "boolean") then
				tree.label = tostring(k)


			elseif (keyType == "number") then
				tree.label = tostring(k)
			elseif (keyType == "string") then
				tree.label = k
			end

			local valueType = type(v)
			if (valueType == "nil") then
				local valueString = row:addText(tostring(v))
				-- valueString.x = 800

			elseif (valueType == "table") then
				local valueString = row:addText(tostring(v))
				-- valueString.x = 800

				tree.onExpand = function(treeInstance)
					self:_listTable(treeInstance, v, nestedLevel)
					local mt = getmetatable(v)
					if (mt) then
						local metaTableTree = treeInstance:addTree("MetaTable")
						metaTableTree.opened = false
						self:_listTable(metaTableTree, mt, nestedLevel)
					end
				end
			elseif (valueType == "function") then
				local valueString = row:addText(tostring(v))

				tree.onExpand = function(treeInstance)
					local debugInfo = debug.getinfo(v)

					if (debugInfo.what == "Lua") then
						treeInstance:addText(debugInfo.source)
						treeInstance:addText("at line: " .. tostring(debugInfo.linedefined))
						treeInstance:addText("#UpValues: " .. tostring(debugInfo.nups))
					elseif (debugInfo.what == "main") then
						treeInstance:addText("Main function")
						treeInstance:addText("#UpValues: " .. tostring(debugInfo.nups))
					else
						treeInstance:addText("C function")
					end
				end
				-- local valueString = row:addText("  " .. tostring(v))
				-- valueString.x = 800

			elseif (valueType == "boolean") then
				local valueString = row:addText(tostring(v))
				-- valueString.x = 800

			elseif (valueType == "number") then
				local valueString = row:addText(tostring(v))
				-- valueString.x = 800

			elseif (valueType == "string") then
				local valueString = row:addText(tostring(v))
				-- valueString.x = 800

			end
		end
	end

	uiContainer:addText("--------------------")

end

function TableDebugUI:_createUI()
	local debugTable = self._params.table
	local window = self.window
	window.title = "Table Debug UI"

	window.width = 600
	window.x = 0
	window.y = 0
	window.height = Engine.ui.getScreenHeight()

	local mainTree = window:addTree(tostring(debugTable))

	self:_listTable(mainTree, debugTable)

end

-- function TableDebugUI:update(dt)
--
-- end
