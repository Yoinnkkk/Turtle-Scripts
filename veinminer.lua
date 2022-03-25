local x = 0
local y = 0
local z = 0
local direction = 0
local ore = {}
local movement = {}

-- x is forwards
-- -x is backwards
-- z is left
-- -z is right
--
-- 0 is forwards
-- 1 is left
-- 2 is backwards
-- 3 is right

function locate()
    local loopedore = {}
    if turtle.detectUp() then
        local success,data = turtle.inspectUp()
        if string.find(data.name, "ore") then
            ore[#ore+1] = {x,y+1,z}
            loopedore[#loopedore+1] = ore[#ore]
        end
    end
    if turtle.detectDown() then
        local success,data = turtle.inspectDown()
        if string.find(data.name, "ore") then
            ore[#ore+1] = {x,y-1,z}
            loopedore[#loopedore+1] = ore[#ore]
        end
    end
    for direction = 1,4 do
        turtle.turnLeft()
        if turtle.detect() then
            local success,data = turtle.inspect()
            if string.find(data.name, "ore") then
                ore[#ore+1] = {direction % 2 == 0 and (direction / 2 > 1 and x+1 or x-1) or x,y,direction % 2 == 1 and (direction / 2 < 1 and z+1 or z-1) or z}
                loopedore[#loopedore+1] = ore[#ore]
            end
        end
    end
    direction = 0
    return loopedore
end  

local finished = false
while finished == false do
    local iterationore = locate()
    if #ore == 0 then
        while #movement ~= 0 do
            if movement[#movement][2] == 0 then
                local desireddirection = movement[#movement][1] == 0 and 2 * (movement[#movement][3] < 0 and 1 or 0) + 1 or 2 * (movement[#movement][1] > 0 and 1 or 0)
                if desireddirection > 0 then
                    for i = 1,(4 - desireddirection) do
                        turtle.turnLeft()
                    end
                end
                turtle.dig()
                turtle.forward()
                if desireddirection == 0 then
                    x = x + 1
                elseif desireddirection == 1 then
                    z = z - 1
                elseif desireddirection == 2 then
                    x = x - 1
                elseif desireddirection == 3 then
                    z = z + 1
                end
                if desireddirection > 0 then
                    for i = 1,(4 - desireddirection) do
                        turtle.turnRight()
                    end
                end
            elseif movement[#movement][2] == 1 then
                turtle.digDown()
                turtle.down()
                y = y - 1
            else
                turtle.digUp()
                turtle.up()
                y = y + 1
            end
            movement[#movement] = nil
        end
        movement = {}
        finished = true
    elseif #iterationore == 1 then
        local orelocation = {iterationore[1][1] - x, iterationore[1][2] - y, iterationore[1][3] - z}
        if orelocation[2] == 0 then
            local desireddirection = orelocation[1] == 0 and 2 * (orelocation[3] < 0 and 1 or 0) + 1 or 2 * (orelocation[1] < 0 and 1 or 0)
            if desireddirection > 0 then
                for i = 1,desireddirection do
                    turtle.turnLeft()
                end
            end
            turtle.dig()
            turtle.forward()
            movement[#movement+1] = orelocation
            if desireddirection > 0 then
                for i = 1,desireddirection do
                    turtle.turnRight()
                end
            end
        elseif orelocation[2] == 1 then
            turtle.digUp()
            turtle.up()
            movement[#movement+1] = {0,1,0}
        else
            turtle.digDown()
            turtle.down()
            movement[#movement+1] = {0,-1,0}
        end
        x = iterationore[1][1]
        y = iterationore[1][2]
        z = iterationore[1][3]
        for i = 1,#ore do
            if ore[i][1] == iterationore[1][1] and ore[i][2] == iterationore[1][2] and ore[i][3] == iterationore[1][3] then
                ore[i] = nil
                for j = i,#ore - 1 do
                    ore[j] = ore[j+1]
                end
            end
        end
        ore[#ore] = nil
    elseif #ore ~= 0 and #iterationore == 0 then
        if movement[#movement][2] == 0 then
            local desireddirection = movement[#movement][1] == 0 and 2 * (movement[#movement][3] < 0 and 1 or 0) + 1 or 2 * (movement[#movement][1] > 0 and 1 or 0)
            if desireddirection > 0 then
                for i = 1,(4 - desireddirection) do
                    turtle.turnLeft()
                end
            end
            turtle.dig()
            turtle.forward()
            if desireddirection == 0 then
                x = x + 1
            elseif desireddirection == 1 then
                z = z - 1
            elseif desireddirection == 2 then
                x = x - 1
            elseif desireddirection == 3 then
                z = z + 1
            end
            if desireddirection > 0 then
                for i = 1,(4 - desireddirection) do
                    turtle.turnRight()
                end
            end
        elseif movement[#movement][2] == 1 then
            turtle.digDown()
            turtle.down()
            y = y - 1
        else
            turtle.digUp()
            turtle.up()
            y = y + 1
        end
        movement[#movement] = nil
    else
        local chosenore = ore[#ore]
        local orePosition = {chosenore[1] - x, chosenore[2] - y, chosenore[3] - z}
        if orePosition[2] == 0 then
            local desireddirection = orePosition[1] == 0 and 2 * (orePosition[3] < 0 and 1 or 0) + 1 or 2 * (orePosition[1] < 0 and 1 or 0)
            if desireddirection > 0 then
                for i = 1,desireddirection do
                    turtle.turnLeft()
                end
            end
            turtle.dig()
            turtle.forward()
            movement[#movement+1] = orePosition
            if desireddirection > 0 then
                for i = 1,desireddirection do
                    turtle.turnRight()
                end
            end
        elseif orePosition[2] == 1 then
            turtle.digUp()
            turtle.up()
            movement[#movement+1] = {0,1,0}
        else
            turtle.digDown()
            turtle.down()
            movement[#movement+1] = {0,-1,0}
        end
        x = chosenore[1]
        y = chosenore[2]
        z = chosenore[3]
        for i = 1,#ore do
            if ore[i][1] == chosenore[1] and ore[i][2] == chosenore[2] and ore[i][3] == chosenore[3] then
                ore[i] = nil
                for j = i,#ore - 1 do
                    ore[j] = ore[j+1]
                end
            end
        end
        ore[#ore] = nil
    end
end