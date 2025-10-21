---
title: Cách cài đặt phần mềm xóa sub cứng
description: Cách cài đặt phần mềm xóa sub cứng
tags: tutorial, ai
keywords: ai, sub-removal, vsr 
author: lk
cover_image: ""
---

Theo feedback của nhiều bạn quan tâm đến chủ đề xóa sub cứng (VSR) từ video [này](https://youtu.be/UHxLB4C3T_k?si=8nt4kdH6kqQGxDDV). 

Khất nhiều lần quá, và ko có thời gian làm lại video cho chỉn chu, mình sẽ hướng dẫn cách cài đặt từ blog này, khi nào có thời gian dư giả hơn, mình sẽ lên video.




## Phương án 1, bạn có thể tải bản cài đặt 1-click. Links tải:

- Windows GPU Version v1.1.0 (GPU):
  - Baidu Cloud Disk: [vsr_windows_gpu_v1.1.0.zip](https://pan.baidu.com/share/init?surl=zR6CjRztmOGBbOkqK8R1Ng&pwd=vsr1) Extraction Code: vsr1
  - Google Drive: [vsr_windows_gpu_v1.1.0.zip](https://drive.google.com/drive/folders/1NRgLNoHHOmdO4GxLhkPbHsYfMOB_3Elr?usp=sharing)

## Phương án 2, cài đặt từ source code trên github

Nếu bạn nào tiếng anh ok, thì có thể đọc và làm theo hướng dẫn ngay [đây](https://github.com/YaoFANGUK/video-subtitle-remover/blob/main/README_en.md#source-code-usage-instructions) .


1. Cài đặt python
2. Cài đặt dependencies, chú ý sử dụng virtual env
3. Tạo thư mục project và activate lên
4. Cài đặt môi trường chạy cho phù 
hợp
    - CUDA đối với các dòng GPU của 
  NVIDIA
    - Direct ML, các dòng GPU của AMD, Intel

5. Sau khi đã cài đặt các bước trên, chúng ta có thể chay lệnh `python run.py` để bật giao diện 


Cảm ơn các bạn đã theo dõi và ủng hộ kênh [Lập Trình AhaXu](https://www.youtube.com/@logauit).

HCM, 2025 Oct 21st.
