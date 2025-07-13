-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_ITEMS_ONLY = variant:find("itemsonly")

print("-- Example Tracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")

-- Items
Tracker:AddItems("items/items.jsonc")

-- Maps
Tracker:AddMaps("maps/maps.jsonc")

-- Locations
Tracker:AddLocations("locations/overworld/treehouse.jsonc")
Tracker:AddLocations("locations/overworld/meadow_zone.jsonc")
Tracker:AddLocations("locations/entrances/meadow_zone.jsonc")
Tracker:AddLocations("locations/overworld/beach_zone.jsonc")
Tracker:AddLocations("locations/entrances/beach_zone.jsonc")
Tracker:AddLocations("locations/overworld/ice_zone.jsonc")
Tracker:AddLocations("locations/entrances/ice_zone.jsonc")
Tracker:AddLocations("locations/overworld/cavern_zone.jsonc")
Tracker:AddLocations("locations/entrances/cavern_zone.jsonc")
Tracker:AddLocations("locations/overworld/magma_zone.jsonc")
Tracker:AddLocations("locations/entrances/magma_zone.jsonc")
Tracker:AddLocations("locations/overworld/haunted_zone.jsonc")
Tracker:AddLocations("locations/entrances/haunted_zone.jsonc")
Tracker:AddLocations("locations/overworld/granite_zone.jsonc")
Tracker:AddLocations("locations/entrances/granite_zone.jsonc")
Tracker:AddLocations("locations/overworld/flower_zone.jsonc")
Tracker:AddLocations("locations/entrances/flower_zone.jsonc")
Tracker:AddLocations("locations/overworld/skygarden.jsonc")
Tracker:AddLocations("locations/entrances/skygarden.jsonc")
-- Layout
Tracker:AddLayouts("layouts/tracker.jsonc")

Tracker:AddLayouts("layouts/layouts_maps.jsonc")
Tracker:AddLayouts("layouts/item_grid.jsonc")
Tracker:AddLayouts("layouts/powers.jsonc")
Tracker:AddLayouts("layouts/prismas.jsonc")
Tracker:AddLayouts("layouts/friendships.jsonc")
Tracker:AddLayouts("layouts/unlocks.jsonc")
Tracker:AddLayouts("layouts/broadcast.jsonc")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
