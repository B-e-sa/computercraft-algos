--- Timbers an spruce tree and  
--- plants a new spruce sapling,
--- using charcoal
function w_debug(text)
    local f = fs.open("debug.txt", "w")
    f.write(textutils.serialise(text))
    f.close()
end

local spruce = "minecraft:spruce_log"
local sapling = "minecraft:spruce_sapling"
local chest = "minecraft:chest"
local charcoal = "minecraft:charcoal"

function search_item(name)
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if item and item.name == name then
            return i
        end
    end
    return nil
end

function wait_fuel()
    while true do
        local fuel_level = turtle.getFuelLevel()
        if fuel_level < 1 then
            local charcoal_slot = search_item(charcoal)
            if not charcoal_slot then
                term.clear()
                print("Insira combustivel no primeiro slot e aguarde")
                sleep(2.5)
            else
                turtle.select(charcoal_slot)
                turtle.refuel()
            end
            break
        else
            break
        end
    end
end

function timber()
    turtle.dig();
    turtle.suck();
    local block_top, _ = turtle.inspectUp();
    if (block_top) then
        turtle.digUp();
    end
    wait_fuel()
    turtle.up();
end

function return_to_start()
    while true do
        local block, data = turtle.inspectDown();
        if block then
            if data.name ~= chest then
                turtle.dig()
            else
                local spruce_slot = search_item(spruce)
                turtle.select(spruce_slot)
                turtle.dropDown()
                break
            end
        end
        wait_fuel()
        turtle.down()
    end
end

function plant_sapling()
    local sapling_slot = search_item(sapling)
    while true do
        if not sapling_slot then
            term.clear()
            print("Insira uma muda de carvalho escuro no segundo slot e aguarde")
            sleep(2.5)
        else
            turtle.select(sapling_slot)
            turtle.place()
            break
        end
    end
end

while true do
    local _, front = turtle.inspect();
    if front.name == spruce then
        timber()
    elseif front.name == sapling then
        sleep(2.5)
    else
        return_to_start()
        plant_sapling()
    end
end
