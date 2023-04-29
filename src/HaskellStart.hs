{-#LANGUAGE BinaryLiterals #-}
{-#LANGUAGE ParallelListComp#-}
module HaskellStart where
import qualified Data.Word as Data-- Haskell常用类型
import Data.Complex ( Complex )

boolValue :: Bool
boolValue = True -- False
charValue :: Char
charValue = 'C'
intValue :: Int
intValue = 23
unsignedValue :: Data.Word
unsignedValue = 1

{- 与 Int 不同,Integer 类型可以表示任意大小的整数,限制它的大小范围的唯一因素就是计算机的内存。-}

-- 八进制
v8 = 0o12
-- 十六进制
v16 = 0x3a
-- 二进制
vb = 0b11111111
-- Float
vf :: Float
vf = 0.1
-- Double
vd :: Double
vd = 0.12
{- String => [Char] -}
vs :: String
vs = "string"
-- tuple 元组
vtuple :: (Int, Double)
vtuple = (1, 1.0) 

{- 
函数类型
函数可以理解为从参数到结果的一个映射, 如 T1 -> T2。每一个函数都符合这样一
个定义,只不过是 T1 或 T2 可能代表着更复杂的类型,可能是一些其他特殊的类型,也可
能是一些函数类型,T1 或 T2 若为函数,那么 T1->T2 函数可以称为高阶函数(higher order
function)。
-}

{- 
非柯里化函数(uncurried function)是一种函数类型。
当函数有多个参数时,必须通过元组一次性传入,然后返回结果,这样的函数就是非柯里化的函数。
-}

uncurriedFn :: (Int, Int) -> Int
uncurriedFn (a, b) = a - b

{- 
柯里化函数(curried function)也是一种函数。
当函数有多个参数时,参数可以一个一个地依次输入,如果参数不足,将返回一个函数作为结果,这样的函数就是柯里化的函数。
-}

curriedFn :: Int -> Int -> Int
curriedFn a b = a - b

{- 
Haskell 还有另外一种书写函数的格式,与函数的类型相互对应,这就是 λ 表达式
函数类型 :: 参数 1 的类型-> 参数 2 的类型-> ... 结果的类型
函数名 = \参数 1 -> \参数 2 -> ... -> 函数体
-}

lambda = (\x -> \y -> x y) abs (-5)
simplifyLambda = (\x y -> x y) abs (-8)

-- => 是类型类的限定符号,


{- 
类型的别名 

在 Haskell 中,可以用 type 关键字将这些复杂的类型替换成为其他简单的名字,在定义时类型的名字要以大写字母开头。

-}
type RGB = (Int, Int, Int)

{-
Haskell 给很多“类型”分成了“类型类”,归为一类的类型有着共同的属性,不同类型
所归的类就称为类型类。类型有着某种属性,意为该类型可以实现特定的函数,类型通过实
现类型类中声明的函数来成为其中的一份子
-}

-- 类型转换

doubleFromInterger = fromInteger 4 :: Complex Double

-- 那些没有给出所有参数的函数应用称为函数的不完全应用(partial application,有时译为偏函数调用),这是柯里化函数的灵活之处。
{- 
当有多个类型类限定在一个类型上的时候,
它们需要用括号写在一起,
并且中间要用逗号隔开,
或者像柯里化那样使用 => 依次连接,这并不是 Haskell 98 标准。
-}

function :: (Show a, Ord a) => a -> a -> a 
function a b = 
  a where
    {
      print a
      print b
      k = a
    }

fn :: Show a => Ord a => a -> a -> a
fn a b = a

-- Heron's formula

s :: Double -> Double -> Double -> Double
s a b c = 
  let p = (a + b +c) / 2
  in sqrt (p * (p - a) * (p - b) * (p - c))

{-
1. let .. in ..
2. where
-}

sV2 :: Double -> Double -> Double -> Double
sV2 a b c = 
  sqrt (p * (p - a) * (p - b) * (p - c))
  where p = (a + b + c) / 2

-- let..in.. 绑定要注意命名捕获(name capture)
-- 如果定义一个函数,用了 where 绑定,那么它在函数的全部的范围都是有效的。

{- Haskell的表达式 -}

-- 条件表达式
{- 
Haskell 里的 if..then..else 顺序式编程语言有些不同,
就是else后的表达式不可省略。
-}
isThree :: Int -> String 
isThree a = if a == 3 then "True" else "False"

{-
情景分析表达式

case ..of ..
-}

month :: Int -> Int
month n = 
  case n of
    1 -> 31
    2 -> 28
    9 -> 30
    10 -> 31
    _ -> error "invalid month"


{- guarded expression => 守卫模式 -}

abs' :: (Num a, Ord a) => a -> a
abs' n
  | n > 0 = n
  | otherwise = -n


{- pattern match => 模式匹配 -}
month' :: Int -> Int
month' 1 = 31
month' 2 = 28
month' 3 = 31
month' 4 = 30
month' _ = error "invalid month"

{-
运算符,如加号、减号等,实质上是与函数是一样的。这里所说的运算符
指的是所有的运算符,因为 Haskell 所有的运算符都是基于函数定义的。例如,(+) (-) (*)
其实是有着同样类型的函数,它们的都是 Num a => a -> a -> a。而 (/) 略有些特殊,它的
类型是 Fractional a => a -> a -> a,即所有参数都会被转换成小数进行运算。
-}

{-
运算符可能有 3 种属性,即优先级(precedence)、 结合性(associativity)和位置(fixity)
在 Haskell 中,运算符号有 0 ∼ 9,共十个优先级。
结合性又分为左结合性、右结合性、无结合性。
根据位置又可分为前缀、中缀和后缀运算符,一般使用的函数常常可以理解为前缀运算符。
-}

-- (!!) 从一个列表中取出第 n 个元素(从 0 开始)
one = [1,2] !! 1 :: Int
lsAdd = 0 : [1, 2] :: [Int]
lsConcat = [0,7] ++ [1,2] :: [Int]

{- module import -}
{-
module XXX where
module XXX (a, b) where
-}

{-
import XXX (a, b)
import XXX hiding (e) // hiding 关键字将它们的定义隐藏
-}

-- 可以使用 qualified 关键字来对不同的模块命名
-- import qualified Test as T

{- bubble sort -}
-- swap
swap :: Ord a => [a] -> [a]
swap [] = []
swap [x] = [x]
swap (x1:x2:rest) 
  | x1 > x2 = x2 : swap (x1 : rest)
  | otherwise = x1 : swap (x2 : rest)

bsOne :: Ord a => [a] -> [a]
bsOne xs  | swap xs == xs = xs
          | otherwise = bsOne $ swap xs

bsTwo :: Ord a => [a] -> [a]
bsTwo [] = []
bsTwo xs = bsTwo initialElems ++ [lastElem]
  where swappedxs = swap xs
        initialElems = init swappedxs
        lastElem = last swappedxs

bs :: Ord a => [a] -> [a]
bs xs = 
  if swappedxs == xs then xs else bs swappedxs 
  where swappedxs = swap xs

{- 列表内包 -}

-- 列表生成器
lg = [x ^ 2| x <- [1..10]]

map' f xs = [f x | x <- xs]

-- list filter
fliter' f xs = [x | x <- xs,even x, f x]

length' xs = sum [1 :: Int | x <- xs]
-- 通过添加扩展ParallelListComp
zip' xs1 xs2 = [(x, y) | x <- xs1 | y <- xs2] 

{- composite function -}
-- 数学中常常用到复合函数(composite function)运算将两个函数复合在一起

fx x = x * x
f x = x + 1 
h x = f (fx x)
-- 复合运算函数符号 .
h' = f.fx
-- >>
h'' = fx >> f