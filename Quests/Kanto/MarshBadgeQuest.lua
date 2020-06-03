-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Marsh Badge'
local description = 'Get Badge + Dojo Pokemon'

-- TO-DO: Get 6th Pokemon out of box again after swapping for Ditto.
-- go to boxes, check boxes for highest level pokemon and put it into team.
-- if team members == 6 then swap with lowest level, else just put it into team.

local dialogs = {
    dojoSaffronDone = Dialog:new({
        "tomodachi"
    })
}

local MarshBadgeQuest = Quest:new()

function MarshBadgeQuest:new()
    --setting starter, if no none defined
    if not KANTO_DOJO_POKEMON_ID then
        KANTO_DOJO_POKEMON_ID = math.random(1,2)
    end
    local o = Quest.new(MarshBadgeQuest, name, description, level, dialogs)
    o.dojoState = false
    return o
end

function MarshBadgeQuest:isDoable()
    if self:hasMap() and not hasItem("Rain Badge") then
        return true
    else
        return false
    end
end

function MarshBadgeQuest:isDone()
    if hasItem("Marsh Badge") and getMapName() == "Lavender Town"
    or getMapName() == "Silph Co 1F"
    or getMapName() == "Route 5" then
        return true
    else
        return false
    end
end


function MarshBadgeQuest:Route8()
    if hasItem("Marsh Badge") then
        sys.debug("quest", "Going to Lavender Town.")
        return moveToCell(72, 10)
    else
        sys.debug("quest", "Going to Saffron City.")
        return moveToCell(3, 12)
    end
end


function MarshBadgeQuest:Route8StopHouse()
    if not hasItem("Marsh Badge") then
        sys.debug("quest", "Going to Saffron City.")
        return moveToCell(0, 6)
    else
        sys.debug("quest", "Going to Lavender Town.")
        return moveToCell(10, 6)
    end
end

function MarshBadgeQuest:isBuyingBike()
    if BUY_BIKE == true and hasItem("Bike Voucher") and getMoney() >= 60000 then
        return true
    else
        return false
    end
end

function MarshBadgeQuest:Route5StopHouse()
    return moveToCell(4, 12)
end

function MarshBadgeQuest:SaffronCity()
    if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Saffron" then
        sys.debug("quest", "Going to heal Pokemon.")
        return moveToCell(19, 45)

    elseif isNpcOnCell(49,14) then -- Rocket on Saffron Gym Entrance
        sys.debug("quest", "Going to Silph Co.")
        return moveToCell(33, 34)

    elseif not dialogs.dojoSaffronDone.state and not self.dojoState then --Need Check dojo
        sys.debug("quest", "Going to Dojo.")
        return moveToCell(42, 13)

    elseif not hasItem("Marsh Badge") then -- Need beat Gym
        sys.debug("quest", "Going to fight 6th Gym.")
        return moveToCell(49, 13)

    else
        sys.debug("quest", "Going to Lavender Town.")
        return moveToCell(60, 39)
    end
end

function MarshBadgeQuest:PokecenterSaffron()
    return self:pokecenter("Saffron City")
end

function MarshBadgeQuest:SaffronDojo()
    if isNpcOnCell(7,5) then
        if dialogs.dojoSaffronDone.state then
            if isNpcOnCell(3,4) and isNpcOnCell(10,4) then
                if KANTO_DOJO_POKEMON_ID == 1 then -- Hitmonchan
                    return talkToNpcOnCell(3, 4)
                else -- Hitmonlee
                    return talkToNpcOnCell(10,4)
                end
            else
                return moveToCell(7, 15)
            end
        else
            return talkToNpcOnCell(7,5)
        end
    else
        self.dojoState = true
        return moveToCell(6, 15)
    end
end


function MarshBadgeQuest:SaffronGym()
    if not hasItem("Marsh Badge") then
        if game.inRectangle(9, 16, 15, 22) then -- Middle, Bottom
            return moveToCell(15, 17)
        elseif game.inRectangle(17, 16, 23, 20) then -- Right, Bottom
            return moveToCell(18, 20)
        elseif game.inRectangle(1, 16, 7, 20) then -- Left, Bottom
            return moveToCell(2, 17)
        elseif game.inRectangle(17, 2, 23, 6) then -- Right, Top
            return moveToCell(18, 6)
        elseif game.inRectangle(1, 2, 7, 6) then -- Left, Top
            return moveToCell(2, 6)
        elseif game.inRectangle(9, 9, 15, 13) then
            return talkToNpcOnCell(12, 10)
        else
            error("MarshBadgeQuest:SaffronGym(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
        end
    else
        if game.inRectangle(9, 9, 15, 13) then
            return moveToCell(10, 13)
        elseif game.inRectangle(9, 16, 15, 22) then
            return moveToCell(12, 22)
        else
            error("MarshBadgeQuest:SaffronGym(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
        end
    end
end

return MarshBadgeQuest
