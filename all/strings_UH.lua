local i18n = require("i18n")
local z = require("assets.strings.zh-Hans")

require("klua.table")

local MISSING_VALUE = {}

local strings_UH = {
    original_zs = {},
    original_captured = false,
    new_zs = {
        [2] = {
            -- 沙塔
            HERO_ALIEN_ABDUCTION_DESCRIPTION_1 = "Triệu hồi tàu mẹ điều khiển bằng chuột. Nhấn chuột phải để bắt cóc một mục tiêu có tối đa 250 máu.",
            HERO_ALIEN_ABDUCTION_DESCRIPTION_2 = "Triệu hồi tàu mẹ điều khiển bằng chuột. Nhấn chuột phải để bắt cóc hai mục tiêu có tối đa 600 máu.",
            HERO_ALIEN_ABDUCTION_DESCRIPTION_3 = "Triệu hồi tàu mẹ điều khiển bằng chuột. Nhấn chuột phải để bắt cóc ba mục tiêu có tổng máu 1000, hoặc một mục tiêu bất kỳ.",
            HERO_ALIEN_ENERGYGLAIVE_DESCRIPTION_1 = "Ném một lưỡi kiếm, gây 22 sát thương và có 70% cơ hội đánh thêm một mục tiêu.",
            HERO_ALIEN_ENERGYGLAIVE_DESCRIPTION_2 = "Ném một lưỡi kiếm, gây 30 sát thương và có 80% cơ hội đánh thêm một mục tiêu.",
            HERO_ALIEN_ENERGYGLAIVE_DESCRIPTION_3 = "Ném một lưỡi kiếm, gây 35 sát thương và có 85% cơ hội đánh thêm một mục tiêu.",
            HERO_ALIEN_FINALCOUNTDOWN_DESCRIPTION_1 = "Khi máu của Sha'tra về 0, anh tự hủy và gây 150 sát thương diện rộng.",
            HERO_ALIEN_FINALCOUNTDOWN_DESCRIPTION_2 = "Khi máu của Sha'tra về 0, anh tự hủy và gây 200 sát thương diện rộng.",
            HERO_ALIEN_FINALCOUNTDOWN_DESCRIPTION_3 = "Khi máu của Sha'tra về 0, anh tự hủy và gây 350 sát thương diện rộng.",
            HERO_ALIEN_PURIFICATIONPROTOCOL_DESCRIPTION_1 = "Triệu hồi drone điều khiển bằng chuột, bắn plasma siêu nóng gây 20 sát thương mỗi giây.",
            HERO_ALIEN_PURIFICATIONPROTOCOL_DESCRIPTION_2 = "Triệu hồi drone điều khiển bằng chuột, bắn plasma siêu nóng gây 40 sát thương mỗi giây.",
            HERO_ALIEN_PURIFICATIONPROTOCOL_DESCRIPTION_3 = "Triệu hồi drone điều khiển bằng chuột, bắn plasma siêu nóng gây 45 sát thương mỗi giây.",

            -- 沙王
            HERO_ALRIC_SANDWARRIORS_DESCRIPTION_1 = "Triệu hồi một chiến binh sa mạc có 60 máu để chặn và tấn công kẻ địch.",
            HERO_ALRIC_SANDWARRIORS_DESCRIPTION_2 = "Triệu hồi hai chiến binh sa mạc, mỗi người có 100 máu.",
            HERO_ALRIC_SANDWARRIORS_DESCRIPTION_3 = "Triệu hồi ba chiến binh sa mạc, mỗi người có 140 máu.",
            HERO_ALRIC_TOUGHNESS_DESCRIPTION_1 = "Tăng 30 máu tối đa cho Alric và cường hóa sinh vật bất tử gần đó.",
            HERO_ALRIC_TOUGHNESS_DESCRIPTION_2 = "Tăng thêm 60 máu tối đa cho Alric và cường hóa sinh vật bất tử gần đó.",
            HERO_ALRIC_TOUGHNESS_DESCRIPTION_3 = "Tăng thêm 90 máu tối đa cho Alric và cường hóa sinh vật bất tử gần đó.",

            -- 兽王
            HERO_BEASTMASTER_BOARMASTER_DESCRIPTION_1 = "Triệu hồi 1 lợn rừng, mỗi con có 160 máu, chặn và tấn công kẻ địch trong phạm vi, gây chảy máu.",
            HERO_BEASTMASTER_BOARMASTER_DESCRIPTION_2 = "Triệu hồi 2 lợn rừng, mỗi con có 160 máu, chặn và tấn công kẻ địch trong phạm vi, gây chảy máu.",
            HERO_BEASTMASTER_BOARMASTER_DESCRIPTION_3 = "Triệu hồi 2 lợn rừng, mỗi con có 240 máu, chặn và tấn công kẻ địch trong phạm vi, gây chảy máu.",
            HERO_BEASTMASTER_DEEPLASHES_DESCRIPTION_1 = "Đòn đánh đặc biệt gây 30 sát thương và thêm 12 sát thương chảy máu.",
            HERO_BEASTMASTER_DEEPLASHES_DESCRIPTION_2 = "Đòn đánh đặc biệt gây 40 sát thương và thêm 36 sát thương chảy máu.",
            HERO_BEASTMASTER_DEEPLASHES_DESCRIPTION_3 = "Đòn đánh đặc biệt gây 50 sát thương và thêm 72 sát thương chảy máu.",
            HERO_BEASTMASTER_DEEPLASHES_TITLE = "Quất roi",
            HERO_BEASTMASTER_FALCONER_DESCRIPTION_1 = "Huấn luyện chim ưng đồng hành, tấn công kẻ địch trong phạm vi, gây 3–9 sát thương và chảy máu.",
            HERO_BEASTMASTER_FALCONER_DESCRIPTION_2 = "Huấn luyện chim ưng đồng hành, tấn công kẻ địch trong phạm vi, gây 9–27 sát thương và chảy máu.",
            HERO_BEASTMASTER_FALCONER_DESCRIPTION_3 = "Huấn luyện chim ưng đồng hành, tấn công kẻ địch trong phạm vi, gây 18–54 sát thương và chảy máu.",
            HERO_BEASTMASTER_STAMPEDE_DESCRIPTION_1 = "Triệu hồi tê giác lao tới gây sát thương, có 50% cơ hội làm choáng kẻ địch.",
            HERO_BEASTMASTER_STAMPEDE_DESCRIPTION_2 = "Tăng quy mô đàn tê giác và tăng 75% cơ hội làm choáng.",
            HERO_BEASTMASTER_STAMPEDE_DESCRIPTION_3 = "Tiếp tục tăng quy mô đàn tê giác và tăng 100% cơ hội làm choáng.",

            -- 螃蟹
            HERO_CRAB_HOOKEDCLAW_DESCRIPTION_1 = "Tăng 15 sát thương đòn đánh thường.",
            HERO_CRAB_HOOKEDCLAW_DESCRIPTION_2 = "Tăng thêm 25 sát thương đòn đánh thường.",
            HERO_CRAB_HOOKEDCLAW_DESCRIPTION_3 = "Tăng thêm 35 sát thương đòn đánh thường.",
            HERO_CRAB_PINCERATTACK_DESCRIPTION_1 = "Bắn càng máy, kẹp các kẻ địch phía trước lại với nhau và gây 15–35 sát thương.",
            HERO_CRAB_PINCERATTACK_DESCRIPTION_2 = "Bắn càng máy, kẹp các kẻ địch phía trước lại với nhau và gây 25–75 sát thương.",
            HERO_CRAB_PINCERATTACK_DESCRIPTION_3 = "Bắn càng máy, kẹp các kẻ địch phía trước lại với nhau và gây 50–100 sát thương.",
            HERO_CRAB_SHOULDERCANNON_DESCRIPTION_1 = "Bắn đạn lỏng 6 lần, mỗi lần gây 25–40 sát thương và làm chậm kẻ địch trong 3 giây.",
            HERO_CRAB_SHOULDERCANNON_DESCRIPTION_2 = "Bắn đạn lỏng 9 lần, mỗi lần gây 25–40 sát thương và làm chậm kẻ địch trong 3 giây.",
            HERO_CRAB_SHOULDERCANNON_DESCRIPTION_3 = "Bắn đạn lỏng 12 lần, mỗi lần gây 25–40 sát thương và làm chậm kẻ địch trong 3 giây.",

            -- 骨龙
            HERO_DRACOLICH_UNSTABLEDISEASE_DESCRIPTION_1 = "Kẻ địch nhiễm bệnh phát nổ khi chết, lây bệnh cho kẻ địch gần đó và gây 20 sát thương.",
            HERO_DRACOLICH_UNSTABLEDISEASE_DESCRIPTION_2 = "Kẻ địch nhiễm bệnh phát nổ khi chết, lây bệnh cho kẻ địch gần đó và gây 50 sát thương.",
            HERO_DRACOLICH_UNSTABLEDISEASE_DESCRIPTION_3 = "Kẻ địch nhiễm bệnh phát nổ khi chết, lây bệnh cho kẻ địch gần đó và gây 80 sát thương.",

            -- 火龙
            HERO_DRAGON_FEAST_DESCRIPTION_1 = "Lao xuống cắn một kẻ địch, gây 80 sát thương và có 25% cơ hội nuốt chửng mục tiêu.",
            HERO_DRAGON_FEAST_DESCRIPTION_2 = "Lao xuống cắn một kẻ địch, gây 140 sát thương và có 60% cơ hội nuốt chửng mục tiêu.",
            HERO_DRAGON_FEAST_DESCRIPTION_3 = "Lao xuống cắn một kẻ địch, gây 200 sát thương và có 100% cơ hội nuốt chửng mục tiêu.",
            HERO_DRAGON_FIERYMIST_DESCRIPTION_1 = "Phun khói nóng, làm chậm kẻ địch 30% trong 3 giây và thiêu đốt chúng.",
            HERO_DRAGON_FIERYMIST_DESCRIPTION_2 = "Phun khói nóng, làm chậm kẻ địch 40% trong 4 giây và thiêu đốt chúng.",
            HERO_DRAGON_FIERYMIST_DESCRIPTION_3 = "Phun khói nóng, làm chậm kẻ địch 50% trong 5 giây và thiêu đốt chúng.",
            HERO_DRAGON_REIGNOFFIRE_DESCRIPTION_1 = "Đòn đánh gây lửa lan giữa các kẻ địch, thiêu đốt và gây 6 sát thương trong 3 giây.",
            HERO_DRAGON_REIGNOFFIRE_DESCRIPTION_2 = "Đòn đánh gây lửa lan giữa các kẻ địch, thiêu đốt và gây 18 sát thương trong 3 giây.",
            HERO_DRAGON_REIGNOFFIRE_DESCRIPTION_3 = "Đòn đánh gây lửa lan giữa các kẻ địch, thiêu đốt và gây 30 sát thương trong 3 giây.",
            HERO_DRAGON_WILDFIREBARRAGE_DESCRIPTION_1 = "Đốt cháy mặt đất bằng 4 vụ nổ, mỗi vụ gây 55 sát thương.",
            HERO_DRAGON_WILDFIREBARRAGE_DESCRIPTION_2 = "Đốt cháy mặt đất bằng 8 vụ nổ, mỗi vụ gây 55 sát thương.",
            HERO_DRAGON_WILDFIREBARRAGE_DESCRIPTION_3 = "Đốt cháy mặt đất bằng 12 vụ nổ, mỗi vụ gây 55 sát thương.",

            -- 石头人
            HERO_GIANT_BASTION_DESCRIPTION_1 = "Khi ở trên chiến trường, Grawl tích lũy thêm sát thương, tối đa 12.",
            HERO_GIANT_BASTION_DESCRIPTION_2 = "Khi ở trên chiến trường, Grawl tích lũy thêm sát thương, tối đa 18.",
            HERO_GIANT_BASTION_DESCRIPTION_3 = "Khi ở trên chiến trường, Grawl tích lũy thêm sát thương, tối đa 24.",
            HERO_GIANT_BOULDERTHROW_DESCRIPTION_1 = "Ném tảng đá lớn, gây 60–120 sát thương diện rộng.",
            HERO_GIANT_BOULDERTHROW_DESCRIPTION_2 = "Ném tảng đá lớn, gây 120–180 sát thương diện rộng.",
            HERO_GIANT_BOULDERTHROW_DESCRIPTION_3 = "Ném tảng đá lớn, gây 180–300 sát thương diện rộng.",
            HERO_GIANT_HARDROCK_DESCRIPTION_1 = "Tăng 100 máu tối đa cho Grawl.",
            HERO_GIANT_HARDROCK_DESCRIPTION_2 = "Tăng 200 máu tối đa cho Grawl.",
            HERO_GIANT_HARDROCK_DESCRIPTION_3 = "Tăng 300 máu tối đa cho Grawl.",
            HERO_GIANT_MASSIVEDAMAGE_DESCRIPTION_1 = "Đòn đánh đặc biệt gây 100 sát thương. Nếu máu của Grawl gấp ba lần mục tiêu, tiêu diệt mục tiêu ngay lập tức.",
            HERO_GIANT_MASSIVEDAMAGE_DESCRIPTION_2 = "Đòn đánh đặc biệt gây 180 sát thương. Nếu máu của Grawl gấp ba lần mục tiêu, tiêu diệt mục tiêu ngay lập tức.",
            HERO_GIANT_MASSIVEDAMAGE_DESCRIPTION_3 = "Đòn đánh đặc biệt gây 240 sát thương. Nếu máu của Grawl gấp ba lần mục tiêu, tiêu diệt mục tiêu ngay lập tức.",
            HERO_GIANT_STOMP_DESCRIPTION_1 = "Giẫm đất 6 lần, gây sát thương, làm chậm và làm choáng kẻ địch xung quanh.",
            HERO_GIANT_STOMP_DESCRIPTION_2 = "Giẫm đất 8 lần, gây sát thương, làm chậm và làm choáng kẻ địch xung quanh.",
            HERO_GIANT_STOMP_DESCRIPTION_3 = "Giẫm đất 10 lần, gây sát thương, làm chậm và làm choáng kẻ địch xung quanh.",

            -- 米诺陶
            HERO_MINOTAUR_BLOODAXE_DESCRIPTION_1 = "Mỗi đòn đánh có 40% cơ hội gây sát thương chuẩn gấp 1.25 lần.",
            HERO_MINOTAUR_BLOODAXE_DESCRIPTION_2 = "Mỗi đòn đánh có 40% cơ hội gây sát thương chuẩn gấp 1.5 lần.",
            HERO_MINOTAUR_BLOODAXE_DESCRIPTION_3 = "Mỗi đòn đánh có 40% cơ hội gây sát thương chuẩn gấp đôi.",

            -- 幻影
            HERO_MIRAGE_LETHALSTRIKE_DESCRIPTION_1 = "Mirage đâm sau lưng mục tiêu, gây 90 sát thương và có 40% cơ hội tiêu diệt ngay lập tức.",
            HERO_MIRAGE_LETHALSTRIKE_DESCRIPTION_2 = "Mirage đâm sau lưng mục tiêu, gây 180 sát thương và có 70% cơ hội tiêu diệt ngay lập tức.",
            HERO_MIRAGE_LETHALSTRIKE_DESCRIPTION_3 = "Mirage đâm sau lưng mục tiêu, gây 270 sát thương và có 90% cơ hội tiêu diệt ngay lập tức.",
            HERO_MIRAGE_SHADOWDODGE_DESCRIPTION_1 = "Mirage có 40% cơ hội né đòn, để lại một ảo ảnh tại vị trí cũ.",
            HERO_MIRAGE_SHADOWDODGE_DESCRIPTION_2 = "Mirage có 60% cơ hội né đòn, để lại một ảo ảnh tại vị trí cũ.",
            HERO_MIRAGE_SHADOWDODGE_DESCRIPTION_3 = "Mirage có 80% cơ hội né đòn, để lại một ảo ảnh tại vị trí cũ.",
            HERO_MIRAGE_SHADOWDODGE_TITLE = "Né đòn bóng tối",
            HERO_MIRAGE_SPEED = "Nhanh",
            HERO_MIRAGE_SWIFTNESS_DESCRIPTION_1 = "Tăng 40% tốc độ di chuyển của Mirage.",
            HERO_MIRAGE_SWIFTNESS_DESCRIPTION_2 = "Tăng 80% tốc độ di chuyển của Mirage.",
            HERO_MIRAGE_SWIFTNESS_DESCRIPTION_3 = "Tăng 100% tốc độ di chuyển của Mirage.",

            -- 猴神
            HERO_MONKEY_GOD_MONKEYPALM_DESCRIPTION_1 = "Dùng võ thuật cổ truyền làm choáng một kẻ địch trong 4 giây và câm lặng nó trong 5 giây.",
            HERO_MONKEY_GOD_MONKEYPALM_DESCRIPTION_2 = "Dùng võ thuật cổ truyền làm choáng một kẻ địch trong 6 giây và câm lặng nó trong 10 giây.",
            HERO_MONKEY_GOD_MONKEYPALM_DESCRIPTION_3 = "Dùng võ thuật cổ truyền làm choáng một kẻ địch trong 7 giây và câm lặng nó trong 15 giây.",
            HERO_MONKEY_GOD_DIVINENATURE_DESCRIPTION_1 = "Saitam truyền dẫn năng lượng thiêng liêng, hồi 3 máu mỗi giây và có thể dùng năng lượng này để triệu hồi phân thân.",
            HERO_MONKEY_GOD_DIVINENATURE_DESCRIPTION_2 = "Saitam truyền dẫn năng lượng thiêng liêng, hồi 6 máu mỗi giây và có thể dùng năng lượng này để triệu hồi phân thân.",
            HERO_MONKEY_GOD_DIVINENATURE_DESCRIPTION_3 = "Saitam truyền dẫn năng lượng thiêng liêng, hồi 9 máu mỗi giây và có thể dùng năng lượng này để triệu hồi phân thân.",
            HERO_MONKEY_GOD_SPINNINGPOLE_DESCRIPTION_1 = "Xoay hai cây chùy, phá giáp kẻ địch xung quanh và gây 32 sát thương.",
            HERO_MONKEY_GOD_SPINNINGPOLE_DESCRIPTION_2 = "Xoay hai cây chùy, phá giáp kẻ địch xung quanh và gây 69 sát thương.",
            HERO_MONKEY_GOD_SPINNINGPOLE_DESCRIPTION_3 = "Xoay hai cây chùy, phá giáp kẻ địch xung quanh và gây 108 sát thương.",
            HERO_MONKEY_GOD_TETSUBOSTORM_DESCRIPTION_1 = "Tung chuỗi đòn nhanh và mạnh, phá giáp một kẻ địch và gây 110 sát thương.",
            HERO_MONKEY_GOD_TETSUBOSTORM_DESCRIPTION_2 = "Tung chuỗi đòn nhanh và mạnh, phá giáp một kẻ địch và gây 180 sát thương.",
            HERO_MONKEY_GOD_TETSUBOSTORM_DESCRIPTION_3 = "Tung chuỗi đòn nhanh và mạnh, phá giáp một kẻ địch và gây 260 sát thương.",

            -- 库绍
            HERO_MONK_DRAGONSTYLE_DESCRIPTION_1 = "Kutsao hóa nội lực thành rồng lửa, gây 50–90 sát thương và làm suy yếu kẻ địch gần đó.",
            HERO_MONK_DRAGONSTYLE_DESCRIPTION_2 = "Kutsao hóa nội lực thành rồng lửa, gây 80–160 sát thương và làm suy yếu kẻ địch gần đó.",
            HERO_MONK_DRAGONSTYLE_DESCRIPTION_3 = "Kutsao hóa nội lực thành rồng lửa, gây 120–240 sát thương và làm suy yếu kẻ địch gần đó.",
            HERO_MONK_LEOPARDSTYLE_DESCRIPTION_1 = "Tung 6 đòn chớp nhoáng vào nhiều mục tiêu, mỗi đòn gây 10–30 sát thương và điểm huyệt làm suy yếu chúng.",
            HERO_MONK_LEOPARDSTYLE_DESCRIPTION_2 = "Tung 9 đòn chớp nhoáng vào nhiều mục tiêu, mỗi đòn gây 12–36 sát thương và điểm huyệt làm suy yếu chúng.",
            HERO_MONK_LEOPARDSTYLE_DESCRIPTION_3 = "Tung 12 đòn chớp nhoáng vào nhiều mục tiêu, mỗi đòn gây 14–42 sát thương và điểm huyệt làm suy yếu chúng.",
            HERO_MONK_TIGERSTYLE_DESCRIPTION_1 = "Kutsao tập trung nội lực tung đòn xuyên giáp, gây 30 sát thương lên một kẻ địch và tiêu diệt ngay mục tiêu cực kỳ suy yếu.",
            HERO_MONK_TIGERSTYLE_DESCRIPTION_2 = "Kutsao tập trung nội lực tung đòn xuyên giáp, gây 50 sát thương lên một kẻ địch và tiêu diệt ngay mục tiêu cực kỳ suy yếu.",
            HERO_MONK_TIGERSTYLE_DESCRIPTION_3 = "Kutsao tập trung nội lực tung đòn xuyên giáp, gây 70 sát thương lên một kẻ địch và tiêu diệt ngay mục tiêu cực kỳ suy yếu.",

            -- 船长
            HERO_PIRATE_LOOTING_DESCRIPTION_1 = "Kẻ địch bị hạ gần Blackthorne rơi thêm 10% vàng. Các đòn đánh khác nguyền rủa kẻ địch, khiến chúng rơi thêm 1 vàng.",
            HERO_PIRATE_LOOTING_DESCRIPTION_2 = "Kẻ địch bị hạ gần Blackthorne rơi thêm 20% vàng. Các đòn đánh khác nguyền rủa kẻ địch, khiến chúng rơi thêm 1.5 vàng.",
            HERO_PIRATE_LOOTING_DESCRIPTION_3 = "Kẻ địch bị hạ gần Blackthorne rơi thêm 30% vàng. Các đòn đánh khác nguyền rủa kẻ địch, khiến chúng rơi thêm 2 vàng.",
            HERO_PIRATE_SCATTERSHOT_DESCRIPTION_1 = "Ném thùng thuốc súng, gây 84 sát thương diện rộng.",
            HERO_PIRATE_SCATTERSHOT_DESCRIPTION_2 = "Ném thùng thuốc súng, gây 154 sát thương diện rộng.",
            HERO_PIRATE_SCATTERSHOT_DESCRIPTION_3 = "Ném thùng thuốc súng, gây 225 sát thương diện rộng.",

            -- 女祭司
            HERO_PRIEST_CONSECRATE_DESCRIPTION_1 = "Ban phước cho một tháp, tăng 15% sát thương trong 10 giây.",
            HERO_PRIEST_CONSECRATE_DESCRIPTION_2 = "Ban phước cho một tháp, tăng 20% sát thương trong 20 giây.",
            HERO_PRIEST_CONSECRATE_DESCRIPTION_3 = "Ban phước cho một tháp, tăng 25% sát thương trong 30 giây.",

            -- 但丁
            HERO_VAN_HELSING_HOLYGRENADE_DESCRIPTION_1 = "Ném một bình nước thánh, câm lặng một kẻ địch và ngăn nó dùng phép trong 15 giây.",
            HERO_VAN_HELSING_HOLYGRENADE_DESCRIPTION_2 = "Ném một bình nước thánh, câm lặng một kẻ địch và ngăn nó dùng phép trong 25 giây.",
            HERO_VAN_HELSING_HOLYGRENADE_DESCRIPTION_3 = "Ném một bình nước thánh, câm lặng vĩnh viễn một kẻ địch.",

            -- 女巫
            HERO_VOODOO_WITCH_BONEDANCE_DESCRIPTION_1 = "Tăng số đầu lâu đang hoạt động lên 4.",
            HERO_VOODOO_WITCH_BONEDANCE_DESCRIPTION_2 = "Tăng số đầu lâu đang hoạt động lên 5.",
            HERO_VOODOO_WITCH_BONEDANCE_DESCRIPTION_3 = "Tăng số đầu lâu đang hoạt động lên 6.",

            -- 大法师
            HERO_WIZARD_ARCANEFOCUS_DESCRIPTION_1 = "Tăng 4 sát thương đòn đánh thường cho Nivus.",
            HERO_WIZARD_ARCANEFOCUS_DESCRIPTION_2 = "Tăng thêm 6 sát thương đòn đánh thường cho Nivus.",
            HERO_WIZARD_ARCANEFOCUS_DESCRIPTION_3 = "Tăng thêm 24 sát thương đòn đánh thường cho Nivus.",
            HERO_WIZARD_DISINTEGRATE_DESCRIPTION_1 = "Phân rã kẻ địch trong phạm vi có tổng máu dưới 40 và triệu hồi một cơn lốc.",
            HERO_WIZARD_DISINTEGRATE_DESCRIPTION_2 = "Phân rã kẻ địch trong phạm vi có tổng máu dưới 50 và triệu hồi một cơn lốc.",
            HERO_WIZARD_DISINTEGRATE_DESCRIPTION_3 = "Phân rã kẻ địch trong phạm vi có tổng máu dưới 75 và triệu hồi một cơn lốc.",
            HERO_WIZARD_MAGICMISSILE_DESCRIPTION_1 = "Phóng 6 đạn phép tự tìm mục tiêu, luôn trúng đích, mỗi đạn gây 12 sát thương.",
            HERO_WIZARD_MAGICMISSILE_DESCRIPTION_2 = "Phóng 10 đạn phép tự tìm mục tiêu, luôn trúng đích, mỗi đạn gây 18 sát thương.",
            HERO_WIZARD_MAGICMISSILE_DESCRIPTION_3 = "Phóng 14 đạn phép tự tìm mục tiêu, luôn trúng đích, mỗi đạn gây 24 sát thương.",
        },
        [3] = {
            -- 艾莉丹
            HERO_ELVES_ARCHER_PORCUPINE_DESCRIPTION_1 = "Mỗi mũi tên liên tiếp bắn vào cùng mục tiêu gây thêm 1 sát thương, cộng dồn tối đa 10 mũi. Sau 7 đòn vào cùng mục tiêu, gây sát thương chuẩn.",
            HERO_ELVES_ARCHER_PORCUPINE_DESCRIPTION_2 = "Mỗi mũi tên liên tiếp bắn vào cùng mục tiêu gây thêm 1.25 sát thương, cộng dồn tối đa 15 mũi. Sau 11 đòn vào cùng mục tiêu, gây sát thương chuẩn.",
            HERO_ELVES_ARCHER_PORCUPINE_DESCRIPTION_3 = "Mỗi mũi tên liên tiếp bắn vào cùng mục tiêu gây thêm 1.5 sát thương, cộng dồn tối đa 25 mũi. Sau 14 đòn vào cùng mục tiêu, gây sát thương chuẩn.",
            HERO_ELVES_ARCHER_VOLLEY_DESCRIPTION_1 = "Ngắm kẻ địch trong tầm và bắn nhanh 11 mũi tên, mỗi mũi gây 10–14 sát thương.",
            HERO_ELVES_ARCHER_VOLLEY_DESCRIPTION_2 = "Ngắm kẻ địch trong tầm và bắn nhanh 15 mũi tên, mỗi mũi gây 10–14 sát thương.",
            HERO_ELVES_ARCHER_VOLLEY_DESCRIPTION_3 = "Ngắm kẻ địch trong tầm và bắn nhanh 18 mũi tên, mỗi mũi gây 10–14 sát thương.",

            -- 狮王
            HERO_ELVES_BRUCE_KINGS_ROAR_DESCRIPTION_1 =
            "Bruce gầm lên, mất 100 máu rồi hồi 10% lượng máu đã mất, làm choáng kẻ địch gần đó trong 1 giây. Mỗi 400 máu bị mất giảm 10 giây thời gian hồi Bầy sư tử.",
            HERO_ELVES_BRUCE_KINGS_ROAR_DESCRIPTION_2 =
            "Bruce gầm lên, mất 150 máu rồi hồi 20% lượng máu đã mất, làm choáng kẻ địch gần đó trong 2 giây. Mỗi 350 máu bị mất giảm 10 giây thời gian hồi Bầy sư tử.",
            HERO_ELVES_BRUCE_KINGS_ROAR_DESCRIPTION_3 = "Bruce mất 200 máu rồi hồi 30% lượng máu đã mất, làm choáng kẻ địch gần đó trong 2 giây. Mỗi 250 máu bị mất giảm 10 giây thời gian hồi Bầy sư tử.",
            HERO_ELVES_BRUCE_LIONS_FUR_DESCRIPTION_1 = "Tăng 30 máu cho Bruce và tăng 6 máu hồi mỗi giây.",
            HERO_ELVES_BRUCE_LIONS_FUR_DESCRIPTION_2 = "Tăng 60 máu cho Bruce và tăng 15 máu hồi mỗi giây.",
            HERO_ELVES_BRUCE_LIONS_FUR_DESCRIPTION_3 = "Tăng 90 máu cho Bruce và tăng 30 máu hồi mỗi giây.",
            HERO_ELVES_BRUCE_SHARP_CLAWS_DESCRIPTION_1 = "Đòn đánh có cơ hội gây chảy máu, chắc chắn gây chảy máu khi Bruce có dưới 50% máu. Nếu mục tiêu đang chảy máu, gây thêm 15 sát thương và hút 25 máu.",
            HERO_ELVES_BRUCE_SHARP_CLAWS_DESCRIPTION_2 = "Đòn đánh có cơ hội gây chảy máu, chắc chắn gây chảy máu khi Bruce có dưới 50% máu. Nếu mục tiêu đang chảy máu, gây thêm 30 sát thương và hút 25 máu.",
            HERO_ELVES_BRUCE_SHARP_CLAWS_DESCRIPTION_3 = "Đòn đánh có cơ hội gây chảy máu, chắc chắn gây chảy máu khi Bruce có dưới 50% máu. Nếu mục tiêu đang chảy máu, gây thêm 45 sát thương và hút 25 máu.",

            -- 迪纳斯王子

            -- 水晶人
            HERO_ELVES_DURAX_CRYSTAL_PRISON_DESCRIPTION_1 = "Triệu hồi gai nhọn trong một vùng rộng, gây tổng cộng 1000 sát thương lên kẻ địch bên trong.",
            HERO_ELVES_DURAX_CRYSTAL_PRISON_DESCRIPTION_2 = "Triệu hồi gai nhọn trong một vùng rộng, gây tổng cộng 1200 sát thương lên kẻ địch bên trong.",
            HERO_ELVES_DURAX_CRYSTAL_PRISON_DESCRIPTION_3 = "Triệu hồi gai nhọn trong một vùng rộng, gây tổng cộng 1400 sát thương lên kẻ địch bên trong.",

            -- 雷格森
            HERO_ELVES_ELDRITCH_BLADE_DESCRIPTION_1 = "Thắp lửa huyền thuật, mỗi đòn đánh gây 30 sát thương và có cơ hội tiêu diệt ngay lập tức, kéo dài 10 giây.",
            HERO_ELVES_ELDRITCH_BLADE_DESCRIPTION_2 = "Thắp lửa huyền thuật, mỗi đòn đánh gây 50 sát thương và có cơ hội tiêu diệt ngay lập tức, kéo dài 10 giây.",
            HERO_ELVES_ELDRITCH_BLADE_DESCRIPTION_3 = "Thắp lửa huyền thuật, mỗi đòn đánh gây 70 sát thương và có cơ hội tiêu diệt ngay lập tức, kéo dài 10 giây.",
            HERO_ELVES_ELDRITCH_SLASH_DESCRIPTION_1 = "Thi triển tuyệt kỹ, tấn công 3 lần vào tối đa 3 kẻ địch, gây 20–60 sát thương. Khi Ngọn lửa Huyền thuật đang cháy, gây sát thương chuẩn và sát thương không còn dao động.",
            HERO_ELVES_ELDRITCH_SLASH_DESCRIPTION_2 = "Thi triển tuyệt kỹ, tấn công 3 lần vào tối đa 3 kẻ địch, gây 45–130 sát thương. Khi Ngọn lửa Huyền thuật đang cháy, gây sát thương chuẩn và sát thương không còn dao động.",
            HERO_ELVES_ELDRITCH_SLASH_DESCRIPTION_3 = "Thi triển tuyệt kỹ, tấn công 3 lần vào tối đa 3 kẻ địch, gây 75–225 sát thương. Khi Ngọn lửa Huyền thuật đang cháy, gây sát thương chuẩn và sát thương không còn dao động.",

            -- 埃里汎
            HERO_ELVES_ELEMENTALIST_ELEMENTAL_STORM_DESCRIPTION_1 = "Triệu hồi lốc nguyên tố, làm chậm kẻ địch và phóng sét, gây 210 sát thương diện rộng trong 8 giây.",
            HERO_ELVES_ELEMENTALIST_ELEMENTAL_STORM_DESCRIPTION_2 = "Cường hóa sét của lốc, cho phép đóng băng kẻ địch và tăng sát thương diện rộng lên 320 trong 10 giây.",
            HERO_ELVES_ELEMENTALIST_ELEMENTAL_STORM_DESCRIPTION_3 = "Cường hóa mọi hiệu ứng của lốc, tăng sát thương diện rộng lên 500 trong 12 giây.",
            HERO_ELVES_ELEMENTALIST_ICY_PRISON_DESCRIPTION_1 = "Đóng băng một kẻ địch tại chỗ trong 4 giây, gây 35 sát thương băng.",
            HERO_ELVES_ELEMENTALIST_ICY_PRISON_DESCRIPTION_2 = "Đóng băng một kẻ địch tại chỗ trong 6 giây, gây 50 sát thương băng.",
            HERO_ELVES_ELEMENTALIST_ICY_PRISON_DESCRIPTION_3 = "Đóng băng một kẻ địch tại chỗ trong 8 giây, gây 65 sát thương băng.",
            HERO_ELVES_ELEMENTALIST_LIGHTNING_ROD_DESCRIPTION_1 = "Phóng tia sét mạnh mẽ, gây 60–100 sát thương chuẩn.",
            HERO_ELVES_ELEMENTALIST_LIGHTNING_ROD_DESCRIPTION_2 = "Phóng tia sét mạnh mẽ, gây 140–220 sát thương chuẩn.",
            HERO_ELVES_ELEMENTALIST_LIGHTNING_ROD_DESCRIPTION_3 = "Phóng tia sét mạnh mẽ, gây 240–400 sát thương chuẩn.",
            HERO_ELVES_ELEMENTALIST_SEAL_OF_FIRE_DESCRIPTION_1 = "Phóng 2 cầu lửa, mỗi quả gây 20–40 sát thương diện rộng và thiêu đốt trong 7 giây.",
            HERO_ELVES_ELEMENTALIST_SEAL_OF_FIRE_DESCRIPTION_2 = "Phóng 4 cầu lửa, mỗi quả gây 20–40 sát thương diện rộng và thiêu đốt trong 7 giây.",
            HERO_ELVES_ELEMENTALIST_SEAL_OF_FIRE_DESCRIPTION_3 = "Phóng 6 cầu lửa, mỗi quả gây 20–40 sát thương diện rộng và thiêu đốt trong 7 giây.",
            HERO_ELVES_ELEMENTALIST_STONE_DANCE_DESCRIPTION_1 = "Triệu hồi 1 khiên đá. Mỗi khiên chặn tổng cộng 35 sát thương cho Arivan và gây 7 sát thương lên kẻ địch chạm phải. Có thể tồn tại tối đa 2 khiên.",
            HERO_ELVES_ELEMENTALIST_STONE_DANCE_DESCRIPTION_2 = "Triệu hồi 1 khiên đá. Mỗi khiên chặn tổng cộng 35 sát thương cho Arivan và gây 8 sát thương lên kẻ địch chạm phải. Có thể tồn tại tối đa 4 khiên.",
            HERO_ELVES_ELEMENTALIST_STONE_DANCE_DESCRIPTION_3 = "Triệu hồi 1 khiên đá. Mỗi khiên chặn tổng cộng 35 sát thương cho Arivan và gây 9 sát thương lên kẻ địch chạm phải. Có thể tồn tại tối đa 5 khiên.",

            -- 堕天使
            HERO_ELVES_FALLEN_ANGEL_SOUL_EATER_DESCRIPTION_1 = "Hấp thụ linh hồn của kẻ địch đã chết có sát thương cao nhất, tăng sát thương trong 12 giây.",
            HERO_ELVES_FALLEN_ANGEL_SOUL_EATER_DESCRIPTION_2 = "Hấp thụ linh hồn của kẻ địch đã chết có sát thương cao nhất, tăng sát thương trong 12 giây.",
            HERO_ELVES_FALLEN_ANGEL_SOUL_EATER_DESCRIPTION_3 = "Hấp thụ linh hồn của kẻ địch đã chết có sát thương cao nhất, tăng sát thương trong 12 giây.",

            -- 浮士德
            HERO_ELVES_FAUSTUS_ENERVATION_DESCRIPTION_1 = "Phong ấn bí thuật vô hiệu hóa phép của 1 kẻ địch và áp dụng hiệu ứng Lửa rồng trong 6 giây.",
            HERO_ELVES_FAUSTUS_ENERVATION_DESCRIPTION_2 = "Phong ấn bí thuật vô hiệu hóa phép của 2 kẻ địch và áp dụng hiệu ứng Lửa rồng trong 8 giây.",
            HERO_ELVES_FAUSTUS_ENERVATION_DESCRIPTION_3 = "Phong ấn bí thuật vô hiệu hóa phép của 3 kẻ địch và áp dụng hiệu ứng Lửa rồng trong 12 giây.",
            HERO_ELVES_FAUSTUS_TELEPORT_RUNE_DESCRIPTION_1 = "Faustus kích hoạt cổ ngữ sức mạnh, dịch chuyển tối đa 2 kẻ địch ngược lại đường đi và áp dụng Phong ấn bí thuật.",
            HERO_ELVES_FAUSTUS_TELEPORT_RUNE_DESCRIPTION_2 = "Faustus kích hoạt cổ ngữ sức mạnh, dịch chuyển tối đa 4 kẻ địch ngược lại đường đi và áp dụng Phong ấn bí thuật.",
            HERO_ELVES_FAUSTUS_TELEPORT_RUNE_DESCRIPTION_3 = "Faustus kích hoạt cổ ngữ sức mạnh, dịch chuyển tối đa 6 kẻ địch ngược lại đường đi và áp dụng Phong ấn bí thuật.",

            -- 树人
            HERO_ELVES_FOREST_ELEMENTAL_BRANCHBALL_DESCRIPTION_1 = "Nhấc một kẻ địch có trên 300 máu rồi ném khỏi màn chơi. Một cú home run!",
            HERO_ELVES_FOREST_ELEMENTAL_BRANCHBALL_DESCRIPTION_2 = "Nhấc một kẻ địch có trên 350 máu rồi ném khỏi màn chơi. Một cú home run!",
            HERO_ELVES_FOREST_ELEMENTAL_BRANCHBALL_DESCRIPTION_3 = "Nhấc một kẻ địch có trên 400 máu rồi ném khỏi màn chơi. Một cú home run!",
            HERO_ELVES_FOREST_ELEMENTAL_NATURESWRAITH_DESCRIPTION_1 = "Phủ 9 dây leo gai lên một vùng rộng, mỗi gai gây 40 sát thương diện rộng, đồng thời triệu hồi một thụ nhân.",
            HERO_ELVES_FOREST_ELEMENTAL_NATURESWRAITH_DESCRIPTION_2 = "Phủ 12 dây leo gai lên một vùng rộng, mỗi gai gây 50 sát thương diện rộng, đồng thời triệu hồi một thụ nhân.",
            HERO_ELVES_FOREST_ELEMENTAL_NATURESWRAITH_DESCRIPTION_3 = "Phủ 15 dây leo gai lên một vùng rộng, mỗi gai gây 60 sát thương diện rộng, đồng thời triệu hồi một thụ nhân.",
            HERO_ELVES_FOREST_ELEMENTAL_OAKSEEDS_DESCRIPTION_1 = "Triệu hồi 2 thụ nhân non để chặn và tấn công kẻ địch. Mỗi thụ nhân rơi 1 vàng khi chết.",
            HERO_ELVES_FOREST_ELEMENTAL_OAKSEEDS_DESCRIPTION_2 = "Triệu hồi 2 thụ nhân non có máu được cường hóa để chặn và tấn công kẻ địch. Mỗi thụ nhân rơi 1 vàng khi chết.",
            HERO_ELVES_FOREST_ELEMENTAL_OAKSEEDS_DESCRIPTION_3 = "Triệu hồi 2 thụ nhân non có lượng máu cao nhất để chặn và tấn công kẻ địch. Mỗi thụ nhân rơi 1 vàng khi chết.",
            HERO_ELVES_FOREST_ELEMENTAL_ROOTSPIKES_DESCRIPTION_1 = "Rễ cây nhọn mọc lên từ mặt đất, gây 70–90 sát thương diện rộng.",
            HERO_ELVES_FOREST_ELEMENTAL_ROOTSPIKES_DESCRIPTION_2 = "Rễ cây nhọn mọc lên từ mặt đất, gây 100–150 sát thương diện rộng.",
            HERO_ELVES_FOREST_ELEMENTAL_ROOTSPIKES_DESCRIPTION_3 = "Rễ cây nhọn mọc lên từ mặt đất, gây 200–300 sát thương diện rộng.",
            HERO_ELVES_FOREST_ELEMENTAL_SPRINGSAP_DESCRIPTION_1 = "Bravebark bao bọc mình trong kén phép, hồi 60 máu cho bản thân và đồng minh trong 2 giây.",
            HERO_ELVES_FOREST_ELEMENTAL_SPRINGSAP_DESCRIPTION_2 = "Bravebark bao bọc mình trong kén phép, hồi 180 máu cho bản thân và đồng minh trong 3 giây.",
            HERO_ELVES_FOREST_ELEMENTAL_SPRINGSAP_DESCRIPTION_3 = "Bravebark bao bọc mình trong kén phép, hồi 360 máu cho bản thân và đồng minh trong 4 giây.",

            -- 威尔伯

            -- 莉恩
            HERO_ELVES_LYNN_WEAKENING_DESCRIPTION_1 = "Giảm 60 giáp và kháng phép của mục tiêu trong 4 giây.",
            HERO_ELVES_LYNN_WEAKENING_DESCRIPTION_2 = "Giảm 80 giáp và kháng phép của mục tiêu trong 6 giây.",
            HERO_ELVES_LYNN_WEAKENING_DESCRIPTION_3 = "Loại bỏ hoàn toàn giáp và kháng phép của mục tiêu trong 8 giây.",

            -- 熊猫
            HERO_ELVES_PANDA_INSPIRE_DESCRIPTION_1 = "Xin gầm lên, khích lệ đồng minh gần đó gây gấp đôi sát thương trong 7 giây.",
            HERO_ELVES_PANDA_INSPIRE_DESCRIPTION_2 = "Xin gầm lên, khích lệ đồng minh gần đó gây gấp đôi sát thương trong 10 giây.",
            HERO_ELVES_PANDA_INSPIRE_DESCRIPTION_3 = "Xin gầm lên, khích lệ đồng minh gần đó gây gấp đôi sát thương trong 13 giây.",
            HERO_ELVES_PANDA_KINDRED_SPIRITS_DESCRIPTION_1 = "Thi triển quyền thuật cổ truyền, gây 80–120 sát thương diện rộng lên mọi kẻ địch xung quanh.",
            HERO_ELVES_PANDA_KINDRED_SPIRITS_DESCRIPTION_2 = "Thi triển quyền thuật cổ truyền, gây 120–200 sát thương diện rộng lên mọi kẻ địch xung quanh.",
            HERO_ELVES_PANDA_KINDRED_SPIRITS_DESCRIPTION_3 = "Thi triển quyền thuật cổ truyền, gây 230–300 sát thương diện rộng lên mọi kẻ địch xung quanh.",
            HERO_ELVES_PANDA_MIND_OVER_BODY_DESCRIPTION_1 = "Xin uống rượu bí truyền, hồi 120 máu trong 8 giây.",
            HERO_ELVES_PANDA_MIND_OVER_BODY_DESCRIPTION_2 = "Xin uống rượu bí truyền, hồi 260 máu trong 12 giây.",
            HERO_ELVES_PANDA_MIND_OVER_BODY_DESCRIPTION_3 = "Xin uống rượu bí truyền, hồi 400 máu trong 18 giây.",

            -- 凤凰
            HERO_ELVES_PHOENIX_INMOLATE_DESCRIPTION_1 = "Phoenix lao xuống đất, gây 100 sát thương diện rộng và hy sinh; khiến Phoenix mất 10 máu mỗi giây.",
            HERO_ELVES_PHOENIX_INMOLATE_DESCRIPTION_2 = "Phoenix lao xuống đất, gây 200 sát thương diện rộng và hy sinh; khiến Phoenix mất 15 máu mỗi giây.",
            HERO_ELVES_PHOENIX_INMOLATE_DESCRIPTION_3 = "Phoenix lao xuống đất, gây 300 sát thương diện rộng và hy sinh; khiến Phoenix mất 30 máu mỗi giây.",

            -- 仙子
            HERO_ELVES_PIXIE_CURSE_DESCRIPTION_1 = "Mỗi đòn đánh của tiên nhỏ có 30% cơ hội nguyền rủa kẻ địch, làm choáng trong 0.5 giây.",
            HERO_ELVES_PIXIE_CURSE_DESCRIPTION_2 = "Mỗi đòn đánh của tiên nhỏ có 40% cơ hội nguyền rủa kẻ địch, làm choáng trong 1 giây.",
            HERO_ELVES_PIXIE_CURSE_DESCRIPTION_3 = "Mỗi đòn đánh của tiên nhỏ có 60% cơ hội nguyền rủa kẻ địch, làm choáng trong 1.5 giây.",
            HERO_ELVES_PIXIE_FURY_DESCRIPTION_1 = "Cử 2 tiên nhỏ tấn công kẻ địch gần đó, mỗi tiên gây 18–56 sát thương phép.",
            HERO_ELVES_PIXIE_FURY_DESCRIPTION_2 = "Cử 3 tiên nhỏ tấn công kẻ địch gần đó, mỗi tiên gây 22–76 sát thương phép.",
            HERO_ELVES_PIXIE_FURY_DESCRIPTION_3 = "Cử 4 tiên nhỏ tấn công kẻ địch gần đó, mỗi tiên gây 34–96 sát thương phép.",

            -- 大瑞格
            HERO_ELVES_RAG_ONE_GNOME_ARMY_DESCRIPTION_1 = "Biến tối đa 4 kẻ địch thành búp bê Rags chiến đấu cho phe ta trong 15 giây.",
            HERO_ELVES_RAG_ONE_GNOME_ARMY_DESCRIPTION_2 = "Biến tối đa 6 kẻ địch thành búp bê Rags chiến đấu cho phe ta trong 15 giây.",
            HERO_ELVES_RAG_ONE_GNOME_ARMY_DESCRIPTION_3 = "Biến tối đa 8 kẻ địch thành búp bê Rags chiến đấu cho phe ta trong 15 giây.",
            HERO_ELVES_RAG_RAGGIFIED_DESCRIPTION_1 = "Biến kẻ địch có lượng máu cao nhất nhưng không vượt quá 200 thành búp bê Rags chiến đấu cho phe ta trong 3 giây.",
            HERO_ELVES_RAG_RAGGIFIED_DESCRIPTION_2 = "Biến kẻ địch có lượng máu cao nhất nhưng không vượt quá 600 thành búp bê Rags chiến đấu cho phe ta trong 5 giây.",
            HERO_ELVES_RAG_RAGGIFIED_DESCRIPTION_3 = "Biến một kẻ địch bất kỳ có lượng máu cao nhất thành búp bê Rags chiến đấu cho phe ta trong 7 giây.",

            -- 维兹南
            HERO_ELVES_VEZNAN_ARCANENOVA_DESCRIPTION_1 = "Tạo vụ nổ phép lớn, gây 28–52 sát thương diện rộng và làm chậm kẻ địch trong 4 giây.",
            HERO_ELVES_VEZNAN_ARCANENOVA_DESCRIPTION_2 = "Tạo vụ nổ phép lớn, gây 46–86 sát thương diện rộng và làm chậm kẻ địch trong 4 giây.",
            HERO_ELVES_VEZNAN_ARCANENOVA_DESCRIPTION_3 = "Tạo vụ nổ phép lớn, gây 64–120 sát thương diện rộng và làm chậm kẻ địch trong 4 giây.",
            HERO_ELVES_VEZNAN_SHACKLES_DESCRIPTION_1 = "Nhốt 1 kẻ địch trong lồng phép, gây 108 sát thương trong 3 giây.",
            HERO_ELVES_VEZNAN_SHACKLES_DESCRIPTION_2 = "Nhốt tối đa 3 kẻ địch trong lồng phép, gây 108 sát thương lên mỗi mục tiêu trong 3 giây.",
            HERO_ELVES_VEZNAN_SHACKLES_DESCRIPTION_3 = "Nhốt tối đa 6 kẻ địch trong lồng phép, gây 108 sát thương lên mỗi mục tiêu trong 3 giây.",
            HERO_ELVES_VEZNAN_SOULBURN_DESCRIPTION_1 = "Khi máu kẻ địch xung quanh lớn hơn 400, phân rã một hoặc nhiều kẻ địch có tổng máu không vượt quá 500.",
            HERO_ELVES_VEZNAN_SOULBURN_DESCRIPTION_2 = "Khi máu kẻ địch xung quanh lớn hơn 400, phân rã một hoặc nhiều kẻ địch có tổng máu không vượt quá 750.",
            HERO_ELVES_VEZNAN_SOULBURN_DESCRIPTION_3 = "Khi máu kẻ địch xung quanh lớn hơn 400, phân rã một hoặc nhiều kẻ địch có tổng máu không vượt quá 1000.",
        },
        [4] = {
            HERO_BERESAD_FEAR_DRAGON_DESCRIPTION_1 = "Beresad gầm lên, khiến mọi kẻ địch bị ảnh hưởng hoảng sợ và chạy ngược đường trong 3 giây.",
            HERO_BERESAD_FEAR_DRAGON_DESCRIPTION_2 = "Beresad gầm lên, khiến mọi kẻ địch bị ảnh hưởng hoảng sợ và chạy ngược đường trong 4 giây.",
            HERO_BERESAD_FEAR_DRAGON_DESCRIPTION_3 = "Beresad gầm lên, khiến mọi kẻ địch bị ảnh hưởng hoảng sợ và chạy ngược đường trong 5 giây.",
            HERO_MURGLUN_INFERNAL_HEAT_DESCRIPTION_1 = "Cứ mỗi 22 giây, Murglun vỗ cánh rực lửa, gây 100 sát thương chuẩn diện rộng và liên tục làm chậm kẻ địch 30%.",
            HERO_MURGLUN_INFERNAL_HEAT_DESCRIPTION_2 = "Cứ mỗi 18 giây, Murglun vỗ cánh rực lửa, gây 100 sát thương chuẩn diện rộng và liên tục làm chậm kẻ địch 30%.",
            HERO_MURGLUN_INFERNAL_HEAT_DESCRIPTION_3 = "Cứ mỗi 14 giây, Murglun vỗ cánh rực lửa, gây 100 sát thương chuẩn diện rộng và liên tục làm chậm kẻ địch 30%.",
            HERO_JACK_O_LANTERN_HERO_JACKO_MELEE_DESCRIPTION_1 = "Jack tích lũy 30% sát thương nhận vào và giải phóng toàn bộ trong đòn đánh tiếp theo.",
            HERO_JACK_O_LANTERN_HERO_JACKO_MELEE_DESCRIPTION_2 = "Jack tích lũy 50% sát thương nhận vào và giải phóng toàn bộ trong đòn đánh tiếp theo.",
            HERO_JACK_O_LANTERN_HERO_JACKO_MELEE_DESCRIPTION_3 = "Jack tích lũy 75% sát thương nhận vào và giải phóng toàn bộ trong đòn đánh tiếp theo.",
        },
        [5] = {
            -- 狮鹫
            HERO_BIRD_BIRDS_OF_PREY_DESCRIPTION_1 =
            "Gọi gryphon tấn công phía trên vùng chỉ định trong 17 giây, mỗi đòn gây %$heroes.hero_bird.ultimate.bird.melee_attack.damage_max[1]%$ sát thương.",
            HERO_BIRD_BIRDS_OF_PREY_DESCRIPTION_2 =
            "Gọi gryphon tấn công phía trên vùng chỉ định trong 19 giây, mỗi đòn gây %$heroes.hero_bird.ultimate.bird.melee_attack.damage_max[2]%$ sát thương.",
            HERO_BIRD_BIRDS_OF_PREY_DESCRIPTION_3 =
            "Gọi gryphon tấn công phía trên vùng chỉ định trong 22 giây, mỗi đòn gây %$heroes.hero_bird.ultimate.bird.melee_attack.damage_max[3]%$ sát thương.",
            HERO_BIRD_CLUSTER_BOMB_DESCRIPTION_1 =
            "Ném thuốc nổ phân mảnh, gây %$heroes.hero_bird.cluster_bomb.explosion_damage_min[1]%$ sát thương và đốt cháy mặt đất trong 16 giây. Kẻ địch chịu 64 sát thương thiêu đốt trong 16 giây.",
            HERO_BIRD_CLUSTER_BOMB_DESCRIPTION_2 =
            "Ném thuốc nổ phân mảnh, gây %$heroes.hero_bird.cluster_bomb.explosion_damage_min[2]%$ sát thương và đốt cháy mặt đất trong 32 giây. Kẻ địch chịu 128 sát thương thiêu đốt trong 32 giây.",
            HERO_BIRD_CLUSTER_BOMB_DESCRIPTION_3 =
            "Ném thuốc nổ phân mảnh, gây %$heroes.hero_bird.cluster_bomb.explosion_damage_min[3]%$ sát thương và đốt cháy mặt đất trong 40 giây. Kẻ địch chịu 160 sát thương thiêu đốt trong 40 giây.",
            HERO_BIRD_EAT_INSTAKILL_DESCRIPTION_1 = "Gryphon lao xuống đất, nuốt chửng một kẻ địch có máu không vượt quá %$heroes.hero_bird.eat_instakill.hp_max[1]%$.",
            HERO_BIRD_EAT_INSTAKILL_DESCRIPTION_2 = "Gryphon lao xuống đất, nuốt chửng một kẻ địch có máu không vượt quá %$heroes.hero_bird.eat_instakill.hp_max[2]%$.",
            HERO_BIRD_EAT_INSTAKILL_DESCRIPTION_3 = "Gryphon lao xuống đất, nuốt chửng một kẻ địch có máu không vượt quá %$heroes.hero_bird.eat_instakill.hp_max[3]%$.",
            HERO_BIRD_SHOUT_STUN_DESCRIPTION_1 =
            "Gryphon kêu vang, làm choáng kẻ địch 0.25 giây, sau đó làm chậm trong 1.5 giây.",
            HERO_BIRD_SHOUT_STUN_DESCRIPTION_2 =
            "Gryphon kêu vang, làm choáng kẻ địch 0.5 giây, sau đó làm chậm trong 1.5 giây.",
            HERO_BIRD_SHOUT_STUN_DESCRIPTION_3 =
            "Gryphon kêu vang, làm choáng kẻ địch 0.75 giây, sau đó làm chậm trong 1.5 giây.",

            -- 土木人
            HERO_BUILDER_DEFENSIVE_TURRET_DESCRIPTION_1 =
            "Dựng một tháp tạm thời tấn công kẻ địch đi qua trong 50 giây, mỗi đòn gây 4–6 sát thương vật lý.",
            HERO_BUILDER_DEFENSIVE_TURRET_DESCRIPTION_2 =
            "Dựng một tháp tạm thời tấn công kẻ địch đi qua trong 75 giây, mỗi đòn gây 8–12 sát thương vật lý.",
            HERO_BUILDER_DEFENSIVE_TURRET_DESCRIPTION_3 =
            "Dựng một tháp tạm thời tấn công kẻ địch đi qua trong 100 giây, mỗi đòn gây 12–18 sát thương vật lý.",
            HERO_BUILDER_DEMOLITION_MAN_DESCRIPTION_1 =
            "Xoay nhanh xà gỗ, gây %$heroes.hero_builder.demolition_man.s_damage_min[1]%$–%$heroes.hero_builder.demolition_man.s_damage_max[1]%$ sát thương vật lý và làm choáng kẻ địch xung quanh trong 1.5 giây.",
            HERO_BUILDER_DEMOLITION_MAN_DESCRIPTION_2 =
            "Xoay nhanh xà gỗ, gây %$heroes.hero_builder.demolition_man.s_damage_min[2]%$–%$heroes.hero_builder.demolition_man.s_damage_max[2]%$ sát thương vật lý và làm choáng kẻ địch xung quanh trong 1.5 giây.",
            HERO_BUILDER_DEMOLITION_MAN_DESCRIPTION_3 =
            "Xoay nhanh xà gỗ, gây %$heroes.hero_builder.demolition_man.s_damage_min[3]%$–%$heroes.hero_builder.demolition_man.s_damage_max[3]%$ sát thương vật lý và làm choáng kẻ địch xung quanh trong 1.5 giây.",
            HERO_BUILDER_LUNCH_BREAK_DESCRIPTION_1 =
            "Torres ngừng chiến đấu để ăn nhẹ, hồi 25% máu. Mỗi tháp tạm thời xung quanh tăng 15% máu cho Torres.",
            HERO_BUILDER_LUNCH_BREAK_DESCRIPTION_2 =
            "Torres ngừng chiến đấu để ăn nhẹ, hồi 30% máu. Mỗi tháp tạm thời xung quanh tăng 15% máu cho Torres.",
            HERO_BUILDER_LUNCH_BREAK_DESCRIPTION_3 =
            "Torres ngừng chiến đấu để ăn nhẹ, hồi 40% máu. Mỗi tháp tạm thời xung quanh tăng 15% máu cho Torres.",
            HERO_BUILDER_WRECKING_BALL_DESCRIPTION_1 =
            "Ném cầu thép khổng lồ xuống đường, gây %$heroes.hero_builder.ultimate.damage[1]%$ sát thương vật lý và làm choáng mục tiêu trong 3 giây, đồng thời làm choáng kẻ địch trong vùng rộng trong 2 giây.",
            HERO_BUILDER_WRECKING_BALL_DESCRIPTION_2 =
            "Ném cầu thép khổng lồ xuống đường, gây %$heroes.hero_builder.ultimate.damage[2]%$ sát thương vật lý và làm choáng mục tiêu trong 4 giây, đồng thời làm choáng kẻ địch trong vùng rộng trong 2 giây.",
            HERO_BUILDER_WRECKING_BALL_DESCRIPTION_3 =
            "Ném cầu thép khổng lồ xuống đường, gây %$heroes.hero_builder.ultimate.damage[3]%$ sát thương vật lý và làm choáng mục tiêu trong 5 giây, đồng thời làm choáng kẻ địch trong vùng rộng trong 2 giây.",

            -- 木龙

            -- 骨龙
            HERO_DRAGON_BONE_BURST_DESCRIPTION_1 =
            "Phóng 10 đạn phép, mỗi đạn gây %$heroes.hero_dragon_bone.burst.damage_min[1]%$–%$heroes.hero_dragon_bone.burst.damage_max[1]%$ sát thương chuẩn và áp dụng dịch bệnh.",
            HERO_DRAGON_BONE_BURST_DESCRIPTION_2 =
            "Phóng 13 đạn phép, mỗi đạn gây %$heroes.hero_dragon_bone.burst.damage_min[2]%$–%$heroes.hero_dragon_bone.burst.damage_max[2]%$ sát thương chuẩn và áp dụng dịch bệnh.",
            HERO_DRAGON_BONE_BURST_DESCRIPTION_3 =
            "Phóng 14 đạn phép, mỗi đạn gây %$heroes.hero_dragon_bone.burst.damage_min[3]%$–%$heroes.hero_dragon_bone.burst.damage_max[3]%$ sát thương chuẩn và áp dụng dịch bệnh.",
            HERO_DRAGON_BONE_RAISE_DRAKES_DESCRIPTION_1 =
            "Triệu hồi hai rồng xương nhỏ, mỗi con có %$heroes.hero_dragon_bone.ultimate.dog.hp[1]%$ máu và gây %$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_min[2]%$–%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_max[1]%$ sát thương vật lý mỗi đòn. Bonehart nhận Hào quang Kỵ sĩ Tử thần cao cấp, cường hóa tháp và sinh vật bất tử gần đó.",
            HERO_DRAGON_BONE_RAISE_DRAKES_DESCRIPTION_2 =
            "Triệu hồi hai rồng xương nhỏ, mỗi con có %$heroes.hero_dragon_bone.ultimate.dog.hp[2]%$ máu và gây %$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_min[3]%$–%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_max[2]%$ sát thương vật lý mỗi đòn. Bonehart nhận Hào quang Kỵ sĩ Tử thần cao cấp, cường hóa tháp và sinh vật bất tử gần đó.",
            HERO_DRAGON_BONE_RAISE_DRAKES_DESCRIPTION_3 =
            "Triệu hồi hai rồng xương nhỏ, mỗi con có %$heroes.hero_dragon_bone.ultimate.dog.hp[3]%$ máu và gây %$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_min[4]%$–%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_max[3]%$ sát thương vật lý mỗi đòn. Bonehart nhận Hào quang Kỵ sĩ Tử thần cao cấp, cường hóa tháp và sinh vật bất tử gần đó.",

            -- 晶龙
            HERO_DRAGON_GEM_CRYSTAL_TOTEM_DESCRIPTION_1 =
            "Ném pha lê xuống đường, làm chậm kẻ địch %$heroes.hero_dragon_gem.crystal_totem.s_slow_factor%$% và gây 6–8 sát thương phép xung quanh mỗi 1 giây. Kéo dài %$heroes.hero_dragon_gem.crystal_totem.duration[1]%$ giây.",
            HERO_DRAGON_GEM_CRYSTAL_TOTEM_DESCRIPTION_2 =
            "Ném pha lê xuống đường, làm chậm kẻ địch %$heroes.hero_dragon_gem.crystal_totem.s_slow_factor%$% và gây 8–10 sát thương phép xung quanh mỗi 1 giây. Kéo dài %$heroes.hero_dragon_gem.crystal_totem.duration[2]%$ giây.",
            HERO_DRAGON_GEM_CRYSTAL_TOTEM_DESCRIPTION_3 =
            "Ném pha lê xuống đường, làm chậm kẻ địch %$heroes.hero_dragon_gem.crystal_totem.s_slow_factor%$% và gây 10–12 sát thương phép xung quanh mỗi 1 giây. Kéo dài %$heroes.hero_dragon_gem.crystal_totem.duration[3]%$ giây.",
            HERO_DRAGON_GEM_FALLING_CRYSTALS_DESCRIPTION_1 =
            "Triệu hồi 7 mũi pha lê, gây %$heroes.hero_dragon_gem.ultimate.damage_min[1]%$–%$heroes.hero_dragon_gem.ultimate.damage_max[1]%$ sát thương chuẩn lên kẻ địch trong phạm vi.",
            HERO_DRAGON_GEM_FALLING_CRYSTALS_DESCRIPTION_2 =
            "Triệu hồi 9 mũi pha lê, gây %$heroes.hero_dragon_gem.ultimate.damage_min[2]%$–%$heroes.hero_dragon_gem.ultimate.damage_max[2]%$ sát thương chuẩn lên kẻ địch trong phạm vi.",
            HERO_DRAGON_GEM_FALLING_CRYSTALS_DESCRIPTION_3 =
            "Triệu hồi 11 mũi pha lê, gây %$heroes.hero_dragon_gem.ultimate.damage_min[3]%$–%$heroes.hero_dragon_gem.ultimate.damage_max[3]%$ sát thương chuẩn lên kẻ địch trong phạm vi.",

            -- 安雅
            HERO_HUNTER_BEASTS_DESCRIPTION_1 =
            "Triệu hồi 2 dơi tấn công trong 8 giây, gây 3–6 sát thương vật lý. Mỗi con có cơ hội cướp 1 vàng từ mục tiêu.",
            HERO_HUNTER_BEASTS_DESCRIPTION_2 =
            "Triệu hồi 2 dơi tấn công trong 13 giây, gây 4–8 sát thương vật lý. Mỗi con có cơ hội cướp 2 vàng từ mục tiêu.",
            HERO_HUNTER_BEASTS_DESCRIPTION_3 =
            "Triệu hồi 2 dơi tấn công trong 18 giây, gây 7–12 sát thương vật lý. Mỗi con có cơ hội cướp 2 vàng từ mục tiêu.",
            HERO_HUNTER_RICOCHET_DESCRIPTION_1 =
            "Anya hóa sương, nhảy qua 3 kẻ địch, gây 55–75 sát thương vật lý lên mỗi mục tiêu và triệu hồi một con dơi sau mỗi lần nhảy.",
            HERO_HUNTER_RICOCHET_DESCRIPTION_2 =
            "Anya hóa sương, nhảy qua 4 kẻ địch, gây 75–100 sát thương vật lý lên mỗi mục tiêu và triệu hồi một con dơi sau mỗi lần nhảy.",
            HERO_HUNTER_RICOCHET_DESCRIPTION_3 =
            "Anya hóa sương, nhảy qua 4 kẻ địch, gây 105–130 sát thương vật lý lên mỗi mục tiêu và triệu hồi một con dơi sau mỗi lần nhảy.",
            HERO_HUNTER_SHOOT_AROUND_DESCRIPTION_1 =
            "Bắn vào mọi kẻ địch xung quanh, gây %$heroes.hero_hunter.shoot_around.s_damage_min[1]%$–%$heroes.hero_hunter.shoot_around.s_damage_max[1]%$ sát thương chuẩn lên mỗi mục tiêu mỗi 0.07 giây.",
            HERO_HUNTER_SHOOT_AROUND_DESCRIPTION_2 =
            "Bắn vào mọi kẻ địch xung quanh, gây %$heroes.hero_hunter.shoot_around.s_damage_min[2]%$–%$heroes.hero_hunter.shoot_around.s_damage_max[2]%$ sát thương chuẩn lên mỗi mục tiêu mỗi 0.07 giây.",
            HERO_HUNTER_SHOOT_AROUND_DESCRIPTION_3 =
            "Bắn vào mọi kẻ địch xung quanh, gây %$heroes.hero_hunter.shoot_around.s_damage_min[3]%$–%$heroes.hero_hunter.shoot_around.s_damage_max[3]%$ sát thương chuẩn lên mỗi mục tiêu mỗi 0.07 giây.",
            
            -- 岩浆怪
            
            -- 光龙
            HERO_LUMENIR_CELESTIAL_JUDGEMENT_DESCRIPTION_1 =
            "Phóng kiếm ánh sáng vào kẻ địch mạnh nhất gần đó, gây %$heroes.hero_lumenir.celestial_judgement.damage[1]%$ sát thương chuẩn và làm choáng %$heroes.hero_lumenir.celestial_judgement.stun_duration[1]%$ giây, đồng thời gây 150 sát thương lên kẻ địch xung quanh.",
            HERO_LUMENIR_CELESTIAL_JUDGEMENT_DESCRIPTION_2 =
            "Phóng kiếm ánh sáng vào kẻ địch mạnh nhất gần đó, gây %$heroes.hero_lumenir.celestial_judgement.damage[2]%$ sát thương chuẩn và làm choáng %$heroes.hero_lumenir.celestial_judgement.stun_duration[2]%$ giây, đồng thời gây 150 sát thương lên kẻ địch xung quanh.",
            HERO_LUMENIR_CELESTIAL_JUDGEMENT_DESCRIPTION_3 =
            "Phóng kiếm ánh sáng vào kẻ địch mạnh nhất gần đó, gây %$heroes.hero_lumenir.celestial_judgement.damage[3]%$ sát thương chuẩn và làm choáng %$heroes.hero_lumenir.celestial_judgement.stun_duration[3]%$ giây, đồng thời gây 150 sát thương lên kẻ địch xung quanh.",
            HERO_LUMENIR_FIRE_BALLS_DESCRIPTION_1 =
            "Thổi 5 quả cầu ánh sáng thiêng liêng dọc đường đi, mỗi quả gây %$heroes.hero_lumenir.fire_balls.flame_damage_min[1]%$–%$heroes.hero_lumenir.fire_balls.flame_damage_max[1]%$ sát thương chuẩn lên mỗi kẻ địch đi qua.",
            HERO_LUMENIR_FIRE_BALLS_DESCRIPTION_2 =
            "Thổi 6 quả cầu ánh sáng thiêng liêng dọc đường đi, mỗi quả gây %$heroes.hero_lumenir.fire_balls.flame_damage_min[2]%$–%$heroes.hero_lumenir.fire_balls.flame_damage_max[2]%$ sát thương chuẩn lên mỗi kẻ địch đi qua.",
            HERO_LUMENIR_FIRE_BALLS_DESCRIPTION_3 =
            "Thổi 8 quả cầu ánh sáng thiêng liêng dọc đường đi, mỗi quả gây %$heroes.hero_lumenir.fire_balls.flame_damage_min[3]%$–%$heroes.hero_lumenir.fire_balls.flame_damage_max[3]%$ sát thương chuẩn lên mỗi kẻ địch đi qua.",
            
            -- 哥布林机甲
            HERO_MECHA_DEATH_FROM_ABOVE_DESCRIPTION_1 =
            "Gọi khí cầu goblin oanh tạc kẻ địch trên một hàng ngang, mỗi đòn gây %$heroes.hero_mecha.ultimate.ranged_attack.damage_min[1]%$–%$heroes.hero_mecha.ultimate.ranged_attack.damage_max[1]%$ sát thương chuẩn diện rộng.",
            HERO_MECHA_DEATH_FROM_ABOVE_DESCRIPTION_2 =
            "Gọi khí cầu goblin oanh tạc kẻ địch trên một hàng ngang, mỗi đòn gây %$heroes.hero_mecha.ultimate.ranged_attack.damage_min[2]%$–%$heroes.hero_mecha.ultimate.ranged_attack.damage_max[2]%$ sát thương chuẩn diện rộng.",
            HERO_MECHA_DEATH_FROM_ABOVE_DESCRIPTION_3 =
            "Gọi khí cầu goblin oanh tạc kẻ địch trên một hàng ngang, mỗi đòn gây %$heroes.hero_mecha.ultimate.ranged_attack.damage_min[3]%$–%$heroes.hero_mecha.ultimate.ranged_attack.damage_max[3]%$ sát thương chuẩn diện rộng.",
            HERO_MECHA_GOBLIDRONES_DESCRIPTION_1 =
            "Triệu hồi %$heroes.hero_mecha.goblidrones.units%$ drone tấn công trong 12 giây, mỗi đòn gây %$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_min[1]%$–%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_max[1]%$ sát thương vật lý.",
            HERO_MECHA_GOBLIDRONES_DESCRIPTION_2 =
            "Triệu hồi %$heroes.hero_mecha.goblidrones.units%$ drone tấn công trong 18 giây, mỗi đòn gây %$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_min[2]%$–%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_max[2]%$ sát thương vật lý.",
            HERO_MECHA_GOBLIDRONES_DESCRIPTION_3 =
            "Triệu hồi %$heroes.hero_mecha.goblidrones.units%$ drone tấn công trong 23 giây, mỗi đòn gây %$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_min[3]%$–%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_max[3]%$ sát thương vật lý.",
            HERO_MECHA_MINE_DROP_DESCRIPTION_1 =
            "Khi đứng yên, cỗ máy định kỳ đặt tối đa 4 mìn trên đường. Mỗi mìn gây %$heroes.hero_mecha.mine_drop.damage_min[1]%$–%$heroes.hero_mecha.mine_drop.damage_max[1]%$ sát thương nổ.",
            HERO_MECHA_MINE_DROP_DESCRIPTION_2 =
            "Khi đứng yên, cỗ máy định kỳ đặt tối đa 5 mìn trên đường. Mỗi mìn gây %$heroes.hero_mecha.mine_drop.damage_min[2]%$–%$heroes.hero_mecha.mine_drop.damage_max[2]%$ sát thương nổ.",
            HERO_MECHA_MINE_DROP_DESCRIPTION_3 =
            "Khi đứng yên, cỗ máy định kỳ đặt tối đa 7 mìn trên đường. Mỗi mìn gây %$heroes.hero_mecha.mine_drop.damage_min[3]%$–%$heroes.hero_mecha.mine_drop.damage_max[3]%$ sát thương nổ.",
            
            -- 尼鲁
            HERO_MUYRN_ROOT_DEFENDER_DESCRIPTION_1 =
            "Tạo rễ cây trong một vùng trong %$heroes.hero_muyrn.ultimate.duration[1]%$ giây, làm chậm kẻ địch và gây 24–40 sát thương chuẩn mỗi giây.",
            HERO_MUYRN_ROOT_DEFENDER_DESCRIPTION_2 =
            "Tạo rễ cây trong một vùng trong %$heroes.hero_muyrn.ultimate.duration[2]%$ giây, làm chậm kẻ địch và gây 28–44 sát thương chuẩn mỗi giây.",
            HERO_MUYRN_ROOT_DEFENDER_DESCRIPTION_3 =
            "Tạo rễ cây trong một vùng trong %$heroes.hero_muyrn.ultimate.duration[3]%$ giây, làm chậm kẻ địch và gây 32–48 sát thương chuẩn mỗi giây.",
            HERO_MUYRN_SENTINEL_WISPS_DESCRIPTION_1 =
            "Triệu hồi %$heroes.hero_muyrn.sentinel_wisps.max_summons[1]%$ tiên nhỏ thân thiện đi theo Nyru trong 8 giây, gây %$heroes.hero_muyrn.sentinel_wisps.wisp.damage_min[1]%$–%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_max[1]%$ sát thương phép.",
            HERO_MUYRN_SENTINEL_WISPS_DESCRIPTION_2 =
            "Triệu hồi %$heroes.hero_muyrn.sentinel_wisps.max_summons[2]%$ tiên nhỏ thân thiện đi theo Nyru trong 11 giây, gây %$heroes.hero_muyrn.sentinel_wisps.wisp.damage_min[2]%$–%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_max[2]%$ sát thương phép.",
            HERO_MUYRN_SENTINEL_WISPS_DESCRIPTION_3 =
            "Triệu hồi %$heroes.hero_muyrn.sentinel_wisps.max_summons[3]%$ tiên nhỏ thân thiện đi theo Nyru trong 14 giây, gây %$heroes.hero_muyrn.sentinel_wisps.wisp.damage_min[3]%$–%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_max[3]%$ sát thương phép.",
            HERO_MUYRN_VERDANT_BLAST_DESCRIPTION_1 =
            "Bắn tia năng lượng xanh, gây %$heroes.hero_muyrn.verdant_blast.s_damage[1]%$ sát thương phép và tăng 1 máu mỗi 275 giây.",
            HERO_MUYRN_VERDANT_BLAST_DESCRIPTION_2 =
            "Bắn tia năng lượng xanh, gây %$heroes.hero_muyrn.verdant_blast.s_damage[2]%$ sát thương phép và tăng 1 máu mỗi 245 giây.",
            HERO_MUYRN_VERDANT_BLAST_DESCRIPTION_3 =
            "Bắn tia năng lượng xanh, gây %$heroes.hero_muyrn.verdant_blast.s_damage[3]%$ sát thương phép và tăng 1 máu mỗi 210 giây.",
            
            -- 黑暗中尉
            HERO_RAELYN_INSPIRE_FEAR_DESCRIPTION_1 =
            "Làm choáng kẻ địch gần đó trong %$heroes.hero_raelyn.inspire_fear.stun_duration[1]%$ giây và giảm sát thương tấn công của chúng trong 6 giây.",
            HERO_RAELYN_INSPIRE_FEAR_DESCRIPTION_2 =
            "Làm choáng kẻ địch gần đó trong %$heroes.hero_raelyn.inspire_fear.stun_duration[2]%$ giây và giảm sát thương tấn công của chúng trong 7 giây.",
            HERO_RAELYN_INSPIRE_FEAR_DESCRIPTION_3 =
            "Làm choáng kẻ địch gần đó trong %$heroes.hero_raelyn.inspire_fear.stun_duration[3]%$ giây và giảm sát thương tấn công của chúng trong 9 giây.",
            HERO_RAELYN_UNBREAKABLE_DESCRIPTION_1 =
            "Trong chiến đấu, mỗi kẻ địch gần Raelyn tạo cho cô lượng khiên bằng %$heroes.hero_raelyn.unbreakable.shield_per_enemy[1]%$% máu tối đa, tính tối đa %$heroes.hero_raelyn.unbreakable.max_targets%$ kẻ địch. Khiên tồn tại 6 giây.",
            HERO_RAELYN_UNBREAKABLE_DESCRIPTION_2 =
            "Trong chiến đấu, mỗi kẻ địch gần Raelyn tạo cho cô lượng khiên bằng %$heroes.hero_raelyn.unbreakable.shield_per_enemy[2]%$% máu tối đa, tính tối đa %$heroes.hero_raelyn.unbreakable.max_targets%$ kẻ địch. Khiên tồn tại 8 giây.",
            HERO_RAELYN_UNBREAKABLE_DESCRIPTION_3 =
            "Trong chiến đấu, mỗi kẻ địch gần Raelyn tạo cho cô lượng khiên bằng %$heroes.hero_raelyn.unbreakable.shield_per_enemy[3]%$% máu tối đa, tính tối đa %$heroes.hero_raelyn.unbreakable.max_targets%$ kẻ địch. Khiên tồn tại 10 giây.",

            -- 战争巨头
            HERO_ROBOT_EXPLODE_DESCRIPTION_1 =
            "Tạo vụ nổ gây %$heroes.hero_robot.explode.damage_min[1]%$–%$heroes.hero_robot.explode.damage_max[1]%$ sát thương nổ và thiêu đốt kẻ địch trong %$heroes.hero_robot.explode.burning_duration%$ giây. Thiêu đốt gây 12 sát thương mỗi giây.",
            HERO_ROBOT_EXPLODE_DESCRIPTION_2 =
            "Tạo vụ nổ gây %$heroes.hero_robot.explode.damage_min[2]%$–%$heroes.hero_robot.explode.damage_max[2]%$ sát thương nổ và thiêu đốt kẻ địch trong %$heroes.hero_robot.explode.burning_duration%$ giây. Thiêu đốt gây 16 sát thương mỗi giây.",
            HERO_ROBOT_EXPLODE_DESCRIPTION_3 =
            "Tạo vụ nổ gây %$heroes.hero_robot.explode.damage_min[3]%$–%$heroes.hero_robot.explode.damage_max[3]%$ sát thương nổ và thiêu đốt kẻ địch trong %$heroes.hero_robot.explode.burning_duration%$ giây. Thiêu đốt gây 20 sát thương mỗi giây.",
            HERO_ROBOT_FIRE_DESCRIPTION_1 =
            "Bắn đạn chứa than hồng, gây %$heroes.hero_robot.fire.damage_min[1]%$–%$heroes.hero_robot.fire.damage_max[1]%$ sát thương vật lý, làm choáng và thiêu đốt kẻ địch trong %$heroes.hero_robot.fire.s_slow_duration[1]%$ giây.",
            HERO_ROBOT_FIRE_DESCRIPTION_2 =
            "Bắn đạn chứa than hồng, gây %$heroes.hero_robot.fire.damage_min[2]%$–%$heroes.hero_robot.fire.damage_max[2]%$ sát thương vật lý, làm choáng và thiêu đốt kẻ địch trong %$heroes.hero_robot.fire.s_slow_duration[1]%$ giây.",
            HERO_ROBOT_FIRE_DESCRIPTION_3 =
            "Bắn đạn chứa than hồng, gây %$heroes.hero_robot.fire.damage_min[3]%$–%$heroes.hero_robot.fire.damage_max[3]%$ sát thương vật lý, làm choáng và thiêu đốt kẻ địch trong %$heroes.hero_robot.fire.s_slow_duration[1]%$ giây.",
            HERO_ROBOT_FIRE_TITLE = "Màn khói khí độc",
            HERO_ROBOT_JUMP_DESCRIPTION_1 =
            "Nhảy lên và đập vào một kẻ địch, làm choáng trong 2 giây và gây %$heroes.hero_robot.jump.s_damage[1]%$ sát thương vật lý diện rộng.",
            HERO_ROBOT_JUMP_DESCRIPTION_2 =
            "Nhảy lên và đập vào một kẻ địch, làm choáng trong 3 giây và gây %$heroes.hero_robot.jump.s_damage[2]%$ sát thương vật lý diện rộng.",
            HERO_ROBOT_JUMP_DESCRIPTION_3 =
            "Nhảy lên và đập vào một kẻ địch, làm choáng trong 4 giây và gây %$heroes.hero_robot.jump.s_damage[3]%$ sát thương vật lý diện rộng.",
            HERO_ROBOT_TRAIN_DESCRIPTION_1 =
            "Triệu hồi chiến xa đi dọc đường, gây %$heroes.hero_robot.ultimate.s_damage[1]%$ sát thương và thiêu đốt kẻ địch trong %$heroes.hero_robot.ultimate.burning_duration%$ giây. Thiêu đốt gây 12 sát thương mỗi giây.",
            HERO_ROBOT_TRAIN_DESCRIPTION_2 =
            "Triệu hồi chiến xa đi dọc đường, gây %$heroes.hero_robot.ultimate.s_damage[2]%$ sát thương và thiêu đốt kẻ địch trong %$heroes.hero_robot.ultimate.burning_duration%$ giây. Thiêu đốt gây 16 sát thương mỗi giây.",
            HERO_ROBOT_TRAIN_DESCRIPTION_3 =
            "Triệu hồi chiến xa đi dọc đường, gây %$heroes.hero_robot.ultimate.s_damage[3]%$ sát thương và thiêu đốt kẻ địch trong %$heroes.hero_robot.ultimate.burning_duration%$ giây. Thiêu đốt gây 20 sát thương mỗi giây.",

            -- 虚空法师
            HERO_SPACE_ELF_SPATIAL_DISTORTION_DESCRIPTION_1 =
            "Bẻ cong không gian quanh mọi tháp trong 8 giây, tăng %$heroes.hero_space_elf.spatial_distortion.s_range_factor[1]%$% tầm đánh.",
            HERO_SPACE_ELF_SPATIAL_DISTORTION_DESCRIPTION_2 =
            "Bẻ cong không gian quanh mọi tháp trong 10 giây, tăng %$heroes.hero_space_elf.spatial_distortion.s_range_factor[2]%$% tầm đánh.",
            HERO_SPACE_ELF_SPATIAL_DISTORTION_DESCRIPTION_3 =
            "Bẻ cong không gian quanh mọi tháp trong 12 giây, tăng %$heroes.hero_space_elf.spatial_distortion.s_range_factor[3]%$% tầm đánh.",
            
            -- 蛛后
            HERO_SPIDER_ARACNID_SPAWNER_DESCRIPTION_1 =
            "Triệu hồi %$heroes.hero_spider.ultimate.spawn_amount[1]%$ nhện chiến đấu trong 8 giây. Đòn đánh của nhện có 25% cơ hội làm choáng kẻ địch.",
            HERO_SPIDER_ARACNID_SPAWNER_DESCRIPTION_2 =
            "Triệu hồi %$heroes.hero_spider.ultimate.spawn_amount[2]%$ nhện chiến đấu trong 10 giây. Đòn đánh của nhện có 25% cơ hội làm choáng kẻ địch.",
            HERO_SPIDER_ARACNID_SPAWNER_DESCRIPTION_3 =
            "Triệu hồi %$heroes.hero_spider.ultimate.spawn_amount[3]%$ nhện chiến đấu trong 12 giây. Đòn đánh của nhện có 25% cơ hội làm choáng kẻ địch.",
            
            -- 毒液
            HERO_VENOM_CREEPING_DEATH_DESCRIPTION_1 =
            "Rải chất nhầy trong một vùng, gây 10–15 sát thương chuẩn mỗi 3 giây trong 40 giây. Nếu có vùng chất nhầy khác, mở cổng dịch chuyển đồng minh và kẻ địch.",
            HERO_VENOM_CREEPING_DEATH_DESCRIPTION_2 =
            "Rải chất nhầy trong một vùng, gây 15–20 sát thương chuẩn mỗi 3 giây trong 50 giây. Nếu có vùng chất nhầy khác, mở cổng dịch chuyển đồng minh và kẻ địch.",
            HERO_VENOM_CREEPING_DEATH_DESCRIPTION_3 =
            "Rải chất nhầy trong một vùng, gây 20–25 sát thương chuẩn mỗi 3 giây trong 60 giây. Nếu có vùng chất nhầy khác, mở cổng dịch chuyển đồng minh và kẻ địch.",
            HERO_VENOM_INNER_BEAST_DESCRIPTION_1 =
            "Khi máu dưới 60%, Grimson biến hình hoàn toàn, tăng %$heroes.hero_venom.inner_beast.basic_melee.s_damage_factor[1]%$% sát thương và hồi %$heroes.hero_venom.inner_beast.basic_melee.regen_health%$% máu tối đa mỗi khi đánh trúng, kéo dài %$heroes.hero_venom.inner_beast.duration%$ giây.",
            HERO_VENOM_INNER_BEAST_DESCRIPTION_2 =
            "Khi máu dưới 60%, Grimson biến hình hoàn toàn, tăng %$heroes.hero_venom.inner_beast.basic_melee.s_damage_factor[2]%$% sát thương và hồi %$heroes.hero_venom.inner_beast.basic_melee.regen_health%$% máu tối đa mỗi khi đánh trúng, kéo dài %$heroes.hero_venom.inner_beast.duration%$ giây.",
            HERO_VENOM_INNER_BEAST_DESCRIPTION_3 =
            "Khi máu dưới 60%, Grimson biến hình hoàn toàn, tăng %$heroes.hero_venom.inner_beast.basic_melee.s_damage_factor[3]%$% sát thương và hồi %$heroes.hero_venom.inner_beast.basic_melee.regen_health%$% máu tối đa mỗi khi đánh trúng, kéo dài %$heroes.hero_venom.inner_beast.duration%$ giây.",
            HERO_VENOM_RANGED_TENTACLE_DESCRIPTION_1 =
            "Đòn đánh tầm xa dịch chuyển mục tiêu lùi lại, gây %$heroes.hero_venom.ranged_tentacle.s_damage[1]%$ sát thương vật lý và có %$heroes.hero_venom.ranged_tentacle.bleed_chance[1]%$% cơ hội gây chảy máu. Chảy máu gây %$heroes.hero_venom.ranged_tentacle.s_bleed_damage%$ sát thương mỗi giây trong %$heroes.hero_venom.ranged_tentacle.bleed_duration[1]%$ giây.",
            HERO_VENOM_RANGED_TENTACLE_DESCRIPTION_2 =
            "Đòn đánh tầm xa dịch chuyển mục tiêu lùi lại, gây %$heroes.hero_venom.ranged_tentacle.s_damage[2]%$ sát thương vật lý và có %$heroes.hero_venom.ranged_tentacle.bleed_chance[2]%$% cơ hội gây chảy máu. Chảy máu gây %$heroes.hero_venom.ranged_tentacle.s_bleed_damage%$ sát thương mỗi giây trong %$heroes.hero_venom.ranged_tentacle.bleed_duration[2]%$ giây.",
            HERO_VENOM_RANGED_TENTACLE_DESCRIPTION_3 =
            "Đòn đánh tầm xa dịch chuyển mục tiêu lùi lại, gây %$heroes.hero_venom.ranged_tentacle.s_damage[3]%$ sát thương vật lý và có %$heroes.hero_venom.ranged_tentacle.bleed_chance[3]%$% cơ hội gây chảy máu. Chảy máu gây %$heroes.hero_venom.ranged_tentacle.s_bleed_damage%$ sát thương mỗi giây trong %$heroes.hero_venom.ranged_tentacle.bleed_duration[3]%$ giây.",

            -- 维斯珀
            HERO_VESPER_ARROW_STORM_DESCRIPTION_1 =
            "Trút %$heroes.hero_vesper.ultimate.s_spread[1]%$ mũi tên xuống một vùng, mỗi mũi gây %$heroes.hero_vesper.ultimate.damage[1]%$ sát thương vật lý. Cứ mỗi 0.5 giây, gọi 4 mũi tên tại vị trí con trỏ, mỗi mũi gây 2.5 sát thương chuẩn.",
            HERO_VESPER_ARROW_STORM_DESCRIPTION_2 =
            "Trút %$heroes.hero_vesper.ultimate.s_spread[2]%$ mũi tên xuống một vùng, mỗi mũi gây %$heroes.hero_vesper.ultimate.damage[2]%$ sát thương vật lý. Cứ mỗi 0.5 giây, gọi 4 mũi tên tại vị trí con trỏ, mỗi mũi gây 5 sát thương chuẩn.",
            HERO_VESPER_ARROW_STORM_DESCRIPTION_3 =
            "Trút %$heroes.hero_vesper.ultimate.s_spread[3]%$ mũi tên xuống một vùng, mỗi mũi gây %$heroes.hero_vesper.ultimate.damage[3]%$ sát thương vật lý. Cứ mỗi 0.5 giây, gọi 4 mũi tên tại vị trí con trỏ, mỗi mũi gây 7.5 sát thương chuẩn.",
            HERO_VESPER_ARROW_TO_THE_KNEE_DESCRIPTION_1 =
            "Bắn mũi tên sắc bén, làm choáng kẻ địch 1 giây và gây %$heroes.hero_vesper.arrow_to_the_knee.s_damage[1]%$ sát thương chuẩn.",
            HERO_VESPER_ARROW_TO_THE_KNEE_DESCRIPTION_2 =
            "Bắn mũi tên sắc bén, làm choáng kẻ địch 2 giây và gây %$heroes.hero_vesper.arrow_to_the_knee.s_damage[2]%$ sát thương chuẩn.",
            HERO_VESPER_ARROW_TO_THE_KNEE_DESCRIPTION_3 =
            "Bắn mũi tên sắc bén, làm choáng kẻ địch 3 giây và gây %$heroes.hero_vesper.arrow_to_the_knee.s_damage[3]%$ sát thương chuẩn.",
            HERO_VESPER_DISENGAGE_DESCRIPTION_1 =
            "Khi bị tấn công, Vesper nhảy lùi né đòn cận chiến tiếp theo, rồi bắn ba mũi tên, mỗi mũi gây %$heroes.hero_vesper.disengage.s_damage[1]%$ sát thương vật lý lên kẻ địch gần đó.",
            HERO_VESPER_DISENGAGE_DESCRIPTION_2 =
            "Khi bị tấn công, Vesper nhảy lùi né đòn cận chiến tiếp theo, rồi bắn ba mũi tên, mỗi mũi gây %$heroes.hero_vesper.disengage.s_damage[2]%$ sát thương vật lý lên kẻ địch gần đó.",
            HERO_VESPER_DISENGAGE_DESCRIPTION_3 =
            "Khi bị tấn công, Vesper nhảy lùi né đòn cận chiến tiếp theo, rồi bắn ba mũi tên, mỗi mũi gây %$heroes.hero_vesper.disengage.s_damage[3]%$ sát thương vật lý lên kẻ địch gần đó.",
            HERO_VESPER_MARTIAL_FLOURISH_DESCRIPTION_1 =
            "Tấn công một kẻ địch ba lần, gây 180 sát thương vật lý.",
            HERO_VESPER_MARTIAL_FLOURISH_DESCRIPTION_2 =
            "Tấn công một kẻ địch ba lần, gây 270 sát thương vật lý.",
            HERO_VESPER_MARTIAL_FLOURISH_DESCRIPTION_3 =
            "Tấn công một kẻ địch ba lần, gây 340 sát thương vật lý.",

            -- 小女巫
            HERO_WITCH_DISENGAGE_DESCRIPTION_1 =
            "Khi máu dưới %$heroes.hero_witch.disengage.hp_to_trigger%$%, Stregi dịch chuyển lùi và để lại mồi nhử có 250 máu. Mồi nhử phát nổ khi bị phá hủy, làm choáng kẻ địch trong %$heroes.hero_witch.disengage.decoy.explotion.stun_duration[1]%$ giây.",
            HERO_WITCH_DISENGAGE_DESCRIPTION_2 =
            "Khi máu dưới %$heroes.hero_witch.disengage.hp_to_trigger%$%, Stregi dịch chuyển lùi và để lại mồi nhử có 350 máu. Mồi nhử phát nổ khi bị phá hủy, làm choáng kẻ địch trong %$heroes.hero_witch.disengage.decoy.explotion.stun_duration[2]%$ giây.",
            HERO_WITCH_DISENGAGE_DESCRIPTION_3 =
            "Khi máu dưới %$heroes.hero_witch.disengage.hp_to_trigger%$%, Stregi dịch chuyển lùi và để lại mồi nhử có 450 máu. Mồi nhử phát nổ khi bị phá hủy, làm choáng kẻ địch trong %$heroes.hero_witch.disengage.decoy.explotion.stun_duration[3]%$ giây.",
            HERO_WITCH_SOLDIERS_DESCRIPTION_1 =
            "Triệu hồi 4 mèo đen chiến đấu, mỗi con có %$heroes.hero_witch.skill_soldiers.soldier.hp_max[1]%$ máu và gây %$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_min[1]%$–%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_max[1]%$ sát thương vật lý mỗi đòn.",
            HERO_WITCH_SOLDIERS_DESCRIPTION_2 =
            "Triệu hồi 6 mèo đen chiến đấu, mỗi con có %$heroes.hero_witch.skill_soldiers.soldier.hp_max[2]%$ máu và gây %$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_min[2]%$–%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_max[2]%$ sát thương vật lý mỗi đòn.",
            HERO_WITCH_SOLDIERS_DESCRIPTION_3 =
            "Triệu hồi 8 mèo đen chiến đấu, mỗi con có %$heroes.hero_witch.skill_soldiers.soldier.hp_max[3]%$ máu và gây %$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_min[3]%$–%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_max[3]%$ sát thương vật lý mỗi đòn.",

            -- 悟空
            HERO_WUKONG_POLE_RANGED_DESCRIPTION_1 =
            "Ném gậy Như Ý lên trời, biến thành 6 cây gậy rơi xuống. Mỗi gậy gây 6–10 sát thương trong vùng nhỏ và làm choáng kẻ địch 3 giây.",
            HERO_WUKONG_POLE_RANGED_DESCRIPTION_2 =
            "Ném gậy Như Ý lên trời, biến thành 10 cây gậy rơi xuống. Mỗi gậy gây 8–15 sát thương trong vùng nhỏ và làm choáng kẻ địch 3 giây.",
            HERO_WUKONG_POLE_RANGED_DESCRIPTION_3 =
            "Ném gậy Như Ý lên trời, biến thành 14 cây gậy rơi xuống. Mỗi gậy gây 11–20 sát thương trong vùng nhỏ và làm choáng kẻ địch 3 giây.",
            HERO_WUKONG_ULTIMATE_DESCRIPTION_1 =
            "Bạch Long lao từ trời xuống đất, gây %$heroes.hero_wukong.ultimate.damage_total[1]%$ sát thương chuẩn và để lại vùng làm chậm tồn tại 7 giây.",
            HERO_WUKONG_ULTIMATE_DESCRIPTION_2 =
            "Bạch Long lao từ trời xuống đất, gây %$heroes.hero_wukong.ultimate.damage_total[2]%$ sát thương chuẩn và để lại vùng làm chậm tồn tại 8 giây.",
            HERO_WUKONG_ULTIMATE_DESCRIPTION_3 =
            "Bạch Long lao từ trời xuống đất, gây %$heroes.hero_wukong.ultimate.damage_total[3]%$ sát thương chuẩn và để lại vùng làm chậm tồn tại 10 giây.",
        }
    }
}

function strings_UH:capture_originals()
    if self.original_captured then
        return
    end

    local msgs = i18n.msgs["zh-Hans"]

    if not msgs then
        return
    end

    for i = 2, 5 do
        for k in pairs(self.new_zs[i]) do
            if self.original_zs[k] == nil then
                local original = msgs[k]

                self.original_zs[k] = original == nil and MISSING_VALUE or original
            end
        end
    end

    self.original_captured = true
end

function strings_UH:apply(enabled)
    local msgs = i18n.msgs["zh-Hans"]

    if not msgs then
        return
    end

    self:capture_originals()

    if enabled then
        for i = 2, 5 do
            table.merge(msgs, self.new_zs[i])
        end
    else
        for k, v in pairs(self.original_zs) do
            if v == MISSING_VALUE then
                msgs[k] = nil
            else
                msgs[k] = v
            end
        end
    end

    self.enabled = enabled and true or false
end

function strings_UH:init()
    self:apply(true)
end

return strings_UH

