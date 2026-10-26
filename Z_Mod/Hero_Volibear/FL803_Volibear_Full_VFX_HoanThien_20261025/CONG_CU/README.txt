Các file trong thư mục này là mã nguồn tham khảo cho việc dựng/kiểm tra
gói. KHÔNG cần chạy chúng để cài mod hoặc chơi game.

Cài bằng cách chép nội dung CAP_NHAT theo tài liệu ở ngoài.

Nếu muốn dựng lại: chỉnh ROOT/TASK/PACK trong mã cho đúng máy, chuẩn bị
GLB, scene Blender, thư mục particles và LÖVE 0.10.2. File render_assets.py
chạy trong Blender nền; build_atlas.lua và kiem_thu_native.lua là main.lua
của các project LÖVE kiểm thử riêng, cần các junction assets/game được
khai báo trong mã. Chúng không phải trình cài đặt hoặc lệnh Lua độc lập.
