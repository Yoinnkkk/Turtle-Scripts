local args = { ... }
local depth = args[1]
local time = args[2]

for i = 1,tonumber(depth) do
    if turtle.detectDown() then
        turtle.digDown()
    end
    turtle.down()
end

local tunnel = loadfile("./scripts/mining/tunnel.lua")
tunnel(time)

for i = 1,depth do
    if turtle.detectUp() then
        turtle.digUp()
    end
    turtle.up()
end
