---
title: (Vi) Linux 101 - Tìm top IP trong log file
description: (Vi) Linux 101 - Tìm top IP trong log file
author: lk
tags: linux, xargs, ps, awk, sort, cat
keywords: linux, xargs, ps, awk, sort, cat
---

## Chúng ta xét các lệnh cơ bản sau

- cat
- grep
- awk
- xargs
- wc
- sort
- uniq

## Ví dụ thực tế 

Xét đoạn log trong ngày **"27/Dec/2022"** ([trong file](https://github.com/ahaxu/ahaxu.github.io/blob/main/sample-files/malicious.log)]).
Đoạn log này scan thử xem hệ thống của bạn có những lỗ hổng nào có thể khai thác hay không, 
Giờ chúng ta hãy tìm ra **top 5 IP** có pattern như trên, để tiến hành block các IP có mục đích không được tốt truy cập vào website của bạn nhé.

```bash
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /.aws/credentials HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /.s3cfg HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /.msmtprc HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /debug/default/view?panel=config HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "POST / HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /frontend_dev.php/$ HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /index%20js HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /config.js HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /config/config.js HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /js/config.js HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /js/envConfig.js HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /env.config.js HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /env.js HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /app/config.yml HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /app/config/parameters.yml HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
13.213.73.235 - - [27/Dec/2022:02:43:02 +0000] "GET /config/secrets.yml HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246" "-"
```

Chúng ta cùng phân tích đoạn lệnh sau
```bash
cat malicious.log | grep "27\/Dec\/2022" | awk '{print $1}' | sort | uniq -c | sort -k1 -n
```

và chúng ta được kết quả như sau
```bash
~> cat malicious.log | grep "27\/Dec\/2022" | awk '{print $1}' | sort | uniq -c | sort -k1 -r | head -n3

# ket qua 
   8 13.213.73.235
   3 13.213.73.236
   2 13.113.73.235
```

## Link video

[Linux tìm top IP trong log file](https://youtu.be/Vuu0t5pB2No)

## Tham khảo

- [xargs man page](https://man7.org/linux/man-pages/man1/xargs.1.html)
- [awk man page](https://man7.org/linux/man-pages/man1/awk.1p.html)
