local args = { ... }
local depth = args[1]
local time = args[2]

local burrow = loadfile("./scripts/mining/burrow.lua")

function refuel()
    dofile("./scripts/mining/refuel.lua")
end
refuel()
burrow(depth, time)

print("Current fuel level: "..turtle.getFuelLevel())
if turtle.getFuelLevel() < 500 then
    refuel()
end

dofile("./scripts/mining/locate.lua")
