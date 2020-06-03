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

local name		  = 'Volcano Badge'
local description = 'Revive Fossil + Cinnabar Key + Exp on Seafoam B4F'
local level = 80

local relogged = false

local VolcanoBadgeQuest = Quest:new()

function VolcanoBadgeQuest:new()
	return Quest.new(VolcanoBadgeQuest, name, description, level)
end

function VolcanoBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Earth Badge") then
		return true
	end
	return false
end

function VolcanoBadgeQuest:isDone()
	if getMapName() == "Cinnabar Lab" or getMapName() == "Cinnabar mansion 1" or getMapName() == "Route 21" then
		return true
	end
	return false
end

function VolcanoBadgeQuest:PokecenterCinnabar()
	self:pokecenter("Cinnabar Island")
end

function VolcanoBadgeQuest:CinnabarIsland()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Cinnabar" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(19, 26)

	elseif not self:isTrainingOver() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(45, 28)

	elseif not hasItem("Cinnabar Key") and isNpcOnCell(28,17) then
		if isNpcOnCell(18,15) then
			sys.debug("quest", "Going to talk to NPC in front of Cinnabar Mansion.")
			return talkToNpcOnCell(18,15)
		else
			sys.debug("quest", "Going to Cinnabar Mansion.")
			return moveToCell(18, 14)
		end

	elseif not hasItem("Volcano Badge") then
		if isNpcOnCell(28,17) then
			sys.debug("quest", "Going to talk to NPC in front of the 7th Gym.")
			return talkToNpcOnCell(28,17)
		else
			sys.debug("quest", "Going to the Gym for the 7th badge.")
			return moveToCell(28, 16)
		end

	elseif hasItem("Dome Fossil") or hasItem("Helix Fossil") then
		sys.debug("quest", "Going to revive our Fossil.")
		return moveToCell(8, 26)

	else
		if game.tryTeachMove("Surf","HM03 - Surf") == true then
			sys.debug("quest", "Going to Route 21.")
			return moveToCell(10, 0)
		end

	end
end

function VolcanoBadgeQuest:CinnabarGym()
	if not hasItem("Volcano Badge") then
		if isNpcOnCell(5,7) then
			sys.debug("quest", "Going to remove Mew from map.")
			return moveToCell(6,11)
		elseif isNpcOnCell(6,7) then
			if not self.relogged then
				self.relogged = true
				return relog(5, "Need to relog, because Blaine NPC cannot be talked to...")
			else
				sys.debug("quest", "Going to talk to Blaine.")
				return talkToNpcOnCell(6,7) -- blaine moves here after prompting mew?
			end
		else
			sys.debug("quest", "Going to Cinnabar Gym B1F.")
			return moveToCell(6, 5)
		end
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(27, 24)
	end
end

function VolcanoBadgeQuest:CinnabarGymB1F()
	if not hasItem("Volcano Badge") then
		sys.debug("quest", "Going to fight Blaine for 7th badge.")
		return talkToNpcOnCell(18,16)
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(7, 5)
	end
end

--** EXP SECTION **

function VolcanoBadgeQuest:canUseNurse()
	return getMoney() > 1500
end

function VolcanoBadgeQuest:Route20()
	if not self:isTrainingOver() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(73, 40) --Seafoam 1F
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(0, 32)
	end
end

function VolcanoBadgeQuest:Seafoam1F()
	if not self:isTrainingOver() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(64, 8) --Seafoam B1F
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(71, 15)
	end
end

function VolcanoBadgeQuest:SeafoamB1F()
	if not self:isTrainingOver() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(64, 25) --Seafoam B2F
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(85, 22)
	end
end

function VolcanoBadgeQuest:SeafoamB2F()
	if not self:isTrainingOver() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(63, 19) --Seafoam B3F
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(51, 27)
	end
end

function VolcanoBadgeQuest:SeafoamB3F()
	if not self:isTrainingOver() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(57, 26) --Seafom B4F
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(64, 16)
	end
end

function VolcanoBadgeQuest:SeafoamB4F()
	if not self:isTrainingOver() then
		if self:needPokecenter() then
			if self:canUseNurse() then -- if have 1500 money
				return talkToNpcOnCell(59,13)
			else
				if not (game.getTotalUsablePokemonCount() > 1) then -- Try get 1500money
					fatal("don't have enough Pokemons for farm 1500 money and heal the team")
				else
					sys.debug("quest", "Trying to get $" .. 1500 - getMoney() .. " more Pokedollars to heal Pokemon.")
				    return moveToRectangle(50, 10, 62, 32)
				end
			end
		else
			--using this instead of moveToRectangle seems to fix
			--the "no action after healing" error :s
			--but it will occasionally move to a link
			sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
			return moveToNormalGround() --moveToRectangle(50,10,62,32)
		end
	else
		sys.debug("quest", "Going back to Cinnabar Island.")
		return moveToCell(53, 28) -- Link: Seafoam B3F
	end
end

-- ** END EXP SECTION 

return VolcanoBadgeQuest
