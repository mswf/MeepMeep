
Queue = class(Queue, function(self)
	self._queue = {}
end)

function Queue:push(object)
	table.insert(self._queue, object)
end

function Queue:pop()
	return table.remove(self._queue, 1)
end

function Queue:isEmpty()
	return #self._queue < 1
end
