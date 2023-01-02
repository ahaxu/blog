---
title: (Vi) Partial application và curry trong haskell
author: lk
---

## Outline
- Function `(->)`, **partial application** và **curry** trong haskell

## Function (->) và partial application

```haskell
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

Dựa theo *type constructor* của hàm `(->)`, chúng ta có thể thấy được rằng kỹ thuật `curry` là mặc định trong haskell. Bởi vì `(->)` được định nghĩa `infixr -1`

**curry** là gì trong tiếng anh &#129300; ?
<img src="https://images.immediate.co.uk/production/volatile/sites/30/2020/08/113777-0b21d44.jpg" alt="curry">

Bởi vì nó associative hướng về phải, cho nên ta có thể thêm dấu ngoặc tròn cho các biểu thức bên dưới: 

```haskell
a -> a -> a -- (1)
```
thêm ngoặc thì sẽ trở thành 
```haskell
a -> (a -> a) -- (2)
```


và đối với hàm map cho list
```haskell
(a -> b) -> [a] -> [b] -- (3)
```
thì tương đương với
```haskell
(a -> b) -> ([a] -> [b]) -- (4)
```

Một ví dụ khác, với phép cộng 2 số nguyên lớn như sau, vì `(->)` có tính chất *right associative*, dịch nghĩa là kết hợp theo hướng bên phải. Cho nên chúng ta có thể biến đổi tương đương như sau:
```haskell
addStuff :: Integer -> Integer -> Integer   -- (5)
addStuff :: Integer -> (Integer -> Integer) -- (6)
```

Chúng ta có thể diễn giải lại biểu thức (6) như sau:
- Hàm `addStuff` nhận vào một tham số kiểu `Integer`
- Sau đó trả về 1 hàm số, mà, hàm số đó lại nhận một tham số bất kỳ kiểu `Integer` và trả về kết quả kiểu `Integer`.

Với biểu thức (6), việc partial apply (apply từng phần) hàm `addStuff` cho tham số thứ 1 kiểu `Integer`, chúng ta sẽ được một hàm số mới với các tham số còn lại chưa được thay thế. Chúng ta gọi đây là **partial application**, hay là **currying**, tức là thay thế từng tham số của hàm số, để được một hàm số mới hơn và các tham số còn lại.

Thao tác này, có thể hình dung thực tế khi nấu ăn, các cắt củ hành (onion) để nấu món curry.
<img src="https://i.insider.com/61fbfdab40ce96001ab19bf2?width=750&format=jpeg&auto=webp" alt="chop onion">

Như thế chúng ta có thể thấy, `curry` là mặc định và hiển nhiên trong **haskell**. Hiểu được khái niệm `curry` hay `partial application` sẽ giúp chúng ta học haskell một cách dễ dàng hơn.

## Tài liệu tham khảo

- [Haskell Programming from First Principles](https://www.goodreads.com/en/book/show/25587599-haskell-programming-from-first-principles)
