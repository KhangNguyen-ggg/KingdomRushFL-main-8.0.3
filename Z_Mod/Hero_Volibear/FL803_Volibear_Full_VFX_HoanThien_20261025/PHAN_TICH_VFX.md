Volibear skin09: hoàn thiện VFX chiến đấu cho KR_FL 8.0.3

Bản trước có 15 nhóm hiệu ứng ngắn, chủ yếu là ghép các texture phẳng.
Phần W2 chưa dùng mesh đầu thú; E chưa có rồng cảnh báo; R chưa có lớp
duy trì suốt 12 giây. Nội tại chỉ nháy theo chu kỳ khi đủ cộng dồn. Sét
lan chụp vị trí lúc phát nên địch di chuyển có thể làm tia sét rời mục tiêu.
Đánh thường/W đặt theo khoảng lệch cố định, chưa bám bone tay/đầu.

Phạm vi thay đổi đã đi qua các điểm gọi sau:

| Phần | Điểm gọi và hành vi hình ảnh |
| --- | --- |
| Đánh thường | `FX.tick` phát tích lực khi animation đổi; `fn_damage` phát vệt tay và nổ tại địch. |
| Nội tại | `FX.tick` quản lý tay/vai theo cộng dồn; `on_hit` nối tia sét bằng ID các mục tiêu. |
| Q | `automatic` phát lúc kích hoạt; tick tạo dấu chân theo khoảng cách; animation Q có vệt vung tay; mốc trúng phát nổ. |
| W | `automatic` phân biệt W1/W2; vết cào, dấu W, đầu thú và hồi máu có vòng đời riêng. |
| E | `automatic` báo trước; `passive` giữ mốc trúng 2 giây, thêm vết đất và khiên; callback sát thương phát ánh khiên/vỡ. |
| R | `active` phát báo đích/bay/tiếp đất; `tick` theo `ult_end` để duy trì và kết thúc hào quang. |
| Chết/hồi sinh | Tick phát tan linh hồn một lần khi chết; callback hồi sinh báo tick phát ánh trở lại. |
| Tài nguyên | Danh sách atlas chỉ thêm `go_volibear_vfx_complete`; các tên dùng trong code đều có atlas tương ứng. |

Các nhóm VFX sau cập nhật (30 nhóm):

`aura`, `windup`, `slash`, `hit`, `chain`, `p_charge`,
`q_cast`, `q_charge`, `q_step`, `q_swing`, `q_hit`, `q_impact`,
`w_hit`, `w_mark`, `w_chomp`, `heal`,
`e_warning`, `e_hit`, `e_ground`, `shield`, `shield_hit`, `shield_break`,
`r_warning`, `r_leap`, `r_hit`, `r_ground`, `r_form`, `r_end`, `death`, `respawn`.

Vị trí bám lấy từ GLB đang dùng, chiếu qua đúng camera 30 độ và cùng
anchor/scale với các atlas chiến đấu cũ và atlas chuyển động 8 hướng.
LUT có 1.077 tư thế, mỗi tư thế chứa hai tay, đầu và hai vai. Các giá trị
là số tĩnh; không giữ tham chiếu tới nhân vật hay store của màn chơi.

Nhịp hình Q trước đây để tay còn giơ khi sát thương đã xảy ra ở giây 0,30.
Giữ 15 tick hình trong 0,50 giây, sắp lại thời điểm 8 tư thế để tư thế chạm
đất xuất hiện ở giây 0,30. Callback sát thương và độ dài chiêu không đổi.
Đánh thường thứ nhất dùng tay phải, thứ hai dùng tay trái. Đồng bộ hình
tiếp xúc ở 35% thời gian đòn đánh; vẫn giữ đủ 22 tư thế của mỗi đòn. W
giữ đủ 21 tư thế, đặt hình tiếp xúc ở mốc sát thương 0,25/0,75 giây.

Nguồn gốc: đối chiếu texture, màu và các giai đoạn trong `skin9.bin.json`
bản [CommunityDragon 14.24](https://raw.communitydragon.org/14.24/game/data/characters/volibear/skins/skin9.bin.json).
W_Chomp tham chiếu mesh `Volibear_Skin9_W2_BearHead01.skn`, texture thân và
mask răng; cảnh báo E tham chiếu DragonModelAnim01; R_Buf_Max có thời lượng
12 giây và phần EndFlash. Các bảng emitter nguồn đã được rút gọn vào thư
mục NGUON để đối chiếu. Thông số gameplay không lấy lại từ BIN skin này.

44 tile bổ sung gồm các texture/tile hoạt ảnh gốc và các góc render từ hai
mesh nguồn. Chuyển texture additive nền đen sang alpha, giữ sắc độ và làm
mềm mép tile để tránh lộ hình chữ nhật. Không dùng ảnh AI thay mesh nguồn.

Giới hạn kỹ thuật: rồng OBJ chưa có rig VFX đi kèm, nên dùng mesh uốn theo
vòng và các góc render; đầu thú W2 phát bằng chuyển động/phóng thu. Không
phải bản nhập nguyên hệ shader và bộ mô phỏng hạt của LoL. Những hệ LoL
ngoài chiến đấu như emote, biến về, vô hiệu hóa trụ địch không có điểm gọi
tương ứng trong hero KR hiện tại.

Việc giải phóng: hiệu ứng chỉ giữ ID, có thời hạn; đánh dấu W xóa ID khi
tháo; hiệu ứng bám kiểm tra chủ/mục tiêu; vệt chuẩn bị đánh tắt khi stun
hoặc đổi animation. Không thêm actor chiến đấu, timer toàn cục, bộ đệm
trận cũ, cơ chế tải hoặc cơ chế giữ ảnh mới. Atlas bổ sung 4 MiB RGBA và
đã được thử tải/tháo ba chu kỳ bằng 8 worker, không giữ lại trong image DB.

Đã thử mô phỏng 10 Volibear đánh liên tục 60 giây, mỗi đòn lan đủ 5 mục
tiêu trong nhóm 8 địch: đỉnh 90 thực thể VFX;
tất cả biến mất sau khi các chủ sở hữu chết. Đây là phép thử vòng đời và
giới hạn số lượng, không dùng để suy ra FPS hay RAM toàn trận thực tế.
