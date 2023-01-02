---
title: (Vi) Khởi tạo môi truờng dev plutus
author: lk
tags: plutus, cardano
---

Khởi tạo môi truờng dev plutus

### !!

Video huớng dẫn cụ thể sẽ được upload tại kênh này ;)

## !! 

<a href="https://www.youtube.com/user/logauit/featured">
https://www.youtube.com/user/logauit/featured
</a>


### Cách cũ trước đây khá rườm rà 

1. Clone <a href="https://github.com/input-output-hk/plutus-apps" target="_blank">plutus-apps</a>
2. Checkout tag version mà bạn cần làm `git checkout v0.1.0`
3. Chay `nix-shell` trong thư mục *plutus-apps*
4. Sau khi khoi tao `nix-shell` xong, copy commit hash(tag version) ở buớc 2
5. Vào thư mục chứa project mà bạn sẽ viết smart contract, edit commit hash cua `plutus-apps` trong file *cabal.project*
6. Edit các git commit hash liên quan đến `plutus-apps` commit hash ở buớc trên
7. Sau đó chạy `cabal update && cabal repl -v`

### Cách mới, tiện hơn

Cách này tiện hơn là do chúng ta không cần phải switch thư mục qua lại giữa `plutus-apps` và thư mục project

- Clone repo <a href="https://github.com/input-output-hk/plutus-starter" target="_blank">plutus-starter repo</a>
- Check out *main* branch, tại thời điểm bài viết này thì *main* branch đang dùng `plutus-apps` với tag `v0.1.0`
- `cd plutus-starter` vào thư mục mà bạn mới clone về
- Chạy `nix-shell`
- Chạy `cabal update && cabal repl`
- Bật editor lên và code thôi ^^

### Tự chọn commit hash cho mình

1. Các bạn có thể tùy chỉnh tag version hoặc commit hash của `plutus-apps` cho phù hợp với mục đích của project mà bạn làm
2. Tham khảo file này <a href="https://github.com/input-output-hk/plutus-starter/blob/main/CONTRIBUTING.md" target="_blank">plutus-starter contributing.md</a>
3. Modify các file liên quan theo hướng dẫn ở *bước 2* cho phù hợp
4. Cách này làm khá tốn thời gian, vì bạn phải sắp xếp và liên kết các commit hash cho phù hợp với nhau (resolve dependencies)
5. Sau đó chạy `nix-shell && cabal update && cabal repl`

### Cấu trúc thư mục của **plutus-starter**

- `src` là thư mục liên quan đến smart contract mà bạn sẽ viết
- `app` la thư mục liên quan đến việc generate plutus script từ thư mục `src`
- Các bạn cũng có thể tham khảo thư mục **examples** để tổ chức lại theo ý bạn

## Happy coding!

