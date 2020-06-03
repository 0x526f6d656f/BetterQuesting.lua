-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Get the Orbs'
local description = 'Will get the Blue and Red Orbs'
local level = 55

local dialogs = {
	jack = Dialog:new({ 
		"Many lives were lost"
	}),
	featherDone = Dialog:new({
		"Good job on getting the Feather Badge"
	})
}

local GetTheOrbs = Quest:new()

function GetTheOrbs:new()
	return Quest.new(GetTheOrbs, name, description, level, dialogs)
end

function GetTheOrbs:isDoable()
	if self:hasMap() and not hasItem("Blue Orb") and not hasItem("Mind Badge") then
		return true
	end
	return false
end

function GetTheOrbs:isDone()
	if hasItem("Blue Orb") and getMapName() == "Mt. Pyre Summit" then
		return true
	else
		return false
	end
end








function GetTheOrbs:Route120()
	if self:needPokecenter() then 
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(0, 8)
	elseif not self:isTrainingOver() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToRectangle(36, 7, 44, 7)
	elseif not hasItem("Feather Badge") then
		sys.debug("quest", "Going to get 6th badge.")
		return moveToCell(0, 8)
	elseif not dialogs.featherDone.state then
		sys.debug("quest", "Going to talk to NPC.")
		return talkToNpcOnCell(49, 99)
	else
		sys.debug("quest", "Going to get the orbs.")
		return moveToCell(50, 100)
	end
end

function GetTheOrbs:FortreeCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Fortree City" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(8, 11)
	elseif self:needPokemart() then
		sys.debug("quest", "Going to buy Pokeballs.")
		return moveToCell(7, 23)
	elseif not self:isTrainingOver() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		moveToCell(54, 14)
	elseif not hasItem("Feather Badge") then 
		sys.debug("quest", "Going to get 6th badge.")
		return moveToCell(29, 16)
	else
		sys.debug("quest", "Going to get the orbs.")
		return moveToCell(54, 14)
	end
end

function GetTheOrbs:PokecenterFortreeCity()
	return self:pokecenter("Fortree City")
end

function GetTheOrbs:FortreeMart()
	return self:pokemart()
end

function GetTheOrbs:FortreeGym()
	if not hasItem("Feather Badge") then
		sys.debug("quest", "Going to get 6th badge.")
		return talkToNpcOnCell(19, 7)
	else
		sys.debug("quest", "Going to get the orbs.")
		return moveToCell(14, 65)
	end
end

function GetTheOrbs:Route121()
	sys.debug("quest", "Going to get the orbs.")
	return moveToCell(30, 35)
end

function GetTheOrbs:Route122()
	sys.debug("quest", "Going to get the orbs.")
	return moveToCell(60, 38)
end

function GetTheOrbs:MtPyre1F()
	sys.debug("quest", "Going to get the orbs.")
	return moveToCell(2, 4)
end

function GetTheOrbs:MtPyre2F()
	sys.debug("quest", "Going to get the orbs.")
	return moveToCell(26, 4)
end

function GetTheOrbs:MtPyre3F()
	if isNpcOnCell(13, 26) then
		sys.debug("quest", "Going to talk to NPC.")
		return talkToNpcOnCell(13, 26)
	else
		sys.debug("quest", "Going to get the orbs.")
		return moveToCell(13, 27)
	end
end

function GetTheOrbs:MtPyreExterior()
	sys.debug("quest", "Going to get the orbs.")
	return moveToCell(25, 0)
end

function GetTheOrbs:MtPyreSummit() -- need to check
	if isNpcOnCell(27,12) then 
		talkToNpcOnCell(27,12)
	elseif isNpcOnCell(26,11) then
		talkToNpcOnCell(26,11)
	elseif not isNpcOnCell(27,4) then
		talkToNpcOnCell(26,4)
		dialogs.jack.state = true
		return
	elseif not dialogs.jack.state then
		moveToCell(27,6)
	
	end	
end

return GetTheOrbs