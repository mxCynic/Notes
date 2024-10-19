我们指的是Functor Applicative and Monad三种抽象
## 三者是super Class和sub Class的关系
```
SuperClass(超类) ---------->->->->->-> SubClass(子类)
Functor ---> Applicative ---> Monad
```
## minimal complete definition 
```
class Functor f where
  fmap :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f a
  (<$) = fmap . const -- 这里是<$的默认实现，我们在编写实例时，只需要写famp实例即可

class Functor f => Applicative f where
  pure :: a -> f a 
  (<*>) :: f (a -> b) -> f a -> f b 
  liftA2 :: (a -> b -> c) -> f a -> f b -> f c
  (*>) :: f a -> f b -> f b
  (<*) :: f a -> f b -> f a

class Applicative m => Monad m where 
  return :: a -> m a
  (>>) :: m a -> m b -> m b
  (>>=) :: m a -> (a -> m b) -> m b
```

## 实例时注意：
如果只是一个Functor实例，那么就只需要实现fmap，如果是Applicative的实例，则对应的Functor的fmap可以写成：
```
fmap f x = pure f <*> x
```
同时也需要实现Applicative的pure和<\*>

而对于一个Monad实例，我们在实现了他的Super Class的实例后，不需要额外实现return，这是因为:
```
return :: a -> m a
return = pure
```
[相关参考文献](https://gitlab.haskell.org/ghc/ghc/-/wikis/proposal/monad-of-no-return)
在这个谈论中，有提到我们对一个monad实例的最小定义如下
```
instance Functor Foo where
    fmap g foo  = …

instance Applicative Foo where
    pure x      = …
    a1 <*> a2   = …

instance Monad Foo where
    m >>= f     = …
```
## instance for Writer‘
```
newtype Writer' w a = Writer' {runWriter' :: (a, w)} deriving (Show)

instance (Monoid w) => Functor (Writer' w) where
  fmap f x = pure f <*> x

instance (Monoid w) => Applicative (Writer' w) where
  pure x = Writer' (x, mempty)
  Writer' (f, y1) <*> Writer' (x, y2) = Writer' (f x, y1 `mappend` y2)

instance (Monoid w) => Monad (Writer' w) where
  (Writer' (x, v)) >>= f =
    let (Writer' (y, v')) = f x
     in Writer' (y, v `mappend` v')
```
