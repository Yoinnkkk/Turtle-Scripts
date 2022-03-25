local modem = peripheral.find("modem") or error("no modem found",0) -- finds modem peripheral
modem.open(19) -- opens port for use
print("Receiver startup finished\n")
function commandPicker()
    print("Type help for commands")
    input = string.lower(read())
    -- emulate c-style switch
    if string.find(input,"veinmine") then
        modem.transmit(18,19,"veinmine")
        commandPicker()
    elseif string.find(input, "eval") then
        modem.transmit(18,19,"eval")
        commandPicker()
    elseif string.find(input,"help") then
        print("List of possible commands:\nHelp\nVeinminer\nEval\n")
        commandPicker()
    else -- Default case
        print("Unknown command\nType help for commands")
        commandPicker()
    end
end
commandPicker()