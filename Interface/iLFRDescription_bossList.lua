local _, iLFRD = ...

iLFRD.encounters = {
	-- Cataclysm
		-- Dragon Soul
		[416] = { -- The Siege of Wyrmrest Temple
			[1] = {i = 1, q = {}},	-- Morchok 311
			[2] = {i = 2, q = {}}, -- Warlord Zon'ozz 324
			[3] = {i = 3, q = {}}, -- Yor'sahj the Unsleeping 325
			[4] = {i = 4, q = {}}, -- Hagara the Stormbinder 317
		},
		[417] = { -- Fall of Deathwing
			[1] = {i = 5, q = {}}, -- Ultraxion 331
			[2] = {i = 6, q = {}}, -- Warmaster Blackhorn 332
			[3] = {i = 7, q = {}}, -- Spine of Deathwing 318
			[4] = {i = 8, q = {}}, -- Madness of Deathwing 333
		},
	-- Mist of Pandaria
		-- Mogu'shan Vaults
			[527] = { -- Guardians of Mogu'shan
				[1] = {i = 1, q = {}}, -- The Stone Guard 679
				[2] = {i = 2, q = {}}, -- Feng the Accursed 689
				[3] = {i = 3, q = {}}, -- Gara'jal the Spiritbinder 682
			},
			[528] = { -- The Vault of Mysteries
				[1] = {i = 4, q = {}}, -- The Spirit Kings 687
				[2] = {i = 5, q = {}}, -- Elegon 726
				[3] = {i = 6, q = {}}, -- Will of the Emperor 677
			},
		-- Heart of Fear
			[529] = { -- The Dread Approach
				[1] = {i = 1, q = {}},  -- Imperial Vizier Zor'lok 745
				[2] = {i = 2, q = {}}, -- Blade Lord Ta'yak 744
				[3] = {i = 3, q = {}}, -- Garalon 713
			},
			[530] = { -- Nightmare of Shek'zeer
				[1] = {i = 4, q = {}}, -- Wind Lord Mel'jarak 741
				[2] = {i = 5, q = {}}, -- Amber-Shaper Un'sok 737
				[3] = {i = 6, q = {}}, -- Grand Empress Shek'zeer 743
			},
		-- Terrace of Endless Spring
			[526] = { -- Terrace of Endless Spring
				[1] = {i = 1, q = {}}, -- Protectors of the Endless 683
				[2] = {i = 2, q = {}}, -- Tsulong 742
				[3] = {i = 3, q = {}}, -- Lei Shi 729
				[4] = {i = 4, q = {}}, -- Sha of Fear 709
			},
		-- Throne of Thunder
			[610] = { -- Last Stand of the Zandalari
				[1] = {i = 1, q = {}}, -- Jin'rokh the Breaker 827
				[2] = {i = 2, q = {}}, -- Horridon 819
				[3] = {i = 3, q = {}}, -- Council of Elders 816
			},
			[611] = { -- Forgotten Depths
				[1] = {i = 4, q = {}}, -- Tortos 825
				[2] = {i = 5, q = {}}, -- Megaera 821
				[3] = {i = 6, q = {}}, -- Ji-kun 828
			},
			[612] = { -- Halls of Flesh-Shaping
				[1] = {i = 7, q = {}}, -- Durumu the Forgotten 818
				[2] = {i = 8, q = {}}, -- Primordius 820
				[3] = {i = 9, q = {}}, -- Dark Animus 824
			},
			[613] = { -- Pinnacle of Storms
				[1] = {i = 10, q = {}}, -- Iron Qon 817
				[2] = {i = 11, q = {}}, -- Twin Consorts 829
				[3] = {i = 12, q = {}}, -- Lei Shen 832
			},
		-- Siege of Orgrimmar
			[716] = { -- Vale of Eternal Sorrows
				[1] = {i = 1, q = {}}, -- Immerseus 852
				[2] = {i = 2, q = {}}, -- The Fallen Protectors 849
				[3] = {i = 3, q = {}}, -- Norushen 866
				[4] = {i = 4, q = {}}, -- Sha of Pride 867
			},
			[717] = { -- Gates of Retribution
				[1] = {i = 5, q = {}}, -- Galakras 868
				[2] = {i = 6, q = {}}, -- Iron Juggernaut 864
				[3] = {i = 7, q = {}}, -- Kor'kron Dark Shaman 856
				[4] = {i = 8, q = {}}, -- General Nazgrim 850
			},
			[724] = { -- The Underhold
				[1] = {i = 9, q = {}}, -- Malkorok 846
				[2] = {i = 10, q = {}}, -- Spoils of Pandaria 870
				[3] = {i = 11, q = {}}, -- Thok the Bloodthirsty 851
			},
			[725] = { -- Downfall
				[1] = {i = 12, q = {}}, -- Siegecrafter Blackfuse 865
				[2] = {i = 13, q = {}}, -- Paragons of the Klaxxi 853
				[3] = {i = 14, q = {}}, -- Garrosh Hellscream 869
			},
		
	--Warlords of Draenor
		--Highmaul
			[849] = { -- Walled City
				[1] = {i = 1, q = {}}, -- Kargath Bladefist 1128
				[2] = {i = 2, q = {}}, -- The Butcher 971
				[3] = {i = 3, q = {}}, -- Brackenspore 1196
			},
			[850] = { -- Arcane Sanctum
				[1] = {i = 4, q = {}}, -- Tectus 1195
				[2] = {i = 5, q = {}}, -- Twin Ogron 1148
				[3] = {i = 6, q = {}}, -- Ko'ragh 1153
			},
			[851] = { -- Imperator's Rise
				[1] = {i = 7, q = {}}, -- Imperator Mar'gok 1197
			},
			
		-- Blackrock Foundry
			[847] = { -- Slagworks
				[1] = {i = 1, q = {}}, -- Oregorgor 1202
				[2] = {i = 2, q = {}}, -- Gruul 1161
				[3] = {i = 7, q = {}}, -- The Blast Furnace 1154
			},
			[846] = { -- The Black Forge
				[1] = {i = 3, q = {}}, -- Hans'gar and Franzok 1155
				[2] = {i = 5, q = {}}, -- Flamebender Ka'graz 1123
				[3] = {i = 8, q = {}}, -- Kromog 1162
			},
			[848] = { -- Iron Assembly
				[1] = {i = 4, q = {}}, -- Beastlord Darmac 1122
				[2] = {i = 6, q = {}}, -- Operator Thogar 1147
				[3] = {i = 9, q = {}}, -- The Iron Maidens 1203
			},
			[823] = { -- Blackhand's Crucible
				[1] = {i = 10, q = {}}, -- Blackhand 959
			},
			
		-- Hellfire Citadel
			[982] = { -- Hellbreach
				[1] = {i = 1, q = {}}, -- Hellfire Assault 1426
				[2] = {i = 2, q = {}}, -- Iron Reaver 1425
				[3] = {i = 3, q = {}}, -- Kormrok 1392
			},
			[983] = { -- Halls of Blood
				[1] = {i = 4, q = {}}, -- Hellfire High Council 1432
				[2] = {i = 5, q = {}}, -- Kilrogg Deadeye 1396
				[3] = {i = 6, q = {}}, -- Gorefiend 1372
			},
			[984] = { -- Bastion of Shadows
				[1] = {i = 7, q = {}}, -- Shadow-Lord Iskar 1433
				[2] = {i = 8, q = {}}, -- Socrethar the Eternal 1427
				[3] = {i = 11, q = {}}, -- Tyrant Velhari 1394
			},
			[985] = { -- Destructor's Rise
				[1] = {i = 9, q = {}}, -- Fel Lord Zakuun 1391
				[2] = {i = 10, q = {}}, -- Xhul'Horac 1447
				[3] = {i = 12, q = {}}, -- Mannoroth 1395
			},
			[986] = { -- The Black Gate
				[1] = {i = 13, q = {}}, -- Archimonde 1438
			},
	-- Legion
		-- The Emerald Nightmare
			[1287] = { -- Darkbough
				[1] = {i = 1, q = {39351,40159}}, -- Nythendra 1703
				[2] = {i = 2, q = {43546,43547,43548,43549}}, -- Il'gynoth, Heart of Corruption 1738
				[3] = {i = 3, q = {}}, -- Elerethe Renferal 1744
			},
			[1288] = { -- Tormented Guardians
				[1] = {i = 1, q = {}}, -- Ursoc 1667
				[2] = {i = 2, q = {}}, -- Dragons of the Nightmare 1704
				[3] = {i = 3, q = {43902,43904,43906,43908}}, -- Cenarius 1750
			},
			[1289] = { -- Rift of Aln
				[1] = {i = 1, q = {42432,43903,43905,43907,43909,43362}}, -- Xavius 1726
			},
		-- The Nighthold
			[1290] = { -- Arcing Aquaducts
				[1] = {i = 1, q = {}}, -- Skorpyron 1706
				[2] = {i = 2, q = {}}, -- Chromatic Anomaly 1725
				[3] = {i = 3, q = {43882,43889,43890,43891}}, -- Trilliax 1731
			},
			[1291] = { -- Royal Athenaeum
				[1] = {i = 1, q = {}}, -- Spellblade Aluriel 1751
				[2] = {i = 2, q = {43910,43913,43916,43919}}, -- High Botanist Tel'arn 1761
				[3] = {i = 3, q = {}}, -- Star Augur Etraeus 1732
			},
			[1292] = { -- Nightspire
				[1] = {i = 1, q = {}}, -- Tichondrius 1762
				[2] = {i = 2, q = {}}, -- Krosus 1713
				[3] = {i = 3, q = {43911,43914,43917,43920}}, -- Grand Magistric Elisande 1743	
			},
			[1293] = { -- Betrayer's Rise
				[1] = {i = 1, q = {43912,43915,43918,43921}}, -- Gul'dan 1737
			},
		-- Trial of Valor
			[1411] = { -- Trial of Valor
				[1] = {i = 1, q = {}}, -- Odyn
				[2] = {i = 2, q = {}}, -- Guarm
				[3] = {i = 3, q = {}}, -- Helya
			},
}