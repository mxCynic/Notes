---
id: Foldable
aliases: []
tags: []
---

## Typeclass Foldable
为数据结构实现 Foldable 的 instance 只需要一个函数: foldMap 和 foldr 任选其一即可.
然而, Foldable, 定义了许多其它函数:
```
-- 简便起见, 我们这里只写出类型.
class Foldable t where
    foldMap :: Monoid m => (a -> m) -> t a -> m
    foldr :: (a -> b -> b) -> b -> t a -> b

    -- 以下函数都有默认实现:
    fold :: Monoid m => t m -> m -- mconcat 的推广
    foldr' :: (a -> b -> b) -> b -> t a -> b
    foldl :: (b -> a -> b) -> b -> t a -> b
    foldl' :: (b -> a -> b) -> b -> t a -> b
    foldr1 :: (a -> a -> a) -> t a -> a
    foldl1 :: (a -> a -> a) -> t a -> a
    toList :: t a -> [a]
    null :: t a -> Bool
    length :: t a -> Int
    elem :: Eq a => a -> t a -> Bool
    maximum :: Ord a => t a -> a
    minimum :: Ord a => t a -> a
    sum :: Num a => t a -> a
    product :: Num a => t a -> a
```
