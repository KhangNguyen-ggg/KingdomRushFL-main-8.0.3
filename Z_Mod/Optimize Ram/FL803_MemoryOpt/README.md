# FL803_MemoryOpt — Tối ưu RAM & độ mượt cho Kingdom Rush FL 8.0.3

Ngày: 23/10/2026. Bản vá dựa trên commit `325549d` của
https://github.com/KhangNguyen-ggg/KingdomRushFL-main-8.0.3

---

## 1. Chép file

Mở thư mục game (thư mục chứa file `.exe` `Kingdom Rush FL_Alliance-FL8.0.3.exe`).

**Chép đè 5 file sau, giữ nguyên đường dẫn:**

| File trong ZIP | Chép đè lên |
|---|---|
| `all/exoskeleton.lua` | `<thư mục game>\all\exoskeleton.lua` |
| `all/systems.lua` | `<thư mục game>\all\systems.lua` |
| `all/game.lua` | `<thư mục game>\all\game.lua` |
| `all/director.lua` | `<thư mục game>\all\director.lua` |
| `dove_modules/perf/memory_guard.lua` | `<thư mục game>\dove_modules\perf\memory_guard.lua` (file MỚI) |

**KHÔNG** chép thư mục `_BACKUP_ORIGINAL/` vào game. Nó chỉ để bạn rollback.

Nếu thư mục game của bạn **không có** `dove_modules/perf/` thì tạo thư mục đó trước.

---

## 2. Rollback

Copy ngược 4 file trong `_BACKUP_ORIGINAL/all/` đè lên `all/` của game,
rồi **xoá** file `dove_modules/perf/memory_guard.lua`.
Game trở về đúng trạng thái gốc.

---

## 3. Bản vá này làm gì

Tất cả đều là **dọn bộ nhớ**, không đổi gameplay, không giảm đồ họa,
không giảm particle, không giảm âm thanh, không đụng file save,
không đặt trần số hero.

### P0-1 — Rò rỉ exoskeleton (nguyên nhân lớn nhất)

`all/exoskeleton.lua`

Mỗi lần vào trận, `all/systems.lua` gọi `EXO:load(...)` với danh sách
exoskeleton của màn. Mỗi file `.exo3` được parse thành bảng Lua
(parts / animations / keyframes / frames). **Không có đường nào giải phóng
lại sau khi rời màn.**

Cơ chế có sẵn `EXO:unload()` / `EXO:unload_all()` nhưng:
- `all/gg_views.lua:1575` là nơi **duy nhất** gọi `EXO:unload()` (màn xem exo),
- `EXO:unload_all()` bản gốc chỉ giải phóng được **0.7 MB** — tức gần như không.

**Đo thật** (LuaJIT, nạp đúng danh sách exo của `all/systems.lua`):

```
200 file exo  ->  122.7 MB bảng Lua
bản gốc, unload_all()  ->  giải phóng được   0.7 MB
bản vá, release_level_exoskeletons()  ->  giải phóng 120.9 MB
nạp lại sau khi release  ->  chạy OK, không lỗi
```

Thêm vào đó:
- `EXO:load()` nay tái dùng exo đã có trong cùng màn thay vì parse lại file.
- `release_level_exoskeletons()` **giữ lại** exo loại `kui`, vì màn map dùng
  chung singleton `exoskeleton` và gọi `EXO:f()` để vẽ — xoá sẽ vỡ màn map.

### P0-2 — Thả module theo màn

`all/game.lua` — hàm mới `game:release_level_modules()`

Mỗi màn nạp `data.levels.<tên>_data`, `_waves`, `game_scripts*`,
`game_templates*`, `game_animations*`. Sau khi rời màn, chúng bị đưa ra khỏi
`package.loaded` để GC thu hồi được. Lần sau vào màn sẽ nạp lại từ file.

### P1 — Cache texture chữ

`all/systems.lua` — `sys.texts`

Bản gốc đặt tên texture chữ là:
```lua
string.format("text_%s_%s_%s", entity.id, sprite_id, store.tick)
```
→ **đổi tên theo từng tick**. Mỗi lần entity chữ được re-insert là sinh một
LÖVE `Image` + `Canvas` + `ImageData` mới, dù nội dung chữ y hệt nhau.
Trong map đông quân, đây là nguồn sinh texture hàng loạt.

Bản vá cache theo **nội dung chữ thực sự** (text + size + font + màu + scale),
giới hạn 400 mục, đếm reference, giải phóng theo FIFO. `sys.texts:clear_cache()`
xóa sạch khi rời màn.

### P2 — Memory guard

`dove_modules/perf/memory_guard.lua` (file mới), nối vào `all/director.lua`

- Dọn rác tăng dần **mỗi 2 giây** trong lúc chơi (`collectgarbage("step")`),
  thay vì đợi một lần thu gom toàn phần có thể không bao giờ tới.
- **Một lần thu gom toàn phần** đúng lúc rời màn — sau khi dữ liệu màn, exo và
  texture chữ đã được giải phóng.
- Cho phép **đo** thay vì đoán:
  - **F9** — bật/tắt khung số liệu Lua heap trên màn hình.
  - **F10** — bật/tắt phần dọn rác định kỳ (để so sánh A/B).

---

## 4. Cách đo lại trên máy bạn

Bấm **F9** rồi đi theo trình tự, ghi lại cột **Working set (MB)** của tiến trình game:

| Mốc | RAM bạn ghi trước đây | Ghi sau bản vá |
|---|---|---|
| Chọn slot | ~300 MB | |
| Màn map | ~2780 MB | |
| Đang load | >5000 MB | |
| Vào màn trung bình | 5500–5700 MB | |
| Map đông (nhiều text) | >6000 MB, crash | |

Cách đo: Task Manager → Details → cột **Working set** (bộ nhớ thực tế).
Nhớ đo cả tiến trình, không chỉ cửa sổ game.

Quan trọng: **đo cả 2 nhóm** —
1. chơi 1 màn rồi thoát, vào map, vào màn khác (RAM có **giữ nguyên** ở mức ban đầu
   là bản vá này đang hoạt động);
2. chơi liên tiếp 5–8 màn (RAM **không còn leo thang** như trước).

---

## 5. Những gì bản vá này CHƯA xử lý

Nói thẳng để bạn không tưởng là đã xong:

1. **`E:load()` re-parse 21.7 MB source, tốn ~520 ms mỗi lần (đo được).**
   `all-desktop/screen_map.lua` có **7 chỗ** gọi `E:load()`, và mỗi chỗ đều
   nối tiếp bằng `UPGR:set_all_generation_levels()` + `DI:set_level()` — tức
   cần template sạch, nên **không thể bỏ qua** mà không sửa luôn logic patch.
   Đây là ứng viên CPU nặng nhất còn lại nhưng tôi **chưa sửa** vì sửa sai sẽ
   làm hỏng template và game không chạy. Cần làm riêng, có kiểm thử.

2. **Texture atlas / VRAM chưa đo được.** Repo GitHub này **không có** file PNG
   atlas của game (chỉ có 9 file PNG; `.gitignore` loại phần asset). Phần RAM
   còn lại có thể nằm ở texture LÖVE trên máy bạn — tôi không có file đó để đo,
   nên không dám sửa mò. Nếu sau khi cài bản vá này mà RAM vẫn >4 GB, cần bạn
   gửi thư mục `data/` hoặc ảnh chụp Task Manager, tôi sẽ làm tiếp phần nạp texture
   theo yêu cầu (gói C) dựa trên số đo thật.

3. **Chưa chạy thử trên Windows.** Tôi chỉ kiểm tra được bằng LuaJIT compile
   (`luajit -bl`) và bằng probe mô phỏng nạp exo. Không có môi trường LÖVE đầy đủ
   ở đây. Số liệu 120.9 MB là **đo thật trên LuaJIT**, còn mức giảm RAM cuối cùng
   trên máy bạn thì **chưa xác minh được** — cần bạn đo như mục 4.

---

## 6. File nào đã sửa

| File | Thay đổi |
|---|---|
| `all/exoskeleton.lua` | thêm `EXO.session_level`, `EXO:release_level_exoskeletons()`; `EXO:load()` tái dùng exo đã nạp |
| `all/systems.lua` | đếm `EXO.session_level` khi vào màn; thay `sys.texts` bằng bản cache theo nội dung |
| `all/game.lua` | `game:destroy()` gọi release exo + `clear_cache()` + `release_level_modules()` + full GC; thêm `game:release_level_modules()` |
| `all/director.lua` | require + `init/update/draw` memory_guard; F9/F10 |
| `dove_modules/perf/memory_guard.lua` | **file mới** |

Tất cả 5 file đã qua kiểm tra cú pháp bằng LuaJIT 2.x.