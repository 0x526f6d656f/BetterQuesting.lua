-- Copyright � 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Plain Badge Quest'
local description = ' Plain Badge'

local PlainBadgeQuest = Quest:new()

function PlainBadgeQuest:new()
	return Quest.new(PlainBadgeQuest, name, description, level)
end

function PlainBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Plain Badge") then
		return true
	end
	return false
end

function PlainBadgeQuest:isDone()
	if hasItem("Plain Badge") and getMapName() == "Goldenrod City Gym" then
		return true
	else
		return false
	end
end

function PlainBadgeQuest:PokecenterGoldenrod()
	self:pokecenter("Goldenrod City")
end

function PlainBadgeQuest:GoldenrodCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Goldenrod" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(64, 47)

    --elseif isNpcOnCell(50,34) then
    --    talkToNpcOnCell(50,34)

	elseif not hasItem("Plain Badge") then
		sys.debug("quest", "Going to get 2nd badge.")
		return moveToCell(75, 20)
	else
		sys.debug("quest", "Going to Route 35 Stop House")
		return moveToCell(69, 11)
	end	
end

function PlainBadgeQuest:GoldenrodCityGym()
	sys.debug("Going to fight Whitney for 2nd badge.")
	return talkToNpcOnCell(10,3)
end

return PlainBadgeQuest