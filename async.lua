local async = {}
function async.call( ... )
    local async_context = {}
    local objs = {...}
    local next
    next = function()
        if #objs > 0 then
            local caller = objs[1]
            table.remove(objs, 1)
            local func = caller[1]
            table.remove(caller, 1)
            table.insert(caller, next)
            func(table.unpack(caller))
        end
    end
    next()
end

function async.next( n )
    if n then n() end
end

return async