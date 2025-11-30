-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
function has_more_then_n_consumable(n)
    local count = Tracker:ProviderCountForCode('consumable')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called has_more_then_n_consumable: count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function has(item)
    if type(item) == "boolean" then
        return item
    end
    return Tracker:ProviderCountForCode(item) >= 1
end

local prisma_items = {"bulbasaur_prisma_activated", "venusaur_prisma_activated", "pelipper_prisma_activated",
                      "gyarados_prisma_activated", "bastiodon_prisma_activated", "empoleon_prisma_activated",
                      "rhyperior_prisma_activated", "blaziken_prisma_activated", "tangrowth_prisma_activated",
                      "dusknoir_prisma_activated", "rotom_prisma_activated", "absol_prisma_activated",
                      "salamence_prisma_activated", "rayquaza_prisma_activated"}

function battle_locations_activated()
    return Tracker:ProviderCountForCode("remove_battle_power_comp_locations") == 0
end

function chase_locations_activated()
    return Tracker:ProviderCountForCode("remove_chase_power_comp_locations") == 0
end

function quiz_locations_activated()
    return Tracker:ProviderCountForCode("remove_quiz_power_comp_locations") == 0
end

function hide_and_seek_locations_activated()
    return Tracker:ProviderCountForCode("remove_hide_and_seek_power_comp_locations") == 0
end

function errand_locations_activated()
    return Tracker:ProviderCountForCode("remove_errand_power_comp_locations") == 0
end

function misc_locations_activated()
    return Tracker:ProviderCountForCode("remove_misc_power_comp_locations") == 0
end

function legendary_locations_activated()
    return Tracker:ProviderCountForCode("remove_legendary_pokemon_power_comp_locations") == 0
end

function power_training_locations_activated()
    return Tracker:ProviderCountForCode("remove_power_training_locations") == 0
end

function attraction_locations_activated()
    return Tracker:ProviderCountForCode("remove_attraction_locations") == 0
end

function attraction_prisma_locations_activated()
    return Tracker:ProviderCountForCode("remove_attraction_prisma_locations") == 0
end

function unlock_locations_activated()
    return Tracker:ProviderCountForCode("remove_pokemon_unlock_locations") == 0
end

function postgame_locations_activated()
    return Tracker:ProviderCountForCode("postgame_locations_activated") == 1
end

function mew_power_comp_locations_activated()
    return Tracker:ProviderCountForCode("mew_power_comp_locations_activated") == 1
end

function has_required_prismas()
    local required_count = Tracker:ProviderCountForCode('required_prismas')
    local count = 0
    for _, prisma_code in ipairs(prisma_items) do
        if Tracker:ProviderCountForCode(prisma_code) > 0 then
            count = count + 1
            if count >= required_count then
                return true
            end
        end
    end
    return false
end

function hasAll(items)
    for _, item in ipairs(items) do
        if type(item) == "table" then
            if not hasAny(item) then
                return false
            end
        elseif not has(item) then
            return false
        end
    end
    return true
end

function hasAny(items)
    for _, item in ipairs(items) do
        if type(item) == "table" then
            if hasAny(item) then
                return true
            end
        elseif has(item) then
            return true
        end
    end
    return false
end

function isHarderEnemyAI()
    return has("harder_enemy_ai")
end

function canFarmBerries()
    return has("dash_beginner")
end

function canReachBeachZoneRecycleArea()
    return canReachBeachZone() and has("beach_zone_bridge2_unlock")
end

function canFarmBerriesIntermediate()
    return canReachBeachZoneRecycleArea()
end

function canFarmBerriesAdvanced()
    return canReachMagmaZone() and has("golem_unlock")
end

function canPlayCatch()
    if isHarderEnemyAI() then
        return has("dash_intermediate")
    end
    return has("dash_beginner")
end

function canPlayCatchIntermediate()
    if isHarderEnemyAI() then
        return has("dash_advanced")
    end
    return has("dash_intermediate")
end

function canPlayCatchAdvanced()
    if isHarderEnemyAI() then
        return has("dash_mastered")
    end
    return has("dash_advanced")
end

function maximizedDash()
    return has("dash_mastered")
end

function canBattle()
    if isHarderEnemyAI() then
        return hasAny({"thunderbolt_beginner", "iron_tail_beginner"}) and has("health_beginner")
    end
    return hasAny({"thunderbolt_beginner", "iron_tail_beginner"})
end

function canBattleIntermediate()
    if isHarderEnemyAI() then
        return hasAny({"thunderbolt_intermediate", "iron_tail_advanced"}) and has("health_advanced")
    end
    return hasAny({"thunderbolt_beginner", "iron_tail_beginner"}) and has("health_advanced")
end

function canBattleAdvanced()
    if isHarderEnemyAI() then
        return hasAny({"thunderbolt_advanced", "iron_tail_mastered"}) and has("health_mastered")
    end
    return hasAny({"thunderbolt_intermediate", "iron_tail_advanced"}) and has("health_mastered")
end

function canBattleThunderBoltImmune()
    if isHarderEnemyAI() then
        return hasAny({"dash_intermediate", "iron_tail_beginner"}) and has("health_beginner")
    end
    return hasAny({"dash_beginner", "iron_tail_beginner"}) and has("health_beginner")
end

function canBattleThunderBoltImmuneIntermediate()
    if isHarderEnemyAI() then
        return hasAny({"dash_advanced", "iron_tail_advanced"}) and has("health_advanced")
    end
    return hasAny({"dash_intermediate", "iron_tail_beginner"}) and has("health_advanced")
end

function canBattleThunderBoltImmuneAdvanced()
    if isHarderEnemyAI() then
        return hasAny({"dash_mastered", "iron_tail_mastered"}) and has("health_mastered")
    end
    return hasAny({"dash_advanced", "iron_tail_advanced"}) and has("health_mastered")
end

function canDashOverworld()
    return has("dash_beginner")
end

function canThunderBoltOverworld()
    return has("thunderbolt_beginner")
end

function canDestroyObjectsOverworld()
    return hasAny({"dash_beginner", "thunderbolt_beginner"})
end

local pokemon_friendship_items = {"chatot", "chikorita", "turtwig", "torterra", "buneary", "munchlax", "treecko",
                                  "mankey", "bidoof", "bibarel", "oddish", "aipom", "ambipom", "leafeon", "spearow",
                                  "croagunk", "starly", "bonsly", "sudowoodo", "pachirisu", "lotad", "shinx", "scyther",
                                  "magikarp", "caterpie", "butterfree", "weedle", "shroomish", "tropius", "bulbasaur",
                                  "venusaur", "piplup", "slowpoke", "azurill", "corsola", "wynaut", "carvanha",
                                  "sharpedo", "wailord", "totodile", "feraligatr", "lapras", "psyduck", "golduck",
                                  "buizel", "floatzel", "vaporeon", "mudkip", "taillow", "staravia", "pidgeotto",
                                  "krabby", "corphish", "blastoise", "wingull", "pelipper", "gyarados", "glalie",
                                  "froslass", "piloswine", "mamoswine", "teddiursa", "ursaring", "kirlia", "spheal",
                                  "quagsire", "glaceon", "octillery", "delibird", "primeape", "squirtle", "smoochum",
                                  "sneasel", "prinplup", "empoleon", "mr_mime", "mawile", "aron", "gible", "marowak",
                                  "zubat", "golbat", "diglett", "dugtrio", "snorlax", "geodude", "machamp", "meowth",
                                  "scizor", "cranidos", "phanpy", "raichu", "magnemite", "magnezone", "hitmonlee",
                                  "electivire", "bastiodon", "charmander", "hitmontop", "hitmonchan", "camerupt",
                                  "chimchar", "infernape", "vulpix", "ninetales", "farfetchd", "meditite", "magby",
                                  "magmortar", "flareon", "magcargo", "torkoal", "golem", "quilava", "baltoy",
                                  "claydol", "ponyta", "rhyperior", "torchic", "blaziken", "murkrow", "honchkrow",
                                  "gliscor", "drifloon", "kakuna", "metapod", "tangrowth", "riolu", "sableye",
                                  "spinarak", "breloom", "pichu", "misdreavus", "mismagius", "elekid", "electabuzz",
                                  "luxray", "stunky", "skuntank", "voltorb", "electrode", "umbreon", "espeon", "gastly",
                                  "haunter", "gengar", "duskull", "dusknoir", "charizard", "flygon", "porygonz",
                                  "bronzor", "togekiss", "arcanine", "lopunny", "furret", "staraptor", "skorupi",
                                  "eevee", "hoppip", "jumpluff", "aerodactyl", "jolteon", "tyranitar", "garchomp",
                                  "absol", "salamence", "bellossom", "budew", "skiploom", "cyndaquil", "mareep",
                                  "dragonite", "lucario", "rayquaza", "drifblim", "burmy", "mimejr", "abra", "mew",
                                  "jirachi", "manaphy", "latias", "suicune", "metagross", "heatran", "groudon",
                                  "celebi", "darkrai", "rotom", "shaymin", "latios", "deoxys"}

function hasEnoughPokemonFriendships(required_amount)
    local count = 0
    for _, pokemon_code in ipairs(pokemon_friendship_items) do
        if Tracker:ProviderCountForCode(pokemon_code) > 0 then
            count = count + 1
            if count >= required_amount then
                return true
            end
        end
    end
    return false
end

function hasEnoughFriendshipJolteon()
    return hasEnoughPokemonFriendships(90)
end

function hasEnoughFriendshipLeafeon()
    return hasEnoughPokemonFriendships(20)
end

function hasEnoughFriendshipVaporeon()
    return hasEnoughPokemonFriendships(30)
end

function hasEnoughFriendshipGlaceon()
    return hasEnoughPokemonFriendships(50)
end
function hasEnoughFriendshipUmbreon()
    return hasEnoughPokemonFriendships(75)
end

function hasEnoughFriendshipGengar()
    return hasEnoughPokemonFriendships(85)
end

function hasEnoughFriendshipLucario()
    return hasEnoughPokemonFriendships(100)
end

function canAccessBastiodonMinigame()
    return hasEnoughPokemonFriendships(50)
end

function canAccessSalamenceMinigame()
    return hasEnoughPokemonFriendships(80)
end

function canAccessRotomMinigame()
    return hasEnoughPokemonFriendships(65)
end

function canCompletePrismaFull()
    return hasEnoughPokemonFriendships(193)
end
function canCompletePrismaStage1()
    return hasEnoughPokemonFriendships(100)
end
function canCompletePrismaStage2()
    return hasEnoughPokemonFriendships(150)
end
local dash_pokemon_items = {"turtwig", "munchlax", "chimchar", "treecko", "bibarel", "bulbasaur", "bidoof", "oddish",
                            "shroomish", "bonsly", "lotad", "weedle", "caterpie", "magikarp", "jolteon", "arcanine",
                            "leafeon", "scyther", "ponyta", "shinx", "eevee", "pachirisu", "buneary", "croagunk", "mew"}
function canBeatAnyBulbasaurMinigame()
    return hasAny(dash_pokemon_items)
end

local vine_swing_pokemon_items = {"munchlax", "magikarp", "blaziken", "infernape", "lucario", "primeape", "tangrowth",
                                  "ambipom", "croagunk", "mankey", "aipom", "chimchar", "treecko", "pachirisu"}

function canBeatAnyVenusaurMinigame()
    return hasAny(vine_swing_pokemon_items) or has("jirachi")
end

function canBeatAllVenusaurMinigame()
    return hasAll(vine_swing_pokemon_items)
end

local aqua_pokemon_items = {"surfboard", "psyduck", "azurill", "slowpoke", "empoleon", "floatzel", "feraligatr",
                            "golduck", "vaporeon", "prinplup", "bibarel", "buizel", "corsola", "piplup", "lotad"}

function canBeatAnyGyaradosMinigame()
    return hasAny(aqua_pokemon_items) or has("manaphy")
end

function canBeatAllGyaradosMinigame()
    return hasAll(aqua_pokemon_items)
end

local circle_pokemon_items = {"balloon", "staraptor", "togekiss", "honchkrow", "gliscor", "pelipper", "staravia",
                              "pidgeotto", "butterfree", "tropius", "murkrow", "taillow", "spearow", "starly", "wingull"}

function canBeatAnyPelipperMinigame()
    return hasAny(circle_pokemon_items) or has("latias")
end

function canBeatAllPelipperMinigame()
    return hasAll(circle_pokemon_items)
end

local slide_pokemon_items = {"snowboard", "teddiursa", "magikarp", "empoleon", "glaceon", "blastoise", "glalie",
                             "lapras", "delibird", "piloswine", "prinplup", "squirtle", "piplup", "quagsire", "spheal"}

function canBeatAnyEmpoleonMinigame()
    return hasAny(slide_pokemon_items) or has("suicune")
end

function canBeatAllEmpoleonMinigame()
    return hasAll(slide_pokemon_items)
end

local panel_pokemon_items = {"sableye", "meowth", "torchic", "electivire", "magmortar", "hitmonlee", "ursaring",
                             "mr_mime", "raichu", "sudowoodo", "charmander", "gible", "chimchar", "magby"}

function canBeatAnyBastiodonMinigame()
    return hasAny(panel_pokemon_items) or has("metagross")
end

function canBeatAllBastiodonMinigame()
    return hasAll(panel_pokemon_items)
end

local bumper_pokemon_items = {"magnemite", "rhyperior", "tyranitar", "hitmontop", "flareon", "venusaur", "snorlax",
                              "torterra", "magnezone", "claydol", "quilava", "torkoal", "baltoy", "bonsly"}

function canBeatAnyRhyperiorMinigame()
    return hasAny(bumper_pokemon_items) or has("heatran")
end

function canBeatAllRhyperiorMinigame()
    return hasAll(bumper_pokemon_items)
end

local boulder_pokemon_items = {"geodude", "phanpy", "blaziken", "garchomp", "scizor", "magmortar", "hitmonchan",
                               "machamp", "marowak", "farfetchd", "cranidos", "camerupt", "bastiodon", "mawile"}

function canBeatAnyBlazikenMinigame()
    return hasAny(boulder_pokemon_items) or has("groudon")
end

function canBeatAllBlazikenMinigame()
    return hasAll(boulder_pokemon_items)
end

local swing_pokemon_items = {"meowth", "pichu", "lucario", "infernape", "blaziken", "riolu", "sneasel", "raichu",
                             "ambipom", "primeape", "aipom", "electabuzz", "chimchar", "croagunk"}

function canBeatAnyTangrowthMinigame()
    return hasAny(swing_pokemon_items) or has("celebi")
end

function canBeatAllTangrowthMinigame()
    return hasAll(swing_pokemon_items)
end

local slam_pokemon_items = {"stunky", "gengar", "mismagius", "scizor", "espeon", "dusknoir", "umbreon", "cranidos",
                            "skuntank", "electrode", "gastly", "duskull", "misdreavus", "krabby"}

function canBeatAnyDusknoirMinigame()
    return hasAny(slam_pokemon_items) or has("darkrai")
end

function canBeatAllDusknoirMinigame()
    return hasAll(slam_pokemon_items)
end

local shoot_pokemon_items = {"magnemite", "porygonz", "magnezone", "gengar", "magmortar", "electivire", "mismagius",
                             "claydol", "electabuzz", "haunter", "abra", "elekid", "mr_mime", "baltoy"}

function canBeatAnyRotomMinigame()
    return hasAny(shoot_pokemon_items) or has("rotom")
end

function canBeatAllRotomMinigame()
    return hasAll(shoot_pokemon_items)
end

local hurdle_pokemon_items = {"chikorita", "absol", "lucario", "ponyta", "ninetales", "lopunny", "espeon", "infernape",
                              "breloom", "riolu", "furret", "mareep", "eevee", "vulpix"}
function canBeatAnyAbsolMinigame()
    return hasAny(hurdle_pokemon_items) or has("shaymin")
end

function canBeatAllAbsolMinigame()
    return hasAll(hurdle_pokemon_items)
end

local sky_pokemon_items = {"balloon", "salamence", "charizard", "dragonite", "flygon", "aerodactyl", "staraptor",
                           "honchkrow", "gliscor", "pidgeotto", "togekiss", "golbat", "taillow", "murkrow", "zubat"}

function canBeatAnySalamenceMinigame()
    return hasAny(sky_pokemon_items) or has("latios")
end

function canBeatAllSalamenceMinigame()
    return hasAll(sky_pokemon_items)
end

local balloon_pokemon_items = {"lucario", "glaceon", "luxray", "mamoswine", "infernape", "floatzel", "rhyperior",
                               "absol", "breloom", "mareep", "cyndaquil", "totodile", "chikorita", "mimejr"}

function canBeatAnyRayquazaMinigame()
    return hasAny(sky_pokemon_items) or has("deoxys")
end

function canBeatAllRayquazaMinigame()
    return hasAll(sky_pokemon_items)
end

function canReachBeachZoneFromIceZone()
    return has("gyarados_prisma_activated") and hasAny({"ice_zone_fast_travel"})
end

function canReachBeachZoneFromTreehouse()
    return hasAny({"venusaur_prisma_activated", "beach_zone_fast_travel"})
end
function canReachBeachZone()
    return canReachBeachZoneFromTreehouse() or canReachBeachZoneFromIceZone()
end

function canReachCavernZoneFromMagmaZone()
    return has("magma_zone_fast_travel")
end

function canReachCavernZoneFromTreehouse()
    return hasAny({"empoleon_prisma_activated", "cavern_zone_fast_travel"})
end

function canReachCavernZone()
    return canReachCavernZoneFromMagmaZone() or canReachCavernZoneFromTreehouse()
end

function canReachIceZoneFromBeachZone()
    return has("gyarados_prisma_activated") and canReachBeachZone()
end

function canReachIceZoneFromTreehouse()
    return has("ice_zone_fast_travel")
end

function canReachIceZone()
    return canReachIceZoneFromTreehouse() or canReachIceZoneFromBeachZone()
end

function canReachMagmaZoneFromCavernZone()
    return has("bastiodon_prisma_activated") and canReachCavernZone()
end

function canReachMagmaZoneFromTreehouse()
    return has("magma_zone_fast_travel")
end

function canReachMagmaZone()
    return canReachMagmaZoneFromTreehouse() or canReachMagmaZoneFromCavernZone()
end

function canReachHauntedZone()
    return hasAny({"haunted_zone_fast_travel", "blaziken_prisma_activated"})
end

function canReachHauntedZoneMansion()
    return has("tangrowth_prisma_activated")
end

function canReachHauntedZoneMansionRooms()
    return has("haunted_zone_mansion_doors_unlock")
end

function canReachFlowerZoneFromTreehouse()
    return has("flower_zone_fast_travel")
end
function canReachFlowerZoneFromGraniteZone()
    return canReachGraniteZoneFromTreehouse()
end
function canReachFlowerZone()
    return canReachFlowerZoneFromGraniteZone() or canReachFlowerZoneFromTreehouse()
end

function canReachGraniteZoneFromTreehouse()
    return hasAny({"granite_zone_fast_travel", "rotom_prisma_activated"})
end

function canReachGraniteZoneFromFlowerZone()
    return canReachFlowerZoneFromTreehouse()
end

function canReachGraniteZone()
    return canReachGraniteZoneFromTreehouse() or canReachGraniteZoneFromFlowerZone()
end

local fast_travel_items = {"meadow_zone_fast_travel", "beach_zone_fast_travel", "ice_zone_fast_travel",
                           "cavern_zone_fast_travel", "magma_zone_fast_travel", "haunted_zone_fast_travel",
                           "granite_zone_fast_travel", "flower_zone_fast_travel"}

function hasOneFastTravelItem()
    return hasAny(fast_travel_items)
end

function canClearChristmasStage1()
    return hasAll({"delibird_unlock", "spheal"})
end

function canClearChristmasStage2()
    return canClearChristmasStage1() and has("teddiursa")
end

function canClearChristmasStage3()
    return canClearChristmasStage2() and hasAll({"squirtle", "squirtle_unlock"})
end

function canClearChristmasStage4()
    return canClearChristmasStage3() and hasAll({"smoochum", "smoochum_unlock"})
end

function canBefriendDelibird()
    if errand_locations_activated() then
        return canClearChristmasStage4()
    end
    return has("delibird_unlock")
end
function StateChanged()
    updateFriendshipItemCount()
    updatePrismaItemCount()
end

function updateFriendshipItemCount()
    local count = 0
    for _, friendship_code in ipairs(pokemon_friendship_items) do
        if Tracker:ProviderCountForCode(friendship_code) > 0 then
            count = count + 1
        end
    end
    friendship_count = Tracker:FindObjectForCode("friendship_count")
    friendship_count.AcquiredCount = count
    friendship_count.MinCount = count
    friendship_count.MaxCount = count
end

function updatePrismaItemCount()
    local count = 0
    for _, prisma_code in ipairs(prisma_items) do
        if Tracker:ProviderCountForCode(prisma_code) > 0 then
            count = count + 1
        end
    end
    prisma_count = Tracker:FindObjectForCode("prisma_count")
    prisma_count.AcquiredCount = count
    prisma_count.MinCount = count
    prisma_count.MaxCount = count
end

