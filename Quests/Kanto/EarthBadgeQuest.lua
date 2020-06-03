-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local team   = require "Libs/teamlib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Earth Badge'
local description = ' Beat Giovanni'

local EarthBadgeQuest = Quest:new()

function EarthBadgeQuest:new()
	return Quest.new(EarthBadgeQuest, name, description, level)
end

function EarthBadgeQuest:isDoable()
	if self:hasMap() and hasItem("Volcano Badge") and not hasItem("Zephyr Badge")then --Fixed DC on gym after win
		return true
	end
	return false
end

function EarthBadgeQuest:isDone()
	if (hasItem("Earth Badge") and getMapName() == "Route 22") or getMapName() == "Pokecenter Cinnabar" then --Fixed DC on gym after win, and Blackout
		return true
	end
	return false	
end

function EarthBadgeQuest:Route21()
	sys.debug("quest", "Going to fight Giovanni.")
	return moveToCell(13, 0)
end

function EarthBadgeQuest:PlayerBedroomPallet() -- fix for tp after Kanto E4
	sys.debug("quest", "Going to Johto.")
	return moveToCell(12, 4)
end

function EarthBadgeQuest:PlayerHousePallet() -- fix for tp after Kanto E4
	sys.debug("quest", "Going to Johto.")
	return moveToCell(4, 10)
end

function EarthBadgeQuest:PalletTown()
	sys.debug("quest", "Going to fight Giovanni.")
	return moveToCell(14, 0)
end

function EarthBadgeQuest:Route1()
	sys.debug("quest", "Going to fight Giovanni.")
	return moveToCell(13, 4)
end

function EarthBadgeQuest:Route1StopHouse()
	sys.debug("quest", "Going to fight Giovanni.")
	return moveToCell(3, 2)
end

function EarthBadgeQuest:PokecenterViridian()
	self:pokecenter("Viridian City")
end

function EarthBadgeQuest:ViridianPokemart()
	self:pokemart("Viridian City")
end

function EarthBadgeQuest:ViridianCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Viridian" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(44, 43)

	elseif self:needPokemart() then
		sys.debug("quest", "Going to buy Pokeballs.")
		return moveToCell(54, 34)

	elseif hasItem("Earth Badge") then
		sys.debug("quest", "Going to E4.")
		return moveToCell(0, 48)

	elseif not self:isTrainingOver() then
		sys.todo("go and evolve pokemon instead of fataling")
		return fatal("Error This team can't beat Giovanni")

	else
		sys.debug("quest", "Going to fight Giovanni.")
		return moveToCell(60, 22) --Viridian Gym 2

	end
end

function EarthBadgeQuest:ViridianGym2()
	if hasItem("Earth Badge") then
		sys.debug("quest", "Going to E4.")
		return moveToCell(10, 32)
	else
		if isNpcOnCell(10,26) then --NPC Gary
			sys.debug("quest", "Going to talk to Gary.")
			return talkToNpcOnCell(10,26)
		else
			sys.debug("quest", "Going to fight Giovanni.")
			return talkToNpcOnCell(10,8)
		end
	end
end

return EarthBadgeQuest