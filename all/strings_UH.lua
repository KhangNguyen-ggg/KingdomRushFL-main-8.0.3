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
            HERO_ALIEN_ABDUCTION_DESCRIPTION_1 = "召唤鼠标操控的母船， 右键绑架一个生命值 250 或以下的样本。",
            HERO_ALIEN_ABDUCTION_DESCRIPTION_2 = "召唤鼠标操控的母船， 右键绑架两个生命值 600 或以下的样本。",
            HERO_ALIEN_ABDUCTION_DESCRIPTION_3 = "召唤鼠标操控的母船， 右键绑架三个生命值总数为 1000 的样本或任意单个样本。",
            HERO_ALIEN_ENERGYGLAIVE_DESCRIPTION_1 = "够投掷出一把剑刃， 造成 22 点伤害， 并有 70% 几率打击一个额外目标。",
            HERO_ALIEN_ENERGYGLAIVE_DESCRIPTION_2 = "够投掷出一把剑刃， 造成 30 点伤害， 并有 80% 几率打击一个额外目标。",
            HERO_ALIEN_ENERGYGLAIVE_DESCRIPTION_3 = "够投掷出一把剑刃， 造成 35 点伤害， 并有 85% 几率打击一个额外目标。",
            HERO_ALIEN_FINALCOUNTDOWN_DESCRIPTION_1 = "沙塔生命值为 0 时自爆， 造成 150 点范围伤害。",
            HERO_ALIEN_FINALCOUNTDOWN_DESCRIPTION_2 = "沙塔生命值为 0 时自爆， 造成 200 点范围伤害。",
            HERO_ALIEN_FINALCOUNTDOWN_DESCRIPTION_3 = "沙塔生命值为 0 时自爆， 造成 350 点范围伤害。",
            HERO_ALIEN_PURIFICATIONPROTOCOL_DESCRIPTION_1 = "召唤鼠标操控的无人机， 发射过热等离子， 每秒造成 20 点伤害。",
            HERO_ALIEN_PURIFICATIONPROTOCOL_DESCRIPTION_2 = "召唤鼠标操控的无人机， 发射过热等离子， 每秒造成 40 点伤害。",
            HERO_ALIEN_PURIFICATIONPROTOCOL_DESCRIPTION_3 = "召唤鼠标操控的无人机， 发射过热等离子， 每秒造成 45 点伤害。",

            -- 沙王
            HERO_ALRIC_SANDWARRIORS_DESCRIPTION_1 = "召唤一名生命值为 60 的沙漠勇士， 阻截并攻击敌人。",
            HERO_ALRIC_SANDWARRIORS_DESCRIPTION_2 = "召唤两名生命值为 100 的沙漠勇士。",
            HERO_ALRIC_SANDWARRIORS_DESCRIPTION_3 = "召唤三名生命值为 140 的沙漠勇士。",
            HERO_ALRIC_TOUGHNESS_DESCRIPTION_1 = "提升阿尔里奇最大生命值 30 点， 并增强附近亡灵生物。",
            HERO_ALRIC_TOUGHNESS_DESCRIPTION_2 = "额外提升阿尔里奇最大生命值 60 点， 并增强附近亡灵生物。",
            HERO_ALRIC_TOUGHNESS_DESCRIPTION_3 = "额外提升阿尔里奇最大生命值 90 点， 并增强附近亡灵生物。",

            -- 兽王
            HERO_BEASTMASTER_BOARMASTER_DESCRIPTION_1 = "召唤 1 只 生命值为 160 的野猪， 在范围内攻击阻截敌人并造成流血效果。",
            HERO_BEASTMASTER_BOARMASTER_DESCRIPTION_2 = "召唤 2 只 生命值为 160 的野猪， 在范围内攻击阻截敌人并造成流血效果。",
            HERO_BEASTMASTER_BOARMASTER_DESCRIPTION_3 = "召唤 2 只 生命值为 240 的野猪， 在范围内攻击阻截敌人并造成流血效果。",
            HERO_BEASTMASTER_DEEPLASHES_DESCRIPTION_1 = "特殊攻击技能， 造成 30 点伤害以及 12 点额外流血伤害。",
            HERO_BEASTMASTER_DEEPLASHES_DESCRIPTION_2 = "特殊攻击技能， 造成 40 点伤害以及 36 点额外流血伤害。",
            HERO_BEASTMASTER_DEEPLASHES_DESCRIPTION_3 = "特殊攻击技能， 造成 50 点伤害以及 72 点额外流血伤害。",
            HERO_BEASTMASTER_DEEPLASHES_TITLE = "鞭笞",
            HERO_BEASTMASTER_FALCONER_DESCRIPTION_1 = "训练一只猎鹰伙伴， 攻击范围内的敌人， 造成 3 至 9 点伤害与流血效果。",
            HERO_BEASTMASTER_FALCONER_DESCRIPTION_2 = "训练一只猎鹰伙伴， 攻击范围内的敌人， 造成 9 至 27 点伤害与流血效果。",
            HERO_BEASTMASTER_FALCONER_DESCRIPTION_3 = "训练一只猎鹰伙伴， 攻击范围内的敌人， 造成 18 至 54 点伤害与流血效果。",
            HERO_BEASTMASTER_STAMPEDE_DESCRIPTION_1 = "召唤一只狂奔的犀牛， 对敌人造成伤害， 并有 50% 的几率使敌人晕眩。",
            HERO_BEASTMASTER_STAMPEDE_DESCRIPTION_2 = "提升牛群的规模和晕眩几率 75%",
            HERO_BEASTMASTER_STAMPEDE_DESCRIPTION_3 = "再次提升牛群的规模和 100% 晕眩几率",

            -- 螃蟹
            HERO_CRAB_HOOKEDCLAW_DESCRIPTION_1 = "基础攻击伤害提升 15 点。",
            HERO_CRAB_HOOKEDCLAW_DESCRIPTION_2 = "基础攻击伤害额外提升 25 点。",
            HERO_CRAB_HOOKEDCLAW_DESCRIPTION_3 = "基础攻击伤害额外提升 35 点。",
            HERO_CRAB_PINCERATTACK_DESCRIPTION_1 = "发射机械鳌， 将前方敌人钳到一起并造成 15 至 35 点伤害。",
            HERO_CRAB_PINCERATTACK_DESCRIPTION_2 = "发射机械鳌， 将前方敌人钳到一起并造成 25 至 75 点伤害。",
            HERO_CRAB_PINCERATTACK_DESCRIPTION_3 = "发射机械鳌， 将前方敌人钳到一起并造成 50 至 100 点伤害。",
            HERO_CRAB_SHOULDERCANNON_DESCRIPTION_1 = "发射液体炮弹， 攻击 6 次每次造成 25 至 40 点伤害， 并使敌人减速 3 秒。",
            HERO_CRAB_SHOULDERCANNON_DESCRIPTION_2 = "发射液体炮弹， 攻击 9 次每次造成 25 至 40 点伤害， 并使敌人减速 3 秒。",
            HERO_CRAB_SHOULDERCANNON_DESCRIPTION_3 = "发射液体炮弹， 攻击 12 次每次造成 25 至 40 点伤害， 并使敌人减速 3 秒。",

            -- 骨龙
            HERO_DRACOLICH_UNSTABLEDISEASE_DESCRIPTION_1 = "被感染的敌人死亡时自爆， 感染附近敌人， 并造成 20 点伤害。",
            HERO_DRACOLICH_UNSTABLEDISEASE_DESCRIPTION_2 = "被感染的敌人死亡时自爆， 感染附近敌人， 并造成 50 点伤害。",
            HERO_DRACOLICH_UNSTABLEDISEASE_DESCRIPTION_3 = "被感染的敌人死亡时自爆， 感染附近敌人， 并造成 80 点伤害。",

            -- 火龙
            HERO_DRAGON_FEAST_DESCRIPTION_1 = "俯冲并吞噬一个敌人， 造成 80 点伤害， 25% 几率将其吞噬。",
            HERO_DRAGON_FEAST_DESCRIPTION_2 = "俯冲并吞噬一个敌人， 造成 140 点伤害， 60% 几率将其吞噬。",
            HERO_DRAGON_FEAST_DESCRIPTION_3 = "俯冲并吞噬一个敌人， 造成 200 点伤害， 100% 几率将其吞噬。",
            HERO_DRAGON_FIERYMIST_DESCRIPTION_1 = "喷出一团高温烟雾， 减缓敌人 30%， 持续 3 秒， 并使其燃烧。",
            HERO_DRAGON_FIERYMIST_DESCRIPTION_2 = "喷出一团高温烟雾， 减缓敌人 40%， 持续 4 秒， 并使其燃烧。",
            HERO_DRAGON_FIERYMIST_DESCRIPTION_3 = "喷出一团高温烟雾， 减缓敌人 50%， 持续 5 秒， 并使其燃烧。",
            HERO_DRAGON_REIGNOFFIRE_DESCRIPTION_1 = "攻击将用灼炎点燃敌人， 在敌人之间传播并灼烧敌人造成 6 点伤害， 持续 3 秒。",
            HERO_DRAGON_REIGNOFFIRE_DESCRIPTION_2 = "攻击将用灼炎点燃敌人， 在敌人之间传播并灼烧敌人造成 18 点伤害， 持续 3 秒。",
            HERO_DRAGON_REIGNOFFIRE_DESCRIPTION_3 = "攻击将用灼炎点燃敌人， 在敌人之间传播并灼烧敌人造成 30 点伤害， 持续 3 秒。",
            HERO_DRAGON_WILDFIREBARRAGE_DESCRIPTION_1 = "灼烧地面， 以 4 次爆炸融化所有敌人， 每次造成 55 点伤害。",
            HERO_DRAGON_WILDFIREBARRAGE_DESCRIPTION_2 = "灼烧地面， 以 8 次爆炸融化所有敌人， 每次造成 55 点伤害。",
            HERO_DRAGON_WILDFIREBARRAGE_DESCRIPTION_3 = "灼烧地面， 以 12 次爆炸融化所有敌人， 每次造成 55 点伤害。",

            -- 石头人
            HERO_GIANT_BASTION_DESCRIPTION_1 = "在场上时， 格劳尔逐渐获得最大 12 点伤害加成。",
            HERO_GIANT_BASTION_DESCRIPTION_2 = "在场上时， 格劳尔逐渐获得最大 18 点伤害加成。",
            HERO_GIANT_BASTION_DESCRIPTION_3 = "在场上时， 格劳尔逐渐获得最大 24 点伤害加成。",
            HERO_GIANT_BOULDERTHROW_DESCRIPTION_1 = "投掷巨石， 造成 60 至 120 点范围伤害。",
            HERO_GIANT_BOULDERTHROW_DESCRIPTION_2 = "投掷巨石， 造成 120 至 180 点范围伤害。",
            HERO_GIANT_BOULDERTHROW_DESCRIPTION_3 = "投掷巨石， 造成 180 至 300 点范围伤害。",
            HERO_GIANT_HARDROCK_DESCRIPTION_1 = "提升格劳尔最大生命值 100 点。",
            HERO_GIANT_HARDROCK_DESCRIPTION_2 = "提升格劳尔最大生命值 200 点。",
            HERO_GIANT_HARDROCK_DESCRIPTION_3 = "提升格劳尔最大生命值 300 点。",
            HERO_GIANT_MASSIVEDAMAGE_DESCRIPTION_1 = "特殊攻击， 造成 100 点伤害， 如果格劳尔的生命值三倍于目标， 则将其秒杀。",
            HERO_GIANT_MASSIVEDAMAGE_DESCRIPTION_2 = "特殊攻击， 造成 180 点伤害， 如果格劳尔的生命值三倍于目标， 则将其秒杀。",
            HERO_GIANT_MASSIVEDAMAGE_DESCRIPTION_3 = "特殊攻击， 造成 240 点伤害， 如果格劳尔的生命值三倍于目标， 则将其秒杀。",
            HERO_GIANT_STOMP_DESCRIPTION_1 = "践踏地面 6 次， 伤害附近敌人， 并使其减速、晕眩。",
            HERO_GIANT_STOMP_DESCRIPTION_2 = "践踏地面 8 次， 伤害附近敌人， 并使其减速、晕眩。",
            HERO_GIANT_STOMP_DESCRIPTION_3 = "践踏地面 10 次， 伤害附近敌人， 并使其减速、晕眩。",

            -- 米诺陶
            HERO_MINOTAUR_BLOODAXE_DESCRIPTION_1 = "每次攻击有 40% 几率造成 1.25 倍真实伤害。",
            HERO_MINOTAUR_BLOODAXE_DESCRIPTION_2 = "每次攻击有 40% 几率造成 1.5 倍真实伤害。",
            HERO_MINOTAUR_BLOODAXE_DESCRIPTION_3 = "每次攻击有 40% 几率造成双倍真实伤害。",

            -- 幻影
            HERO_MIRAGE_LETHALSTRIKE_DESCRIPTION_1 = "幻影背刺目标， 造成 90 点伤害， 有 40% 几率将其秒杀。",
            HERO_MIRAGE_LETHALSTRIKE_DESCRIPTION_2 = "幻影背刺目标， 造成 180 点伤害， 有 70% 几率将其秒杀。",
            HERO_MIRAGE_LETHALSTRIKE_DESCRIPTION_3 = "幻影背刺目标， 造成 270 点伤害， 有 90% 几率将其秒杀。",
            HERO_MIRAGE_SHADOWDODGE_DESCRIPTION_1 = "赋予幻影 40% 的闪避几率， 并在其所在位置留下幻象。",
            HERO_MIRAGE_SHADOWDODGE_DESCRIPTION_2 = "赋予幻影 60% 的闪避几率， 并在其所在位置留下幻象。",
            HERO_MIRAGE_SHADOWDODGE_DESCRIPTION_3 = "赋予幻影 80% 的闪避几率， 并在其所在位置留下幻象。",
            HERO_MIRAGE_SHADOWDODGE_TITLE = "暗影闪避",
            HERO_MIRAGE_SPEED = "快",
            HERO_MIRAGE_SWIFTNESS_DESCRIPTION_1 = "提升幻影 40% 的移动速度。",
            HERO_MIRAGE_SWIFTNESS_DESCRIPTION_2 = "提升幻影 80% 的移动速度。",
            HERO_MIRAGE_SWIFTNESS_DESCRIPTION_3 = "提升幻影 100% 的移动速度。",

            -- 猴神
            HERO_MONKEY_GOD_MONKEYPALM_DESCRIPTION_1 = "运用古代武艺， 将一个敌人打晕 4 秒， 并使其沉默 5 秒。",
            HERO_MONKEY_GOD_MONKEYPALM_DESCRIPTION_2 = "运用古代武艺， 将一个敌人打晕 6 秒， 并使其沉默 10 秒。",
            HERO_MONKEY_GOD_MONKEYPALM_DESCRIPTION_3 = "运用古代武艺， 将一个敌人打晕 7 秒， 并使其沉默 15 秒。",
            HERO_MONKEY_GOD_DIVINENATURE_DESCRIPTION_1 = "通过传输神圣能量， 塞塔姆获得每秒 3 点的生命值恢复， 并且可以运用神圣能量召唤分身。",
            HERO_MONKEY_GOD_DIVINENATURE_DESCRIPTION_2 = "通过传输神圣能量， 塞塔姆获得每秒 6 点的生命值恢复， 并且可以运用神圣能量召唤分身。",
            HERO_MONKEY_GOD_DIVINENATURE_DESCRIPTION_3 = "通过传输神圣能量， 塞塔姆获得每秒 9 点的生命值恢复， 并且可以运用神圣能量召唤分身。",
            HERO_MONKEY_GOD_SPINNINGPOLE_DESCRIPTION_1 = "旋转挥舞两根狼牙棒，破坏周围敌人的护甲并造成 32 点伤害。",
            HERO_MONKEY_GOD_SPINNINGPOLE_DESCRIPTION_2 = "旋转挥舞两根狼牙棒， 破坏周围敌人的护甲并造成 69 点伤害。",
            HERO_MONKEY_GOD_SPINNINGPOLE_DESCRIPTION_3 = "旋转挥舞两根狼牙棒， 破坏周围敌人的护甲并造成 108 点伤害。",
            HERO_MONKEY_GOD_TETSUBOSTORM_DESCRIPTION_1 = "打出一阵疾风怒涛般迅速又强力的攻击， 破坏一个敌人的护甲并其造成 110 点伤害。",
            HERO_MONKEY_GOD_TETSUBOSTORM_DESCRIPTION_2 = "打出一阵疾风怒涛般迅速又强力的攻击， 破坏一个敌人的护甲并其造成 180 点伤害。",
            HERO_MONKEY_GOD_TETSUBOSTORM_DESCRIPTION_3 = "打出一阵疾风怒涛般迅速又强力的攻击， 破坏一个敌人的护甲并其造成 260 点伤害。",

            -- 库绍
            HERO_MONK_DRAGONSTYLE_DESCRIPTION_1 = "库绍将其内力化为火龙， 对附近敌人造成 50 至 90 点伤害， 并削弱敌人。",
            HERO_MONK_DRAGONSTYLE_DESCRIPTION_2 = "库绍将其内力化为火龙， 对附近敌人造成 80 至 160 点伤害， 并削弱敌人。",
            HERO_MONK_DRAGONSTYLE_DESCRIPTION_3 = "库绍将其内力化为火龙， 对附近敌人造成 120 至 240 点伤害， 并削弱敌人。",
            HERO_MONK_LEOPARDSTYLE_DESCRIPTION_1 = "对多个目标进行 6 次闪电般的快速打击， 每次造成 10 至 30 点伤害， 并点穴削弱敌人。",
            HERO_MONK_LEOPARDSTYLE_DESCRIPTION_2 = "对多个目标进行 9 次闪电般的快速打击， 每次造成 12 至 36 点伤害， 并点穴削弱敌人。",
            HERO_MONK_LEOPARDSTYLE_DESCRIPTION_3 = "对多个目标进行 12 次闪电般的快速打击， 每次造成 14 至 42 点伤害， 并点穴削弱敌人。",
            HERO_MONK_TIGERSTYLE_DESCRIPTION_1 = "库绍将内力集中后， 可发出穿透护甲的攻击， 对一名敌人造成 30 点伤害， 秒杀极度虚弱的敌人。",
            HERO_MONK_TIGERSTYLE_DESCRIPTION_2 = "库绍将内力集中后， 可发出穿透护甲的攻击， 对一名敌人造成 50 点伤害， 秒杀极度虚弱的敌人。",
            HERO_MONK_TIGERSTYLE_DESCRIPTION_3 = "库绍将内力集中后， 可发出穿透护甲的攻击， 对一名敌人造成 70 点伤害， 秒杀极度虚弱的敌人。",

            -- 船长
            HERO_PIRATE_LOOTING_DESCRIPTION_1 = "在黑棘附近被打败的敌人， 会额外掉落 10% 金币， 并使其他攻击诅咒敌人使其额外掉落 1 个金币。",
            HERO_PIRATE_LOOTING_DESCRIPTION_2 = "在黑棘附近被打败的敌人， 会额外掉落 20% 金币， 并使其他攻击诅咒敌人使其额外掉落 1.5 个金币。",
            HERO_PIRATE_LOOTING_DESCRIPTION_3 = "在黑棘附近被打败的敌人， 会额外掉落 30% 金币， 并使其他攻击诅咒敌人使其额外掉落 2 个金币。",
            HERO_PIRATE_SCATTERSHOT_DESCRIPTION_1 = "投掷火药桶， 造成 84 点范围伤害。",
            HERO_PIRATE_SCATTERSHOT_DESCRIPTION_2 = "投掷火药桶， 造成 154 点范围伤害。",
            HERO_PIRATE_SCATTERSHOT_DESCRIPTION_3 = "投掷火药桶， 造成 225 点范围伤害。",

            -- 女祭司
            HERO_PRIEST_CONSECRATE_DESCRIPTION_1 = "加持一座防御塔， 赋予其 15% 的伤害加成， 持续 10 秒。",
            HERO_PRIEST_CONSECRATE_DESCRIPTION_2 = "加持一座防御塔， 赋予其 20% 的伤害加成， 持续 20 秒。",
            HERO_PRIEST_CONSECRATE_DESCRIPTION_3 = "加持一座防御塔， 赋予其 25% 的伤害加成， 持续 30 秒。",

            -- 但丁
            HERO_VAN_HELSING_HOLYGRENADE_DESCRIPTION_1 = "投掷一瓶圣水， 使一名敌人沉默， 无法施法 15 秒。",
            HERO_VAN_HELSING_HOLYGRENADE_DESCRIPTION_2 = "投掷一瓶圣水， 使一名敌人沉默， 无法施法 25 秒。",
            HERO_VAN_HELSING_HOLYGRENADE_DESCRIPTION_3 = "投掷一瓶圣水， 使一名敌人永久沉默。",

            -- 女巫
            HERO_VOODOO_WITCH_BONEDANCE_DESCRIPTION_1 = "将激活的骷髅数增加到 4 个。",
            HERO_VOODOO_WITCH_BONEDANCE_DESCRIPTION_2 = "将激活的骷髅数增加到 5 个。",
            HERO_VOODOO_WITCH_BONEDANCE_DESCRIPTION_3 = "将激活的骷髅数增加到 6 个。",

            -- 大法师
            HERO_WIZARD_ARCANEFOCUS_DESCRIPTION_1 = "提升纽维斯基础攻击伤害 4 点。",
            HERO_WIZARD_ARCANEFOCUS_DESCRIPTION_2 = "额外提升纽维斯基础攻击伤害 6 点。",
            HERO_WIZARD_ARCANEFOCUS_DESCRIPTION_3 = "额外提升纽维斯基础攻击伤害 24 点。",
            HERO_WIZARD_DISINTEGRATE_DESCRIPTION_1 = "分解范围内总生命值不足 40 点的敌人， 并召唤一个龙卷风。",
            HERO_WIZARD_DISINTEGRATE_DESCRIPTION_2 = "分解范围内总生命值不足 50 点的敌人， 并召唤一个龙卷风。",
            HERO_WIZARD_DISINTEGRATE_DESCRIPTION_3 = "分解范围内总生命值不足 75 点的敌人， 并召唤一个龙卷风。",
            HERO_WIZARD_MAGICMISSILE_DESCRIPTION_1 = "发出 6 个自动瞄准的魔法飞弹， 必定命中， 每个飞弹造成 12 点伤害。",
            HERO_WIZARD_MAGICMISSILE_DESCRIPTION_2 = "发出 10 个自动瞄准的魔法飞弹， 必定命中， 每个飞弹造成 18 点伤害。",
            HERO_WIZARD_MAGICMISSILE_DESCRIPTION_3 = "发出 14 个自动瞄准的魔法飞弹， 必定命中， 每个飞弹造成 24 点伤害。",
        },
        [3] = {
            -- 艾莉丹
            HERO_ELVES_ARCHER_PORCUPINE_DESCRIPTION_1 = "对相同目标每连发一箭， 造成1点额外伤害， 最多10箭生效， 相同目标攻击7次后造成真实伤害。",
            HERO_ELVES_ARCHER_PORCUPINE_DESCRIPTION_2 = "对相同目标每连发一箭， 造成1.25点额外伤害， 最多15箭生效， 相同目标攻击11次后造成真实伤害。",
            HERO_ELVES_ARCHER_PORCUPINE_DESCRIPTION_3 = "对相同目标每连发一箭， 造成1.5点额外伤害， 最多25箭生效， 相同目标攻击14次后造成真实伤害。",
            HERO_ELVES_ARCHER_VOLLEY_DESCRIPTION_1 = "瞄准射程内的敌人， 快速连发11箭， 每支箭造成10-14伤害。",
            HERO_ELVES_ARCHER_VOLLEY_DESCRIPTION_2 = "瞄准射程内的敌人， 快速连发15箭， 每支箭造成10-14伤害。",
            HERO_ELVES_ARCHER_VOLLEY_DESCRIPTION_3 = "瞄准射程内的敌人， 快速连发18箭， 每支箭造成10-14伤害。",

            -- 狮王
            HERO_ELVES_BRUCE_KINGS_ROAR_DESCRIPTION_1 =
            "威武咆哮， 使布鲁斯失去100点血量， 然后回复已损失的10%血量， 击晕附近敌人1秒， 布鲁斯每失去400血量降低狮群10秒冷却。",
            HERO_ELVES_BRUCE_KINGS_ROAR_DESCRIPTION_2 =
            "威武咆哮， 使布鲁斯失去150点血量， 然后回复已损失的20%血量， 击晕附近敌人2秒， 布鲁斯每失去350血量降低狮群10秒冷却。",
            HERO_ELVES_BRUCE_KINGS_ROAR_DESCRIPTION_3 = "使布鲁斯失去200点血量， 然后回复已损失的30%血量， 击晕附近敌人2秒， 布鲁斯每失去250血量降低狮群10秒冷却。",
            HERO_ELVES_BRUCE_LIONS_FUR_DESCRIPTION_1 = "布鲁斯的生命值提高30点， 增加每秒6点回血。",
            HERO_ELVES_BRUCE_LIONS_FUR_DESCRIPTION_2 = "布鲁斯的生命值提高60点， 增加每秒15点回血。",
            HERO_ELVES_BRUCE_LIONS_FUR_DESCRIPTION_3 = "布鲁斯的生命值提高90点， 增加每秒30点回血。",
            HERO_ELVES_BRUCE_SHARP_CLAWS_DESCRIPTION_1 = "攻击概率造成流血效果， 布鲁斯血量低于50%时必定造成流血， 如果目标正在流血， 可造成15点额外伤害， 并吸取25点血量。",
            HERO_ELVES_BRUCE_SHARP_CLAWS_DESCRIPTION_2 = "攻击概率造成流血效果， 布鲁斯血量低于50%时必定造成流血， 如果目标正在流血， 可造成30点额外伤害， 并吸取25点血量。",
            HERO_ELVES_BRUCE_SHARP_CLAWS_DESCRIPTION_3 = "攻击概率造成流血效果， 布鲁斯血量低于50%时必定造成流血， 如果目标正在流血， 可造成45点额外伤害， 并吸取25点血量。",

            -- 迪纳斯王子

            -- 水晶人
            HERO_ELVES_DURAX_CRYSTAL_PRISON_DESCRIPTION_1 = "在一大片区域召唤尖刺， 对区域内的敌人共计造成1000点伤害。",
            HERO_ELVES_DURAX_CRYSTAL_PRISON_DESCRIPTION_2 = "在一大片区域召唤尖刺， 对区域内的敌人共计造成1200点伤害。",
            HERO_ELVES_DURAX_CRYSTAL_PRISON_DESCRIPTION_3 = "在一大片区域召唤尖刺， 对区域内的敌人共计造成1400点伤害。",

            -- 雷格森
            HERO_ELVES_ELDRITCH_BLADE_DESCRIPTION_1 = "燃起异能之焰， 每次攻击造成30点伤害， 并有几率一击必杀， 持续10秒。",
            HERO_ELVES_ELDRITCH_BLADE_DESCRIPTION_2 = "燃起异能之焰， 每次攻击造成50点伤害， 并有几率一击必杀， 持续10秒。",
            HERO_ELVES_ELDRITCH_BLADE_DESCRIPTION_3 = "燃起异能之焰， 每次攻击造成70点伤害， 并有几率一击必杀， 持续10秒。",
            HERO_ELVES_ELDRITCH_SLASH_DESCRIPTION_1 = "发动秘技， 对最多3个敌人展开3次攻击， 造成20-60点伤害， 如果燃起异能之焰造成真实伤害， 并且伤害不再波动。",
            HERO_ELVES_ELDRITCH_SLASH_DESCRIPTION_2 = "发动秘技， 对最多3个敌人展开3次攻击， 造成45-130点伤害， 如果燃起异能之焰造成真实伤害， 并且伤害不再波动。",
            HERO_ELVES_ELDRITCH_SLASH_DESCRIPTION_3 = "发动秘技， 对最多3个敌人展开3次攻击， 造成75-225点伤害， 如果燃起异能之焰造成真实伤害， 并且伤害不再波动。",

            -- 埃里汎
            HERO_ELVES_ELEMENTALIST_ELEMENTAL_STORM_DESCRIPTION_1 = "召唤一场元素龙卷风， 减速敌人并释放闪电， 在8秒内造成210点范围伤害。",
            HERO_ELVES_ELEMENTALIST_ELEMENTAL_STORM_DESCRIPTION_2 = "龙卷风获得强化闪电， 能冻结敌人， 且范围伤害提高到10秒内320点。",
            HERO_ELVES_ELEMENTALIST_ELEMENTAL_STORM_DESCRIPTION_3 = "所有龙卷风效果得到强化， 范围伤害提高到12秒内500点。",
            HERO_ELVES_ELEMENTALIST_ICY_PRISON_DESCRIPTION_1 = "原地冻结一个敌人4秒， 造成35点冰霜伤害。",
            HERO_ELVES_ELEMENTALIST_ICY_PRISON_DESCRIPTION_2 = "原地冻结一个敌人6秒， 造成50点冰霜伤害。",
            HERO_ELVES_ELEMENTALIST_ICY_PRISON_DESCRIPTION_3 = "原地冻结一个敌人8秒， 造成65点冰霜伤害。",
            HERO_ELVES_ELEMENTALIST_LIGHTNING_ROD_DESCRIPTION_1 = "施放一道高能闪电箭， 造成60-100点真实伤害。",
            HERO_ELVES_ELEMENTALIST_LIGHTNING_ROD_DESCRIPTION_2 = "施放一道高能闪电箭， 造成140-220点真实伤害。",
            HERO_ELVES_ELEMENTALIST_LIGHTNING_ROD_DESCRIPTION_3 = "施放一道高能闪电箭， 造成240-400点真实伤害。",
            HERO_ELVES_ELEMENTALIST_SEAL_OF_FIRE_DESCRIPTION_1 = "发射2个火球， 每个造成20-40点范围伤害与7秒燃烧效果。",
            HERO_ELVES_ELEMENTALIST_SEAL_OF_FIRE_DESCRIPTION_2 = "发射4个火球， 每个造成20-40点范围伤害与7秒燃烧效果。",
            HERO_ELVES_ELEMENTALIST_SEAL_OF_FIRE_DESCRIPTION_3 = "发射6个火球， 每个造成20-40点范围伤害与7秒燃烧效果。",
            HERO_ELVES_ELEMENTALIST_STONE_DANCE_DESCRIPTION_1 = "召唤1面石盾， 每面石盾为埃里汎抵挡共计35点伤害， 并对接触的敌人造成7点伤害， 最多召唤2面石盾。",
            HERO_ELVES_ELEMENTALIST_STONE_DANCE_DESCRIPTION_2 = "召唤1面石盾， 每面石盾为埃里汎抵挡共计35点伤害， 并对接触的敌人造成8点伤害， 最多召唤4面石盾。",
            HERO_ELVES_ELEMENTALIST_STONE_DANCE_DESCRIPTION_3 = "召唤1面石盾， 每面石盾为埃里汎抵挡共计35点伤害， 并对接触的敌人造成9点伤害， 最多召唤5面石盾。",

            -- 堕天使
            HERO_ELVES_FALLEN_ANGEL_SOUL_EATER_DESCRIPTION_1 = "吸收死去的最高伤害的敌人的灵魂， 获得额外伤害加成， 持续12秒。",
            HERO_ELVES_FALLEN_ANGEL_SOUL_EATER_DESCRIPTION_2 = "吸收死去的最高伤害的敌人的灵魂， 获得额外伤害加成， 持续12秒。",
            HERO_ELVES_FALLEN_ANGEL_SOUL_EATER_DESCRIPTION_3 = "吸收死去的最高伤害的敌人的灵魂， 获得额外伤害加成， 持续12秒。",

            -- 浮士德
            HERO_ELVES_FAUSTUS_ENERVATION_DESCRIPTION_1 = "一种奥术封印， 使1个敌人的魔法能力无效化， 同时施加龙焰效果， 持续6秒。",
            HERO_ELVES_FAUSTUS_ENERVATION_DESCRIPTION_2 = "一种奥术封印， 使2个敌人的魔法能力无效化， 同时施加龙焰效果， 持续8秒。",
            HERO_ELVES_FAUSTUS_ENERVATION_DESCRIPTION_3 = "一种奥术封印， 使3个敌人的魔法能力无效化， 同时施加龙焰效果， 持续12秒。",
            HERO_ELVES_FAUSTUS_TELEPORT_RUNE_DESCRIPTION_1 = "浮士德唤醒力量符文， 将最多2个敌人原路传送回， 并施加奥术封印。",
            HERO_ELVES_FAUSTUS_TELEPORT_RUNE_DESCRIPTION_2 = "浮士德唤醒力量符文， 将最多4个敌人原路传送回， 并施加奥术封印。",
            HERO_ELVES_FAUSTUS_TELEPORT_RUNE_DESCRIPTION_3 = "浮士德唤醒力量符文， 将最多6个敌人原路传送回， 并施加奥术封印。",

            -- 树人
            HERO_ELVES_FOREST_ELEMENTAL_BRANCHBALL_DESCRIPTION_1 = "抓起一个生命值300以上的敌人， 将其扔出关卡。本垒打！",
            HERO_ELVES_FOREST_ELEMENTAL_BRANCHBALL_DESCRIPTION_2 = "抓起一个生命值350以上的敌人， 将其扔出关卡。本垒打！",
            HERO_ELVES_FOREST_ELEMENTAL_BRANCHBALL_DESCRIPTION_3 = "抓起一个生命值400以上的敌人， 将其扔出关卡。本垒打！",
            HERO_ELVES_FOREST_ELEMENTAL_NATURESWRAITH_DESCRIPTION_1 = "用9根尖刺藤蔓密集覆盖大片区域， 每根尖刺造成40点范围伤害, 并召唤一只树人。",
            HERO_ELVES_FOREST_ELEMENTAL_NATURESWRAITH_DESCRIPTION_2 = "用12根尖刺藤蔓密集覆盖大片区域， 每根尖刺造成50点范围伤害, 并召唤一只树人。",
            HERO_ELVES_FOREST_ELEMENTAL_NATURESWRAITH_DESCRIPTION_3 = "用15根尖刺藤蔓密集覆盖大片区域， 每根尖刺造成60点范围伤害, 并召唤一只树人。",
            HERO_ELVES_FOREST_ELEMENTAL_OAKSEEDS_DESCRIPTION_1 = "召唤2只小树人， 阻截并攻击敌人， 树人死亡掉落1个金币。",
            HERO_ELVES_FOREST_ELEMENTAL_OAKSEEDS_DESCRIPTION_2 = "召唤2只具有强化生命值的小树人， 阻截并攻击敌人， 树人死亡掉落1个金币。",
            HERO_ELVES_FOREST_ELEMENTAL_OAKSEEDS_DESCRIPTION_3 = "召唤2只具有最高生命值的小树人， 阻截并攻击敌人， 树人死亡掉落1个金币。",
            HERO_ELVES_FOREST_ELEMENTAL_ROOTSPIKES_DESCRIPTION_1 = "地面迅速长出尖刺盘根， 造成70-90点范围伤害。",
            HERO_ELVES_FOREST_ELEMENTAL_ROOTSPIKES_DESCRIPTION_2 = "地面迅速长出尖刺盘根， 造成100-150点范围伤害。",
            HERO_ELVES_FOREST_ELEMENTAL_ROOTSPIKES_DESCRIPTION_3 = "地面迅速长出尖刺盘根， 造成200-300点范围伤害。",
            HERO_ELVES_FOREST_ELEMENTAL_SPRINGSAP_DESCRIPTION_1 = "无畏树人被包裹于魔茧之中， 在2秒内为自身和友军治疗60点生命值。",
            HERO_ELVES_FOREST_ELEMENTAL_SPRINGSAP_DESCRIPTION_2 = "无畏树人被包裹于魔茧之中， 在3秒内为自身和友军治疗180点生命值。",
            HERO_ELVES_FOREST_ELEMENTAL_SPRINGSAP_DESCRIPTION_3 = "无畏树人被包裹于魔茧之中， 在4秒内为自身和友军治疗360点生命值。",

            -- 威尔伯

            -- 莉恩
            HERO_ELVES_LYNN_WEAKENING_DESCRIPTION_1 = "降低目标的魔法抗性和护甲60点， 持续4秒。",
            HERO_ELVES_LYNN_WEAKENING_DESCRIPTION_2 = "降低目标的魔法抗性和护甲80点， 持续6秒。",
            HERO_ELVES_LYNN_WEAKENING_DESCRIPTION_3 = "完全破坏目标的魔法抗性和护甲， 持续8秒。",

            -- 熊猫
            HERO_ELVES_PANDA_INSPIRE_DESCRIPTION_1 = "鑫发出愤怒咆哮， 激励附近友军造成双倍伤害， 持续7秒。",
            HERO_ELVES_PANDA_INSPIRE_DESCRIPTION_2 = "鑫发出愤怒咆哮， 激励附近友军造成双倍伤害， 持续10秒。",
            HERO_ELVES_PANDA_INSPIRE_DESCRIPTION_3 = "鑫发出愤怒咆哮， 激励附近友军造成双倍伤害， 持续13秒。",
            HERO_ELVES_PANDA_KINDRED_SPIRITS_DESCRIPTION_1 = "一种古老的秘宗拳术， 能对所有附近敌人造成80-120点范围伤害。",
            HERO_ELVES_PANDA_KINDRED_SPIRITS_DESCRIPTION_2 = "一种古老的秘宗拳术， 能对所有附近敌人造成120-200点范围伤害。",
            HERO_ELVES_PANDA_KINDRED_SPIRITS_DESCRIPTION_3 = "一种古老的秘宗拳术， 能对所有附近敌人造成230-300点范围伤害。",
            HERO_ELVES_PANDA_MIND_OVER_BODY_DESCRIPTION_1 = "鑫喝下自制秘饮， 在8秒内治疗自身120点生命值。",
            HERO_ELVES_PANDA_MIND_OVER_BODY_DESCRIPTION_2 = "鑫喝下自制秘饮， 在12秒内治疗自身260点生命值。",
            HERO_ELVES_PANDA_MIND_OVER_BODY_DESCRIPTION_3 = "鑫喝下自制秘饮， 在18秒内治疗自身400点生命值。",

            -- 凤凰
            HERO_ELVES_PHOENIX_INMOLATE_DESCRIPTION_1 = "朝地面俯冲， 造成100点范围伤害， 并在此过程中死亡， 使凤凰每秒损失10点血量。",
            HERO_ELVES_PHOENIX_INMOLATE_DESCRIPTION_2 = "朝地面俯冲， 造成200点范围伤害， 并在此过程中死亡， 使凤凰每秒损失15点血量。",
            HERO_ELVES_PHOENIX_INMOLATE_DESCRIPTION_3 = "朝地面俯冲， 造成300点范围伤害， 并在此过程中死亡， 使凤凰每秒损失30点血量。",

            -- 仙子
            HERO_ELVES_PIXIE_CURSE_DESCRIPTION_1 = "每次小仙子攻击都有30%几率诅咒敌人， 将其击晕0.5秒。",
            HERO_ELVES_PIXIE_CURSE_DESCRIPTION_2 = "每次小仙子攻击都有40%几率诅咒敌人， 将其击晕1秒。",
            HERO_ELVES_PIXIE_CURSE_DESCRIPTION_3 = "每次小仙子攻击都有60%几率诅咒敌人， 将其击晕1.5秒。",
            HERO_ELVES_PIXIE_FURY_DESCRIPTION_1 = "派出2个小仙子打击附近敌人， 每个造成18-56点魔法伤害。",
            HERO_ELVES_PIXIE_FURY_DESCRIPTION_2 = "派出3个小仙子打击附近敌人， 每个造成22-76点魔法伤害。",
            HERO_ELVES_PIXIE_FURY_DESCRIPTION_3 = "派出4个小仙子打击附近敌人， 每个造成34-96点魔法伤害。",

            -- 大瑞格
            HERO_ELVES_RAG_ONE_GNOME_ARMY_DESCRIPTION_1 = "将最多4个敌人转变成友方瑞格布偶参战， 持续15秒。",
            HERO_ELVES_RAG_ONE_GNOME_ARMY_DESCRIPTION_2 = "将最多6个敌人转变成友方瑞格布偶参战， 持续15秒。",
            HERO_ELVES_RAG_ONE_GNOME_ARMY_DESCRIPTION_3 = "将最多8个敌人转变成友方瑞格布偶参战， 持续15秒。",
            HERO_ELVES_RAG_RAGGIFIED_DESCRIPTION_1 = "将一个最高200点生命值的最高血量的敌人转变成友方瑞格布偶参战， 持续3秒。",
            HERO_ELVES_RAG_RAGGIFIED_DESCRIPTION_2 = "将一个最高600点生命值的最高血量的敌人转变成友方瑞格布偶参战， 持续5秒。",
            HERO_ELVES_RAG_RAGGIFIED_DESCRIPTION_3 = "将任意一个最高血量的敌人转变成友方瑞格布偶参战， 持续7秒。",

            -- 维兹南
            HERO_ELVES_VEZNAN_ARCANENOVA_DESCRIPTION_1 = "制造一场巨大的魔法爆炸， 造成28-52点范围伤害， 并使敌人减速， 持续4秒。",
            HERO_ELVES_VEZNAN_ARCANENOVA_DESCRIPTION_2 = "制造一场巨大的魔法爆炸， 造成46-86点范围伤害， 并使敌人减速， 持续4秒。",
            HERO_ELVES_VEZNAN_ARCANENOVA_DESCRIPTION_3 = "制造一场巨大的魔法爆炸， 造成64-120点范围伤害， 并使敌人减速， 持续4秒。",
            HERO_ELVES_VEZNAN_SHACKLES_DESCRIPTION_1 = "用魔法牢笼困住1个敌人， 在3秒内造成108点伤害。",
            HERO_ELVES_VEZNAN_SHACKLES_DESCRIPTION_2 = "用魔法牢笼困住最多3个敌人， 在3秒内对每个敌人造成108点伤害。",
            HERO_ELVES_VEZNAN_SHACKLES_DESCRIPTION_3 = "用魔法牢笼困住最多6个敌人， 在3秒内对每个敌人造成108点伤害。",
            HERO_ELVES_VEZNAN_SOULBURN_DESCRIPTION_1 = "周围敌人血量大于400点时解体生命值共计不超过500的单个或数个敌人。",
            HERO_ELVES_VEZNAN_SOULBURN_DESCRIPTION_2 = "周围敌人血量大于400点时解体生命值共计不超过750的单个或数个敌人。",
            HERO_ELVES_VEZNAN_SOULBURN_DESCRIPTION_3 = "周围敌人血量大于400点时解体生命值共计不超过1000的单个或数个敌人。",
        },
        [4] = {
            HERO_BERESAD_FEAR_DRAGON_DESCRIPTION_1 = "贝雷萨德一声怒吼，受影响的所有敌人均会四散逃命，沿路径倒行3秒。",
            HERO_BERESAD_FEAR_DRAGON_DESCRIPTION_2 = "贝雷萨德一声怒吼，受影响的所有敌人均会四散逃命，沿路径倒行4秒。",
            HERO_BERESAD_FEAR_DRAGON_DESCRIPTION_3 = "贝雷萨德一声怒吼，受影响的所有敌人均会四散逃命，沿路径倒行5秒。",
            HERO_MURGLUN_INFERNAL_HEAT_DESCRIPTION_1 = "每隔22秒，墨尔古伦便会扇动她那燃着火焰的双翼，对一片区域内的所有敌人造成100点真实伤害，并持续减速敌人30%。",
            HERO_MURGLUN_INFERNAL_HEAT_DESCRIPTION_2 = "每隔18秒，墨尔古伦便会扇动她那燃着火焰的双翼，对一片区域内的所有敌人造成100点真实伤害，并持续减速敌人30%。",
            HERO_MURGLUN_INFERNAL_HEAT_DESCRIPTION_3 = "每隔14秒，墨尔古伦便会扇动她那燃着火焰的双翼，对一片区域内的所有敌人造成100点真实伤害，并持续减速敌人30%。",
            HERO_JACK_O_LANTERN_HERO_JACKO_MELEE_DESCRIPTION_1 = "杰克会蓄积每次所受伤害的30%，等到下次攻击时一并释放出来。",
            HERO_JACK_O_LANTERN_HERO_JACKO_MELEE_DESCRIPTION_2 = "杰克会蓄积每次所受伤害的50%，等到下次攻击时一并释放出来。",
            HERO_JACK_O_LANTERN_HERO_JACKO_MELEE_DESCRIPTION_3 = "杰克会蓄积每次所受伤害的75%，等到下次攻击时一并释放出来。",
        },
        [5] = {
            -- 狮鹫
            HERO_BIRD_BIRDS_OF_PREY_DESCRIPTION_1 =
            "召唤狮鹫飞到区域上空攻击敌人，持续17秒，每次攻击造成%$heroes.hero_bird.ultimate.bird.melee_attack.damage_max[1]%$点伤害。",
            HERO_BIRD_BIRDS_OF_PREY_DESCRIPTION_2 =
            "召唤狮鹫飞到区域上空攻击敌人，持续19秒，每次攻击造成%$heroes.hero_bird.ultimate.bird.melee_attack.damage_max[2]%$点伤害。",
            HERO_BIRD_BIRDS_OF_PREY_DESCRIPTION_3 =
            "召唤狮鹫飞到区域上空攻击敌人，持续22秒，每次攻击造成%$heroes.hero_bird.ultimate.bird.melee_attack.damage_max[3]%$点伤害。",
            HERO_BIRD_CLUSTER_BOMB_DESCRIPTION_1 =
            "投掷一枚分裂炸药，对敌人造成%$heroes.hero_bird.cluster_bomb.explosion_damage_min[1]%$点伤害，并使地面燃烧16秒，使敌人在16秒内受到64点燃烧伤害。",
            HERO_BIRD_CLUSTER_BOMB_DESCRIPTION_2 =
            "投掷一枚分裂炸药，对敌人造成%$heroes.hero_bird.cluster_bomb.explosion_damage_min[2]%$点伤害，并使地面燃烧32秒，使敌人在32秒内受到128点燃烧伤害。",
            HERO_BIRD_CLUSTER_BOMB_DESCRIPTION_3 =
            "投掷一枚分裂炸药，对敌人造成%$heroes.hero_bird.cluster_bomb.explosion_damage_min[3]%$点伤害，并使地面燃烧40秒，使敌人在40秒内受到160点燃烧伤害。",
            HERO_BIRD_EAT_INSTAKILL_DESCRIPTION_1 = "狮鹫俯冲地面，吞噬一名生命值不超过%$heroes.hero_bird.eat_instakill.hp_max[1]%$的敌人。",
            HERO_BIRD_EAT_INSTAKILL_DESCRIPTION_2 = "狮鹫俯冲地面，吞噬一名生命值不超过%$heroes.hero_bird.eat_instakill.hp_max[2]%$的敌人。",
            HERO_BIRD_EAT_INSTAKILL_DESCRIPTION_3 = "狮鹫俯冲地面，吞噬一名生命值不超过%$heroes.hero_bird.eat_instakill.hp_max[3]%$的敌人。",
            HERO_BIRD_SHOUT_STUN_DESCRIPTION_1 =
            "狮鹫发出震耳欲聋的叫声，眩晕敌人0.25秒，随后使其减速1.5秒",
            HERO_BIRD_SHOUT_STUN_DESCRIPTION_2 =
            "狮鹫发出震耳欲聋的叫声，眩晕敌人0.5秒，随后使其减速1.5秒",
            HERO_BIRD_SHOUT_STUN_DESCRIPTION_3 =
            "狮鹫发出震耳欲聋的叫声，眩晕敌人0.75秒，随后使其减速1.5秒",

            -- 土木人
            HERO_BUILDER_DEFENSIVE_TURRET_DESCRIPTION_1 =
            "建造一座临时塔楼攻击经过的敌人，持续50秒，每次攻击造成4-6点物理伤害。",
            HERO_BUILDER_DEFENSIVE_TURRET_DESCRIPTION_2 =
            "建造一座临时塔楼攻击经过的敌人，持续75秒，每次攻击造成8-12点物理伤害。",
            HERO_BUILDER_DEFENSIVE_TURRET_DESCRIPTION_3 =
            "建造一座临时塔楼攻击经过的敌人，持续100秒，每次攻击造成12-18点物理伤害。",
            HERO_BUILDER_DEMOLITION_MAN_DESCRIPTION_1 =
            "快速旋转手中的木梁，对周围的敌人造成%$heroes.hero_builder.demolition_man.s_damage_min[1]%$-%$heroes.hero_builder.demolition_man.s_damage_max[1]%$点物理伤害， 并击晕敌人1.5秒。",
            HERO_BUILDER_DEMOLITION_MAN_DESCRIPTION_2 =
            "快速旋转手中的木梁，对周围的敌人造成%$heroes.hero_builder.demolition_man.s_damage_min[2]%$-%$heroes.hero_builder.demolition_man.s_damage_max[2]%$点物理伤害， 并击晕敌人1.5秒。",
            HERO_BUILDER_DEMOLITION_MAN_DESCRIPTION_3 =
            "快速旋转手中的木梁，对周围的敌人造成%$heroes.hero_builder.demolition_man.s_damage_min[3]%$-%$heroes.hero_builder.demolition_man.s_damage_max[3]%$点物理伤害， 并击晕敌人1.5秒。",
            HERO_BUILDER_LUNCH_BREAK_DESCRIPTION_1 =
            "托雷斯停下战斗，享用小吃，为自己恢复25%生命， 周围每有一个塔楼使托雷斯血量增加 15 %。",
            HERO_BUILDER_LUNCH_BREAK_DESCRIPTION_2 =
            "托雷斯停下战斗，享用小吃，为自己恢复30%生命， 周围每有一个塔楼使托雷斯血量增加 15 %。",
            HERO_BUILDER_LUNCH_BREAK_DESCRIPTION_3 =
            "托雷斯停下战斗，享用小吃，为自己恢复40%生命， 周围每有一个塔楼使托雷斯血量增加 15 %。",
            HERO_BUILDER_WRECKING_BALL_DESCRIPTION_1 =
            "朝路径上扔出一个巨大钢球，造成%$heroes.hero_builder.ultimate.damage[1]%$点物理伤害，使敌人眩晕3秒， 并使大范围敌人眩晕2秒。",
            HERO_BUILDER_WRECKING_BALL_DESCRIPTION_2 =
            "朝路径上扔出一个巨大钢球，造成%$heroes.hero_builder.ultimate.damage[2]%$点物理伤害，使敌人眩晕4秒， 并使大范围敌人眩晕2秒。",
            HERO_BUILDER_WRECKING_BALL_DESCRIPTION_3 =
            "朝路径上扔出一个巨大钢球，造成%$heroes.hero_builder.ultimate.damage[3]%$点物理伤害，使敌人眩晕5秒， 并使大范围敌人眩晕2秒。",

            -- 木龙

            -- 骨龙
            HERO_DRAGON_BONE_BURST_DESCRIPTION_1 =
            "发射10颗魔法弹幕, 每颗造成%$heroes.hero_dragon_bone.burst.damage_min[1]%$-%$heroes.hero_dragon_bone.burst.damage_max[1]%$点真实伤害并施加瘟疫效果。",
            HERO_DRAGON_BONE_BURST_DESCRIPTION_2 =
            "发射13颗魔法弹幕, 每颗造成%$heroes.hero_dragon_bone.burst.damage_min[2]%$-%$heroes.hero_dragon_bone.burst.damage_max[2]%$点真实伤害并施加瘟疫效果。",
            HERO_DRAGON_BONE_BURST_DESCRIPTION_3 =
            "发射14颗魔法弹幕, 每颗造成%$heroes.hero_dragon_bone.burst.damage_min[3]%$-%$heroes.hero_dragon_bone.burst.damage_max[3]%$点真实伤害并施加瘟疫效果。",
            HERO_DRAGON_BONE_RAISE_DRAKES_DESCRIPTION_1 =
            "召唤两只小骨龙，每只拥有%$heroes.hero_dragon_bone.ultimate.dog.hp[1]%$点生命值，攻击造成%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_min[2]%$-%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_max[1]%$点物理伤害， 使伯恩哈特获得高级死亡骑士光环， 增强附近亡灵防御塔与亡灵生物。",
            HERO_DRAGON_BONE_RAISE_DRAKES_DESCRIPTION_2 =
            "召唤两只小骨龙，每只拥有%$heroes.hero_dragon_bone.ultimate.dog.hp[2]%$点生命值，攻击造成%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_min[3]%$-%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_max[2]%$点物理伤害， 使伯恩哈特获得高级死亡骑士光环， 增强附近亡灵防御塔与亡灵生物。。",
            HERO_DRAGON_BONE_RAISE_DRAKES_DESCRIPTION_3 =
            "召唤两只小骨龙，每只拥有%$heroes.hero_dragon_bone.ultimate.dog.hp[3]%$点生命值，攻击造成%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_min[4]%$-%$heroes.hero_dragon_bone.ultimate.dog.melee_attack.damage_max[3]%$点物理伤害， 使伯恩哈特获得高级死亡骑士光环， 增强附近亡灵防御塔与亡灵生物。。",

            -- 晶龙
            HERO_DRAGON_GEM_CRYSTAL_TOTEM_DESCRIPTION_1 =
            "朝路上投掷一颗水晶，使敌人减速%$heroes.hero_dragon_gem.crystal_totem.s_slow_factor%$%，并且在周围每1秒造成6-8点魔法伤害。持续%$heroes.hero_dragon_gem.crystal_totem.duration[1]%$秒。",
            HERO_DRAGON_GEM_CRYSTAL_TOTEM_DESCRIPTION_2 =
            "朝路上投掷一颗水晶，使敌人减速%$heroes.hero_dragon_gem.crystal_totem.s_slow_factor%$%，并且在周围每1秒造成8-10点魔法伤害。持续%$heroes.hero_dragon_gem.crystal_totem.duration[2]%$秒。",
            HERO_DRAGON_GEM_CRYSTAL_TOTEM_DESCRIPTION_3 =
            "朝路上投掷一颗水晶，使敌人减速%$heroes.hero_dragon_gem.crystal_totem.s_slow_factor%$%，并且在周围每1秒造成10-12点魔法伤害。持续%$heroes.hero_dragon_gem.crystal_totem.duration[3]%$秒。",
            HERO_DRAGON_GEM_FALLING_CRYSTALS_DESCRIPTION_1 =
            "召唤7根水晶锥，对范围内的敌人造成%$heroes.hero_dragon_gem.ultimate.damage_min[1]%$-%$heroes.hero_dragon_gem.ultimate.damage_max[1]%$点真实伤害。",
            HERO_DRAGON_GEM_FALLING_CRYSTALS_DESCRIPTION_2 =
            "召唤9根水晶锥，对范围内的敌人造成%$heroes.hero_dragon_gem.ultimate.damage_min[2]%$-%$heroes.hero_dragon_gem.ultimate.damage_max[2]%$点真实伤害。",
            HERO_DRAGON_GEM_FALLING_CRYSTALS_DESCRIPTION_3 =
            "召唤11根水晶锥，对范围内的敌人造成%$heroes.hero_dragon_gem.ultimate.damage_min[3]%$-%$heroes.hero_dragon_gem.ultimate.damage_max[3]%$点真实伤害。",

            -- 安雅
            HERO_HUNTER_BEASTS_DESCRIPTION_1 =
            "召唤2只蝙蝠攻击附近的敌人，持续8秒，造成3-6点物理伤害， 每只蝙蝠有一定几率从目标处偷取1金币。",
            HERO_HUNTER_BEASTS_DESCRIPTION_2 =
            "召唤2只蝙蝠攻击附近的敌人，持续13秒，造成4-8点物理伤害， 每只蝙蝠有一定几率从目标处偷取2金币。",
            HERO_HUNTER_BEASTS_DESCRIPTION_3 =
            "召唤2只蝙蝠攻击附近的敌人，持续18秒，造成7-12点物理伤害， 每只蝙蝠有一定几率从目标处偷取2金币。",
            HERO_HUNTER_RICOCHET_DESCRIPTION_1 =
            "安雅变作迷雾，在3个敌人之间跳跃，对每个敌人造成55-75点物理伤害， 每次跳跃后召唤一只蝙蝠。",
            HERO_HUNTER_RICOCHET_DESCRIPTION_2 =
            "安雅变作迷雾，在4个敌人之间跳跃，对每个敌人造成75-100点物理伤害， 每次跳跃后召唤一只蝙蝠。",
            HERO_HUNTER_RICOCHET_DESCRIPTION_3 =
            "安雅变作迷雾，在4个敌人之间跳跃，对每个敌人造成105-130点物理伤害， 每次跳跃后召唤一只蝙蝠。",
            HERO_HUNTER_SHOOT_AROUND_DESCRIPTION_1 =
            "对周围所有敌人射击，每0.07秒对每个敌人造成%$heroes.hero_hunter.shoot_around.s_damage_min[1]%$-%$heroes.hero_hunter.shoot_around.s_damage_max[1]%$的真实伤害。",
            HERO_HUNTER_SHOOT_AROUND_DESCRIPTION_2 =
            "对周围所有敌人射击，每0.07秒对每个敌人造成%$heroes.hero_hunter.shoot_around.s_damage_min[2]%$-%$heroes.hero_hunter.shoot_around.s_damage_max[2]%$的真实伤害。",
            HERO_HUNTER_SHOOT_AROUND_DESCRIPTION_3 =
            "对周围所有敌人射击，每0.07秒对每个敌人造成%$heroes.hero_hunter.shoot_around.s_damage_min[3]%$-%$heroes.hero_hunter.shoot_around.s_damage_max[3]%$的真实伤害。",
            
            -- 岩浆怪
            
            -- 光龙
            HERO_LUMENIR_CELESTIAL_JUDGEMENT_DESCRIPTION_1 =
            "向附近最强的敌人施放圣光之剑，造成%$heroes.hero_lumenir.celestial_judgement.damage[1]%$点真实伤害，并使其眩晕%$heroes.hero_lumenir.celestial_judgement.stun_duration[1]%$秒， 同时对附近敌人造成150点伤害。",
            HERO_LUMENIR_CELESTIAL_JUDGEMENT_DESCRIPTION_2 =
            "向附近最强的敌人施放圣光之剑，造成%$heroes.hero_lumenir.celestial_judgement.damage[2]%$点真实伤害，并使其眩晕%$heroes.hero_lumenir.celestial_judgement.stun_duration[2]%$秒， 同时对附近敌人造成150点伤害。",
            HERO_LUMENIR_CELESTIAL_JUDGEMENT_DESCRIPTION_3 =
            "向附近最强的敌人施放圣光之剑，造成%$heroes.hero_lumenir.celestial_judgement.damage[3]%$点真实伤害，并使其眩晕%$heroes.hero_lumenir.celestial_judgement.stun_duration[3]%$秒， 同时对附近敌人造成150点伤害。",
            HERO_LUMENIR_FIRE_BALLS_DESCRIPTION_1 =
            "吐息5个神圣光球，在路径上移动并对敌人造成伤害。每个光球对每名经过的敌人造成%$heroes.hero_lumenir.fire_balls.flame_damage_min[1]%$-%$heroes.hero_lumenir.fire_balls.flame_damage_max[1]%$点真实伤害。",
            HERO_LUMENIR_FIRE_BALLS_DESCRIPTION_2 =
            "吐息6个神圣光球，在路径上移动并对敌人造成伤害。每个光球对每名经过的敌人造成%$heroes.hero_lumenir.fire_balls.flame_damage_min[2]%$-%$heroes.hero_lumenir.fire_balls.flame_damage_max[2]%$点真实伤害。",
            HERO_LUMENIR_FIRE_BALLS_DESCRIPTION_3 =
            "吐息8个神圣光球，在路径上移动并对敌人造成伤害。每个光球对每名经过的敌人造成%$heroes.hero_lumenir.fire_balls.flame_damage_min[3]%$-%$heroes.hero_lumenir.fire_balls.flame_damage_max[3]%$点真实伤害。",
            
            -- 哥布林机甲
            HERO_MECHA_DEATH_FROM_ABOVE_DESCRIPTION_1 =
            "呼叫一架哥布林飞艇，对水平线的敌人进行轰炸，每次攻击造成%$heroes.hero_mecha.ultimate.ranged_attack.damage_min[1]%$-%$heroes.hero_mecha.ultimate.ranged_attack.damage_max[1]%$点真实范围伤害。",
            HERO_MECHA_DEATH_FROM_ABOVE_DESCRIPTION_2 =
            "呼叫一架哥布林飞艇，对水平线的敌人进行轰炸，每次攻击造成%$heroes.hero_mecha.ultimate.ranged_attack.damage_min[2]%$-%$heroes.hero_mecha.ultimate.ranged_attack.damage_max[2]%$点真实范围伤害。",
            HERO_MECHA_DEATH_FROM_ABOVE_DESCRIPTION_3 =
            "呼叫一架哥布林飞艇，对水平线的敌人进行轰炸，每次攻击造成%$heroes.hero_mecha.ultimate.ranged_attack.damage_min[3]%$-%$heroes.hero_mecha.ultimate.ranged_attack.damage_max[3]%$点真实范围伤害。",
            HERO_MECHA_GOBLIDRONES_DESCRIPTION_1 =
            "召唤%$heroes.hero_mecha.goblidrones.units%$架无人机攻击敌人，持续12秒，每次攻击造成%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_min[1]%$-%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_max[1]%$点物理伤害。",
            HERO_MECHA_GOBLIDRONES_DESCRIPTION_2 =
            "召唤%$heroes.hero_mecha.goblidrones.units%$架无人机攻击敌人，持续18秒，每次攻击造成%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_min[2]%$-%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_max[2]%$点物理伤害。",
            HERO_MECHA_GOBLIDRONES_DESCRIPTION_3 =
            "召唤%$heroes.hero_mecha.goblidrones.units%$架无人机攻击敌人，持续23秒，每次攻击造成%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_min[3]%$-%$heroes.hero_mecha.goblidrones.drone.ranged_attack.damage_max[3]%$点物理伤害。",
            HERO_MECHA_MINE_DROP_DESCRIPTION_1 =
            "静止时，机甲会定期在路径上安放至多4枚爆炸地雷。每枚地雷的爆炸会造成%$heroes.hero_mecha.mine_drop.damage_min[1]%$-%$heroes.hero_mecha.mine_drop.damage_max[1]%$点爆炸伤害。",
            HERO_MECHA_MINE_DROP_DESCRIPTION_2 =
            "静止时，机甲会定期在路径上安放至多5枚爆炸地雷。每枚地雷的爆炸会造成%$heroes.hero_mecha.mine_drop.damage_min[2]%$-%$heroes.hero_mecha.mine_drop.damage_max[2]%$点爆炸伤害。",
            HERO_MECHA_MINE_DROP_DESCRIPTION_3 =
            "静止时，机甲会定期在路径上安放至多7枚爆炸地雷。每枚地雷的爆炸会造成%$heroes.hero_mecha.mine_drop.damage_min[3]%$-%$heroes.hero_mecha.mine_drop.damage_max[3]%$点爆炸伤害。",
            
            -- 尼鲁
            HERO_MUYRN_ROOT_DEFENDER_DESCRIPTION_1 =
            "在一定范围内生成树根，持续%$heroes.hero_muyrn.ultimate.duration[1]%$秒，减速敌人，且每秒造成24-40点真实伤害。",
            HERO_MUYRN_ROOT_DEFENDER_DESCRIPTION_2 =
            "在一定范围内生成树根，持续%$heroes.hero_muyrn.ultimate.duration[2]%$秒，减速敌人，且每秒造成28-44点真实伤害。",
            HERO_MUYRN_ROOT_DEFENDER_DESCRIPTION_3 =
            "在一定范围内生成树根，持续%$heroes.hero_muyrn.ultimate.duration[3]%$秒，减速敌人，且每秒造成32-48点真实伤害。",
            HERO_MUYRN_SENTINEL_WISPS_DESCRIPTION_1 =
            "召唤%$heroes.hero_muyrn.sentinel_wisps.max_summons[1]%$只友善的仙灵跟随尼鲁8秒。仙灵会造成%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_min[1]%$-%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_max[1]%$点魔法伤害。",
            HERO_MUYRN_SENTINEL_WISPS_DESCRIPTION_2 =
            "召唤%$heroes.hero_muyrn.sentinel_wisps.max_summons[2]%$只友善的仙灵跟随尼鲁11秒。仙灵会造成%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_min[2]%$-%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_max[2]%$点魔法伤害。",
            HERO_MUYRN_SENTINEL_WISPS_DESCRIPTION_3 =
            "召唤%$heroes.hero_muyrn.sentinel_wisps.max_summons[3]%$只友善的仙灵跟随尼鲁14秒。仙灵会造成%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_min[3]%$-%$heroes.hero_muyrn.sentinel_wisps.wisp.damage_max[3]%$点魔法伤害。",
            HERO_MUYRN_VERDANT_BLAST_DESCRIPTION_1 =
            "向敌人发射一束绿色能量，造成%$heroes.hero_muyrn.verdant_blast.s_damage[1]%$点魔法伤害， 每275秒增加1点生命。",
            HERO_MUYRN_VERDANT_BLAST_DESCRIPTION_2 =
            "向敌人发射一束绿色能量，造成%$heroes.hero_muyrn.verdant_blast.s_damage[2]%$点魔法伤害， 每245秒增加1点生命。",
            HERO_MUYRN_VERDANT_BLAST_DESCRIPTION_3 =
            "向敌人发射一束绿色能量，造成%$heroes.hero_muyrn.verdant_blast.s_damage[3]%$点魔法伤害， 每210秒增加1点生命。",
            
            -- 黑暗中尉
            HERO_RAELYN_INSPIRE_FEAR_DESCRIPTION_1 =
            "使附近敌人眩晕%$heroes.hero_raelyn.inspire_fear.stun_duration[1]%$秒，并降低其攻击伤害6秒。",
            HERO_RAELYN_INSPIRE_FEAR_DESCRIPTION_2 =
            "使附近敌人眩晕%$heroes.hero_raelyn.inspire_fear.stun_duration[2]%$秒，并降低其攻击伤害7秒。",
            HERO_RAELYN_INSPIRE_FEAR_DESCRIPTION_3 =
            "使附近敌人眩晕%$heroes.hero_raelyn.inspire_fear.stun_duration[3]%$秒，并降低其攻击伤害9秒。",
            HERO_RAELYN_UNBREAKABLE_DESCRIPTION_1 =
            "蕾琳会在战斗中根据附近敌人的数量生成生命护盾（每有一名敌人，将生成她总生命值%$heroes.hero_raelyn.unbreakable.shield_per_enemy[1]%$%的护盾，上限%$heroes.hero_raelyn.unbreakable.max_targets%$名敌人）， 持续6秒",
            HERO_RAELYN_UNBREAKABLE_DESCRIPTION_2 =
            "蕾琳会在战斗中根据附近敌人的数量生成生命护盾（每有一名敌人，将生成她总生命值%$heroes.hero_raelyn.unbreakable.shield_per_enemy[2]%$%的护盾，上限%$heroes.hero_raelyn.unbreakable.max_targets%$名敌人）， 持续8秒",
            HERO_RAELYN_UNBREAKABLE_DESCRIPTION_3 =
            "蕾琳会在战斗中根据附近敌人的数量生成生命护盾（每有一名敌人，将生成她总生命值%$heroes.hero_raelyn.unbreakable.shield_per_enemy[3]%$%的护盾，上限%$heroes.hero_raelyn.unbreakable.max_targets%$名敌人）， 持续10秒",

            -- 战争巨头
            HERO_ROBOT_EXPLODE_DESCRIPTION_1 =
            "制造一阵爆炸，对敌人造成%$heroes.hero_robot.explode.damage_min[1]%$-%$heroes.hero_robot.explode.damage_max[1]%$点爆炸伤害，并使他们燃烧%$heroes.hero_robot.explode.burning_duration%$秒。燃烧每秒造成12点伤害。",
            HERO_ROBOT_EXPLODE_DESCRIPTION_2 =
            "制造一阵爆炸，对敌人造成%$heroes.hero_robot.explode.damage_min[2]%$-%$heroes.hero_robot.explode.damage_max[2]%$点爆炸伤害，并使他们燃烧%$heroes.hero_robot.explode.burning_duration%$秒。燃烧每秒造成16点伤害。",
            HERO_ROBOT_EXPLODE_DESCRIPTION_3 =
            "制造一阵爆炸，对敌人造成%$heroes.hero_robot.explode.damage_min[3]%$-%$heroes.hero_robot.explode.damage_max[3]%$点爆炸伤害，并使他们燃烧%$heroes.hero_robot.explode.burning_duration%$秒。燃烧每秒造成20点伤害。",
            HERO_ROBOT_FIRE_DESCRIPTION_1 =
            "发射装满炽热余烬的炮弹，对敌人造成%$heroes.hero_robot.fire.damage_min[1]%$-%$heroes.hero_robot.fire.damage_max[1]%$点物理伤害，并晕眩点燃敌人%$heroes.hero_robot.fire.s_slow_duration[1]%$秒。",
            HERO_ROBOT_FIRE_DESCRIPTION_2 =
            "发射装满炽热余烬的炮弹，对敌人造成%$heroes.hero_robot.fire.damage_min[2]%$-%$heroes.hero_robot.fire.damage_max[2]%$点物理伤害，并晕眩点燃敌人%$heroes.hero_robot.fire.s_slow_duration[1]%$秒。",
            HERO_ROBOT_FIRE_DESCRIPTION_3 =
            "发射装满炽热余烬的炮弹，对敌人造成%$heroes.hero_robot.fire.damage_min[3]%$-%$heroes.hero_robot.fire.damage_max[3]%$点物理伤害，并晕眩点燃敌人%$heroes.hero_robot.fire.s_slow_duration[1]%$秒。",
            HERO_ROBOT_FIRE_TITLE = "瓦斯烟幕",
            HERO_ROBOT_JUMP_DESCRIPTION_1 =
            "跳到空中，砸向一名敌人，使其眩晕2秒，并对范围内造成%$heroes.hero_robot.jump.s_damage[1]%$点物理伤害。",
            HERO_ROBOT_JUMP_DESCRIPTION_2 =
            "跳到空中，砸向一名敌人，使其眩晕3秒，并对范围内造成%$heroes.hero_robot.jump.s_damage[2]%$点物理伤害。",
            HERO_ROBOT_JUMP_DESCRIPTION_3 =
            "跳到空中，砸向一名敌人，使其眩晕4秒，并对范围内造成%$heroes.hero_robot.jump.s_damage[3]%$点物理伤害。",
            HERO_ROBOT_TRAIN_DESCRIPTION_1 =
            "召唤一辆战车沿路径行进，对敌人造成%$heroes.hero_robot.ultimate.s_damage[1]%$点伤害并使其燃烧，持续%$heroes.hero_robot.ultimate.burning_duration%$秒。燃烧每秒造成12点伤害。",
            HERO_ROBOT_TRAIN_DESCRIPTION_2 =
            "召唤一辆战车沿路径行进，对敌人造成%$heroes.hero_robot.ultimate.s_damage[2]%$点伤害并使其燃烧，持续%$heroes.hero_robot.ultimate.burning_duration%$秒。燃烧每秒造成16点伤害。",
            HERO_ROBOT_TRAIN_DESCRIPTION_3 =
            "召唤一辆战车沿路径行进，对敌人造成%$heroes.hero_robot.ultimate.s_damage[3]%$点伤害并使其燃烧，持续%$heroes.hero_robot.ultimate.burning_duration%$秒。燃烧每秒造成20点伤害。",

            -- 虚空法师
            HERO_SPACE_ELF_SPATIAL_DISTORTION_DESCRIPTION_1 =
            "扭曲所有防御塔周围的空间8秒，增加防御塔%$heroes.hero_space_elf.spatial_distortion.s_range_factor[1]%$%攻击范围。",
            HERO_SPACE_ELF_SPATIAL_DISTORTION_DESCRIPTION_2 =
            "扭曲所有防御塔周围的空间10秒，增加防御塔%$heroes.hero_space_elf.spatial_distortion.s_range_factor[2]%$%攻击范围。",
            HERO_SPACE_ELF_SPATIAL_DISTORTION_DESCRIPTION_3 =
            "扭曲所有防御塔周围的空间12秒，增加防御塔%$heroes.hero_space_elf.spatial_distortion.s_range_factor[3]%$%攻击范围。",
            
            -- 蛛后
            HERO_SPIDER_ARACNID_SPAWNER_DESCRIPTION_1 =
            "召唤%$heroes.hero_spider.ultimate.spawn_amount[1]%$只蜘蛛，持续战斗8秒，蜘蛛攻击敌人时25%几率使其眩晕。",
            HERO_SPIDER_ARACNID_SPAWNER_DESCRIPTION_2 =
            "召唤%$heroes.hero_spider.ultimate.spawn_amount[2]%$只蜘蛛，持续战斗10秒，蜘蛛攻击敌人时25%几率使其眩晕。",
            HERO_SPIDER_ARACNID_SPAWNER_DESCRIPTION_3 =
            "召唤%$heroes.hero_spider.ultimate.spawn_amount[3]%$只蜘蛛，持续战斗12秒，蜘蛛攻击敌人时25%几率使其眩晕。",
            
            -- 毒液
            HERO_VENOM_CREEPING_DEATH_DESCRIPTION_1 =
            "在一定范围散布粘稠物质，每3秒对敌人造成10-15点真实伤害，持续40秒，若有另一片粘稠物质则开启传送门，传送友方与敌人。",
            HERO_VENOM_CREEPING_DEATH_DESCRIPTION_2 =
            "在一定范围散布粘稠物质，每3秒对敌人造成15-20点真实伤害，持续50秒，若有另一片粘稠物质则开启传送门，传送友方与敌人。",
            HERO_VENOM_CREEPING_DEATH_DESCRIPTION_3 =
            "在一定范围散布粘稠物质，每3秒对敌人造成20-25点真实伤害，持续60秒，若有另一片粘稠物质则开启传送门，传送友方与敌人。",
            HERO_VENOM_INNER_BEAST_DESCRIPTION_1 =
            "当格里姆森的生命值低于60%时将完全变身，攻击伤害提升%$heroes.hero_venom.inner_beast.basic_melee.s_damage_factor[1]%$%，并且每次攻击命中时恢复自身总生命值的%$heroes.hero_venom.inner_beast.basic_melee.regen_health%$%，持续%$heroes.hero_venom.inner_beast.duration%$秒。",
            HERO_VENOM_INNER_BEAST_DESCRIPTION_2 =
            "当格里姆森的生命值低于60%时将完全变身，攻击伤害提升%$heroes.hero_venom.inner_beast.basic_melee.s_damage_factor[2]%$%，并且每次攻击命中时恢复自身总生命值的%$heroes.hero_venom.inner_beast.basic_melee.regen_health%$%，持续%$heroes.hero_venom.inner_beast.duration%$秒。",
            HERO_VENOM_INNER_BEAST_DESCRIPTION_3 =
            "当格里姆森的生命值低于60%时将完全变身，攻击伤害提升%$heroes.hero_venom.inner_beast.basic_melee.s_damage_factor[3]%$%，并且每次攻击命中时恢复自身总生命值的%$heroes.hero_venom.inner_beast.basic_melee.regen_health%$%，持续%$heroes.hero_venom.inner_beast.duration%$秒。",
            HERO_VENOM_RANGED_TENTACLE_DESCRIPTION_1 =
            "远程攻击一名敌人将其向后传送，造成%$heroes.hero_venom.ranged_tentacle.s_damage[1]%$点物理伤害，并有%$heroes.hero_venom.ranged_tentacle.bleed_chance[1]%$%机率施加出血效果。出血效果每秒造成%$heroes.hero_venom.ranged_tentacle.s_bleed_damage%$点伤害，持续%$heroes.hero_venom.ranged_tentacle.bleed_duration[1]%$秒。",
            HERO_VENOM_RANGED_TENTACLE_DESCRIPTION_2 =
            "远程攻击一名敌人将其向后传送，造成%$heroes.hero_venom.ranged_tentacle.s_damage[2]%$点物理伤害，并有%$heroes.hero_venom.ranged_tentacle.bleed_chance[2]%$%机率施加出血效果。出血效果每秒造成%$heroes.hero_venom.ranged_tentacle.s_bleed_damage%$点伤害，持续%$heroes.hero_venom.ranged_tentacle.bleed_duration[2]%$秒。",
            HERO_VENOM_RANGED_TENTACLE_DESCRIPTION_3 =
            "远程攻击一名敌人将其向后传送，造成%$heroes.hero_venom.ranged_tentacle.s_damage[3]%$点物理伤害，并有%$heroes.hero_venom.ranged_tentacle.bleed_chance[3]%$%机率施加出血效果。出血效果每秒造成%$heroes.hero_venom.ranged_tentacle.s_bleed_damage%$点伤害，持续%$heroes.hero_venom.ranged_tentacle.bleed_duration[3]%$秒。",

            -- 维斯珀
            HERO_VESPER_ARROW_STORM_DESCRIPTION_1 =
            "朝一片区域倾泻%$heroes.hero_vesper.ultimate.s_spread[1]%$支箭矢，每支对敌人造成%$heroes.hero_vesper.ultimate.damage[1]%$点物理伤害，每0.5秒在鼠标光标位置召唤4支箭矢，每支箭造成2.5真实伤害。",
            HERO_VESPER_ARROW_STORM_DESCRIPTION_2 =
            "朝一片区域倾泻%$heroes.hero_vesper.ultimate.s_spread[2]%$支箭矢，每支对敌人造成%$heroes.hero_vesper.ultimate.damage[2]%$点物理伤害，每0.5秒在鼠标光标位置召唤4支箭矢，每支箭造成5真实伤害。",
            HERO_VESPER_ARROW_STORM_DESCRIPTION_3 =
            "朝一片区域倾泻%$heroes.hero_vesper.ultimate.s_spread[3]%$支箭矢，每支对敌人造成%$heroes.hero_vesper.ultimate.damage[3]%$点物理伤害，每0.5秒在鼠标光标位置召唤4支箭矢，每支箭造成7.5真实伤害。",
            HERO_VESPER_ARROW_TO_THE_KNEE_DESCRIPTION_1 =
            "射出一支利箭，眩晕敌人1秒，造成%$heroes.hero_vesper.arrow_to_the_knee.s_damage[1]%$点真实伤害。",
            HERO_VESPER_ARROW_TO_THE_KNEE_DESCRIPTION_2 =
            "射出一支利箭，眩晕敌人2秒，造成%$heroes.hero_vesper.arrow_to_the_knee.s_damage[2]%$点真实伤害。",
            HERO_VESPER_ARROW_TO_THE_KNEE_DESCRIPTION_3 =
            "射出一支利箭，眩晕敌人3秒，造成%$heroes.hero_vesper.arrow_to_the_knee.s_damage[3]%$点真实伤害。",
            HERO_VESPER_DISENGAGE_DESCRIPTION_1 =
            "当维斯珀受到攻击时，会向后跳跃避开下一次近战攻击，接着射出三支箭矢，每支对附近敌人造成%$heroes.hero_vesper.disengage.s_damage[1]%$点物理伤害。",
            HERO_VESPER_DISENGAGE_DESCRIPTION_2 =
            "当维斯珀受到攻击时，会向后跳跃避开下一次近战攻击，接着射出三支箭矢，每支对附近敌人造成%$heroes.hero_vesper.disengage.s_damage[2]%$点物理伤害。",
            HERO_VESPER_DISENGAGE_DESCRIPTION_3 =
            "当维斯珀受到攻击时，会向后跳跃避开下一次近战攻击，接着射出三支箭矢，每支对附近敌人造成%$heroes.hero_vesper.disengage.s_damage[3]%$点物理伤害。",
            HERO_VESPER_MARTIAL_FLOURISH_DESCRIPTION_1 =
            "攻击一名敌人三次，造成180点物理伤害。",
            HERO_VESPER_MARTIAL_FLOURISH_DESCRIPTION_2 =
            "攻击一名敌人三次，造成270点物理伤害。",
            HERO_VESPER_MARTIAL_FLOURISH_DESCRIPTION_3 =
            "攻击一名敌人三次，造成340点物理伤害。",

            -- 小女巫
            HERO_WITCH_DISENGAGE_DESCRIPTION_1 =
            "当斯特蕾吉生命值低于%$heroes.hero_witch.disengage.hp_to_trigger%$%时，会向后传送并在原先位置留下一个诱饵。其拥有250生命值，被摧毁时爆炸，眩晕敌人%$heroes.hero_witch.disengage.decoy.explotion.stun_duration[1]%$秒。",
            HERO_WITCH_DISENGAGE_DESCRIPTION_2 =
            "当斯特蕾吉生命值低于%$heroes.hero_witch.disengage.hp_to_trigger%$%时，会向后传送并在原先位置留下一个诱饵。其拥有350点生命值，被摧毁时爆炸，眩晕敌人%$heroes.hero_witch.disengage.decoy.explotion.stun_duration[2]%$秒。",
            HERO_WITCH_DISENGAGE_DESCRIPTION_3 =
            "当斯特蕾吉生命值低于%$heroes.hero_witch.disengage.hp_to_trigger%$%时，会向后传送并在原先位置留下一个诱饵。其拥有450点生命值，被摧毁时爆炸，眩晕敌人%$heroes.hero_witch.disengage.decoy.explotion.stun_duration[3]%$秒。",
            HERO_WITCH_SOLDIERS_DESCRIPTION_1 =
            "召唤4只黑猫与敌人作战，每只拥有%$heroes.hero_witch.skill_soldiers.soldier.hp_max[1]%$点生命值，其攻击可造成%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_min[1]%$-%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_max[1]%$点物理伤害。",
            HERO_WITCH_SOLDIERS_DESCRIPTION_2 =
            "召唤6只黑猫与敌人作战，每只拥有%$heroes.hero_witch.skill_soldiers.soldier.hp_max[2]%$点生命值，其攻击可造成%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_min[2]%$-%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_max[2]%$点物理伤害。",
            HERO_WITCH_SOLDIERS_DESCRIPTION_3 =
            "召唤8只黑猫与敌人作战，每只拥有%$heroes.hero_witch.skill_soldiers.soldier.hp_max[3]%$点生命值，其攻击可造成%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_min[3]%$-%$heroes.hero_witch.skill_soldiers.soldier.melee_attack.damage_max[3]%$点物理伤害。",

            -- 悟空
            HERO_WUKONG_POLE_RANGED_DESCRIPTION_1 =
            "将金箍棒掷向空中，变出6根落向敌人，每根对小范围内的敌人造成6-10点伤害，并使其眩晕3秒。",
            HERO_WUKONG_POLE_RANGED_DESCRIPTION_2 =
            "将金箍棒掷向空中，变出10根落向敌人，每根对小范围内的敌人造成8-15点伤害，并使其眩晕3秒。",
            HERO_WUKONG_POLE_RANGED_DESCRIPTION_3 =
            "将金箍棒掷向空中，变出14根落向敌人，每根对小范围内的敌人造成11-20点伤害，并使其眩晕3秒。",
            HERO_WUKONG_ULTIMATE_DESCRIPTION_1 =
            "小白龙从天而降，猛扎进地面，造成%$heroes.hero_wukong.ultimate.damage_total[1]%$点真实伤害，并留下7秒减速区域。",
            HERO_WUKONG_ULTIMATE_DESCRIPTION_2 =
            "小白龙从天而降，猛扎进地面，造成%$heroes.hero_wukong.ultimate.damage_total[2]%$点真实伤害，并留下8秒减速区域。",
            HERO_WUKONG_ULTIMATE_DESCRIPTION_3 =
            "小白龙从天而降，猛扎进地面，造成%$heroes.hero_wukong.ultimate.damage_total[3]%$点真实伤害，并留下10秒减速区域。",
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
