require "lua/weikie/character"

Player = class(Player, Character, function(self)
	--self:_loadModel("objects/Rabbit/Rabbit.obj")
	--self:_loadModel("objects/weikie/billboard.obj")
	--self:setMaterial("objects/snowman.png")
end)

function Player:update(dt)
	self:pollInput()
end

function Player:pollInput()
	if Input.key(KeyCode.w) == true then
		self:moveUp()
	end

	if Input.key(KeyCode.d) == true then
		self:moveLeft()
	end

	if Input.key(KeyCode.s) == true then
		self:moveDown()
	end

	if Input.key(KeyCode.a) == true then
		self:moveRight()
	end
end
