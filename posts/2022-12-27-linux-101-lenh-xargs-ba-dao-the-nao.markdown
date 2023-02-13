---
title: (Vi) Linux 101 - Lệnh `xargs` bá đạo thế nào
description: (Vi) Linux 101 - Lệnh `xargs` bá đạo thế nào
author: lk
tags: linux, xargs
keywords: linux, xargs
cover_image: https://ahaxu.github.io/images/2022-08-28-hello-world-kyxuan.jpg
---

## Outline

- Force kill process của một chương trình nào đó

ở đây chúng ta muốn tìm các process có tên là **chrome** sau đó force kill các process liên quan.

```bash
ps aux | grep "chrome" | awk '{print $2}' | xargs -I$ kill -9 $
```

- Chạy song song với tham số `-P`

ở đây chúng ta muốn in ra các website từ trong file [website.list](../sample-files/website.list), sau đó lấy content của từng website bằng lệnh `curl`.

```bash
cat /tmp/website.list | xargs -I$ -P5 sh -c 'curl -s $'
```

## Link video

[Linux 101 -  Lệnh xargs bá đao thế nào ?](https://youtu.be/xzcGDAKtyZs)

## Tài liệu tham khảo

- [xargs man page](https://man7.org/linux/man-pages/man1/xargs.1.html)
- [awk man page](https://man7.org/linux/man-pages/man1/awk.1p.html)

