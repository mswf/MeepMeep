DebugRenderer = class(DebugRenderer, Engine.baseDebugRenderer, function(self)


end)


function DebugRenderer:addLine2D(x1, y1, x2, y2, r,g,b,a)
	self:addLine(x1, y1, 0, x2, y2, 0, r,g,b,a)
end

function DebugRenderer:addTriangle2D(x1, y1, x2, y2, x3, y3, r,g,b,a)
	self:addTriangle(x1, y1, 0, x2, y2, 0, x3, y3, 0, r or 0,g or 0,b or 0,a or 1)
end
