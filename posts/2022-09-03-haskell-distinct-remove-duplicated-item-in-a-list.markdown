---
layout: post
title: Haskell `distinct` function to remove duplicated item in a list
author: lk
---

Assume that we need to write a function to remove duplicated item in a list as code snippet bellow

```bash
~> let xs = [1..5] ++ [2..9]
~> xs
[1,2,3,4,5,2,3,4,5,6,7,8,9]

~> distinct1 xs
[1,2,3,4,5,6,7,8,9]

~> distinct2 xs
[1,2,3,4,5,6,7,8,9]

~> distinct3 xs
[1,2,3,4,5,6,7,8,9]

~> distinct4 xs
Logger ["inserting 1","inserting 2","inserting 3","inserting 4","inserting 5","2 duplicated","3 duplicated","4 duplicated","5 duplicated","inserting 6","inserting 7","inserting 8","inserting 9"] [1,2,3,4,5,6,7,8,9]
```

If you are rush to see how hell the code is ^^, here is the link to replit.co <a href="https://replit.com/@longnguyen207/AhaxuBlog1?v=1" target="_blank">https://replit.com/@longnguyen207/AhaxuBlog1?v=1</a>


## Recursive with accumulated list

```haskell
distinct1
  :: (Ord a)
  => [a]
  -> [a]
distinct1 as = 
  go as [] 
  where 
    go [] acc = acc
    go (a:as) acc 
      | a `elem` acc = go as acc
      | otherwise = go as (acc++[a])
```

## Using `fold`

```haskell
distinct2
  :: (Ord a)
  => [a]
  -> [a]
distinct2 =
    foldl
      (\acc a ->
        if a `notElem` acc
        then acc ++ [a]
        else acc
      )[]
```

## Using `StateT` monad

In case we want to use `Set` utilities to stored and handle those existed item of a list

There is a function `filterM` from `Control.Monad`

```haskell
filterM :: Applicative m => (a -> m Bool) -> [a] -> m [a]`
```

for learning purpose, we will rewrite as `filterM2` as below:
```haskell
filterM2
  :: Applicative f
  => (a -> f Bool)
  -> [a]
  -> f [a]
filterM2 p =
  foldr 
    (\a facc -> 
      liftA2
        (\b acc -> 
          if b 
          then (a:acc) 
          else acc)
        (p a)
        facc
    )
    (pure [])
```
and the `distinct3` function using `StateT`

```haskell
distinct3
  :: (Ord a)
  => [a]
  -> [a]
distinct3 as =
  let
    rs = filterM2 (
      \a -> StateT $ 
        \s -> Identity $ 
          if Set.notMember a s 
          then (True, Set.insert a s) 
          else (False, s)) as
  in fst $ runState rs Set.empty
```

## In case we want to log each step we do

```haskell
distinct4
  :: (Ord a, Show a)
  => [a]
  -> Logger String [a]
distinct4 as =
  let
    rs = filterM2 (\a -> StateT $ \s -> 
        let
          (l,bs)  | Set.notMember a s = ("inserting " ++ show a, (True, Set.insert a s))
                  | otherwise        = (show a ++ " duplicated", (False, s))
        in Logger [l] bs) as
  in evalStateT rs Set.empty
```

And, Logger data type defined as
```haskell
-- implement logger for logging
data Logger l a = 
  Logger [l] a
  deriving(Show, Eq, Ord)

instance Functor (Logger l) where
  fmap 
    :: (a -> b) 
    -> Logger l a 
    -> Logger l b
  fmap f (Logger l a) = Logger l $ f a

instance Applicative (Logger l) where
  pure a = Logger [] a

  (<*>)
    :: Logger l (a -> b) 
    -> Logger l a 
    -> Logger l b
  (<*>) (Logger l1 f) (Logger l2 a) = Logger (l1++l2) $ f a

instance Monad (Logger l) where
  return = pure
  (>>=) 
    :: Logger l a 
    -> (a -> Logger l b) 
    -> Logger l b
  (>>=) (Logger l1 a) f =
    let Logger l2 b =  f a
    in Logger (l1++l2) b
```

Try with ghci [repl.it](https://replit.com/@longnguyen207/HarmlessSteelblueDownloads#distinct.hs)
```bash
~> let xs = [1..5] ++ [2..9]
~> xs
[1,2,3,4,5,2,3,4,5,6,7,8,9]

~> distinct1 xs
[1,2,3,4,5,6,7,8,9]

~> distinct2 xs
[1,2,3,4,5,6,7,8,9]

~> distinct3 xs
[1,2,3,4,5,6,7,8,9]

~> distinct4 xs
Logger ["inserting 1","inserting 2","inserting 3","inserting 4","inserting 5","2 duplicated","3 duplicated","4 duplicated","5 duplicated","inserting 6","inserting 7","inserting 8","inserting 9"] [1,2,3,4,5,6,7,8,9]
```

## More about StateT

_TODO

## Final thoughts

_TODO

`StateT` help us to **stack** `State` action within other monads which need temporary variable to deal with complex computation.


## Reference

_TODO
