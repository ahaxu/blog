---
title: (Draft) (Vi) Partial application và curry trong haskell
author: lk
---

## Outline
- Function `(->)`, partial application và curry trong haskell

## Function (->) và partial application

```
Prelude> :info (->)
type (->) :: * -> * -> *
data (->) a b
        -- Defined in ‘GHC.Prim’
infixr -1 ->
instance Applicative ((->) r) -- Defined in ‘GHC.Base’
instance Functor ((->) r) -- Defined in ‘GHC.Base’
instance Monad ((->) r) -- Defined in ‘GHC.Base’
instance Monoid b => Monoid (a -> b) -- Defined in ‘GHC.Base’
instance Semigroup b => Semigroup (a -> b) -- Defined in ‘GHC.Base’
```

Dựa theo *type constructor* của hàm `(->)`, chúng ta có thể thấy được rằng kỹ thuật `curry` là mặc định trong haskell. Bởi vì `(->)` là một `infix operator` và tính chất `right associative`.

`curry` là gì trong tiếng anh &#129300; ?
<img src="https://images.immediate.co.uk/production/volatile/sites/30/2020/08/113777-0b21d44.jpg" alt="curry">

Bởi vì nó associative phải, cho nên ta có thể thêm dấu ngoặc tròn như sau: 

```
a -> a -> a
```
-- thêm ngoặc thì sẽ trở thành 
```
a -> (a -> a)
```
-- và đối với hàm map cho list
```
(a -> b) -> [a] -> [b]
```
-- thì tương đương với
```
(a -> b) -> ([a] -> [b])
```

Một ví dụ khác, với phép cộng 2 số nguyên lớn như sau, vì `(->)` *right associative* cho nên chúng ta có thể biến đổi tương đương như sau:
```
addStuff :: Integer -> Integer -> Integer -- but with explicit parenthesization
addStuff :: Integer -> (Integer -> Integer)
```
Chúng ta có thể diễn giải như sau, hàm `addStuff` nhận vào một tham số kiểu `Integer`, sau đó trả về 1 hàm số, mà, hàm số đó lại nhận một tham số bất kỳ kiểu `Integer` và trả về kết quả kiểu `Integer`.

Như thế chúng ta có thể thấy, `curry` là mặc định và hiển nhiên trong haskell. Hiểu được khái niệm `curry` hay `partial application` sẽ giúp chúng ta học haskell một cách dễ dàng hơn.


## Tài liệu tham khảo

- [Haskell Programming from First Principles](https://www.goodreads.com/en/book/show/25587599-haskell-programming-from-first-principles)
