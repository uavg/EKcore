local _, iLFRD = ...

iLFRD.encounters = {
	-- Cataclysm
		-- Dragon Soul
		[416] = { -- The Siege of Wyrmrest Temple
			[1] = 1,	-- Morchok 311
			[2] = 2, -- Warlord Zon'ozz 324
			[3] = 3, -- Yor'sahj the Unsleeping 325
			[4] = 4, -- Hagara the Stormbinder 317
		},
		[417] = { -- Fall of Deathwing
			[1] = 5, -- Ultraxion 331
			[2] = 6, -- Warmaster Blackhorn 332
			[3] = 7, -- Spine of Deathwing 318
			[4] = 8, -- Madness of Deathwing 333
		},
	-- Mist of Pandaria
		-- Mogu'shan Vaults
			[527] = { -- Guardians of Mogu'shan
				[1] = 1, -- The Stone Guard 679
				[2] = 2, -- Feng the Accursed 689
				[3] = 3, -- Gara'jal the Spiritbinder 682
			},
			[528] = { -- The Vault of Mysteries
				[1] = 4, -- The Spirit Kings 687
				[2] = 5, -- Elegon 726
				[3] = 6, -- Will of the Emperor 677
			},
		-- Heart of Fear
			[529] = { -- The Dread Approach
				[1] = 1,  -- Imperial Vizier Zor'lok 745
				[2] = 2, -- Blade Lord Ta'yak 744
				[3] = 3, -- Garalon 713
			},
			[530] = { -- Nightmare of Shek'zeer
				[1] = 4, -- Wind Lord Mel'jarak 741
				[2] = 5, -- Amber-Shaper Un'sok 737
				[3] = 6, -- Grand Empress Shek'zeer 743
			},
		-- Terrace of Endless Spring
			[526] = { -- Terrace of Endless Spring
				[1] = 1, -- Protectors of the Endless 683
				[2] = 2, -- Tsulong 742
				[3] = 3, -- Lei Shi 729
				[4] = 4, -- Sha of Fear 709
			},
		-- Throne of Thunder
			[610] = { -- Last Stand of the Zandalari
				[1] = 1, -- Jin'rokh the Breaker 827
				[2] = 2, -- Horridon 819
				[3] = 3, -- Council of Elders 816
			},
			[611] = { -- Forgotten Depths
				[1] = 4, -- Tortos 825
				[2] = 5, -- Megaera 821
				[3] = 6, -- Ji-kun 828
			},
			[612] = { -- Halls of Flesh-Shaping
				[1] = 7, -- Durumu the Forgotten 818
				[2] = 8, -- Primordius 820
				[3] = 9, -- Dark Animus 824
			},
			[613] = { -- Pinnacle of Storms
				[1] = 10, -- Iron Qon 817
				[2] = 11, -- Twin Consorts 829
				[3] = 12, -- Lei Shen 832
			},
		-- Siege of Orgrimmar
			[716] = { -- Vale of Eternal Sorrows
				[1] = 1, -- Immerseus 852
				[2] = 2, -- The Fallen Protectors 849
				[3] = 3,-- Norushen 866
				[4] = 4, -- Sha of Pride 867
			},
			[717] = { -- Gates of Retribution
				[1] = 5, -- Galakras 868
				[2] = 6, -- Iron Juggernaut 864
				[3] = 7, -- Kor'kron Dark Shaman 856
				[4] = 8, -- General Nazgrim 850
			},
			[724] = { -- The Underhold
				[1] = 9, -- Malkorok 846
				[2] = 10, -- Spoils of Pandaria 870
				[3] = 11, -- Thok the Bloodthirsty 851
			},
			[725] = { -- Downfall
				[1] = 12, -- Siegecrafter Blackfuse 865
				[2] = 13, -- Paragons of the Klaxxi 853
				[3] = 14, -- Garrosh Hellscream 869
			},
		
	--Warlords of Draenor
		--Highmaul
			[849] = { -- Walled City
				[1] = 1, -- Kargath Bladefist 1128
				[2] = 2, -- The Butcher 971
				[3] = 3, -- Brackenspore 1196
			},
			[850] = { -- Arcane Sanctum
				[1] = 4, -- Tectus 1195
				[2] = 5, -- Twin Ogron 1148
				[3] = 6, -- Ko'ragh 1153
			},
			[851] = { -- Imperator's Rise
				[1] = 7, -- Imperator Mar'gok 1197
			},
			
		-- Blackrock Foundry
			[847] = { -- Slagworks
				[1] = 1, -- Oregorgor 1202
				[2] = 2, -- Gruul 1161
				[3] = 7, -- The Blast Furnace 1154
			},
			[846] = { -- The Black Forge
				[1] = 3, -- Hans'gar and Franzok 1155
				[2] = 5, -- Flamebender Ka'graz 1123
				[3] = 8, -- Kromog 1162
			},
			[848] = { -- Iron Assembly
				[1] = 4, -- Beastlord Darmac 1122
				[2] = 6, -- Operator Thogar 1147
				[3] = 9, -- The Iron Maidens 1203
			},
			[823] = { -- Blackhand's Crucible
				[1] = 10, -- Blackhand 959
			},
			
		-- Hellfire Citadel
			[982] = { -- Hellbreach
				[1] = 1, -- Hellfire Assault 1426
				[2] = 2, -- Iron Reaver 1425
				[3] = 3, -- Kormrok 1392
			},
			[983] = { -- Halls of Blood
				[1] = 4, -- Hellfire High Council 1432
				[2] = 5, -- Kilrogg Deadeye 1396
				[3] = 6, -- Gorefiend 1372
			},
			[984] = { -- Bastion of Shadows
				[1] = 7, -- Shadow-Lord Iskar 1433
				[2] = 8, -- Socrethar the Eternal 1427
				[3] = 11, -- Tyrant Velhari 1394
			},
			[985] = { -- Desturctor's Rise
				[1] = 9, -- Fel Lord Zakuun 1391
				[2] = 10, -- Xhul'Horac 1447
				[3] = 12, -- Mannoroth 1395
			},
			[986] = { -- The Black Gate
				[1] = 13, -- Archimonde 1438
			},
	-- Legion
		-- The Emerald Nightmare
			[1287] = { -- Darkbough
				[1] = 1, -- Nythendra 1703
				[3] = 3, -- Il'gynoth, Heart of Corruption 1738
				[2] = 5, -- Elerethe Renferal 1744
			},
			[1288] = { -- Tormented Guardians
				[1] = 2, -- Ursoc 1667
				[3] = 4, -- Dragons of the Nightmare 1704
				[2] = 6, -- Cenarius 1750
			},
			[1289] = { -- Rift of Aln
				[1] = 7, -- Xavius 1726
			},
		-- The Nighthold
			[1290] = { -- Arcing Aquaducts
				[1] = 1, -- Skorpyron 1706
				[2] = 2, -- Chromatic Anomaly 1725
				[3] = 3, -- Trilliax 1731
			},
			[1291] = { -- Royal Athenaeum
				[1] = 4, -- Spellblade Aluriel 1751
				[2] = 6, -- High Botanist Tel'arn 1761
				[3] = 8, -- Star Augur Etraeus 1732
			},
			[1292] = { -- Nightspire
				[1] = 5, -- Tichondrius 1762
				[2] = 7, -- Krosus 1713
				[3] = 9, -- Grand Magistric Elisande 1743	
			},
			[1293] = { -- Betrayer's Rise
				[1] = 10, -- Gul'dan 1737
			},
}