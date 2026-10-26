# Việt hóa FL 8.0.5 — R2

## Nguyên nhân ô vuông

Trong gói mod trước, các nhãn `建造说明`, `建造方式`, `机制与说明` và tám đoạn hướng dẫn xây tháp mới vẫn dùng tiếng Trung. Font EB Garamond dùng cho phần đọc không có các ký tự đó. Tiêu đề cửa sổ kỹ năng cũng dùng ngoặc toàn chiều rộng.

Đã tái hiện trong chính màn chọn tháp: trước sửa có **54 ký tự không được font hỗ trợ** trong các cửa sổ hướng dẫn mới. Sau dịch và thay ngoặc thường, phép kiểm tra tương ứng còn **0**. Giữ cấu hình và file font hiện có.

## Những chỗ đã rà và sửa

Sửa **115 khóa trong từ điển**, cùng các nhãn/hướng dẫn viết trực tiếp trong Lua. Ưu tiên màn chọn tháp, tám tháp mới, các tên tháp cũ có lỗi rõ ràng và các thông báo còn tiếng Trung. Không tuyên bố đã biên tập lại toàn bộ 15.557 khóa.

| Trước | Sau / lý do |
|---|---|
| Dwarf Hall: Phòng thỏ | Sảnh Người Lùn |
| Archmage Tower: Tháp Thầy | Tháp Đại Pháp Sư |
| Dwarven Bastion: Lâu đài con rắn | Pháo đài Người Lùn |
| Crossbow Fort: Lâu đài quân đội | Pháo đài Nỏ |
| Battle-Mecha T200: T200 loại máy bay chiến đấu | Robot Chiến Đấu T200 |
| Tribal Axethrowers: Cây ném bẫy | Bộ Lạc Ném Rìu |
| Hunter/Watcher/Sentinel Arbor dịch thành Cây săn/Cây của người chăm sóc/Cây Cảnh Sát | Tháp Thợ Săn/Tháp Canh/Tháp Vệ Binh |
| Sát thương súng | Sát thương vật lý, theo loại đạn thực tế của drone |
| Hồi bắn | Khoảng cách giữa các phát/loạt bắn |
| Trong tầm 50 khi nói về vùng tên lửa nổ | Trong bán kính 50 |
| Đặt lại hồi kỹ năng | Giúp kỹ năng hồi lại ngay lập tức |
| Sniper bỏ qua 25 điểm giáp | Khi tính sát thương, giáp thấp hơn 25 **điểm phần trăm**, theo `reduce_armor = 0.25` |
| Sniper kết liễu hoặc gây 50% máu tối đa, không nêu điều kiện | Nêu riêng mục tiêu thường, mục tiêu miễn kết liễu và boss |
| Wifi Babies xây từ nhánh KR2 | Nhánh cấp 3 của Spirit Mausoleum KR4, theo menu xây đang chạy |
| Mike có 320/360 máu | Mô tả 300/400 theo `dove43_config.plague_hospital.mike_hp` và hàm khởi tạo Mike |

Hướng dẫn tám tháp mới có cả tên đang dùng trên giao diện và tên tiếng Anh để đối chiếu. Giữ các tên riêng tiếng Anh khi bản dịch literal làm khó hiểu, ví dụ Flame Chompers.

Các nhãn còn sót trong màn chọn phép/tháp/hero, gợi ý trên map, công cụ phát triển, tùy chọn di động, phím tắt và trình sửa đợt quái cũng được dịch. Nội dung ngôn ngữ Nhật/Hàn/Hoa phồn thể trong các nhánh lựa chọn ngôn ngữ riêng được giữ lại.

## Kiểm tra

- 4 file Lua sửa đổi biên dịch bằng LuaJIT đi kèm game.
- 115 khóa sửa khớp danh sách duyệt; 15.442 khóa còn lại và các bảng tên lính giữ nguyên.
- Giữ toàn bộ 79 mục hướng dẫn xây và danh sách ID tháp đặc biệt.
- Khởi chạy bản sao game với slot 3 chỉ đọc trong bộ nhớ, chặn ghi save/settings thật.
- Mở đủ 8 hướng dẫn thông qua màn chọn tháp; mở 24 cửa sổ kỹ năng mới và cửa sổ cơ chế Ranger.
- Kiểm tra glyph bằng font đang được giao diện dùng; kiểm tra thêm toàn bộ 79 hướng dẫn và 115 câu mới với font phần đọc. Không còn glyph thiếu trong phạm vi này.
- Xem ảnh chụp sau sửa ở Sniper Tower và Wifi Babies để kiểm tra dấu Việt, xuống dòng và bố cục.

Các file sửa chỉ chứa câu chữ và nhãn. Không sửa chỉ số sát thương, máu hoặc hoạt động kỹ năng; số liệu Mike được sửa trong phần mô tả để phản ánh mã đang chạy.

Chưa rà toàn bộ câu thoại, nhiệm vụ, thành tựu và mọi mô tả trong game. Các test này xác nhận phần giao diện/bản dịch được sửa, không thay cho một lượt chơi hết chiến dịch.
