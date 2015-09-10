local SWS_ADDON_NAME, StatWeightScore = ...;
local CharacterModule = StatWeightScore:NewModule(SWS_ADDON_NAME.."Character");

local ScoreModule;
local SpecModule;
local ScanningTooltipModule;

local L;
local Utils;

local ScoreCache = {};

function CharacterModule:OnInitialize()
    ScoreModule = StatWeightScore:GetModule(SWS_ADDON_NAME.."Score");
    SpecModule = StatWeightScore:GetModule(SWS_ADDON_NAME.."Spec");
    ScanningTooltipModule = StatWeightScore:GetModule(SWS_ADDON_NAME.."ScanningTooltip");
    L = StatWeightScore.L;
    Utils = StatWeightScore.Utils;

    self:AddToStatsPane();

    self:RegisterMessage(SWS_ADDON_NAME.."ConfigChanged", "UpdateStatCategory");

    local eventFrame = CreateFrame("Frame");
    eventFrame:RegisterUnitEvent("UNIT_ATTACK_SPEED", "player");
    eventFrame:RegisterUnitEvent("UNIT_AURA", "player");
    eventFrame:RegisterUnitEvent("UNIT_STATS", "player");
    eventFrame:RegisterUnitEvent("UNIT_SPELL_HASTE", "player");

    eventFrame:SetScript("OnEvent", function()
        self:InvalidateScoreCache();
    end)
end

function CharacterModule:InvalidateScoreCache()
    table.wipe(ScoreCache);
end

function CharacterModule:UpdateStatCategory()
    self:InvalidateScoreCache();

    if(StatWeightScore.db.profile.ShowStatsPane) then
        self:AddToStatsPane();
    else
        PAPERDOLL_STATCATEGORIES[SWS_ADDON_NAME] = nil;
        for i, k in pairs(PAPERDOLL_STATCATEGORY_DEFAULTORDER) do
            if(k == SWS_ADDON_NAME) then
                table.remove(PAPERDOLL_STATCATEGORY_DEFAULTORDER, i);
                break;
            end
        end

        return;
    end

    local category = PAPERDOLL_STATCATEGORIES[SWS_ADDON_NAME];
    table.wipe(category.stats);

    for key, _ in pairs(PAPERDOLL_STATINFO) do
        if(string.find(key, SWS_ADDON_NAME)) then
            PAPERDOLL_STATINFO[key] = nil;
        end
    end

    local specs = SpecModule:GetSpecs();

    for _, specKey in ipairs(Utils.OrderKeysBy(specs, "Order")) do
        local spec = specs[specKey];
        local key = SWS_ADDON_NAME..spec.Name;

        PAPERDOLL_STATINFO[key] = {
            updateFunc = function(statFrame, unit)
                local score = self:CalculateTotalScore(spec);
                local color = "";

                -- not correct in CM
                if(select(3, GetInstanceInfo()) == 8) then
                    color = GRAY_FONT_COLOR_CODE;
                    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..L["Warning"];
                    statFrame.tooltip2 = L["CharacterPane_CM_Tooltip"];
                else
                    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..L["CharacterPane_Tooltip_Title"];
                    statFrame.tooltip2 = string.format(L["CharacterPane_Tooltip_Title_Text"], spec.Name);
                end

                PaperDollFrame_SetLabelAndText(statFrame, L["TooltipMessage_StatScore"].." ("..spec.Name..")", color..string.format("%.2f", score), false);
            end
        };

        table.insert(category.stats, key);
    end
end

function CharacterModule:AddToStatsPane()
    if(not StatWeightScore.db.profile.ShowStatsPane or PAPERDOLL_STATCATEGORIES[SWS_ADDON_NAME]) then
        return;
    end

    local lastId = -1;

    for _, cat in pairs(PAPERDOLL_STATCATEGORIES) do
        if(cat.id > lastId) then
            lastId = cat.id;
        end
    end

    local category = {
        id = lastId + 1,
        stats = {
        }
    };

    PAPERDOLL_STATCATEGORIES[SWS_ADDON_NAME] = category;
    table.insert(PAPERDOLL_STATCATEGORY_DEFAULTORDER, 2, SWS_ADDON_NAME);

    self:UpdateStatCategory();

    local frameName = "CharacterStatsPaneCategory"..category.id;
    if(not getglobal(frameName)) then
        _G["STAT_CATEGORY_"..SWS_ADDON_NAME] = L["StatPaneCategoryTitle"];
        CreateFrame("Frame", frameName, CharacterStatsPaneScrollChild, "StatGroupTemplate");
    end
end

do
	local baseAttributes = {
		WARRIOR = {
			agi = 889,
			int = 711,
			str = 1455,
			spi = 679,
		},
		PALADIN = {
			agi = 455,
			int = 1042,
			str = 1455,
			spi = 782,
		},
		HUNTER = {
			agi = 1284,
			int = 854,
			str = 886,
			spi = 711,
		},
		ROGUE = {
			agi = 1284,
			int = 711,
			str = 1206,
			spi = 533,
		},
		PRIEST = {
			agi = 1067,
			int = 1042,
			str = 843,
			spi = 782,
		},
		DEATHKNIGHT = {
			agi = 1071,
			int = 569,
			str = 1455,
			spi = 640,
		},
		SHAMAN = {
			agi = 1284,
			int = 1042,
			str = 626,
			spi = 782,
		},
		MAGE = {
			agi = 889,
			int = 1042,
			str = 647,
			spi = 1155,
		},
		WARLOCK = {
			agi = 985,
			int = 1042,
			str = 551,
			spi = 1155,
		},
		MONK = {
			agi = 1284,
			int = 1042,
			str = 626,
			spi = 782,
		},
		DRUID = {
			agi = 1284,
			int = 1042,
			str = 626,
			spi = 782,
		},
	}
	
	local raceMods = {
		Human = {
			versatility = 100,  -- The Human Spirit
		},
		Dwarf = {
			agi = -4,
			int = -1,
			str = 5,
			sta = 1,
			spi = -1,
		},
		NightElf = {
			agi = 4,
			str = -4,
			-- 3 % dodge?
		},
		Orc = {
			agi = -3,
			int = -3,
			str = 3,
			sta = 1,
			spi = 2,
		},
		Tauren = {
			agi = -4,
			int = -4,
			str = 5,
			sta = 1 + 197,  -- Endurance
			spi = 2,
		},
		Undead = {
			agi = -2,
			int = -2,
			str = -1,
			spi = 5,
		},
		Gnome = {
			agi = 2,
			int = 3,
			str = -5,
			haste = 90,  -- Nimble Fingers
		},
		Troll = {
			agi = 2,
			int = -4,
			str = 1,
			spi = 1,
			-- Berserking?
		},
		BloodElf = {
			agi = 2,
			int = 3,
			str = -3,
			spi = -2,
			crit = 110,
		},
		Draenei = {
			agi = -3 + 65,  -- Heroic Presence
			int = 65,  -- Heroic Presence
			str = 1 + 65,  -- Heroic Presence
			spi = 2,
		},
		Goblin = {
			agi = 2,
			int = 3,
			str = -3,
			spi = -2,
			haste = 90,  -- Time is Money
		},
		Worgen = {
			agi = 2,
			int = -4,
			str = 3,
			spi = -1,
			crit = 110,  -- Visiousness
		},
		Pandaren = {
			agi = -2,
			int = -1,
			sta = 1,
			spi = 2,
			-- Epicurean?
		},
	}
	
	local specMods = {
		[263] = {  -- Enhancement
			crit = 1110,
		},
	}
	
	function CharacterModule:CalculateTotalScore(spec)
		if(ScoreCache[spec.Name]) then
			return ScoreCache[spec.Name]
		end

		local specScore = 0;

		for i = 0, 19 do
			local link = GetInventoryItemLink("player", i);
			if(link) then
				local _, _, _, _, _, _, _, _, loc = GetItemInfo(link);
				local score = ScoreModule:CalculateItemScore(link, loc, ScanningTooltipModule:ScanTooltip(link), spec);
				if(score) then
					if(i == 17 and score.Offhand) then
						specScore = specScore + score.Offhand;
					else
						specScore = specScore + score.Score;
					end
				end
			end
		end
		
		
		if UnitLevel("player") == 100 then
			local weights = SpecModule:GetWeights(spec)
			local function calculateScore(alias, amount)
				local weight = weights[alias]
				return (weight or 0) * amount
			end
			local _, class = UnitClass("player")
			local att = baseAttributes[class]
			local _, race = UnitRace("player")
			local rmods = raceMods[race]
			if race == "NightElf" then  -- Touch of Elune
				local hour = GetGameTime()  -- might be better to check some hidden flag or something
				if hour >= 6 and hour < 18 then
					rmods.crit = 110
					rmods.haste = 0
				else
					rmods.crit = 0
					rmods.haste = 90
				end
			end
			local spec = GetSpecializationInfo(GetSpecialization())
			local smods = specMods[tostring(spec)]
			
			-- base attributes
			specScore = specScore + calculateScore("str", att.str + (rmods.str or 0))
			specScore = specScore + calculateScore("agi", att.agi + (rmods.agi or 0))
			specScore = specScore + calculateScore("int", att.int + (rmods.int or 0))
			specScore = specScore + calculateScore("sta", 890 + (rmods.sta or 0))
			specScore = specScore + calculateScore("spi", att.spi + (rmods.spi or 0))
			specScore = specScore + calculateScore("crit", 550 + (rmods.crit or 0) + (smods and smods.crit or 0))  -- 6%
			specScore = specScore + calculateScore("haste", rmods.haste or 0)
			specScore = specScore + calculateScore("mastery", 880)  -- true for all specs
			specScore = specScore + calculateScore("versatility", rmods.versatility or 0)
			-- dodge?
			-- raid buffs
			specScore = specScore + calculateScore("mastery", 550)
			specScore = specScore + calculateScore("haste", 450)
			specScore = specScore + calculateScore("crit", 550)
			specScore = specScore + calculateScore("multistrike", 330)
			specScore = specScore + calculateScore("versatility", 390)
		end
		

		ScoreCache[spec.Name] = specScore;
		return specScore;
	end
end