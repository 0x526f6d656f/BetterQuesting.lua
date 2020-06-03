-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Mineral Badge Quest'
local description = 'Will Exp to lv 55 and earn the 6th Badge'
local level = 55

local dialogs = {
	phare = Dialog:new({ 
		"see you in the gym"
	}),
	potion = Dialog:new({ 
		"How are you today deary?"
	})
}

local MineralBadgeQuest = Quest:new()

function MineralBadgeQuest:new()
	return Quest.new(MineralBadgeQuest, name, description, level, dialogs)
end

function MineralBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Mineral Badge") and hasItem("Storm Badge") then
		return true
	end
	return false
end

function MineralBadgeQuest:isDone()
	if hasItem("Mineral Badge") and getMapName() == "Olivine City Gym" then
		return true
	else
		return false
	end
end

function MineralBadgeQuest:CianwoodCity()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Cianwood" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(24, 47)
	elseif not dialogs.potion.state then 
		sys.debug("quest", "Going to get SecretPotion.")
		return moveToCell(15, 48)
	else
		sys.debug("quest", "Going back to Olivine City.")
		return moveToCell(31, 33)
	end 
end

function MineralBadgeQuest:Route41()
	if not self:isTrainingOver() and not self:needPokecenter() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToRectangle(1, 8, 2, 52)
	else
		sys.debug("quest", "Going back to Olivine City.")
		return moveToCell(52, 0)
	end
end

function MineralBadgeQuest:Route40()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(12, 47)
	else
		sys.debug("quest", "Going back to Olivine City.")
		return moveToCell(30, 7)
	end
end

function MineralBadgeQuest:OlivineCity()
	if BUY_RODS and hasItem("Good Rod") and not hasItem("Super Rod") and getMoney() >= 75000 then
		sys.debug("quest", "Going to buy Good Rod.")
		return moveToCell(28, 17)
	elseif self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Olivine Pokecenter" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(13, 32)
	elseif not dialogs.phare.state then 
		sys.debug("quest", "Going to Lighthouse Top.")
		return moveToCell(42, 34)
	elseif not self:isTrainingOver() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(0, 36)
	else
		sys.debug("quest", "Going to get 6th badge.")
		return moveToCell(10, 15)
	end
end

function MineralBadgeQuest:OlivineHouse1()
	if hasItem("Good Rod") and not hasItem("Super Rod") then
		return talkToNpcOnCell(0, 10)
	else
		return moveToCell(7, 15)
	end
end

function MineralBadgeQuest:GlitterLighthouse1F() -- todo
	if dialogs.phare.state then 
		return moveToCell(8,14)
	else
		return moveToCell(9,5)
	end
end

function MineralBadgeQuest:GlitterLighthouse2F() --todo
	if dialogs.phare.state then 
		if game.inRectangle(10,4,15,7) then
			return moveToCell(13,7)
		elseif game.inRectangle(3,4,9,13) then
			return moveToCell(9,12)
		end
	else
		if game.inRectangle(10,4,15,7) then
			return moveToCell(12,4)
		elseif game.inRectangle(3,4,9,13) then
			return moveToCell(3,5)
		end
	end
end

function MineralBadgeQuest:GlitterLighthouse3F() --todo
	if dialogs.phare.state then 
		if game.inRectangle(9,3,13,12) then
			return moveToCell(12,5)
		elseif game.inRectangle(1,6,6,3) then
			return moveToCell(3,5)
		end
	else 
		if game.inRectangle(9,3,13,12) then
			return moveToCell(9,12)
		elseif game.inRectangle(1,6,6,3) then
			return moveToCell(5,4)
		end
	end
end

function MineralBadgeQuest:GlitterLighthouse4F() --todo
	if dialogs.phare.state then 
		return moveToCell(5,4)
	else
		return moveToCell(11,6)
	end
end

function MineralBadgeQuest:GlitterLighthouse5F() --todo
	if dialogs.phare.state then 
		return moveToCell(11,11)
	elseif isNpcOnCell(11,9) then
		return talkToNpcOnCell(11,9)
	elseif not isNpcOnCell(11,9) then
		return moveToCell(11,11)
	end
end

function MineralBadgeQuest:CianwoodShop()
	if not dialogs.potion.state then 
		sys.debug("quest", "Going to get SecretPotion.")
		return talkToNpcOnCell(2,2)
	else
		sys.debug("quest", "Going back to Olivine City.")
		return moveToCell(7, 10)
	end
end

function MineralBadgeQuest:OlivinePokecenter()
	self:pokecenter("Olivine City")
end

function MineralBadgeQuest:PokecenterCianwood()
	self:pokecenter("Cianwood City")
end

function MineralBadgeQuest:OlivineCityGym()
	sys.debug("quest", "Going to get 6th badge.")
	return talkToNpcOnCell(6,3)
end

function MineralBadgeQuest:CianwoodCityGym()
	sys.debug("quest", "Going back to Olivine City.")
	return moveToCell(32, 40)
end

return MineralBadgeQuest