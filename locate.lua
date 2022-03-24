function inspect()
    local success,data = turtle.inspectUp()
    if data.name ~= nil then
        if string.find(data.name, "ore") then
            turtle.digUp()
        end
    end
    local success,data = turtle.inspectDown()
    if data.name ~= nil then
        if string.find(data.name, "ore") then
            turtle.digDown()
        end
    end
    for i = 1, 4 do
        turtle.turnLeft()
        local success,data = turtle.inspect()
        if data.name ~= nil then
            if string.find(data.name, "ore") then
                turtle.dig()
            end
        end
    end
end

inspect()
