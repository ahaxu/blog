---
title: (Vi) So sánh functor applicative và monad 
author: lk
---


## Review về kiểu của các hàm `($)`, `(<>)`, `(<$>)`, `(<*>)`, `(>>=)` hay flip bind `(=<<)`

- Function application `($) :: (a -> b) -> a -> b`

Xét hàm số `f :: a -> b`, các phép biến đổi bên dưới là tương đương 

```
f             :: a -> b
f a           :: b              -- apply a vào f
(a -> b) -> a :: b              -- thay f bằng (a -> b)
($)           :: (a->b)->a->b   -- chuyển vế b 
```
Thực tế ta sẽ thấy các đoạn code sau
```
print $ show a
````

- Monoid `(<>) :: Semigroup m => m -> m -> m`

```
putStrLn $ "hello" <> " " <> "world!"
```

- Functor `(<$>) :: Functor f => (a->b) -> f a -> f b`

```
(\x -> x * 2) <$> [1..2]

getSum $ fold $ Sum <$> [1..5]
```

- Applicative `(<*>) :: Applicative k => k (a -> b) -> k a -> k b`

```
pure (\x -> x * 2) <*> [1..2]

getSum $ fold $ pure Sum <*> [1..5]
```

- Monad `(>>=) :: Monad m => m a -> (a -> m b) -> m b`

Ta thấy có nhiều trường hợp, cần phải lấy được giá trị `a` ra khỏi context tính toán nào đó (ký hiệu là `m`).

Ví dụ bên dưới minh hoạ về trường hợp chúng ta cần lấy giá trị `a` ra khỏi context `Maybe` sau đó dùng hàm `+` để tính tổng, sau đó để giá trị sau khi tính tổng vào lại trong context `Maybe`.

*chú ý: trong các bài viết thì chúng ta thường thấy thuật ngữ **monadic function**, ở đây chính là hàm `a ->  m b`, tức là một hàm số nhận vào một giá trị `a` (chưa nằm trong context tính toán nào, hoặc chưa nào trong một container nào có side effect), và trả về một giá trị `b` nào đó nằm trong context `m` nào đó.*
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

## Mối quan hệ giữa `($) (<>) <*>`
```
($)   ::   (a -> b)   ->   a ->   b
(<>)  :: f            -> f   -> f 
(<*>) :: f (a -> b)   -> f a -> f b
```
Ta có thể thấy rằng, `(<*>)` là sự kết hợp giữa `($)` và `(<>)`

## Mối quan hệ giữa `<$> (=<<)`
```
(<$>) :: (a -> b)  -> f a -> f b

(=<<) :: (a-> m b) -> m a -> m b
```

Ta có thể thấy rằng bản chất của flip bind `(=<<)` là sự kết hợp theo trình tự: hàm `fmap`(hay `(<$>)`) và sau đó là hàm `join :: Monad m => m (m a) -> m a`.


## Link tham khảo

- [Bài giảng về monad](https://gitlab.com/ahaxu/haskell-tutorial-vietnamese/-/blob/master/overview/8_monad.md)
