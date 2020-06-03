-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local pc     = require "Libs/pclib"
local game   = require "Libs/gamelib"
local team	 = require "Libs/teamlib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Saffron Guard'
local description = 'Route 15 to Saffron City'
local level = 65

local dialogs = {
	talkToNpcAgainForBikeVoucher = Dialog:new({ 
		"talk to me again!"
	}),
	gotDitto = Dialog:new({
		"Take this Bike Voucher and thanks again for your help!"
	})
}

local SaffronGuardQuest = Quest:new()

function SaffronGuardQuest:new()
	return Quest.new(SaffronGuardQuest, name, description, level)
end

function SaffronGuardQuest:isDoable()
	if self:hasMap() and not hasItem("Marsh Badge") then
		return true
	end
	return false
end

function SaffronGuardQuest:isDone()
	if getMapName() == "Saffron City" or getMapName() == "Pokecenter Fuchsia" then --Fix Blackout
		return true
	end
	return false
end

function SaffronGuardQuest:Route15()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(94, 25)
end

function SaffronGuardQuest:Route14()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(17, 0)
end

function SaffronGuardQuest:Route13()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(94, 0)
end

function SaffronGuardQuest:Route12()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(1, 47)
end

function SaffronGuardQuest:Route11StopHouse()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(0, 6)
end

function SaffronGuardQuest:Route11()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(0, 15)
end

function SaffronGuardQuest:VermilionCity()

	if self:isDittoSwapNeeded() or self:isReSwapNeeded() then
		sys.debug("quest", "Going to get Ditto out of the boxes for Bike Voucher.")
		return moveToCell(27, 21)

	--if has Ditto, get Bike Voucher
	elseif self:isVoucherNeeded() then
		sys.debug("quest", "Going to get Bike Voucher.")
		return moveToCell(32,21)
	end

	--all done - move to next quest location
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(42, 0)
end

function SaffronGuardQuest:isVoucherNeeded()
	return not hasItem("Bike Voucher")
		and hasPokemonInTeam("Ditto")
		and not hasItem("Bicycle")
		and BUY_BIKE
end


function SaffronGuardQuest:isDittoSwapNeeded()
	return not hasItem("Bike Voucher")
		and not hasPokemonInTeam("Ditto")
		and not hasItem("Bicycle")
		and BUY_BIKE
end

function SaffronGuardQuest:isReSwapNeeded()
	return swapBoxId and swapSlotId	-- parameters for swap are set
		and hasItem("Bike Voucher") -- and preQuest "Voucher" is done
end

function SaffronGuardQuest:PokecenterVermilion()
	if self:isDittoSwapNeeded() then
		sys.debug("entered regardless", "yes")

		local isDittoSwaped = getTeamSize() >= 6

		local dittoId = {132 }
		local result, pkmBoxId, slotId, swapTeamId = pc.retrieveFirstFromIds(dittoId)

		--working 	| then return because of open proShine functions to be resolved
		--			| if not returned, a "can only execute one function per frame" might occur
		if result == pc.result.WORKING then return sys.info("Searching PC")

		--no solution, terminate bot
		elseif  result == pc.result.NO_RESULT then
			-- quick fix until pathfinder is added, then moving to route 8 wouldn't
			-- such a hassle to implement
			BUY_BIKE = false
			return sys.log("No ditto caught, you skipped a quest. You missed out on a fancy new bike :(")
		end

		--solution found and already added to team

		--if team was full set values, needed to return swap target
		if isDittoSwaped then
			swapBoxId = pkmBoxId
			swapSlotId = slotId
		end

		local pkm = result
		local msg = "Found "..pkm.name.." on BOX: " .. pkmBoxId .. "  Slot: " .. slotId
		if swapTeamId then  msg = msg .. " | Swapping with pokemon in team N: " .. swapTeamId
		else                msg = msg .. " | Added to team." end
		return sys.log(msg)

	--getting the pokemon, we needed to put down because of ditto
	elseif self:isReSwapNeeded() then
		--start pc
		if not isPCOpen() then return usePC() end
		--refresing
		if not isCurrentPCBoxRefreshed() then return sys.debug("refreshed") end
		-- open correct box for transfer
		if swapBoxId ~= getCurrentPCBoxId() then return openPCBox(swapBoxId) end

		--get the pokemon we put down to retrieve
	    withdrawPokemonFromPC(swapBoxId, swapSlotId)
		swapBoxId, swapSlotId = nil, nil	--reset after swap
		return

	--do basic pokecenter related stuff...
	else self:pokecenter("Vermilion City") end
end

function SaffronGuardQuest:VermilionHouse2Bottom()
	if self:isVoucherNeeded() then
		sys.debug("quest", "Going to get Bike Voucher.")
		pushDialogAnswer(game.hasPokemonWithName("Ditto"))
		pushDialogAnswer(1)
		return talkToNpcOnCell(6, 6)
	elseif dialogs.talkToNpcAgainForBikeVoucher.state then
		return talkToNpcOnCell(6, 6)
	else
		sys.debug("quest", "Going to go to Saffron City.")
		return moveToCell(5, 10)
	end
end

function SaffronGuardQuest:Route6()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(26, 5)
end

function SaffronGuardQuest:Route6StopHouse()
	sys.debug("quest", "Going to Saffron City.")
	return moveToCell(3, 2)
end

return SaffronGuardQuest