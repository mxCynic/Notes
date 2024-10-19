## deriving (Show)
value constructors are function .so we can map them and partially apply them and everything.
##  Algebraic data types intro

##  Record syntax
just like this
~~~
data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String
                     } deriving (Show)
~~~

## Type parameters
[don't put type constraints into data declarations even if it seems to make sense, because you'll have to put them into the function type declarations either way.](https://learnyouahaskell.com/making-our-own-types-and-typeclasses#:~:text=don%27t%20put%20type%20constraints%20into%20data%20declarations%20even%20if%20it%20seems%20to%20make%20sense%2C%20because%20you%27ll%20have%20to%20put%20them%20into%20the%20function%20type%20declarations%20either%20way.)
这告诉我们，在定义类型的时候，不需要进行type constraints。因为我们定义函数的时候会type constraints
~~~
data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i + l) (j + m) (k + n)
~~~

### 类型构造函数(type constructor)和值构造函数(value constructor)有什么区别？
上一段代码中的类型定义中。等号左边是type constructor，而右边是value constructor
我们在声明新的变量的时候是使用的value constructor.返回的是一个Vector a的对象，我们在新的函数中声明这个对象的时候是用的type constructor来规定。而不是value.

## Derived instances
有以下种类
```
deriving (Eq, Ord, Show, Read, Bounded, Enum)
```
## Type synonyms
比如String
```
ghci> :i String 
type String :: *
type String = [Char]
  	-- Defined in ‘GHC.Base’
```

kjjj

## Typeclasses 102
So _**class_ i**s for defining new typeclasses , **data i**s for defining new class and **_instance_** is for making our types instances of typeclasses.
## Kinds and some type-foo
types are the labels of values and kinds are the labels of types and there are parallels between the two.