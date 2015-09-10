local L = LibStub("AceLocale-3.0"):NewLocale("StatWeightScore", "zhTW");
if not L then return end

-- L["AlternativeStatDisplayNames_Crit"] = ""
L["AlternativeStatDisplayNames_Spellpower"] = "法術能量" -- Needs review
L["CharacterPane_CM_Tooltip"] = "總分不適用於降低裝備等級的挑戰模式地城中"
L["CharacterPane_Tooltip_Title"] = "評量屬性分數"
L["CharacterPane_Tooltip_Title_Text"] = "在%s 專精下所有現有裝備物品的總屬性權重分數"
L["Culture"] = "enUS"
L["DecimalSeparator"] = "%."
L["Error_MultiplePrimaryStatsSelected"] = "您只能選擇一個主要屬性(敏捷、力量或智力)"
L["GemsDisplayFormat"] = "%s 珠寶"
-- L["Matcher_BlackhandTrinket2_ArgOrder"] = ""
-- L["Matcher_BlackhandTrinket2_Pattern"] = ""
-- L["Matcher_BlackhandTrinket3_ArgOrder"] = ""
-- L["Matcher_BlackhandTrinket3_Pattern"] = ""
L["Matcher_BlackhandTrinket_ArgOrder"] = "duration value stat tick maxstack ppm"
L["Matcher_BlackhandTrinket_Pattern"] = "^Equip: Your [%a ]- have a chance to trigger [%a' ]- for (%d+) sec.  While [%a' ]- is active, you gain ([%d,%. ]+) ([%a ]-) every ([%d,%. ]+) sec, stacking up to ([%d,%. ]+) times%.  %(Approximately ([%d%.]+) procs per minute%)$"
L["Matcher_BonusArmor_ArgOrder"] = "value"
L["Matcher_BonusArmor_Pattern"] = "^%+(%d+) ?BONUS_ARMOR$"
L["Matcher_ICD2_ArgOrder"] = "value stat duration chance cd"
L["Matcher_ICD2_Pattern"] = "^Equip: Your attacks have a chance to grant you ([%d,%. ]+) ([%a ]-) for (%d+) sec%.  %((%d+)%% chance, (%d+) sec cooldown%)$"
-- L["Matcher_ICD3_ArgOrder"] = ""
-- L["Matcher_ICD3_Pattern"] = ""
L["Matcher_ICD_ArgOrder"] = "value stat duration chance cd"
L["Matcher_ICD_Pattern"] = "^Equip: Each time your attacks hit, you have a chance to gain ([%d,%. ]+) ([%a ]-) for (%d+) sec%.  %((%d+)%% chance, (%d+) sec cooldown%)$"
-- L["Matcher_InsigniaOfConquest2_ArgOrder"] = ""
-- L["Matcher_InsigniaOfConquest2_Pattern"] = ""
L["Matcher_InsigniaOfConquest_ArgOrder"] = "value stat duration"
L["Matcher_InsigniaOfConquest_Pattern"] = "^Equip: When you deal damage you have a chance to gain ([%d,%. ]+) ([%a ]-) for (%d+) sec%."
L["Matcher_Partial_CdMin"] = "(%d+) Min"
L["Matcher_Partial_CdSec"] = "(%d+) Sec"
L["Matcher_Precheck_BonusArmor"] = "BONUS_ARMOR$"
L["Matcher_Precheck_Equip"] = "^裝備:"
L["Matcher_Precheck_Use"] = "^使用:"
-- L["Matcher_RPPM2_ArgOrder"] = ""
-- L["Matcher_RPPM2_Pattern"] = ""
-- L["Matcher_RPPM3_ArgOrder"] = ""
-- L["Matcher_RPPM3_Pattern"] = ""
-- L["Matcher_RPPM4_ArgOrder"] = ""
-- L["Matcher_RPPM4_Pattern"] = ""
L["Matcher_RPPM_ArgOrder"] = "value stat duration ppm"
L["Matcher_RPPM_Pattern"] = "^Equip: Your attacks have a chance to grant ([%d,%. ]+) ([%a ]-) for (%d+) sec%.  %(Approximately ([%d%.]+) procs per minute%)$"
L["Matcher_SoliumBand_ArgOrder"] = "type duration ppm"
L["Matcher_SoliumBand_BuffType_Greater"] = "Greater"
L["Matcher_SoliumBand_Pattern"] = "^Equip: Your attacks have a chance to grant Archmage's ?(%a-) Incandescence for (%d+) sec%.  %(Approximately ([%d%.]+) procs per minute%)$"
L["Matcher_StatTooltipParser_Armor"] = "^(%d+) (RESISTANCE0_NAME)$"
-- L["Matcher_StatTooltipParser_Armor_ArgOrder"] = ""
L["Matcher_StatTooltipParser_DPS"] = "^%(([%d,%. ]+) ([%a ]+)%)$"
-- L["Matcher_StatTooltipParser_DPS_ArgOrder"] = ""
L["Matcher_StatTooltipParser_Stat"] = "^%+([%d,%. ]+) ([%a ]+)$"
-- L["Matcher_StatTooltipParser_Stat_ArgOrder"] = ""
L["Matcher_StoneOfFire_ArgOrder"] = "value duration"
L["Matcher_StoneOfFire_Pattern"] = "^Equip: When you heal or deal damage you have a chance to increase your Strength, Agility, or Intellect by ([%d,%. ]+) for (%d+) sec%.  Your highest stat is always chosen%.$"
L["Matcher_Use2_ArgOrder"] = "value stat duration cd"
L["Matcher_Use2_Pattern"] = "^Use: Grants ([%d,%. ]+) ([%a ]-) for (%d+) sec%. %(([%d%a ]-) Cooldown%)$"
-- L["Matcher_Use3_ArgOrder"] = ""
-- L["Matcher_Use3_Pattern"] = ""
-- L["Matcher_Use4_ArgOrder"] = ""
-- L["Matcher_Use4_Pattern"] = ""
L["Matcher_Use_ArgOrder"] = "stat value duration cd"
L["Matcher_Use_Pattern"] = "^Use: Increases y?o?u?r? ?([%a ]-) by ([%d,%. ]+) for (%d+) sec%. %(([%d%a ]-) Cooldown%)$"
L["Offhand_DPS"] = "副手秒傷"
L["Offhand_Score"] = "副手分數"
L["Options_BlankLineMainAbove_Label"] = "上方加入空行(主要)"
L["Options_BlankLineMainAbove_Tooltip"] = "在主要提示中屬性評分資訊之上顯示空白行"
L["Options_BlankLineMainBelow_Label"] = "下方加入空行(主要)"
L["Options_BlankLineMainBelow_Tooltip"] = "在主要提示中屬性評分資訊之下顯示空白行"
L["Options_BlankLineRefAbove_Label"] = "上方加入空行(比較)"
L["Options_BlankLineRefAbove_Tooltip"] = "在比較提示中屬性評分資訊之上顯示空白行(例：你在一個物品上同時按下Shift鍵)"
L["Options_BlankLineRefBelow_Label"] = "下方加入空行(比較)"
L["Options_BlankLineRefBelow_Tooltip"] = "在比較提示中屬性評分資訊之下顯示空白行(例：你在一個物品上同時按下Shift鍵)"
L["Options_Compare_Character"] = "角色分數總計"
L["Options_Compare_Item"] = "裝備物品分數"
L["Options_Compare_Label"] = "百分比獲取比較為"
L["Options_Compare_Tooltip"] = "是否在提示中顯示與現有裝備物品或角色總分的比較百分比值。"
L["Options_CreateNewSpec"] = "創建新的專精"
L["Options_DeleteSpec"] = "刪除專精"
L["Options_DeleteSpec_Confirm"] = "您確定想要刪除專精 '%s'?"
L["Options_DuplicateSpec"] = "複製專精"
L["Options_EnableCmMode_Label"] = "啟用挑戰模式"
L["Options_EnableCmMode_Tooltip"] = "當在挑戰模式地城時，直接從提示讀取屬性 - 那些是挑戰模式正確的屬。只有當你按下Shift鍵，並且有啟用此選項，並且在挑戰模式地城裡比較才有效。"
L["Options_Enabled"] = "啟用"
L["Options_EnabledGlobal_Tooltip"] = "在提示中啟用屬性評分的顯示"
L["Options_EnabledSpec_Tooltip"] = "在提示中啟用特定專精屬性評分的顯示"
L["Options_EnchantLevel_Label"] = "珠寶等級"
L["Options_EnchantLevel_Tooltip"] = "空插槽使用什麼等級的珠寶"
L["Options_Export"] = "匯出"
L["Options_Export_Label"] = "匯出輸出"
L["Options_Export_Title"] = "匯出權重"
L["Options_ExportType_Label"] = "匯出到"
L["Options_ExportType_Tooltip"] = "選擇匯出格式"
L["Options_ForceSelectedGemStat_Label"] = "強制選擇珠寶 屬性/數值"
L["Options_ForceSelectedGemStat_Tooltip"] = "如果物品已經有個插槽插入了寶石，不使用那塊寶石進行計算，而是使用專精設置中基於等級與屬性的最佳寶石"
L["Options_GemStat_Best"] = "最佳屬性"
L["Options_GemStat_Label"] = "珠寶屬性"
L["Options_GemStat_Tooltip"] = "假定空的珠寶插槽要使用什麼屬性。最佳屬性會自動選擇最佳的評定屬性。"
L["Options_GetStats_Label"] = "獲取屬性來源"
L["Options_GetStats_ParseTooltip"] = "物品提示"
L["Options_GetStats_Tooltip"] = "是否從wow api調用獲取屬性  (GetItemStats()) 或是從提示中解析。從提示解析有一定的優勢 (例如允許您可以計算副專精灰暗的屬性)，但需要所使用的語言支持。"
L["Options_GetStats_WoWAPI"] = "WoW API"
L["Options_Import_Label"] = "匯入"
L["Options_Import_Title"] = "匯入權重"
L["Options_Import_Tooltip"] = "複製&貼上來輸入匯入"
L["Options_ImportType_Label"] = "匯入來源"
L["Options_ImportType_Tooltip"] = "選擇匯入來源類型"
L["Options_NormalizeWeights_Label"] = "標準值"
L["Options_NormalizeWeights_Tooltip"] = "調整計算的值- 所以主屬性會是1.0，其他屬性會以此為標準調整"
L["Options_Open"] = "開啟設置"
L["Options_Order_Label"] = "排序"
L["Options_Percentage_Change"] = "變動"
L["Options_Percentage_Difference"] = "差異"
L["Options_Percentage_Label"] = "百分比計算為"
L["Options_Percentage_Tooltip"] = "是否在提示中顯示百分比變動或差異的百分比值。"
L["Options_SelectStats_Label"] = "選擇屬性"
L["Options_SelectStats_Tooltip"] = "選擇跟此專精相關的屬性"
L["Options_ShowStatsPane_Label"] = "顯示總分"
L["Options_ShowStatsPane_Tooltip"] = "是否在角色視窗顯示總分"
L["Options_Specialization_Label"] = "專精"
L["Options_Specialization_Tooltip"] = "此屬性權重設置的標籤"
L["Options_StatWeightsSetup"] = "屬性權重設置"
L["Options_Weights_Open"] = "開啟屬性權重的設置"
L["Options_Weights_Section"] = "屬性權重"
L["StatPaneCategoryTitle"] = "屬性評量分數"
L["ThousandSeparator"] = ","
L["TooltipMessage_StatScore"] = "屬性評分"
L["TooltipMessage_WithGem"] = "包含珠寶"
L["TooltipMessage_WithProcAverage"] = "包含平均觸發"
L["TooltipMessage_WithUseAverage"] = "包含平均使用冷卻"
L["Warning"] = "警告"
L["WelcomeMessage"] = "已載入。 v%s by Necroskillz"
