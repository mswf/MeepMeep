require "lua/weikie/character"

Player = class(Player, Character, function(self)
	Log.waka("player init")
	--do i really need to do this
	self._base.init(self)
	--self.character = Character()
end)

function Player:update()
	self:pollInput()
	--self._base:update()
end

function Player:pollInput()
	if Input.keyDown(KeyCode.w) == true then
		self:moveUp()
	end

	if Input.keyDown(KeyCode.a) == true then
		self:moveLeft()
	end

	if Input.keyDown(KeyCode.s) == true then
		self:moveDown()
	end

	if Input.keyDown(KeyCode.d) == true then
		self:moveRight()
	end
end
