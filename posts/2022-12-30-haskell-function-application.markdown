---
title: (Vi) Haskell function application
author: lk
tags: haskell, function application
---

## Function application ($)

Hãy check thử thông tin của `($)` trong `ghci`
```haskell
Prelude> :info ($)
($) :: (a -> b) -> a -> b       -- Defined in ‘GHC.Base’
infixr 0 $
```

Khi bắt đầu học haskell, chúng ta thường thắc mắc tại sao `($)` lại được sử dụng khá phổ biến khi code.
Hãy xét một vài ví dụ: [dòng 152](https://github.com/ahaxu/simple-telegram-bot/blob/master/src/EmaImproved.hs#L152), [hoặc dòng 104](https://github.com/ahaxu/simple-telegram-bot/blob/master/src/EmaImproved.hs#L104).

Chúng ta có thể thấy `($)` là một cách viết khác tương đương với việc gôm các biểu thức tính toán vào trong cặp dấu `(` và `)` (**chú ý *không phải là unit type `()`* **) để gôm thứ tự tính toán(*evaluation*) các biểu thức lại với nhau từ trong ra ngoài.

Xét ví dụ sau:

```haskell
-- một cách viết khác của hàm add
addInteger :: Integer -> Integer -> Integer
addInteger = (+)

-- một cách viết khác của hàm even
isEven :: Integer -> Bool
isEven = even

-- combine 2 hàm lại với nhau
combineFunc :: Integer -> Integer -> Bool
combineFunc a b = isEven (addInteger a b) -- (1)
```

Vì type của `($)` là:

```haskell
($) :: (a -> b) -> a -> b       -- Defined in ‘GHC.Base’
-- có thể diễn giải như sau, sau $ sẽ là một hàm số và các tham số của hàm số đó
```

Cho nên ta có hàm `combineFunc` được viết lại như sau:

```haskell
combineFunc a b = isEven $ addInteger a b -- (2)
```

như thế, chúng ta đã hiểu được ý nghĩa của `($)`, hi vọng chúng ta sẽ học haskell dễ hơn &#129395;.

Mở rộng ra một xíu, tại sao hàm `combineFunc` lại có thể được viết tương đương thế này:

```haskell
combineFunc = (isEven .) . addInteger -- (3)
```

**hint**: bằng cách sửa dụng **function composition** và kỹ thuật **pointfree** trong haskell, chúng ta có thể biến đổi được tương đương từ `(2)` sang `(3)`

## Tham khảo
- [4. Haskell function composition, áp dụng vào bài tập liên quan đến list
](https://youtu.be/cucVyKgeMyI) 

