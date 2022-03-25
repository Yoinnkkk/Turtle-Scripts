local args = { ... }
local depth = args[1]
local time = args[2]

local veniminer = loadfile("./scripts/mining/veinminer.lua")
local tunnel = loadfile("./scripts/mining/tunnel.lua")

for i = 1,tonumber(depth) do
    if turtle.detectDown() then
        turtle.digDown()
        veniminer()
    end
    turtle.down()
end

tunnel(time)

for i = 1,depth do
    if turtle.detectUp() then
        turtle.digUp()
    end
    turtle.up()
end
