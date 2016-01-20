


local function rgb(r,g,b,a)
	a = a or 255
	return {r/255, g/255, b/255, a/255}
end

local sensibleColours = {}
sensibleColours[1] = rgb(111, 222, 122)
sensibleColours[2] = rgb(228, 170, 116)
sensibleColours[3] = rgb(35, 169, 245)
sensibleColours[4] = rgb(255, 255, 255)
-- sensibleColours[4] = rgb(11, 218, 206)

local tileProperties = {
	-- Base Properties
	Fertile = {
		buildable = true
	},
	Arid = {
		buildable = true

	},

	-- Structures
	House = {

	},

	-- Resources
	Trees = {
		buildable = true

	},

	Iron = {

	},
	Gold = {

	},
	Cold = {

	},

	Fish = {

	},

	Wildlife_buffalos = {

	},
	Wildlife_horses = {

	},
	Wildlife_deer = {

	},
}

enumify(tileProperties, "TileProperties")


local tileTypes = {
	Water = {
		walkable = false,
		potentialProperties = {
			TileProperties.Cold,

			TileProperties.Fish,
		},
	},
	Grassland = {
		walkable = true,
		potentialProperties = {
			TileProperties.Fish,
			TileProperties.Fertile,
			TileProperties.Wildlife_buffalos,
			TileProperties.Wildlife_horses,
		},
	},
	Arid = {
		walkable = true,
		potentialProperties = {
			TileProperties.Cold,

			TileProperties.Wildlife_horses,
		},
	},
	Mountain = {
		walkable = false,
		potentialProperties = {
			TileProperties.Cold,

			TileProperties.Wildlife_horses,
		},
	},
}

enumify(tileTypes, "TileTypes")
