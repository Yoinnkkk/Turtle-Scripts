for i = 1,16 do
    turtle.select(i)
    if turtle.refuel(0) then
        local level = turtle.getFuelLevel()
        turtle.refuel()
        print("New fuel level: "..turtle.getFuelLevel()..", increase of "..(turtle.getFuelLevel()-level))
    elseif (turtle.getItemDetail(i) ~= nil) then
        print(turtle.getItemDetail(i).count,turtle.getItemDetail(i).name)
    end
end
