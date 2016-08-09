local addon, ns = ...

if not IsAddOnLoaded("BigWigs") then return end

-- 調用moniui風格美化
--[[local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
        if event == "ADDON_LOADED" and addon == "BigWigs_Plugins" then
                if not BigWigs then return end
                local bars = BigWigs:GetPlugin("Bars", true)
                if bars then
					--if cfg.StyleBW then
                        bars:SetBarStyle("MonoUI")
					--end
                end
                f:UnregisterEvent("ADDON_LOADED")
        end
end)]]--

-- 預設設置
local SetBW = function()
if(BigWigs3DB) then table.wipe(BigWigs3DB) end
	BigWigs3DB = {
	["namespaces"] = {
		["BigWigs_Plugins_Victory"] = {  --勝利
			["profiles"] = {
				["Default"] = {
					["soundName"] = "None",  --不播放勝利音效
					["blizzMsg"] = false, --不顯示暴雪擊敗動畫
				},
			},
		},
	    ["BigWigs_Plugins_Bars"] = {  --計時條
		    ["profiles"] = {
				["Default"] = {
					["BigWigsEmphasizeAnchor_x"] = 825,  --大型計時條x座標
					["BigWigsEmphasizeAnchor_y"] = 470, --大型計時條y座標
					["BigWigsEmphasizeAnchor_width"] = 180, --大型計時條長度
					["emphasizeGrowup"] = true, --大型計時條向上成長
						
				    ["BigWigsAnchor_x"] = 125, --小型計時條x座標
					["BigWigsAnchor_y"] = 610, --小型計時條y座標
					["BigWigsAnchor_width"] = 160, --小型計時條長度
					["growup"] = false, --小型計時條向上成長
					
					["fontSize"] = 12, --字體大小
					["barStyle"] = "RealUI", --計時條風格
					["outline"] = "OUTLINE", --字體描邊
					["font"] = "預設",

					["emphasizeScale"] = 1.4,  --大型計時條縮放
					--["interceptMouse"] = true, --滑鼠點擊
					},
				},
			},
		["BigWigs_Plugins_Super Emphasize"] = {
			["profiles"] = {
				["Default"] = {
					["voice"] = "English: Amy",  --倒數語音
					["font"] = "預設",
				},
			},
		},
	    ["BigWigs_Plugins_BossBlock"] = {  --首領戰訊息封鎖
		    ["profiles"] = {
			    ["Default"] = {
				    ["blockEmotes"] = false,  --不禁用暴雪首領表情
				    ["blockSpellErrors"] = false,  --不禁止紅字提示
			    },
		    },
	    },		
		["BigWigs_Plugins_Proximity"] = { --距離監視模塊
			["profiles"] = {
				["Default"] = {
					["fontSize"] = 20,
					["width"] = 120,
					["objects"] = {
						["tooltip"] = false, --技能說明tooltip
						["ability"] = false, --技能名稱
						["close"] = false, --關閉
						["sound"] = false,  --音效按鈕
						["background"] = false,  --背景
						},
					["posy"] = 90, --距離監視Y座標
					["posx"] = 340, --距離監視X座標
					["height"] = 120, 
				},
			},
		},
		["BigWigs_Plugins_Messages"] = {
			["profiles"] = {
				["Default"] = {
					["chat"] = true,  --發送訊息到聊天框
					["monochrome"] = false, --禁用單色顯示
					["outline"] = "OUTLINE", --字體描邊
					["fontSize"] = 20, --字體大小
						["BWEmphasizeMessageAnchor_x"] = 550, --強調訊息X座標
						["BWEmphasizeMessageAnchor_y"] = 660, --強調訊息Y座標
						["BWMessageAnchor_y"] = 640, --訊息Y座標
						["BWMessageAnchor_x"] = 810, --訊息X座標
					},
				},
			},			
		["BigWigs_Plugins_Alt Power"] = {  --特殊能量
			["profiles"] = {
				["Default"] = {
					["posx"] = 388,
					["fontSize"] = 16,
					["font"] = "預設",
					["posy"] = 735,
					["fontOutline"] = "OUTLINE",
				},
			},
		},
		["BigWigs_Plugins_Statistics"] = {  --統計
			["profiles"] = {
				["Default"] = {
					["printNewBestKill"] = false,
					["saveBestKill"] = false,
				},
			},
		},
	},
	["profiles"] = {
		["Default"] = {
			["raidicon"] = false,  --禁用自動標記
			["showZoneMessages"] = false,  --關閉區域訊息
			["fakeDBMVersion"] = true,  --假裝我是dbm
		},
	},
}
BigWigs3IconDB = {
	["hide"] = true,  --隱藏小地圖圖示
}
end



-- 載入設置
StaticPopupDialogs.SET_BW = {
        text = "載入BigWigs布局(僅適用1920*1200)",
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept =  function() SetBW() ReloadUI() end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = true,
        preferredIndex = 5,
}
SLASH_SETBW1 = "/setbw"
SlashCmdList["SETBW"] = function()
        StaticPopup_Show("SET_BW")
end


