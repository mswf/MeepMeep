
PriorityQueue = class(PriorityQueue, function(self)
	self._queue = {}
end)


function PriorityQueue:push(object, priority)
	table.insert(self._queue, object)
end

function PriorityQueue:pop()
	return table.remove(self._queue, 1)
end

function PriorityQueue:isEmpty()
	return #self._queue < 1
end
