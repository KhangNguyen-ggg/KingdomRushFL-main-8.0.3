Phép thử kỹ thuật, không cần chạy để cài bản vá.

native/main.lua và conf.lua dùng LÖVE 0.10.2/LuaJIT, cửa sổ ẩn, không vào màn
đầy đủ, không ghi save. Có so sánh các tình huống kỹ năng trước/sau VFX.
Hai dòng đầu ghi đường dẫn máy đã thử; sửa root/task nếu dùng máy khác.
Giữ tên/thư mục bản vá trong Z_Mod/Volibear như đang có.

Thư mục source của phép thử cần các directory junction chỉ để đọc:
game -> gốc game
assets -> kr3-desktop/assets/images/fullhd đang cài
vfxassets -> CAP_NHAT/kr3-desktop/assets/images/fullhd của bản vá

Chạy một lượt với biến môi trường KRFL_VFX_BASELINE=1, rồi một lượt khi bỏ
biến đó. Kiểm tra baseline_result.txt và candidate_result.txt không có FAIL;
hai file *_gameplay.txt phải giống nhau. Bản chạy candidate tạo ảnh xem trước.
KIEM_TRA.txt là kết quả đã chạy trên máy này.

Không xóa đệ quy thư mục chứa junction trỏ vào game.
