> module HskStart where

非柯里化函数(uncurried function)是一种函数类型。
当函数有多个参数时,必须通过元组一次性传入,然后返回结果,这样的函数就是非柯里化的函数。

> uncurriedFn :: (Int, Int) -> Int
> uncurriedFn (a, b) = a - b

柯里化函数(curried function)也是一种函数。
当函数有多个参数时,参数可以一个一个地依次输入,如果参数不足,将返回一个函数作为结果,这样的函数就是柯里化的函数。

> curriedFn :: Int -> Int -> Int
> curriedFn a b = a - b
