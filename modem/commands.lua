function commandPicker()
    print("Receiver startup finished, type help for commands")
    input = string.lower(read())
    -- emulate c-style switch
    if string.find(input,"veinminer") then

    elseif string.find(input,"help") then
        print("List of possible commands:\nHelp\nVeinminer\n")
        commandPicker()
    else -- Default case
        print("Unknown command, type help for commands")
        commandPicker()
    end
end