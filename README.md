# async.lua

## 为什么要用async.lua (why you need async.lua)

你可以使用async.lua来管理回调函数, 避免在callback hell里沉沦, 减少心智负担.

You can use async.lua to manage your callback functions, avoid sinking in callback hell, and reduce mental burden.

## 构建一个调用序列 (make a call sequence)
```
async.call(
  {
    function(name, next)
      print(name)
      async.next(next)
    end, 
    'my name'
  }, 
  {
    function(address, phone, next)
      print(address, phone)
      async.next(next)
    end, 
    'shenzhen china', '123456'
  }, 
)
```

## next 参数 (the next parameter)

next总是为最后一个参数, 这样不会破坏你原有的函数设计, 只需要在适合的时机调用async.next(next)

next is always the last parameter, so it will not affect your original function design, only need to call async.next(next) at the right time
