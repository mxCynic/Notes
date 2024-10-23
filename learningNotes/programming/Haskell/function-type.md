---
id: function-type
aliases: []
tags: []
---

function-type is (->) r
it'a a Funcor, Applicative and Monad


## definition:
[from](https://hackage.haskell.org/package/ghc-internal-9.1001.0/docs/src/GHC.Internal.Base.html#:~:text=%2D%2D%20%7C%20%40since%20base%2D2.01%0Ainstance%20Functor%20((%2D%3E)
```
-- | @since base-2.01
instance Functor ((->) r) where
    fmap = (.)

-- | @since base-2.01
instance Applicative ((->) r) where
    pure = const
    (<*>) f g x = f x (g x)
    liftA2 q f g x = q (f x) (g x)

-- | @since base-2.01
instance Monad ((->) r) where
    f >>= k = \ r -> k (f r) r

```
## Funcor

let us see how it works like Functor
```
-- in this case, f is the same as r -> (also is (->) r)
fmap :: (a -> b) -> f a -> f b
-- so the type also signation as:
fmap :: (a -> b) -> (r -> a) -> (r -> b)
famp = (.)
```
for example:
```
ghci> (+3) <$> (+3) $ 2
8
```

## Applicative

```
pure :: Applicative f => a -> f a
pure :: a -> (r -> a)
pure x = \_ ->
--it works like const

(<*>) :: Applicative f => f (a -> b) -> f a -> f b
(<*>) :: (r -> (a -> b)) - > (r -> a) -> (r -> b)
f <*> g = \x -> (f x ) (g x)
```

for example:
```
ghci> (+) <*> (*2) $ 3
9
-- 9 = 3 + (3 * 2)
```
## important exampe
```
ghci> (+) <$> (*2) <*> (+10) $ 3
19 
-- 19 = (3 * 2) + (3 + 10)
```
how it works? let us see the type of it
```
(+) <$> (*2) <*> (+10) $ 3

(a -> a -> a) <$> (a -> a) <*> (a -> a) $ a

-- <$> works like this:
-- <$> :: (a -> (a -> a)) -> (r -> a) -> (r -> (a -> a))
-- Here, we say (a -> a) is b which means
-- <$> :: (a -> b) -> (r -> a) -> (r -> b)
-- and (r ->) is f
-- <$> :: (a -> b) -> f a -> f b
-- This is a familiar look

-- so, we get f b which is (a -> a -> a)
(a -> a -> a) <*> (a -> a) $ a

-- <*> ::  (r -> a -> a) -> (r -> a) -> (r -> a)
-- we just say (r ->) is f
-- <*> ::  f(a -> a) -> f a -> f a
-- <*> ::  f(a -> b) -> f a -> f b

-- so we get f b which is (a -> a)

(a -> a) $ a
```

wait, wait, wait!  
we calculate a function, it's type is a -> a
So, We are still confused about why we put 3 to (*3) and (+10) first, and than use (+) to connect them
It seems that 3 is passed twice as a parameter.

The magic is <*>
which is:

```
(<*>) :: Applicative f => f (a -> b) -> f a -> f b
(<*>) :: (r -> (a -> b)) - > (r -> a) -> (r -> b)
f <*> g = \x -> (f x ) (g x)
```

It meas, get x, put it to f, and put it to g, and than f x be a Unary Function, g x be a value.
in the code we get:
```
(a -> a -> a) <*> (a -> a) $ a
-- the first one is \x -> x * 2 +
-- the second one is \x -> x +10


```
