---
title: (En) Comparision of functor, applicative and monad 
author: lk
tags: haskell, monoid, monad, functor, applicative
---

![](../images/2022-12-07-recap.png)

## Outline

We will dicuss about the relationship between each type class (monoid, functor, applicative, and monad).
You can discover more with the links to the relevant videos as bellow (English videos coming soon).

- [Introduction to haskell type class](https://youtu.be/I48P7LY1LHk)
- [Monoid](https://youtu.be/DurtGLmG1qc)
- [Functor](https://youtu.be/pqkNBKiYOY8)
- [Applicative](https://youtu.be/h2pVUDLL82g)
- [Monad](https://youtu.be/LhGxO9-tKzg)


## Review about type signature of `($)`, `(<>)`, `(<$>)`, `(<*>)`, `(>>=)` or flip bind `(=<<)`

- Function application `($) :: (a -> b) -> a -> b`
![](../images/2022-12-07-value-apply.png)

let's say that function `f` has signature `f :: a -> b`, we have these equivalent transformations as below

```
f             :: a -> b
f a           :: b                  -- apply f to a
(a -> b) -> a :: b                  -- replace f with (a -> b)
($)           :: (a -> b) -> a ->b
```

In fact, we see lots of block of code as below

```
print $ show a
```

- Monoid (mappend function) `(<>) :: Semigroup m => m -> m -> m`
![](../images/2022-12-07-monoid-illustration.png)

We see that `(<>)` or `mappend` receive 2 params which have the same type (structure), and return the result which also keep the original structure (type)

```
putStrLn $ "hello" <> " " <> "world!"
```

- Functor (fmap function) `(<$>) :: Functor f => (a->b) -> f a -> f b`

![](../images/2022-12-07-fmap.png)

```
(\x -> x * 2) <$> [1..2]

getSum $ fold $ Sum <$> [1..5]
```

- Applicative `(<*>) :: Applicative k => k (a -> b) -> k a -> k b`
![apply function](../images/2022-12-07-applicative-just.png)

```
pure (\x -> x * 2) <*> [1..2]

getSum $ fold $ pure Sum <*> [1..5]
```

- Monad (bind function) `(>>=) :: Monad m => m a -> (a -> m b) -> m b`
![](../images/2022-12-07-monad-chain.png)

In real life, we see many computation cases that need to take value `a` out of the computation context (or take value `a` out of any context(structure) which denoted as `m`)

The sample bellow, illustrate the case that we need to take a value `a` out of `Maybe` structure, and *then* calling `(+)` function for a sum computation, and *then* put the result value into `Maybe` structure.

```
maybePlus :: Maybe Int -> Maybe Int -> Maybe Int
maybePlus ma mb =
  case ma of
    Nothing -> Nothing
    Just a ->
      case mb of
        Nothing -> Nothing
        Just b  -> Just (a + b)

-- helper function
andThen :: Maybe a -> (a -> Maybe b) -> Maybe b
andThen ma f =
  case ma of
    Nothing -> Nothing
    Just a  -> f a

-- using helper function to refactor
maybePlus' :: Maybe Int -> Maybe Int -> Maybe Int
maybePlus' ma mb = ma `andThen` \a -> mb `andThen` \b -> Just (a + b)
```

## Relation between `($) (<>) <*>`
```
($)   ::   (a -> b)   ->   a ->   b
(<>)  :: f            -> f   -> f 
(<*>) :: f (a -> b)   -> f a -> f b
```
We can see that `(<*>)` indeed is the combination of `($)` and `(<>)`
 
## Relation between `<$> (=<<)`
```
(<$>) :: (a -> b)  -> f a -> f b

(=<<) :: (a-> m b) -> m a -> m b
```

We can see that flip bind function `(=<<)` is the combination in order of `fmap` and `join :: Monad m => m (m a) -> m a` function. You can read more about the equivalent transformations [here](https://gitlab.com/ahaxu/haskell-tutorial-vietnamese/-/blob/master/overview/8_monad.md#ch%E1%BB%A9ng-minh-join-fmap)(_english version coming soon, but i hope that you can understand the equivalent transformations_)

## Link to youtube video

- [https://youtu.be/ckUVRGETbbY](https://youtu.be/ckUVRGETbbY)

## Ref

- [Monad tutorial in Vietnamese](https://gitlab.com/ahaxu/haskell-tutorial-vietnamese/-/blob/master/overview/8_monad.md)
- Credit to [adit.io](https://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html) about pictures about functors, applicative and monad
- [Of Algebirds, Monoids, Monads, and other Bestiary for Large-Scale Data Analytics](https://www.michael-noll.com/blog/2013/12/02/twitter-algebird-monoid-monad-for-large-scala-data-analytics/#what-is-a-monoid)
