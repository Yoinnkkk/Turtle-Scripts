local x = 0
local y = 0
local z = 0
local direction = 0
ore = {}

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
    loopedore = {}
    if turtle.detectUp() then
        local success,data = turtle.inspectUp()
        if string.find(data.name, "planks") then
            print(success)
            ore[#ore+1] = {x,y+1,z}
            loopedore[#loopedore+1] = ore[#ore]
        end
    end
    if turtle.detectDown() then
        local success,data = turtle.inspectDown()
        if string.find(data.name, "planks") then
            print(success)
            ore[#ore+1] = {x,y-1,z}
            loopedore[#loopedore+1] = ore[#ore]
        end
    end
    for direction = 1,4 do
        turtle.turnLeft()
        if turtle.detect() then
            local success,data = turtle.inspect()
            if string.find(data.name, "planks") then
                print(success)
                ore[#ore+1] = {direction % 2 == 0 and (direction / 2 > 1 and x+1 or x-1) or x,y,direction % 2 == 1 and (direction / 2 < 1 and z+1 or z-1) or z}
                loopedore[#loopedore+1] = ore[#ore]
            end
        end
    end
    direction = 0
    return loopedore
end  

finished = false
while finished == false do
    iterationore = locate()
    if #ore == 0 then
        finished = true
    elseif #iterationore == 1 then
        orelocation = {iterationore[1][1] - x, iterationore[1][2] - y, iterationore[1][3] - z}
        if orelocation[2] == 0 then
            desireddirection = orelocation[1] == 0 and 2 * (orelocation[3] < 0 and 1 or 0) + 1 or 2 * (orelocation[1] < 0 and 1 or 0)
            print(desireddirection)
            if desireddirection > 0 then
                for i = 1,desireddirection do
                    turtle.turnLeft()
                end
            end
            turtle.dig()
            turtle.forward()
            if desireddirection > 0 then
                for i = 1,desireddirection do
                    turtle.turnRight()
                end
            end
            x = orelocation[1]
            y = orelocation[3]
        elseif orelocation[2] == 1 then
            turtle.digUp()
            turtle.up()
        else
            turtle.digDown()
            turtle.down()
        end
    end
end


for i = 1,#ore do
    print(ore[i][1].." "..ore[i][2].." "..ore[i][3])
end

