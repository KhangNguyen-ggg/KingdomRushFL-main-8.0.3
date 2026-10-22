-- chunkname: @./_assets/kr6-desktop/sounds/sounds.lua

return {
	AreaAttack = {
		loop = false,
		gain = 1,
		source_group = "BULLETS",
		files = {
			"Sound_CommonAreaHit.ogg"
		}
	},
	ArrowSound = {
		loop = false,
		mode = "random",
		source_group = "BULLETS",
		files = {
			"Sound_ArrowRelease2.ogg",
			"Sound_ArrowRelease3.ogg"
		},
		gain = {
			0.65,
			0.8
		}
	},
	BoltSound = {
		loop = false,
		gain = 0.68,
		source_group = "BULLETS",
		files = {
			"Sound_MageShot.ogg"
		}
	},
	BombExplosionSound = {
		loop = false,
		gain = 0.8,
		source_group = "EXPLOSIONS",
		files = {
			"Sound_Bomb1.ogg"
		}
	},
	BombShootSound = {
		loop = false,
		gain = 0.75,
		source_group = "EXPLOSIONS",
		files = {
			"Sound_EngineerShot.ogg"
		}
	},
	BasicBodyImpact = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_combat_basicImpact_v1.ogg",
			"kr6_sfx_combat_basicImpact_v2.ogg",
			"kr6_sfx_combat_basicImpact_v3.ogg"
		}
	},
	DeathEplosion = {
		loop = false,
		gain = 0.4,
		source_group = "DEATH",
		files = {
			"Sound_EnemyExplode1.ogg"
		}
	},
	DeathHuman = {
		loop = false,
		mode = "random",
		source_group = "DEATH",
		files = {
			"Sound_HumanDead1.ogg",
			"Sound_HumanDead2.ogg",
			"Sound_HumanDead3.ogg",
			"Sound_HumanDead4.ogg"
		}
	},
	GUISplash = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		delay = 0,
		files = {
			"kr6_sfx_splashScreen_v1.ogg"
		}
	},
	GUIAchievementWin = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_achievementPopup_v1.ogg"
		}
	},
	GUIButtonCommon = {
		loop = false,
		gain = 0.6,
		source_group = "GUI",
		files = {
			"kr6_sfx_ui_buttonClick_v1.ogg"
		}
	},
	GUIButtonUnavailable = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_buttonUnavailable_v1.ogg"
		}
	},
	GUIBuyUpgrade = {
		loop = false,
		gain = 0.6,
		source_group = "GUI",
		files = {
			"kr6_sfx_towerHeroSpellRoom_buyUpgrade_v1.ogg"
		}
	},
	GUICoins = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_Coins.ogg"
		}
	},
	GUILooseLife = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_LooseLife.ogg"
		}
	},
	GUIMapNewFlah = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_MapNewFlag.ogg"
		}
	},
	GUINextWaveIncoming = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_WaveIncoming.ogg"
		}
	},
	GUINextWaveReady = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_NextWaveReady.ogg"
		}
	},
	GUINotificationClose = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_notificationScreen_in_v1.ogg"
		}
	},
	GUINotificationOpen = {
		loop = false,
		gain = 0.8,
		source_group = "GUI",
		files = {
			"kr6_sfx_notificationScreen_in_v1.ogg"
		}
	},
	GUIPopUpClose = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_notificationPopup_in_v1.ogg"
		}
	},
	GUIPopUpOpen = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_notificationPopup_in_v1.ogg"
		}
	},
	GUINotificationPaperOver = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_NotificationPaperOver.ogg"
		}
	},
	GUINotificationSecondLevel = {
		loop = false,
		gain = 0.8,
		source_group = "GUI",
		files = {
			"Sound_NotificationSecondLevel.ogg"
		}
	},
	GUIPlaceRallyPoint = {
		loop = false,
		gain = 0.8,
		source_group = "GUI",
		files = {
			"Sound_RallyPointPlaced.ogg"
		}
	},
	GUIQuestCompleted = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_stageVictory_v1.ogg"
		}
	},
	GUIQuestFailed = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_stageDefeat_v1.ogg"
		}
	},
	GUIQuickMenuOpen = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_GUIOpenTowerMenu.ogg"
		}
	},
	GUIQuickMenuOver = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_GUIMouseOverTowerIcon.ogg"
		}
	},
	GUISpellRefresh = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_SpellRefresh.ogg"
		}
	},
	GUISpellSelect = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_SpellSelect.ogg"
		}
	},
	GUITowerBuilding = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_TowerBuilding.ogg"
		}
	},
	GUIClearHolder = {
		loop = false,
		gain = 0.8,
		source_group = "GUI",
		files = {
			"kr6_sfx_holder_clearHolder_op3_v1.ogg"
		}
	},
	GUITowerOpenDoor = {
		loop = false,
		gain = 0.2,
		source_group = "GUI",
		delay = 0.2,
		files = {
			"kra_sfx_tower_paladinCovenant_deploy_v1.ogg"
		}
	},
	GUITowerSell = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_TowerSell.ogg"
		}
	},
	GUITransitionClose = {
		loop = false,
		gain = 0.7,
		source_group = "GUI",
		files = {
			"kr6_sfx_loadingScreen_IN_v1.ogg"
		}
	},
	GUITransitionOpen = {
		loop = false,
		gain = 0.7,
		source_group = "GUI",
		files = {
			"kr6_sfx_loadingScreen_OUT_v1.ogg"
		}
	},
	GUIWinStars = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr5_sfx_victorystars_3_v1.ogg"
		}
	},
	GUIWinStars1 = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_ui_victoryScreen_starClaim_1_v1.ogg"
		}
	},
	GUIWinStars2 = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_ui_victoryScreen_starClaim_2_v1.ogg"
		}
	},
	GUIWinStars3 = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_ui_victoryScreen_starClaim_3_v1.ogg"
		}
	},
	GUIXpBarShort = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_ui_endStageScreen_levelUp_xpBarUp_short_v1.ogg"
		}
	},
	GUIXpBarLong = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_ui_endStageScreen_levelUp_xpBarUp_long_v1.ogg"
		}
	},
	GUINewXpLevel = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_ui_endStageScreen_levelUp_feedback_v1.ogg"
		}
	},
	GUICardsVD = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_ui_victoryDefeatScreen_cards_v1.ogg"
		}
	},
	GUIBuyLevel = {
		source_group = "GUI",
		gain = 1,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_towerHeroSpellRoom_buyLevel_v1.ogg"
		}
	},
	GuimapNewRoad = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"Sound_MapRoad.ogg"
		}
	},
	GUIAchievementClaim = {
		source_group = "GUI",
		gain = 0.8,
		loop = false,
		ignore = 0.2,
		files = {
			"kr6_sfx_achievementRoom_achievementClaim_v1.ogg"
		}
	},
	GUICardPreGlow = {
		loop = false,
		gain = 0.8,
		source_group = "GUI",
		delay = 0.5,
		files = {
			"kr6_sfx_rewardRoom_rewardUnlock_glow_v1.ogg"
		}
	},
	GUICardAppear = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_rewards_unlock_appear-stomp_v1.ogg"
		}
	},
	GUICardUnlock = {
		loop = false,
		gain = 0.95,
		source_group = "GUI",
		files = {
			"kr6_sfx_rewardRoom_rewardUnlock_reward_v1.ogg"
		}
	},
	GUIEquip = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_heroselect_op2.ogg"
		}
	},
	GUIBalloonIn = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_balloon-in.ogg"
		}
	},
	GUIBalloonOut = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_balloon-out.ogg"
		}
	},
	GUIFlagFall = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_flagfall.ogg"
		}
	},
	GUIButtonSoft1 = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_genericbuttonsoft_op1.ogg"
		}
	},
	GUIButtonSoft2 = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_genericbuttonsoft_op2.ogg"
		}
	},
	GUIHeroScroll = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_heroscroll_op1.ogg"
		}
	},
	GUIHeroSelect = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_heroselect_op1.ogg"
		}
	},
	GUIHeroSkillConfirm = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_heroskillconfirm.ogg"
		}
	},
	GUIHeroSkillSelect = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr5_sfx_heroskillselect.ogg"
		}
	},
	GUIGemCounterSingle = {
		source_group = "GUI",
		gain = 0.7,
		loop = false,
		ignore = 0.1,
		files = {
			"kra_sfx_ui_gemCounter_SINGLE_v1.ogg"
		}
	},
	HeroLevelUp = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg"
		}
	},
	HeroReinforcementTauntIntro = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg"
		}
	},
	HeroReinforcementTauntSelect = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"Reinforcement-01a.ogg"
		}
	},
	HitSound = {
		loop = false,
		gain = 0.15,
		source_group = "BULLETS",
		files = {
			"Sound_ArrowHit2.ogg",
			"Sound_ArrowHit3.ogg"
		}
	},
	InAppBuyGems = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"inapp_cash.ogg"
		}
	},
	InAppBuyInApp = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"inapp_chin.ogg"
		}
	},
	InAppEarnGems = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"inapp_gems.ogg"
		}
	},
	InAppExtraGold = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"inapp_gnome.ogg"
		}
	},
	GUIRewardUnlockCardAppear = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_rewards_unlock_cardAppear_v1.ogg"
		}
	},
	GUIRewardUnlockPreGlow = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_rewards_unlock_pre-glow_v1.ogg"
		}
	},
	GUIRewardUnlockCardUnlock = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_rewards_unlock_op1_v1.ogg"
		}
	},
	GUIMapDotsAppear = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_mapDotsAppear_op2_v2.ogg"
		}
	},
	GUIMapStageFlagAppear = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_stageFlagAppear_v1.ogg"
		}
	},
	GUIMapStage4WallBreak = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_map_stage4_wallBreak_v1.ogg"
		}
	},
	GUIMapStage5ForestBurn = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_map_stage5_forestBurn_v1.ogg"
		}
	},
	GUIMapStage8FortressBreak = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_map_stage8_fortressBreak_v1.ogg"
		}
	},
	GUIMapStage11RockBreak = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_map_stage11_rockBreak_v1.ogg"
		}
	},
	GUIButtonHover = {
		loop = false,
		gain = 0.5,
		ignore = 0.1,
		source_group = "GUI",
		files = {
			"kr6_sfx_ui_buttonHover_op3_v1.ogg"
		}
	},
	GUIButtonOut = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_buttonOut_op2_v2.ogg"
		}
	},
	GUIResetUpgrade = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_towerHeroSpellRoom_resetUpgrade_v1.ogg"
		}
	},
	GUIHeroTowerSelect = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_towerHeroSpellRoom_equip_v1.ogg"
		}
	},
	GUITowerWheelTapOn = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_towerWheelDrag_tapOn_v1.ogg"
		}
	},
	GUITowerWheelTapOff = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kra_sfx_ui_towerWheelDrag_tapOff_v1.ogg"
		}
	},
	GUIStageVictory = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_ui_victoryScreen_stinger_v1.ogg"
		}
	},
	GUIStageDefeat = {
		loop = false,
		gain = 1,
		source_group = "GUI",
		files = {
			"kr6_sfx_ui_defeatScreen_fullSeq_withoutCards_v2.ogg"
		}
	},
	HeroGeraldTaunt = {
		loop = false,
		gain = 0.6,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_geraldlightseeker_taunt01_c.ogg",
			"kr_voice_geraldlightseeker_taunt02_a.ogg",
			"kr_voice_geraldlightseeker_taunt03_b.ogg",
			"kr_voice_geraldlightseeker_taunt04_b.ogg"
		}
	},
	HeroGeraldTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_geraldlightseeker_taunt01_c.ogg"
		}
	},
	HeroGeraldTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_voice_geraldlightseeker_taunt01_c.ogg"
		}
	},
	HeroGeraldDeath = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"kr_voice_geraldlightseeker_death_a.ogg"
		}
	},
	HeroGeraldTauntUltimate = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"kr_voice_geraldlightseeker_ultimate_a.ogg"
		}
	},
	HeroGeraldTauntLevelUp = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"kr_voice_geraldlightseeker_levelup_c.ogg"
		}
	},
	HeroGeraldInspireCourageCast = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gerald_inspireCourage_cast_v1.ogg"
		}
	},
	HeroGeraldShieldOfRetributionCast = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gerald_shieldOfRetribution_cast_v1.ogg"
		}
	},
	HeroGeraldFatedSurvivorCast = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		delay = 1.2,
		files = {
			"kr6_sfx_heroes_gerald_fatedSurvivor_cast_v1.ogg"
		}
	},
	HeroGeraldDivineBladeCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gerald_divineBlade_cast_op1_v1.ogg"
		}
	},
	HeroDivineBladeImpact = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		delay = 1,
		files = {
			"kr6_sfx_heroes_gerald_divineBlade_impact_v1.ogg"
		}
	},
	HeroZefiraTaunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_zefira_taunt01_b.ogg",
			"kr_voice_zefira_taunt02_d.ogg",
			"kr_voice_zefira_taunt03_b.ogg",
			"kr_voice_zefira_taunt04_c.ogg"
		}
	},
	HeroZefiraTauntIntro = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_zefira_taunt01_b.ogg"
		}
	},
	HeroZefiraTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.8,
		loop = false,
		interruptible = true,
		files = {
			"kr_voice_zefira_taunt01_b.ogg"
		}
	},
	HeroZefiraDeath = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_zefira_death_b.ogg"
		}
	},
	HeroZefiraTauntUltimate = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_zefira_ultimate_b.ogg"
		}
	},
	HeroZefiraTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_zefira_levelup_a.ogg"
		}
	},
	HeroZefiraBasicAttackCast = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_zefira_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_heroes_zefira_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_heroes_zefira_basicAttack_cast_var1_v1.ogg"
		}
	},
	HeroZefiraDazzlingHammerCast = {
		loop = false,
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_zefira_dazzlingHammer_cast_v1.ogg"
		}
	},
	HeroZefiraShieldingBladesCast = {
		loop = false,
		mode = "random",
		gain = 0.2,
		source_group = "SFX",
		interruptible = true,
		files = {
			"kr6_sfx_heroes_zefira_shieldingBlades_cast_v1.ogg"
		}
	},
	HeroZefiraAstralBlinkInCast = {
		loop = false,
		gain = 0.2,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_zefira_astralBlink_In_v1.ogg"
		}
	},
	HeroZefiraAstralBlinkOutCast = {
		loop = false,
		gain = 0.2,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_zefira_astralBlink_Out_v1.ogg"
		}
	},
	HeroZefiraEtherealSpears = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_zefira_etherealSpears_cast_woOut_v1.ogg"
		}
	},
	HeroBolinTaunt = {
		loop = false,
		gain = 0.5,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_bolinfarslayer_taunt01_b.ogg",
			"kr_voice_bolinfarslayer_taunt02_c.ogg",
			"kr_voice_bolinfarslayer_taunt03_b.ogg",
			"kr_voice_bolinfarslayer_taunt04_a.ogg"
		}
	},
	HeroBolinTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_bolinfarslayer_taunt01_b.ogg"
		}
	},
	HeroBolinTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_voice_bolinfarslayer_taunt01_b.ogg"
		}
	},
	HeroBolinDeath = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_bolinfarslayer_death_a.ogg"
		}
	},
	HeroBolinTauntUltimate = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"kr_voice_bolinfarslayer_ultimate_c.ogg"
		}
	},
	HeroBolinTauntLevelUp = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"kr_voice_bolinfarslayer_levelup_c.ogg"
		}
	},
	HeroBolinBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_heroes_bolin_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_heroes_bolin_basicAttack_cast_var3_v1.ogg"
		}
	},
	HeroBolinSmokeMortarCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_smokeMortar_cast_v1.ogg"
		}
	},
	HeroBolinSmokeMortarTripleImpact = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		interruptible = true,
		files = {
			"kr6_sfx_heroes_bolin_smokeMortar_impact_tripleImpact_v1.ogg"
		}
	},
	HeroBolinMinefieldCastThrow = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_minefield_cast_throw_v1.ogg"
		}
	},
	HeroBolinMinefieldCastArmed = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_minefield_cast_armed_v1.ogg"
		}
	},
	HeroBolinMinefieldExplosion = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_minefield_cast_explosion_var1_v1.ogg",
			"kr6_sfx_heroes_bolin_minefield_cast_explosion_var2_v1.ogg",
			"kr6_sfx_heroes_bolin_minefield_cast_explosion_var3_v1.ogg"
		}
	},
	HeroBolinGiantSlayerAttack = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_giantSlayer_attack_var1_v1.ogg",
			"kr6_sfx_heroes_bolin_giantSlayer_attack_var2_v1.ogg",
			"kr6_sfx_heroes_bolin_giantSlayer_attack_var3_v1.ogg"
		}
	},
	HeroBolinSuppresiveFireCastDrink = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_suppressiveFire_cast_drink_v1.ogg"
		}
	},
	HeroBolinSuppresiveFireCastReload = {
		loop = false,
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_bolin_suppressiveFire_cast_reload_v1.ogg"
		}
	},
	HeroMalikTaunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_malik_taunt01_b.ogg",
			"kr_voice_malik_taunt02_b.ogg",
			"kr_voice_malik_taunt03_a.ogg",
			"kr_voice_malik_taunt04_a.ogg"
		}
	},
	HeroMalikTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_malik_taunt01_b.ogg"
		}
	},
	HeroMalikTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_voice_malik_taunt01_b.ogg"
		}
	},
	HeroMalikDeath = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_malik_death_a.ogg"
		}
	},
	HeroMalikTauntUltimate = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_malik_ultimate_d.ogg"
		}
	},
	HeroMalikTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_malik_levelup_c.ogg"
		}
	},
	HeroMalikUnbreakableCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_malik_unbreakable_cast_v1.ogg"
		}
	},
	HeroMalikHammernadoCastLoopStart = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_malik_hammernado_cast_loopStart_v1.ogg"
		}
	},
	HeroMalikHammernadoCastLoop = {
		loop = true,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_malik_hammernado_cast_LOOP_v1.ogg"
		}
	},
	HeroMalikHammernadoCastLoopEnd = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_malik_hammernado_cast_loopEnd_v1.ogg"
		}
	},
	HeroMalikEarthquakeCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_malik_earthquake_cast_v1.ogg"
		}
	},
	HeroMalikObliterateCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_malik_obliterate_cast_v1.ogg"
		}
	},
	HeroAshbiteTaunt = {
		loop = false,
		gain = 0.5,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_ashbite_taunt01_b.ogg",
			"kr_voice_ashbite_taunt02_b.ogg",
			"kr_voice_ashbite_taunt03_c.ogg",
			"kr_voice_ashbite_taunt04_a.ogg"
		}
	},
	HeroAshbiteTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_ashbite_taunt01_b.ogg"
		}
	},
	HeroAshbiteTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_voice_ashbite_taunt01_b.ogg"
		}
	},
	HeroAshbiteDeath = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_ashbite_death_d.ogg"
		}
	},
	HeroAshbiteTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_ashbite_levelup_a.ogg"
		}
	},
	HeroAshbiteBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ashbite_basicAttack_var1_v1.ogg",
			"kr6_sfx_heroes_ashbite_basicAttack_var2_v1.ogg",
			"kr6_sfx_heroes_ashbite_basicAttack_var3_v1.ogg"
		}
	},
	HeroAshbiteBlazingBreathCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ashbite_blazingBreath_cast_v1.ogg"
		}
	},
	HeroAshbiteSearingSneeze = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ashbite_searingSneeze_cast_v1.ogg"
		}
	},
	HeroAshbiteFeedingTimeFlyDown = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ashbite_feedingTime_flyDown_v1.ogg"
		}
	},
	HeroAshbiteFeedingTimeAttack = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ashbite_feedingTime_attack_var1_v1.ogg",
			"kr6_sfx_heroes_ashbite_feedingTime_attack_var2_v1.ogg",
			"kr6_sfx_heroes_ashbite_feedingTime_attack_var3_v1.ogg"
		}
	},
	HeroAshbiteWildfireBarrageCast = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ashbite_wildfireBarrage_cast_var1_v1.ogg",
			"kr6_sfx_heroes_ashbite_wildfireBarrage_cast_var2_v1.ogg",
			"kr6_sfx_heroes_ashbite_wildfireBarrage_cast_var3_v1.ogg"
		}
	},
	HeroAshbiteWildfireBarrageImpact = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ashbite_wildfireBarrage_impact_var1_v1.ogg",
			"kr6_sfx_heroes_ashbite_wildfireBarrage_impact_var2_v1.ogg",
			"kr6_sfx_heroes_ashbite_wildfireBarrage_impact_var3_v1.ogg"
		}
	},
	HeroDrakkanTaunt = {
		loop = false,
		gain = 1,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_drakkan_taunt01_b.ogg",
			"kr_voice_drakkan_taunt02_b.ogg",
			"kr_voice_drakkan_taunt03_c.ogg",
			"kr_voice_drakkan_taunt04_c.ogg"
		}
	},
	HeroDrakkanTauntIntro = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_drakkan_taunt01_b.ogg"
		}
	},
	HeroDrakkanTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_voice_drakkan_taunt01_b.ogg"
		}
	},
	HeroDrakkanDeath = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_drakkan_death_c.ogg"
		}
	},
	HeroDrakkanTauntUltimate = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_drakkan_ultimate_b.ogg"
		}
	},
	HeroDrakkanTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_drakkan_levelup_d.ogg"
		}
	},
	HeroDrakkanArcaneStormCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_arcaneStorm_cast_v1.ogg"
		}
	},
	HeroDrakkanArcaneStormImpact = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_arcaneStorm_impact_var1_v1.ogg",
			"kr6_sfx_heroes_drakkan_arcaneStorm_impact_var2_v1.ogg",
			"kr6_sfx_heroes_drakkan_arcaneStorm_impact_var3_v1.ogg",
			"kr6_sfx_heroes_drakkan_arcaneStorm_impact_var4_v1.ogg",
			"kr6_sfx_heroes_drakkan_arcaneStorm_impact_var5_v1.ogg",
			"kr6_sfx_heroes_drakkan_arcaneStorm_impact_var6_v1.ogg"
		}
	},
	HeroDrakkanBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_heroes_drakkan_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_heroes_drakkan_basicAttack_cast_var3_v1.ogg"
		}
	},
	HeroDrakkanDeconstructCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_deconstruct_cast_op1_v1.ogg"
		}
	},
	HeroDrakkanDoubleDragonCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_doubleDragon_cast_op1_v1.ogg"
		}
	},
	HeroDrakkanDoubleDragonDisappear = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_doubleDragon_disappear_v1.ogg"
		}
	},
	HeroDrakkanTalentTeleportIn = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_talentTeleport_in_v1.ogg"
		}
	},
	HeroDrakkanTalentTeleportOut = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_talentTeleport_out_v1.ogg"
		}
	},
	HeroDrakkanNullifyingPulseCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_drakkan_nullifyingPulse_cast_op1_v1.ogg"
		}
	},
	HeroRhodesTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_rhodes_taunt01_b.ogg",
			"kr_voice_rhodes_taunt02_a.ogg",
			"kr_voice_rhodes_taunt03_b.ogg",
			"kr_voice_rhodes_taunt04_c.ogg"
		}
	},
	HeroRhodesTauntIntro = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_rhodes_taunt01_b.ogg"
		}
	},
	HeroRhodesTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_voice_rhodes_taunt01_b.ogg"
		}
	},
	HeroRhodesDeath = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_rhodes_death_b.ogg"
		}
	},
	HeroRhodesTauntUltimate = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_rhodes_ultimate_c.ogg"
		}
	},
	HeroRhodesTauntLevelUp = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_rhodes_levelup_a.ogg"
		}
	},
	HeroRhodesSolarFlareCast = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_rhodes_solarFlare_cast_v1.ogg"
		}
	},
	HeroRhodesSolarFlareRayCast = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_rhodes_solarFlare_rayCast_v1.ogg"
		}
	},
	HeroRhodesStrongCrustCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_rhodes_strongCrust_cast_v1.ogg"
		}
	},
	HeroRhodesSunbeamCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_rhodes_sunbeam_cast_op1_v1.ogg"
		}
	},
	HeroRhodesTwistingTopStart = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_rhodes_twistingTop_loopStart_v1.ogg"
		}
	},
	HeroRhodesTwistingTopLoop = {
		source_group = "SFX",
		gain = 0.7,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_heroes_rhodes_twistingTop_loop_v1.ogg"
		}
	},
	HeroRhodesTwistingTopLoopEnd = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_rhodes_twistingTop_loopEnd_v1.ogg"
		}
	},
	HeroGeminaTaunt = {
		loop = false,
		gain = 0.5,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_gemina_taunt_d.ogg",
			"kr_gemina_taunt02_c.ogg",
			"kr_gemina_taunt03_c.ogg",
			"kr_gemina_taunt04_c.ogg"
		}
	},
	HeroGeminaTauntIntro = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_gemina_taunt_d.ogg"
		}
	},
	HeroGeminaTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_gemina_taunt_d.ogg"
		}
	},
	HeroGeminaDeath = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_gemina_death_d.ogg"
		}
	},
	HeroGeminaTauntUltimate = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_gemina_ultimate_c.ogg"
		}
	},
	HeroGeminaTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_gemina_levelup_c.ogg"
		}
	},
	HeroGeminaForwardIllusionCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_fowardIllusion_cast_v1.ogg"
		}
	},
	HeroGeminaGuardingDecoyCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_guardingDecoy_cast_v1.ogg"
		}
	},
	HeroGeminaMagicMissileCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_mirrorMissiles_cast_var1_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_cast_var2_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_cast_var3_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_cast_var4_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_cast_var5_v1.ogg"
		}
	},
	HeroGeminaMagicMissileImpact = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_mirrorMissiles_impact_var1_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_impact_var2_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_impact_var3_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_impact_var4_v1.ogg",
			"kr6_sfx_heroes_gemina_mirrorMissiles_impact_var5_v1.ogg"
		}
	},
	HeroGeminaMirrorSlashesCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_mirrorSlashes_cast.ogg"
		}
	},
	HeroGeminaMirrorBarrage = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_mirrorSlashes_barrage_v1.ogg"
		}
	},
	HeroGeminaIAmLegionCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_iAmLegion_cast_v2.ogg"
		}
	},
	HeroGeminaIllusionDeath = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_illusion_death_var1_v1.ogg",
			"kr6_sfx_heroes_gemina_illusion_death_var2_v1.ogg",
			"kr6_sfx_heroes_gemina_illusion_death_var3_v1.ogg"
		}
	},
	HeroGeminaDeathExplosion = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_gemina_illusion_deathExplosion_var1_v1.ogg",
			"kr6_sfx_heroes_gemina_illusion_deathExplosion_var2_v1.ogg",
			"kr6_sfx_heroes_gemina_illusion_deathExplosion_var3_v1.ogg"
		}
	},
	HeroConnorTaunt = {
		loop = false,
		gain = 0.6,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_connor_taunt_b.ogg",
			"kr_connor_taunt02_b.ogg",
			"kr_connor_taunt03_b.ogg",
			"kr_connor_taunt04_b.ogg"
		}
	},
	HeroConnorTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_connor_taunt_b.ogg"
		}
	},
	HeroConnorTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_connor_taunt_b.ogg"
		}
	},
	HeroConnorDeath = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_connor_death_c.ogg"
		}
	},
	HeroConnorTauntUltimate = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_connor_ultimate_b.ogg"
		}
	},
	HeroConnorTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_connor_levelup_c.ogg"
		}
	},
	HeroConnorArterialSlashCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_connor_arterialSlash_cast_v1.ogg"
		}
	},
	HeroConnorRetributionCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_connor_retribution_fullSeq_v1.ogg"
		}
	},
	HeroConnorEarthshatterJump = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_connor_earthshatter_jump_v2.ogg"
		}
	},
	HeroConnorEarthshatterImpact = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_connor_earthshatter_impact_v2.ogg"
		}
	},
	HeroConnorTemplarRageCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_connor_templarRage_cast_v1.ogg"
		}
	},
	HeroConnorTemplarRageBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_connor_templarRage_basicAttack_var1_v1.ogg",
			"kr6_sfx_heroes_connor_templarRage_basicAttack_var2_v1.ogg",
			"kr6_sfx_heroes_connor_templarRage_basicAttack_var3_v1.ogg"
		}
	},
	HeroIgnusTaunt = {
		loop = false,
		gain = 0.6,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_ignus_taunt01_c.ogg",
			"kr_ignus_taunt02_a.ogg",
			"kr_ignus_taunt03_a.ogg",
			"kr_ignus_taunt04_c.ogg"
		}
	},
	HeroIgnusTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_ignus_taunt01_c.ogg"
		}
	},
	HeroIgnusTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_ignus_taunt01_c.ogg"
		}
	},
	HeroIgnusDeath = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_ignus_death_c.ogg"
		}
	},
	HeroIgnusTauntUltimate = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_ignus_ultimate_b.ogg"
		}
	},
	HeroIgnusTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_ignus_levelup_b.ogg"
		}
	},
	HeroIgnusFireballCast = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_fireball_cast_var1_v1.ogg",
			"kr6_sfx_heroes_ignus_fireball_cast_var2_v1.ogg",
			"kr6_sfx_heroes_ignus_fireball_cast_var3_v1.ogg"
		}
	},
	HeroIgnusFireballImpact = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_fireball_impact_var1_v1.ogg",
			"kr6_sfx_heroes_ignus_fireball_impact_var2_v1.ogg",
			"kr6_sfx_heroes_ignus_fireball_impact_var3_v1.ogg"
		}
	},
	HeroIgnusHeatwaveCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		delay = 0.5,
		files = {
			"kr6_sfx_heroes_ignus_heatwave_cast_v1.ogg"
		}
	},
	HeroIgnusFlameRushCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_flameRush_cast_v1.ogg"
		}
	},
	HeroIgnusFlameRushBounceHit = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_flameRush_bounceHit_var1_v1.ogg",
			"kr6_sfx_heroes_ignus_flameRush_bounceHit_var2_v1.ogg",
			"kr6_sfx_heroes_ignus_flameRush_bounceHit_var3_v1.ogg"
		}
	},
	HeroIgnusSupernovaCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_supernova_oneShot_v1.ogg"
		}
	},
	HeroIgnusSupernovaLoopStart = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		delay = 0.5,
		files = {
			"kr6_sfx_heroes_ignus_supernova_loopStart_v1.ogg"
		}
	},
	HeroIgnusSupernovaLoop = {
		source_group = "SFX",
		gain = 0.7,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_heroes_ignus_supernova_loop.ogg"
		}
	},
	HeroIgnusSupernovaLoopEnd = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_supernova_loopEnd_v1.ogg"
		}
	},
	HeroIgnusTransformationIn = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_transformation_in_v1.ogg"
		}
	},
	HeroIgnusTransformationOut = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_transformation_out_v1.ogg"
		}
	},
	HeroIgnusFireMovement = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_fireMovement_var1_v1.ogg",
			"kr6_sfx_heroes_ignus_fireMovement_var2_v1.ogg",
			"kr6_sfx_heroes_ignus_fireMovement_var3_v1.ogg"
		}
	},
	HeroIgnusBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_ignus_basicAttack_cast_var1_op1_v1.ogg",
			"kr6_sfx_heroes_ignus_basicAttack_cast_var2_op1_v1.ogg",
			"kr6_sfx_heroes_ignus_basicAttack_cast_var3_op1_v1.ogg",
			"kr6_sfx_heroes_ignus_basicAttack_cast_var4_op1_v1.ogg",
			"kr6_sfx_heroes_ignus_basicAttack_cast_var5_op1_v1.ogg"
		}
	},
	HeroMalikBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_malik_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_heroes_malik_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_heroes_malik_basicAttack_cast_var3_v1.ogg"
		}
	},
	HeroOniTaunt = {
		loop = false,
		gain = 0.6,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_oni_taunt01_a.ogg",
			"kr_oni_taunt02_a.ogg",
			"kr_oni_taunt03_b.ogg",
			"kr_oni_taunt04_c.ogg"
		}
	},
	HeroOniTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_oni_taunt01_a.ogg"
		}
	},
	HeroOniTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_oni_taunt01_a.ogg"
		}
	},
	HeroOniDeath = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"kr_oni_death_b.ogg"
		}
	},
	HeroOniTauntUltimate = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_oni_ultimate_b.ogg"
		}
	},
	HeroOniTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_oni_levelup_c.ogg"
		}
	},
	HeroOniDeathStrikeCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		delay = 0.2,
		files = {
			"kr6_sfx_heroes_oni_deathStrike_cast_v1.ogg"
		}
	},
	HeroOniNetherfocusCast = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		delay = 0.3,
		files = {
			"kr6_sfx_heroes_oni_netherfocus_cast_v1.ogg"
		}
	},
	HeroOniHellishStrikeCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		delay = 0.1,
		files = {
			"kr6_sfx_heroes_oni_hellishStrike_cast_v1.ogg"
		}
	},
	HeroOniHellishStrikePhaseOut = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		delay = 0.1,
		files = {
			"kr6_sfx_heroes_oni_hellishStrike_phaseOut_v1.ogg"
		}
	},
	HeroOniHellishStrikeHits = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_oni_hellishStrike_hits_v1.ogg"
		}
	},
	HeroOniSwordTormentOneShot = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		delay = 0.75,
		files = {
			"kr6_sfx_heroes_oni_swordTorment_cast-swordsUp_v1.ogg"
		}
	},
	HeroIllianaTaunt = {
		loop = false,
		gain = 0.6,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_illiana_taunt01_a.ogg",
			"kr_illiana_taunt02_a.ogg",
			"kr_illiana_taunt03_b.ogg",
			"kr_illiana_taunt04_c.ogg"
		}
	},
	HeroIllianaTauntIntro = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_illiana_taunt01_a.ogg"
		}
	},
	HeroIllianaTauntSelect = {
		source_group = "TAUNTS",
		gain = 0.9,
		loop = false,
		interruptible = true,
		files = {
			"kr_illiana_taunt01_a.ogg"
		}
	},
	HeroIllianaDeath = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_illiana_death_b.ogg"
		}
	},
	HeroIllianaTauntUltimate = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_illiana_ultimate_b.ogg"
		}
	},
	HeroIllianaTauntLevelUp = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_illiana_levelup_a.ogg"
		}
	},
	HeroIllianaBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_heroes_illiana_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_heroes_illiana_basicAttack_cast_var3_v1.ogg"
		}
	},
	HeroIllianaSparkyBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_sparkyBasicAttack_cast_var1_v1.ogg",
			"kr6_sfx_heroes_illiana_sparkyBasicAttack_cast_var2_v1.ogg",
			"kr6_sfx_heroes_illiana_sparkyBasicAttack_cast_var2_v1.ogg"
		}
	},
	HeroIllianaTagCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_tag_cast_v1.ogg"
		}
	},
	HeroIllianaTagBounce = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_tag_bounce_var1_v1.ogg",
			"kr6_sfx_heroes_illiana_tag_bounce_var2_v1.ogg",
			"kr6_sfx_heroes_illiana_tag_bounce_var3_v1.ogg"
		}
	},
	HeroIllianaGlitterBombImpact = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_glitterBomb_impact_v1.ogg"
		}
	},
	HeroIllianaEasyPrey = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_easyPrey_impact_v1.ogg"
		}
	},
	HeroIllianaSparkyIncinerateCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_sparkyIncinerate_cast_op1_v1.ogg"
		}
	},
	HeroIllianaSparkyIncinerateFire = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_heroes_illiana_sparkyIncinerate_fire_op2_v1.ogg"
		}
	},
	PowersRainOfFireCast = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_rainOfFire_cast_var1_v1.ogg",
			"kr6_sfx_powers_rainOfFire_cast_var2_v1.ogg",
			"kr6_sfx_powers_rainOfFire_cast_var3_v1.ogg",
			"kr6_sfx_powers_rainOfFire_cast_var4_v1.ogg"
		}
	},
	PowersRainOfFireImpact = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_rainOfFire_impact_var1_v1.ogg",
			"kr6_sfx_powers_rainOfFire_impact_var2_v1.ogg",
			"kr6_sfx_powers_rainOfFire_impact_var3_v1.ogg",
			"kr6_sfx_powers_rainOfFire_impact_var4_v1.ogg"
		}
	},
	PowersRoyalDecreeCastLvl1 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_royalDecree_lvl1_v4.ogg"
		}
	},
	PowersRoyalDecreeCastLvl6 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_royalDecree_lvl3_v3.ogg"
		}
	},
	PowersTeleportSigilInOut = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_teleportSigil_teleport_in-out_v1.ogg"
		}
	},
	PowersTeleportSigilInstakillCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_teleportSigil_instakill_cast_v1.ogg"
		}
	},
	PowersAspectOfSolEntrance = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_aspectOfSol_entrance_cast_v1.ogg"
		}
	},
	PowersAspectOfSolBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.55,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_aspectOfSol_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_powers_aspectOfSol_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_powers_aspectOfSol_basicAttack_cast_var3_v1.ogg"
		}
	},
	PowersAspectOfSolWarcryCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_aspectOfSol_warcry_cast_op1_v1.ogg"
		}
	},
	PowersAspectOfSolEpicEntranceCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_aspectOfSol_epicEntrance_cast_v1.ogg"
		}
	},
	PowersAspectOfSolEpicEntranceOut = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_aspectOfSol_epicEntrance_out_v1.ogg"
		}
	},
	PowersAspectOfSolChargedAttack = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_aspectOfSol_chargedAttack_v1.ogg"
		}
	},
	PowersAspectOfSolSummonTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_aspectofsol_taunt01_a.ogg"
		}
	},
	PowersAspectOfSolMoveTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_aspectofsol_taunt02_c.ogg"
		}
	},
	PowersSoaringShopSummon = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_soaringShop_summon_op2_v1.ogg"
		}
	},
	PowersSoaringShopBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_soaringShop_basicAttack_var1_v1.ogg",
			"kr6_sfx_powers_soaringShop_basicAttack_var2_v1.ogg",
			"kr6_sfx_powers_soaringShop_basicAttack_var3_v1.ogg"
		}
	},
	PowersSoaringShopFrozotov = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_soaringShop_frozotov_var1_v1.ogg",
			"kr6_sfx_powers_soaringShop_frozotov_var2_v1.ogg",
			"kr6_sfx_powers_soaringShop_frozotov_var3_v1.ogg"
		}
	},
	PowersSoaringShopFatBoy = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_soaringShop_fatBoy_v1.ogg"
		}
	},
	PowersSoaringShopSummonTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_gnomeshop_taunt01_a.ogg"
		}
	},
	PowersSoaringShopMoveTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "random",
		source_group = "TAUNTS",
		files = {
			"kr_gnomeshop_taunt02_a.ogg",
			"kr_gnomeshop_taunt02_b.ogg"
		}
	},
	PowersThunderZapperSummonTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "random",
		source_group = "TAUNTS",
		files = {
			"kr_thunderzapper_taunt01_a.ogg",
			"kr_thunderzapper_taunt01_b.ogg",
			"kr_thunderzapper_taunt01_c.ogg"
		}
	},
	PowersThunderZapperBaseCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_thunderZapper_base_cast_v1.ogg"
		}
	},
	PowersThunderZapperOut = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_thunderZapper_base_out_v1.ogg"
		}
	},
	PowersThunderZapperRicochetCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_thunderZapper_ricochet_cast_var1_v1.ogg",
			"kr6_sfx_powers_thunderZapper_ricochet_cast_var2_v1.ogg",
			"kr6_sfx_powers_thunderZapper_ricochet_cast_var3_v1.ogg"
		}
	},
	PowersThunderZapperLightningStrikeCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_thunderZapper_lightningStrike_cast_var1_v1.ogg",
			"kr6_sfx_powers_thunderZapper_lightningStrike_cast_var2_v1.ogg",
			"kr6_sfx_powers_thunderZapper_lightningStrike_cast_var3_v1.ogg"
		}
	},
	PowersWintersongsWrathSummonTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_elorawintersong_taunt01_e.ogg"
		}
	},
	PowersWintersongsWrathBaseCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_wintersongsWrath_base_cast_v1.ogg"
		}
	},
	PowersWintersongsWrathBaseLoop = {
		loop = true,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_wintersongsWrath_base_loop_v1.ogg"
		}
	},
	PowersWintersongsWrathBaseLoopEnd = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_wintersongsWrath_base_loopEnd_v1.ogg"
		}
	},
	PowersWintersongsWrathSpikesCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_wintersongsWrath_spikes_cast_var1_v1.ogg",
			"kr6_sfx_powers_wintersongsWrath_spikes_cast_var2_v1.ogg",
			"kr6_sfx_powers_wintersongsWrath_spikes_cast_var3_v1.ogg",
			"kr6_sfx_powers_wintersongsWrath_spikes_cast_var4_v1.ogg"
		}
	},
	PowersWintersongsWrathGlobalCastLoopStart = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_wintersongsWrath_global_cast_loopStart_v1.ogg"
		}
	},
	PowersWintersongsWrathGlobalCastLoop = {
		loop = true,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_wintersongsWrath_global_cast_LOOP_v1.ogg"
		}
	},
	PowersWintersongsWrathGlobalCastLoopEnd = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_wintersongsWrath_global_cast_loopEnd_v1.ogg"
		}
	},
	PowersMusketeersSummonTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_acemusketeers_taunt01_a.ogg"
		}
	},
	PowersMusketeersMoveTaunt = {
		source_group = "TAUNTS",
		gain = 0.7,
		loop = false,
		ignore = 1,
		mode = "random",
		files = {
			"kr_acemusketeers_taunt01_a.ogg",
			"kr_acemusketeers_taunt02_a.ogg"
		}
	},
	PowersMusketeersBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_musketeers_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_powers_musketeers_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_powers_musketeers_basicAttack_cast_var3_v1.ogg"
		}
	},
	PowersMusketeersShrapnelRoundsCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_powers_musketeers_shrapnelRounds_cast_var1_v1.ogg",
			"kr6_sfx_powers_musketeers_shrapnelRounds_cast_var2_v1.ogg",
			"kr6_sfx_powers_musketeers_shrapnelRounds_cast_var2_v1.ogg"
		}
	},
	TowerArcherGarrisonTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_archergarrison_taunt02_c.ogg",
			"kr_voice_archergarrison_taunt03_b.ogg",
			"kr_voice_archergarrison_taunt04_d.ogg"
		}
	},
	TowerArcherGarrisonTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_voice_archergarrison_taunt01_b.ogg"
		}
	},
	TowerArcherGarrisonTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_archergarrison_taunt01_b.ogg"
		}
	},
	TowerArcherGarrisonSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_archergarrison_skill-a_c.ogg"
		}
	},
	TowerArcherGarrisonSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_archergarrison_skill-b_c.ogg"
		}
	},
	TowerArcherGarrisonSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_archergarrison_skill-c_b.ogg"
		}
	},
	TowerArcherGarrisonBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_archerGarrison_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_archerGarrison_basicAttack_cast_var3_v1.ogg",
			"kr6_sfx_towers_archerGarrison_basicAttack_cast_var4_v1.ogg",
			"kr6_sfx_towers_archerGarrison_basicAttack_cast_var5_v1.ogg",
			"kr6_sfx_towers_archerGarrison_basicAttack_cast_var6_v1.ogg"
		}
	},
	TowerArcherGarrisonTendonPierceCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		delay = 0.6,
		files = {
			"kr6_sfx_towers_archerGarrison_tendonPierce_cast_v1.ogg"
		}
	},
	TowerArcherGarrisonEyeInTheSkyCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_archerGarrison_eyeInTheSky_cast_v1.ogg"
		}
	},
	TowerArcherGarrisonMarkOfTheEagleCast = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_archerGarrison_markOfTheEagle_cast_v1.ogg"
		}
	},
	TowerArcherArrowFrenzyCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		delay = 0.5,
		files = {
			"kr6_sfx_towers_archerGarrison_arrowFrenzy_v1.ogg"
		}
	},
	TowerScholarMageTaunt = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_scholarmage_taunt02_b.ogg",
			"kr_voice_scholarmage_taunt03_c.ogg",
			"kr_voice_scholarmage_taunt04_b.ogg"
		}
	},
	TowerScholarMageTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 0.9,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_voice_scholarmage_taunt01_b.ogg"
		}
	},
	TowerScholarMageTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_scholarmage_taunt01_b.ogg"
		}
	},
	TowerScholarMageSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_scholarmage_skill-a_b.ogg"
		}
	},
	TowerScholarMageSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_scholarmage_skill-b_a.ogg"
		}
	},
	TowerScholarMageSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_scholarmage_skill-c_a.ogg"
		}
	},
	TowerScholarMageBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_towers_scholarMage_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_scholarMage_basicAttack_cast_var3_v1.ogg"
		}
	},
	TowerScholarMageTomeOfFlamesCast = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		delay = 0.2,
		files = {
			"kr6_sfx_towers_scholarMage_tomeOfFlames_cast_v1.ogg"
		}
	},
	TowerScholarMageTomeOfFlamesImpact = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_tomeOfFlames_impact_v1.ogg"
		}
	},
	TowerScholarMageScrollOfKnowledgeCast = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_scrollOfKnowledge_cast_v1.ogg"
		}
	},
	TowerScholarMageSpareCopiesCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_spareCopies_cast_var1_v1.ogg",
			"kr6_sfx_towers_scholarMage_spareCopies_cast_var2_v1.ogg",
			"kr6_sfx_towers_scholarMage_spareCopies_cast_var3_v1.ogg"
		}
	},
	TowerScholarMageSpareCopiesImpact = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_spareCopies_impact_var1_v1.ogg",
			"kr6_sfx_towers_scholarMage_spareCopies_impact_var2_v1.ogg",
			"kr6_sfx_towers_scholarMage_spareCopies_impact_var3_v1.ogg"
		}
	},
	TowerScholarMageSpareCopiesBolts = {
		loop = false,
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_spareCopies_bolts_var1_v1.ogg",
			"kr6_sfx_towers_scholarMage_spareCopies_bolts_var2_v1.ogg",
			"kr6_sfx_towers_scholarMage_spareCopies_bolts_var3_v1.ogg"
		}
	},
	TowerScholarArcaneMeteorCast = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_arcaneMeteor_cast_v1.ogg"
		}
	},
	TowerScholarArcaneMeteorImpact = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_scholarMage_arcaneMeteor_impact_v1.ogg"
		}
	},
	TowerRoyalCatapultTaunt = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_royalcatapult_taunt02_c.ogg",
			"kr_voice_royalcatapult_taunt03_c.ogg",
			"kr_voice_royalcatapult_taunt04_b.ogg"
		}
	},
	TowerRoyalCatapultTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 0.9,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_voice_royalcatapult_taunt01_d.ogg"
		}
	},
	TowerRoyalCatapultTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_royalcatapult_taunt01_d.ogg"
		}
	},
	TowerRoyalCatapultSkillATaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_royalcatapult_skill-a_c.ogg"
		}
	},
	TowerRoyalCatapultSkillBTaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_royalcatapult_skill-b_a.ogg"
		}
	},
	TowerRoyalCatapultSkillCTaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_royalcatapult_skill-c_a.ogg"
		}
	},
	TowerRoyalCatapultBasicAttackFire = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_towers_royalCatapult_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_royalCatapult_basicAttack_cast_var3_v1.ogg"
		}
	},
	TowerRoyalCatapultBasicAttackImpact = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_basicAttack_impact_var1_v1.ogg",
			"kr6_sfx_towers_royalCatapult_basicAttack_impact_var2_v1.ogg",
			"kr6_sfx_towers_royalCatapult_basicAttack_impact_var3_v1.ogg"
		}
	},
	TowerRoyalCatapultTarredZoneImpact = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_tarredZone_impact_var1_v1.ogg"
		}
	},
	TowerRoyalCatapultPowerballExplosion = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_powerball_explosion_var1_v1.ogg",
			"kr6_sfx_towers_royalCatapult_powerball_explosion_var2_v1.ogg",
			"kr6_sfx_towers_royalCatapult_powerball_explosion_var3_v1.ogg"
		}
	},
	TowerRoyalCatapultSecureTheAreaCast = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		delay = 0.5,
		files = {
			"kr6_sfx_towers_royalCatapult_secureTheArea_cast_v1.ogg"
		}
	},
	TowerRoyalCatapultSecureTheAreaTrigger = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_secureTheArea_trigger_op1_v1.ogg"
		}
	},
	TowerRoyalCatapultBlazingBallCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_blazingBall_cast_v1.ogg"
		}
	},
	TowerRoyalCatapultBlazingBallImpact = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_blazingBall_impact_roll_v1.ogg"
		}
	},
	TowerKnightsOrderTaunt = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_knightsorder_taunt02_c.ogg",
			"kr_voice_knightsorder_taunt03_a.ogg",
			"kr_voice_knightsorder_taunt04_a.ogg"
		}
	},
	TowerKnightsOrderTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 0.9,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_voice_knightsorder_taunt01_a.ogg"
		}
	},
	TowerKnightsOrderTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_knightsorder_taunt01_a.ogg"
		}
	},
	TowerKnightsOrderSkillATaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_knightsorder_skill-a_c.ogg"
		}
	},
	TowerKnightsOrderSkillBTaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_knightsorder_skill-b_d.ogg"
		}
	},
	TowerKnightsOrderSkillCTaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_knightsorder_skill-c_c.ogg"
		}
	},
	TowerKnightsOrderResilienceCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		delay = 0.5,
		files = {
			"kr6_sfx_towers_knightsOrder_resilience_cast_op2_v1.ogg"
		}
	},
	TowerKnightsOrderLastStandCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_knightsOrder_lastStand_cast_var1_v1.ogg",
			"kr6_sfx_towers_knightsOrder_lastStand_cast_var2_v1.ogg",
			"kr6_sfx_towers_knightsOrder_lastStand_cast_var3_v1.ogg"
		}
	},
	TowerKnightsOrderUnitDeath = {
		loop = false,
		mode = "sequence",
		gain = 1.5,
		source_group = "SFX",
		files = {
			"kra_sfx_tower_paladinCovenant_unitDeath_var1_v1.ogg",
			"kra_sfx_tower_paladinCovenant_unitDeath_var2_v1.ogg",
			"kra_sfx_tower_paladinCovenant_unitDeath_var3_v1.ogg"
		}
	},
	TowerElvenRangerTaunt = {
		loop = false,
		gain = 1,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_elveneliteranger_taunt02_b.ogg",
			"kr_voice_elveneliteranger_taunt03_c.ogg",
			"kr_voice_elveneliteranger_taunt04_a.ogg"
		}
	},
	TowerElvenRangerTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_voice_elveneliteranger_taunt01_a.ogg"
		}
	},
	TowerElvenRangerTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_elveneliteranger_taunt01_a.ogg"
		}
	},
	TowerElvenRangerSkillATaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_voice_elveneliteranger_skill-a_a.ogg"
		}
	},
	TowerElvenRangerSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_elveneliteranger_skill-b_c.ogg"
		}
	},
	TowerElvenRangerSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_elveneliteranger_skill-c_a.ogg"
		}
	},
	TowerElvenRangerPoisonTipArrowImpact = {
		loop = false,
		mode = "sequence",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_elvenEliteRangers_poisonTipArrow_impact_var1_v1.ogg",
			"kr6_sfx_towers_elvenEliteRangers_poisonTipArrow_impact_var2_v1.ogg",
			"kr6_sfx_towers_elvenEliteRangers_poisonTipArrow_impact_var3_v1.ogg"
		}
	},
	TowerElvenRangerBrambleShotRootGrowth = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_elvenEliteRangers_brambleShot_rootsGrowth_v1.ogg"
		}
	},
	TowerElvenRangerWoodlandTrickImpact = {
		loop = false,
		mode = "sequence",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_elvenEliteRangers_woodlandTrick_impact_var1_v1.ogg",
			"kr6_sfx_towers_elvenEliteRangers_woodlandTrick_impact_var2_v1.ogg",
			"kr6_sfx_towers_elvenEliteRangers_woodlandTrick_impact_var3_v1.ogg"
		}
	},
	TowerElvenRangerMercilessAimCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_elvenEliteRangers_mercilessAim_cast_v1.ogg"
		}
	},
	TowerDwarvenCulverinTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_dwarvenculverin_taunt02_a.ogg",
			"kr_voice_dwarvenculverin_taunt03_c.ogg",
			"kr_voice_dwarvenculverin_taunt04_c.ogg"
		}
	},
	TowerDwarvenCulverinTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_voice_dwarvenculverin_taunt01_c.ogg"
		}
	},
	TowerDwarvenCulverinTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_voice_dwarvenculverin_taunt01_c.ogg"
		}
	},
	TowerDwarvenCulverinSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_dwarvenculverin_skill_a_c.ogg"
		}
	},
	TowerDwarvenCulverinSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_dwarvenculverin_skill_b_a.ogg"
		}
	},
	TowerDwarvenCulverinSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_voice_dwarvenculverin_skill_c_c.ogg"
		}
	},
	TowerCulverinBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_dwarvenCulverin_basicAttack_var1_v1.ogg",
			"kr6_sfx_towers_dwarvenCulverin_basicAttack_var2_v1.ogg",
			"kr6_sfx_towers_dwarvenCulverin_basicAttack_var3_v1.ogg"
		}
	},
	TowerCulverinSulfurBlastCannonUpwards = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_dwarvenCulverin_sulfurBlast_cannonUpwards_v1.ogg"
		}
	},
	TowerCulverinSulfurBlastCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_dwarvenCulverin_sulfurBlast_cast_v1.ogg"
		}
	},
	TowerCulverinSulfurBlastImpact = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_dwarvenCulverin_sulfurBlast_impact_v1.ogg"
		}
	},
	TowerCulverinFullThrottleCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_dwarvenCulverin_fullThrottle_cast_v1.ogg"
		}
	},
	TowerCulverinRedHotLeadCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_dwarvenCulverin_redHotLead_cast_var1_v1.ogg",
			"kr6_sfx_towers_dwarvenCulverin_redHotLead_cast_var2_v1.ogg",
			"kr6_sfx_towers_dwarvenCulverin_redHotLead_cast_var3_v1.ogg"
		}
	},
	TowerSunrayMasterTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_sunraymaster_taunt02_a.ogg",
			"kr_sunraymaster_taunt03_a.ogg",
			"kr_sunraymaster_taunt04_b.ogg"
		}
	},
	TowerSunrayMasterTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_sunraymaster_taunt_b.ogg"
		}
	},
	TowerSunrayMasterTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_sunraymaster_taunt_b.ogg"
		}
	},
	TowerSunrayMasterSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_sunraymaster_skill-a_b.ogg"
		}
	},
	TowerSunrayMasterSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_sunraymaster_skill-b_a.ogg"
		}
	},
	TowerSunrayMasterSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_sunraymaster_skill-c_a.ogg"
		}
	},
	TowerSunrayMasterRapidFireBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.45,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_basicAttack_rapidFire_var1_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_basicAttack_rapidFire_var2_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_basicAttack_rapidFire_var3_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_basicAttack_rapidFire_var4_v1.ogg"
		}
	},
	TowerSunrayMasterRayLoopStart = {
		loop = false,
		gain = 0.65,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_basicAttack_ray_loopStart_v1.ogg"
		}
	},
	TowerSunrayMasterRayCast = {
		loop = true,
		gain = 0.65,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_basicAttack_ray_cast_v1.ogg"
		}
	},
	TowerSunrayMasterLoopEnd = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_basicAttack_ray_loopEnd_v1.ogg"
		}
	},
	TowerSunrayMasterExoburstCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_exoburst_cast_var1_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_exoburst_cast_var2_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_exoburst_cast_var3_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_exoburst_cast_var4_v1.ogg"
		}
	},
	TowerSunrayOverchargeCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_overcharge_cast_v1.ogg"
		}
	},
	TowerMinorElementalsCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_minorElementals_cast_op1_v1.ogg"
		}
	},
	TowerSunrayMasterChangeModeRapidFire = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_changeMode_rapidFire_op2_v1.ogg"
		}
	},
	TowerSunrayMasterChangeModeRay = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_changeMode_ray_v1.ogg"
		}
	},
	TowerSunrayMasterRadiantSmiteCharge = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_radiantSmite_charge_v1.ogg"
		}
	},
	TowerSunrayMasterRadiantSmiteImpact = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sunrayMaster_radiantSmite_impact_var1_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_radiantSmite_impact_var2_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_radiantSmite_impact_var3_v1.ogg",
			"kr6_sfx_towers_sunrayMaster_radiantSmite_impact_var4_v1.ogg"
		}
	},
	TowerLightPriestessTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_lightpriestess_taunt02_a.ogg",
			"kr_lightpriestess_taunt03_c.ogg",
			"kr_lightpriestess_taunt04_c.ogg"
		}
	},
	TowerLightPriestessTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_lightpriestess_taunt_b.ogg"
		}
	},
	TowerLightPriestessTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_lightpriestess_taunt_b.ogg"
		}
	},
	TowerLightPriestessSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_lightpriestess_skill-a_b.ogg"
		}
	},
	TowerLightPriestessSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_lightpriestess_skill-b_e.ogg"
		}
	},
	TowerLightPriestessSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_lightpriestess_skill-c_b.ogg"
		}
	},
	TowerLightPriestessBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_lightPriestess_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_towers_lightPriestess_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_lightPriestess_basicAttack_cast_var3_v1.ogg"
		}
	},
	TowerLightPriestessBasicBuffActive = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_lightPriestess_basicBuff_active_v1.ogg"
		}
	},
	TowerLightPriestessSanctuaryCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_lightPriestess_sanctuary_cast_v1.ogg"
		}
	},
	TowerLightPriestessCircleOfSilenceCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_lightPriestess_circleOfSilence_cast_op1_v1.ogg"
		}
	},
	TowerLightPriestessPanaceaCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_lightPriestess_panacea_cast_v1.ogg"
		}
	},
	TowerLightPriestessAvatarOfLightCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_lightPriestess_avatarOfLight_cast.ogg"
		}
	},
	TowerLightPriestessAvatarOfLightRay = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_lightPriestess_avatarOfLight_ray_var1_v1.ogg",
			"kr6_sfx_towers_lightPriestess_avatarOfLight_ray_var2_v1.ogg",
			"kr6_sfx_towers_lightPriestess_avatarOfLight_ray_var3_v1.ogg"
		}
	},
	TowerIronbarkTreantTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_ironbarktreant_taunt02_a.ogg",
			"kr_ironbarktreant_taunt03_b.ogg",
			"kr_ironbarktreant_taunt04_b.ogg"
		}
	},
	TowerIronbarkTreantTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_ironbarktreant_taunt_b.ogg"
		}
	},
	TowerIronbarkTreantTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_ironbarktreant_taunt_b.ogg"
		}
	},
	TowerIronbarkTreantSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_ironbarktreant_skill-a_c.ogg"
		}
	},
	TowerIronbarkTreantSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_ironbarktreant_skill-b_c.ogg"
		}
	},
	TowerIronbarkTreantSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_ironbarktreant_skill-c_a.ogg"
		}
	},
	TowerIronbarkTreantBasicAttackCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_basicAttack_cast_v1.ogg"
		}
	},
	TowerIronbarkTreantUprootCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_uproot_cast_v1.ogg"
		}
	},
	TowerIronbarkTreantPlantCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_plant_cast_v1.ogg"
		}
	},
	TowerIronbarkTreantDeath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_death_op1_v1.ogg"
		}
	},
	TowerIronbarkTreantHayFeverCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_hayFever_cast_v1.ogg"
		}
	},
	TowerIronbarkTreantNaturesHandCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_naturesHand_cast_v1.ogg"
		}
	},
	TowerIronbarkTreantGnarlyRootsCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_gnarlyRoots_cast_v1.ogg"
		}
	},
	TowerIronbarkTreantCrankySeedlingsCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_crankySeedlings_cast_v1.ogg"
		}
	},
	TowerIronbarkTreantCrankySeedlingsImpact = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_crankySeedlings_impact_v1.ogg"
		}
	},
	TowerIronbarkTreantCrankySeedlingsExplosion = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_crankySeedlings_explosion_v1.ogg"
		}
	},
	TowerIronbarkTreantCrankySeedlingsDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_ironbarkTreant_crankySeedlings_death_var1_v1.ogg",
			"kr6_sfx_towers_ironbarkTreant_crankySeedlings_death_var2_v1.ogg",
			"kr6_sfx_towers_ironbarkTreant_crankySeedlings_death_var3_v1.ogg"
		}
	},
	TowerWildcatHuntressesTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_wildcathuntress_taunt02_c.ogg",
			"kr_wildcathuntress_taunt03_a.ogg",
			"kr_wildcathuntress_taunt04_d.ogg"
		}
	},
	TowerWildcatHuntressesTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_wildcathuntress_taunt_e.ogg"
		}
	},
	TowerWildcatHuntressesTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_wildcathuntress_taunt_e.ogg"
		}
	},
	TowerWildcatHuntressesSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_wildcathuntress_skill-c_a.ogg"
		}
	},
	TowerWildcatHuntressesSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_wildcathuntress_skill-b_c.ogg"
		}
	},
	TowerWildcatHuntressesSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_wildcathuntress_skill-a_e.ogg"
		}
	},
	TowerWildcatHuntressesSilverGlaivesCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_silverGlaives_cast_var1_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_silverGlaives_cast_var2_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_silverGlaives_cast_var3_v1.ogg"
		}
	},
	TowerWildcatHuntressesSilverGlaivesBounce = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_silverGlaives_bounce_var1_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_silverGlaives_bounce_var2_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_silverGlaives_bounce_var3_v1.ogg"
		}
	},
	TowerWildcatHuntressesGrievousBiteCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_grievousBite_cast_var1_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_grievousBite_cast_var2_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_grievousBite_cast_var3_v1.ogg"
		}
	},
	TowerWildcatHuntressesRainingArrowsCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_rainingArrows_cast_v1.ogg"
		}
	},
	TowerWildcatHuntressesRainingArrowsArrow = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_rainingArrows_arrow_var1_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_rainingArrows_arrow_var2_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_rainingArrows_arrow_var3_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_rainingArrows_arrow_var4_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_rainingArrows_arrow_var5_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_rainingArrows_arrow_var6_v1.ogg"
		}
	},
	TowerWildcatHuntressesSneakyClawsCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_sneakyClaws_cast_op3_v1.ogg"
		}
	},
	TowerWildcatHuntressesSneakyClawsPantherHit = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_sneakyClaws_pantherHit_var1_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_sneakyClaws_pantherHit_var2_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_sneakyClaws_pantherHit_var3_v1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_sneakyClaws_pantherHit_var4_v1.ogg"
		}
	},
	TowerWildcatHuntressesDeath = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_wildcatHuntresses_death_var1_op1.ogg",
			"kr6_sfx_towers_wildcatHuntresses_death_var2_op2.ogg",
			"kr6_sfx_towers_wildcatHuntresses_death_var3_op2.ogg"
		}
	},
	TowerAlchemistShackTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_alchemistshack_taunt02_a.ogg",
			"kr_alchemistshack_taunt03_b.ogg",
			"kr_alchemistshack_taunt04_a.ogg"
		}
	},
	TowerAlchemistShackTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_alchemistshack_taunt01_b.ogg"
		}
	},
	TowerAlchemistShackTauntLevel4 = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_alchemistshack_taunt01_b.ogg"
		}
	},
	TowerAlchemistShackSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_alchemistshack_skill-a_c.ogg"
		}
	},
	TowerAlchemistShackSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_alchemistshack_skill-b_a.ogg"
		}
	},
	TowerAlchemistShackSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_alchemistshack_skill-c_b.ogg"
		}
	},
	TowerAlchemistShackBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_towers_alchemistShack_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_alchemistShack_basicAttack_cast_var3_v1.ogg"
		}
	},
	TowerAlchemistShackBasicAttackImpact = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_basicAttack_impact_var1_v1.ogg",
			"kr6_sfx_towers_alchemistShack_basicAttack_impact_var2_v1.ogg",
			"kr6_sfx_towers_alchemistShack_basicAttack_impact_var3_v1.ogg"
		}
	},
	TowerAlchemistShackStickySpillageCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_stickySpillage_cast_var1_v1.ogg",
			"kr6_sfx_towers_alchemistShack_stickySpillage_cast_var2_v1.ogg",
			"kr6_sfx_towers_alchemistShack_stickySpillage_cast_var3_v1.ogg",
			"kr6_sfx_towers_alchemistShack_stickySpillage_cast_var4_v1.ogg"
		}
	},
	TowerAlchemistShackTestSubjectSummon = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_testSubject_summon_v1.ogg"
		}
	},
	TowerAlchemistShackTestSubjectDrink = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_testSubject_drink_v1.ogg"
		}
	},
	TowerAlchemistShackTestSubjectPoofIn = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_testSubject_poof_IN_op3_v1.ogg"
		}
	},
	TowerAlchemistShackTestSubjectPoofOut = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_testSubject_poof_OUT_v1.ogg"
		}
	},
	TowerAlchemistShackPerfectedFormulaPrepare = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_perfectedFormula_prepare_v1.ogg"
		}
	},
	TowerAlchemistShackPerfectedFormulaCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_perfectedFormula_impact_var1_v1.ogg",
			"kr6_sfx_towers_alchemistShack_perfectedFormula_impact_var2_v1.ogg",
			"kr6_sfx_towers_alchemistShack_perfectedFormula_impact_var3_v1.ogg"
		}
	},
	TowerAlchemistShackMagnumOpusCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_magnumOpus_cast_v1.ogg"
		}
	},
	TowerAlchemistShackMagnumOpusTransform = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_magnumOpus_transform_v1.ogg"
		}
	},
	TowerAlchemistShackMagnumOpusPigBreak = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_alchemistShack_magnumOpus_pigBreak_op1_v1.ogg",
			"kr6_sfx_towers_alchemistShack_magnumOpus_pigBreak_op2_v1.ogg"
		}
	},
	TowerGoldProspectorsTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_aceprospectors_taunt01_a.ogg",
			"kr_aceprospectors_taunt03_a.ogg",
			"kr_aceprospectors_taunt04_c.ogg"
		}
	},
	TowerGoldProspectorsTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_aceprospectors_taunt02_c.ogg"
		}
	},
	TowerGoldProspectorskSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_aceprospectors_skill-a_c.ogg"
		}
	},
	TowerGoldProspectorsSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_aceprospectors_skill-b_b.ogg"
		}
	},
	TowerGoldProspectorsSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_aceprospectors_skill-c_c.ogg"
		}
	},
	TowerGoldProspectorsBlockCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_goldProspectors_block_cast_var1_v1.ogg",
			"kr6_sfx_towers_goldProspectors_block_cast_var2_v1.ogg",
			"kr6_sfx_towers_goldProspectors_block_cast_var3_v1.ogg"
		}
	},
	TowerGoldProspectorsEmergingBlastCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_goldProspectors_emergingBlast_impact_var1_v1.ogg",
			"kr6_sfx_towers_goldProspectors_emergingBlast_impact_var2_v1.ogg",
			"kr6_sfx_towers_goldProspectors_emergingBlast_impact_var3_v1.ogg"
		}
	},
	TowerGoldProspectorsMadSpelunkersCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_goldProspectors_madSpelunkers_cast_op1_v1.ogg"
		}
	},
	TowerGoldProspectorsMadSpelunkersImpact = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_goldProspectors_madSpelunkers_impact_v1.ogg"
		}
	},
	TowerArcaneForgerTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_arcaneforger_taunt02_c.ogg",
			"kr_arcaneforger_taunt03_c.ogg",
			"kr_arcaneforger_taunt04_a.ogg"
		}
	},
	TowerArcaneForgerTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 1,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_arcaneforger_taunt01_b.ogg"
		}
	},
	TowerArcaneForgerSkillATaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_arcaneforger_skill-a_c.ogg"
		}
	},
	TowerArcaneForgerSkillBTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_arcaneforger_skill-b_a.ogg"
		}
	},
	TowerArcaneForgerSkillCTaunt = {
		loop = false,
		gain = 0.7,
		source_group = "TAUNTS",
		files = {
			"kr_arcaneforger_skill-c_a.ogg"
		}
	},
	TowerArcaneForgerBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_towers_arcaneForger_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_arcaneForger_basicAttack_cast_var3_v1.ogg"
		}
	},
	TowerArcaneForgerBasicAttackImpact = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_basicAttack_impact_var1_v1.ogg",
			"kr6_sfx_towers_arcaneForger_basicAttack_impact_var2_v1.ogg",
			"kr6_sfx_towers_arcaneForger_basicAttack_impact_var3_v1.ogg"
		}
	},
	TowerArcaneForgerBasicAttackCharge = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_basicAttack_charge_var1_v1.ogg",
			"kr6_sfx_towers_arcaneForger_basicAttack_charge_var2_v1.ogg",
			"kr6_sfx_towers_arcaneForger_basicAttack_charge_var3_v1.ogg"
		}
	},
	TowerArcaneForgerSliveringDiscsCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_sliveringDiscs_cast_v1.ogg"
		}
	},
	TowerArcaneForgerSliveringDiscsSpin = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_sliveringDiscs_spin_v1.ogg"
		}
	},
	TowerArcaneForgerPrismaticSentriesCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_prismaticSentries_cast_v1.ogg"
		}
	},
	TowerArcaneForgerPrismaticSentriesRayOneShot = {
		loop = false,
		gain = 0.65,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_prismaticSentries_ray_oneShot_v1.ogg"
		}
	},
	TowerArcaneForgerPrismaticSentriesRayLoop = {
		source_group = "SFX",
		gain = 0.65,
		loop = false,
		interruptible = true,
		files = {
			"kr6_sfx_towers_arcaneForger_prismaticSentries_ray_LOOP_v1.ogg"
		}
	},
	TowerArcaneForgerPrismaticSentriesRayLoopEnd = {
		loop = false,
		gain = 0.65,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_prismaticSentries_ray_loopEND_v1.ogg"
		}
	},
	TowerArcaneForgerHardlighPrisonCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_hardlightPrison_cast_v1.ogg"
		}
	},
	TowerArcaneForgerArcaneMawCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_arcaneForger_arcaneMaw_cast_v1.ogg"
		}
	},
	TowerCursedCrossbowsTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_cursedcrossbow_taunt02_a.ogg",
			"kr_cursedcrossbow_taunt03_b.ogg",
			"kr_cursedcrossbow_taunt04_a.ogg"
		}
	},
	TowerCursedCrossbowsTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_cursedcrossbow_taunt01_c.ogg"
		}
	},
	TowerCursedCrossbowsSkillATaunt = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_cursedcrossbow_skill-a_c.ogg"
		}
	},
	TowerCursedCrossbowsSkillBTaunt = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_cursedcrossbow_skill-b_c.ogg"
		}
	},
	TowerCursedCrossbowsSkillCTaunt = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_cursedcrossbow_skill-c_e.ogg"
		}
	},
	TowerCursedCrossbowsBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_cursedCrossbows_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_basicAttack_cast_var3_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_basicAttack_cast_var4_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_basicAttack_cast_var5_v1.ogg"
		}
	},
	TowerCursedCrossbowsCorruptFrenzyCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_cursedCrossbows_corruptFrenzy_cast_v1.ogg"
		}
	},
	TowerCursedCrossbowsCorruptFrenzyAttack = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_cursedCrossbows_corruptFrenzy_attack_var1_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_corruptFrenzy_attack_var2_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_corruptFrenzy_attack_var3_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_corruptFrenzy_attack_var4_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_corruptFrenzy_attack_var5_v1.ogg"
		}
	},
	TowerCursedCrossbowsFearFactorCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_cursedCrossbows_fearFactor_cast_var1_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_fearFactor_cast_var2_v1.ogg",
			"kr6_sfx_towers_cursedCrossbows_fearFactor_cast_var3_v1.ogg"
		}
	},
	TowerCursedCrossbowsCursedBoltCast = {
		source_group = "SFX",
		gain = 0.7,
		loop = false,
		delay = 0.55,
		files = {
			"kr6_sfx_towers_cursedCrossbows_cursedBolt_cast_v1.ogg"
		}
	},
	TowerCursedCrossbowsFallenKnightCast = {
		source_group = "SFX",
		gain = 0.7,
		loop = false,
		delay = 0.1,
		files = {
			"kr6_sfx_towers_cursedCrossbows_fallenKnight_cast_v1.ogg"
		}
	},
	TowerSentryWatchtowerTaunt = {
		loop = false,
		gain = 0.8,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_sentrywatchtower_taunt02_b.ogg",
			"kr_sentrywatchtower_taunt03_c.ogg",
			"kr_sentrywatchtower_taunt04_c.ogg"
		}
	},
	TowerSentryWatchtowerTauntSelect = {
		loop = false,
		mode = "sequence",
		gain = 0.8,
		source_group = "TAUNTS",
		interruptible = true,
		files = {
			"kr_sentrywatchtower_taunt01_c.ogg"
		}
	},
	TowerSentryWatchtowerSkillATaunt = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_sentrywatchtower_skill-a_b.ogg"
		}
	},
	TowerSentryWatchtowerSkillBTaunt = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_sentrywatchtower_skill-b_c.ogg"
		}
	},
	TowerSentryWatchtowerSkillCTaunt = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_sentrywatchtower_skill-c_b.ogg"
		}
	},
	TowerSentryWatchtowerBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sentryWatchtower_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_towers_sentryWatchtower_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_towers_sentryWatchtower_basicAttack_cast_var3_v1.ogg"
		}
	},
	TowerSentryWatchtowerBattleMomentumCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sentryWatchtower_battleMomentum_cast_op1_v1.ogg"
		}
	},
	TowerSentryWatchtowerMortalWoundCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sentryWatchtower_mortalWound_cast_v1.ogg"
		}
	},
	TowerSentryWatchtowerGuardianHoundCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sentryWatchtower_guardianHound_cast_v1.ogg"
		}
	},
	TowerSentryWatchtowerGuardianHoundAttack = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sentryWatchtower_guardianHound_attack_oneShot_v1.ogg"
		}
	},
	TowerSentryWatchtowerTripleTapCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_sentryWatchtower_tripleTap_cast_v1.ogg"
		}
	},
	TowerArchersKr1Taunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Archer_Ready.ogg",
			"Archer_Taunt1.ogg",
			"Archer_Taunt2.ogg"
		}
	},
	TowerRangerKr1Taunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Ranger_Ready.ogg",
			"Ranger_Taunt1.ogg",
			"Ranger_Taunt2.ogg"
		}
	},
	TowerRangerKr1PoisonTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Ranger_Taunt1.ogg"
		}
	},
	TowerRangerKr1ThornTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Ranger_Taunt2.ogg"
		}
	},
	TowerRangerKr1Thorn = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"Sound_Thorn.ogg"
		}
	},
	TowerMusketeersKr1Taunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Muskateer_Ready.ogg",
			"Muskateer_Event1.ogg",
			"Muskateer_Event2.ogg"
		}
	},
	TowerMusketeersKr1ShrapnelTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Muskateer_Event1.ogg"
		}
	},
	TowerMusketeersKr1SniperTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Muskateer_Snipe.ogg"
		}
	},
	TowerMusketeersKr1ShotgunCast = {
		loop = false,
		gain = 0.8,
		source_group = "BULLETS",
		files = {
			"Sound_Shootgun.ogg"
		}
	},
	TowerMusketeersKr1ShrapnelCast = {
		loop = false,
		gain = 0.15,
		source_group = "BULLETS",
		files = {
			"Sound_Shrapnel.ogg"
		}
	},
	TowerMusketeersKr1SniperCast = {
		loop = false,
		gain = 0.8,
		source_group = "BULLETS",
		files = {
			"Sound_Sniper.ogg"
		}
	},
	TowerMageKr1Taunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Mage_Ready.ogg",
			"Mage_Taunt1.ogg",
			"Mage_Taunt2.ogg"
		}
	},
	TowerArcaneKr1Taunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Arcane_Ready.ogg",
			"Arcane_Taunt1.ogg",
			"Arcane_Taunt2.ogg"
		}
	},
	TowerArcaneKr1RayCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"Sound_RayArcane.ogg"
		}
	},
	TowerArcaneKr1DisintegrateTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Arcane_Taunt2.ogg"
		}
	},
	TowerArcaneKr1DisintegrateCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"Sound_ArcaneDesintegrate.ogg"
		}
	},
	TowerArcaneKr1TeleportTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Arcane_Taunt1.ogg"
		}
	},
	TowerArcaneKr1TeleportCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"Sound_Teleport.ogg"
		}
	},
	TowerSorcererKr1Taunt = {
		loop = false,
		mode = "sequence",
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Sorcerer_Ready.ogg",
			"Sorcerer_Taunt1.ogg",
			"Sorcerer_Taunt2.ogg"
		}
	},
	TowerSorcererKr1AshesToAshesTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Sorcerer_Taunt2.ogg"
		}
	},
	TowerSorcererKr1Attack = {
		loop = false,
		gain = 0.68,
		source_group = "BULLETS",
		files = {
			"Sound_Sorcerer.ogg"
		}
	},
	TowerSorcererKr1PolymporphCast = {
		loop = false,
		gain = 0.68,
		source_group = "SFX",
		files = {
			"Sound_Polimorph.ogg"
		}
	},
	TowerSorcererKr1Sheep = {
		loop = false,
		gain = 0.68,
		source_group = "SFX",
		files = {
			"Sound_Sheep.ogg"
		}
	},
	TowerSorcererKr1RockElementalDeath = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Sound_RockElementalDeath.ogg"
		}
	},
	TowerSorcererKr1RockElementalRally = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Sound_RockElementalRally.ogg"
		}
	},
	TowerBarracksKr1Taunt = {
		loop = false,
		mode = "sequence",
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Barrack_Ready.ogg",
			"Barrack_Taunt1.ogg",
			"Barrack_Taunt2.ogg",
			"Barrack_Move.ogg"
		}
	},
	TowerPaladinsKr1Taunt = {
		loop = false,
		mode = "sequence",
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Paladin_Ready.ogg",
			"Paladin_Taunt1.ogg",
			"Paladin_Taunt2.ogg",
			"Paladin_Move.ogg"
		}
	},
	TowerPaladinsKr1PaladinHealingTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Paladin_Ready.ogg"
		}
	},
	TowerPaladinsKr1HolyStrikeTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Paladin_Taunt1.ogg"
		}
	},
	TowerPaladinsKr1ShieldTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Paladin_Taunt2.ogg"
		}
	},
	TowerPaladinsKr1HealingCast = {
		loop = false,
		gain = 0.68,
		source_group = "SFX",
		files = {
			"Sound_PaladinHeal.ogg"
		}
	},
	TowerBarbariansKr1Taunt = {
		loop = false,
		mode = "sequence",
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Barbarian_Ready.ogg",
			"Barbarian_Taunt1.ogg",
			"Barbarian_Taunt2.ogg",
			"Barbarian_Move.ogg"
		}
	},
	TowerBarbariansKr1DoubleAxesTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Barbarian_Move.ogg"
		}
	},
	TowerBarbariansKr1AxeSound = {
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_BattleAxe.ogg"
		}
	},
	TowerBarbariansKr1ThrowingAxesTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Barbarian_Ready.ogg"
		}
	},
	TowerBarbarianKr1TwisterTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Barbarian_Taunt1.ogg"
		}
	},
	TowerEngineersKr1Taunt = {
		loop = false,
		mode = "sequence",
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Artillery_Ready.ogg",
			"Artillery_Taunt1.ogg",
			"Artillery_Taunt2.ogg"
		}
	},
	TowerBfgKr1Taunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"BFG_Ready.ogg"
		}
	},
	TowerBfgClusterTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"BFG_Taunt1.ogg"
		}
	},
	TowerBfgMissileTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"BFG_Taunt2.ogg"
		}
	},
	TowerBfgKr1RocketLaunch = {
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_RocketLaunt.ogg"
		}
	},
	TowerTeslaKr1Taunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Tesla_Ready.ogg"
		}
	},
	TowerTeslaKr1OverchargeTaunt = {
		loop = false,
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Tesla_Taunt1.ogg"
		}
	},
	TowerTeslaKr1ChargedBoltTaunt = {
		loop = false,
		mode = "sequence",
		gain = 0.6,
		source_group = "TAUNTS",
		files = {
			"Tesla_Taunt2a.ogg",
			"Tesla_Taunt2b.ogg",
			"Tesla_Taunt2c.ogg"
		}
	},
	TowerTeslaKr1Attack = {
		loop = false,
		gain = 0.6,
		source_group = "BULLETS",
		files = {
			"Sound_Tesla_attack_1.ogg",
			"Sound_Tesla_attack_2.ogg"
		}
	},
	ReinforcementTaunt = {
		loop = false,
		gain = 0.6,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_reinforcements_taunt01_a.ogg",
			"kr_voice_reinforcements_taunt01_f.ogg",
			"kr_voice_reinforcements_taunt02_c.ogg",
			"kr_voice_reinforcements_taunt02_e.ogg",
			"kr_voice_reinforcements_taunt03_a.ogg",
			"kr_voice_reinforcements_taunt03_f.ogg"
		}
	},
	EnemyBanditDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_bandit_death_var1_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var2_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var3_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var4_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var5_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var6_v1.ogg"
		}
	},
	EnemyBlackguardDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_bandit_death_var1_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var2_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var3_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var4_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var5_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var6_v1.ogg"
		}
	},
	EnemyShadowArcherDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_bandit_death_var1_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var2_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var3_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var4_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var5_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var6_v1.ogg"
		}
	},
	EnemyShadowBladesDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_shadowblades_death_var1_v1.ogg",
			"kr6_sfx_enemy_shadowblades_death_var2_v1.ogg",
			"kr6_sfx_enemy_shadowblades_death_var3_v1.ogg",
			"kr6_sfx_enemy_shadowblades_death_var4_v1.ogg"
		}
	},
	EnemyCrowcallerDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_crowcaller_death_var1_v1.ogg",
			"kr6_sfx_enemy_crowcaller_death_var2_v1.ogg",
			"kr6_sfx_enemy_crowcaller_death_var3_v1.ogg"
		}
	},
	EnemyCrowDeath = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_crow_death_var1_v1.ogg",
			"kr6_sfx_enemy_crow_death_var2_v1.ogg",
			"kr6_sfx_enemy_crow_death_var3_v1.ogg"
		}
	},
	EnemyHeadhunterDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_headhunter_death_var2_v1.ogg",
			"kr6_sfx_enemy_headhunter_death_var3_v1.ogg",
			"kr6_sfx_enemy_headhunter_death_var4_v1.ogg"
		}
	},
	EnemyGoblinDeath = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_goblin_death_var1_v1.ogg",
			"kr6_sfx_enemy_goblin_death_var2_v1.ogg",
			"kr6_sfx_enemy_goblin_death_var3_v1.ogg"
		}
	},
	EnemyOrcShamanDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_goblin_death_var1_v1.ogg",
			"kr6_sfx_enemy_goblin_death_var2_v1.ogg",
			"kr6_sfx_enemy_goblin_death_var3_v1.ogg"
		}
	},
	EnemyOrcWarriorDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_orcWarrior_death_var1_v1.ogg",
			"kr6_sfx_enemy_orcWarrior_death_var4_v1.ogg",
			"kr6_sfx_enemy_orcWarrior_death_var5_v1.ogg"
		}
	},
	EnemyOrcWildlingDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_orcWarrior_death_var1_v1.ogg",
			"kr6_sfx_enemy_orcWarrior_death_var4_v1.ogg",
			"kr6_sfx_enemy_orcWarrior_death_var5_v1.ogg"
		}
	},
	EnemyWulfDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_wulf_death_var1_v1.ogg",
			"kr6_sfx_enemy_wulf_death_var2_v1.ogg",
			"kr6_sfx_enemy_wulf_death_var3_v1.ogg"
		}
	},
	EnemyWorgDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_wulf_death_var1_v1.ogg",
			"kr6_sfx_enemy_wulf_death_var2_v1.ogg",
			"kr6_sfx_enemy_wulf_death_var3_v1.ogg"
		}
	},
	EnemyRiderGoblinDeath = {
		loop = false,
		mode = "random",
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_riderGoblin_death_var1_op1.ogg",
			"kr6_sfx_enemy_riderGoblin_death_var2_op1.ogg",
			"kr6_sfx_enemy_riderGoblin_death_var3_op1_v1.ogg"
		}
	},
	EnemyOgreDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_ogre_death_var1_v1.ogg",
			"kr6_sfx_enemy_ogre_death_var3_v1.ogg",
			"kr6_sfx_enemy_ogre_death_var4_v1.ogg"
		}
	},
	EnemyShadowBladesSmokeBombCast = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_shadowBlades_smokebomb_var1_v1.ogg",
			"kr6_sfx_enemy_shadowBlades_smokebomb_var2_v1.ogg",
			"kr6_sfx_enemy_shadowBlades_smokebomb_var3_v1.ogg"
		}
	},
	EnemyHeadhunterInstakillCast = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		delay = 0.3,
		files = {
			"kr6_sfx_enemy_headhunter_instakill_v1.ogg"
		}
	},
	EnemyCrowcallerCrowSummon = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_crowcaller_crowSummon_var1_v1.ogg",
			"kr6_sfx_enemy_crowcaller_crowSummon_var2_v1.ogg",
			"kr6_sfx_enemy_crowcaller_crowSummon_var3_v1.ogg"
		}
	},
	EnemyOrcWarriorRageCast = {
		loop = false,
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_orcWarrior_rage_op2_v1.ogg"
		}
	},
	EnemyOrcShamanHealingCast = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_orcShaman_healing_v1.ogg"
		}
	},
	EnemyOrcWildlingTriggerRunCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_orcWildling_triggerRun_var1_v1.ogg",
			"kr6_sfx_enemy_orcWildling_triggerRun_var3_v1.ogg",
			"kr6_sfx_enemy_orcWildling_triggerRun_var4_v1.ogg"
		}
	},
	EnemyTrollMediumDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_trollMedium_death_var1.ogg",
			"kr6_sfx_enemy_trollMedium_death_var2.ogg",
			"kr6_sfx_enemy_trollMedium_death_var3.ogg"
		}
	},
	EnemyTrollLargeDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_trollLarge_death_var_001.ogg",
			"kr6_sfx_enemy_trollLarge_death_var_003.ogg",
			"kr6_sfx_enemy_trollLarge_death_var_004.ogg"
		}
	},
	EnemyFrostBruteDeath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostBrute_death_wvoice.ogg"
		}
	},
	EnemyTrollGliderDeath = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_trollGlider_death_var1.ogg",
			"kr6_sfx_enemy_trollGlider_death_var2.ogg",
			"kr6_sfx_enemy_trollGlider_death_var3.ogg"
		}
	},
	EnemyFrostHeraldDeath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostHerald_death_op1_v1.ogg"
		}
	},
	EnemyFrostHeraldBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostHerald_basicAttack_var1_v1.ogg",
			"kr6_sfx_enemy_frostHerald_basicAttack_var2_v1.ogg",
			"kr6_sfx_enemy_frostHerald_basicAttack_var3_v1.ogg"
		}
	},
	EnemyFrostHeraldStalactiteChannel = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostHerald_stalactite_op3_channelOnly_v1.ogg"
		}
	},
	EnemyFrostHeraldStalactiteFall = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostHerald_stalactite_op3_stalactites_v1.ogg"
		}
	},
	EnemyFrostBaiterCloneJump = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostBaiter_cloneJump_var2_v1.ogg",
			"kr6_sfx_enemy_frostBaiter_cloneJump_var4_v1.ogg",
			"kr6_sfx_enemy_frostBaiter_cloneJump_var5_v1.ogg"
		}
	},
	EnemyFrostBaiterDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostBaiter_death_var1_v1.ogg",
			"kr6_sfx_enemy_frostBaiter_death_var2_v1.ogg",
			"kr6_sfx_enemy_frostBaiter_death_var4_v1.ogg"
		}
	},
	EnemyIceCloneDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_iceClone_death_var1_v1.ogg",
			"kr6_sfx_enemy_iceClone_death_var2_v1.ogg",
			"kr6_sfx_enemy_iceClone_death_var3_v1.ogg"
		}
	},
	EnemyFrostBruteBreath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_frostBrute_breath_v1.ogg"
		}
	},
	EnemyTrollCrusherTowerBlockImpact = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_trollCrusher_towerBlock_impact_op1_v1.ogg"
		}
	},
	EnemyTrollCrusherTowerBlockBlock = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_trollCrusher_towerBlock_block_var1_v1.ogg",
			"kr6_sfx_enemy_trollCrusher_towerBlock_block_var2_v1.ogg",
			"kr6_sfx_enemy_trollCrusher_towerBlock_block_var3_v1.ogg"
		}
	},
	EnemyTrollChieftainDrumbeat = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_trollChieftain_drumbeat_v1.ogg"
		}
	},
	EnemySpiderSmallDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_spiderSmall_death_var1_v1.ogg",
			"kr6_sfx_enemy_spiderSmall_death_var2_v1.ogg",
			"kr6_sfx_enemy_spiderSmall_death_var3_v1.ogg"
		}
	},
	EnemySpiderBigDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_spiderBig_death_var1_v1.ogg",
			"kr6_sfx_enemy_spiderBig_death_var2_v1.ogg",
			"kr6_sfx_enemy_spiderBig_death_var3_v1.ogg"
		}
	},
	EnemySpiderMatriarchLayEgg = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_spiderMatriarch_layEgg_var1_v1.ogg",
			"kr6_sfx_enemy_spiderMatriarch_layEgg_var2_v1.ogg",
			"kr6_sfx_enemy_spiderMatriarch_layEgg_var3_v1.ogg"
		}
	},
	EnemySonOfSarelgazCocoonUnit = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_sonOfSarelgaz_cocoonUnit_v1.ogg"
		}
	},
	EnemySpiderMatriarchEggHatch = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_egg_hatch_v1.ogg"
		}
	},
	EnemyGiantSpiderClimbDown = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_giantSpider_climbDown_op2_v1.ogg"
		}
	},
	Stage08EnemyCrowFlockTransform = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_enemy_crowFlock_transform_v1.ogg"
		}
	},
	EnemyShadowArcherDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_bandit_death_var1_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var2_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var3_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var4_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var5_v1.ogg",
			"kr6_sfx_enemy_bandit_death_var6_v1.ogg"
		}
	},
	EnemyCrowcallerDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_crowcaller_death_var1_v1.ogg",
			"kr6_sfx_enemy_crowcaller_death_var2_v1.ogg",
			"kr6_sfx_enemy_crowcaller_death_var3_v1.ogg"
		}
	},
	EnemyCrowcallerCrowSummon = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_crowcaller_crowSummon_var1_v1.ogg",
			"kr6_sfx_enemy_crowcaller_crowSummon_var2_v1.ogg",
			"kr6_sfx_enemy_crowcaller_crowSummon_var3_v1.ogg"
		}
	},
	EnemyCrowDeath = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_crow_death_var1_v1.ogg",
			"kr6_sfx_enemy_crow_death_var2_v1.ogg",
			"kr6_sfx_enemy_crow_death_var3_v1.ogg"
		}
	},
	EnemySkeletonDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_skeleton_death_var1_v1.ogg",
			"kr6_sfx_enemy_skeleton_death_var2_v1.ogg",
			"kr6_sfx_enemy_skeleton_death_var3_v1.ogg"
		}
	},
	EnemyExaltedShadowBladesSmokeBomb = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_exaltedShadowBlade_smokeBomb_var1_v1.ogg",
			"kr6_sfx_enemy_exaltedShadowBlade_smokeBomb_var2_v1.ogg",
			"kr6_sfx_enemy_exaltedShadowBlade_smokeBomb_var3_v1.ogg"
		}
	},
	EnemyGargoyleDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_gargoyle_death_var1_v1.ogg",
			"kr6_sfx_enemy_gargoyle_death_var2_v1.ogg",
			"kr6_sfx_enemy_gargoyle_death_var3_v1.ogg"
		}
	},
	EnemyGargoyleStoneFormIn = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_gargoyle_stoneForm_in_v1.ogg"
		}
	},
	EnemyDarkDiscipleDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkDisciple_death_var1_op2_v1.ogg",
			"kr6_sfx_enemy_darkDisciple_death_var2_op2_v1.ogg",
			"kr6_sfx_enemy_darkDisciple_death_var3_op2_v1.ogg"
		}
	},
	EnemyDarkDiscipleTowerTetherSummon = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkDisciple_towerTether_summon_v1.ogg"
		}
	},
	EnemyDarkDiscipleTowerTetherCastLock = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkDisciple_towerTether_cast_lock_v1.ogg"
		}
	},
	EnemyDarkDiscipleTowerTetherCastUnlock = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkDisciple_towerTether_cast_unlock_v1.ogg"
		}
	},
	EnemyNecromancerDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_necromancer_death_var1_v1.ogg",
			"kr6_sfx_enemy_necromancer_death_var2_v1.ogg",
			"kr6_sfx_enemy_necromancer_death_var3_v1.ogg"
		}
	},
	EnemyNecromancerRaiseDeadCast = {
		loop = false,
		gain = 0.75,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_necromancer_raiseDead_cast_v1.ogg"
		}
	},
	EnemyDarkKnightDeath = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkKnight_death_var1_v1.ogg",
			"kr6_sfx_enemy_darkKnight_death_var2_v1.ogg",
			"kr6_sfx_enemy_darkKnight_death_var3_v1.ogg"
		}
	},
	EnemyDarkKnightTransform = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkKnight_transform_v1.ogg"
		}
	},
	EnemyDarkSlayerDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkKnight_death_var1_v1.ogg",
			"kr6_sfx_enemy_darkKnight_death_var2_v1.ogg",
			"kr6_sfx_enemy_darkKnight_death_var3_v1.ogg"
		}
	},
	EnemyDeathRiderDeath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_deathRider_death_v1.ogg"
		}
	},
	EnemyDarkConstruct = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkConstruct_death_v1.ogg"
		}
	},
	EnemyDarklingDeath = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darklings_death_var1_v1.ogg",
			"kr6_sfx_enemy_darklings_death_var2_v1.ogg",
			"kr6_sfx_enemy_darklings_death_var3_v1.ogg",
			"kr6_sfx_enemy_darklings_death_var4_v1.ogg",
			"kr6_sfx_enemy_darklings_death_var5_v1.ogg"
		}
	},
	EnemySwampThingDeath = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemies_swampThing_death_var3_v1.ogg"
		}
	},
	EnemyDarkSapperDeath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkSapper_death_v1.ogg"
		}
	},
	EnemyDarkSapperBasicAttackImpact = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_darkSapper_basicAttack_impact_var1_v1.ogg",
			"kr6_sfx_enemy_darkSapper_basicAttack_impact_var2_v1.ogg",
			"kr6_sfx_enemy_darkSapper_basicAttack_impact_var3_v1.ogg"
		}
	},
	KR6Terrain1AmbienceSoundBirds = {
		loop = false,
		mode = "random",
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_ambiance_terrain1_birds_var1_v1.ogg",
			"kr6_sfx_ambiance_terrain1_birds_var2_v1.ogg",
			"kr6_sfx_ambiance_terrain1_birds_var3_v1.ogg",
			"kr6_sfx_ambiance_terrain1_birds_var4_v1.ogg"
		}
	},
	KR6Terrain1AmbienceSoundWind = {
		loop = false,
		mode = "random",
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_ambiance_terrain1_windgust_var1_v1.ogg",
			"kr6_sfx_ambiance_terrain1_windgust_var2_v1.ogg"
		}
	},
	Terrain1AmbienceSoundCicadas = {
		loop = false,
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_ambiance_terrain1_cicadas_v1.ogg"
		}
	},
	Terrain2Ambience = {
		loop = false,
		mode = "random",
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_ambiance_terrain2_var1_v1.ogg",
			"kr6_sfx_ambiance_terrain2_var2_v1.ogg",
			"kr6_sfx_ambiance_terrain2_var3_v1.ogg",
			"kr6_sfx_ambiance_terrain2_var4_v1.ogg",
			"kr6_sfx_ambiance_terrain2_var5_v1.ogg",
			"kr6_sfx_ambiance_terrain2_var6_v1.ogg",
			"kr6_sfx_ambiance_terrain2_var7_v1.ogg"
		}
	},
	Terrain3Ambience = {
		loop = false,
		mode = "random",
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_ambiance_terrain3_var1_v1.ogg",
			"kr6_sfx_ambiance_terrain3_var2_v1.ogg",
			"kr6_sfx_ambiance_terrain3_var3_v1.ogg",
			"kr6_sfx_ambiance_terrain3_var4_v1.ogg",
			"kr6_sfx_ambiance_terrain3_var5_v1.ogg",
			"kr6_sfx_ambiance_terrain3_var6_v1.ogg",
			"kr6_sfx_ambiance_terrain3_var7_v1.ogg",
			"kr6_sfx_ambiance_terrain3_var8_v1.ogg"
		}
	},
	Stage01GeraldEnter = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage01_gerald_enter_v1.ogg"
		}
	},
	Stage01ConstructionWorkerTap12 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage01_constructionWorker_tap1-2_v1.ogg"
		}
	},
	Stage01ConstructionWorkerTap3 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage01_constructionWorker_tap3_wShout_v1.ogg"
		}
	},
	Stage01CowSpiesReveal = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage01_cowSpies_reveal_v1.ogg"
		}
	},
	Stage01StatueChange = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage01_statue_change_op1_v1.ogg"
		}
	},
	Stage01OldKingGibberishThrow = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage01_oldKing_gibberish_throw_v1.ogg"
		}
	},
	Stage01OldKingGibberishLaugh = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage01_oldKing_gibberish_laugh_v1.ogg"
		}
	},
	Stage02ScrollsDisintegrate = {
		loop = false,
		gain = 0.25,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_nivus_disintegrate_cast_v1.ogg"
		}
	},
	Stage02BookFountainTap = {
		loop = false,
		gain = 0.75,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage02_bookFountain_tap_v1.ogg"
		}
	},
	Stage02WizardStudentsTap1 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage02_wizardStudents_tap1.ogg"
		}
	},
	Stage02WizardStudentsTap2 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage02_wizardStudents_tap2_v1.ogg"
		}
	},
	Stage02WizardStudentsTap2Cheer = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage02_wizardStudents_tap2_cheer_v1.ogg"
		}
	},
	Stage02MerlinPart1 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage02_merlin_part-1_v1.ogg"
		}
	},
	Stage02MerlinPart2 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage02_merlin_part-2_v1.ogg"
		}
	},
	Stage02BattleChessPieceSelect = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage02_battleChess_pieceSelect_v1.ogg"
		}
	},
	Stage02BattleChessPieceValidMove = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage02_battleChess_validMove_v1.ogg"
		}
	},
	Stage02BattleChessPieceInvalidMove = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage02_battleChess_invalidMove_op2_v1.ogg"
		}
	},
	Stage02BattleChessPieceExplosion = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage02_battleChess_explosion_v1.ogg"
		}
	},
	Stage02StatueTeleport = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage02_statue_teleport_v1.ogg"
		}
	},
	Stage02StatueTeleportRecharge = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage02_statue_teleport_recharge_v1.ogg"
		}
	},
	Stage03SheepExplosion = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_sheep_explosion_v1.ogg"
		}
	},
	Stage03BabyJenkinsCastPart1 = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_babyJenkins_cast_part1_v1.ogg"
		}
	},
	Stage03BabyJenkinsCastPart2 = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_babyJenkins_cast_part2_v1.ogg"
		}
	},
	Stage03CowAbductionCast = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_cowAbduction_v1.ogg"
		}
	},
	Stage03FishermanSingle = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_fisherman_single_v1.ogg"
		}
	},
	Stage03FishermanCatchFishFeedback = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_fisherman_catchFishFeedback_v1.ogg"
		}
	},
	Stage03FishermanPile = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_fisherman_pile_v1.ogg"
		}
	},
	Stage04WallExplosionPart1 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_wallExplosion_part1_v1.ogg"
		}
	},
	Stage04WallExplosionPart2 = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_wallExplosion_part2_v2.ogg"
		}
	},
	Stage04WallExplosionPart3 = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_wallExplosion_part3_v1.ogg"
		}
	},
	Stage04DwarvenCraneActivation = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_dwarvenCrane_activation_op1_v1.ogg"
		}
	},
	Stage04DwarvenCraneBasicAttack = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "random",
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_dwarvenCrane_basicAttack_cast_var1_v1.ogg",
			"kr6_sfx_stage04_dwarvenCrane_basicAttack_cast_var2_v1.ogg",
			"kr6_sfx_stage04_dwarvenCrane_basicAttack_cast_var3_v1.ogg"
		}
	},
	Stage04DwarvenCraneBasicAttackImpact = {
		loop = false,
		gain = 0.4,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_dwarvenCrane_basicAttack_impact_v1.ogg"
		}
	},
	Stage04MinecraftTap12 = {
		loop = false,
		gain = 0.3,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_minecraft_tap_op3_v1.ogg"
		}
	},
	Stage04MinecraftTap3 = {
		loop = false,
		gain = 0.3,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_minecraft_tap3_v1.ogg"
		}
	},
	Stage04MinecraftLap = {
		loop = false,
		gain = 0.2,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_minecraft_lap_v1.ogg"
		}
	},
	Stage04MinecraftCrashExplosion = {
		loop = false,
		gain = 0.4,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage04_minecraft_crashExplosion_v1.ogg"
		}
	},
	Stage05ForestBurnPrep = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage05_forestBurn_prep_v1.ogg"
		}
	},
	Stage05ForestBurnExplosionPart1ThrowTorch = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage05_forestBurn_explosion_part1-throwTorch_v1.ogg"
		}
	},
	Stage05ForestBurnExplosionPart2 = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage05_forestBurn_explosion_part2_v1.ogg"
		}
	},
	Stage05SilveroakTreeActivationCast = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage05_silveroakTree_activationCast_v1.ogg"
		}
	},
	Stage05SilveroakTreeRecoverCast = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage05_silveroakTree_recoverCast_v1.ogg"
		}
	},
	Stage05BushGoblinTap = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage05_bushGoblin_tap_v1.ogg"
		}
	},
	Stage05AlleriaSwiftwindTaunt = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_voice_alleriaswiftwind_taunt01_d.ogg",
			"kr_voice_alleriaswiftwind_taunt02_a.ogg"
		}
	},
	Stage05AlleriaSwiftwindDeath = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "TAUNTS",
		files = {
			"kr_voice_alleriaswiftwind_death_b.ogg"
		}
	},
	Stage05LampBreak = {
		loop = false,
		gain = 0.5,
		ignore = 0.1,
		mode = "random",
		source_group = "SFX",
		files = {
			"kr6_sfx_lamp_break_var1_v1.ogg",
			"kr6_sfx_lamp_break_var2_v1.ogg",
			"kr6_sfx_lamp_break_var3_v1.ogg"
		}
	},
	Stage05OldManElfShout = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_oldManElf_shout_var2_v1.ogg"
		}
	},
	Stage05ElvenMusicianPlay = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_elvenMusician_play_v1.ogg"
		}
	},
	Stage05AlleriaMultishotCast = {
		loop = false,
		gain = 0.7,
		ignore = 0.1,
		mode = "random",
		source_group = "SFX",
		files = {
			"kr6_sfx_stage05_alleria_multishot_var1_v2.ogg",
			"kr6_sfx_stage05_alleria_multishot_var2_v2.ogg",
			"kr6_sfx_stage05_alleria_multishot_var3_v2.ogg"
		}
	},
	Stage05AlleriaSummonCast = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage05_alleria_summonCast_op1_v1.ogg"
		}
	},
	Stage06NivusMagicMissileCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_nivus_magicMissile_cast_var1_v1.ogg",
			"kr6_sfx_stage06_nivus_magicMissile_cast_var2_v1.ogg",
			"kr6_sfx_stage06_nivus_magicMissile_cast_var3_v1.ogg"
		}
	},
	Stage06NivusSpawnBooksSummon = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_nivus_spawnBooks_summon_var1_v1.ogg",
			"kr6_sfx_stage06_nivus_spawnBooks_summon_var2_v1.ogg",
			"kr6_sfx_stage06_nivus_spawnBooks_summon_var3_v1.ogg"
		}
	},
	Stage06NivusSpawnBooksCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_nivus_spawnBooks_cast_var1_v1.ogg",
			"kr6_sfx_stage06_nivus_spawnBooks_cast_var2_v1.ogg",
			"kr6_sfx_stage06_nivus_spawnBooks_cast_var3_v1.ogg"
		}
	},
	Stage06DisintegrateTeleportCast = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_nivus_disintegrate_teleport_cast_v1.ogg"
		}
	},
	Stage06DisintegrateCast = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_nivus_disintegrate_cast_v1.ogg"
		}
	},
	Stage06PolymorphCast = {
		loop = false,
		gain = 0.7,
		ignore = 0.1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_nivus_polymorph_cast_v1.ogg"
		}
	},
	Stage06WizardMushroomYawn = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_wizardMushroom_yawn_v1.ogg"
		}
	},
	Stage06WizardMushroomEat = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_wizardMushroom_eat_v1.ogg"
		}
	},
	Stage06WizardMushroomHitSigh = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_wizardMushroom_hit-sigh_v1.ogg"
		}
	},
	Stage06LakeWizardTap = {
		loop = false,
		gain = 0.7,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage06_lakeWizard_tap_v1.ogg"
		}
	},
	Stage07BushBladesSpawnMov = {
		loop = false,
		mode = "sequence",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage07_bush_bladesSpawn_bushMov1_v1.ogg",
			"kr6_sfx_stage07_bush_bladesSpawn_bushMov2_v1.ogg",
			"kr6_sfx_stage07_bush_bladesSpawn_bushMov3_v1.ogg"
		}
	},
	Stage07BushBladesSpawn = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage07_bush_bladesSpawn_spawn_v1.ogg"
		}
	},
	Stage07StableKnightSpawn = {
		loop = false,
		gain = 0.9,
		mode = "random",
		delay = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage07_stable_knightSpawn_op1_v1.ogg",
			"kr6_sfx_stage07_stable_knightSpawn_op2_v1.ogg",
			"kr6_sfx_stage07_stable_knightSpawn_op3_v1.ogg"
		}
	},
	Stage07StableKnightArrive = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage07_stable_knightArrive_v1.ogg"
		}
	},
	Stage07CampfireExtinguish = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage07_campfire_extinguish_op2_v1.ogg"
		}
	},
	Stage07HorseTapFeedback = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage07_horseTapFeedback_var1_v1.ogg",
			"kr6_sfx_stage07_horseTapFeedback_var2_v1.ogg",
			"kr6_sfx_stage07_horseTapFeedback_var3_v1.ogg"
		}
	},
	Stage07BuyRider = {
		loop = false,
		gain = 0.6,
		ignore = 1,
		source_group = "TAUNTS",
		files = {
			"kr_stage07Rider_v1.ogg"
		}
	},
	Stage08StageStartFieryProjectiles = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_stageStart_fieryProjectiles_v1.ogg"
		}
	},
	Stage08StagePhase2FieryProjectiles = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_defenderWall_explosion_v1.ogg"
		}
	},
	Stage08FieryProjectilesTravel = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_stageStart_fieryProjectiles_travel_var1_v1.ogg",
			"kr6_sfx_stage08_stageStart_fieryProjectiles_travel_var2_v1.ogg",
			"kr6_sfx_stage08_stageStart_fieryProjectiles_travel_var3_v1.ogg"
		}
	},
	Stage08FieryProjectilesExplosion = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_stageStart_fieryProjectiles_explosion_var1_v1.ogg",
			"kr6_sfx_stage08_stageStart_fieryProjectiles_explosion_var2_v1.ogg",
			"kr6_sfx_stage08_stageStart_fieryProjectiles_explosion_var3_v1.ogg"
		}
	},
	Stage08StagePhase3Run = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_stagePhase3_run_op2_v1.ogg"
		}
	},
	Stage08StagePhase3CartExplosion = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_stagePhase3_cartExplosion_v1.ogg"
		}
	},
	Stage08DefenderCatapultLoad = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage8_catapult_load_v1.ogg"
		}
	},
	Stage08DefenderCatapultFire = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_defenderCatapult_fire_v1.ogg"
		}
	},
	Stage08DefenderCatapultImpact = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_towers_royalCatapult_basicAttack_impact_var1_v1.ogg",
			"kr6_sfx_towers_royalCatapult_basicAttack_impact_var2_v1.ogg",
			"kr6_sfx_towers_royalCatapult_basicAttack_impact_var3_v1.ogg"
		}
	},
	Stage08EnemyCrowFlockTransform = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_enemy_crowFlock_transform_v1.ogg"
		}
	},
	Stage08OrcSiegeEngineMoveIn = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_enemy_orcSiegeEngine_moveIn_v1.ogg"
		}
	},
	Stage08OrcSiegeEngineMoveOut = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_enemy_orcSiegeEngine_moveOut_v1.ogg"
		}
	},
	Stage08OrcSiegeEngineFire = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_enemy_orcSiegeEngine_fire_v1.ogg"
		}
	},
	Stage08OrcChieftainDeath = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_boss_orcChieftain_death_v1.ogg"
		}
	},
	Stage08OrcChieftainBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_boss_orcChieftain_basicAttack_var1_v1.ogg",
			"kr6_boss_orcChieftain_basicAttack_var2_v1.ogg",
			"kr6_boss_orcChieftain_basicAttack_var3_v1.ogg"
		}
	},
	Stage08OrcChieftainMoveCartWalk = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_boss_orcChieftain_moveCart_walk_LOOP_v2.ogg"
		}
	},
	Stage08OrcSiegeEngineTap = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_enemy_orcSiegeEngine_tap_v1.ogg"
		}
	},
	Stage08OrcSiegeEngineDeath = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_enemy_orcSiegeEngine_death_v1.ogg"
		}
	},
	Stage08TowerRepairment = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_towerRepairment_v1.ogg"
		}
	},
	Stage08ScaredCrowd = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage08_scaredCrowd_v1.ogg"
		}
	},
	EnemyBossGiantFootsteps = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_boss_giantFootsteps_var1_v1.ogg",
			"kr6_sfx_enemy_boss_giantFootsteps_var2_v1.ogg",
			"kr6_sfx_enemy_boss_giantFootsteps_var3_v1.ogg",
			"kr6_sfx_enemy_boss_giantFootsteps_var4_v1.ogg",
			"kr6_sfx_enemy_boss_giantFootsteps_var5_v1.ogg",
			"kr6_sfx_enemy_boss_giantFootsteps_var6_v1.ogg"
		}
	},
	Stage09PillarTap = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage09_pillar_tap_var1_v1.ogg",
			"kr6_sfx_stage09_pillar_tap_var2_v1.ogg"
		}
	},
	Stage09PillarPreCrumble = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage09_pillar_tap_var3_v1.ogg"
		}
	},
	Stage09PillarCrumble = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage09_pillar_crumble_v1.ogg"
		}
	},
	Stage09MortalKombat = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage09_mortalKombat_fullSeq_v1.ogg"
		}
	},
	Stage10WaterSplashIn = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_waterSplash_in_var1_v1.ogg",
			"kr6_sfx_stage10_waterSplash_in_var2_v1.ogg",
			"kr6_sfx_stage10_waterSplash_in_var3_v1.ogg"
		}
	},
	Stage10WaterSplashOut = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_waterSplash_out_var1_v1.ogg",
			"kr6_sfx_stage10_waterSplash_out_var2_v1.ogg",
			"kr6_sfx_stage10_waterSplash_out_var3_v1.ogg"
		}
	},
	Stage10BellUnfreeze = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_bellUnfreeze_v1.ogg"
		}
	},
	Stage10BellFreeze = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_bellFreeze_v1.ogg"
		}
	},
	Stage10BellRing = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_bellRing_v1.ogg"
		}
	},
	Stage10DoorOpenAndGrumble = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_doorOpen_op1_v1.ogg"
		}
	},
	Stage10DoorOpen = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_doorOpen_op2_v1.ogg"
		}
	},
	Stage10DoorClose = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_doorClose_v1.ogg"
		}
	},
	Stage10StalactitesFall = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_stalactitesFall_var1_v2.ogg",
			"kr6_sfx_stage10_stalactitesFall_var2_v2.ogg",
			"kr6_sfx_stage10_stalactitesFall_var3_v2.ogg"
		}
	},
	Stage10FreeTower = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage10_freeTower_v1.ogg"
		}
	},
	Stage10JTDevour = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_jt_Devour_v1.ogg"
		}
	},
	Stage10JTRoar = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_jt_roar_v1.ogg"
		}
	},
	Stage10JTTowerFreeze = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_jt_towerFreeze_v1.ogg"
		}
	},
	Stage10JTChestTaunt = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_jt_chestTaunt_v1.ogg"
		}
	},
	Stage10JTCaveRumble = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_jt_caveRumble_v1.ogg"
		}
	},
	Stage10AtAtTap1 = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage10_atat_tap1_v1.ogg"
		}
	},
	Stage10AtAtTap2 = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage10_atat_tap2_v1.ogg"
		}
	},
	Stage10AtAtTapBreak = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage10_atat_tapBreak_v1.ogg"
		}
	},
	Stage10AtAtShoot = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage10_atat_shoot_var1_v1.ogg",
			"kr6_sfx_easterEgg_stage10_atat_shoot_var2_v1.ogg",
			"kr6_sfx_easterEgg_stage10_atat_shoot_var3_v1.ogg"
		}
	},
	Stage11EncampmentLevelUp1Taunt = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr_voice_linireanencampment_taunt01_a.ogg"
		}
	},
	Stage11EncampmentLevelUp2Taunt = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr_voice_linireanencampment_taunt02_b.ogg"
		}
	},
	Stage11EncampmentAttackTaunt = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr_voice_linireanencampment_attack_c.ogg"
		}
	},
	Stage11EncampmentDamaged = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage11_encampment_damaged_var1_v1.ogg",
			"kr6_sfx_stage11_encampment_damaged_var2_v1.ogg",
			"kr6_sfx_stage11_encampment_damaged_var3_v1.ogg",
			"kr6_sfx_stage11_encampment_damaged_var4_v1.ogg"
		}
	},
	Stage11FireArrow = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage11_encampment_fireArrow_v1.ogg"
		}
	},
	Stage11EncampmentLevelUp1 = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage11_encampment_levelUp_1_v1.ogg"
		}
	},
	Stage11EncampmentLevelUp2 = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage11_encampment_levelUp_2_v1.ogg"
		}
	},
	Stage11EncampmentDestroyedInit = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage11_encampment_destroyed_init_v2.ogg"
		}
	},
	Stage11EncampmentDestroyedEnd = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage11_encampment_destroyed_end_v2.ogg"
		}
	},
	Stage11EggNestDestroyed = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage11_eggNest_destroyed_v1.ogg"
		}
	},
	Stage11EggNestHatch = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_egg_hatch_v1.ogg"
		}
	},
	Stage11SarelgazBite = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_sarelgaz_bite_v1.ogg"
		}
	},
	Stage11SarelgazDeath = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_sarelgaz_death_v1.ogg"
		}
	},
	Stage11SarelgazClimbDown = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_sarelgaz_climbDown_v1.ogg"
		}
	},
	Stage11SarelgazClimbUp = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_giantSpider_climbUp_v1.ogg"
		}
	},
	Stage11SarelgazWebbing = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_sarelgaz_webbing_v1.ogg"
		}
	},
	Stage11SarelgazCocoonTower = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_sarelgaz_cocoonTower_v1.ogg"
		}
	},
	Stage11SarelgazInterrupt = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_boss_sarelgaz_interrupt_v1.ogg"
		}
	},
	Stage12ElevatorInCreak = {
		loop = false,
		mode = "sequence",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage12_elevator_in_creak1_v1.ogg",
			"kr6_sfx_stage12_elevator_in_creak2_v1.ogg",
			"kr6_sfx_stage12_elevator_in_creak3_v1.ogg",
			"kr6_sfx_stage12_elevator_in_creak4_v1.ogg"
		}
	},
	Stage12ElevatorInFall = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage12_elevator_in_fall_v1.ogg"
		}
	},
	Stage12ElevatorOut = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage12_elevator_out_op1_v1.ogg"
		}
	},
	Stage12TrollRappel = {
		loop = false,
		mode = "random",
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage12_troll_rappel_var1_v1.ogg",
			"kr6_sfx_stage12_troll_rappel_var2_v1.ogg",
			"kr6_sfx_stage12_troll_rappel_var3_v1.ogg"
		}
	},
	Stage13SorcererDeath = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_sorcerer_death_var1_v1.ogg",
			"kr6_sfx_sorcerer_death_var2_v1.ogg",
			"kr6_sfx_sorcerer_death_var3_v1.ogg"
		}
	},
	Stage13KamikazeGliderPreparation = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_kamikazeGlider_preparation_var1_v1.ogg",
			"kr6_sfx_kamikazeGlider_preparation_var2_v1.ogg",
			"kr6_sfx_kamikazeGlider_preparation_var3_v1.ogg",
			"kr6_sfx_kamikazeGlider_preparation_var4_v1.ogg",
			"kr6_sfx_kamikazeGlider_preparation_var5_v1.ogg"
		}
	},
	Stage13KamikazeGliderDeathImpact = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_kamikazeGlider_deathImpact_var1_v1.ogg",
			"kr6_sfx_kamikazeGlider_deathImpact_var2_v1.ogg",
			"kr6_sfx_kamikazeGlider_deathImpact_var3_v1.ogg"
		}
	},
	Stage13SunrayTowerActivation = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayTower_activation_v1.ogg"
		}
	},
	Stage13SunrayTowerPowerUp = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayTower_powerUp_v1.ogg"
		}
	},
	Stage13SunrayTowerPowerDown = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayTower_powerDown_v1.ogg"
		}
	},
	Stage13SunrayRayCast = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayTower_rayCast_v1.ogg"
		}
	},
	Stage13SunrayRayLoop = {
		loop = true,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayTower_loop_v1.ogg"
		}
	},
	Stage13SunrayObeliskActivation = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayObelisk_activation_v1.ogg"
		}
	},
	Stage13SunrayObeliskPowerUp = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayObelisk_powerUp_glareOnly_v1.ogg"
		}
	},
	Stage13SunrayObeliskPowerDown = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayObelisk_powerDown_v1.ogg"
		}
	},
	Stage13SunrayObeliskFire = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_sunrayObelisk_fire_var1_v1.ogg",
			"kr6_sfx_sunrayObelisk_fire_var2_v1.ogg",
			"kr6_sfx_sunrayObelisk_fire_var3_v1.ogg",
			"kr6_sfx_sunrayObelisk_fire_var4_v1.ogg"
		}
	},
	Stage13TrollKingEntranceSlide = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_entrance_slide_v1.ogg"
		}
	},
	Stage13TrollKingEntranceJump = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_entrance_jump_v1.ogg"
		}
	},
	Stage13TrollKingEntranceLand = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_entrance_land_v1.ogg"
		}
	},
	Stage13TrollKingShieldbreak = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_shieldbreak_v1.ogg"
		}
	},
	Stage13TrollKingShieldbreakShieldrop = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_shieldbreak_shieldDrop_op2_v1.ogg"
		}
	},
	Stage13TrollKingHit1 = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_towerHit_hit1_v1.ogg"
		}
	},
	Stage13TrollKingHit2 = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_towerHit_hit2_v1.ogg"
		}
	},
	Stage13TrollKingTowerBreak = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_towerBreak_v1.ogg"
		}
	},
	Stage13TrollKingBasicAttack = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_trollKing_basicAttack_op2_v1.ogg"
		}
	},
	Stage14BuildingRepaired = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage14_buildingRepaired.ogg"
		}
	},
	Stage14BlacksmithWork = {
		loop = false,
		mode = "random",
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage14_blacksmith_work_var1_v1.ogg",
			"kr6_sfx_stage14_blacksmith_work_var1_v1.ogg",
			"kr6_sfx_stage14_blacksmith_work_var2_v1.ogg",
			"kr6_sfx_stage14_blacksmith_work_var3_v1.ogg",
			"kr6_sfx_stage14_blacksmith_work_var4_v1.ogg"
		}
	},
	Stage14TavernBeerCast = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage14_tavernBeer_cast_var1_v1.ogg",
			"kr6_sfx_stage14_tavernBeer_cast_var2_v1.ogg",
			"kr6_sfx_stage14_tavernBeer_cast_var3_v1.ogg"
		}
	},
	Stage14TavernBeerImpact = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage14_tavernBeer_impact_v1.ogg"
		}
	},
	Stage14ArmoryBuildTaunt = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		source_group = "TAUNTS",
		files = {
			"kr_brightwickarmory_build_c.ogg"
		}
	},
	Stage14ArmoryMoveTaunt = {
		loop = false,
		gain = 0.9,
		ignore = 1.5,
		source_group = "TAUNTS",
		files = {
			"kr_brightwickarmory_build_c.ogg"
		}
	},
	Stage14ArmoryUpgradeTaunt = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_brightwickarmory_build_c.ogg"
		}
	},
	Stage14BlacksmithBuildTaunt = {
		ignore = 1,
		gain = 0.8,
		loop = false,
		delay = 1.5,
		source_group = "TAUNTS",
		files = {
			"kr_brightwickblacksmith_build_c.ogg"
		}
	},
	Stage14BlacksmithUpgradeTaunt = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"kr_brightwickblacksmith_build_c.ogg"
		}
	},
	Stage14TavernBuildTaunt = {
		ignore = 1,
		gain = 0.8,
		loop = false,
		delay = 1.2,
		source_group = "TAUNTS",
		files = {
			"kr_brightwicktavern_build_c.ogg"
		}
	},
	Stage14DeloreanTurnOn = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		interruptible = true,
		files = {
			"kr6_sfx_easterEgg_stage14_delorean_turnOn_v1.ogg"
		}
	},
	Stage14DeloreanPowerDown = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage14_delorean_powerDown_v1.ogg"
		}
	},
	Stage14CeilingGoatTap1 = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		interruptible = true,
		files = {
			"kr6_sfx_easterEgg_stage14_ceilingGoat_tap1_v1.ogg"
		}
	},
	Stage12VaseBreak = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage12_vaseBreak_var1_v1.ogg",
			"kr6_sfx_easterEgg_stage12_vaseBreak_var2_v1.ogg",
			"kr6_sfx_easterEgg_stage12_vaseBreak_var3_v1.ogg"
		}
	},
	Stage09MortalKombatHit = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage9_mortalKombat_hit_v1.ogg"
		}
	},
	Stage09MortalKombatFinisher = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage9_mortalKombat_finisher_v1.ogg"
		}
	},
	Stage14CeilingGoatTap2 = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage14_ceilingGoat_tap2_v1.ogg"
		}
	},
	Stage15BlackburnTaunt = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_lordblackburn_taunt03_b.ogg",
			"kr_lordblackburn_taunt05_b.ogg",
			"kr_lordblackburn_taunt01_b.ogg"
		}
	},
	Stage15BlackburnRespawn = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_lordblackburn_taunt02_a.ogg"
		}
	},
	Stage15BlackburnDrinkPotion = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_drinkPotion_v1.ogg"
		}
	},
	Stage15BlackburnPowerUp = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_powerUp_v1.ogg"
		}
	},
	Stage15BlackburnExplosion = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_explosion_op1_v1.ogg"
		}
	},
	Stage15WitchConjurePotion = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_witch_conjurePotion_v1.ogg"
		}
	},
	Stage15WitchMovement = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_witch_movement_v1.ogg"
		}
	},
	Stage15WitchLaughter = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_witch_laughter_v1.ogg"
		}
	},
	Stage15GoatExplosion = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage03_sheep_explosion_v1.ogg"
		}
	},
	Stage15WitchCauldronBoil = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_witch_cauldronBoil_v1.ogg"
		}
	},
	Stage15WitchKickCauldronKick = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_witch_kickCauldron_kick_v1.ogg"
		}
	},
	Stage15WitchKickCauldronSplash = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_witch_kickCauldron_splash_v1.ogg"
		}
	},
	Stage15BossBlackburnBlockTower = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_boss_blackburn_blockTower_v1.ogg"
		}
	},
	Stage15SwampBubbling = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_swampBubbling_var1_v1.ogg",
			"kr6_sfx_stage15_swampBubbling_var2_v1.ogg",
			"kr6_sfx_stage15_swampBubbling_var3_v1.ogg",
			"kr6_sfx_stage15_swampBubbling_var4_v1.ogg",
			"kr6_sfx_stage15_swampBubbling_var5_v1.ogg"
		}
	},
	Stage15SwampOutBigCreep = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_swampOut_bigCreep_v1.ogg"
		}
	},
	Stage15SwampOutSmallCreep = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_swampOut_smallCreep_var1_v1.ogg",
			"kr6_sfx_stage15_swampOut_smallCreep_var2_v1.ogg",
			"kr6_sfx_stage15_swampOut_smallCreep_var3_v1.ogg"
		}
	},
	Stage15MidCinematicDarkEnergy = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_midCinematic_darkEnergy_v1.ogg"
		}
	},
	Stage15BlackburnJumpIn = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_blackburn_jump_in_v1.ogg"
		}
	},
	Stage15BlackburnJumpOut = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_blackburn_jump_out_v1.ogg"
		}
	},
	Stage15BlackburnBasicAttack = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_boss_blackburn_basicAttack_var1_v1.ogg",
			"kr6_sfx_stage15_boss_blackburn_basicAttack_var2_v1.ogg",
			"kr6_sfx_stage15_boss_blackburn_basicAttack_var3_v1.ogg"
		}
	},
	Stage15BlackburnDefeat = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_boss_blackburn_defeat_op1_v1.ogg"
		}
	},
	Stage15TheRingLidOpen = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_theRing_lidOpen_v1.ogg"
		}
	},
	Stage15TheRingSamaraGlitch1 = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_theRing_samaraGlitch_1_v1.ogg"
		}
	},
	Stage15TheRingSamaraGlitch2 = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_theRing_samaraGlitch_2_v1.ogg"
		}
	},
	Stage15TheRingSamaraGlitch3 = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_theRing_samaraGlitch_3_v1.ogg"
		}
	},
	Stage15ThreeEyedFishTap1 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_threeEyedFish_tap1_v1.ogg"
		}
	},
	Stage15ThreeEyedFishTap2 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage15_threeEyedFish_tap2_v1.ogg"
		}
	},
	Stage15BlackburnDeath = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage15_blackburn_death.ogg"
		}
	},
	Stage16RottenTreantDeath = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_rottenTreant_death_var1_v1.ogg",
			"kr6_sfx_enemy_rottenTreant_death_var2_v1.ogg",
			"kr6_sfx_enemy_rottenTreant_death_var3_v1.ogg"
		}
	},
	Stage16GoldenGroveCorruption1 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_goldenGrove_corruption1_v1.ogg"
		}
	},
	Stage16GoldenGroveCorruption2 = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_goldenGrove_corruption2_v1.ogg"
		}
	},
	Stage16GoldenGroveCorruptionTree = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_goldenGrove_corruptionTree_v1.ogg"
		}
	},
	Stage16CorruptedTreantLaunch = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_corruptedTreant_launch_v1.ogg"
		}
	},
	Stage16CorruptedTreantImpact = {
		loop = false,
		mode = "random",
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_corruptedTreant_impact_var1_v1.ogg",
			"kr6_sfx_stage16_corruptedTreant_impact_var2_v1.ogg",
			"kr6_sfx_stage16_corruptedTreant_impact_var3_v1.ogg"
		}
	},
	Stage16DeathRiderLaugh = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_deathRider_laugh.ogg"
		}
	},
	Stage16GoldenTreantEat = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_goldenTreant_eat_v1.ogg"
		}
	},
	Stage16GoldenTreantEatTongue = {
		loop = false,
		gain = 0.6,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage16_goldenTreant_eat_tongue_v1.ogg"
		}
	},
	Stage16DekuSproutTapIn = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage16_dekuSprout_tap_IN_v1.ogg"
		}
	},
	Stage16DekuSproutTapOut = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_easterEgg_stage16_dekuSprout_tap_OUT_v1.ogg"
		}
	},
	Stage17JoustHorseGallop = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_horseGallop_v1.ogg"
		}
	},
	Stage17JoustBattleCry = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_battleCry_op1_v1.ogg"
		}
	},
	Stage17JoustStart = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_start_v1.ogg"
		}
	},
	Stage17JoustClash = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_clash_v1.ogg"
		}
	},
	Stage17JoustKnockedOut = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_knockedOut_op1_v1.ogg"
		}
	},
	Stage17JoustLadyCheer = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_ladyCheer_op1_v1.ogg"
		}
	},
	Stage17JoustPlayerWin = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_playerWin_v1.ogg"
		}
	},
	Stage17JoustPlayerLoseHorns = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_playerLose_horns_v1.ogg"
		}
	},
	Stage17JoustPlayerLoseLadyCry = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_joust_playerLose_ladyCry_v1.ogg"
		}
	},
	Stage17KnightClashTrigger = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_knightClash_trigger_1.ogg"
		}
	},
	Stage17KnightClashCombat = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_knightClash_combat_var1_v1.ogg",
			"kr6_sfx_stage17_knightClash_combat_var2_v1.ogg",
			"kr6_sfx_stage17_knightClash_combat_var3_v1.ogg"
		}
	},
	Stage17KnightClashEvilWin = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_knightClash_evilWin_finalStrike_op1_v1.ogg"
		}
	},
	Stage17KnightClashGoodWin = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage17_knightClash_goodWin_op1_v1.ogg"
		}
	},
	Stage18DemonSpawnDeath = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_demonSpawn_death_var1_v1.ogg",
			"kr6_sfx_enemy_demonSpawn_death_var2_v1.ogg",
			"kr6_sfx_enemy_demonSpawn_death_var3_v1.ogg"
		}
	},
	Stage18DemonFlareonAttack = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_demonFlareon_attack_var1_v1.ogg",
			"kr6_sfx_enemy_demonFlareon_attack_var2_v1.ogg",
			"kr6_sfx_enemy_demonFlareon_attack_var3_v1.ogg"
		}
	},
	Stage18DemonHoundDeath = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_demonHound_death_var1_v1.ogg",
			"kr6_sfx_enemy_demonHound_death_var2_v1.ogg",
			"kr6_sfx_enemy_demonHound_death_var3_v1.ogg"
		}
	},
	Stage18DemonLordShieldCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_demonLord_shield_cast_v1.ogg"
		}
	},
	Stage18DemonLordDeath = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_demonLord_death_var1_v1.ogg",
			"kr6_sfx_enemy_demonLord_death_var2_v1.ogg",
			"kr6_sfx_enemy_demonLord_death_var3_v1.ogg"
		}
	},
	Stage18MagmaElementalDeath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_magmaElemental_death_v1.ogg"
		}
	},
	Stage18DemonImpDeath = {
		loop = false,
		mode = "random",
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_enemy_demonImp_death_var1_v1.ogg",
			"kr6_sfx_enemy_demonImp_death_var2_v1.ogg",
			"kr6_sfx_enemy_demonImp_death_var3_v1.ogg"
		}
	},
	Stage18MolochRayImpact = {
		loop = false,
		mode = "random",
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_sfx_lightning_op1.ogg",
			"kr6_sfx_lightning_op2.ogg",
			"kr6_sfx_lightning_op3.ogg"
		}
	},
	Stage18MolochBigBell = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_entrance_bellToll_singleton_op3_v1.ogg"
		}
	},
	Stage18MolochBigBellIn = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_entrance_bellToll_reveal_IN_v1.ogg"
		}
	},
	Stage18MolochBigBellOut = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_entrance_bellToll_reveal_OUT_v1.ogg"
		}
	},
	Stage18DenasTaunt = {
		loop = false,
		gain = 0.9,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr_princedenas_taunt01_b.ogg",
			"kr_princedenas_taunt02_a.ogg",
			"kr_princedenas_taunt03_a.ogg"
		}
	},
	Stage18DenasDeath = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_princedenas_death_a.ogg"
		}
	},
	Stage18DenasTauntIntro = {
		loop = false,
		gain = 0.9,
		source_group = "TAUNTS",
		files = {
			"kr_princedenas_taunt02_a.ogg"
		}
	},
	Stage18PortalOpen = {
		loop = false,
		gain = 0.64,
		ignore = 0.15,
		source_group = "SFX",
		files = {
			"kr6_stage18_portal_open_v1.ogg"
		}
	},
	Stage18PortalCreepPassage = {
		loop = false,
		gain = 0.7,
		ignore = 0.15,
		mode = "random",
		source_group = "SFX",
		files = {
			"kr6_stage18_portal_creepPassage_var1_v1.ogg",
			"kr6_stage18_portal_creepPassage_var2_v1.ogg",
			"kr6_stage18_portal_creepPassage_var3_v1.ogg"
		}
	},
	Stage18PortalClose = {
		loop = false,
		gain = 0.64,
		ignore = 0.15,
		source_group = "SFX",
		files = {
			"kr6_stage18_portal_close_v1.ogg"
		}
	},
	Stage18TowerVeznanBoltCharge = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_bolt_charge_v1.ogg"
		}
	},
	Stage18TowerVeznanBoltRelease = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_bolt_release_var1_v1.ogg",
			"kr6_stage18_towerVeznan_bolt_release_var2_v1.ogg",
			"kr6_stage18_towerVeznan_bolt_release_var3_v1.ogg"
		}
	},
	Stage18TowerVeznanBoltImpact = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_bolt_impact_var1_v1.ogg",
			"kr6_stage18_towerVeznan_bolt_impact_var2_v1.ogg",
			"kr6_stage18_towerVeznan_bolt_impact_var3_v1.ogg"
		}
	},
	Stage18TowerVeznanDisableTowersCast = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_disableTowers_cast_v1.ogg"
		}
	},
	Stage18TowerVeznanDisableTowersDisable = {
		loop = false,
		gain = 0.8,
		ignore = 0.15,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_disableTowers_disable_v1.ogg"
		}
	},
	Stage18TowerVeznanDisableTowersInterrupt = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_disableTowers_interrupt_v1.ogg"
		}
	},
	Stage18TowerVeznanStatueBreakCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_statueBreak_cast_v1.ogg"
		}
	},
	Stage18TowerVeznanStatueBreakBolt = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_statueBreak_bolt_v1.ogg"
		}
	},
	Stage18TowerVeznanStatueBreakBreak = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_towerVeznan_statueBreak_break_v1.ogg"
		}
	},
	Stage18IntroCinematicVeznanEyesAppear = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_introCinematic_veznanEyes_appear_op1_v1.ogg"
		}
	},
	Stage18MidCinematicPortalBreak = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_midCinematic_portalBreak_v1.ogg"
		}
	},
	Stage18MidCinematicDenasGallop = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_stage18_midCinematic_denas_gallop_v1.ogg"
		}
	},
	Stage18MidCinematicDenasHorseNeigh = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_stage18_midCinematic_denas_horseNeigh_v1.ogg"
		}
	},
	Stage18MidCinematicTowerVeznanSnap = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr6_stage18_midCinematic_towerVeznan_snap_v2.ogg"
		}
	},
	Stage18MidCinematicTowerVeznanReveal = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_midCinematic_towerVeznan_reveal_v1.ogg"
		}
	},
	Stage18MidCinematicLevelIllusionReveal = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_midCinematic_levelIllusion_reveal_v1.ogg"
		}
	},
	Stage18DenasEmpoweredAttack = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_denas_empoweredAttack_cast_op1_v1.ogg"
		}
	},
	Stage18DenasEmpoweredAttackCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_denas_empoweredAttack_cast_op1_v1.ogg"
		}
	},
	Stage18DenasBombardmentCast = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_stage18_denas_bombardment_cast_v1.ogg"
		}
	},
	Stage18DenasBombardmentImpact = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_stage18_denas_bombardment_impact_v1.ogg"
		}
	},
	Stage18DemonsPentagramAppear = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_demons_pentagram_appear_v1.ogg"
		}
	},
	Stage18DemonsPentagramIn = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_stage18_demons_pentagram_in_var1_v1.ogg",
			"kr6_stage18_demons_pentagram_in_var2_v1.ogg",
			"kr6_stage18_demons_pentagram_in_var3_v1.ogg",
			"kr6_stage18_demons_pentagram_in_var4_v1.ogg"
		}
	},
	Stage18MolochEntranceLightningStrike = {
		loop = false,
		mode = "sequence",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_entrance_lightningStrike_1_v1.ogg",
			"kr6_stage18_moloch_entrance_lightningStrike_2_v1.ogg",
			"kr6_stage18_moloch_entrance_lightningStrike_3_v1.ogg"
		}
	},
	Stage18MolochEntrance = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_entrance_v1.ogg"
		}
	},
	Stage18MolochRoar = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_roar_op1_v1.ogg"
		}
	},
	Stage18MolochSlam = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_slam_v1.ogg"
		}
	},
	Stage18MolochMoltenRockCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_moltenRock_cast_v1.ogg"
		}
	},
	Stage18MolochMoltenRockThrow = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_moltenRock_throw_v1.ogg"
		}
	},
	Stage18MolochMoltenRockImpact = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_moltenRock_impact_v1.ogg"
		}
	},
	Stage18BossVeznanBoltCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_veznan_bolt_cast_v1.ogg"
		}
	},
	Stage18BossVeznanBoltRelease = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_veznan_bolt_release_v2.ogg"
		}
	},
	Stage18BossVeznanBoltImpact = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_veznan_bolt_impact_v2.ogg"
		}
	},
	Stage18BossVeznanIllusionDeath = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_veznan_illusion_death_v1.ogg"
		}
	},
	Stage18BossVeznanSoulSiphonCast = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_veznan_soulSiphon_cast_v1.ogg"
		}
	},
	Stage18BossVeznanBasicAttackCast = {
		loop = false,
		mode = "random",
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_veznan_basicAttack_cast_var1_v1.ogg",
			"kr6_stage18_boss_veznan_basicAttack_cast_var2_v1.ogg",
			"kr6_stage18_boss_veznan_basicAttack_cast_var3_v1.ogg"
		}
	},
	Stage18BossVeznanMidCinematicTeleportIn = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_midCinematic_teleportIn_v1.ogg"
		}
	},
	Stage18BossVeznanMidCinematicExplosion = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_midCinematic_explosion_v1.ogg"
		}
	},
	Stage18BossVeznanDeathFullSeq = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_boss_veznan_death_fullSEQ_v1.ogg"
		}
	},
	Stage18BossVeznanMolochDefeatFullSeq = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_stage18_moloch_defeat_fullSEQ_v1.ogg"
		}
	},
	Stage18VeznanTowerDoorOpen = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage18_veznan_towerDoor_open_v1.ogg"
		}
	},
	Stage18VeznanTowerDoorClose = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage18_veznan_towerDoor_close_v1.ogg"
		}
	},
	Stage18VeznanLaugh = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage18_veznan_laugh_var3_v1.ogg"
		}
	},
	Stage18TowerDoorOpen = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage18_veznan_towerDoor_open_v1.ogg"
		}
	},
	Stage18TowerDoorClose = {
		loop = false,
		gain = 0.4,
		source_group = "SFX",
		files = {
			"kr6_sfx_stage18_veznan_towerDoor_close_v1.ogg"
		}
	},
	ItemsFatBoyCastOneShot = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_items_fatBoy_cast_oneShot_v1.ogg"
		}
	},
	ItemsFatBoyBellows = {
		source_group = "SFX",
		gain = 0.8,
		loop = false,
		mode = "random",
		files = {
			"kr6_sfx_items_fatBoy_bellows_var1_v1.ogg",
			"kr6_sfx_items_fatBoy_bellows_var2_v1.ogg",
			"kr6_sfx_items_fatBoy_bellows_var3_v1.ogg"
		}
	},
	ItemsFatBoySmallExplosions = {
		source_group = "SFX",
		gain = 0.8,
		loop = false,
		mode = "random",
		files = {
			"kr6_sfx_items_fatBoy_cast_smallExplosions_var1_v1.ogg",
			"kr6_sfx_items_fatBoy_cast_smallExplosions_var2_v1.ogg",
			"kr6_sfx_items_fatBoy_cast_smallExplosions_var3_v1.ogg",
			"kr6_sfx_items_fatBoy_cast_smallExplosions_var4_v1.ogg"
		}
	},
	ItemsGoldBag = {
		loop = false,
		gain = 0.7,
		source_group = "SFX",
		files = {
			"kr6_sfx_items_goldBag_cast_op1_v1.ogg"
		}
	},
	ItemsHeartbox = {
		loop = false,
		gain = 0.9,
		source_group = "SFX",
		files = {
			"kr6_sfx_items_heartbox_cast_op1_v2.ogg"
		}
	},
	kra_sfx_ui_mapDotsAppear_op2_v2 = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kra_sfx_ui_mapDotsAppear_op2_v2.ogg"
		}
	},
	kra_sfx_ui_stageFlagAppear = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kra_sfx_ui_stageFlagAppear_v1.ogg"
		}
	},
	kr4_flag_glow = {
		loop = false,
		gain = 0.2,
		source_group = "SFX",
		files = {
			"kr4_flag_glow.ogg"
		}
	},
	kr4_map_star = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr4_map_star.ogg"
		}
	},
	MeleeSword = {
		source_group = "SWORDS",
		gain = 0.2,
		mode = "sequence",
		ignore = 0.45,
		loop = false,
		files = {
			"Sound_SoldiersFighting-01.ogg",
			"Sound_SoldiersFighting-02.ogg",
			"Sound_SoldiersFighting-03.ogg",
			"Sound_SoldiersFighting-04.ogg",
			"Sound_SoldiersFighting-05.ogg"
		}
	},
	MeleeBlunt = {
		source_group = "SWORDS",
		gain = 0.2,
		mode = "sequence",
		ignore = 0.45,
		loop = false,
		files = {
			"kra_sfx_combat_bigChar_meleeAttack_noSword_var2_v1.ogg",
			"kra_sfx_combat_bigChar_meleeAttack_noSword_var3_v1.ogg"
		}
	},
	MusicMainMenu = {
		source_group = "MUSIC",
		gain = 0.7,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_Menu_v5.ogg"
		}
	},
	MusicMap6 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_WorldMap_v5.ogg"
		}
	},
	MusicCredits = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_Credits_v2.ogg"
		}
	},
	MusicBattlePrep_251 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_comic_v6.ogg"
		}
	},
	MusicBattlePrep_252 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_preparation2_v6.ogg"
		}
	},
	MusicBattlePrep_253 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_preparation1_v3.ogg"
		}
	},
	MusicBattlePrep_254 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_preparation2_v6.ogg"
		}
	},
	MusicBattlePrep_255 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_preparation1_v3.ogg"
		}
	},
	MusicBattlePrep_256 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_preparation2_v6.ogg"
		}
	},
	MusicBattlePrep_257 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_preparation1_v3.ogg"
		}
	},
	MusicBattlePrep_258 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_preparation2_v6.ogg"
		}
	},
	MusicBattlePrep_259 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_preparation1_v3.ogg"
		}
	},
	MusicBattlePrep_260 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_preparation2_v5.ogg"
		}
	},
	MusicBattlePrep_261 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_preparation1_v3.ogg"
		}
	},
	MusicBattlePrep_262 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_preparation2_v5.ogg"
		}
	},
	MusicBattlePrep_263 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_preparation1_v3.ogg"
		}
	},
	MusicBattlePrep_264 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_preparation1_v4.ogg"
		}
	},
	MusicBattlePrep_269 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_preparation1_v4.ogg"
		}
	},
	MusicBattlePrep_265 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_preparation2_v1.ogg"
		}
	},
	MusicBattlePrep_266 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_preparation1_v4.ogg"
		}
	},
	MusicBattlePrep_267 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_preparation2_v1.ogg"
		}
	},
	MusicBattlePrep_268 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battleStage18_preparation_v3.ogg"
		}
	},
	MusicBattle_251 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle1_v3.ogg"
		}
	},
	MusicBattle_252 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle2_v7.ogg"
		}
	},
	MusicBattle_253 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle1_v3.ogg"
		}
	},
	MusicBattle_254 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle2_v7.ogg"
		}
	},
	MusicBattle_255 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle1_v3.ogg"
		}
	},
	MusicBattle_256 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle2_v7.ogg"
		}
	},
	MusicBattle_257 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle1_v3.ogg"
		}
	},
	MusicBattle_258 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_battle2_v7.ogg"
		}
	},
	MusicBattle_259 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_battle1_v3.ogg"
		}
	},
	MusicBattle_260 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_battle2_v5.ogg"
		}
	},
	MusicBattle_261 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_battle1_Variation_v3.ogg"
		}
	},
	MusicBattle_262 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_battle2_v5.ogg"
		}
	},
	MusicBattle_263 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_battle1_v3.ogg"
		}
	},
	MusicBattle_264 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battle1_v4.ogg"
		}
	},
	MusicBattle_269 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battle1_v4.ogg"
		}
	},
	MusicBattle_265 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battle2_v3.ogg"
		}
	},
	MusicBattle_266 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battle1_v4.ogg"
		}
	},
	MusicBattle_267 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battle2_v3.ogg"
		}
	},
	MusicBattle_268 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battleStage18_phase1_v6.ogg"
		}
	},
	MusicBattle_2_18 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battleStage18_phase2_v5.ogg"
		}
	},
	MusicBossFight_8 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t1_boss_v3.ogg"
		}
	},
	MusicBossFight_10 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_battle1_v3.ogg"
		}
	},
	MusicBossFight_11 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_battle1_v3.ogg"
		}
	},
	MusicBossFight_13 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t2_boss_v3.ogg"
		}
	},
	MusicBossPreFight_18 = {
		source_group = "MUSIC",
		gain = 0.6,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battleStage18_stinger-ph2-boss_v1.ogg"
		}
	},
	MusicBossFight_18 = {
		source_group = "MUSIC",
		gain = 0.6,
		loop = true,
		stream = true,
		files = {
			"kr6_bgmusic_t3_battleStage18_bossFight_v7.ogg"
		}
	},
	MusicEndVictory = {
		source_group = "MUSIC",
		gain = 0.7,
		stream = true,
		files = {
			"kr5_bgmusic_t3_boss_victory.ogg"
		}
	},
	MusicSuspense = {
		source_group = "MUSIC",
		gain = 0.7,
		stream = true,
		files = {
			"MusicSuspense.ogg"
		}
	}
}

