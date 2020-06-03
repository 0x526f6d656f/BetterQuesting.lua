-- Copyright © 2016 Rympex <Rympex@noemail>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'SSAnne Quest'
local description = 'Completes the SSAnne'

local dialogs = {
	NeedRegisterTicket = Dialog:new({ 
		"has been booked in the passenger registry of S.S. Anne!",
		"pc is already registered to your"
	}),
	PcGetRegisterDone = Dialog:new({ 
		"welcome aboard to"
	}),
	RegisterTicketDone = Dialog:new({ 
		"enjoy your passengership on the"
	}),
	NeedPharmacist = Dialog:new({ 
		"did you speak to the pharmacist"
	}),
	TrashBinCheck = Dialog:new({ 
		"is empty"
	}),
	PharmacistWorking = Dialog:new({ 
		"explore the ballroom for now"
	}),
	KitchenDone = Dialog:new({ 
		"that the captain is cured in a timely fashion"
	}),
}

local SSAnneQuest = Quest:new()

function SSAnneQuest:new()
	return Quest.new(SSAnneQuest, name, description, level, dialogs)
end

function SSAnneQuest:isDoable()
	if self:hasMap() and not hasItem("HM01 - Cut") then
		return true
	else
		return false
	end
end

function SSAnneQuest:isDone()
	if getMapName() == "Vermilion City" and hasItem("HM01 - Cut") then
		return true
	else
		return false
	end
end

function SSAnneQuest:PokecenterVermilion()
	self:pokecenter("Vermilion City")
end

function SSAnneQuest:VermilionCity()
	return moveToCell(40, 67)
end

local SSAnneBasementRoom4Done = false

function SSAnneQuest:SSAnneBasementRoom4()
	SSAnneBasementRoom4Done = true
	sys.debug("quest", "Trainer battles are done in: SS Anne Basement Room 4")
	return moveToCell(5, 11)
end

function SSAnneQuest:SSAnneBasement()
	if not SSAnneBasementRoom4Done then
		sys.debug("quest", "Going to fight trainers in: SS Anne Basement Room 4")
		return moveToCell(7, 2)
	else
		return moveToCell(27, 4)--moveToMap("SSAnne 1F")
	end
end

function SSAnneQuest:SSAnne2FRoom6()
	if dialogs.PharmacistWorking.state then
		return moveToCell(5, 11)--moveToMap("SSAnne 2F")
	else
		return talkToNpcOnCell(9,9)
	end
end

function SSAnneQuest:SSAnne2FCaptainRoom()
	if hasItem("Secret Potion") and not hasItem("HM01 - Cut") then
		return talkToNpcOnCell(5,4)
	else
		return moveToCell(2, 11)--moveToMap("SSAnne 2F")
	end
end

function SSAnneQuest:BallroomSSAnne()
	if isNpcOnCell(2,20) then
		if isNpcOnCell(20, 33) and not self.trashBin1Ballroom then -- Item: Leppa Berry
			if not dialogs.TrashBinCheck.state then
				return talkToNpcOnCell(20, 33)
			else
				dialogs.TrashBinCheck.state = false
				self.trashBin1Ballroom = true
				return
			end
		elseif isNpcOnCell(10, 33) and not self.trashBin2Ballroom then -- Item: Chesto Berry
			if not dialogs.TrashBinCheck.state then
				return talkToNpcOnCell(10, 33)
			else
				dialogs.TrashBinCheck.state = false
				self.trashBin2Ballroom = true
				return
			end		
		elseif isNpcOnCell(23, 39) and not self.trashBin3Ballroom then -- Item: Oran Berry
			if not dialogs.TrashBinCheck.state then
				return talkToNpcOnCell(23, 39)
			else
				dialogs.TrashBinCheck.state = false
				self.trashBin3Ballroom = true
				return
			end
		else
			return talkToNpcOnCell(2, 20)
		end
	else
		return moveToCell(22, 12)--moveToMap("SSAnne 3F")
	end
end

local SSAnne3FBattleRoomDone = false

function SSAnneQuest:SSAnne3FBattleRoom()
	if isNpcOnCell(8, 5) then
		return talkToNpcOnCell(8, 5)
	else
		SSAnne3FBattleRoomDone = true
		sys.debug("quest", "Trainer battles are done in: SS Anne 3F Battle Room.")
		return moveToCell(8, 15)
	end
end

function SSAnneQuest:SSAnne3F()
	if not SSAnne3FBattleRoomDone then
		sys.debug("quest", "Going to fight trainers in: SS Anne 3F Battle Room.")
		return moveToCell(15, 2)
	elseif not hasItem("Secret Potion") then
		if not hasItem("HM01 - Cut") then
			return moveToCell(6, 7)--moveToMap("Ballroom SS Anne")
		end
	else
		return moveToCell(27, 4)--moveToMap("SSAnne 2F")
	end
end

function SSAnneQuest:SSAnne2F()
	if hasItem("Secret Potion") then
		if isNpcOnCell(26, 4) then
			return talkToNpcOnCell(26,4)
		else
			return moveToCell(27, 4)--moveToMap("SSAnne 2F Captain Room")
		end
	elseif not hasItem("HM01 - Cut") then
		if dialogs.PharmacistWorking.state then
			return moveToCell(2, 17)--moveToMap("SSAnne 3F")
		else
			if isNpcOnCell(28, 18) and not self.trashBinLeftovers then -- Item: LeftOvers
				if not dialogs.TrashBinCheck.state then
					return talkToNpcOnCell(28, 18)
				else
					dialogs.TrashBinCheck.state = false
					self.trashBinLeftovers = true
					return
				end
			else
				return moveToCell(22, 15)--moveToMap("SSAnne 2F Room6")
			end
		end
	else
		return moveToCell(4, 4)--moveToMap("SSAnne 1F")
	end
end

local SSAnne1FRoom7Done = false
local SSAnne1FRoom6Done = false
local SSAnne1FRoom5Done = false
local SSAnne1FRoom3Done = false

function SSAnneQuest:SSAnne1FRoom7()
	SSAnne1FRoom7Done = true
	sys.debug("quest", "Trainer battles are done in: SS Anne 1F Room 7")
	return moveToCell(6, 2)
end

function SSAnneQuest:SSAnne1FRoom6()
	SSAnne1FRoom6Done = true
	sys.debug("quest", "Trainer battles are done in: SS Anne 1F Room 6")
	return moveToCell(6, 2)
end

function SSAnneQuest:SSAnne1FRoom5()
	SSAnne1FRoom5Done = true
	sys.debug("quest", "Trainer battles are done in: SS Anne 1F Room 5")
	return moveToCell(5, 2)
end

function SSAnneQuest:SSAnne1FRoom3()
	SSAnne1FRoom3Done = true
	sys.debug("quest", "Trainer battles are done in: SS Anne 1F Room 3")
	return moveToCell(6, 2)
end


function SSAnneQuest:SSAnne1F()

	if hasItem("Secret Potion") then
		sys.debug("quest", "Going to SS Anne 2F.")
		return moveToCell(2, 11)--moveToMap("SSAnne 2F")

	elseif not hasItem("HM01 - Cut") then
		if dialogs.RegisterTicketDone.state then
			if dialogs.NeedPharmacist.state or dialogs.KitchenDone.state then
				sys.debug("quest", "Going to SS Anne 2F.")
				return moveToCell(2, 11)--moveToMap("SSAnne 2F")
			else
				sys.debug("quest", "Going to SS Anne 1F Kitchen.")
				return moveToCell(2, 19)--moveToMap("SSAnne 1F Kitchen")
			end
		else
			sys.debug("quest", "Talking to NPC to register room.")
			return talkToNpcOnCell(16,3)
		end

	elseif not SSAnneBasementRoom4Done then
		sys.debug("quest", "Going to fight trainers in: SS Anne Basement Room 4")
		return moveToCell(20, 18)

	elseif not SSAnne1FRoom7Done then
		sys.debug("quest", "Going to fight trainers in: SS Anne 1F Room 7")
		return moveToCell(17, 13)

	elseif not SSAnne1FRoom6Done then
		sys.debug("quest", "Going to fight trainers in: SS Anne 1F Room 6")
		return moveToCell(15, 13)

	elseif not SSAnne1FRoom5Done then
		sys.debug("quest", "Going to fight trainers in: SS Anne 1F Room 5")
		return moveToCell(13, 13)

	elseif not SSAnne1FRoom3Done then
		sys.debug("quest", "Going to fight trainers in: SS Anne 1F Room 3")
		return moveToCell(9, 13)



	else
		sys.debug("quest", "Going back to Vermilion City.")
		return moveToCell(15, 2)--moveToMap("Vermilion City")
	end
end

function SSAnneQuest:SSAnne1FKitchen()
	if dialogs.NeedPharmacist.state or dialogs.KitchenDone.state then
		sys.debug("quest", "Going to SS Anne 1F.")
		return moveToCell(7, 2)--moveToMap("SSAnne 1F")
	else
		-- GET ITEMS CHECK
		if isNpcOnCell(14, 7) and not self.trashBin1Kitchen then -- Item: Great Ball
			if not dialogs.TrashBinCheck.state then
				return talkToNpcOnCell(14, 7)
			else
				dialogs.TrashBinCheck.state = false
				self.trashBin1Kitchen = true
				return
			end
		elseif isNpcOnCell(14, 9) and not self.trashBin2Kitchen then -- Item: Pecha Berry - [Mission Pharmacist]
			if not dialogs.TrashBinCheck.state then
				return talkToNpcOnCell(14, 9)
			else
				dialogs.TrashBinCheck.state = false
				self.trashBin2Kitchen = true
				return
			end
		elseif isNpcOnCell(14, 11) and not self.trashBin3Kitchen then -- Item: Hyper Potion
			if not dialogs.TrashBinCheck.state then
				return talkToNpcOnCell(14, 11)
			else
				dialogs.TrashBinCheck.state = false
				self.trashBin3Kitchen = true
				return
			end
		else
			sys.debug("quest", "Going to talk to Doctor Neumann.")
			return talkToNpcOnCell(5, 3)
		end
	end
end

function SSAnneQuest:SSAnneBasementRoom5()
	if isNpcOnCell(5, 10) then
		if dialogs.NeedRegisterTicket.state then -- Complete the Register on Left-PC and Exit
			if not dialogs.PcGetRegisterDone.state then
				return talkToNpcOnCell(6, 3)
			else
				return talkToNpcOnCell(5, 10)
			end
		else
			return talkToNpcOnCell(5, 10)
		end
	else
		return moveToCell(5, 11)--moveToMap("SSAnne Basement")
	end
end



return SSAnneQuest
