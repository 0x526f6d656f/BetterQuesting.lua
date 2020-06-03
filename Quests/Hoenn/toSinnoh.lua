-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'To Sinnoh Quest'
local description = 'Fight the 6 Sinnoh NPCs.'

local toSinnohQuest = Quest:new()

local NPC1done = false
local NPC2done = false
local NPC3done = false
local NPC4done = false
local NPC5done = false
local NPC6done = false

-- required OT Pokemon:
-- 1. Starmie (need Water Stone)
-- 2. Illumise
-- 3. Nidoking (need Moon Stone)
-- 4. Nidoqueen (need Moon Stone)
-- 5. Onix
-- 6. Huntail

-- need to make sure to force catch these in previous quests
-- 1. catch Starmie in LilycoveCity with Super Rod in "ToMossdeepCity"
-- 2. catch Illumise before Mauville Gym
-- 3. catch Nidorino somewhere in Kanto (+ get a Moonstone somewhere)
-- 4. catch Nidorina somewhere in Kanto (+ get a Moonstone somewhere)
-- 5. catch an onix somewhere
-- 6. IMPOSSIBLE to get alone - needs to be traded as a Clamperl while holding "DEEP SEA TOOTH"





function toSinnohQuest:new()
	local o = Quest.new(toSinnohQuest, name, description, level, dialogs)
	o.pokemon = "Clamperl"
	o.forceCaught = false
	return o
end

function toSinnohQuest:isDoable()
	if self:hasMap() and hasItem("Rain Badge") and not hasItem("Coal Badge") then
		return true
	end
	return false
end

function toSinnohQuest:isDone()
	if hasItem("xxx") and getMapName() == "xxx" then
		return true
	else
		return false
	end
end

function toSinnohQuest:PlayerBedroomLittlerootTown()
	sys.debug("quest", "Going back to Kanto -- Saffron City.")
	return moveToCell(11, 5)
end

function toSinnohQuest:PlayerHouseLittlerootTown()
	sys.debug("quest", "Going back to Kanto -- Saffron City.")
	return moveToCell(11, 12)
end

function toSinnohQuest:LittlerootTown()
	sys.debug("quest", "Going back to Kanto -- Saffron City.")
	return moveToCell(22, 0)
end

function toSinnohQuest:Route101()
	sys.debug("quest", "Going back to Kanto -- Saffron City.")
	return moveToCell(23, 0)
end

function toSinnohQuest:OldaleTown()
	sys.debug("quest", "Going back to Kanto -- Saffron City.")
	return moveToCell(24, 0)
end

function toSinnohQuest:Route103()
	sys.debug("quest", "Going back to Kanto -- Saffron City.")
	return moveToCell(100, 19)
end

function toSinnohQuest:Route110()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(24, 3)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(56, 33)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(24, 3)
	end
end

function toSinnohQuest:MauvilleCityStopHouse1()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(3, 2)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(4, 12)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(3, 2)
	end
end

function toSinnohQuest:MauvilleCity()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(48, 17)
	elseif NPC2done then
		if game.hasPokemonWithName("Nidoking") then
			sys.debug("quest", "Going back to Hoenn - New Mauville.")
			return moveToCell(22, 30)
		else
			sys.debug("quest", "Going to fetch Nidoking from PC Boxes.")
			return moveToCell(28, 13)
		end
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(48, 18)
	end
end

function toSinnohQuest:MauvilleCityStopHouse4()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(10, 6)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(0, 7)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(10, 7)
	end
end

function toSinnohQuest:Route118()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(59, 0)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(3, 17)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(59, 0)
	end
end

function toSinnohQuest:Route119B()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(9, 0)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(9, 0)
	end
end

function toSinnohQuest:Route119A()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(55, 8)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(55, 8)
	end
end

function toSinnohQuest:FortreeCity()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(54, 14)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(54, 14)
	end
end

function toSinnohQuest:Route120()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(50, 100)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(50, 100)
	end
end

function toSinnohQuest:Route121()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(85, 7)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(31, 35)
	else	
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(85, 7)
	end
end

function toSinnohQuest:LilycoveCity()
	if NPC5done then
		sys.debug("quest", "Going to Hoenn - Hoenn Pokemon League.")
		return moveToCell(95, 19)
	elseif NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(26, 38)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(0, 23)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(26, 38)
	end
end

function toSinnohQuest:LilycoveCityHarbor()
	if NPC5done then
		sys.debug("quest", "Going to Hoenn - Hoenn Pokemon League.")
		return moveToCell(8, 3)
	elseif NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		pushDialogAnswer(2) -- Vermilion City
		return talkToNpcOnCell(8, 10)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(8, 3)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		pushDialogAnswer(2) -- Vermilion City
		return talkToNpcOnCell(8, 10)
	end
end

function toSinnohQuest:VermilionCity()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(43, 0)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		pushDialogAnswer(2) -- Lilycove City
		return talkToNpcOnCell(58, 62)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(43, 0)
	end
end

function toSinnohQuest:Route6()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(27, 5)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(22, 61)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(27, 5)
	end
end

function toSinnohQuest:Route6StopHouse()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(4, 2)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(3, 12)
	else
		sys.debug("quest", "Going back to Kanto -- Saffron City.")
		return moveToCell(4, 2)
	end
end

function toSinnohQuest:SaffronCity()
	if NPC3done then
		sys.debug("quest", "Going back to Johto - National Park.")
		return moveToCell(10, 15)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(26, 52)
	else
		if isNpcOnCell(56, 24) then
			if game.hasPokemonWithName("Starmie") then
				sys.debug("quest", "Going to fight Symphonia with Starmie.")
				pushDialogAnswer(1)
				pushDialogAnswer(game.hasPokemonWithName("Starmie"))
				return talkToNpcOnCell(56, 24)
			else
				sys.debug("quest", "Going to fetch a Staryu or Starmie from PC Box.")
				return moveToCell(19, 45)
			end
		else
			NPC1done = true
			if not game.isTeamFullyHealed() then
				sys.debug("quest", "Going to heal Pokemon.")
				return moveToCell(19, 45)
			else
				sys.debug("quest", "Going back to Johto -- Ilex Forest.")
				return moveToCell(10, 15)
			end
		end
	end
end

function toSinnohQuest:PokecenterSaffron()
	if not (game.hasPokemonWithName("Staryu") or game.hasPokemonWithName("Starmie")) then
		sys.debug("quest", "Going to put Staryu/Starmie in our team if we caught it before.")
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon = 1, getCurrentPCBoxSize() do
						if getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) == "Staryu" or getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) == "Starmie" then
							sys.debug("team manager", "LOG: " .. getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) .. " found in BOX: " .. getCurrentPCBoxId() .."  Slot: ".. pokemon .. ". Swapping with Pokemon #1: " .. getPokemonName(1))
							return swapPokemonFromPC(getCurrentPCBoxId(), pokemon, 1)
						end
					end
					return openPCBox(getCurrentPCBoxId() + 1)
				end
			else
				return
			end
		else
			return usePC()
		end
	elseif game.hasPokemonWithName("Staryu") and hasItem("Water Stone") then
		return useItemOnPokemon("Water Stone", game.hasPokemonWithName("Staryu"))
	elseif game.hasPokemonWithName("Staryu") and not hasItem("Water Stone") then
		fatal("Need water stone.")
	else
		self:pokecenter("Saffron City")
	end
end

function toSinnohQuest:SaffronCityStation()
	if NPC3done then
		if not game.inRectangle(1, 3, 13, 7) then
			sys.debug("quest", "Going back to Johto -- National Park.")
			return talkToNpcOnCell(9, 9)
		else
			sys.debug("quest", "Going back to Johto -- National Park.")
			return moveToCell(1, 4)
		end
	elseif NPC2done then
		if not game.inRectangle(0, 9, 32, 20) then
			sys.debug("quest", "Going back to Hoenn - New Mauville.")
			return talkToNpcOnCell(9, 7)
		else
			sys.debug("quest", "Going back to Hoenn - New Mauville.")
			return moveToCell(9, 20)
		end
	else
		if not game.inRectangle(1, 3, 13, 7) then
			sys.debug("quest", "Going back to Johto -- Ilex Forest.")
			return talkToNpcOnCell(9, 9)
		else
			sys.debug("quest", "Going back to Johto -- Ilex Forest.")
			return moveToCell(1, 4)
		end
	end
end

function toSinnohQuest:SaffronCityStationFloor2()
	if NPC3done then
		sys.debug("quest", "Going back to Johto -- National Park.")
		return talkToNpcOnCell(14, 10)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(26, 13)
	else
		sys.debug("quest", "Going back to Johto -- Ilex Forest.")
		return talkToNpcOnCell(14, 10)
	end
end

function toSinnohQuest:GoldenrodCityStationFloor2()
	if NPC3done then
		sys.debug("quest", "Going back to Johto -- National Park.")
		return moveToCell(26, 13)
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return talkToNpcOnCell(14, 10)
	else
		sys.debug("quest", "Going back to Johto -- Ilex Forest.")
		return moveToCell(26, 13)
	end
end

function toSinnohQuest:GoldenrodCityStation()
	if NPC3done then
		if not game.inRectangle(0, 9, 32, 20) then
			sys.debug("quest", "Going back to Johto -- National Park.")
			return talkToNpcOnCell(9, 7)
		else
			sys.debug("quest", "Going back to Johto -- National Park.")
			return moveToCell(9, 20)
		end
	elseif NPC2done then
		if not game.inRectangle(1, 3, 13, 6) then
			sys.debug("quest", "Going back to Hoenn - New Mauville.")
			return talkToNpcOnCell(9, 9)
		else
			sys.debug("quest", "Going back to Hoenn - New Mauville.")
			return moveToCell(1, 4)
		end
	else
		if not game.inRectangle(0, 9, 32, 20) then
			sys.debug("quest", "Going back to Johto -- Ilex Forest.")
			return talkToNpcOnCell(9, 7)
		else
			sys.debug("quest", "Going back to Johto -- Ilex Forest.")
			return moveToCell(9, 20)
		end
	end
end

function toSinnohQuest:GoldenrodCity()
	if NPC3done then
		if game.hasPokemonWithName("Nidoqueen") then
			sys.debug("quest", "Going back to Johto -- National Park.")
			return moveToCell(69, 11)
		else
			sys.debug("quest", "Going to fetch Nidoqueen from PC Boxes.")
			return moveToCell(64, 47)
		end
	elseif NPC2done then
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(54, 33)
	if game.hasPokemonWithName("Illumise") then
		sys.debug("quest", "Going back to Johto -- Ilex Forest.")
		return moveToCell(67, 62)
	else
		sys.debug("quest", "Going to fetch Illumise from PC Boxes.")
		return moveToCell(64, 47)
	end
end

function toSinnohQuest:PokecenterGoldenrod()
	if NPC3done then
		if not game.hasPokemonWithName("Nidoqueen") then
			sys.debug("quest", "Going to put Nidoqueen in our team if we caught it before.")
			if isPCOpen() then
				if isCurrentPCBoxRefreshed() then
					if getCurrentPCBoxSize() ~= 0 then
						for pokemon = 1, getCurrentPCBoxSize() do
							if getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) == "Nidoqueen" then
								sys.debug("team manager", "LOG: " .. getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) .. " found in BOX: " .. getCurrentPCBoxId() .."  Slot: ".. pokemon .. ". Swapping with Pokemon #1: " .. getPokemonName(1))
								return swapPokemonFromPC(getCurrentPCBoxId(), pokemon, 1)
							end
						end
						return openPCBox(getCurrentPCBoxId() + 1)
					end
				else
					return
				end
			else
				return usePC()
			end
		else
			self:pokecenter("Saffron City")
		end

	elseif not game.hasPokemonWithName("Illumise") then
		sys.debug("quest", "Going to put Illumise in our team if we caught it before.")
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon = 1, getCurrentPCBoxSize() do
						if getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) == "Illumise" then
							sys.debug("team manager", "LOG: " .. getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) .. " found in BOX: " .. getCurrentPCBoxId() .."  Slot: ".. pokemon .. ". Swapping with Pokemon #1: " .. getPokemonName(1))
							return swapPokemonFromPC(getCurrentPCBoxId(), pokemon, 1)
						end
					end
					return openPCBox(getCurrentPCBoxId() + 1)
				end
			else
				return
			end
		else
			return usePC()
		end
	else
		self:pokecenter("Saffron City")
	end
end

function toSinnohQuest:Route34()
	if not NPC2done then
		sys.debug("quest", "Going back to Johto -- Ilex Forest.")
		return moveToCell(25, 64)
	else
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(13, 0)
	end
end

function toSinnohQuest:Route34StopHouse()
	if not NPC2done then
		sys.debug("quest", "Going back to Johto -- Ilex Forest.")
		return moveToCell(4, 12)
	else
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(4, 2)
	end
end

function toSinnohQuest:IlexForest()
	if isNpcOnCell(40, 12) then
		sys.debug("quest", "Going to fight Indragiri.")
		pushDialogAnswer(1)
		pushDialogAnswer(game.hasPokemonWithName("Illumise"))
		return talkToNpcOnCell(40, 12)
	else
		NPC2done = true
		sys.debug("quest", "Going back to Hoenn - New Mauville.")
		return moveToCell(8, 7)
	end
end

function toSinnohQuest:Route122()
	sys.debug("quest", "Going back to Hoenn - New Mauville.")
	return moveToCell(64, 60)
end

function toSinnohQuest:Route123()
	sys.debug("quest", "Going back to Hoenn - New Mauville.")
	return moveToCell(0, 12)
end

function toSinnohQuest:PokecenterMauvilleCity()
	if not game.hasPokemonWithName("Nidoking") then
		sys.debug("quest", "Going to put Nidoking in our team if we caught it before.")
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon = 1, getCurrentPCBoxSize() do
						if getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) == "Nidoking" then
							sys.debug("team manager", "LOG: " .. getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) .. " found in BOX: " .. getCurrentPCBoxId() .."  Slot: ".. pokemon .. ". Swapping with Pokemon #1: " .. getPokemonName(1))
							return swapPokemonFromPC(getCurrentPCBoxId(), pokemon, 1)
						end
					end
					return openPCBox(getCurrentPCBoxId() + 1)
				end
			else
				return
			end
		else
			return usePC()
		end
	else
		self:pokecenter("Mauville City")
	end
end

function toSinnohQuest:NewMauvilleEntrance()
	if NPC3done then
		return moveToCell(12, 15)
	else
		if isNpcOnCell(12, 7) then
			return talkToNpcOnCell(12, 7)
		else
			return moveToCell(12, 4)
		end
	end
end

function toSinnohQuest:NewMauville()
	if NPC3done then
		if not game.inRectangle(42, 35, 60, 62) then
			return moveToCell(46, 39)
		else
			return moveToCell(48, 53)
		end
	else
		-- new mauville quest
		if isNpcOnCell(53, 57) then
			return talkToNpcOnCell(53, 57)
		elseif isNpcOnCell(56, 38) then
			return talkToNpcOnCell(56, 38)
		elseif isNpcOnCell(44, 39) then
			return talkToNpcOnCell(44, 39)
		elseif isNpcOnCell(26, 34) then
			return talkToNpcOnCell(26, 34)
		elseif isNpcOnCell(27, 42) then
			return talkToNpcOnCell(27, 42)
		elseif isNpcOnCell(1, 39) then
			return talkToNpcOnCell(1, 39)
		-- sinnoh quest
		elseif isNpcOnCell(1, 46) then
			sys.debug("quest", "Going to fight Nova.")
			pushDialogAnswer(1)
			pushDialogAnswer(game.hasPokemonWithName("Nidoking"))
			return talkToNpcOnCell(1, 46)
		elseif not isNpcOnCell(1, 46) then
			NPC3done = true
		end
	end
end

function toSinnohQuest:Route35StopHouse()
	sys.debug("quest", "Going back to Johto -- National Park.")
	return moveToCell(4, 2)
end

function toSinnohQuest:Route35()
	sys.debug("quest", "Going back to Johto -- National Park.")
	return moveToCell(11, 6)
end

function toSinnohQuest:NationalParkStopHouse1()
	sys.debug("quest", "Going back to Johto -- National Park.")
	return moveToCell(4, 2)
end

function toSinnohQuest:NationalPark()
	if NPC4done then
		sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
		return moveToCell(62, 31)
	else
		if isNpcOnCell(59, 23) then
			pushDialogAnswer(1)
			pushDialogAnswer(game.hasPokemonWithName("Nidoqueen"))
			sys.debug("quest", "Going to fight Novi.")
			return talkToNpcOnCell(59, 23)
		else
			NPC4done = true
		end
	end
end

function toSinnohQuest:NationalParkStop()
	sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
	return moveToCell(10, 6)
end

function toSinnohQuest:Route36()
	sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
	return moveToCell(19, 0)
end

function toSinnohQuest:Route37()
	sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
	return moveToCell(18, 4)
end

function toSinnohQuest:EcruteakCity()
	sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
	return moveToCell(3, 26)
end

function toSinnohQuest:EcruteakStopHouse1()
	sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
	return moveToCell(0, 7)
end

function toSinnohQuest:Route38()
	sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
	return moveToCell(0, 15)
end

function toSinnohQuest:Route39()
	sys.debug("quest", "Going to Johto -- Olivine City Cafe.")
	return moveToCell(28, 65)
end

function toSinnohQuest:OlivineCity()
	if NPC5done then
		pushDialogAnswer(3) -- Lilycove City
		return talkToNpcOnCell(17, 47)
	else
		if game.hasPokemonWithName("Onix") then
			return moveToCell(7, 31)
		else
			return moveToCell(13, 32)
		end
	end
end

function toSinnohQuest:OlivinePokecenter()
	if not game.hasPokemonWithName("Onix") then
		sys.debug("quest", "Going to put Onix in our team if we caught it before.")
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon = 1, getCurrentPCBoxSize() do
						if getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) == "Onix" then
							sys.debug("team manager", "LOG: " .. getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) .. " found in BOX: " .. getCurrentPCBoxId() .."  Slot: ".. pokemon .. ". Swapping with Pokemon: " .. game.hasPokemonWithName("Nidoqueen"))
							return swapPokemonFromPC(getCurrentPCBoxId(), pokemon, game.hasPokemonWithName("Nidoqueen"))
						end
					end
					return openPCBox(getCurrentPCBoxId() + 1)
				end
			else
				return
			end
		else
			return usePC()
		end
	else
		self:pokecenter("Olivine City")
	end
end

function toSinnohQuest:OlivineCafe()
	if NPC5done then
		sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
		return moveToCell(11, 15)
	else
		if isNpcOnCell(6, 11) then
			sys.debug("quest", "Going to fight Oswald.")
			pushDialogAnswer(1)
			pushDialogAnswer(game.hasPokemonWithName("Onix"))
			return talkToNpcOnCell(6, 11)
		else
			NPC5done = true
		end
	end
end

function toSinnohQuest:Route124()
	if not forceCaught then
		sys.debug("quest", "Going to catch Clamperl for NPC 6.")
		return useItem("Super Rod")
	else
		sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
		return moveToCell(53, 60)
	end
end

function toSinnohQuest:Route126()
	sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
	return moveToCell(125, 64)
end

function toSinnohQuest:Route127()
	sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
	return moveToCell(38, 93)
end

function toSinnohQuest:Route128()
	sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
	return moveToCell(123, 33)
end

function toSinnohQuest:EverGrandeCity()
	if game.inRectangle(4, 1, 51, 44) then
		sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
		return moveToCell(31, 9)
	else
		sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
		return moveToCell(27, 56)
	end
end

function toSinnohQuest:VictoryRoadHoenn1F()
	if game.inRectangle(32, 4, 49, 14) then
		sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
		return moveToCell(46, 10)
	else
		sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
		return moveToCell(9, 17)
	end
end

function toSinnohQuest:VictoryRoadHoennB1F()
	sys.debug("quest", "Going to Hoenn -- Hoenn Pokemon League.")
	return moveToCell(46, 7)
end

function toSinnohQuest:PokemonLeagueHoenn()
	if isNpcOnCell(20, 12) then
		if not game.hasPokemonWithName("Huntail") then
			sys.debug("quest", "Going to put Huntail in our team if we caught it before.")
			if isPCOpen() then
				if isCurrentPCBoxRefreshed() then
					if getCurrentPCBoxSize() ~= 0 then
						for pokemon = 1, getCurrentPCBoxSize() do
							if getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) == "Huntail" then
								sys.debug("team manager", "LOG: " .. getPokemonNameFromPC(getCurrentPCBoxId(), pokemon) .. " found in BOX: " .. getCurrentPCBoxId() .."  Slot: ".. pokemon .. ". Swapping with Pokemon: " .. game.hasPokemonWithName("Nidoqueen"))
								return swapPokemonFromPC(getCurrentPCBoxId(), pokemon, game.hasPokemonWithName("Nidoqueen"))
							end
						end
						return openPCBox(getCurrentPCBoxId() + 1)
					else
						fatal("No Huntail in Boxes. Huntail is impossible to get without trading. Please catch a Clamperl, trade it while holding \"Deep Sea Tooth\" and then restart the bot here.")
					end
				else
					return
				end
			else
				return usePC()
			end
		elseif not game.isTeamFullyHealed() then
			return talkToNpcOnCell(4, 22)
		else
			return talkToNpcOnCell(20, 12)
		end
	else
		NPC6done = true
	end
end

return toSinnohQuest