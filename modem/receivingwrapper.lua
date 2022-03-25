local modem = peripheral.find("modem") or error("no modem found",0) -- finds modem peripheral
modem.open(18) -- open modem for conversation
local event, side, channel, replyChannel, message, distance -- set variables for message
function recall()
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message") -- grabs sent message and stores it
        print(message)
    until channel == 18
    if channel == 18 and string.find(message, "Modem") then
        modem.transmit(19,18,"Init message recieved\nOpen connection port 18")
        recall()
    elseif channel == 18 and string.find(message, "veinmine") then
        dofile("./veinminer.lua")
        -- work for veinminer command
        recall()
    elseif channel == 18 and string.find(message, "eval") then
        dofile("./eval.lua")
        -- work for eval command
        recall()
    else
        recall()
    end
end
recall() -- first recall, the rest will be done in commands and so forth
