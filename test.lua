local async = require('async')

---- async call ----
function step1(a, b, c, next)
    print('step1', a, b, c)
    -- you may call the in some callback
    async.next(next)
end

local function step2(a, b, c, next)
    print('step2', a, b, c)
    async.next(next)
end

local function step3(a, b, c, next)
    print('step3', a, b, c)
    async.next(next)
end

async.call(
    {step1, 1, 2, 3},
    {step2, 4, 5, 6},
    {step3, 7, 8, 9})

---- water fall ----
async.waterfall({
    function (callback)
        callback(nil, 1, 2)
    end,
    function (callback, a, b)
        print(a, b)
        callback(nil, 3)
    end,
    function(callback, a)
        print(a)
        callback(nil, 4)
    end
    }, 
    function (err, result)
        if err then
            print('error:', err)
        else
            print(result)
        end
end)
