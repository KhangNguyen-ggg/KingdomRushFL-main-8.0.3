# CODEX_HANDOFF — Kingdom Rush FL 8.0.3

Ngày bàn giao: **12/10/2026, giờ Việt Nam**. Người dùng: **Khang**. Ngôn ngữ trao đổi: **tiếng Việt**.

Tài liệu này tổng hợp cuộc trò chuyện về Việt hóa, font, InfiniteHero, bảo vệ save, tối ưu và boss đồng minh. Đây là trạng thái bàn giao kỹ thuật, không phải khẳng định mọi bản vá đã được chạy trên Windows. Những đoạn mã và báo cáo còn trong workspace đã được đọc lại khi lập tài liệu.

## 1. Đọc phần này trước khi tiếp tục

1. **Nền hiện tại là FL 8.0.3**, không còn là 8.0.1 được nhắc ở đầu cuộc trò chuyện.
2. Người dùng đã xác nhận ba boss **Blackburn, Juggernaut, Set** chạy được; sau sửa cách nạp tài nguyên, **Navira cơ bản cũng đã được xác nhận chạy thành công**.
3. Sau đó đã phát hành Navira đầy đủ kỹ năng, Hammerhold gồm Mirage/Alric/Malik, và thay Spectro bằng Godieth.
4. Trọng tâm gần nhất là **Malik địch ở đấu trường Campaign và Malik đồng minh**, đặc biệt ngai, lời thoại, hoạt ảnh và hiệu ứng.
5. Người dùng xác nhận **King Malik đã hiện trên ngai** sau bản sửa trước. Sau đó báo còn thiếu khung thoại và lặp động tác giơ búa mở màn tới lúc nhảy xuống.
6. Bản mới nhất đã gửi: **`FL803_Malik_Thoai_HoatAnh_KyNang.zip`**. Đã kiểm tra Lua và đối chiếu tài nguyên KR4. **Chưa có phản hồi người dùng rằng đã cài/thử thành công bản mới nhất này.** Không ghi “đã hết lỗi trong game”.
7. Lần đối chiếu trước khi làm bản Malik mới nhất, GitHub `main` vẫn chứa bản trước sửa ngai. **Không coi GitHub luôn mới bằng ZIP đã giao.** Trước khi sửa tiếp, so sánh mã trên máy người dùng, GitHub và payload ZIP mới nhất.
8. Yêu cầu ngay trước tài liệu này là tạo handoff để Codex tiếp tục. Không có lỗi mới nào được người dùng báo sau ZIP Malik mới nhất.

## 2. Repository, tài nguyên và môi trường

| Nguồn | Vai trò |
|---|---|
| https://github.com/KhangNguyen-ggg/KingdomRushFL-main-8.0.3 | Repository FL của người dùng; ưu tiên dữ liệu/chỉ số riêng của mod |
| https://github.com/KhangNguyen-ggg/Kingdom-Rush-Vengeance-v1.16.2.6 | Dữ liệu KR4/Vengeance để đối chiếu sprite, animation, màn và thoại Malik |
| https://www.facebook.com/groups/614164973065643/permalink/1782378782910917/ | Bài người dùng hỏi về kết nối server và `Block_Game_Internet.bat`; không tự coi nội dung bài là kết luận bảo mật |

- FL đang dùng Lua/LÖVE, thư mục mã có `all`, `all-desktop`, `kr3`, `kr3-desktop`, `lib`, `dove_modules`, `main.lua`.
- Dữ liệu KR4 chứa nhiều `.plist` và atlas PNG. Không chép script/engine KR4 nguyên xi vào FL.
- Mã hành vi gốc KR4 không có dưới dạng Lua tương đương để dùng trực tiếp; các triển khai hành vi mới là thích nghi cho FL. Không tuyên bố giống 100% bản gốc chỉ từ việc khớp sprite.
- Workspace của phiên ChatGPT: `/workspace/scratch/c022069f23a1`.
- Đường dẫn này là môi trường cũ, **không phải đường dẫn game trên Windows của người dùng**, và có thể không tồn tại trong VS Code Codex mới.
- Phiên trước có Lua 5.4 qua thư viện hệ thống/Python ctypes, có thể đọc mã và kiểm tra mô phỏng. **Không có môi trường chơi game Windows đầy đủ để đo FPS/RAM/VRAM hoặc kiểm chứng trực quan cuối cùng.**
- Kho GitHub FL trước đây thiếu một phần asset và strings. Không suy ra một file không tồn tại trong bản game chỉ vì không thấy trên GitHub.
- Không có bằng chứng bản Malik mới nhất đã được push lên repository; sản phẩm đã giao là ZIP.

## 3. Yêu cầu và lựa chọn phải giữ

### 3.1. Việt hóa và font

- Văn phong tự nhiên; đối chiếu tên riêng với bản tiếng Anh và nguồn phù hợp. **Elynie**, không phải Annie; không nhầm tên người dùng nhớ gần đúng như “Evelyn”.
- Giữ tên màn bằng tiếng Anh, ví dụ **Gray Ravens**; giữ **Casual / Normal / Veteran / Impossible**.
- Giữ tên chế độ **Campaign / Heroic / Iron** và các tiêu đề Challenge tương ứng bằng tiếng Anh. Người dùng gọi nhóm này là “độ khó” trong một số tin nhắn; thực tế cần giữ cả tên chế độ và độ khó.
- Nút đổi bản đồ phần 6 phải là **Genesis**, không phải “Khởi đầu mới”.
- Bản font người dùng chọn sau cùng là **Soup of Justice cho toàn bộ phần Việt hóa**. Trước đó có bản Soup/Garamond và Bangers/Patrick Hand; không tự quay về các bản cũ.
- Chữ sáng, dễ đọc, tránh chìm vào nền; không cắt dấu Việt.
- Khi bản dịch tràn/thiếu ký tự, dùng câu tiếng Anh gốc nếu tra được; không tự bịa câu thay thế. Giữ cơ chế co chữ khi phù hợp.
- Mã locale của bản Việt hóa vẫn là **`zh-Hans`**, nhãn hiển thị là “Tiếng Việt”. Đừng chuyển hàng loạt sang `vi` làm đứt đường nạp.

### 3.2. InfiniteHero, đội và save

- Chế độ thứ ba trên map: Một tướng → Hai tướng → Vô hạn.
- **Không áp trần số hero/boss/bản sao hoặc số đội trong code.** Bản giới hạn 8 hero là phương án cũ đã bị thay thế theo yêu cầu người dùng.
- Chọn đội trên map, đội được spawn khi bắt đầu màn; không buộc người dùng tạo thêm từng hero trong trận.
- Có nhiều đội độc lập theo slot save, thêm/bỏ/nhân bản/chuyển/xóa đội. Cho phép nhiều bản sao cùng hero.
- Nút **Xóa đội màu đỏ**; giữ ít nhất một đội. Tên và thứ tự các đội khác không bị phá.
- Bố cục cuối: hai nút đổi đội **dưới hai nút đổi trang**; **Nhân bản dưới Thêm**; **Xóa đội dưới Bỏ**.
- Trong trận, ô skill hero nằm **trên ba phép thường**, kích thước ngang ô phép; thanh phân trang riêng trên chân dung, không đè nút skill. Giữ chế độ một/hai hero và các ô skill chủ động vốn có.
- **Không tự cấp 1/2/3 sao, không mở toàn bộ stage, không tạo slot debug có sẵn tiến độ.** Sao kiếm được qua chơi thật vẫn giữ.
- Không tự sửa/xóa số sao trong save đang có để “sửa lỗi”; không thể suy ra tiến độ thật đã mất.
- Giữ cơ chế `.bak`, `.corrupt`, từ chối ghi save không hợp lệ và xử lý lỗi ghi. Không thay save người dùng bằng file mẫu.

### 3.3. Boss, hiệu năng, cách giao bản vá

- Boss vào đội InfiniteHero như hero, có thể chọn và điều khiển điểm đứng.
- **Skill boss tự dùng**, không yêu cầu người dùng bấm ô kỹ năng. Đây là lựa chọn sau cùng, thay cho bản skill chủ động cũ.
- Boss hiển thị cùng danh sách hero; avatar và ảnh lớn dựa trên encyclopedia.
- Tách **mỗi boss một module** để dễ tìm lỗi; giữ phần chung nhỏ, sửa đúng nguyên nhân.
- Juggernaut: ném bom gọi **7 Golem Head**, cooldown **10 giây**, riêng từng bản sao, tính lại khi thả bom.
- Navira đồng minh: sát thương đánh thường **cơ bản min=max=280**. Buff/giáp/hệ số game vẫn áp dụng; **không sửa sát thương Navira địch**.
- **Spectro đã được thay bằng Godieth**. Giữ chuyển ID đội cũ `hero_allied_spectro` → `hero_allied_godieth` theo thứ tự/số lượng.
- Tối ưu cả game nếu có bằng chứng, ưu tiên không giảm đồ họa, texture, particle hoặc âm thanh; không đổi FPS/tick/cân bằng một cách ngầm định.
- Người dùng thích **ZIP nhỏ, ghi rõ chép thư mục/file nào**, kèm rollback. Không bắt tải lại game khoảng 3 GB khi chỉ cần vài file.
- Không đồng nhất “test tải 12 boss” với “12 loại boss mới”: đó là 12 thực thể, gồm bản sao trong roster 8 loại hiện có.

## 4. Lịch sử công việc và các bản đã làm

### 4.1. Việt hóa 8.0.1 → 8.0.3

- Ban đầu nhận thư mục strings 8.0.1, sau đó người dùng chuyển sang 8.0.3 và đưa repository.
- Biên tập strings đã Việt hóa, chuẩn hóa tên riêng; mở rộng tới chuỗi tiếng Trung nằm trực tiếp trong Lua/UI, tài liệu tháp, lựa chọn phép, UH và tiện ích.
- Hướng dẫn gói ghi nhận đã rà 694 file Lua; bộ đang dùng khoảng 17.902 giá trị chuỗi. Đây là thống kê của lần làm bản dịch, không phải số liệu quét lại repository hiện tại.
- Giữ tên stage/độ khó tiếng Anh, bổ sung Genesis và cải thiện font/màu.
- Có các gói: `FL803_VietHoa_BienTap.zip`, `FL803_VietHoa_DayDu_TenMan_English.zip`, `FL803_VietHoa_Genesis_Font_Comic.zip`, `FL803_VietHoa_SoupOfJustice_Garamond.zip`, cuối cùng `FL803_VietHoa_SoupOfJustice_ToanBo.zip`.
- Soup đã chỉnh metrics để tránh cắt dấu; EB Garamond Bold bổ trợ ký hiệu Soup thiếu. Chữ Việt chính do Soup cung cấp.
- `GGLabel` và mô tả stage có cơ chế đo khung rồi lấy tiếng Anh gốc. Không bao phủ tự động mọi `text_runs`, chuỗi ghép động, chữ trong ảnh hoặc nội dung online.
- Người dùng từng không tải được file đính kèm. Khi giao lại, đảm bảo tạo file thật và link tải hoạt động.

### 4.2. InfiniteHero và bảo vệ save

- Tạo chế độ InfiniteHero và các điểm tích hợp nạp/tạo hero, map, HUD.
- Lỗi bấm stage: đã tái hiện `screen_map.lua` gọi `i18n.english_for` khi ghép với bản i18n cũ không có hàm. Đã thêm kiểm tra tồn tại hàm; giữ fallback tiếng Anh trên bản Soup toàn bộ.
- Sửa vị trí/kích thước skill và phân trang theo yêu cầu đã được người dùng đính chính.
- Sau crash đội quá đông và hiện tượng mọi màn thành 2 sao, đã làm bảo vệ save và bỏ logic tạo tiến độ debug. Không có bằng chứng có thể khôi phục toàn bộ sao cũ nếu đã ghi đè và không còn backup.
- Có bản thử giới hạn 8 nhưng sau đó đã làm **vô hạn + nhiều đội + xóa đội đỏ** theo yêu cầu rõ ràng của người dùng.
- Gói `FL803_InfiniteHero_NhieuDoi_BaoVeSave.zip` gom các sửa InfiniteHero, bấm stage, HUD, save; các bản boss sau kế thừa phần này.

### 4.3. Spell/item

- Gói `FL803_Spell_KhongGioiHanLuot.zip` thay **`all/power_selection.lua`**.
- Bỏ giới hạn số lần mỗi trận cho: rương chiến lợi phẩm, túi cứu thương, Vez'nan's Wrath, Hand of Midas và Wrath of Elynie. Dùng cơ chế `nil` không giới hạn sẵn có.
- Giữ cooldown, giá, hiệu ứng và điều kiện chọn mục tiêu; bỏ dòng mô tả giới hạn lượt. Không phải vô hạn vật phẩm trong inventory.
- Hai tên đã đối chiếu:

| Tên Việt | Tên Trung | ID | Cách đọc tiếng Anh từ ID |
|---|---|---|---|
| Sừng sững trên đỉnh núi | 独立兮山之上 | `yao_spirit_blessing` | Yao's Spirit Blessing |
| Nhân duyên hội ngộ | 因缘际会 | `shaosiyuan_fateful_bond` | Shaosiyuan's Fateful Bond |

Hai cách đọc tiếng Anh trên **không phải tên chính thức đã xác minh**.

- Hồi chiêu item ở `all/power_selection.lua`: tham số thứ tư của `cheat_item_option(...)` hoặc `kro_item_option(...)` là giây; ví dụ Vez'nan `990, 180` nghĩa là giá 990, cooldown 180.
- Cooldown hiệu dụng còn qua `selected_power_cooldown()` / `spell_mode_cooldown()` trong `all-desktop/game_gui.lua` và `GS.mode_power_cooldown_factor` trong `kr3/game_settings.lua`.
- `mermaid_gift` có công thức riêng trong HUD, không chỉ sửa bảng chọn phép.

### 4.4. Boss đồng minh: triển khai rồi quay lại nền ổn định

1. Làm Blackburn trước, sau đó thêm Juggernaut, Set, Navira, Spectro, Mirage, Alric, Malik vào InfiniteHero.
2. Có bản đầy đủ skill chủ động; sau yêu cầu mới chuyển sang skill tự động, ảnh encyclopedia và giảm giữ dữ liệu thừa.
3. Người dùng báo Set tàng hình, Juggernaut ném Golem Head quá dày, màn xanh chỉ hiện Memory. Đã sửa tài nguyên Set, cooldown Juggernaut và handler lỗi.
4. Set cần **`go_enemy_set`**, đối chiếu màn gốc `level89_data.lua`; trước đó dùng nhóm không đúng. Trong bản tách module, sửa frame/alias và hai dạng nằm trong `all/allied_set.lua`; `allied_set_render.lua` cũ không còn cần.
5. Người dùng báo chỉ ba boss Juggernaut/Set/Blackburn chạy, năm boss khác crash. Đã phát hành gỡ boss nhưng giữ InfiniteHero, rồi dựng lại ba boss thành từng module.
6. Người dùng xác nhận **ba boss này chưa thấy vấn đề**.
7. Navira cơ bản thêm lại vẫn crash lúc vào stage. So với bản skill chủ động chạy được, khôi phục thứ tự/nhóm texture: `encyclopedia_creeps`, `rebborn_enemy_icons`, `go_stage119` ở tỉ lệ game thường.
8. Người dùng xác nhận **“chạy thành công”** sau bản khôi phục nạp tài nguyên. Chưa chứng minh toàn bộ nguyên nhân crash cũ chỉ có một lỗi; đây là thay đổi có bằng chứng và có xác nhận thực tế.
9. Sau đó phát hành `FL803_Navira_FullSkills_TuDong.zip`.
10. Phát hành `FL803_Hammerhold_Godieth_Navira280.zip`: thêm lại Mirage/Alric/Malik, thay Spectro bằng Godieth, Navira ally 280.
11. Người dùng thấy các boss còn thiếu/khựng hoạt ảnh; riêng màn Malik không có cảnh ngồi trên ngai và wave 15 đi bộ như creep. Từ đây chuyển trọng tâm sang đối chiếu KR4 và sửa Malik.

### 4.5. Bộ skill đồng minh hiện tại

| Boss | Module | Dữ liệu nguồn / các điểm cần giữ |
|---|---|---|
| Blackburn | `all/allied_blackburn.lua` | `eb_blackburn`; đạp đất/choáng, gọi Skeleton Knight, di chuyển/chết/hồi sinh |
| Juggernaut | `all/allied_juggernaut.lua` | `eb_juggernaut`; missile, bom 7 Golem Head / 10 giây |
| Set | `all/allied_set.lua` | `enemy_set`; trụ, cường hóa lính, hào quang lửa, dạng 2, sửa frame/atlas |
| Navira | `all/allied_navira.lua` | `boss_navira`; lốc, tia linh hồn, ngưỡng máu, hấp thụ Specter, melee cơ bản 280 |
| Mirage | `all/allied_mirage.lua` | Boss Hammerhold; dao, né để lại phân thân, tối đa 4 Nomad; khoảng nghỉ chung né/triệu hồi 8 giây |
| Alric | `all/allied_alric.lua` | Boss Hammerhold; Flurry, 3 Sand Warrior, lốc cát tốc độ ×6 trong 3 giây, hồi 40 giây |
| Malik | `all/allied_malik.lua` | `enemy_malik`; búa sét / 4,5 giây, nhảy / 12 giây, đập đất phép + choáng / 13 giây |
| Godieth | `all/allied_godieth.lua` | `eb_balrog`; phun độc, vùng độc 10 giây, DoT, chuyển xác phù hợp thành Shadow Spawn đồng minh |

Navira đầy đủ: lốc tự động 25 giây, 6 giây, tốc độ ×1,25, aura 15 magic/0,25 giây bán kính 40; ngưỡng HP 90%/60%/15% mỗi ngưỡng một lần mỗi lượt sống; tối đa 3 tia, stun gốc 5 giây; hồi 320 HP từ Specter đã chết gần đó, cooldown 10 giây, mỗi xác chỉ một Navira nhận. Một số điều kiện/cooldown là cách thích nghi sang phe mình, không gán thành hành vi KR5 nguyên xi.

Không chạy nguyên script boss địch cho ally: script địch có thể khóa tháp, gọi wave, kết thúc trận hoặc ghi sự kiện boss chết. Ally phải có vòng đời hero và sát thương đúng phe.

### 4.6. Tối ưu toàn game và crash log

- `FL803_Game_Optimization.zip` sửa sáu file: `all/game.lua`, `all/systems.lua`, `all/utils.lua`, `all/utils_123.lua`, `all/utils_4.lua`, `all/utils_v.lua`.
- Dọn tham chiếu trận cũ từ simulation/UI khi thoát; tái sử dụng hàm ease/tween; dọn coroutine đã kết thúc ở tick kế tiếp, giữ lịch cũ.
- Không giảm đồ họa, không đặt giới hạn hero; kết quả mô phỏng không chứng minh hết tràn RAM của tiến trình Windows.
- `FL803_CrashLog_ThuMucGame.zip` thay `main.lua`: ghi `KRFL_crash_log.txt` cạnh thư mục game nếu ghi được, có đường dự phòng thư mục dữ liệu LÖVE; màn xanh hiển thị đường log và traceback.
- Dấu nhận diện bản log: **`CRASHLOG_VISIBLE_20261010`**, có `SESSION START` lúc mở game. **`SESSION START` không phải báo cáo crash; cần mục `CRASH` và stack trace.**
- Bản log riêng được tạo trên commit `a12353da285921ee2be488fb0bd7a29b8d97116e`; không chép mù `main.lua` cũ lên bản người dùng đã chỉnh thêm.
- User từng không thấy log. Chưa có stack trace Windows xác nhận những crash cũ của 5 boss trong phần lịch sử này. Đừng bịa đường `%APPDATA%` cụ thể khi chưa đọc `love.filesystem.getSaveDirectory()`/identity thực tế.

### 4.7. Các câu hỏi phụ đã nêu, không biến thành kết luận chưa có chứng cứ

- Upload game khoảng 3 GB lên GitHub; có cần thoát game khi đẩy repo; câu hỏi về số luồng tối đa ở launcher.
- Chụp màn hình lấy hình ứng dụng trước, lần hai mới ra game: có báo cáo người dùng, **chưa có bản vá chụp màn hình đã được xác nhận**.
- Kết nối server/cập nhật khi load game và `Block_Game_Internet.bat`: có thư mục điều tra `fl803_network_audit/`. Mã updater có HTTP worker và địa chỉ tải; điều đó không tự chứng minh malware, vị trí server hoặc nội dung tải “không rõ”. **Chưa có bằng chứng trong bàn giao rằng firewall đã được áp trên máy người dùng hay chức năng mạng đã bị loại hoàn toàn.**
- Muốn hướng dẫn cường hóa hero FL tới 8.0.3: đối chiếu tài liệu/chỉ số của mod trước khi lấy vanilla. Không coi tài liệu cũ là bản mô tả mọi thay đổi mới nhất.

## 5. Bản Malik mới nhất — chi tiết để sửa tiếp

### 5.1. Baseline và lỗi được xác định

- Malik địch: `enemy_malik`; scene: `stage36_malik_throne`.
- Đấu trường FL: **level 186**, tương ứng dữ liệu KR4 **level 36**, chỉ cảnh boss Campaign, kích hoạt vào **wave 15**.
- Slot 3 mở khóa sẵn do tác giả là môi trường người dùng test; không có bằng chứng slot 3 là nguyên nhân mất ngai/hoạt ảnh. Không chỉnh save để chữa lỗi này.
- Ngai bị mái/khán đài che: scene vốn ở lớp vẽ không phù hợp. Bản trước nâng trên `Z_OBJECTS_COVERS`, tách ghế tĩnh và cho Malik nhảy thực sự từ ngai.
- Bản scene trước cho `sitTauntLoop` làm idle vô hạn; chưa tạo khung thoại.
- Chuỗi **walk chỉ khai báo 26/52 khung** cho các alias layered; kỹ năng cắt phần hồi động tác sau hit/release.
- **Đính chính quan trọng:** có cập nhật trung gian nói combat idle trỏ nhầm ghế; đọc lại cuối cùng cho thấy layered combat idle **đã là frame 237**. Lỗi thật là thiếu walk và scene idle dùng taunt loop. Không sửa combat idle về frame 1.
- Hiệu ứng đáp từng bị rút xuống 10 khung thay vì 18; thiếu đăng ký/sử dụng vài hiệu ứng đánh đất/phá tháp.
- Đánh dấu thắng ngay lúc HP hết có thể cắt cảnh gục xuống/lời cuối.

### 5.2. Chín file cài của ZIP mới nhất

| Đường dẫn tính từ gốc game | Thay đổi |
|---|---|
| `all/malik_presentation.lua` | Mới; helper thoại, vị trí khung, dọn khung, chờ hết animation, tạo FX |
| `all/allied_malik.lua` | Skill ally đủ recovery, FX, hướng đạn, alias chết đầy đủ |
| `all/allied_boss_common.lua` | Tùy chọn `rotate`, `hit_offset`, `fx_duration` cho projectile; chỉ Malik bật các tùy chọn mới |
| `all/level_utils.lua` | Chờ boss có `enemy.wait_for_death_animation` tới `health.death_finished_ts` trong hai hàm kiểm tra còn địch |
| `kr3/game_scripts-45e.lua` | Scene, thoại, skill enemy, jump, death/victory, luồng level 186; tích hợp bản ngai trước |
| `kr3/game_templates-45e.lua` | Template dialogue, FX, bóng Malik; cờ chờ chết; melee vùng |
| `kr3/data/game_animations_merge_g4.lua` | Đủ walk, alias ngồi nghỉ/vào-ra thoại, `allyDeath` |
| `kr3/data/malik/taunt_orange.png` | Nền thoại 240×92 ghép 9 phần từ ảnh KR4 |
| `kr3/data/malik/taunt_orange_arrow.png` | Mũi khung thoại gốc KR4 |

### 5.3. Luồng và hành vi đã triển khai

- Ngồi `sitIdle` → hai dòng INTRO một lần → nghỉ.
- Khiêu khích định kỳ: `sitTauntIn` → `sitTauntLoop` trong lúc hiện chữ → `sitTauntEnd` → ngồi nghỉ; xen cười/tức giận. Không giơ búa lặp từ đầu đến wave 15.
- Khi `exit=true`: ngắt thoại cũ, hai dòng PRE_FIGHT, xóa khung, chạy `sitJump` đủ 57 khung. Ghế tách thành decal đứng lại.
- Nhảy từ ngai: chuẩn bị 28 frame, chuyển vị trí trong 19 frame tiếp, cung nhảy cao 60; kết thúc tại node 45 của path KR4 rank 3 → path FL 4. Boss bắt đầu `destination_index=2` vì scene đã dùng điểm đầu.
- Combat jump: chuyển vị trí trên không; phục hồi z/bans/tốc độ/vị trí nếu chết hoặc choáng. Sát thương lúc đáp sau mốc 0,3 giây rồi chờ nốt `jumpLand`; chạy hết danh sách điểm, không lặp mãi điểm cuối.
- Walk đủ 52 frame trên hai lớp, hướng walk/up/down.
- Đập thường có ground decal; enemy melee type `area`, radius 60, tối đa 8 mục tiêu, số sát thương khai báo 172–216 được giữ.
- Enemy special phá tháp có tia sét/vụ nổ, chờ hết special; ally special chuyển sang magic/stun vào địch, không phá tháp người chơi.
- Enemy taunt dưới sân dùng `taunt`, điều kiện không có blocker, khoảng 25 giây.
- Enemy chết: death → deathLoop + hai câu END → deathEnd → báo hoàn tất/cleanup.
- Ally chết dùng alias 570–669 (100 frame), sau đó chu kỳ hồi sinh hero hiện có; không gọi lời cuối/kết quả thắng của enemy.
- Module thoại dùng `body_bold` theo cấu hình font hiện có, chữ `{255,244,215}`; dịch riêng nếu locale `zh-Hans`/`vi` hoặc không tra được khóa.
- PNG nạp lười qua `I:add_image`, dùng lại; text texture do hệ thống `texts` tạo và dọn; mỗi owner chỉ có một khung thoại sống.

### 5.4. Mốc hình gốc KR4 đã kiểm tra

Hai lớp `malik_layer1` và `malik_layer2` cùng khoảng frame:

| Trạng thái gốc | Frame | Ghi chú ở FL |
|---|---:|---|
| idle | 1 | Ngồi; alias FL `sitIdle` |
| sitAngry | 2–57 | Tức giận |
| sitTauntIn | 58–63 | Vào thoại |
| sitTauntLoop | 64–97 | Đang nói |
| sitTauntEnd | 98–110 | Kết thúc thoại |
| sitLaugh | 111–179 | Cười |
| sitJump | 180–236 | Nhảy khỏi ngai |
| idleWalk | 237 | Đứng dưới sân; alias FL `idle` |
| walk | 238–289 | 52 frame |
| melee | 290–343 | 54 frame |
| range | 344–388 | 45 frame |
| jumpLaunch | 389–424 | 36 frame |
| jumpTravel | 425–431 | Loop trên không |
| jumpLand | 432–460 | 29 frame |
| special | 461–525 | 65 frame |
| taunt | 526–569 | 44 frame |
| death | 570–602 | 33 frame |
| deathLoop | 603–636 | 34 frame |
| deathEnd | 637–669 | 33 frame |

FX: `malik_attack_floor_decal` 27 frame; `malik_jump_decal` 18; `malik_towerdestroction_ray` 16; `malik_towerdestroction_explotion` 50; `malik_attack_ray` 20; `malik_attack_ray_modifier` 6. **Giữ đúng cách viết `destroction`/`explotion` của asset**, đừng sửa chính tả ID.

Tài nguyên Malik cần `go_stage186` và `kr4_level36_malik`. Hiệu ứng nằm trong atlas level36 PC đối chiếu với `go_stage186`; không cần nạp thêm toàn bộ sandstorm chỉ để dùng các FX này.

### 5.5. Nguồn KR4 cụ thể

Các đường dẫn trong repository Vengeance:

- `KR4/Animations/Enemies/Sandstorm/malik_animations.plist` và các animation plist được include.
- `KR4/Sprites/SD/Gameplay/LevelsExtra/kr4_level36_malik.plist` + PNG.
- `KR4_PC/Sprites/SD/Ingame/kr4_level36_pc.plist` + PNG.
- `KR4_PC/Sprites/SD/Ingame/kr4_level36_2_pc.plist` + PNG.
- `KR4/Sprites/SD/Common/kr4_common.plist` + PNG: `taunt_orange`, `taunt_orange_arrow`.
- `KR4/Level/level36_data.plist`, `KR4/LevelModes/Campaign/level36_campaign.plist`.
- `KR4_PC/Localization/Localized_en`: các khóa `ENEMY_MALIK_INTRO_TAUNT_*`, `BATTLE`, `PRE_FIGHT`, `END`.

## 6. Trạng thái lỗi và phần còn phải làm

| Vấn đề | Trạng thái chắc chắn tại bàn giao | Việc tiếp theo |
|---|---|---|
| Malik không hiện trên ngai | Người dùng xác nhận đã hiện sau bản scene trước | Giữ lớp vẽ/ghế tách, tránh regression |
| Không có khung thoại; lặp giơ búa mở màn | Đã sửa trong ZIP mới nhất, Lua test qua; chưa có xác nhận chơi thật | Ưu tiên thử Campaign từ đầu màn |
| Malik thiếu/khựng hoạt ảnh, FX | Đã bổ sung ranges/recovery/FX; đối chiếu atlas qua | Xem thực tế lúc đánh, ném, special, nhảy, chết |
| Kết quả thắng cắt cảnh chết | Đã thêm chờ riêng Malik và test qua | Thử giết Malik, kể cả khi không còn creep |
| Navira load crash | Bản cơ bản sau sửa resource đã được user xác nhận chạy | Giữ nhóm và tỉ lệ texture; test skills nếu có lỗi mới |
| Các boss khác thiếu hoạt ảnh | Báo cáo chung của user vẫn là việc chưa kiểm chứng hết | Sau Malik, xử lý từng boss dựa trên triệu chứng/nguồn gốc |
| Set tàng hình ở các bản cũ | Đã có sửa và sau đó user xác nhận bộ 3 ổn định | Không khẳng định vẫn lỗi hiện tại; kiểm tra nếu tái diễn |
| Crash do đội quá đông / RAM | Có giảm cấp phát và giữ tham chiếu; không có đo Windows | Đo RAM tiến trình theo trận/thoát trận, phân biệt lượng entity thật với leak; không áp cap trái yêu cầu |
| Save toàn stage 2 sao | Đã bỏ tạo tiến độ debug và thêm backup | Không tự phục hồi sao bằng phỏng đoán; chỉ từ backup hợp lệ |
| Log không thấy | Đã giao handler ghi cạnh game và dự phòng | Xác nhận đang dùng đúng main.lua; cần CRASH + traceback khi lỗi |
| Screenshot lấy khung cũ | Chưa xác định nguyên nhân/chưa có fix được chứng thực | Chỉ điều tra tiếp nếu user vẫn cần |
| Kết nối mạng/updater | Có audit mã trước đây; chưa kết luận đầy đủ về mọi dữ liệu tải | Đọc lại call sites, endpoint và thao tác tải/ghi/chạy trước khi kết luận |
| Tràn chữ/chữ trong ảnh | Có fallback một số UI; chưa xem mọi màn | Theo ảnh/file thực tế, không hứa tất cả nội dung động đều đã Việt hóa |

**Không có lý do để làm lại toàn bộ mod boss từ đầu ở thời điểm này.** Giữ baseline đã chạy, sửa khu vực có lỗi và kiểm tra hồi quy phần chung.

## 7. Những file hay cần tìm

| Nhóm | File |
|---|---|
| Strings Việt | `kr3-desktop/assets/strings/zh-Hans*.lua`, `Localized_zh-cn.lua` |
| Hướng dẫn cách xây tháp | `kr3/data/special_tower_encyclopedia.lua` |
| Tài liệu/cân bằng tháp | `kr3/data/tower_balance_docs.lua`, `tower_power_display.lua`, `tower_menus_data.lua` |
| Tên trên bản đồ | `kr3-desktop/data/map_data.lua` |
| UH | `all/strings_UH.lua` |
| Locale/fallback | `all/i18n.lua`, `all/gg_views.lua` |
| Font | `all-desktop/data/font_subst.lua`, `lib/klove/font_db.lua`, `all-desktop/assets/fonts/FL-SoupOfJustice.otf`, `EBGaramond-Bold.ttf` |
| Roster/đội | `all/infinite_heroes.lua`, `all-desktop/screen_map.lua` |
| HUD/skill/phân trang | `all-desktop/game_gui.lua` |
| Nạp tài nguyên | `all/director.lua`; kiểm tra texture thường và scaled riêng |
| Spawn hero theo phần | `all/level_utils.lua`, `all/level_utils_5.lua`, `all/level_utils_6.lua` |
| Save | `all/storage.lua`, `all/storage_io_generic.lua`, `all-desktop/screen_slots.lua`; nhánh debug map trong `screen_map.lua` |
| Registry boss | `all/allied_bosses.lua` |
| Runtime boss chung | `all/allied_boss_common.lua` |
| Mô tả skill tương thích HUD | `all/allied_boss_skills.lua`; skill thực nằm trong từng module boss |
| Boss gốc KR1 | `kr3/game_templates-1.lua`, `kr3/game_scripts-1.lua` |
| Set gốc | `kr3/game_templates-v.lua`, `kr3/game_scripts-v.lua`, `kr3/data/levels/level89_data.lua` |
| Navira gốc | `kr3/game_templates-5.lua`, `kr3/game_scripts-5.lua`, `kr3/balance/balance.lua`, `level119_data.lua` |
| Hammerhold | `kr3/game_templates-45e.lua`, `kr3/game_scripts-45e.lua`; level183/185/186 |
| Animation Hammerhold | `kr3/data/game_animations_merge_g4.lua` |
| Godieth | Tìm `eb_balrog` ở template/script KR3 và `all/allied_godieth.lua` |
| Spell/item | `all/power_selection.lua` |
| Handler lỗi | `main.lua` |
| Mạng/cập nhật | `dove_modules/updater/update_manager.lua`, các call sites khởi tạo từ main/mod/launcher |

## 8. Các gói và checkpoint quan trọng

Các tên dưới đây đã có trong thư mục `output/` của phiên cũ. **Đây không phải hướng dẫn cài lần lượt tất cả ZIP.** Nhiều gói chồng cùng file; bản cũ có thể ghi đè sửa mới.

| Gói | Vai trò |
|---|---|
| `FL803_VietHoa_SoupOfJustice_ToanBo.zip` | Nền Việt hóa/font được chọn cuối cùng |
| `FL803_InfiniteHero_NhieuDoi_BaoVeSave.zip` | Infinite không cap, nhiều đội, xóa đỏ, bảo vệ save |
| `FL803_Spell_KhongGioiHanLuot.zip` | Bỏ hạn mức dùng spell mỗi trận |
| `FL803_CrashLog_ThuMucGame.zip` | Handler log dễ lấy; main.lua cần merge với bản hiện hành |
| `FL803_Game_Optimization.zip` | Sáu file tối ưu engine |
| `FL803_GoBoss_GiuInfiniteHero.zip` | Checkpoint gỡ boss để khoanh vùng; không phải bản nên cài lại tự động |
| `FL803_3Boss_TachFile_Blackburn_Juggernaut_Set.zip` | Nền 3 boss user xác nhận ổn |
| `FL803_Navira_Buoc1_CoBan.zip` | Bước thử Navira cũ, đã từng crash load |
| `FL803_Navira_KhoiPhucNapTaiNguyen.zip` | Sửa resource, user xác nhận chạy |
| `FL803_Navira_FullSkills_TuDong.zip` | Navira tự động đầy đủ |
| `FL803_Hammerhold_Godieth_Navira280.zip` | Roster 8 boss hiện tại |
| `FL803_Malik_Ngai_Nhay_HoatAnh.zip` | Bản scene trước; user xác nhận thấy Malik trên ngai |
| **`FL803_Malik_Thoai_HoatAnh_KyNang.zip`** | **Bản mới nhất, gồm sửa ngai trước + thoại/animation/FX mới** |

Các bản boss thử cũ như `FL803_InfiniteHero_Boss_FullSkills.zip`, `FL803_Boss_AutoSkills_FIX.zip`, `FL803_Set_Juggernaut_FIX.zip`, `FL803_Set_HienHinh_FIX.zip` có thể dùng để so sánh lịch sử, không ghi đè mù lên roster/module mới.

### Nhận diện chính xác ZIP mới nhất

- Tên: `FL803_Malik_Thoai_HoatAnh_KyNang.zip`.
- Kích thước lúc bàn giao: **420.923 byte**.
- SHA-256: **`9ca661df31508d0459a2ebb9dcd01bbe75cc5b7800d6b754c5b22a86e5519379`**.
- Đường dẫn phiên cũ: `/workspace/scratch/c022069f23a1/output/FL803_Malik_Thoai_HoatAnh_KyNang.zip`.
- Trong ZIP: `CAP_NHAT/` gồm 9 file; `BACKUP_TRUOC_CAP_NHAT/` gồm 6 Lua trước lần sửa; `HUONG_DAN.txt`, `MALIK_CHANGES.diff`, `validation.log`.
- Cài: thoát game, chép `all` và `kr3` bên trong `CAP_NHAT` vào gốc game, ghi đè; vào lại Campaign từ đầu.
- Rollback: chép backup phù hợp; file mới `all/malik_presentation.lua` và `kr3/data/malik/` có thể xóa sau khi khôi phục những file gọi chúng.
- Backup này đã gồm bản sửa ngai trước, không phải nguyên bản FL 8.0.3 chưa mod.
- Nếu Codex mới chỉ có tài liệu này mà không có các file vá, cần lấy ZIP hoặc đọc các file đã cài trên máy. **Markdown không chứa toàn bộ mã nguồn patch.**

## 9. Kiểm tra đã chạy và giới hạn

### 9.1. Lần Malik mới nhất

- Biên dịch cú pháp **7 Lua**.
- Đối chiếu **19 trạng thái** animation với KR4 và **1.475 tham chiếu frame** thân/FX có trong atlas.
- Chạy coroutine scene: intro chỉ một lần, idle giữa các câu, thoại định kỳ, pre-fight, nhảy đủ khung, ghế ở lại.
- Kiểm tra Campaign-only, chỉ spawn một boss wave 15 ở điểm đáp.
- Kiểm tra nhảy qua path và phục hồi khi chết/choáng.
- Kiểm tra ném búa giữ đủ 45 frame thay vì cắt ngay sau release.
- Kiểm tra death → 2 câu cuối → deathEnd; thắng chờ, entity/text texture dọn sạch.
- Kiểm tra walk 52 frame, combat idle 237, ally death 100 frame.
- Hồi quy các boss khác, roster, resource và dấu vết 3 boss ổn định không thay đổi.
- Test tải Lua: **12 thực thể gồm bản sao của 8 loại boss**, 10 phút mô phỏng; live entity lớn nhất 195; chênh trung bình bộ nhớ Lua giữa cửa sổ đầu/cuối khoảng **−5,5 KiB** trong lượt ghi log.
- Hết mục tiêu thì entity tạm hết hạn; không tích lũy trạng thái khi đứng yên; ally không gây damage phe mình hoặc tự báo thắng.

Đây là **kiểm tra mã trong môi trường mô phỏng**. Không biến thành tuyên bố đã chơi trên Windows, không coi con số KiB là RAM/VRAM của game, không hứa đội vô hạn không bao giờ crash.

### 9.2. Nếu còn workspace cũ

Thư mục chính: `/workspace/scratch/c022069f23a1/fl803_malik_complete/`.

- `payload/`: mã mới nhất để giao, 7 Lua + 2 PNG.
- `baseline/`: 6 Lua trước lần cập nhật này.
- `build_update.py`: dựng thay đổi từ baseline; **không tự tạo module mới và PNG**, chúng đã nằm trong payload.
- `check.py`, `native_checks.lua`: kiểm tra Lua/hồi quy.
- `check_assets.py`: kiểm tra ranges và sự tồn tại frame trong atlas gốc.
- `MALIK_CHANGES.diff`, `validation.log`, `HUONG_DAN.txt`: bằng chứng và hướng dẫn.
- `dialogue_preview.png`: ảnh ghép kiểm tra bố cục từ asset, **không phải screenshot game đang chạy**.
- `fl803_malik_scene/source/vengeance/`: dữ liệu gốc đã tải, dùng cho asset check.

Các lệnh đã dùng trong môi trường cũ:

```bash
python fl803_malik_complete/check_assets.py
python fl803_malik_complete/check.py --full
```

Harness phụ thuộc thư mục dự án trước như `fl803_game_opt`, `fl803_hammer_godieth`, `fl803_boss_crash_fix/test_core`, `fl803_three_boss` và đường dẫn tuyệt đối cũ. **Không giả định chạy được chỉ với ZIP patch hoặc chỉ với handoff.** Trong VS Code cần điều chỉnh đường dẫn/môi trường hoặc kiểm tra bằng game thực.

Thư mục checkpoint khác: `fl803_review`, `fl803_complete`, `fl803_fonts`, `fl803_soup_all`, `fl803_infinite`, `fl803_infinite_fix_stage`, `fl803_infinite_hud`, `fl803_infinite_safety`, `fl803_infinite_teams`, `fl803_unlimited_spells`, `fl803_three_boss`, `fl803_navira_load_restore`, `fl803_navira_full`, `fl803_hammer_godieth`, `fl803_game_opt`, `fl803_crashlog_visible`, `fl803_network_audit`.

`fl803_malik_scene/build_patch.py` của lần trước có chỉnh tay tiếp sau quá trình dựng; khi cần nền trước, **lấy payload/ZIP đã giao**, không chạy lại builder cũ rồi mặc định kết quả giống hệt.

## 10. Quy trình đề nghị cho Codex tiếp nhận

1. Đọc tài liệu này, tìm thư mục game thật và đọc `AGENTS.md` nếu repository có. Xem `git status`; giữ nguyên sửa riêng của người dùng.
2. Kiểm tra đang có roster 8 boss và patch Malik mới nhất hay chưa. Dùng `rg` tìm:

```text
malik_presentation
wait_for_death_animation
malik_layerX_sitIdle
malik_layerX_allyDeath
hero_allied_godieth
```

3. Nếu có ZIP, so sánh 9 file trong `CAP_NHAT` với file hiện có. Không tự ghi đè cả repository theo ZIP cũ; merge thay đổi nếu người dùng đã chỉnh thêm.
4. Dùng team test ít entity trước: 1 Malik đồng minh ở màn thường; Campaign đấu trường với boss địch. Test riêng hai vai trò.
5. Campaign: xem 2 câu intro rồi nghỉ; chờ ít nhất một lần taunt; wave 15 pre-fight → nhảy khỏi ngai → chiến đấu; quan sát melee/range/special/jump; hạ Malik và chờ kết quả sau lời cuối.
6. Ally: di chuyển đủ hướng; skill tự động; chết/choáng giữa jump; hồi sinh; thử hai bản sao có trạng thái/cooldown độc lập; không gây damage đồng minh/phá tháp/báo thắng.
7. Nếu lỗi, lấy **đầy đủ stack trace, màn/chế độ, đội, thao tác, kỹ năng đang chạy**. Lỗi load → kiểm tra atlas/tỉ lệ/layer/alias trước; lỗi lúc skill → kiểm tra template, target còn tồn tại, lifecycle và cleanup.
8. Sau thay đổi ở common/director/level_utils/animation, chạy hồi quy 3 boss ổn định, Navira, đội và save. Chỉ mở rộng test để giải quyết rủi ro cụ thể; không cần lặp stress dài vô ích.
9. Nếu cần tối ưu, đo theo cùng một kịch bản vào màn → chơi → thoát → vào lại. Phân biệt memory entity đang sống, cache asset và tham chiếu leak. Không giảm đồ họa hoặc áp cap trái yêu cầu.
10. Giao ZIP chỉ chứa phần cần thay, kèm hướng dẫn chép, backup, danh sách thay đổi và phạm vi đã thử. Nêu rõ phần nào chưa kiểm chứng.

## 11. Tiêu chí hoàn tất công việc còn lại

- Malik địch hiện từ đầu Campaign, không lặp mở màn vô hạn, thoại đọc được và dọn đúng.
- Nhảy khỏi ngai đúng lúc, không spawn kép/đi từ cửa, không kẹt scene.
- Các kỹ năng có chuyển động/FX phù hợp và không cắt phần cuối vô cớ.
- Cảnh chết kết thúc được, không treo thắng và không báo thắng sớm.
- Malik ally điều khiển như hero, tự dùng skill, chết/hồi sinh an toàn.
- Không làm hỏng roster, các boss đã ổn định, InfiniteHero, save, font hoặc stage English.
- Có xác nhận chơi thực hoặc ghi rõ giới hạn còn lại; không lấy test Lua thay cho xác nhận đồ họa.

## 12. Prompt ngắn để bắt đầu trong VS Code

> Đọc CODEX_HANDOFF.md và kiểm tra mã game hiện tại trước khi sửa. Tiếp tục hoàn thiện Malik địch ở Campaign level 186 và Malik đồng minh trong InfiniteHero. Đối chiếu bản FL803_Malik_Thoai_HoatAnh_KyNang.zip đã giao với mã trên máy; giữ mọi tính năng Việt hóa Soup, đội vô hạn, save protection, Juggernaut CD 10 giây, Navira ally 280 và Godieth thay Spectro. Ưu tiên xác minh thoại, cảnh ngai/nhảy, đủ hoạt ảnh và FX, rồi xử lý lỗi thực tế. Không tự cấp sao, không áp cap hero, không tuyên bố đã thử game khi chỉ chạy mô phỏng.
