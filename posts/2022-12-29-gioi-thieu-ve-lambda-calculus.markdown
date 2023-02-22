---
title: (Vi) Giới thiệu về lambda calculus
description: (Vi) Giới thiệu về lambda calculus
author: lk
tags: lambda calculus
keywords: lambda calculus
cover_image: https://ahaxu.github.io/images/2022-08-28-hello-world-kyxuan.jpg
---

## Outline
- Giới thiệu về **Lambda calculus** 

## Giới thiệu về lambda calculus 

### Lambda structure

```
λ x . x
^─┬─^
  └────── the extent of the head of the lambda.
λ x . x
  ^────── the single parameter of the function. This
          binds any variables with the same name
          in the body of the function.
λ x . x
      ^── body, the expression the lambda returns
          when applied. This is a bound variable.
```

### Beta reduction

Khi chúng ta áp dụng hàm số cho một tham số nào đó, chúng ta thay thế input cho toàn bộ các bound variables trong body của lambda.
Sau đó, chúng ta còn có thể bỏ phần head của lambda đi. 
Vì phần head của biểu thức lambda nó cho biết các biến nào được bound (móc) vào lambda.
Quá trình này được gọi là beta reduction.

Để rõ hơn, chúng ta cùng xét ví dụ sau:

Giả sử chúng ta có hàm số 
```
𝜆𝑥.𝑥
```
hàm số trên rất quen thuộc, nó là hàm **identidy**, nhận vào một tham số `x` bất kỳ nào, thì cũng trả về chính `x`

Chúng ta sẽ thử làm **beta reduction** với số `2`. Chúng ta áp dụng hàm số trên cho số `2`, thay `2` vào từng **bound variable** (dựa vào phần head) trong thân hàm (body), sau đó chúng ta bỏ phần **head**. Chúng ta sẽ được kết quả là `2`

```
# Áp dụng hàm số với giá trị 2
(𝜆𝑥.𝑥) 2 
# kết quả sau cùng 
2
```

- Nested lambda 

```
𝜆𝑥𝑦.𝑥𝑦
```

tương đương với

```
𝜆𝑥.(𝜆𝑦.𝑥𝑦)
```

## Tài liệu tham khảo

- [Haskell Programming from First Principles](https://www.goodreads.com/en/book/show/25587599-haskell-programming-from-first-principles)
