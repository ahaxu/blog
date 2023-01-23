---
title: (En) Linux 101 - Find top IP in a log file
author: lk
tags: linux, xargs, ps, awk, sort, cat
---

## Overview

- cat
- grep
- awk
- xargs
- wc
- sort
- uniq

## Use case

Saying that we have the access.log file from nginx, and we want to find the top IP access to our server with bad purpose in "23/Jan/2023".

Let's use this [sample log file](https://github.com/ahaxu/ahaxu.github.io/blob/main/sample-files/malicious-log-2.log)

```bash
185.254.196.115 - - [23/Jan/2023:05:31:27 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.189 - - [23/Jan/2023:05:40:14 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.189 - - [23/Jan/2023:06:12:38 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
185.254.196.115 - - [23/Jan/2023:06:40:29 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
65.2.176.32 - - [23/Jan/2023:07:59:00 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.189 - - [23/Jan/2023:08:13:37 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.189 - - [23/Jan/2023:09:05:01 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
95.214.235.205 - - [23/Jan/2023:10:17:52 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.189 - - [23/Jan/2023:10:47:41 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
4.236.144.116 - - [23/Jan/2023:11:39:13 +0700] "GET /.env HTTP/1.1" 301 169 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:77.0) Gecko/20100101 Firefox/77.0" "-"
135.125.246.189 - - [23/Jan/2023:12:16:54 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
95.214.235.205 - - [23/Jan/2023:12:58:25 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.110 - - [23/Jan/2023:14:33:52 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
185.254.196.115 - - [23/Jan/2023:14:36:35 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
95.214.235.205 - - [23/Jan/2023:16:10:31 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.110 - - [23/Jan/2023:16:32:27 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
135.125.246.110 - - [23/Jan/2023:17:46:38 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
51.195.157.191 - - [23/Jan/2023:17:57:33 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36" "-"
20.163.234.175 - - [23/Jan/2023:18:20:18 +0700] "GET /.env HTTP/1.1" 404 153 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:107.0) Gecko/20100101 Firefox/107.0" "-"
135.125.246.110 - - [23/Jan/2023:19:29:10 +0700] "GET /.env HTTP/1.1" 404 555 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36" "-"
```

## Link to video

[Linux find top IP in a log file](https://youtu.be/FzWg8-8bo6M)

## Refs

- [xargs man page](https://man7.org/linux/man-pages/man1/xargs.1.html)
- [awk man page](https://man7.org/linux/man-pages/man1/awk.1p.html)
