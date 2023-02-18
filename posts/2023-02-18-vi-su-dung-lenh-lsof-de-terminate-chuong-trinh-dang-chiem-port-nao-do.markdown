---
title: (Vi) Sử dụng lệnh lsof để terminate chương trình đang chiếm port nào đó
description: Sử dụng lệnh lsof để terminate chương trình đang chiếm port nào đó
author: lk
tags: lsof, linux
keywords: lsof, linux
cover_image: https://ahaxu.github.io/images/2022-08-28-hello-world-kyxuan.jpg
---

## Sử dụng lệnh lsof để terminate chương trình đang chiếm port nào đó

```
lsof -i -n -P | grep LISTEN | grep 8080 | awk '{print $2}' | xargs -I$ kill -9 $
```

## Link bài giảng youtube

- [https://youtu.be/Rm0Afh_ST9I](https://youtu.be/Rm0Afh_ST9I)

## Ref

- [https://man7.org/linux/man-pages/man8/lsof.8.html](https://man7.org/linux/man-pages/man8/lsof.8.html)
