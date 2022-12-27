---
title: (Vi) Linux 101 - Lệnh `xargs` bá đạo thế nào
author: lk
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

## Tài liệu tham khảo

- [xargs man page](https://man7.org/linux/man-pages/man1/xargs.1.html)
- [awk man page](https://man7.org/linux/man-pages/man1/awk.1p.html)

