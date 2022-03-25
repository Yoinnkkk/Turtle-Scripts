local modem = peripheral.find("modem") or error("no modem found",0) -- finds modem peripheral
modem.open(18) -- open modem for conversation
local event, side, channel, replyChannel, message, distance -- set variables for message
function awaitmessage()
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message") -- grabs sent message and stores it
    until channel == 18
end
awaitmessage() -- first recall, the rest will be done in commands and so forth
if channel == 18 and string.find(message, "Modem") then
    modem.transit(19,18,"Startup message recieved. Open connection port 18")
    awaitmessage()
elseif channel == 18 and string.find(message, "veinminer") then
    -- work for veinminer command
    awaitmessage()
else
    awaitmessage()
end