# async.lua
### 为什么要用async.lua (why you need async.lua)

你可以使用async.lua来管理回调函数, 避免在callback hell里沉沦, 减少心智负担.

You can use async.lua to manage your callback functions, avoid sinking in callback hell, and reduce mental burden.

## async.waterfall

和你知道的waterfall一样

waterfall call as you know

```
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
    end
)
```
