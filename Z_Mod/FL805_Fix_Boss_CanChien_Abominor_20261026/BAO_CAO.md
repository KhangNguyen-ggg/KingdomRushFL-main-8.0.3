# Sửa boss đồng minh đánh hụt Abominor — 26/10/2026

## Chẩn đoán

Đã xác nhận phản ánh về boss đồng minh tay ngắn ở Abominor dạng 1–4.

Vị trí cận chiến được tính bằng `enemy.enemy.melee_slot` cộng `soldier.melee_slot_offset`. Abominor đặt điểm đứng chặn cách tâm 63, 70, 90, 90 đơn vị ở bốn dạng đầu. Với Blackburn, cộng thêm 25 đơn vị thành 88/95/115/115; đòn AOE thường chỉ có bán kính khoảng 63,83 và không có độ lệch điểm trúng về phía trước. Nó vung đòn đúng vị trí nhưng tâm Abominor nằm ngoài vùng sát thương.

Juggernaut, Set, Mirage, Alric, Malik, một số dạng/vị trí của Godieth và Lich King cũng hụt theo cơ chế này. Hai Navira có bán kính 120 nên không hụt trong ma trận đã kiểm tra. Sett và Volibear dùng nhánh đánh đơn mục tiêu; phép đo này không chỉ ra cùng lỗi AOE ở chúng.

## Bản sửa

Chỉ thay `all/script_utils.lua`.

Thêm kiểm tra tiếp xúc với rìa thân của **mục tiêu chính đang bị boss đồng minh chặn**. Dùng chính `enemy.melee_slot` làm mốc tiếp xúc. Nếu tâm mục tiêu vốn nằm trong vùng AOE, giữ kết quả cũ. Nếu mục tiêu rời xa, không có tiếp xúc thì vẫn đánh hụt.

Hai điểm gọi dùng chung kiểm tra mới: `y_soldier_do_single_area_attack` và `y_soldier_do_loopable_melee_attack`. Giữ bộ lọc `damage_flags`/`damage_bans`, quy tắc đánh ký sinh hiện có, thứ tự và giới hạn số mục tiêu. Lính/hero thường không có `boss_kind` tiếp tục dùng phép kiểm tra cũ. Mục tiêu phụ không nhận vùng tiếp xúc mở rộng.

Không sửa dữ liệu hoặc script Abominor, chỉ số các boss, bán kính AOE, hồi chiêu hay cách đứng chặn.

## Dạng 5

`boss_crocs_lvl5` có `vis.bans = F_BLOCK`, tắt đòn cận chiến và dùng bước giẫm. Vì vậy nó không bị lính/boss đồng minh chặn đường. Đây là cơ chế của dạng cuối, không phải bất tử. Kiểm tra bằng hệ thống HP xác nhận dạng 5 vẫn nhận sát thương vật lý. Bộ chọn mục tiêu cận chiến dựa trên `F_BLOCK` vẫn bỏ qua nó sau bản sửa.

## Kiểm tra

Khởi chạy LÖVE/LuaJIT Windows cùng runtime game trên bản sao riêng, vào màn 2-27 với 14 tướng/boss mod để nạp đầy đủ template/animation. Dùng bản sao slot 3 trong bộ nhớ, stub các thao tác ghi save/settings.

- Đo 600 bố cục tầm đánh bằng hàm vị trí chặn và ellipse gốc.
- Chạy 288 đòn AOE với coroutine tấn công, cập nhật hoạt ảnh và hệ thống HP của game: các đòn AOE của roster hiện tại, Abominor dạng 1–4, ba hạng chặn và hai hướng đứng.
- Trước sửa: 174/288 lần không gây giảm HP. Sau sửa: 0/288 lần hụt.
- Kiểm tra lính thường giữ hành vi cũ, mục tiêu rời xa không bị đánh từ xa, giữ cờ miễn AOE/cấm đánh bay/cấm chọn mục tiêu vách đá.
- Kiểm tra mục tiêu phụ ngoài bán kính cũ không bị trúng, mục tiêu phụ trong bán kính cũ vẫn trúng, quy tắc đánh ký sinh và nhánh AOE lặp vẫn hoạt động.
- Dạng 5 vẫn có `F_BLOCK`, không phải mục tiêu chặn hợp lệ và vẫn nhận sát thương qua hệ thống HP.
- File vá và các fixture biên dịch bằng LuaJIT cài cùng game.

CSV và kết quả trước/sau nằm trong `KIEM_THU`. Các phép kiểm tra dùng fixture ở vị trí cận chiến, không thay cho việc chơi hết trận Abominor với mọi đội/buff/mức tăng cường.
