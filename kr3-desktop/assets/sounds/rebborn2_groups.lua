local hero_oberon = {
	"EnchantedSlash.ogg",
	"hero_oberon_taunt_1.ogg", "hero_oberon_taunt_2.ogg", "hero_oberon_taunt_3.ogg", "hero_oberon_taunt_4.ogg", "hero_oberon_death.ogg"
}

local hero_deadeye = {
	"hero_deadeye_death.wav", "hero_deadeye_taunt_1.wav", "hero_deadeye_taunt_2.wav", "hero_deadeye_taunt_3.wav",
	"hero_deadeye_taunt_4.wav", "hero_deadeye_taunt_5.wav", "hero_deadeye_taunt_6.wav", "hero_deadeye_taunt_7.wav",
	"hero_deadeye_taunt_8.wav", "hero_deadeye_taunt_9.wav", "hero_deadeye_taunt_10.wav",
	"kr4_linirea_knight_rider_charge_loop.ogg", "kr4_linirea_knight_rider_charge_loopstart.ogg", "kr4_linirea_knight_rider_charge_loopend.ogg",
	"DeadeyeWhistle.wav", "DeadeyeShotgunSFX.ogg"
}

local hero_zezitra = {
	"hero_zezitra_taunt_1.wav", "hero_zezitra_taunt_2.wav", "hero_zezitra_taunt_3.wav", "hero_zezitra_taunt_4.wav",
	"hero_zezitra_taunt_5.wav", "hero_zezitra_taunt_6.wav", "hero_zezitra_death.wav",
	"Zezitra Shield.wav", "Zezitra Possession.wav", "RayZezitra.wav"
}

local hero_ember = {
	"hero_ember_krakatoa.wav", "hero_ember_taunt_1.wav", "hero_ember_taunt_2.wav", "hero_ember_taunt_3.wav", "hero_ember_taunt_4.wav", "hero_ember_death.wav",
	"EmberCrackOfDoom.wav", "EmberVolcanoRise.wav", "EmberVolcanoSink.wav", "EmberVolcanoProjectileLaunch.wav", "EmberVolcanoProjectileImpact.wav"
}

local hero_penumbra = {
	"penumbra_shootray.ogg", "Penumbra_Death.ogg", "Penumbra_Black_Tide.ogg", "Penumbra_Shadow_Tsunami.wav", "Penumbra_Pillar_1.wav", "Penumbra_Pillar_2.wav",
	"hero_penumbra_taunt-1.wav", "hero_penumbra_taunt-2.wav", "hero_penumbra_taunt-3.wav", "hero_penumbra_taunt-4.wav", "hero_penumbra_taunt-5.wav", "hero_penumbra_taunt-6.wav"
}

local hammerhold_stage88_sounds = {
	"MusicBattlePrep_88",
	"MusicBattle_88"
}

local hammerhold_stage89_sounds = {
	"MusicBattlePrep_89",
	"MusicBattle_89",
	"MusicBossFightReBBBornHammerhold",
	"MusicBossFightReBBBornHammerhold2"
}

local hammerhold_stage90_sounds = {
	"MusicBattlePrep_90",
	"MusicBattle_90",
	"MusicBossFightReBBBornHammerhold",
	"MusicBossFightReBBBornHammerhold2"
}

return {
	hero_oberon = {files = hero_oberon},
	hero_deadeye = {files = hero_deadeye},
	hero_zezitra = {files = hero_zezitra},
	hero_ember = {files = hero_ember},
	hero_penumbra = {files = hero_penumbra},
	HammerholdEnemySounds = {
		files = {"FremenSpawnSFX.ogg", "Set - Channel.ogg", "Set - Channel Finish.wav", "SetResurrection.ogg", "SetResurrection2.ogg", "Sand Monk Spell.wav", "boss_umbra_openportal.ogg", "Malagar Teleport.wav"}
	},
	SphinxSounds = {files = {"SphinxFail.ogg"}},
	music_stage88_rebborn = {sounds = hammerhold_stage88_sounds},
	music_stage89_rebborn = {sounds = hammerhold_stage89_sounds},
	music_stage90_rebborn = {sounds = hammerhold_stage90_sounds}
}
