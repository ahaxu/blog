---
title: (Draft Vi) Kleisli composition và ứng dụng thực tế
author: lk
---

## (Draft Vi) Kleisli composition và ứng dụng thực tế

Giả sử chúng ta có hàm số f và g như sau
```
f     :: A -> T (B)
g     :: B -> T (C) 
```
Liệu có cách nào để combine 2 hàm số f và g có kết quả trả về như sau
```
?? g f ::                  A ->              T (C)
??     :: (B -> T (C)) -> (A -> T (B))-> (A->T(C)) -- thay g f vào vế trái 
```
chúng ta cần
```
g' :: T (B) -> T (C)
``` 
để có
```
g' . f :: (TB ->TC)-> (A->TB) -> (A ->TC)
```
vì
```(=<<) :: B -> T(C) -> T(B) -> T(C)
``` 
cho nên
```
g' = (=<<) g
```

do đó
```
f      :: A -> T (B)
g      :: B -> T (C)
g'     :: T B -> T C where g' = (=<<) g)

g' . f :: A -> T C

??  g f = g' .f = ((=<<) g) . f
>=> g f = g' .f = ((=<<) g) . f

```

`??` -> `>=>` còn gọi là *fishy operator*

```
g >=> f :: (B -> T (C)) -> (A -> T (B))-> (A->T(C)) -- Kleisli composition
```

### Ứng dụng của Kleisli composition

TODO
