---
title: (Vi) Monad trong haskell
description: Monad trong haskell
author: lk
tags: haskell, monad
keywords: haskell, monad
---

## Link youtube

- [8.1 Monad trong haskell](https://youtu.be/LhGxO9-tKzg "monad trong haskell")

## Từ cụ thể đến tổng quát hoá

Tham khảo [file](https://gitlab.com/ahaxu/haskell-tutorial-vietnamese/-/blob/master/overview/8_monad.hs)  

1. maybePlus

2. eitherPlus

3. listPlus

Chúng ta thấy các pattern sau:

```haskell
andThen   :: Maybe a      -> (a -> Maybe b)    -> Maybe b
andThen'  :: (Either e a) -> (a -> Either e b) -> (Either e b)
andThen'' :: [a]          -> (a -> [b])        -> [b]   
             [] a         -> (a ->   [] b)     -> [] b
```

Qua đó chúng ta có thể tổng quát hoá (generalization)

```haskell
bind  :: Monad m => m a -> (a -> m b) -> m b
(>>=) :: Monad m => m a -> (a -> m b) -> m b
```

Nếu chúng ta có thể viết ngược lại

`flip bind` hay `(=<<)`

```haskell
(=<<) ::   Monad m => (a -> m b) -> m a -> m b
fmap  :: Functor f => (a -> b)   -> f a -> f b (*)

```

Nếu ta thay
```haskell
    f = m
    b = m b'
```

vào (*)

```haskell
fmap  :: Functor f => (a -> m b') -> m a -> m (m b')
(=<<) ::   Monad m => (a -> m b)  -> m a -> m b

```

Nếu chúng ta có hàm số nào đó  `join :: m (m b') -> m b'`

```haskell
fmap :: Functor f =>    (a -> m b') -> m a -> m (m b')
join ::                                       m (m b') -> m b'
join (fmap) ::          (a -> m b') -> m a             -> m b'
```

Như thế, hàm **flip bind (=<<)** là sự kết hợp giữa `fmap` và `join`, có thể viết `(=<<) = (join .) . fmap` theo cách áp dụng function composition

Chứng minh `(=<<) = (join .) . fmap` 

```haskell
(=<<) f ma = join (fmap f ma)
(=<<) f ma = join ((fmap f) ma)   -- function application associates to the left
(=<<) f ma = join . (fmap f) ma   -- function composition  g ( h x) with g = join, h = (fmap f)
(=<<) f    = join . (fmap f)      -- pointfree on ma
(=<<) f    = (join .) (fmap f)    -- function application associates to the left
(=<<) f    = ((join .) . fmap) f  -- function composition g (h x), g = (join .), h = fmap
(=<<)      = (join .) . fmap      -- pointfree on f
(=<<)      = (join .) . fmap      -- QED
```      

Ngoài lý do tổng quát hoá, **Monad** còn có điểm gì khác hay không??

Xét đọan mã sau về hàm băm (md5 hash) đọc khóa bí mật từ file

Viết bằng ruby
```ruby
# pure
def integrity_checksum(input)
    Digest::MD5.base64digest(input)
end

# impure
def impure_integrity_checksum(input)
    k = File.read("~/.secret-key")
    Digest::MD5.base64digest(k+input)
end
```

Viết lại bằng haskell

```haskell
-- pure
integrityChecksum ::
  ByteString
  -> ByteString
integrityChecksum input = MD5.hash input

-- impure with explicit side effect
integrityChecksum' ::
  ByteString
  -> IO ByteString
integrityChecksum' input = 
  readFile "~/.secret-key"
    >>= \k ->
      pure (MD5.hash(k <> input))

-- desugar way, impure with explicit side effect
integrityChecksum'' ::
  ByteString
  -> IO ByteString
integrityChecksum'' input = do
    k <- readFile "~/.secret-key" 
    pure (MD5.hash(k <> input))
```

Như thế, chúng ta lường trưóc được rằng: hàm `integrityChecksum` sẽ có side effect.
Chúng ta sẽ tách bạch các hàm ko có **side effect** và các hàm có **side effect**, như thế khi code sẽ giảm thiêủ lỗi, code dễ đọc hơn. 

## Monad type class

```haskell
class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a
  {-# MINIMAL (>>=) #-}
```

## Monad laws
Mọi Monad instances phải thỏa mãn các luật sau:

- Left identity(đồng nhất trái):
```haskell
return a >>= h ≡ h a
```
- Right identity(đồng nhất phải):
```haskell
m >>= return ≡ m
```
- Associativity(tính kết hợp):
```haskell
(m >>= g) >>= h ≡ m >>= (\x -> g x >>= h)
```

Trong `Control.Monad`, chúng ta có 1 toán tử (`>=>`) goị là **monad-composition** hoặc là **Kleisli-composition operator** có signature như sau:

```haskell
infixr 1 >=>
(>=>)   ::
    Monad m =>
       (a -> m b)
    -> (b -> m c)
    -> (a -> m c)
f >=> g =
    \x -> f x >>= g
```

Như thế, tính chất kết hợp
```haskell
(m >>= g) >>= h ≡ m >>= (\x -> g x >>= h)
```

chúng ta có thể viết lại như sau:
```haskell
(m >=> g) >=> h ≡  m >=> (g >=> h)
```

## Cách hiểu nôm na, mù mờ và chưa đúng về monad
![Hiểu sai về monad trong haskell](../images/2022_08_28_monad_hieu_sai_ve_monad.png "hieu sai ve monad trong haskell").


## Tham khảo
- [Function application associates to the left](https://www.haskell.org/tutorial/functions.html)
- [Why Is Haskell So Hard To Learn? (And How To Deal With It) by Saurabh Nanda #FnConf19
](https://www.youtube.com/watch?v=JKJaD7E6WxE)
- [Haskell Beginners 2022: Lecture 4
](https://www.youtube.com/watch?v=12D4Y2Hdnhg)
- [https://wiki.haskell.org/Monad_laws](https://wiki.haskell.org/Monad_laws)

## TODO

- Inside IO monad !!
- Giải thích:
    **"A monad is just a monoid in the category of endofunctors, what's the problem?"**

- endofunctor category
- monoidal 

