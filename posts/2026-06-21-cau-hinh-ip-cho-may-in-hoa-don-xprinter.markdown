---
title: Cấu hình IP cho máy in hóa đơn Xprinter
description: Cấu hình IP cho máy in hóa đơn Xprinter
tags: support, it, pos,printer, xprinter
keywords: support, it, pos,printer, xprinter
author: lk
cover_image: ""
---

Máy POS (iPos) ko kết nối được đến máy in hóa đơn (Xprinter)

1. Cần xác định được đúng giải IP của máy trạm POS đang kết nối vào wifi, và xác định đúng dây cáp đang cắm vào máy in Xprinter có cùng giải mạng ko.
    1. Nếu giải IP của máy trạn POS khác với dải IP của của dây cáp đấu vào máy in hóa đơn:
        1. Lấy 1 máy tính, đấu vào cáp đấu vào máy in hóa đơn, ta lấy được giải IP của máy in hóa đơn.
        2. kết nối máy trạm POS đến các wifi trong nhà, khi dải IP trùng với giải IP của máy in hóa đơn là được
        3. Chú ý dải máy in của POS đã kết nối đúng wifi trùng mạng với dây LAN đấu vào máy in, giả sử IP máy POS lúc này là: `192.168.1.2`, khi này ta cần set IP của máy in thành `192.168.1.x`

2. In test page từ máy in để lấy IP hiện tại của máy in (ko cần cắm dây LAN), giả sử lúc này là `202.161.1.111` ... khác dải `192.168.1.x`
3. Đấu máy in vào máy tính bằng dây LAN, cấu hình IP máy tính lúc này sao cho cùng giải `202.161.1.x`, ví dụ: `202.161.1.112`
4. Sau đó, ta có thể vào trang quản lý máy in giao diện web với IP `202.161.1.111`
5. Vào mục đổi IP, ta đổi lại IP máy in thành `192.168.1.123` sao cho cùng mạng với wifi đang kết nối của POS (**b1.1.2**)
6. In thử ta được địa chỉ IP mới của máy in lúc này là `192.168.1.123`
7. Cắm máy in vào dây LAN cùng dải IP với POS (`192.168.1.x`) là in được.

