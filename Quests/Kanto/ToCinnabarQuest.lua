-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local pc            = require "Libs/pclib"
local team          = require "Libs/teamlib"
local SurfTarget    = require "Data/surfTargets"

local name		  = 'Traveling'
local description = 'Route 8 To Cinnabar Island'

local ToCinnabarQuest = Quest:new()

function ToCinnabarQuest:new()
	local o = Quest.new(ToCinnabarQuest, name, description, level)
	return o
end

function ToCinnabarQuest:isDoable()
	if self:hasMap() and hasItem("Marsh Badge") and not hasItem("Volcano Badge") then
		return true
	end
	return false
end

function ToCinnabarQuest:isDone()
	if getMapName() == "Cinnabar Island" or getMapName() == "Pokecenter Saffron" then --Fix Blackout
		return true
	end
	return false
end

function ToCinnabarQuest:Route8()
	sys.debug("quest", "Going to Lavender Town.")
	return moveToCell(72, 11)
end

function ToCinnabarQuest:PokecenterLavender()
	self:pokecenter("Lavender Town")
end

function ToCinnabarQuest:LavenderTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Lavender" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(9, 5)
	else
		sys.debug("quest", "Going to Cinnabar Island.")
		return moveToCell(14, 25)
	end
end

function ToCinnabarQuest:Route12()
	sys.debug("quest", "Going to Cinnabar Island.")
	return moveToCell(24, 92)
end

function ToCinnabarQuest:Route13()
	sys.debug("quest", "Going to Cinnabar Island.")
	return moveToCell(18,34) --Fixed: Can't Use moveToMap("Route 14") 1 cell of this link is on water
end

function ToCinnabarQuest:Route14()
	return moveToCell(0, 53)
end

function ToCinnabarQuest:Route15()
	return moveToCell(6, 16)
end

function ToCinnabarQuest:Route15StopHouse()
	return moveToCell(0, 6)
end

function ToCinnabarQuest:hasSurfer()
	local surferIds = SurfTarget.getIds()
	local teamIds = team.getPkmIds()
	local matches = Set.intersection(teamIds, surferIds)

	return team.getFirstPkmWithMove("surf") or matches
end

function ToCinnabarQuest:PokecenterFuchsia()

	local surferIds = SurfTarget.getIds()

	--1. check for surfer
	if not self:hasSurfer() then
		local result, pkmBoxId, slotId, swapTeamId =
		pc.retrieveFirstFromIds(surferIds)

		--working 	| then return because of open proShine functions to be resolved
		--			| if not returned, a "can only execute one function per frame" might occur
		if result == pc.result.WORKING then return sys.info("Searching PC")

		--no solution, terminate bot
		elseif  result == pc.result.NO_RESULT then
			return sys.error("No pokemon in your team or on your computer has the ability to surf. Can't progress Quest")
		end

		--solution found and added
		local pkm = result
		local msg = "Found Surfer "..pkm.name.." on BOX: " .. pkmBoxId .. "  Slot: " .. slotId
		if swapTeamId then  msg = msg .. " | Swapping with pokemon in team N: " .. swapTeamId
		else                msg = msg .. " | Added to team." end
		sys.log(msg)

		--do basic pokecenter related stuff...
	else self:pokecenter("Fuchsia City") end

end

function ToCinnabarQuest:isRodObtainable()
	return BUY_RODS and hasItem("Old Rod") and not hasItem("Good Rod") and getMoney() >= 15000
end

function ToCinnabarQuest:FuchsiaHouse1()
	if self:isRodObtainable() then
		return talkToNpcOnCell(3, 6)
	else
		return moveToCell(5, 11)
	end
end

function ToCinnabarQuest:FuchsiaCity()
	--visiting pokecenter
	if self:needPokecenter() or not game.isTeamFullyHealed() 		--healing
		or not self:hasSurfer()										--getting surfer
		or self.registeredPokecenter ~= "Pokecenter Fuchsia"		--register pokecenter
	then
		sys.debug("quest", "Going to Pokecenter.")
		return moveToCell(30, 39)

	--Item: GoodRod
	elseif self:isRodObtainable() then
		sys.debug("quest", "Going to get Good Rod.")
		return moveToCell(45, 36)

	--else progress story
	else
		sys.debug("quest", "Going to Cinnabar Island.")
		return moveToCell(23, 44)
	end
end

function ToCinnabarQuest:FuchsiaCityStopHouse()	
	sys.debug("quest", "Going to Cinnabar Island.")
	return moveToCell(6, 20)
end

function ToCinnabarQuest:Route19()
	if game.tryTeachMove("Surf","HM03 - Surf") == true then
		sys.debug("quest", "Going to Cinnabar Island.")
		return moveToCell(0, 44)
	end
end

function ToCinnabarQuest:Route20()
	if game.inRectangle(52, 20, 120, 39) then
		sys.debug("quest", "Going to Cinnabar Island.")
		return moveToCell(60, 32)
	elseif game.inRectangle(0, 40, 80, 45) or game.inRectangle(0, 17, 50, 40) then
		sys.debug("quest", "Going to Cinnabar Island.")
		return moveToCell(0, 30)
	else
		error("ToCinnabarQuest:Route20(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
	end
end

function ToCinnabarQuest:Seafoam1F()
	if game.inRectangle(5, 5, 21, 17) then
		sys.debug("quest", "Going to Cinnabar Island.")
		return moveToCell(20, 8)
	elseif game.inRectangle(63, 5, 79, 16) then
		sys.debug("quest", "Going to Cinnabar Island.")
		return moveToCell(71, 15)
	else
		error("ToCinnabarQuest:Seafoam1F(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
	end
end

function ToCinnabarQuest:SeafoamB1F()
	sys.debug("quest", "Going to Cinnabar Island.")
	return moveToCell(85, 22)
end

return ToCinnabarQuest