---
title: (Vi) Khởi tạo môi truờng dev plutus
author: lk
---

Khởi tạo môi truờng dev plutus

Cách cũ trước đây khá rườm rà 

- Clone [`plutus-apps` repo](https://github.com/input-output-hk/plutus-apps), checkout tag version mà bạn cần làm
- Chay `nix-shell` trong thư mục
- Sau khi khoi tao nix-shell xong, copy commit hash / tag version o buoc 1
- Vao project dev smart contract cua ban, edit commit hash cua `plutus-app`
- Update cac git commit hash lien quan den plutus-app commit hash o buoc tren
- Sau do chay cabal update, cabal repl

Cach moi

- Clone plutus-starter
- Check main branch hien dang dung plutus-app v0.1.0
- Cd vao plutus-starter
- Chay nix-shell
- Chay cabal update && cabal repl
- Bat editor len va code thoi ;)

Tu do lai cho minh

- Cac ban co the dung version nao cua plutus-app cho phu hop voi project cua minh
- Tham khao file https://github.com/input-output-hk/plutus-starter/blob/main/CONTRIBUTING.md
- Modify cac file line quan theo huong dan o tren cho phu hop
- Cach nay kha la ton thoi gian, vi ban phai sap xep cac commit hash cho phu hop voi nhau
- sau do chay *cabal update && cabal repl*

Cau truc thu muc

- src/ la thu muc cac ban co the de smart contract o day
- app/ la thu muc cac ban de build plutus script
- Cac ban co the tham khao thu muc examples de to chuc thu muc cho hop ly

