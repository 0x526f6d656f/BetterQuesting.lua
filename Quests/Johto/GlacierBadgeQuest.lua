-- Copyright � 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Glacier Badge Quest'
local description = 'Will clear the Rocket Hideout, and earn the 7th Badge'
local level = 64

local talkedToChappyNPC = false
local N = 1
local lance = false
local computerone = false
local admin = false
local pcJames = false
local pcJessie = false

local GlacierBadgeQuest = Quest:new()
local dialogs = {
	fdp = Dialog:new({ 
		"Rats, no sign of any picture with Christina on this desk!"
		
		
	}),
	marchefdp = Dialog:new({ 
		"I don't have anything to do with this now...",
		"Yes, this was the computer!"
		
	})

}
function GlacierBadgeQuest:new()
	return Quest.new(GlacierBadgeQuest, name, description, level, dialogs)
end


function GlacierBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Glacier Badge") and hasItem("Mineral Badge") then
		return true
	end
	return false
end

function GlacierBadgeQuest:isDone()
	if hasItem("Glacier Badge") and getMapName() == "Mahogany Town Gym" then
		return true
	else
		return false
	end
end

function GlacierBadgeQuest:OlivineCityGym()
	sys.debug("quest", "Going to Mahogany Town.")
	return moveToCell(6, 25)
end

function GlacierBadgeQuest:OlivineCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Olivine Pokecenter" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(13, 32)
	elseif not self:isTrainingOver() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(0, 36)
	else
		sys.debug("quest", "Going to Mahogany Town.")
		return moveToCell(20, 0)
	end
end

function GlacierBadgeQuest:OlivinePokecenter()
	self:pokecenter("Olivine City")
end

function GlacierBadgeQuest:Route40()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(12, 47)
	else
		sys.debug("quest", "Going back to Olivine City.")
		return moveToCell(30, 7)
	end
end

function GlacierBadgeQuest:Route41()
	if not self:isTrainingOver() and not self:needPokecenter() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToRectangle(1, 8, 2, 52)
	else
		sys.debug("quest", "Going back to Olivine City.")
		return moveToCell(52, 0)
	end
end

function GlacierBadgeQuest:Route39()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(28, 65)
	else
		sys.debug("quest", "Going to Mahogany Town.")
		return moveToCell(39, 17)
	end
end

function GlacierBadgeQuest:Route38()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(0, 15)
	else
		sys.debug("quest", "Going to Mahogany Town.")
		return moveToCell(63, 11)
	end
end

function GlacierBadgeQuest:EcruteakStopHouse1()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(0, 7)
	else
		sys.debug("quest", "Going to Mahogany Town.")
		return moveToCell(10, 6)
	end
end


function GlacierBadgeQuest:EcruteakCity()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(3, 26)
	else
		sys.debug("quest", "Going to Mahogany Town.")
		return moveToCell(62, 33)
	end
end


function GlacierBadgeQuest:EcruteakStopHouse2()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(0, 6)
	else
		sys.debug("quest", "Going to Mahogany Town.")
		return moveToCell(10, 6)
	end
end

function GlacierBadgeQuest:Route42()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(3, 18)
	else
		sys.debug("quest", "Going to Mahogany Town.")
		return moveToCell(95, 16)
	end
end

function GlacierBadgeQuest:MahoganyTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mahogany" then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(25, 23)
	elseif not self:isTrainingOver() and not self:needPokecenter() then
		sys.debug("quest", "Going to level Pokemon until Level " .. self.level .. ".")
		return moveToCell(0, 17)
	elseif not isNpcOnCell(11,24) then
		sys.debug("quest", "Going to get 7th badge.")
		return moveToCell(11, 23)
	elseif not self.talkedToChappyNPC then
		sys.debug("quest", "Going to talk to Chappy.")
		return moveToCell(12, 5)
	elseif self.talkedToChappyNPC then 
		sys.debug("quest", "Going to do Rocket quest.")
		return moveToCell(16, 14)
	end
end

function GlacierBadgeQuest:Route43()
	if not self.talkedToChappyNPC then
		sys.debug("quest", "Going to talk to Chappy.")
		return moveToCell(22, 0)
	else
		sys.debug("quest", "Going to do Rocket quest.")
		return moveToCell(18, 64)
	end
end

function GlacierBadgeQuest:LakeofRage()
	if isNpcOnCell(50,28) then
		sys.debug("quest", "Going to talk to Chappy.")
		return talkToNpcOnCell(50,28)
	else
		self.talkedToChappyNPC = true
		sys.debug("quest", "Going to do Rocket quest.")
		return moveToCell(46, 60)
	end
end

function GlacierBadgeQuest:MahoganyTownShop()
	sys.debug("quest", "Going to do Rocket quest.")
	return moveToCell(6, 3)
end

function GlacierBadgeQuest:MahoganyTownRocketHideoutB1F()
	sys.debug("quest", "Going to do Rocket quest.")
	return moveToCell(4, 24)
end

function GlacierBadgeQuest:MahoganyTownRocketHideoutB2F()
	if game.inRectangle(3, 23, 48, 30) and not lance then 
		if isNpcOnCell(24, 22) then
			if not game.inRectangle(24, 23, 24, 23) then
				moveToCell(24,23,24,23)
			else
				talkToNpcOnCell(24,22) 
				lance = true
				return
			end
		else 
			moveToCell(24,22)
		end
	elseif game.inRectangle(3,30,48,23) and not isNpcOnCell(24,22) then
		moveToCell(24,22)
	elseif game.inRectangle(3,30,48,23) then
		moveToCell(49,30)
	elseif game.inRectangle(14,22,26,9) then
		if isNpcOnCell(15,12) then
			talkToNpcOnCell(15,12)
		elseif isNpcOnCell(15,13) then
			talkToNpcOnCell(15,13) 
		elseif isNpcOnCell(15,14) then
			talkToNpcOnCell(15,14)
		else
			talkToNpcOnCell(24,22)
		end
	elseif game.inRectangle(3,3,48,5) or game.inRectangle(46,6,40,19) then 
		if not admin and not pcJessie then
			if not game.inRectangle(40,18,40,18) then
				moveToCell(40,18)
			else
				talkToNpcOnCell(40,17)
				pcJessie = true
				return
			end
		elseif admin then 
			moveToCell(49,5)
		else
			moveToCell(2,5)
		end
	elseif game.inRectangle(3,9,9,19) then
		if not admin and not pcJames then
			if not game.inRectangle(5,18,5,18) then
				return moveToCell(5,18)
			else
				talkToNpcOnCell(5,17)
				pcJames = true	
				return
			end
		else
			moveToCell(2,10)
		end
	end
end


function GlacierBadgeQuest:MahoganyTownRocketHideoutB3F()
	if game.inRectangle(48,4,26,30) then
		if dialogs.fdp.state then
			dialogs.fdp.state = false
			N = N + 1
			return
		elseif dialogs.marchefdp.state then
			if not admin then
			moveToCell(49,5)
			else moveToCell(49,30)
			end
		elseif N == 1 then
				if not game.inRectangle(40,19,40,19) then
					moveToCell(40,19)
				else
				talkToNpcOnCell(40,18)
				return
				end
		elseif N == 2 then
				if not game.inRectangle(37,19,37,19) then
					moveToCell(37,19)
				else
				talkToNpcOnCell(37,18)
				
				return
				end
		elseif  N == 3 then
				if not game.inRectangle(34,19,34,19) then
					moveToCell(34,19)
				else
				talkToNpcOnCell(34,18)
				
				return
				end
		elseif  N == 4 then
				if not game.inRectangle(31,19,31,19) then
					moveToCell(31,19)
				else
				talkToNpcOnCell(31,18)
				
				return
				end
		elseif N == 5 then
				if not game.inRectangle(40,15,40,15) then
					moveToCell(40,15)
				else
				talkToNpcOnCell(40,14)
				
				return
				end
		elseif N == 6 then
				if not game.inRectangle(37,15,37,15) then
					moveToCell(37,15)
				else
				talkToNpcOnCell(37,14)
			
				return
				end
		elseif N == 7 then
				if not game.inRectangle(34,15,34,15) then
					moveToCell(34,15)
				else
				talkToNpcOnCell(34,14)
			
				return
				end
		elseif N == 8 then
				if not game.inRectangle(31,15,31,15) then
					moveToCell(31,15)
					else
				talkToNpcOnCell(31,14)
				
				return
				end
			
		elseif not admin then
			moveToCell(49,5)
		else moveToCell(49,30)
		end
	elseif game.inRectangle(3,4,23,19) then
		if isNpcOnCell(18,15) then 
			moveToCell(2,10)
		elseif isNpcOnCell(18,9) and  not admin then
			talkToNpcOnCell(18,9)
		elseif not admin then
			if not game.inRectangle(16,7,16,7)then
				moveToCell(16,7)
			else	
			talkToNpcOnCell(16,6)
			admin = true
			return
			end
		else moveToCell(2,5)
		end
	end
end



function GlacierBadgeQuest:PokecenterMahogany()
	if isNpcOnCell(9,22) then
		sys.debug("quest", "Going to talk to NPC.")
		return talkToNpcOnCell(9,22)
	else
		return self:pokecenter("Mahogany Town")
	end
end

function GlacierBadgeQuest:MahoganyTownGym()
	if game.inRectangle(15, 49, 21, 67) then 
		sys.debug("quest", "Going to get 7th badge.")
		return moveToCell(17, 49)

	elseif game.inRectangle(12, 32, 22, 46) then  
		sys.debug("quest", "Going to get 7th badge.")
		return moveToCell(17, 32)

	elseif game.inRectangle(13, 12, 21, 29) then 
		sys.debug("quest", "Going to get 7th badge.")
		return talkToNpcOnCell(19, 12)
	end
end

return GlacierBadgeQuest