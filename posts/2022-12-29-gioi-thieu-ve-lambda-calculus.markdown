---
title: (Draft) (Vi) Giới thiệu về lambda calculus
description: (Draft) (Vi) Giới thiệu về lambda calculus
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
  └────── phần mở rộng của phần đầu của lambda.

λ x . x
  ^────── the single parameter of the function. This
          tham số duy nhất của hàm số. Tham số này móc (bind) bất kỳ
          tham số nào cùng tên trong phần thân (body) của hàm.

λ x . x
      ^── body, the expression the lambda returns
          phần thân, biểu thức mà lambda trả về khi hàm số được applied.
          Chúng ta gọi x là bound variable
```

### Beta reduction

Khi chúng ta **áp dụng** hàm số cho một **tham số** nào đó, chúng ta thay thế input cho toàn bộ các **bound variables** trong body của lambda.

Sau đó, chúng ta còn có thể bỏ phần **head** của lambda đi. 

Vì phần **head** của biểu thức lambda nó cho biết các biến nào được **bound (móc)** vào lambda.

Quá trình này được gọi là **beta reduction**.

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

Hãy cùng xem xét một ví dụ sau:

<img src="../images/2023-02-22-beta-reduction.png" alt="beta reduction" width="60%" height="60%">


### Nested lambda 

Xét vì mặt cú pháp hay ký hiệu

```
𝜆𝑥𝑦.𝑥𝑦
```

tương đương với

```
𝜆𝑥.(𝜆𝑦.𝑥𝑦)
```

### Function application

Bạn có thể đọc thêm về function application tại [đây](https://ahaxu.com/posts/2023-01-02-partial-application-va-curry-trong-haskell.html)

<img src="../images/2022-02-22-lambda-calculus-function-application.png" alt="lambda calculus" width="60%" height="60%">


### Free variable

Nếu chúng ta thấy **tham số(biến)** nào đó trong phần body của biểu thức lambda calculus, mà **không**  nằm trong phần head của biểu thức, thì ta gọi đó là  **biến tự do(free variable)**

ví dụ:
```
𝜆b.a -- a là free variable
```

### Combinator

1 biểu thức được gọi là combinator khi và chỉ khi hàm số hay body không tồn tại **biến tự do**

<img src="../images/2023-02-22-def-combinator.png" alt="định nghĩa về combinator" width="60%" height="60%">

Church encoding: booleans

<img src="../images/2023-02-22-bool-combinators.png" alt="lambda calculus" width="60%" height="60%">

## Tài liệu tham khảo

- [Haskell Programming from First Principles](https://www.goodreads.com/en/book/show/25587599-haskell-programming-from-first-principles)
- [Lambda Calculus - Fundamentals of Lambda Calculus & Functional Programming in JavaScript](https://www.youtube.com/watch?v=3VQ382QG-y4&t=2890s)
- [Haskell function application](https://ahaxu.com/posts/2023-01-02-partial-application-va-curry-trong-haskell.html)
