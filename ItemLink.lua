local SWS_ADDON_NAME, StatWeightScore = ...;
local ItemLinkModule = StatWeightScore:NewModule(SWS_ADDON_NAME.."ItemLink");

local Utils = StatWeightScore.Utils;

local function ParseItemString(itemString)
    local parts = Utils.Pack(strsplit(":", itemString));

    return select(1, parts);
end

local function ParseLink(link)
    if(not link)then
        return nil, nil, {}, nil;
    end


    local color, linkType, itemString, text = string.match(link, "(|cff%x+)|H([^:]+):([%d:]+)|h%[?([^%[%]]+)%]?|h|r");
    return color, linkType, itemString and ParseItemString(itemString), text;
end

local function AssignProperty(instance, property, defaultValue, source, sourceIndex)
    local value = sourceIndex ~= nil and source ~= nil and source[sourceIndex] or source;
    instance[property] = value or defaultValue;
end

local ItemLink = Utils.Class(function(instance, link)
    local color, linkType, itemStringParts, text = ParseLink(link);

    AssignProperty(instance, "color", GREEN_FONT_COLOR_CODE, color);
    AssignProperty(instance, "linkType", "item", linkType);
    AssignProperty(instance, "text", "Unknown link", text);

    AssignProperty(instance, "itemId", "0", itemStringParts, 1);
    AssignProperty(instance, "enchantId", "0", itemStringParts, 2);
    AssignProperty(instance, "gem1Id", "0", itemStringParts, 3);
    AssignProperty(instance, "gem2Id", "0", itemStringParts, 4);
    AssignProperty(instance, "gem3Id", "0", itemStringParts, 5);
    AssignProperty(instance, "gem4Id", "0", itemStringParts, 6);
    AssignProperty(instance, "suffixId", "0", itemStringParts, 7);
    AssignProperty(instance, "uniqueId", "0", itemStringParts, 8);
    AssignProperty(instance, "linkLevel", "0", itemStringParts, 9);
    AssignProperty(instance, "specializationId", "0", itemStringParts, 10);
    AssignProperty(instance, "upgradeType", "0", itemStringParts, 11);
    AssignProperty(instance, "instanceDifficultyId", "0", itemStringParts, 12);

    instance.bonuses = {};

    local numBonus = itemStringParts and tonumber(itemStringParts[13]) or 0;
    if numBonus ~= 0 then
        for i = 14, 14 + numBonus do
            table.insert(instance.bonuses, itemStringParts[i]);
        end
    end

    if(instance.upgradeType ~= "0") then
        AssignProperty(instance, "upgradeId", "0", itemStringParts, 14 + numBonus);
    end
end);

function ItemLink:HasBonus(bonus)
    local flag = false;

    for _, b in pairs(self.bonuses) do
        if(b == bonus) then
            flag = true;
            break;
        end
    end

    return flag;
end

function ItemLink:HasBonuses(bonuses)
    local flag = false;

    for _, b in pairs(bonuses) do
        flag = self:HasBonus(b);
        if(not flag) then
            break;
        end
    end

    return flag;
end

function ItemLink:RemoveBonus(bonus)
    for i, b in pairs(self.bonuses) do
        if(b == bonus) then
            table.remove(self.bonuses, i);
            break;
        end
    end
end

function ItemLink:AddBonus(bonus)	
    table.insert(self.bonuses, bonus);
end

function ItemLink:ToString()
    local link = string.format("%s|H%s:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s",
        self.color,
        self.linkType,
        self.itemId,
        self.enchantId,
        self.gem1Id,
        self.gem2Id,
        self.gem3Id,
        self.gem4Id,
        self.suffixId,
        self.uniqueId,
        self.linkLevel,
        self.specializationId,
        self.upgradeType,
        self.instanceDifficultyId);

    if(self.bonuses)then
		if self:HasBonus("529") or self:HasBonus("530") or self:HasBonus("531") then
			link = link..":"..#self.bonuses-1;
		else
			link = link..":"..#self.bonuses;
		end

        for _, bonus in ipairs(self.bonuses) do
            link = link..":"..bonus;
        end
    end

    if(self.upgradeType ~= "0" and not self:HasBonus("529") and not self:HasBonus("530") and not self:HasBonus("531")) then  -- check bonuses to not overwrite upgrades (hacky, do fix)
        link = link..":"..self.upgradeId;
    end
	
    return link.."|h["..self.text.."]|h|r"
end

function ItemLinkModule:OnInitialize()
end

function ItemLinkModule:Parse(link)
    return ItemLink(link);
end
