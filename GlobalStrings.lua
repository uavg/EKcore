--- 人物
CHAT_FLAG_AFK = "[AFK] ";
CHAT_FLAG_DND = "[DND] ";
CHAT_FLAG_GM = "[GM] ";

--- 密語[TO][FROM]
CHAT_WHISPER_GET = "[from] %s:\32";
CHAT_WHISPER_INFORM_GET = "[to] %s:\32";
CHAT_BN_WHISPER_GET = "[from] %s:\32"
CHAT_BN_WHISPER_INFORM_GET = "[to] %s:\32";

--- 公會[G][O]
CHAT_GUILD_GET = "[|Hchannel:Guild|hG|h] %s:\32";
CHAT_OFFICER_GET = "[|Hchannel:o|hO|h] %s:\32";

--- 小隊[P][PL][DG]
CHAT_PARTY_GET = "[|Hchannel:party|hP|h] %s:\32";
CHAT_PARTY_LEADER_GET = "[|Hchannel:party|hPL|h] %s:\32";
CHAT_PARTY_GUIDE_GET = "[|Hchannel:party|hDG|h] %s:\32";

--- 團隊[R][L][RW!]
--CHAT_MONSTER_PARTY_GET = "[|Hchannel:raid|hR|h] %s:\32";
CHAT_RAID_GET = "[|Hchannel:raid|hR|h] %s:\32";
CHAT_RAID_WARNING_GET = "[RW!] %s:\32";
CHAT_RAID_LEADER_GET = "[|Hchannel:raid|hL|h] %s:\32";

CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[I]|h %s:\32";
CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[IL]|h %s:\32";

--- 戰場[BG][BL]
CHAT_BATTLEGROUND_GET = "[|Hchannel:Battleground|hBG|h] %s:\32";
CHAT_BATTLEGROUND_LEADER_GET = "[|Hchannel:Battleground|hBL|h] %s:\32";

--- 上下線提示，下線紅色上線綠色
BN_INLINE_TOAST_FRIEND_OFFLINE = "\124TInterface\\FriendsFrame\\UI-Toast-ToastIcons.tga:16:16:0:0:128:64:2:29:34:61\124t%s has gone |cffff0000offline|r.";
BN_INLINE_TOAST_FRIEND_ONLINE = "\124TInterface\\FriendsFrame\\UI-Toast-ToastIcons.tga:16:16:0:0:128:64:2:29:34:61\124t%s has come |cff00ff00online|r.";

ERR_FRIEND_OFFLINE_S = "%s has gone |cffff0000offline|r.";
ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h has come |cff00ff00online|r.";

--- 專業技能提升 [你的附魔技能提升到102→附魔 102]
ERR_SKILL_UP_SI = "%s |cff1eff00%d|r";

--- 改變頻道提示 [加入頻道→+][離開頻道→-][改變頻道→>]
CHAT_YOU_CHANGED_NOTICE = ">|Hchannel:%d|h[%s]|h";
CHAT_YOU_CHANGED_NOTICE_BN = ">|Hchannel:CHANNEL:%d|h[%s]|h";
CHAT_YOU_JOINED_NOTICE = "+|Hchannel:%d|h[%s]|h";
CHAT_YOU_JOINED_NOTICE_BN = "+|Hchannel:CHANNEL:%d|h[%s]|h";
CHAT_YOU_LEFT_NOTICE = "-|Hchannel:%d|h[%s]|h";
CHAT_YOU_LEFT_NOTICE_BN = "-|Hchannel:CHANNEL:%d|h[%s]|h";

--- 物品 [裝備綁定→BOE][拾取綁定→BOP][使用綁定→Binds when used][靈魂綁定→SoulBound][物品等級→iLVL]
ITEM_BIND_ON_EQUIP = "BOE";
ITEM_ACCOUNTBOUND = "BOA";
ITEM_BIND_ON_PICKUP = "BOP";
ITEM_BIND_TO_ACCOUNT = "BOA";
ITEM_BIND_TO_BNETACCOUNT = "BOA";
ITEM_BNETACCOUNTBOUND = "BOA";
ITEM_BIND_ON_USE = "BOU";
ITEM_SOULBOUND = "SoulBound"
ITEM_LEVEL = "|cff00ffffiLvl: %d|r"; -- Blue color

--- 魔法製造的物品
ITEM_CONJURED = "魔法";
ITEM_CREATED_BY = ""; -- No creator name
ITEM_LEVEL_AND_MIN = "等級%d (min: %d)";
ITEM_LEVEL_RANGE = "等級%d - %d";
ITEM_LEVEL_RANGE_CURRENT = "等級%d - %d (%d)";
ITEM_LIMIT_CATEGORY_MULTIPLE = "裝備唯一: %s (%d)";

--- 提示AH賣出
ERR_AUCTION_SOLD_S = "|cff1eff00%s|r |cffffffffsold.|r";

--- 戰鬥等級
ITEM_MOD_CRIT_MELEE_RATING = "+%s近戰爆擊";
ITEM_MOD_CRIT_MELEE_RATING_SHORT = "近戰爆擊";
ITEM_MOD_CRIT_RANGED_RATING = "+%s遠程爆擊 ";
ITEM_MOD_CRIT_RANGED_RATING_SHORT = "遠程爆擊";
ITEM_MOD_CRIT_RATING = "+%s爆擊";
ITEM_MOD_CRIT_RATING_SHORT = "爆擊";
ITEM_MOD_CRIT_SPELL_RATING = "+%s法術爆擊 ";
ITEM_MOD_CRIT_SPELL_RATING_SHORT = "法術爆擊";
ITEM_MOD_VERSATILITY = "全能";
ITEM_MOD_EXTRA_ARMOR = "+%s護甲";
ITEM_MOD_EXTRA_ARMOR_SHORT = "護甲";
--ITEM_MOD_CR_MULTISTRIKE_SHORT = "雙擊";
--TEXT_MODE_A_STRING_RESULT_MULTISTRIKE = "(雙擊)"; --戰鬥紀錄
ITEM_SOCKETABLE = ""

--STAT_MULTISTRIKE = "雙擊"; --人物介面
STAT_VERSATILITY = "全能";

ENCHANTED_TOOLTIP_LINE = "|cff00ffff%s|r";
ARMOR_TEMPLATE = "%s護甲";
DAMAGE_TEMPLATE = "%s - %s";
DPS_TEMPLATE = "%s DPS";

EMPTY_SOCKET_RED = "紅";
EMPTY_SOCKET_YELLOW = "黃";
EMPTY_SOCKET_BLUE = "藍";
EMPTY_SOCKET_META = "變換";
EMPTY_SOCKET_NO_COLOR = "無";
EMPTY_SOCKET_PRISMATIC = "無";
ITEM_SOCKET_BONUS = "獎勵: %s";

--- TOOLTIP [售價→Price][英雄模式→Heroic]
--SELL_PRICE = "$$";

---拾取 [你拾取了：[霜紋布]。→+[霜紋布]] 拾取金錢 [你拾取了2銅幣。→+2O]

LOOT_ITEM = "%s + %s";
LOOT_ITEM_BONUS_ROLL = "%s + %s (bonus)";
LOOT_ITEM_BONUS_ROLL_MULTIPLE = "%s + %sx%d (bonus)";
LOOT_ITEM_BONUS_ROLL_SELF = "+ %s (bonus)";
LOOT_ITEM_BONUS_ROLL_SELF_MULTIPLE = "+ %sx%d (bonus)";
LOOT_ITEM_MULTIPLE = "%s + %sx%d";
LOOT_ITEM_PUSHED = "%s + %s";
LOOT_ITEM_PUSHED_MULTIPLE = "%s + %sx%d";
LOOT_ITEM_SELF = "+ %s";
LOOT_ITEM_SELF_MULTIPLE = "+ %s x%d";
LOOT_ITEM_PUSHED_SELF = "+ %s";
LOOT_ITEM_PUSHED_SELF_MULTIPLE = "+ %s x%d";
--退回
LOOT_ITEM_REFUND = "+ %s";
LOOT_ITEM_REFUND_MULTIPLE = "+ %sx%d";
--製造
LOOT_ITEM_CREATED_SELF = "+ %s";
LOOT_ITEM_CREATED_SELF_MULTIPLE = "+ %sx%d";
--金錢
LOOT_MONEY = "|cff00a956+|r |cffffffff%s";
YOU_LOOT_MONEY = "|cff00a956+|r |cffffffff%s";
LOOT_MONEY_SPLIT = "|cff00a956+|r |cffffffff%s";
COPPER_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0\124t";
SILVER_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-SilverIcon:0:0:2:0\124t";
GOLD_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0\124t";
--通貨
CURRENCY_GAINED = "+ %s";
CURRENCY_GAINED_MULTIPLE = "+ %s x%d";
CURRENCY_GAINED_MULTIPLE_BONUS = "+ %s x%d (Bonus)";
--擲骰
LOOT_ROLL_ALL_PASSED = "|HlootHistory:%d|h[Loot]|h: 全體放棄 %s";
LOOT_ROLL_PASSED_AUTO = "%s 自動放棄 %s";
LOOT_ROLL_PASSED_AUTO_FEMALE = "%s 自動放棄 %s";
LOOT_ROLL_PASSED_SELF = "|HlootHistory:%d|h[Loot]|h: 放棄 %s";
LOOT_ROLL_PASSED_SELF_AUTO = "|HlootHistory:%d|h[Loot]|h: 自動放棄 %s";

--- BUFF時間替換 天/時/分/秒→d/h/m/無
DAY_ONELETTER_ABBR    = "|cffffffff%dd|r";
HOUR_ONELETTER_ABBR   = "|cffffffff%dh|r";
MINUTE_ONELETTER_ABBR = "|cffffffff%dm|r";
SECOND_ONELETTER_ABBR = "|cffffffff%d|r";