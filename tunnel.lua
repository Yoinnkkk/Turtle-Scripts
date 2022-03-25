local args = { ... }
local time = args[1]
local veniminer = loadfile("./scripts/mining/veinminer.lua")

for i = 1,tonumber(time) do
    veniminer()
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
