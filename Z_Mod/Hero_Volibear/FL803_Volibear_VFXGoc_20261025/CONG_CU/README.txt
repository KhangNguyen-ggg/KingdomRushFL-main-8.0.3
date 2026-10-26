build/main.lua và conf.lua là công cụ dựng lại atlas bằng LÖVE 0.10.2.
Không cần Blender hoặc Python. Người chơi không cần chạy công cụ này.

Sửa hai đường dẫn task/pack ở đầu main.lua nếu đổi nơi làm việc.
Trong thư mục source build, tạo junction particles trỏ vào thư mục particles
gốc do bạn cung cấp. Các file được chọn ghi trực tiếp trong selections.

Chạy LÖVE trỏ vào thư mục build. Công cụ chỉ ghi atlas PNG/Lua và báo cáo
vào gói bản vá, không ghi vào ảnh gốc hoặc game đang cài. Atlas được chặn
ở kích thước 1024x1024; nếu chọn thêm ảnh không đủ chỗ, công cụ sẽ báo FAIL.

Không xóa đệ quy thư mục chứa junction trỏ vào dữ liệu gốc.
