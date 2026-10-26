# Kiểm tra Volibear Real3D Part1/Part2 — 2026-10-23

Kết luận: ghép hai gói cho bộ file sprite đầy đủ, kiểm tra nhẹ đạt. Chưa đủ căn cứ xác nhận hết crash khi vào màn. Không cài lại Volibear, không sửa ZIP nguồn, mã game live, cấu hình F1 hay save trong lượt kiểm tra này.

## Hai gói dùng cùng nhau

- Part1: 34 file; gồm module hero/registry, bảng hoạt ảnh, 18 metadata atlas, 9 PNG thân và 1 PNG chân dung, hướng dẫn/báo cáo.
- Part2: 9 file PNG còn lại. Không phải bản sửa mới thay thế Part1.
- Tổng: 43 file, không trùng đường dẫn; 18 atlas thân và 341 khung hình; 19 PNG tính cả chân dung.
- Chỉ Part1 sẽ thiếu 9 PNG: e_idle, e_windup, idle, knockup, q_intro, q_outro, r_outro, r_run, w_slash. Chỉ Part2 không có mã đăng ký hero.
- Cần nền game đã có các module boss đồng minh/Sett/Lich King; đây không phải bộ cài độc lập lên KR_FL tác giả chưa có các module đó.

## Kiểm tra đã chạy

- Giải nén hai gói vào thư mục thử riêng, kiểm tra không có đường dẫn vượt thư mục đích hoặc file trùng nhau.
- Giải nén dữ liệu PNG bằng zlib: 19/19 ảnh đủ dữ liệu scanline, đúng RGBA8, không phát hiện ảnh hỏng trong phần đã kiểm tra.
- Runtime LÖVE 0.10.2 của game đọc PNG và nạp lên GPU từng ảnh, dùng thêm UI Sett từ bản nền. Không nạp toàn bộ game.
- Kiểm tra đủ 18 atlas, 341 frame; vùng cắt nằm trong ảnh; trim khớp kích thước; mọi frame hoạt ảnh gốc và sau prepare() đều tồn tại.
- Cú pháp của 3 module và toàn bộ metadata hợp lệ. prepare() chạy được với component tối thiểu; callback đánh trái/phải luân phiên đúng.
- Đối chiếu registry: khác game live hiện tại chỉ ở dòng thêm Volibear. UI Sett giữ nguyên các entry Sett, thêm 2 entry Volibear. Không thấy sửa module Navira/Sett/RAM trong hai gói.

Kết quả runtime:

```text
PASS: LÖVE 0.10.2 PNG decode + GPU upload (19 patch images plus existing Sett UI), 18 body atlases / 341 frames, all quad/trim bounds, animation references, module syntax and prepare(), left/right attack alternation.
GPU upload tested one image at a time to keep memory low. Engine integration and complete stage entry NOT tested.
```

## Liên quan lỗi Alric và crash

- Hai gói không chứa all/infinite_heroes.lua, nên không tự sửa lỗi Infinite bỏ qua màn manual_hero_insertion. Lỗi đó nằm trong code chung đã sửa ở lượt trước.
- Chép đúng hai gói này sẽ không ghi đè all/infinite_heroes.lua hiện tại; bản sửa chung vẫn còn. Nếu dùng nền game cũ chưa sửa, hiện tượng gọi Alric vẫn có thể xuất hiện.
- Bản vừa gỡ trước đó có allied_volibear.lua kiểu V2 (sprite AI/optical-flow), khác module Real3D trong Part1. Vì vậy không thể kết luận cả hai bản có cùng lỗi runtime.
- Không phát hiện lỗi cú pháp, frame thiếu hoặc atlas vượt biên có thể giải thích trực tiếp crash trong hai part khi ghép đủ.
- Chưa chạy lại vào màn KR3 với Navira xanh + Sett + Volibear; người dùng chọn chỉ kiểm tra nhẹ. Không dùng kết quả này để khẳng định an toàn mọi stage/đội hoặc đã hết native ntdll 0xc0000005/OOM.

## Các hạn chế và điểm cần chỉnh

1. Mã compact() lược tư thế, trái với comment “retaining ALL poses”. Q intro còn 7/16 tư thế, Q attack 7/8, Q outro 7/25; E channel 11/24. Có thể làm chuyển động gắt; chưa đo cảm nhận trong trận.
2. W giữ 19/21 tư thế, nhảy R 17/19, tiếp đất R 14/17. Đi lên/xuống dùng cùng clip run, chỉ đổi hướng theo cơ chế sprite; không có góc render riêng cho từng hướng.
3. E hiện hồi 120 HP sau cast mà không kiểm tra số địch thực sự trúng, khác mô tả “nếu trúng địch”. Đây là sai lệch gameplay, không phải bằng chứng nguyên nhân crash.
4. Chưa có VFX sét/hạt của trang phục LoL ngoài model. Ảnh atlas đã kiểm tra trực quan là thân model 3D, không có đủ hiệu ứng chiêu gốc.
5. Tài nguyên thân: 65,5 MiB RGBA; chân dung: 0,5 MiB. Đây là kích thước một bộ pixel, không phải RAM tổng hay mức RAM tăng thực tế. Game còn bộ đệm giải mã, Canvas/GPU và tài nguyên nền/F1.

Thống kê tư thế sau compact():

```text
candidate_e_channel: 24 -> 11 unique poses
candidate_jump: 19 -> 17 unique poses
candidate_land: 17 -> 14 unique poses
candidate_q_attack: 8 -> 7 unique poses
candidate_q_intro: 16 -> 7 unique poses
candidate_q_outro: 25 -> 7 unique poses
candidate_w: 21 -> 19 unique poses
```

## Không trộn với ZIP Real3D cũ

FL803_Volibear_Real3D_InfiniteHero.zip không đồng nhất với Part1+Part2. 18 PNG thân khớp, nhưng mã hero/metadata và cách đóng gói khác.

Ví dụ gói cũ khai báo volibear_r_cast_0000 và _0001; Part1 khai báo _0001 và _0002 theo bảng animation_db. Hai part đã chuyển key sang 1-based. Trộn metadata 0000 của gói cũ với bảng frame 1-based có thể làm lệch hoặc thiếu frame. Gói ZIP cũ cũng không có registry/UI đầy đủ như Part1 và dựa vào nền V2 đã cài.

## F1 nghĩa là gì

F1 là menu chỉnh game ở bản đồ. “Bật toàn bộ F1” trong các phép thử trước là bật các nhóm tài nguyên bổ sung: cheat, cheat5, cheat6, cheathero, cheat5_dragon, cheat5_special theo slot thử; không có nghĩa mọi nút trong menu đều bật. Những nhóm này làm game tải thêm nhiều tháp/hero/nhóm đặc biệt. Chưa có bằng chứng chúng xung đột với nhau; đây là vấn đề lượng tài nguyên cần tải. Lỗi gọi nhầm Alric có nguyên nhân riêng ở Infinite.

## Đối chiếu file

- Volibear_Real3D_Part1.zip: SHA256 808b6aaa9cd58f8f173d7a836464d479001dd6708b2246556a89ef3a07a6d874
- Volibear_Real3D_Part2.zip: SHA256 227a6ae80c01053d08b651a50d086a285d18ef59a1fc8499747c7fe54f5ff9ac

Script và log thử nhẹ nằm tại D:\CodexTemp\KRFL_Volibear_Parts_Audit_20261023. Thư mục unit/base_assets là junction chỉ đọc về game; không xóa đệ quy thư mục thử mà chưa xử lý junction.
