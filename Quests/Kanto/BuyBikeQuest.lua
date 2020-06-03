-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Exchange Voucher for the Bike'
local description = 'Cerulean City'

local BuyBikeQuest = Quest:new()

function BuyBikeQuest:new()
	return Quest.new(BuyBikeQuest, name, description, level, dialogs)
end

function BuyBikeQuest:isDoable()
	if self:hasMap() and hasItem("Soul Badge") and not hasItem("Volcano Badge")then
		return true
	end
	return false
end

function BuyBikeQuest:isDone()
	if getMapName() == "Route 5 Stop House" or getMapName() == "Pokecenter Saffron" then --Fix Blackout
		return true
	end
	return false
end

function BuyBikeQuest:Route5()
	if hasItem("Bike Voucher") then
		sys.debug("quest", "Going to buy Bike.")
		return moveToCell(13,0)
	else
		sys.debug("quest", "Going to Saffron City.")
		return moveToCell(22, 36)
	end
end

function BuyBikeQuest:CeruleanCity()
	if hasItem("Bike Voucher") then
		sys.debug("quest", "Going to buy Bike.")
		return moveToCell(15, 38)
	else
		sys.debug("quest", "Going to Saffron City.")
		return moveToCell(16, 50)
	end
end

function BuyBikeQuest:CeruleanCityBikeShop()
	if hasItem("Bike Voucher") then
		sys.debug("quest", "Going to buy Bike.")
		return talkToNpcOnCell(11,7)
	else
		sys.debug("quest", "Going to Saffron City.")
		return moveToCell(6, 15)
	end
end

return BuyBikeQuest