--- Bonemeals an spruce sapling until 
--- it fully growths
function search_item(name)
    for i = 1,16 do
        local item = turtle.getItemDetail(i)
        if item and item.name == name then
            return i
        end
    end
    return nil
end

while true do
    local _,data = turtle.inspect()
    if (data.name == "minecraft:spruce_sapling") then
        local bone_meal_slot = search_item("minecraft:bone_meal")

        if bone_meal_slot then
            turtle.select(bone_meal_slot)
            turtle.place()
        else
            print("Insira bone meal e aguarde")
        end
    else
        sleep(2.5)
    end
end