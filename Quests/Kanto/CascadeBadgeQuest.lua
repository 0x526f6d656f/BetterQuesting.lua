

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Cascade Badge Quest'
local description = 'From Cerulean to Route 5'
local level       = 21

local dialogs = {
	billTicketDone = Dialog:new({
		"Oh!! You found it!",
		"Have you enjoyed the Cruise yet?"
	}),
	bookPillowDone = Dialog:new({
		"Oh! Looks like Bill's research book is under his pillow.",
		"There is nothing else here..."
	})
}

local CascadeBadgeQuest = Quest:new()

function CascadeBadgeQuest:new()
	return Quest.new(CascadeBadgeQuest, name, description, level, dialogs)
end

function CascadeBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("HM01 - Cut") then
		return true
	end
	return false
end

function CascadeBadgeQuest:isDone()
	if getMapName() == "Route 5" then
		return true
	else
		return false
	end
end

function CascadeBadgeQuest:CeruleanCity()
	if self:needPokecenter()
		or not game.isTeamFullyHealed()
		or self.registeredPokecenter ~= "Pokecenter Cerulean"
	then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(26,30)

	elseif self:needPokemart() then
		sys.debug("quest", "Going to buy Pokeballs.")
		return moveToCell(24,40)

	elseif not self:isTrainingOver() then
		sys.debug("quest", "Going to train Pokemon until level " .. self.level .. ".")
		-- Route 24 Bridge
		return moveToCell(39,0)

	elseif not dialogs.billTicketDone.state then
		sys.debug("quest", "Going to talk to Bill for S.S. Anne Ticket.")
		-- Route 24 Bridge
		return moveToCell(39,0)

	elseif not hasItem("Cascade Badge") then
		sys.debug("quest", "Going to fight Misty for 2nd badge.")
		return moveToCell(35,32)

	elseif isNpcOnCell(43,23) then
		sys.debug("quest", "Going to talk to Police Officer.")
		--talk to the newly added police officer
		return talkToNpcOnCell(43,23)

	else
		-- all done Ticket + Badge (Go to Route 5)
		sys.debug("quest", "Going to Route 5.")
		return moveToCell(16, 50) -- Route 5
	end
end

function CascadeBadgeQuest:CeruleanPokemart()
	self:pokemart("Cerulean City")
end

function CascadeBadgeQuest:PokecenterCerulean()
	return self:pokecenter("Cerulean City")
end

function CascadeBadgeQuest:Route24Bridge()
	if not self:isTrainingOver() and not self:needPokecenter() then
		sys.debug("quest", "Going to train Pokemon until level " .. self.level .. ".")
		return moveToCell(14,0)
	elseif self:needPokecenter() then
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(14,31)
	elseif not dialogs.billTicketDone.state then
		sys.debug("quest", "Going to talk to Bill for S.S. Anne Ticket.")
		return moveToCell(14,0)
	else
		sys.debug("quest", "Going to Cerulean City.")
		return moveToCell(14,31)
	end
end

function CascadeBadgeQuest:Route24Grass()
	if not self:isTrainingOver()
		and not self:needPokecenter()
	then
		sys.debug("quest", "Going to train Pokemon until level " .. self.level .. ".")
		return moveToRectangle(6, 2, 9, 16)
	else
		sys.debug("quest", "Going to heal Pokemon.")
		return moveToCell(8,0)
	end
end

function CascadeBadgeQuest:Route24()
	if game.inRectangle(14, 0, 15, 31) then
		return self:Route24Bridge()
	elseif game.inRectangle(6, 0, 12, 31) then
		return self:Route24Grass()
	else
		error("CascadeBadgeQuest:Route24(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
	end
end

function CascadeBadgeQuest:Route25()
	if hasItem("Nugget") then
		sys.debug("quest", "Going to Maniac House to sell " .. getItemQuantity("Nugget") .. " Nuggets.")
		return moveToCell(114,7) -- sell Nugget give $15.000 maniac house
	elseif self:needPokecenter() then
		sys.debug("quest", "Going to heal Pokemon.")
		moveToCell(14, 30)
	elseif not self:isTrainingOver() then
		sys.debug("quest", "Going to train Pokemon until level " .. self.level .. ".")
		return moveToCell(8,30)
	elseif not dialogs.billTicketDone.state then
		sys.debug("quest", "Going to talk to Bill for S.S. Anne Ticket.")
		return moveToCell(99,7)
	else
		sys.debug("quest", "Going back to Cerulean City.")
		moveToCell(14, 30)
	end
end

function CascadeBadgeQuest:BillsHouse() -- get ticket 
	if dialogs.billTicketDone.state then
		return moveToCell(10,13)
	else
		if dialogs.bookPillowDone.state then
			return talkToNpcOnCell(11, 3)
		else
			return talkToNpcOnCell(18, 2)
		end
	end
end

function CascadeBadgeQuest:ItemManiacHouse() -- sell nugget
	if hasItem("Nugget") then
		return talkToNpcOnCell(6, 5)
	else
		return moveToCell(4,9)
	end
end

function CascadeBadgeQuest:CeruleanGym() -- get Cascade Badge
	if self:needPokecenter() or hasItem("Cascade Badge") then
		return moveToCell(11,25)
	else
		return talkToNpcOnCell(10, 6)
	end
end

return CascadeBadgeQuest