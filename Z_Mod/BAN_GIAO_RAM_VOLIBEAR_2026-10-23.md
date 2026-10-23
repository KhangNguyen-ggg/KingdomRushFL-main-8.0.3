# Bàn giao KRFL 8.0.3 — RAM và sprite Volibear

Ngày kiểm tra: 23/10/2026. Nội dung dành cho phiên tiếp theo tiếp tục công việc trong cùng workspace.

## 1. Workspace và quy ước của người dùng

```text
D:\Kingdom Rush Frontiers Tower Defense v5.4.07\KingdomRushFL-main 8.0.3
```

- PowerShell trên Windows. HEAD lúc bàn giao: `acc9f8d`. Có nhiều thay đổi chưa commit; không reset/checkout hàng loạt.
- Người dùng thường đang chơi: dựng bản sửa riêng, KHÔNG tự chép vào game đang dùng.
- Mỗi bản mod phải có một ZIP riêng tên bắt đầu `FL803_`, có hướng dẫn chép đúng thư mục và bản sao lưu.
- Giữ save, đội hình, các mod hero hiện có; không giới hạn số hero/quái hoặc âm thầm thay F1/độ phân giải để che lỗi RAM.
- Không tự đóng Blender/game/ứng dụng của người dùng. Không chạy phép thử nặng song song với game khi thiếu bộ nhớ.
- Không hứa hết crash hoặc tăng FPS nếu mới đo logic hay một phần workload.

## 2. Việc gần nhất và yêu cầu tiếp theo

Người dùng đang chuẩn bị sprite Volibear thật từ model GLB bằng Blender, đã được hướng dẫn chạy script. Sau đó hỏi thời gian render, phụ thuộc CPU/GPU và RAM khi đưa sprite vào game. Yêu cầu cuối là tạo file bàn giao này.

**Phát hiện mới khi bàn giao: render đã có đủ đầu ra cuối cùng. Không hướng dẫn render lại từ đầu trước khi xem các file hiện có.**

## 3. Volibear: file nguồn và script nên dùng

```text
Z_Mod\Volibear\prestige_duality_dragon_volibear.glb
Z_Mod\Volibear\Volibear_Khada_Render_All_In_One.py
```

- GLB: 18.204.880 byte, 90 animation, 1 mesh, 195 node theo JSON nguồn.
- Script chính là `Volibear_Khada_Render_All_In_One.py`, tự nhập model, đặt scene/camera/đèn, render, cắt vùng trong suốt, ghép atlas và tạo Lua.
- Các script `Z_Mod\render_volibear_in_blender.py` và bản trong `Volibear_Khada_3D_Render_Kit` là bản cũ; tránh nhầm đầu ra và hướng dẫn.
- Thông số script chính: `FRAME_SIZE=512`, `GAME_FPS=30`, `RENDER_SAMPLES_PER_SECOND=16`, `ATLAS_MAX_SIDE=4096`, `SKIP_EXISTING_PNG=False`.
- Dùng 18 action/tag đã chọn, không xuất tất cả 90 animation.
- Lịch phát có frame lặp để giữ thời lượng ở 30 tick/giây; số ảnh thật mỗi giây không nhất thiết là 30.
- Script tạo scene mới. Chưa kiểm tra có cần sửa góc camera, hướng nhìn, bóng hoặc vật liệu sau khi xem ảnh.
- GLB không đảm bảo chứa các particle/VFX kỹ năng của LoL; không khẳng định đã có đầy đủ Q/W/E/R chỉ vì render nhân vật xong.

Blender trong ảnh của người dùng tự hiển thị `5.2.3 LTS`, Python Console 3.13.13. Không suy diễn tương thích chỉ từ tên phiên bản.

## 4. Trạng thái render thực tế khi bàn giao

Đầu ra:

```text
Z_Mod\Volibear\Volibear_Real3D_Export\
    frames\<tag>\*.png
    atlases\go_volibear_<tag>.png
    atlases\go_volibear_<tag>.lua
    volibear_animation_map.lua
    render_report.json
    README_output.txt
```

- Có `render_report.json`, `volibear_animation_map.lua`, README cuối lượt xuất.
- Đủ **18 atlas PNG + 18 Lua**, **341 PNG khung hình**. Tổng 359 PNG gồm cả atlas.
- Đã đối chiếu kích thước header PNG với `atlas_size` trong report và kiểm tra đủ Lua tương ứng.
- Chưa QA hình ảnh/chuyển động và chưa kiểm tra từng tọa độ trim/anchor.
- Khi kiểm tra bàn giao không tìm thấy tiến trình `blender` đang chạy.

| Tag | Khung hình thật |
|---|---:|
| idle | 36 |
| run | 19 |
| attack1 / attack2 | 22 / 22 |
| q_intro / q_attack / q_outro | 16 / 8 / 25 |
| w_slash | 21 |
| e_windup / e_channel / e_idle | 7 / 24 / 24 |
| r_cast / r_impact / r_outro / r_run | 2 / 17 / 6 / 19 |
| death / respawn / knockup | 32 / 26 / 15 |

Lúc người dùng gửi ảnh Not Responding, Blender vẫn dùng thêm khoảng 2,69 CPU-second trong 3 giây, chưa thấy PNG; khi ấy chưa thể kết luận treo. Nay đầu ra cho thấy lượt xuất đã đi tới phần ghi report cuối.

### Số liệu bộ nhớ cần dùng thay cho ước lượng trước

- Tổng PNG atlas trên đĩa: **15,6268 MiB**.
- Tổng `width × height × 4` của 18 atlas: **65,5 MiB** cho MỘT bản dữ liệu RGBA8, chưa gồm mipmap, ảnh CPU tạm/còn giữ, driver, Lua, VFX hoặc tài nguyên chung.
- 341 ảnh gốc 512×512 chưa cắt tương đương 341 MiB, nhưng game nên nạp atlas đã trim, không nạp cả thư mục frame thô.
- Trước khi có đầu ra, đã nói dự trù 100–400 MB và tối đa khoảng 418 ảnh theo cap script. Đây là ước lượng cũ, KHÔNG phải số đo; nay có 341 frame và số pixel atlas thực tế để tính chính xác hơn.
- Chưa đo RAM tăng thực tế khi tích hợp hero. Iris Xe dùng RAM chia sẻ; không tự cộng cứng gấp đôi 65,5 MiB rồi gọi đó là RAM tiến trình.

## 5. Tích hợp Volibear: trạng thái và bước tiếp theo

Đã có module trong game:

```text
all\allied_volibear.lua
```

Header module hiện mô tả bản V2 dùng ảnh AI/optical-flow, không phải khung từ model 3D. Tên entity `hero_allied_volibear_prestige`, texture đang khai báo `go_volibear_prestige` và `ui_sett_spirit`. Animation hiện dùng prefix `volibear_prestige` với dãy frame cũ.

**Chưa chuyển module này sang 18 atlas mới trong lượt công việc vừa rồi.** Có các ZIP cũ `FL803_Volibear_COPY_PASTE.zip`, `FL803_Volibear_Muot_V2_COPY_PASTE.zip`; không coi chúng là mod sprite GLB mới.

Khi được yêu cầu tiếp tục tích hợp:

1. Xem một số frame/atlas và preview hoạt ảnh để kiểm tra vật liệu, alpha, pose thực sự chuyển động, góc nhìn và cắt tay/chân.
2. Đọc `volibear_animation_map.lua`, Lua atlas và module hero cũ; đối chiếu alias game dùng như walk/attack/q với run/attack1/q_intro… Không chỉ chép ảnh đè.
3. Khai báo đủ nhóm texture mới; kiểm tra cách Lua atlas đánh tên frame và trim/anchor. Giữ vị trí chân ổn định khi chuyển clip.
4. Kiểm tra Q/W/E/R theo code hiện có, không thay gameplay ngoài yêu cầu. Đánh giá riêng VFX còn thiếu.
5. Dựng bản mod riêng trong `Z_Mod`, thử vào/ra màn, đo RAM/FPS cùng cấu hình trước/sau; tạo ZIP FL803 đầy đủ trước khi đề nghị cài.
6. Không tự thay mod đang chơi hoặc render lại toàn bộ chỉ để thử chỉnh camera; thử vài frame trước.

## 6. RAM: bản hiện có và xác nhận cài đặt

```text
Z_Mod\Optimize Ram\FL803_ToiUuRAM_HopNhat_v4.zip
Z_Mod\Optimize Ram\FL803_ToiUuRAM_HopNhat_v4_1_TuyChonLuong.zip
```

Các thư mục cùng tên chứa `CAP_NHAT`, `BACKUP_TRUOC_VA`, manifest, hướng dẫn, kết quả và mã thử.

**Kiểm tra ở thời điểm bàn giao: cả 14 file live đều trùng SHA-256 payload v4.1.** Phiên trước chỉ đóng gói; sau đó người dùng đã tự cài. Không tiếp tục nói v4.1 chưa nằm trong game.

V4.1 khác v4 ở việc bỏ giới hạn cứng 2 luồng ảnh. Dùng đúng giá trị menu 2/4/6/8; settings từng kiểm tra có `max_threads=8`. Khi hướng dẫn tiếp theo cần kiểm tra lại nếu người dùng đổi.

Các thay đổi RAM vẫn còn trong v4.1:

- Dọn listener/store/GUI/EXO/lưới khi thoát hoặc chơi lại từ v2.
- Cách đưa ảnh sang Canvas và thả pixel CPU tạm từ v3.
- Bỏ giữ vĩnh viễn 20 nhóm atlas; ảnh chiến đấu được tải lại sau khi đã trả.
- **GC toàn bộ sau mỗi ảnh có `w*h >= 4194304`**, ảnh nhỏ dùng GC tăng dần.
- Tái sử dụng lưới mục tiêu trong trận; font nhỏ gom về cỡ nguyên.
- Cache ảnh chữ tối đa 128 mục và ngân sách 8 MiB pixel texture; không đuổi ảnh còn dùng. Sao chép size trước khi hàm render font biến đổi nó.

### Vấn đề tải chậm chưa xử lý xong

Người dùng báo v4.1 tải màn lâu hơn rõ rệt và nhìn thấy cả menu chọn slot khi load.

- Đã giải thích rõ: trả về 8 luồng KHÔNG bỏ các thay đổi RAM khác.
- Tải lại các atlas và GC toàn bộ sau từng ảnh lớn là hai nguyên nhân có thể làm tải chậm; Canvas cũng thêm công đoạn upload/copy.
- **Chưa đo thời gian trước/sau cùng cấu hình**, chưa xác định chính xác việc menu chọn slot xuất hiện. Không khẳng định game thực sự tải lại menu đó hoặc đó là hành vi bình thường.
- Người dùng đã được nói rằng việc ưu tiên RAM ở khâu tải quá mạnh chưa được đánh giá đầy đủ; không coi độ chậm này là cái giá bắt buộc của chống tích lũy RAM.
- Nếu tiếp tục tối ưu tốc độ: đo các phase thực tế, ưu tiên kiểm tra tần suất full GC khi upload và vòng đời atlas. Không xóa cơ chế dọn store/listener đã sửa đúng.

## 7. MemoryOpt và tránh ghép xung đột

Người dùng từng tự chép `Z_Mod\Optimize Ram\FL803_MemoryOpt` trong lúc đang làm v4 và cho phép lấy phần tốt.

- Bản MemoryOpt đó ghi đè mất một số bước teardown của v2; v4 đã khôi phục.
- Giữ ý tưởng cache chữ nhưng sửa lỗi khóa màu, eviction ảnh còn dùng, giới hạn dung lượng và size bị mutate.
- Không dùng đường `memory_guard`/phím F9/F10 của MemoryOpt vì game vốn đã có GC tăng dần; `all/director.lua` trong v4 trở về đường cũ đã kiểm thử.
- File `dove_modules\perf\memory_guard.lua` có thể còn trên ổ nhưng v4.1 không nạp nó. Không tự xóa; backup trước v4 có thể còn phụ thuộc file này.
- `BACKUP_TRUOC_VA` của gói v4 là trạng thái trước v4 CÓ MemoryOpt, không phải bản gốc tác giả.

## 8. Bằng chứng thử RAM và giới hạn

Kết quả chi tiết nằm trong `KIEM_TRA.txt` và `KIEM_THU` của gói v4/v4.1. Log được sao chép vào v4.1 là phép thử **v4 giới hạn 2 luồng**, không phải đo dài ở 8 luồng.

- V4: 6 lượt vào màn 2-27 (`level_idx=87`) với 9 boss khác nhau, tháp ba phần đầu; bản sao cấu hình thử tắt các nhóm F1 5/6/extra hero/dragon/special, không ghi save người dùng.
- Đội: Mirage, Alric, Malik, Set, Juggernaut, Blackburn, Navira đỏ, Navira xanh, Godieth.
- Lượt đầu thêm 160 giant rat thật, kiểm tra cập nhật/vẽ cùng 9 boss. Kích hoạt nhánh victory cưỡng bức, không phải chơi thắng trọn 6 trận.
- Map khởi đầu private 2224,6 MiB. Sau lượt 1..6: 2625,5 / 2622,6 / 2600,3 / 2599,9 / 2746,0 / 2723,2 MiB.
- Texture map giữ 1042,9 MiB sau từng lượt; Lua khoảng 174–177 MiB; weak references tới store trận cũ đều 0.
- Đỉnh private lấy mẫu 3052,9 MiB. Không kết luận mọi leak đã hết, không đồng nhất PrivateUsage với mọi chỉ số Task Manager.
- 9 boss + TẤT CẢ nhóm F1 từng vào/ra được nhưng cũng tái hiện PNG allocation failure / bad allocation khi thiếu bộ nhớ cấp phát. Không coi cấu hình này đã chữa hết OOM.
- Đạt kiểm tra 14 file cú pháp; 1200 truy vấn mục tiêu đúng ID và thứ tự; 12 chu kỳ atlas 2048×2048 trả texture về baseline; 100 chu kỳ teardown kết hợp; cache chữ đúng màu/refcount/ngân sách.
- Benchmark SSO riêng có GC: trung vị 362,241 ms xuống 322,691 ms, khoảng 11%; KHÔNG phải FPS toàn game. Không có GC, bản tái dùng bảng có thể chậm hơn.
- V4.1 đã kiểm tra cú pháp và biểu thức số luồng dùng đúng 2/4/6/8; chưa chạy lại bài dài ở 8 luồng.

## 9. Công cụ thử riêng, nếu còn trên máy

```text
D:\CodexTemp\KRFL_RAM_v4_20261023
D:\CodexTemp\KRFL_RAM_v4_1_check
D:\CodexTemp\KRFL_Boss9_Crash_20261022\runtime\love-probe.exe
```

- Runtime thử là LÖVE 0.10.2/LuaJIT từ EXE game, không phải LÖVE 11; không giả định Image:release có sẵn.
- Các thư mục test full có junction trỏ về workspace live. Không ghi qua junction và không xóa đệ quy toàn thư mục scratch mà chưa kiểm tra.
- Test dùng save copy trong bộ nhớ và identity riêng, chặn save/settings. Đọc script trước khi chạy lại; một số đường require có thể đọc file live nếu không preload bản candidate.
- Máy 16 GB RAM, Iris Xe RAM chia sẻ; bộ nhớ cấp phát trống thay đổi theo ứng dụng đang mở. Theo dõi bộ nhớ hệ thống trước phép thử; không stress máy tới OOM chỉ để đo.

## 10. Điều chưa được phép khẳng định

- Atlas mới đã được tích hợp và chạy ổn trong game.
- Sprite render có đầy đủ VFX LoL hoặc đã được QA đẹp/đúng mọi pose.
- Volibear chắc chắn chỉ tốn đúng 65,5 MiB RAM tổng.
- V4.1 đã giải quyết tải chậm hoặc hiện menu chọn slot trong loading.
- Mọi cấu hình 9 boss + F1 đều hết crash, hoặc FPS cả trận tăng 11%.

File bàn giao chỉ ghi trạng thái và việc tiếp theo; lượt tạo file này không sửa mã game, không khởi chạy render lại, không cài mod mới.

## 11. Cập nhật sắp xếp thư mục sau bàn giao

Người dùng tạo `Z_Mod\Sett` và `Z_Mod\Volibear`, yêu cầu gom tài nguyên theo hero.
- Đã chuyển 14 mục riêng của Sett (10 ZIP và 4 ảnh Q) vào `Z_Mod\Sett`.
- Đã chuyển 9 mục riêng của Volibear vào `Z_Mod\Volibear`: thư mục export, ZIP export, script render, GLB, Untitled.blend, 2 ZIP mod cũ, preview V2 và ảnh sprite mẫu.
- `Volibear_Real3D_Preview.gif` đã có sẵn trong thư mục đích, giữ nguyên.
- Gói sửa chung `FL803_FIX_HangCho_Block_Set_Sett_Q.zip`, tài nguyên hero khác và các gói RAM giữ nguyên vị trí.
- File bàn giao chung RAM/Volibear này giữ ở gốc Z_Mod. Các đường dẫn nguồn/export Volibear phía trên đã cập nhật.
- Chỉ di chuyển tài nguyên trong Z_Mod; không thay đổi mã hoặc tài nguyên game đang chạy.