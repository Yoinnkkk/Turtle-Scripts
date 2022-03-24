local args = { ... }
local time = args[1]

for i = 1,tonumber(time) do
    dofile("./scripts/mining/locate.lua")
    if turtle.detect() then
        turtle.dig()
    end
    turtle.forward()
    if(turtle.getFuelLevel() < 500) then
        dofile("./scripts/mining/refuel.lua")
    end
end
turtle.turnLeft()
turtle.turnLeft()
for i = 1,tonumber(time) do
    if turtle.detect() then
        turtle.dig()
    end
    turtle.forward()
end
