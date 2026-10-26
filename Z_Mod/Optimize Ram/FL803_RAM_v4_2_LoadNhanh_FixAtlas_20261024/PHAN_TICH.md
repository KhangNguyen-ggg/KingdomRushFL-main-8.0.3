# Kiểm tra tải ảnh và RAM — 24/10/2026

## Lần chơi thử slot 3 trước đó

Lần chơi xem thử màn 5-22 không chép patch, sửa mã hoặc thay đội hình/F1.
Chỉ có thao tác trong game; game có thể tự lưu tiến độ/thống kê của slot 3.
Ba file director.lua, image_db.lua, sound_db.lua hiện có thời gian sửa
24/10 lúc 14:15, khớp lần chép gói sửa Volibear/load trước phiên chơi xem thử.
Không coi thời gian sửa file là bằng chứng đã đối chiếu toàn bộ ổ đĩa.

## Vì sao bản trước tối ưu RAM tải nhanh hơn

1. Bản trước giữ vĩnh viễn 20 nhóm atlas phổ biến, nên lần sau không phải
   phân tích, giải mã và upload lại những nhóm đó. v4 bỏ phần giữ này để
   giảm RAM ở map. Tải lại khi vào trận là chi phí có thật của lựa chọn đó.
2. v4.1 vẫn dùng 8 worker đúng thiết lập, nhưng main thread chạy full GC
   sau MỖI ảnh từ 2048×2048 trở lên. Heap bản đồ/template lớn khiến mỗi
   lần quét đắt. Upload GPU và GC vẫn chạy trên main thread; 8 worker không
   thể làm các bước này chạy song song. Phép thử 8 nhóm ảnh với heap sống
   khoảng 230 MiB xác nhận phần lớn thời gian cũ nằm trong full GC.
3. Vòng while của từng worker tiếp tục nhận thêm ảnh sau mỗi GC dài;
   trong khi đó các worker khác chờ main nhận kết quả. v4.2 nhận một ảnh
   mỗi worker rồi gom GC cuối lượt, giữ đường giải mã được luân phiên.
4. F1 gọi thêm nhóm hero/tháp làm danh sách ảnh/âm thanh tải lớn hơn. Bản
   vá không đổi các mục đó, không đổi số quái/hero hay chất lượng hình.

Trung vị phép thử riêng: **13.286 → 3.374 giây**.
Không suy ra cả màn sẽ nhanh lên cùng tỷ lệ. Không khẳng định mọi trường
hợp load lâu đều do GC; âm thanh, script, dữ liệu màn, driver và lượng
tài nguyên yêu cầu vẫn ảnh hưởng thời gian chờ.

## Khung hình lỗi tại Vez'nan Tower

- Màn được nhận diện là level56, KR1 màn 12. Hình khung thoại lấy từ
  go_stage56.lua, sprite boss_veznan_taunts_love_0001, ảnh go_stage12-1-1.png.
- PNG đang đúng; kiểm tra pixel sau upload Canvas cho khung thoại,
  phần tháp và Vez'nan đều khớp các pixel không trong suốt trong PNG.
- Lỗi xác nhận được: khi I:i(atlas) trả nil, SpriteBatch cũ giữ texture
  của lượt vẽ trước, nhưng thêm quad của sprite bị thiếu vào đó. Vì vậy
  có thể hiện biểu tượng/ảnh không liên quan trong khung thoại hoặc FX.
  Đây là lỗi bộ vẽ đã có; việc tải lại/giải phóng nhiều hơn làm nó dễ lộ
  nếu xảy ra thiếu texture, không chứng minh bản RAM tạo ra lỗi bộ vẽ này.
- Lỗi xác nhận được: worker dừng do lỗi giải mã thì mã cũ chỉ log, bỏ
  worker rồi vẫn báo tải xong. Bản vá báo lỗi tải rõ ràng và kiểm tra số
  ảnh hoàn thành trước khi vào màn.
- Chưa bắt được chính lần giải mã lỗi của ảnh người dùng. Thiếu RAM là
  khả năng phù hợp với lỗi PNG/OOM đã gặp trước, chưa phải kết luận cho
  ảnh này. Khởi tạo lại từ map hai lượt với một boss + tháp ba phần đầu
  không gặp thiếu ảnh. Không dùng kết quả đó để kết luận đội nặng đã ổn.

## Phạm vi và kiểm tra

Chỉ 2 file payload. Không sửa live code, save, đội hình hoặc F1.
Kiểm tra LuaJIT/LÖVE 0.10.2 thật; chạy riêng, cửa sổ ẩn, save đọc bản sao
trong RAM và các hàm lưu bị thay bằng no-op trong harness kiểm thử.

Xem KIEM_TRA.txt để biết kết quả gốc, gồm benchmark và đường vào màn
Vez'nan có khung thoại + chữ runtime. Các kiểm thử không thay cho việc
chơi toàn bộ chiến dịch hoặc stress toàn bộ F1 với đội boss trong ảnh.
