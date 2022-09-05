---
title: (Vi) Khởi tạo môi truờng dev plutus
author: lk
---

Khởi tạo môi truờng dev plutus

Cách cũ trước đây khá rườm rà 

- Clone [`plutus-apps` repo](https://github.com/input-output-hk/plutus-apps)
- Checkout tag version mà bạn cần làm
- Chay `nix-shell` trong thư mục `plutus-apps`
- Sau khi khoi tao `nix-shell` xong, copy commit hash(tag version) o buoc 2
- Vào thư mục chứa project mà bạn sẽ viết smart contract, edit commit hash cua `plutus-app`
- Edit các git commit hash liên quan đến `plutus-app` commit hash ở buớc trên
- Sau do chay `cabal update && cabal repl -v`

Cách mới, tiện hơn

- Clone repo [`plutus-starter`](https://github.com/input-output-hk/plutus-starter)
- Check out **main** branch, tại thời điểm bài viết này thì **main** branch đang dùng `plutus-app` với tag `v0.1.0`
- `cd plutus-starter` vào thư mục mà bạn mới clone về
- Chạy `nix-shell`
- Chạy `cabal update && cabal repl`
- Bật editor lên và code thôi ^^

Tự chọn commit hash cho mình

- Các bạn có thể tùy chỉnh tag version hoặc commit hash của `plutus-app` cho phù hợp với mục đích của project mà bạn làm
- Tham khảo file này https://github.com/input-output-hk/plutus-starter/blob/main/CONTRIBUTING.md
- Modify các file liên quan theo hướng dẫn ở bước trên cho phù hợp
- Cách này làm khá tốn thời gian, vì bạn phải sắp xếp và liên kết các commit hash cho phù hợp với nhau (resolve dependencies)
- sau do chay `nix-shell && cabal update && cabal repl`

Cấu trúc thư mục của **plutus-starter**

- `src` là thư mục liên quan đến smart contract mà bạn sẽ viết
- `app` la thư mục liên quan đến việc generate plutus script từ thư mục `src`
- Các bạn cũng có thể tham khảo thư mục **examples** để tổ chức lại theo ý bạn

Happy coding!

