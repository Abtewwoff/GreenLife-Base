Async = {}

function Async.parallel(tasks, cb)
	if #tasks == 0 then
		cb({})
		return
	end

	local remaining = #tasks
	local results = {}

	for i = 1, #tasks, 1 do
		Citizen.CreateThread(function()
			tasks[i](function(result)
				table.insert(results, result)
				remaining = remaining - 1;

				if remaining == 0 then
					cb(results)
				end
			end)
		end)
	end
end

function Async.parallelLimit(tasks, limit, cb)
	if #tasks == 0 then
		cb({})
		return
	end

	local remaining = #tasks
	local running = 0
	local queue = {}
	local results = {}

	for i = 1, #tasks, 1 do
		table.insert(queue, tasks[i])
	end

	local function processQueue()
		if #queue == 0 then
			return
		end

		while running < limit and #queue > 0 do
			local task = table.remove(queue, 1)
			running = running + 1

			task(function(result)
				table.insert(results, result)
				remaining = remaining - 1;
				running = running - 1

				if remaining == 0 then
					cb(results)
				end
			end)
		end

		Citizen.CreateThread(processQueue)
	end

	processQueue()
end

