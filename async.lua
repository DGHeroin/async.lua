-- MIT License
-- Blake@github.com/DGHeroin/async.lua

local async = {}
local unpack = unpack or table.unpack

function async.waterfall(tasks, resultCb)
    local nextArg = {}
    local next
    local error
    resultCb = resultCb or function () end

    next = function()
        if #tasks == 0 then
            if resultCb then
                resultCb(error, unpack(nextArg))
            end
            resultCb = nil
            return
        end
        if error then
            tasks = {} -- 清空序列
            resultCb(error, unpack(nextArg))
            return
        end
        local err = nil
        local v = table.remove(tasks, 1)
        v(function(err, ...)
            local arg = {...}
            nextArg = arg
            if err then
                error = err
            end
            next()
        end, unpack(nextArg))
    end
    next()
end

function async.parallel(tasks, resultCb)
    local count = 0
    local result = {}
    resultCb = resultCb or function () end
    local function invokeFinal(err)
        if not resultCb then return end
        resultCb(err, result)
        resultCb = nil
    end
    local function invoke(i, task)
        task(function (err, ...)
            count = count + 1
            local args  = {...}
            result[i] = args
            if err then -- 终止
                invokeFinal(err)
                return
            end
            if count == #tasks then
                invokeFinal()
            end
        end)
    end
    for index, value in ipairs(tasks) do
        invoke(index, value)
    end
end


return async
