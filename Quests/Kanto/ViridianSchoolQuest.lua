-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local team   = require "Libs/teamlib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Viridian School'
local description = 'from Route 1 to Route 2'
local level = 8

local dialogs = {
	jacksonDefeated = Dialog:new({
		"You will not take my spot!",
		"Sorry, the young boy there doesn't want to give his spot, I'm truly sorry..."
	})
}

local ViridianSchoolQuest = Quest:new()
function ViridianSchoolQuest:new()
	return Quest.new(ViridianSchoolQuest, name, description, level, dialogs)
end

function ViridianSchoolQuest:isDoable()
	if not hasItem("Boulder Badge") and self:hasMap() then
		return true
	end
	return false
end

function ViridianSchoolQuest:isDone()
	return getMapName() == "Route 2"
end

-- necessary, in case of black out we come back to the bedroom
function ViridianSchoolQuest:PlayerBedroomPallet()
	return moveToCell(12,4)
end

function ViridianSchoolQuest:PlayerHousePallet()
	return moveToCell(4,10)
end

function ViridianSchoolQuest:PalletTown()
	return moveToCell(14,0)
end

function ViridianSchoolQuest:Route1()
	if self:needPokecenter() then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(14, 4)
	else
		sys.debug("quest", "Going to Viridian City.")
		return moveToCell(14,4)
	end
end

function ViridianSchoolQuest:Route1StopHouse()
	if self:needPokecenter() then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(4,2)
	else
		sys.debug("quest", "Going to Viridian City.")
		return moveToCell(4,2)
	end
end

function ViridianSchoolQuest:isTrainingOver()
	if getTeamSize() >= 2 and team.getLowestLvl() >= self.level then
		return true
	end
	return false
end

function ViridianSchoolQuest:ViridianCity()
	if not game.isTeamFullyHealed()
		or self.registeredPokecenter ~= "Pokecenter Viridian" then
		sys.debug("quest", "Going to heal Pokemon")
		return moveToCell(44,43)
	elseif self:needPokemart() then
		sys.debug("quest", "Going to buy Pokeballs")
		return moveToCell(54,34)
	elseif not self.dialogs.jacksonDefeated.state and self:isTrainingOver() then
		sys.debug("quest", "Going to fight Jackson")
		return moveToCell(48,34)
	elseif not self:isTrainingOver() then
		sys.debug("quest", "Going to train Pokemon until they all reached level " .. self.level .. ".")
		return moveToCell(0,47)
	else
		sys.debug("quest", "TODO: add what it does here")
		return moveToCell(39,0)
	end
end

function ViridianSchoolQuest:ViridianCitySchool()
	if self.dialogs.jacksonDefeated.state or not self:isTrainingOver() then
		return moveToCell(4,13)
	else
		return moveToCell(12,3)
	end
end

function ViridianSchoolQuest:ViridianCitySchoolUnderground()
	if self.dialogs.jacksonDefeated.state or not self:isTrainingOver() then
		return moveToCell(13,3)
	elseif not isNpcVisible("Jackson") then
		self.dialogs.jacksonDefeated.state = true
		return moveToCell(13,3)
	elseif isNpcOnCell(7,6) then
		return talkToNpcOnCell(7,6)
	else
		return talkToNpc("Jackson")
	end	
end

function ViridianSchoolQuest:Route22()
	if self:needPokecenter() then
		return moveToCell(60,12)
	elseif self:isTrainingOver() then
		return moveToCell(60,12)
	else
		return moveToGrass()
	end	
end

function ViridianSchoolQuest:PokecenterViridian()
	return self:pokecenter("Viridian City")
end

function ViridianSchoolQuest:ViridianPokemart()
	return self:pokemart("Viridian City")
end

return ViridianSchoolQuest
