-- this is an example/default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via their ids
-- it will also keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
-- if you run into issues when touching A LOT of items/locations here, see the comment about Tracker.AllowDeferredLogicUpdate in autotracking.lua
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
-- used for hint tracking to quickly map hint status to a value from the Highlight enum
HINT_STATUS_MAPPING = {}
if Highlight then
    HINT_STATUS_MAPPING = {
        [20] = Highlight.Avoid,
        [40] = Highlight.None,
        [10] = Highlight.NoPriority,
        [0] = Highlight.Unspecified,
        [30] = Highlight.Priority
    }
end

local Entrances = require("scripts/logic/entrance")

CUR_INDEX = -1
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}
local VISITED_STAGES_FORMAT = "pokepark_visited_stages_%i"
-- The first integer is the team (mostly unused by Archipelago currently). The second integer is the slot number.
local GOAL_STATUS_FORMAT = "_read_client_status_%i_%i"
local STAGE_NAME_TO_TAB_NAME = {
    ["Meadow Zone Main Area"] = {"Meadow Zone", "Main Area"},
    ["Meadow Zone Venusaur Area"] = {"Meadow Zone", "Venusaur Area"},
    ["Treehouse"] = {"Treehouse"},
    ["Beach Zone Main Area"] = {"Beach Zone"},
    ["Ice Zone Main Area"] = {"Ice Zone", "Main Area"},
    ["Ice Zone Empoleon Area"] = {"Ice Zone", "Empoleon Area"},
    ["Cavern Zone Main Area"] = {"Cavern Zone"},
    ["Magma Zone Main Area"] = {"Magma Zone", "Main Area"},
    ["Magma Zone Blaziken Area"] = {"Magma Zone", "Blaziken Area"},
    ["Haunted Zone Main Area"] = {"Haunted Zone", "Main Area"},
    ["Haunted Zone Mansion Area"] = {"Haunted Zone", "Mansion Area"},
    ["Haunted Zone Rotom Area"] = {"Haunted Zone", "Rotom Area"},
    ["Granite Zone Main Area"] = {"Granite Zone"},
    ["Flower Zone Main Area"] = {"Flower Zone"},
    ["Skygarden"] = {"Skygarden"},
    ["Pokepark Entrance"] = {"Pokepark Entrance"},
    ["Bulbasaur's Daring Dash Attraction"] = {"Attractions", "Bulbasaur's Daring Dash"},
    ["Venusaur's Vine Swing Attraction"] = {"Attractions", "Venusaur's Vine Swing"},
    ["Pelipper's Circle Circuit Attraction"] = {"Attractions", "Pelipper's Circle Circuit"},
    ["Gyarados' Aqua Dash Attraction"] = {"Attractions", "Gyarados' Aqua Dash"},
    ["Empoleon's Snow Slide Attraction"] = {"Attractions", "Empoleon's Snow Slide"},
    ["Bastiodon's Panel Crush Attraction"] = {"Attractions", "Bastiodon's Panel Crush"},
    ["Blaziken's Boulder Bash Attraction"] = {"Attractions", "Blaziken's Boulder Bash"},
    ["Tangrowth's Swing-Along Attraction"] = {"Attractions", "Tangrowth's Swing-Along"},
    ["Rotom's Spooky Shoot-'em-Up Attraction"] = {"Attractions", "Rotom's Spooky Shoot-'em-Up"},
    ["Dusknoir's Speed Slam Attraction"] = {"Attractions", "Dusknoir's Speed Slam"},
    ["Absol's Hurdle Bounce Attraction"] = {"Attractions", "Absol's Hurdle Bounce"},
    ["Salamence's Sky Race Attraction"] = {"Attractions", "Salamence's Sky Race"},
    ["Rayquaza's Balloon Panic Attraction"] = {"Attractions", "Rayquaza's Balloon Panic"}

}
-- gets the data storage key for hints for the current player
-- returns nil when not connected to AP
function getHintDataStorageKey()
    if AutoTracker:GetConnectionState("AP") ~= 3 or Archipelago.TeamNumber == nil or Archipelago.TeamNumber == -1 or
        Archipelago.PlayerNumber == nil or Archipelago.PlayerNumber == -1 then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print("Tried to call getHintDataStorageKey while not connect to AP server")
        end
        return nil
    end
    return string.format("_read_hints_%s_%s", Archipelago.TeamNumber, Archipelago.PlayerNumber)
end

-- resets an item to its initial state
function resetItem(item_code, item_type)
    local obj = Tracker:FindObjectForCode(item_code)
    if obj then
        item_type = item_type or obj.Type
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("resetItem: resetting item %s of type %s", item_code, item_type))
        end
        if item_type == "toggle" or item_type == "toggle_badged" then
            obj.Active = false
        elseif item_type == "progressive" or item_type == "progressive_toggle" then
            obj.CurrentStage = 0
            obj.Active = false
        elseif item_type == "consumable" then
            obj.AcquiredCount = 0
        elseif item_type == "custom" then
            -- your code for your custom lua items goes here
        elseif item_type == "static" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("resetItem: tried to reset static item %s", item_code))
        elseif item_type == "composite_toggle" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format(
                "resetItem: tried to reset composite_toggle item %s but composite_toggle cannot be accessed via lua." ..
                    "Please use the respective left/right toggle item codes instead.", item_code))
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("resetItem: unknown item type %s for code %s", item_type, item_code))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("resetItem: could not find item object for code %s", item_code))
    end
end

-- advances the state of an item
function incrementItem(item_code, item_type, multiplier)
    local obj = Tracker:FindObjectForCode(item_code)
    if obj then
        item_type = item_type or obj.Type
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("incrementItem: code: %s, type %s", item_code, item_type))
        end
        if item_type == "toggle" or item_type == "toggle_badged" then
            obj.Active = true
        elseif item_type == "progressive" or item_type == "progressive_toggle" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif item_type == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment * multiplier
        elseif item_type == "custom" then
            -- your code for your custom lua items goes here
        elseif item_type == "static" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("incrementItem: tried to increment static item %s", item_code))
        elseif item_type == "composite_toggle" and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format(
                "incrementItem: tried to increment composite_toggle item %s but composite_toggle cannot be access via lua." ..
                    "Please use the respective left/right toggle item codes instead.", item_code))
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("incrementItem: unknown item type %s for code %s", item_type, item_code))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("incrementItem: could not find object for code %s", item_code))
    end
end

function set_setting_item(obj, v)
    if obj.Type == 'toggle' then
        local active = v ~= 0
        obj.Active = active
        return v
    elseif obj.Type == 'progressive' then
        obj.CurrentStage = v
        return v
    elseif obj.Type == "consumable" then
        obj.AcquiredCount = v
        obj.MinCount = v
        obj.MaxCount = v
        return v
    else
        print(string.format("Unsupported item type '%s' for item '%s'", tostring(obj.Type), item_code))
        return nil
    end
end

-- apply everything needed from slot_data, called from onClear
function apply_slot_data(slot_data)
    -- autotracking settings from YAML
    local function setFromSlotData(slot_data_key, item_code)
        local v = (slot_data.options and slot_data.options[slot_data_key]) or slot_data[slot_data_key]
        if not v then
            print(string.format("Could not find key '%s' in slot data", slot_data_key))
            return nil
        end

        local obj = Tracker:FindObjectForCode(item_code)
        if not obj then
            print(string.format("Could not find item for code '%s'", item_code))
            return nil
        end
        set_setting_item(obj, v)

    end
    if slot_data["goal"] == 1 then
        local obj = Tracker:FindObjectForCode("postgame_locations_activated")
        set_setting_item(obj, 1)
        local obj = Tracker:FindObjectForCode("mew_power_comp_locations_activated")
        set_setting_item(obj, 0)
    end
    if slot_data["goal"] == 0 then
        local obj = Tracker:FindObjectForCode("postgame_locations_activated")
        set_setting_item(obj, 0)
        local obj = Tracker:FindObjectForCode("mew_power_comp_locations_activated")
        set_setting_item(obj, 1)
    end
    setFromSlotData('num_required_prisma_count_skygarden', 'required_prismas')
    setFromSlotData('remove_battle_power_comp_locations', 'remove_battle_power_comp_locations')
    setFromSlotData('remove_chase_power_comp_locations', 'remove_chase_power_comp_locations')
    setFromSlotData('remove_quiz_power_comp_locations', 'remove_quiz_power_comp_locations')
    setFromSlotData('remove_hide_and_seek_power_comp_locations', 'remove_hide_and_seek_power_comp_locations')
    setFromSlotData('remove_errand_power_comp_locations', 'remove_errand_power_comp_locations')
    setFromSlotData('remove_misc_power_comp_locations', 'remove_misc_power_comp_locations')
    setFromSlotData('remove_legendary_pokemon_power_comp_locations', 'remove_legendary_pokemon_power_comp_locations')
    setFromSlotData('remove_power_training_locations', 'remove_power_training_locations')
    setFromSlotData('remove_attraction_locations', 'remove_attraction_locations')
    setFromSlotData('remove_attraction_prisma_locations', 'remove_attraction_prisma_locations')
    setFromSlotData('remove_pokemon_unlock_locations', 'remove_pokemon_unlock_locations')
    setFromSlotData('harder_enemy_ai', 'harder_enemy_ai')
    setFromSlotData('each_zone', 'each_zone')

    SLOT_DATA_EXIT_TO_ENTRANCE = {}
    local load_assignments_from_ap = Tracker:FindObjectForCode("setting_load_exit_assignments_from_ap")
    if load_assignments_from_ap.Active then
        visited_stages_key = string.format(VISITED_STAGES_FORMAT, Archipelago.PlayerNumber)

        Archipelago:Get({visited_stages_key})

        local entrances = slot_data["entrances"]
        if entrances then
            for entrance, exit in pairs(entrances) do
                local entrance_mapped = Entrances.slot_data_name_to_local[entrance]
                local exit_mapped = Entrances.slot_data_name_to_local[exit]

                if entrance_mapped and exit_mapped then
                    local new_entrance_name = "@" .. entrance_mapped .. "_Entrance"
                    local new_exit_name = exit_mapped .. "_Exit"
                    Entrances.slot_data_exit_to_entrance[new_exit_name] = new_entrance_name
                end
            end
        else
            print("'entrances' was not present in slot_data, automatic entrance assignment will not be available")
        end
    end
end

-- called right after an AP slot is connected
function onClear(slot_data)
    -- use bulk update to pause logic updates until we are done resetting all items/locations
    Tracker.BulkUpdate = true
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    CUR_INDEX = -1
    -- reset locations
    for _, mapping_entry in pairs(LOCATION_MAPPING) do
        for _, location_table in ipairs(mapping_entry) do
            if location_table then
                local location_code = location_table[1]
                if location_code then
                    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                        print(string.format("onClear: clearing location %s", location_code))
                    end
                    if location_code:sub(1, 1) == "@" then
                        local obj = Tracker:FindObjectForCode(location_code)
                        if obj then
                            obj.AvailableChestCount = obj.ChestCount
                            if obj.Highlight then
                                obj.Highlight = Highlight.None
                            end
                        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                            print(string.format("onClear: could not find location object for code %s", location_code))
                        end
                    else
                        -- reset hosted item
                        local item_type = location_table[2]
                        resetItem(location_code, item_type)
                    end
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: skipping location_table with no location_code"))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: skipping empty location_table"))
            end
        end
    end
    -- reset items
    for _, mapping_entry in pairs(ITEM_MAPPING) do
        for _, item_table in ipairs(mapping_entry) do
            if item_table then
                local item_code = item_table[1]
                local item_type = item_table[2]
                if item_code then
                    resetItem(item_code, item_type)
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: skipping item_table with no item_code"))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: skipping empty item_table"))
            end
        end
    end
    -- Get and subscribe to changes in the player's status to track goal completion
    goal_status_key = string.format(GOAL_STATUS_FORMAT, Archipelago.TeamNumber, Archipelago.PlayerNumber)
    Archipelago:Get({goal_status_key})
    Archipelago:SetNotify({goal_status_key})
    apply_slot_data(slot_data)
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    -- manually run snes interface functions after onClear in case we need to update them (i.e. because they need slot_data)
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here
    end
    -- setup data storage tracking for hint tracking
    local data_strorage_keys = {}
    if PopVersion >= "0.32.0" then
        data_strorage_keys = {getHintDataStorageKey()}
    end
    -- subscribes to the data storage keys for updates
    -- triggers callback in the SetNotify handler on update
    Archipelago:SetNotify(data_strorage_keys)
    -- gets the current value for the data storage keys
    -- triggers callback in the Retrieved handler when result is received
    Archipelago:Get(data_strorage_keys)
    Tracker.BulkUpdate = false
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
        return
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index
    local mapping_entry = ITEM_MAPPING[item_id]
    if not mapping_entry then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    for _, item_table in pairs(mapping_entry) do
        if item_table then
            local item_code = item_table[1]
            local item_type = item_table[2]
            local multiplier = item_table[3] or 1
            if item_code then
                incrementItem(item_code, item_type, multiplier)
                -- keep track which items we touch are local and which are global
                if is_local then
                    if LOCAL_ITEMS[item_code] then
                        LOCAL_ITEMS[item_code] = LOCAL_ITEMS[item_code] + 1
                    else
                        LOCAL_ITEMS[item_code] = 1
                    end
                else
                    if GLOBAL_ITEMS[item_code] then
                        GLOBAL_ITEMS[item_code] = GLOBAL_ITEMS[item_code] + 1
                    else
                        GLOBAL_ITEMS[item_code] = 1
                    end
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: skipping item_table with no item_code"))
            end
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onClear: skipping empty item_table"))
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    -- track local items via snes interface
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions for local item tracking here
    end
end

-- called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return
    end
    local mapping_entry = LOCATION_MAPPING[location_id]
    if not mapping_entry then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find location mapping for id %s", location_id))
        end
        return
    end
    for _, location_table in pairs(mapping_entry) do
        if location_table then
            local location_code = location_table[1]
            if location_code then
                local obj = Tracker:FindObjectForCode(location_code)
                if obj then
                    if location_code:sub(1, 1) == "@" then
                        obj.AvailableChestCount = obj.AvailableChestCount - 1
                    else
                        -- increment hosted item
                        local item_type = location_table[2]
                        incrementItem(location_code, item_type)
                    end
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onLocation: could not find object for code %s", location_code))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onLocation: skipping location_table with no location_code"))
            end
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: skipping empty location_table"))
        end
    end
end

-- called when a locations is scouted
function onScout(location_id, location_name, item_id, item_name, item_player)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onScout: %s, %s, %s, %s, %s", location_id, location_name, item_id, item_name,
            item_player))
    end
    -- not implemented yet :(
end

_last_activated_tab = ""
function onMap(stage_name)
    if not stage_name then
        return
    end
    local map_switch_setting = Tracker:FindObjectForCode("setting_map_tracking")
    if map_switch_setting and map_switch_setting.Active then
        local tab_info = STAGE_NAME_TO_TAB_NAME[stage_name]
        if tab_info then
            local tab_name, tab2_name = table.unpack(tab_info)
            local full_tab_path = tab2_name and (tab_name .. "/" .. tab2_name) or tab_name
            if full_tab_path ~= _last_activated_tab then
                Tracker:UiHint("ActivateTab", tab_name)
                if tab2_name then
                    Tracker:UiHint("ActivateTab", tab2_name)
                end
                _last_activated_tab = full_tab_path
            end
        end
    end

end

-- called when a bounce message is received
function onBounce(json)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onBounce: %s", dump_table(json)))
    end
    local slots = json["slots"]
    -- Lua does not support `slots ~= {Archipelago.PlayerNumber}`, so check the first and second values in the table.
    if not slots or not (slots[1] == Archipelago.PlayerNumber and slots[2] == nil) then
        -- All Bounced messages to be processed by this tracker are expected to target the player's slot specifically.
        return
    end

    local data = json["data"]
    if not data then
        return
    end
    -- The key is specified in the AP client.
    onMap(data["pokepark_stage_name"])
end

-- called whenever Archipelago:Get returns data from the data storage or
-- whenever a subscribed to (via Archipelago:SetNotify) key in data storgae is updated
-- oldValue might be nil (always nil for "_read" prefixed keys and via retrieved handler (from Archipelago:Get))
function onDataStorageUpdate(key, value, oldValue)
    -- if you plan to only use the hints key, you can remove this if
    if key == getHintDataStorageKey() then
        onHintsUpdate(value)
    end
end

-- called whenever the hints key in data storage updated
-- NOTE: this should correctly handle having multiple mapped locations in a section.
--       if you only map sections 1 to 1 you can simplfy this. for an example see
--       https://github.com/Cyb3RGER/sm_ap_tracker/blob/main/scripts/autotracking/archipelago.lua
function onHintsUpdate(hints)
    -- Highlight is only supported since version 0.32.0
    if PopVersion < "0.32.0" or not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return
    end
    local player_number = Archipelago.PlayerNumber
    -- get all new highlight values per section
    local sections_to_update = {}
    for _, hint in ipairs(hints) do
        -- we only care about hints in our world
        if hint.finding_player == player_number then
            updateHint(hint, sections_to_update)
        end
    end
    -- update the sections
    for location_code, highlight_code in pairs(sections_to_update) do
        -- find the location object
        local obj = Tracker:FindObjectForCode(location_code)
        -- check if we got the location and if it supports Highlight
        if obj and obj.Highlight then
            obj.Highlight = highlight_code
        end
    end
end

-- update section highlight based on the hint
function updateHint(hint, sections_to_update)
    -- get the highlight enum value for the hint status
    local hint_status = hint.status
    local highlight_code = nil
    if hint_status then
        highlight_code = HINT_STATUS_MAPPING[hint_status]
    end
    if not highlight_code then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("updateHint: unknown hint status %s for hint on location id %s", hint.status,
                hint.location))
        end
        -- try to "recover" by checking hint.found (older AP versions without hint.status)
        if hint.found == true then
            highlight_code = Highlight.None
        elseif hint.found == false then
            highlight_code = Highlight.Unspecified
        else
            return
        end
    end
    -- get the location mapping for the location id
    local mapping_entry = LOCATION_MAPPING[hint.location]
    if not mapping_entry then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("updateHint: could not find location mapping for id %s", hint.location))
        end
        return
    end
    -- get the "highest" highlight value pre section
    for _, location_table in pairs(mapping_entry) do
        if location_table then
            local location_code = location_table[1]
            -- skip hosted items, they don't support Highlight
            if location_code and location_code:sub(1, 1) == "@" then
                -- see if we already set a Highlight for this section
                local existing_highlight_code = sections_to_update[location_code]
                if existing_highlight_code then
                    -- make sure we only replace None or "increase" the highlight but never overwrite with None
                    -- this so sections with mulitple mapped locations show the "highest" Highlight and
                    -- only show no Highlight when all hints are found
                    if existing_highlight_code == Highlight.None or
                        (existing_highlight_code < highlight_code and highlight_code ~= Highlight.None) then
                        sections_to_update[location_code] = highlight_code
                    end
                else
                    sections_to_update[location_code] = highlight_code
                end
            end
        end
    end
end

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    Archipelago:AddItemHandler("item handler", onItem)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    Archipelago:AddLocationHandler("location handler", onLocation)
end
Archipelago:AddRetrievedHandler("retrieved handler", onDataStorageUpdate)
Archipelago:AddSetReplyHandler("set reply handler", onDataStorageUpdate)
-- Archipelago:AddScoutHandler("scout handler", onScout)
Archipelago:AddBouncedHandler("bounce handler", onBounce)
