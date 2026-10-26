# Phân tích RAM FL 8.0.3 / 8.0.5 và bản vá F1 — 25/10/2026

Nguyên nhân chênh lệch lớn được khoanh vùng ở tài nguyên F1 nạp sẵn. Người dùng xác nhận hai lần đo không cùng tùy chọn; thử tắt F1 bổ sung trên 8.0.3 cũng giảm RAM. Không có bằng chứng 8.0.5 mặc nhiên tiết kiệm 1 GB trên cùng cấu hình.

## Số đo đúng màn người dùng nêu

LÖVE/LuaJIT Windows thật, màn 2-27 (level_idx=87), bản sao slot 3 (slot_2.lua), Volibear + Navira, toàn bộ F1 bật trong bản sao kiểm thử. Không bật/tắt gì trong save thật. Tắt ghi slot/settings trong harness. Độ phân giải kiểm thử 1280×720; ảnh fullhd giữ nguyên; 8 worker; mỗi lượt 180 update/draw, sau đó về map. Đây không phải chơi hết wave.

| Mốc | Private MiB | Working Set MiB | Texture MiB |
|---|---:|---:|---:|
| 8.0.3 trước vá, trong trận ổn định | 4946.2 | 4950.7 | 1940.6 |
| Sau vá, trước khi dùng mục F1 | 2846.3 | 2878.3 | 927.0 |
| Sau vá, đã mở mục F1 và tải xong | 4821.1 | 4849.1 | 1940.6 |
| Sau vá, quay về map | 2440.8 | 2478.4 | 1044.6 |

Trước khi dùng F1: giảm khoảng 2099.9 MiB private (2.05 GiB, khoảng 42%) trong phép thử này. Texture giảm 1013.6 MiB. Mức giảm ở máy/màn/đội khác có thể khác.

Đỉnh private toàn phép thử trước vá: 5162.5 MiB. Sau vá, bao gồm lần nạp toàn bộ F1 giữa trận: 5529.1 MiB. Bản vá giảm tài nguyên nạp sẵn; không bảo đảm giảm đỉnh RAM nếu cuối cùng vẫn gọi toàn bộ F1. Sau khi mở mục F1, RAM tăng trở lại tương ứng với tài nguyên thực sự đã nạp.

## So sánh 8.0.5 và những phần không chép sang

- love.dll, lua51.dll và SDL2.dll hai bản giống SHA-256. Entity DB giống mã. Với 221 tên texture ở phép thử màn 56, 261 file PNG/DDS tương ứng so được đều giống byte giữa hai bản; không thấy giảm chất lượng ảnh trong tập đã kiểm tra.
- 8.0.5 mặc định image_db_uses_canvas=false; 8.0.3 hiện tại là true. Chỉ đổi cờ này ở 8.0.3, cùng màn 56/tướng/F1: private ổn định 4548.1 → 5467.1 MiB. Vì vậy giữ Canvas của 8.0.3.
- 8.0.5 giữ thường trú 20 nhóm atlas và worker dùng push không chờ tiêu thụ; 8.0.3 hiện tại đã bỏ giữ thường trú và dùng supply để chặn tích lũy kết quả giải mã. Không chép ngược hai hành vi đó.
- Với toàn bộ F1 trong bản sao save, hai phép thử 8.0.5 đã bị bộ theo dõi dừng khi vượt ngân sách: khoảng 5853.7 MiB mặc định và 5724.5 MiB khi bật Canvas. Đây là số lúc đang tải, không phải số ổn định trong trận; không dùng chúng để tuyên bố RAM ổn định của 8.0.5 là 5–6 GB.
- Đối chứng nhẹ trên cùng màn 56, cùng Catha và cùng tùy chọn: 8.0.3 private 1815.4 MiB, texture 660.6; 8.0.5 private 2408.4 MiB, texture 671.7. Trong đối chứng này 8.0.5 không ít RAM hơn.
- Các ảnh Volibear đang có tổng khoảng 137.5 MiB RGBA nếu đều nạp; đây là chi phí mod thêm, không đủ để một mình giải thích toàn bộ chênh lệch lớn. Không xóa hoặc giảm chất lượng chúng.
- Thử _heapmin() của CRT sau GC: private không đổi (4494.2 MiB). Không thêm mẹo trim Working Set hoặc giả làm giảm dữ liệu sống.

## Bản vá thực hiện

1. director.lua tách các ảnh chỉ phục vụ mục F1 bổ sung thành hai danh sách chờ theo đúng scale cũ. Tướng/đội đang chọn, tháp đang chọn, tài nguyên màn, phép và icon giao diện vẫn đi qua đường tải bình thường.
2. game_gui.lua gọi nạp danh sách chờ trước khi thực hiện mua/nâng cấp vào Goldfinger, g5_special_buy hoặc tower_hero_buy_e. Các mục con nhận đủ ảnh trước khi được dùng. Lần đầu có thanh tiến trình ở đáy; thời gian mô phỏng không nhảy theo thời gian chờ tải.
3. Khi tải xong, các nhóm mới nhập vào danh sách tài nguyên của trận để đường unload cũ trả đủ chủ sở hữu. Lần gọi sau không nạp lại. Restart tiếp tục dùng các ảnh đã tải; trận mới có danh sách chờ mới.
4. Khôi phục phần bộ nạp v4.2 đã có trong gói cũ nhưng chưa có ở live: nhận luân phiên kết quả worker, gom GC; lỗi giải mã/worker dừng hoặc thiếu ảnh sẽ báo lỗi thay vì vào trận thiếu texture. Giữ giới hạn kết quả chờ và số worker theo menu.

Không sửa F1, đội, tiến độ, save/settings, chỉ số, giới hạn hero, font, PNG/DDS hoặc DLL. Không đưa mã tính thưởng/sát thương của 8.0.5 vào 8.0.3.

## Kiểm chứng và giới hạn

- Cả 3 file biên dịch bằng LuaJIT đi kèm game.
- Các kiểm tra nhỏ đạt: worker lỗi, worker dừng, đếm upload thiếu, đường upload thành công, quyền sở hữu nhóm chờ, gọi nạp lần hai không tăng chủ sở hữu.
- Runtime màn 56/Catha: cờ F1 vẫn bật; trước khi bấm F1, private 2529.2 MiB; gọi đúng TowerMenuButton.on_click để mua g5_special_buy; tải đủ ảnh F1 của baseline; tiếp tục cập nhật/vẽ rồi về map, không ghi nhận thiếu ảnh.
- Runtime màn 2-27/Volibear + Navira: xác nhận đủ hai boss thật trong entities; thử cùng đường bấm F1; kiểm tra các ảnh F1 bổ sung của baseline đã có; lần gọi thứ hai không tăng atlas ownership; quay lại map texture về 1044.6 MiB. Không so nhầm ảnh nền màn 56 với màn 87.
- Chưa chơi hết mọi wave, mọi loại mua F1 hoặc chạy nhiều giờ. Không đo mức tăng FPS. Tài nguyên F1 đang tải theo một lô vào lần dùng đầu, chưa tách riêng từng hero/tháp. Chỉ riêng thay đổi này không làm RAM thấp mãi sau khi người chơi dùng hết F1.
- Số thời gian trong log là các lượt riêng có cache I/O/driver khác nhau; không coi chênh lệch thời gian của chúng là benchmark tách riêng một hàm.

Raw metrics, process snapshots, nguồn harness và self-check nằm trong KIEM_THU. exit_code=null trong process.json là hạn chế lấy mã thoát của runner PowerShell; kết quả đạt dựa vào assert và kết quả PASS do chính harness ghi, không suy ra exit code native bằng 0.
