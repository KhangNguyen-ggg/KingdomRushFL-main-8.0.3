# 📋 Bàn giao công việc — Phân tích tràn RAM mod Kingdom Rush Origins

> Ngày bàn giao: **2026-10-22** · Người bàn giao: Khang Nguyen · Người nhận: **Chế độ Code**
> Mục đích: chuyển toàn bộ kết quả phân tích RAM + các bản vá đã làm sang phiên làm việc code để tiếp tục triển khai, kiểm chứng và vá các nguồn ăn RAM còn lại.

---

## 1. Bối cảnh dự án

- **Repo:** `KhangNguyen-ggg/KingdomRushFL-main-8.0.3` (public, branch `main`)
- **Base game:** Kingdom Rush Origins (`kr3-desktop-4.2.10`)
- **Engine:** LÖVE2D 0.10 + **Lua 5.1** (không có `goto` như Lua 5.2+, chú ý khi viết code)
- **Asset:** đầy đủ trên git, dùng **Git LFS**
- **Convention bàn giao cũ:** các ZIP nằm trong thư mục `Z_Mod/`, đặt tên theo mẫu `FL803_*.zip` (BACKUP / CAP_NHAT / HUONG_DAN / MANIFEST / KIEM_TRA_LUA)

### ⚠️ Quy tắc bắt buộc khi sửa file .lua

- File .lua của mod dùng **TAB thụt lề, KHÔNG dùng space**. Khi vá hoặc soạn lại phải **giữ nguyên byte** (đừng để editor tự convert).
- **GitHub App chỉ có quyền read** → không commit bản vá lên repo được; mọi bản vá đóng gói ZIP và gửi qua Google Drive.

---

## 2. Tóm tắt vấn đề

Khi chơi mod lâu hoặc thoát/restart trận giữa chừng, RAM tăng liên tục và không giảm → nghi ngờ tràn RAM (memory leak). Đã phân tích trên:

- **P1 phân tích ở base commit `6e33473`**
- **P2 phân tích ở HEAD `acc9f8d`** (cả hai ngày 2026-10-22)

---

## 3. Nguyên nhân đã xác định

### 3.1 Đã vá bởi P1 (commit `6e33473`)

**Nguyên nhân chính — leak qua `wait_signal`:**

- Hàm `wait_signal` trong `all/systems.lua` đăng ký closure **giữ cả `store`** vào signal registry toàn cục.
- Handler chỉ được `signal.remove` khi coroutine chạy hết → **thoát/restart trận giữa chừng làm `store` bị giữ vĩnh viễn** (reference leak).
- GC yếu: chỉ `collectgarbage("step")` 1 bước/frame trong `main.lua`.

**Yếu tố phụ chưa vá lúc đó:**

- Font cache tăng theo size 0.5px (`lib/klove/font_db.lua`)
- Spike nạp atlas 16 thread khi vào level
- 20 atlas persistent
- InfiniteHero deepclone entity

### 3.2 Đã vá bởi P2 (HEAD `acc9f8d`)

Sau khi P1 vá xong, user cài thêm mod (Sett / Navira / Godieth / Blackburn / Malik + 2 font EBGaramond) → RAM stack lại. Phân tích HEAD cho thấy:

- **Gói SETT không chứa `systems/game/main`** → P1 **không bị ghi đè**, vẫn còn hiệu lực.
- **Nguyên nhân mới:**
  - **(a)** `EXO:load` trong `sys.level:init` parse lại **toàn bộ exoskeleton mỗi level** rồi ghi đè, **không có chỗ nào gọi `EXO:unload`** → hàng chục MB rác mỗi level.
  - **(b)** Cache font trong `lib/klove/font_db.lua` lưu **vĩnh viễn** theo cặp tên + size; **size ≤ 6px không quantize** (mỗi 0.5px = 1 font mới); `font_db:load` chỉ chạy 1 lần khi khởi động (`main.lua:522`).

---

## 4. Các bản vá đã bàn giao (hoàn thành)

### P1 — Vá leak `wait_signal` (3 file) ✅

- Tracking `wait_signal` handler trên `store._wait_signal_handlers`
- Dọn handler trong `game:destroy()`
- GC step 512 khi heap > 400 MB (trong `main.lua`)
- **File:** `FL803_GiamRAM_FixWaitSignal.zip` — [Google Drive](https://drive.google.com/file/d/1kVWDHMDWbZCc4ftEZa3ad4zkHxgkQfq1/view?usp=drivesdk)
- Trạng thái: user cài và **xác nhận RAM giảm**.

### P2 — Vá font cache + exoskeleton (2 file) ✅

- `all/exoskeleton.lua`: tái sử dụng exo đã load (bỏ parse lại mỗi level)
- `lib/klove/font_db.lua`: quantize **mọi size font về số nguyên**
- **File:** `FL803_P2_GiamRAM_Font_Exo.zip` — [Google Drive](https://drive.google.com/file/d/138ujtmxpEIwbRsI_ajao1exg7xGU4nv1/view?usp=drivesdk)
- ⚠️ **Lưu ý đã nói với user:** nếu mod mới ship đè `exoskeleton.lua` / `font_db.lua` thì **P2 mất, cần vá lại**.

---

## 5. Việc còn tồn đọng (chưa vá) — giao cho Chế độ Code

| # | Việc | Vị trí | Ghi chú |
|---|------|--------|---------|
| 1 | **Deepclone hero trong InfiniteHero** | `all/infinite_heroes.lua` | Nguồn ăn RAM lớn nhất chưa được giảm. |
| 2 | Spike nạp 16 thread atlas khi vào level | (atlas loading) | Chưa giảm; cân nhắc chunk/queue load. |
| 3 | 20 atlas persistent | (atlas manager) | Chưa giảm; cân nhắc unload atlas không dùng. |
| 4 | GC vẫn yếu ở baseline | `main.lua` | P1 đã cải thiện (step 512 khi > 400 MB) nhưng có thể tinh chỉnh thêm. |

---

## 6. Kiến thức đã kiểm chứng (không cần phân tích lại)

- ✅ `all/infinite_heroes.lua` (mod InfiniteHero, loadout hero không giới hạn qua `slot.liuhui_hero`) **KHÔNG dùng** signal / wait_signal / collectgarbage / deepclone ở mức hệ thống — chỉ thao tác trường `store.*` và save slot → **bản vá RAM không ảnh hưởng chức năng mod này** (đã kiểm chứng 2026-10-22, commit `6e33473`).
- ✅ Các mod hero (`allied_*.lua`, `*_enhance.lua`) đều **không dùng signal**; coroutine nằm trong update entity; `entity_cache` gắn trên `store` → **sạch**, không cần vá.

---

## 7. Checklist cho Chế độ Code khi tiếp nhận

- [ ] Đọc repo `KhangNguyen-ggg/KingdomRushFL-main-8.0.3`, xác nhận HEAD hiện tại để biết P1/P2 có bị mod mới ghi đè chưa.
- [ ] Kiểm tra `all/systems.lua`, `all/exoskeleton.lua`, `lib/klove/font_db.lua` ở HEAD: nếu khác bản P1/P2 → vá lại theo mô tả mục 4.
- [ ] Làm việc còn tồn đọng #1 (deepclone InfiniteHero) trước — nguồn ăn RAM lớn nhất.
- [ ] Giữ quy ước: TAB thụt lề, giữ nguyên byte, ZIP theo `FL803_*.zip` trong `Z_Mod/`, không commit lên repo (GitHub App read-only).
- [ ] Sau mỗi vá: đóng gói ZIP + hướng dẫn cài cho user (user tự cài và xác nhận RAM qua Task Manager).

---

*Báo cáo đầy đủ ngữ cảnh dự án nằm trong Knowledge `projects` (chủ đề KingdomRushFL).*