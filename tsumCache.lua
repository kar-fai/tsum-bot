function rm(directory)
    local command = "rm -rf "..rootDir()..directory
    os.execute(command)
end

function filesize(directory)
    local command = "du -sh "..rootDir()..directory.." | cut -f -1"
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    if result == nil or result == "" then
        return "deleted"
    else
        return result:sub(0,-2)
    end
end

local label = {type=CONTROLLER_TYPE.LABEL, text="Choose which you want to delete"}
local images_switch = {type=CONTROLLER_TYPE.SWITCH, title="images/* \t\t\t"..filesize("images")..":", key="delete_images", value=1}
local wwww_images_switch = {type=CONTROLLER_TYPE.SWITCH, title="www/images/ \t\t"..filesize("www/images")..":", key="delete_www_images", value=1}
local www_datacsv_switch = {type=CONTROLLER_TYPE.SWITCH, title="www/data.csv \t"..filesize("www/data.csv")..":", key="delete_www_datacsv", value=1}
local controls = {label, images_switch, wwww_images_switch, www_datacsv_switch}
local enableRemember = true;

dialog(controls, enableRemember);

if images_switch.value == 1 then rm("images/*") end

if wwww_images_switch.value == 1 then rm("www/images") end

if www_datacsv_switch.value == 1 then rm("www/data.csv") end