local SWS_ADDON_NAME, StatWeightScore = ...;
local BaseStatsModule = StatWeightScore:NewModule(SWS_ADDON_NAME.."BaseStats");

local SpecModule;

function BaseStatsModule:OnInitialize()
    SpecModule = StatWeightScore:GetModule(SWS_ADDON_NAME.."Spec");
end	

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
		crit = 110,  -- Viciousness
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

function BaseStatsModule:GetBaseScore(spec)
	local baseScore = 0
	
	local weights = SpecModule:GetWeights(spec)
	local function calculateScore(alias, amount)
		return (weights[alias] or 0) * amount
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
	baseScore = baseScore + calculateScore("str", att.str + (rmods.str or 0))
	baseScore = baseScore + calculateScore("agi", att.agi + (rmods.agi or 0))
	baseScore = baseScore + calculateScore("int", att.int + (rmods.int or 0))
	baseScore = baseScore + calculateScore("sta", 890 + (rmods.sta or 0))
	baseScore = baseScore + calculateScore("spi", att.spi + (rmods.spi or 0))
	baseScore = baseScore + calculateScore("crit", 550 + (rmods.crit or 0) + (smods and smods.crit or 0))  -- 6%
	baseScore = baseScore + calculateScore("haste", rmods.haste or 0)
	baseScore = baseScore + calculateScore("mastery", 880)  -- true for all specs
	baseScore = baseScore + calculateScore("versatility", rmods.versatility or 0)
	-- dodge?
	
	-- raid buffs
	baseScore = baseScore + calculateScore("mastery", 550)
	baseScore = baseScore + calculateScore("haste", 450)
	baseScore = baseScore + calculateScore("crit", 550)
	baseScore = baseScore + calculateScore("multistrike", 330)
	baseScore = baseScore + calculateScore("versatility", 390)
	
	return baseScore
end