local modem = peripheral.find("modem") or error("no modem found",0) -- finds modem peripheral
modem.open(19) -- opens port for use
modem.transmit(18,19,"Modem Init started\nAwaiting response port 19") -- sends message ready for response
local event, side, channel, replyChannel, message, distance, input -- set variables for response
function awaitmessage() -- recaller function
    repeat -- await new message
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message") -- grabs sent message and stores it
        print(message)
    until channel == 19 -- condition
end
awaitmessage()
if channel == 19 and string.find(message, "Init") then
    dofile("./commands.lua") 
end

