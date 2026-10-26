# FL 8.0.5 có gì mới và gói mod đã chuyển

Đối chiếu trực tiếp bản FL 8.0.5 trong thư mục bạn cung cấp với nền 8.0.3 và các mod đang cài. Đây là những thay đổi xác minh từ mã/tài nguyên cục bộ, không phải changelog chính thức hoặc danh sách đầy đủ mọi chỉnh sửa cân bằng.

## Những điểm mới đã xác minh

- **Tám nhánh tháp Dove 4.3:** Sniper Tower, Plague Hospital, Command Center, Ice Cooler, Machine Gunner, Blastin’ Bullriders, Wifi Babies và Wicked Sisters - Stregi. Có menu, kỹ năng, hoạt ảnh và âm thanh tương ứng trong bản 8.0.5.
- **Chống vòng lặp phản sát thương:** đánh dấu sát thương phản bằng `DAMAGE_SPIKED_ARMOR`, đồng thời lưu nguồn sát thương cuối. Gói mod giữ cả thay đổi này lẫn callback sát thương mà boss đồng minh đang cần.
- **Sửa thưởng gọi đợt sớm:** số giây còn lại không âm; phần thời gian tính thưởng bị giới hạn ở 100 giây. Một số đoạn chờ boss tại màn 186/190/191 không nhận thưởng gọi sớm.
- **Một số chỉnh sửa tháp/nâng cấp:** ricochet/độc của Ranger, các tham số tháp và mô tả cân bằng. Giữ nguyên mã 8.0.5, cập nhật các đoạn Việt hóa xung đột theo số liệu mới.
- **Cập nhật mô tả hai phép:** phép hồi sinh/câm lặng mô tả xóa toàn bộ giáp vật lý và kháng phép của hero địch, giảm 50% sức tấn công trong 14 giây; phép hồi sinh/hồi máu mô tả làm chậm địch 35%, gây 6 sát thương chuẩn mỗi 0,5 giây và nhận 4 vàng mỗi 2 mục tiêu. Đây là thay đổi mô tả được đối chiếu; không quy tất cả hiệu ứng này thành tính năng chỉ mới xuất hiện trong 8.0.5.
- Sửa một số chữ thay thế trong Genesis/barbarian và mã an toàn dịch chuyển, cùng các thay đổi nhỏ khác.

`love.dll`, `lua51.dll`, `SDL2.dll` trùng giữa hai bản được kiểm tra. Chênh RAM 4 GB/3 GB ban đầu không chứng minh 8.0.5 có engine tiết kiệm thêm 1 GB: tùy chọn F1 khi đo khác nhau, và bạn đã xác nhận tắt các mục F1 trên 8.0.3 cũng giảm RAM trong trận.

## Mod hiện tại được mang sang

- Việt hóa và các font đang cài; tên màn, độ khó/chế độ tiếng Anh và nhãn **Genesis**. Giữ 15.557 khóa locale 8.0.5, dịch 165 khóa mới; các tên lính dạng bảng vẫn giữ cấu trúc.
- InfiniteHero, nhiều đội và bản sao, không thêm giới hạn số tướng/đội; HUD và giao diện đội hiện tại.
- Boss đồng minh: Blackburn, Juggernaut, Set, Mirage, Alric, Malik, Godieth, Navira đỏ/xanh, ba bản Sett, Volibear Prestige và Lich King. Giữ module, skill tự động, các lựa chọn/hiệu ứng hiện có, Navira horde, Godieth và cơ chế chống ký sinh.
- Những sửa cảnh/hoạt ảnh Malik, hiệu ứng và di chuyển Volibear, Sett và Lich King đang có.
- Bỏ giới hạn lượt trong trận của nhóm phép/vật phẩm đã mod, giữ cooldown và chi phí.
- Bảo vệ save `.bak`/`.corrupt`, kiểm tra ghi save, crash log, tùy chọn phím tắt/tiện ích và các tối ưu hiện có.
- Dọn store/UI/listener/EXO khi rời hoặc restart trận; hàng đợi nạp ảnh và cơ chế báo lỗi ảnh/worker.
- Hoãn nạp nhóm ảnh F1 đến lần mua đầu. Bổ sung lại điểm gọi nạp tại nút mua: bản `game_gui.lua` hiện tại ở thư mục 8.0.3 đã thiếu điểm gọi này so với gói RAM v5. Gói 8.0.5 chứa đủ phần nạp và phần gọi, đã thử qua thao tác mua thật.

Không chép nguyên thư mục 8.0.3 đè lên 8.0.5. Gói chỉ có 174 file thay đổi/bổ sung, giữ nguyên 262 file mới riêng của 8.0.5 và các file tháp/âm thanh nền mới. Không kèm exe, DLL hoặc save. Phần lớn tài nguyên vẫn lấy từ game 8.0.5 đầy đủ của bạn.

## Sửa tương thích kèm theo

- Ghép `game-cleanup` mới của 8.0.5 với việc dọn listener/UI/EXO cũ khi restart, tránh mất một trong hai nhánh sửa.
- Giữ callback boss khi ghép phần ghi nhận nguồn sát thương/phản sát thương.
- Giữ đầy đủ menu tám tháp mới khi ghép thay đổi HUD và menu mod.
- Màn Malik 186 có bốn decal trùng cảnh trỏ tới tên `Stage36_Mask_*` không tồn tại ở cả hai bản. Loại bỏ bốn entry lỗi; sáu lớp `Stage_36_masks_0001` đến `0006` đúng của màn vẫn giữ nguyên. Đã chạy thử màn 186 sau sửa.

## Kết quả kiểm tra

Chạy bằng LÖVE/LuaJIT Windows cùng runtime với game, trên bản sao riêng của 8.0.5; dùng bản sao slot 3 trong bộ nhớ, chặn ghi save/settings thật.

| Phép thử | Kết quả |
|---|---|
| Biên dịch 123 Lua; 15.557 khóa dịch, bảng tên 7 lính | PASS |
| Giữ 262 file mới và mã quan trọng của 8.0.5 | PASS |
| 5.433 trường âm thanh cũ tồn tại nguyên vẹn trong bảng âm thanh mới | PASS |
| 2-27: Volibear + Navira, Sniper + Plague Hospital, restart rồi về map | PASS |
| Màn 186: 9 boss đồng minh, Command Center + Ice Cooler, về map | PASS |
| 2-27: 3 Sett + Lich King, Machine Gunner + Blastin’ Bullriders | PASS |
| 2-27: Catha, Wifi Babies + Wicked Sisters - Stregi | PASS |
| Bật đủ nhóm F1 trong bản sao save, mua Goldfinger, kiểm tra nạp và về map | PASS |

Kiểm tra tài nguyên phân biệt sprite vô hình có chủ đích với sprite đang hiển thị; không bỏ qua lỗi ảnh hoặc hoạt ảnh thật. Sau về map, weak reference xác nhận store trận cũ đã được thu gom. Các kết quả chi tiết ở `KIEM_THU`.

RAM trong test F1 (private memory, 1 GiB = 1.024 MiB): trước dùng F1 **2.350 MiB**, sau nạp ổn định **4.557 MiB**, đỉnh tiến trình **5.265 MiB**, về map **2.424 MiB**. Lần mua đầu mất khoảng 9 giây ở lần chạy này. Các test còn lại dùng cấu hình riêng; không lấy số của chúng so trực tiếp với lần đo 4 GB/3 GB của bạn.

Chưa kiểm tra một chiến dịch chơi đủ sóng, toàn bộ màn, mọi kỹ năng/bản sao/đội hình hoặc toàn bộ giao diện. Gói giữ hành vi/cân bằng của mod hiện có; không khẳng định mọi lỗi cũ đều được giải quyết. Hai thư mục game thật chưa bị cài bản ghép trong thao tác tạo gói này.
