---
id: DiffList
aliases: []
tags: []
---

DiffList which is called Difference List. is a way to accelerate list append.

## definition
```
newtype DiffList a = DiffList {getDiffList :: [a] -> [a]}

instance Semigroup (DiffList a) where
  (DiffList f) <> (DiffList g) = DiffList (\xs -> f (g xs))

instance Monoid (DiffList a) where
  mempty = DiffList{getDiffList = \xs -> [] ++ xs}

instance (Show a) => Show (DiffList a) where
  show (DiffList f) = show (f [])

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs ++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

```

## how it works?

First, let's see how the ++ definition:
```
(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x:xs) ++ ys = x ++ (xs ++ ys)
```

The list works like this 
```
[1, 2] ++ [3, 4] ++ [5, 6]
[1, 2, 3, 4] ++ [5, 6]
[1..6]
```

But the DiffList works like:
```
([1, 2] ++ ) ([3, 4] ++) ([5, 6]++)
([1, 2] ++ ) ([3,,6]++)
[1..6]++
```

## Summarize

for N list , each list' length is $A_i(i=0, 1\dots n)$the total times is 
$$
times = \sum_{i=0}^n(n-i)A_n
$$
but for DiffList, the total times is 
$$
times = 2n
$$
