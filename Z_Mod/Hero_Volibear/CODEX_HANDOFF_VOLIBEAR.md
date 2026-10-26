# CODEX HANDOFF — VOLIBEAR PRESTIGE DUALITY DRAGON (KR FL 8.0.3)

**Ngày bàn giao:** 23/10/2026  
**Dự án:** Kingdom Rush FL 8.0.3 (PC / Windows)  
**Repo gốc:** https://github.com/KhangNguyen-ggg/KingdomRushFL-main-8.0.3  
**Nhánh chính để đối chiếu:** `main` — không tự ý ghi đè những thay đổi mới hơn 23/10/2026.  
**Hero ID:** `hero_allied_volibear_prestige`  
**Trang phục:** Volibear Lưỡng Cực Long Trảo – Hàng Hiệu / Prestige Duality Dragon Volibear  
**Khada:** https://modelviewer.lol/model-viewer?id=106009  
**Mục đích:** Bàn giao đầy đủ trạng thái công việc để Codex/người phát triển tiếp tục kiểm thử, sửa lỗi và hoàn thiện hero **không làm hỏng các hero khác, chế độ Infinite Hero hoặc save**.

> **TRẠNG THÁI QUAN TRỌNG:** Đã có bản mod Real3D đóng gói và đã kiểm tra cấu trúc ZIP/CRC; **CHƯA có xác nhận hero hoạt động ổn định trong executable Windows**. Không được đánh dấu “hoàn thành, đã test game” chỉ vì cú pháp Lua hoặc atlas hợp lệ.

## 1. Các tệp bàn giao và lựa chọn phiên bản

### Bản cài đang được ưu tiên

- `Volibear_Real3D_Fix.zip` — **bản khuyến nghị để cài thử**: 43 file, ~15,6 MiB (16.324.394 byte), đường dẫn bên trong đặt **trực tiếp** từ `all/` và `kr3-desktop/`, không cần CMD/PowerShell.
- `Volibear_Real3D_Part1.zip` + `Volibear_Real3D_Part2.zip` — gói tương đương, chia hai ZIP **độc lập** để khắc phục trường hợp lỗi tải; giải nén cả hai vào cùng một thư mục trước khi sao chép.
- `FL803_Volibear_Real3D_COPY_PASTE.zip` — nội dung mod tương ứng nhưng có **một thư mục bao bên ngoài**, nên phải vào thư mục đó mới thấy `all/` và `kr3-desktop/`.

### Tài nguyên nguồn và công cụ

- `prestige_duality_dragon_volibear.glb` — **model 3D nguồn do người dùng cung cấp**; ~18 MB, glTF 2.0, có **1 mesh, 1 skin/skeleton, 90 animation**. Đây là model có animation xương thật, không phải hình AI.
- `Volibear_Real3D_Export.zip` — kết quả Blender render trung gian (~72 MB), 18 nhóm animation kèm ảnh PNG từng frame, atlas và thông tin clip.
- `Volibear_Khada_Render_All_In_One.py` — script Blender tạo bộ render/atlas từ GLB. Giữ lại để render lại ở góc nhìn, độ phân giải hoặc số frame khác.
- `Volibear_Real3D_Preview.gif` — GIF xem trước, **không thay thế kiểm thử trong game**.
- Các bản trước `Volibear_FL803_Prestige_Duality_Dragon.zip`, `FL803_Volibear_COPY_PASTE.zip`, `FL803_Volibear_Muot_V2_COPY_PASTE.zip` dùng ảnh AI/tái dựng; **không dùng làm nguồn animation cuối** trừ khi chủ động làm bản fallback.

### Kết quả kiểm tra tính toàn vẹn (23/10/2026)

| Tệp ZIP | Kết quả CRC | SHA-256 |
|---|---|---|
| `Volibear_Real3D_Fix.zip` | OK | `c2f0a37887e85d40dfa2bb2c0105edaf1c7389e4f2b1bec936a47d44570a0921` |
| `Volibear_Real3D_Part1.zip` | OK | `808b6aaa9cd58f8f173d7a836464d479001dd6708b2246556a89ef3a07a6d874` |
| `Volibear_Real3D_Part2.zip` | OK | `227a6ae80c01053d08b651a50d086a285d18ef59a1fc8499747c7fe54f5ff9ac` |
| `Volibear_Real3D_Export.zip` | OK | `1394fec6dad48d8efb18e7eafab9098edc884163d0b8aae911bc5d799005ef25` |

*CRC chỉ chứng minh ZIP có thể đọc/giải nén; không chứng minh game load được texture, Lua đúng runtime hoặc hero đã chơi được.*

## 2. Cấu trúc gói Real3D đang có

```text
Volibear_Real3D_Fix.zip
├── HUONG_DAN.txt
├── VOLIBEAR_ASSET_REPORT.json
├── all/
│   ├── allied_bosses.lua              # FILE GHI ĐÈ: đăng ký thêm hero
│   ├── allied_volibear.lua            # FILE MỚI: cơ chế hero + P/Q/W/E/R
│   └── volibear_animation_map.lua     # FILE MỚI: ánh xạ các clip vào A.db
└── kr3-desktop/assets/images/fullhd/
    ├── ui_sett_spirit.lua             # FILE GHI ĐÈ: thêm 2 ô icon/portrait Volibear
    ├── ui_volibear_prestige.png       # FILE MỚI: icon/portrait
    ├── go_volibear_<clip>.lua         # 18 FILE MỚI: atlas frame
    └── go_volibear_<clip>.png         # 18 FILE MỚI: atlas texture
```

**Chỉ hai file vốn đã có trong repo bị ghi đè:**

1. `all/allied_bosses.lua`
2. `kr3-desktop/assets/images/fullhd/ui_sett_spirit.lua`

Các file Volibear khác được thêm mới. Nếu game đã được người dùng sửa hai file này sau khi đóng gói, **PHẢI merge từng thay đổi**, không dùng bản cũ chép đè thẳng.

## 3. Hệ thống game đang dùng để nạp Volibear

- `all/allied_bosses.lua`: `M.list[#M.list+1]=require("allied_volibear")`; bộ `M.get(name)` cho phép nhận dạng `hero_allied_volibear_prestige` trong roster boss/hero.
- `all/infinite_heroes.lua`: roster `M.bosses=require("allied_bosses")`; khi spawn, nếu `M.get_boss(name)` tồn tại thì gọi `M.bosses.register(name)`. **Không sửa các danh sách save đội hero để nhét Volibear vào đội 1 bằng tay.**
- `all/allied_boss_common.lua`: `C.create(def)` tạo template hero, `M.decorate` nối khả năng chủ động/tự động, skill và xử lý hero; nhiều phần dùng mẫu `enemy_set` giống Sett. **Volibear chưa dùng native template riêng**, mà dùng `source="enemy_set"` rồi thay sprite, chỉ số và đòn đánh trong `prepare()`.
- `all/volibear_animation_map.lua`: tạo `A.db[hero_prefix.."_<animation>"]={prefix="volibear_<clip>", frames={...}}`.
- `all/allied_volibear.lua`: gọi `volibear_animation_map.register(prefix,A)`, sau đó dùng `compact(...)` rút thời lượng một số animation để phù hợp nhịp trận. Kiểm tra từng `compact()` để tránh hình chưa đi hết tư thế đúng lúc sát thương phát sinh.
- `all/director.lua`: nạp `boss.textures` của những hero đang dùng vào `game.required_textures` tại runtime; bản này khai báo đủ **18 atlas** trong `M.textures`. Không cần sửa director chỉ để load PNG nếu mọi atlas đã có mặt.
- `all-desktop/screen_map.lua`: có `ui_sett_spirit` trong `screen_map.required_textures`, nên dùng chung nhóm UI để thêm hình Volibear mà không phải sửa `screen_map.lua`. Tên sprite là `volibear_prestige_icon` và `info_portrait_volibear_prestige`.
- `lib/klove/image_db.lua`: mỗi file atlas Lua khai báo `a_name`, `size`, `trim`, `a_size`, `f_quad`; engine dùng dữ liệu này để trích frame từ PNG. Các frame dùng tên theo dạng `volibear_<clip>_0001`, không bắt đầu từ `_0000`.

### 18 clip, 341 khung hình nguồn đã đóng gói

| Clip | Số frame nguồn | Mục đích |
|---|---:|---|
| `idle` | 36 | Đứng yên |
| `run` | 19 | Di chuyển (cả hướng trên/dưới tạm dùng cùng clip) |
| `attack1` | 22 | Đánh thường tay 1 |
| `attack2` | 22 | Đánh thường tay 2 |
| `q_intro` | 16 | Q: chuẩn bị |
| `q_attack` | 8 | Q: ra đòn |
| `q_outro` | 25 | Q: kết thúc |
| `w_slash` | 21 | W: cào |
| `e_windup` | 7 | E: chuẩn bị |
| `e_channel` | 24 | E: thi triển |
| `e_idle` | 24 | E: trạng thái chờ/điện tích |
| `r_cast` | 2 | R: khởi động; hiện map dùng 1 frame |
| `r_run` | 19 | R: chuyển động/nhảy |
| `r_impact` | 17 | R: đập đất |
| `r_outro` | 6 | R: thu chiêu |
| `death` | 32 | Chết |
| `respawn` | 26 | Hồi sinh |
| `knockup` | 15 | Hất tung / phản ứng |
| **Tổng** | **341** | **18 atlas** |

Lưu ý: **Số frame nguồn ≠ độ dài `A.db.frames`**. File animation map có thể lặp hoặc chọn bớt các chỉ số để phối thời gian với engine. `A.db` của KR FL sử dụng `FPS` toàn cục (xem `all/animation_db.lua`), không phải FPS tùy ý từ Blender.

## 4. Gameplay hiện đã viết (chuyển thể, chưa xác nhận cân bằng)

**Thông số prototype:** HP 2.800, giáp 35%, kháng phép 18%, tốc chạy 80, đánh thường hai nhịp 120–160 sát thương, hồi 10 HP/giây. Đây là **thiết kế cho KR FL**, không phải chỉ số Riot.

- **P — Lôi Điện Cuồng Nộ:** tích cộng dồn sau đòn đánh; 5 cộng dồn tạo sát thương phép lan vùng, có hồi chiêu nội bộ.
- **Q — Sấm Sét Truy Kích:** tự dùng trong cự ly gần, trình tự `q_intro → q_attack → q_outro`, gây sát thương và choáng.
- **W — Vuốt Rồng Cuồng Nộ:** cào mục tiêu, đánh dấu 12 giây; đánh lại mục tiêu đã đánh dấu hồi máu.
- **E — Thiên Lôi Giáng Hạ:** `e_windup → e_channel`, sát thương phép diện rộng và tự hồi HP.
- **R — Thần Lôi Giáng Thế:** chọn điểm trong tầm 220; di chuyển/nhảy và đập đất gây sát thương, choáng; tăng tốc đánh tạm thời.
- **Death/Respawn:** có clip render tương ứng.

Phần kỹ năng hiện chủ yếu là tác động trong Lua; **VFX sét/hạt/rãnh nứt đất/tiếng kỹ năng đặc trưng Riot chưa được xuất đầy đủ** từ GLB và chưa được phục dựng hoàn chỉnh.

## 5. Trạng thái xác nhận / chưa xác nhận

### Đã xác nhận bằng kiểm tra tệp

- File GLB có **1 mesh, 1 skeleton/skin và 90 animation**.
- ZIP Blender gốc chứa ảnh render + atlas; bản mod tích hợp **18 atlas/341 frame nguồn**.
- Bản Fix có **43 file**; kiểm tra CRC thành công; ZIP chia nhỏ cũng vượt kiểm tra CRC.
- `allied_volibear.lua`, `volibear_animation_map.lua`, bảng đăng ký và atlas đã hiện diện trong gói Fix.

### Chưa xác nhận — tuyệt đối không ghi thành “đã hoàn thành”

- Chưa chạy thử executable Windows thực tế: màn chọn hero, nạp stage, chiến đấu, chết/hồi sinh, quay về bản đồ.
- Chưa đo FPS/VRAM/RAM khi dùng nhiều Volibear hoặc Infinite Hero.
- Chưa kiểm chứng vị trí chân, anchor, hướng nhìn, thời điểm trúng đòn, nhảy R và thời điểm hạ xuống có chính xác trên từng stage.
- Chưa khẳng định animation hoàn toàn mượt, không có nháy khung hoặc lệch pose ở các clip ghép.
- Chưa xác nhận đầy đủ logic P/Q/W/E/R đối với boss, quái bay, quái miễn choáng, target chết giữa chừng và trường hợp nhiều Volibear cùng lúc.
- Chưa xác nhận an toàn save qua các phiên bản/hệ thống Infinite Hero sau nhiều trận.

## 6. Các vấn đề/rủi ro ưu tiên sửa

1. **Kiểm thử runtime load:** vào Hero Room, nhìn icon/portrait; chọn Volibear; vào một stage. Nếu crash, lần theo `require("allied_volibear")`, `C.create()`, `source="enemy_set"`, tiền tố animation và việc nạp 18 texture.
2. **Chỉnh tốc độ animation theo đòn đánh:** `compact("attack1","attack",26)` và `compact("attack2","attack2",26)` đang rút 22 frame nguồn có lặp chỉ số; kiểm tra event trúng đòn tại `hit_time=12/FPS` khớp khoảnh khắc móng vuốt chạm mục tiêu.
3. **Đảm bảo mọi sprite đúng tâm/độ cao:** cấu hình hiện tại `sp.anchor=V.v(0.5,0.13)` và `sp.scale=V.v(0.37,0.37)`. Kiểm tra chân chạm đường, thân không lấn UI và không cắt VFX.
4. **R và xử lý gián đoạn:** R gọi `C.move_form()`, dịch vị trí nhân vật và tăng `offset.y`; bảo đảm dừng/choáng/chết giữa chừng không giữ `offset.y` hoặc vị trí sai. Kiểm tra hình từ `r_cast` rất ngắn và `r_outro`.
5. **Chất lượng góc chạy:** `walk`, `walkUp`, `walkDown` hiện trỏ cùng `run` (chỉ một góc từ GLB), cần render hoặc tái định hướng camera nếu muốn di chuyển nhiều hướng tự nhiên.
6. **Tốc độ nạp và VRAM:** 18 PNG atlas được khai báo cùng lúc; đo RAM/VRAM trên stage đông hero, xem có cần resize hay gom atlas. Không tối ưu bằng cách cố định số sao màn chơi hoặc sửa save.
7. **Kiểm tra mối quan hệ với Sett:** Volibear dùng chung nhóm UI `ui_sett_spirit` và nguồn template `enemy_set`; phải bảo đảm không làm mất portrait/skill icon của Sett và không thay đổi native Sett.
8. **VFX và âm thanh:** thêm riêng hiệu ứng sét, điện giật, Q/W/E/R nếu muốn giống LoL, không sửa mesh gốc một cách phá hủy.

## 7. Cài bản hiện tại thủ công, không CMD/PowerShell

1. **Sao lưu** thư mục game và save. Chép riêng dự phòng `all/allied_bosses.lua` và `kr3-desktop/assets/images/fullhd/ui_sett_spirit.lua`.
2. Giải nén `Volibear_Real3D_Fix.zip`.
3. Kiểm tra ngay ở thư mục vừa giải nén thấy `all/` và `kr3-desktop/`.
4. Sao chép **hai thư mục con** đó vào thư mục gốc KR FL 8.0.3; Windows hỏi thì chọn **Replace** chỉ với các tệp liên quan đã kiểm tra.
5. Nếu đã chỉnh sửa hai file bị ghi đè, **merge thay vì Replace** để không mất commit/mod khác.
6. Khởi động game, vào Hero Room tìm `Volibear Long Trảo - Hàng Hiệu`, thêm vào đội Infinite Hero, chọn một màn dễ để test. Không sử dụng save duy nhất trong lúc thử.

**Nếu file Fix không tải được:** giải nén hai tệp `Volibear_Real3D_Part1.zip` và `Volibear_Real3D_Part2.zip` vào cùng **một thư mục trung gian** rồi cài theo bước 3–6. **Không nối nhị phân hai ZIP**, và không chỉ cài Part1.

## 8. Checklist kiểm thử nghiệm thu (Codex/nhà phát triển tiếp theo)

- [ ] `main` được cập nhật; so sánh 2 file hiện có trước khi merge; tạo nhánh/commit riêng cho Volibear.
- [ ] Có đủ 18 cặp `go_volibear_*.lua` + `.png`, `ui_volibear_prestige.png`, 3 file Lua trong `all/`.
- [ ] Mỗi `A.db` tham chiếu sprite tồn tại; frame nằm trong atlas; `f_quad` không vượt kích thước PNG.
- [ ] Khởi động game không lỗi Lua/texture thiếu; Hero Room có hình đại diện và tên Volibear.
- [ ] Volibear được chọn qua Infinite Hero, xuất hiện đúng đội đã chọn, **không tự chuyển về Đội 1**.
- [ ] Có thể vào stage, thấy đúng chiều lật trái/phải, đi/đứng yên mượt, không kéo theo nền ảnh.
- [ ] Đánh thường luân phiên `Attack1/Attack2`, có sát thương đúng thời điểm chạm.
- [ ] P/Q/W/E/R hoạt động; không kẹt sau cast và không phát skill liên tục sai cooldown.
- [ ] R đáp vào vị trí hợp lệ; sau bị ngắt kỹ năng, hero vẫn di chuyển/đánh được.
- [ ] Chết rồi hồi sinh bình thường, sprite/offset/HP reset đúng.
- [ ] Hero cũ (đặc biệt 3 Sett, Malik, Set, Navira, Godieth) còn hoạt động.
- [ ] Chạy thử nhiều Volibear cùng lúc, kiểm tra RAM/VRAM và FPS.
- [ ] Thoát game/mở lại: save, đội Infinite Hero, tiến trình stage và số sao giữ nguyên.
- [ ] Khi hoàn thành test mới đổi trạng thái PR từ Draft sang Ready hoặc merge lên `main`.

## 9. Quy tắc bàn giao cho AI/Codex tiếp theo

> Đọc tài liệu này và **ưu tiên đối chiếu trực tiếp nội dung repo mới nhất và các ZIP được cung cấp**. Không suy ra rằng hero đã chạy thành công chỉ từ tài liệu. Nếu được yêu cầu sửa lỗi, trước tiên kiểm tra log/ảnh lỗi thực tế rồi mới sửa. Tạo patch tối thiểu, tránh viết lại hoặc ghi đè engine, boss playable, Infinite Hero, save, các hero hiện có. Nếu repo đổi sau 23/10/2026, merge theo diff mới. Mọi thay đổi cần có bước kiểm tra ngược (regression). Ưu tiên **gói copy–paste**, không bắt người dùng chạy CMD/PowerShell. Luôn bàn giao một ZIP chứa đúng hai thư mục `all/` và `kr3-desktop/` cùng README và checklist. Nếu dùng PNG lớn/asset tải bằng Git LFS, chú ý GitHub LFS pointer không phải dữ liệu ảnh thực.

### Tài liệu repo cần đọc trước khi sửa

- `all/allied_boss_common.lua` — cấu trúc template/skills/summon.
- `all/allied_bosses.lua` — đăng ký hero.
- `all/infinite_heroes.lua` — lọc roster, đội và spawn, bảo vệ save.
- `all/allied_sett.lua`, `all/sett_visuals.lua` — ví dụ hero có custom sprites, hiệu ứng và kỹ năng.
- `all/animation_db.lua` — cách engine lấy frame/fps.
- `lib/klove/image_db.lua` — cách nạp atlas và trích quad.
- `all/director.lua` — nạp `boss.textures` theo hero đang dùng.
- `all-desktop/screen_map.lua` — Hero Room, chọn hero, `ui_sett_spirit`.
- `kr3-desktop/assets/images/fullhd/` — atlas PNG/Lua thực tế.

**Tiêu chí hoàn thành cuối cùng:** Volibear chơi được trong game thật, animation chuyển động lấy từ GLB (không dùng AI giả frame), kỹ năng và hồi sinh ổn định, không hỏng các hero cũ/save, không tăng tải tài nguyên vô lý, có gói copy–paste đã kiểm tra thực tế.
