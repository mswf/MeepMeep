
MapGenerator = class(MapGenerator, function(self, graph)
	self._graph = graph

	self:_runGenerator()
end)

local findPath = Graph.findPath


local T_TYPES = TileTypes
local T_TYPES_GRASS = T_TYPES.Grassland
local T_TYPES_ARID= T_TYPES.Arid
local T_TYPES_MOUNTAIN= T_TYPES.Mountain
local T_TYPES_WATER = T_TYPES.Water

function MapGenerator:_runGenerator()
	Log.steb("Start Generation")

	-- math.randomseed(1)

	-- 40 x 40 == ocean visible
	local GRID_WIDTH, GRID_HEIGHT = 40,40
	-- local GRID_WIDTH, GRID_HEIGHT = 200,200

	self._graph:initializeToDimensions(GRID_WIDTH, GRID_HEIGHT)



	local currentNode = self._graph:getNodeByGridPos(math.floor(GRID_WIDTH/2),math.floor(GRID_HEIGHT/2),math.random(1,2))

	self._startNode = currentNode


	local regionNodes = {}
	table.insert(regionNodes, currentNode)

	local randomOtherNode = self._graph:getNodeByGridPos(2,2,1)

	local graph = self._graph

	-- local path = findPath(currentNode, randomOtherNode)

	local TAKE_EVERY_NTH_NODE_FROM_PATH = 6

	each(
		function(path)
			each(
				function(node)

					-- thicken the path
					each(
					function(node)
						if (node.tileType == T_TYPES_WATER) then
							node.tileType = T_TYPES_GRASS
						end
						each(
							function(node)
								if (node.tileType == T_TYPES_WATER) then
									-- random beaches
									if (math.random() > .99) then
										node.tileType = T_TYPES_ARID
										each(
											function(node)
												if (node.tileType == T_TYPES_WATER) then
													node.tileType = T_TYPES_ARID
												end
											end,
											node.neighbours
										)
									end
								end
							end,
							node.neighbours
							)
					end,
					node.neighbours)

					if (node.tileType ~= T_TYPES_MOUNTAIN) then
						node.tileType = T_TYPES_GRASS
					end
				end,
				path)
			end,
		map(
			function(splitPath)
				local piecedTogetherPaths = {}

				-- from currentNode to the first split piece
				local shortPath = findPath(currentNode, splitPath[#splitPath])
				each(
					function(i)
						table.insert(piecedTogetherPaths, shortPath[i])
					end,
					range(1, #shortPath)
				)

				each(
					function(n)
						local shortPath = findPath(splitPath[n], splitPath[n+1])
						each(
							function(i)
								table.insert(piecedTogetherPaths, shortPath[i])
							end,
							range(1, #shortPath)
						)
					end,
					range(1, #splitPath -1)
				)

				return piecedTogetherPaths

			end,
			map(
				function(path)
					local splitPath = {}

					each(
						function(number)
							-- if (true) then
							local node = path[number]

							local x, y = node:getWorldCenter()

							if (math.random() > 0.5) then
								x = x + math.random(1,3)
							else
								x = x - math.random(1,3)
							end
							if (math.random() > 0.5) then
								y = y + math.random(1,3)
							else
								y = y - math.random(1,3)
							end

							local newNode = graph:getNodeByWorldCoord(x, y)
							-- newNode.tileType = T_TYPES_MOUNTAIN
								table.insert(splitPath, newNode)
							-- end
						end,
						range(1, #path, TAKE_EVERY_NTH_NODE_FROM_PATH)
					)

					return splitPath
				end,
				map(
				function(x)
					local curX, curY = currentNode:getWorldCenter()

					-- magic number 6.28
					local direction = math.random(628-20, 628 + 628/4+20) / 100;
			    local posOffset = 25;
					local deltaX, deltaY = math.cos(direction)*posOffset, math.sin(direction)*posOffset

					local targetNode = graph:getNodeByWorldCoord(curX + deltaX, curY + deltaY)

					table.insert(regionNodes, targetNode)

					return findPath(currentNode, targetNode)
				end, range(6))
			)
		)
	)

	-- math.randomseed(1)


	local RANDOM_WALK_STEPS = 15
	each(
		function(regionNode)
			local currentNode = regionNode
			for i=1, RANDOM_WALK_STEPS do

				currentNode.tileType = T_TYPES_GRASS;
				local currentNodeNeighbours = currentNode.neighbours

				local nextNode = currentNodeNeighbours[math.random(1, #currentNode.neighbours)]
				if (nextNode.tileType == T_TYPES_GRASS) then
					nextNode = currentNodeNeighbours[math.random(1, #currentNode.neighbours)]
				end

				local prevNode = currentNode

				currentNode = nextNode


				for i=1, #prevNode.neighbours do
					prevNode.neighbours[i].tileType = T_TYPES_GRASS;

					for j=1, #prevNode.neighbours[i].neighbours do
						if (prevNode.neighbours[i].neighbours[j].tileType ~= T_TYPES_GRASS) then
							prevNode.neighbours[i].neighbours[j].tileType = T_TYPES_ARID;
						end
					end
				end
			end
		end,
		regionNodes
	)



	do
		local allNodes = graph._nodes
		local count = 0
		each(
			function(node)
				count = count + 1
				-- if (math.random() > 0.6) then
				-- 	node.tileType = T_TYPES_MOUNTAIN
				-- end
			end,
			filter(function(node) if (node.tileType ~= T_TYPES_WATER) then return true end end, allNodes)
		)
		Log.steb(count)
	end

	Log.steb("done with generation")
end



if (GlobalIngameState) then
	GlobalIngameState:__onReload()
end
