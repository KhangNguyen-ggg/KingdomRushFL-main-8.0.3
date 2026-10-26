Kiểm thử nhẹ bằng LÖVE 0.10.2/LuaJIT, không ghi save và không chạy màn đầy đủ.
Người chơi không cần chạy các file này để cài bản mod.

native/main.lua cần các junction chỉ để đọc trong thư mục source:
game -> gốc game
assets -> kr3-desktop/assets/images/fullhd đang cài
vfxassets -> CAP_NHAT/kr3-desktop/assets/images/fullhd của gói này

Sửa root/task ở đầu script nếu đổi vị trí. Chạy một lượt với biến môi trường
KRFL_VFX_BASELINE=1 và một lượt khi bỏ biến đó. Kết quả *_result.txt phải
không có FAIL; các dòng gameplay trong *_gameplay.txt phải giống nhau.
Bản candidate dựng hai ảnh xem trước bằng renderer native.

Phép thử dùng database/entity thật, coroutine di chuyển hero thật, image_db
và renderer KR. Dùng slot giả trong RAM và chặn storage.save_slot.
Không thay thế thử chơi một màn hoàn chỉnh với đúng đội hình/F1 của người dùng.

Không xóa đệ quy thư mục có junction trỏ vào game.
