Công cụ kỹ thuật, người chơi không cần chạy để cài bản mod.

render_walk8.py: chạy bằng Blender 5.2.3 ở background, mở scene gốc
Z_Mod/Volibear/Untitled.blend. Dùng các action Run_Base,
Volibear_spell1_run.anm, Spell4_Run và Idle_Base. Camera trực giao, góc cao
30 độ; xoay model/skeleton cùng nhau, bù phép chiếu để mặt nhân vật khớp
8 hướng trên màn hình. Không ghi đè GLB, scene gốc hoặc file game đang cài.

pack_assets/main.lua + conf.lua: chạy bằng LÖVE 0.10.2 để kiểm tra biên alpha,
cắt ảnh, đóng atlas và ghi metadata. Thư mục source cần junction frames trỏ
vào nơi chứa frame Blender. Cắt ảnh giữ nguyên canvas/mốc chân, không tự
căn giữa từng tư thế. Kiểm tra đúng 736 pose, không ảnh rỗng hoặc cắt biên.

Đường dẫn ROOT/TASK/PACK ghi trong script là nơi đã chạy trên máy này;
sửa nếu đổi nơi làm việc. render_report.json ghi action/góc/nhịp/mốc chân.
NGUON_RENDER.json ghi SHA256 của GLB và scene gốc.

Không xóa đệ quy thư mục có junction trỏ vào game hoặc dữ liệu nguồn.
