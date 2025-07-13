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
	if type(item) == "boolean" then return item end
	return Tracker:ProviderCountForCode(item) >= 1
end

function hasAll(items)
	for _, item in ipairs(items) do
		if type(item) == "table" then
			if not hasAny(item) then return false end
		elseif not has(item) then
			return false
		end
	end
	return true
end

function hasAny(items)
	for _, item in ipairs(items) do
		if type(item) == "table" then
			if hasAny(item) then return true end
		elseif has(item) then return true end
	end
	return false
end

function hasWorldStateIceZoneOrHigher()
	return hasAny({ "ice_zone_unlock", "cavern_and_magma_zone_unlock", "haunted_zone_unlock", "granite_and_flower_zone_unlock", "skygarden_unlock" })
end

function hasWorldStateCavernMagmaZoneOrHigher()	
    return hasAny({ "cavern_and_magma_zone_unlock", "haunted_zone_unlock", "granite_and_flower_zone_unlock", "skygarden_unlock" })
end

function hasWorldStateHauntedZoneOrHigher()    
    return hasAny({"haunted_zone_unlock", "granite_and_flower_zone_unlock", "skygarden_unlock" })
end

function canFarmBerries()
    return has("dash_beginner")
end

function canPlayCatch()
    return hasAny({"dash_beginner"})
end
function canPlayCatchIntermediate()
    return hasAny({"dash_intermediate"})
end
function canBattle()
    return hasAny({"thunderbolt_beginner", "dash_beginner", "iron_tail_beginner"})
end

function canBattleThunderBoltImmune()
    return hasAny({"dash_beginner", "iron_tail_beginner"})
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


local pokemon_friendship_items = {
    "chatot", "chikorita", "turtwig", "torterra", "buneary", "munchlax", "treecko", "mankey", 
    "bidoof", "bibarel", "oddish", "aipom", "ambipom", "leafeon", "spearow", "croagunk", 
    "starly", "bonsly", "sudowoodo", "pachirisu", "lotad", "shinx", "scyther", "magikarp", 
    "caterpie", "butterfree", "weedle", "shroomish", "tropius", "bulbasaur", "venusaur", 
    "piplup", "slowpoke", "azurill", "corsola", "wynaut", "carvanha", "sharpedo", "wailord", 
    "totodile", "feraligatr", "lapras", "psyduck", "golduck", "buizel", "floatzel", "vaporeon", 
    "mudkip", "taillow", "staravia", "pidgeotto", "krabby", "corphish", "blastoise", "wingull", 
    "pelipper", "gyarados", "glalie", "froslass", "piloswine", "mamoswine", "teddiursa", 
    "ursaring", "kirlia", "spheal", "quagsire", "glaceon", "octillery", "delibird", "primeape", 
    "squirtle", "smoochum", "sneasel", "prinplup", "empoleon", "mr_mime", "mawile", "aron", 
    "gible", "marowak", "zubat", "golbat", "diglett", "dugtrio", "snorlax", "geodude", 
    "machamp", "meowth", "scizor", "cranidos", "phanpy", "raichu", "magnemite", "magnezone", 
    "hitmonlee", "electivire", "bastiodon", "charmander", "hitmontop", "hitmonchan", "camerupt", 
    "chimchar", "infernape", "vulpix", "ninetales", "farfetchd", "meditite", "magby", 
    "magmortar", "flareon", "magcargo", "torkoal", "golem", "quilava", "baltoy", "claydol", 
    "ponyta", "rhyperior", "torchic", "blaziken", "murkrow", "honchkrow", "gliscor", "drifloon", 
    "kakuna", "metapod", "tangrowth", "riolu", "sableye", "spinarak", "breloom", "pichu", 
    "misdreavus", "mismagius", "elekid", "electabuzz", "luxray", "stunky", "skuntank", "voltorb", 
    "electrode", "umbreon", "espeon", "gastly", "haunter", "gengar", "duskull", "dusknoir", 
    "charizard", "flygon", "porygonz", "bronzor", "togekiss", "arcanine", "lopunny", "furret", 
    "staraptor", "skorupi", "eevee", "hoppip", "jumpluff", "aerodactyl", "jolteon", "tyranitar", 
    "garchomp", "absol", "salamence", "bellossom", "budew", "skiploom", "cyndaquil", "mareep", 
    "dragonite", "lucario", "rayquaza", "drifblim", "burmy", "mimejr", "abra", "mew", "jirachi", 
    "manaphy", "latias", "suicune", "metagross", "heatran", "groudon", "celebi", "darkrai", 
    "rotom", "shaymin", "latios", "deoxys"
}

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
local dash_pokemon_items = {
    "turtwig", "munchlax", "chimchar", "treecko", "bibarel", "bulbasaur", 
    "bidoof", "oddish", "shroomish", "bonsly", "lotad", "weedle", 
    "caterpie", "magikarp", "jolteon", "arcanine", "leafeon", "scyther", 
    "ponyta", "shinx", "eevee", "pachirisu", "buneary", "croagunk", "mew"
}
function canBeatAnyBulbasaurMinigame()
    return hasAny(dash_pokemon_items)
end

local vine_swing_pokemon_items = {
    "munchlax", "magikarp", "blaziken", "infernape", "lucario", "primeape", 
    "tangrowth", "ambipom", "croagunk", "mankey", "aipom", "chimchar", 
    "treecko", "pachirisu"
}

function canBeatAnyVenusaurMinigame()
    return hasAny(vine_swing_pokemon_items) or has("jirachi")
end

function canBeatAllVenusaurMinigame()
    return hasAll(vine_swing_pokemon_items)
end

local aqua_pokemon_items = {
    "surfboard","psyduck", "azurill", "slowpoke", "empoleon", "floatzel", "feraligatr", 
    "golduck", "vaporeon", "prinplup", "bibarel", "buizel", "corsola", 
    "piplup", "lotad"
}

function canBeatAnyGyaradosMinigame()
    return hasAny(aqua_pokemon_items) or has("manaphy")
end

function canBeatAllGyaradosMinigame()
    return hasAll(aqua_pokemon_items)
end

local circle_pokemon_items = {
    "balloon","staraptor", "togekiss", "honchkrow", "gliscor", "pelipper", "staravia", 
    "pidgeotto", "butterfree", "tropius", "murkrow", "taillow", "spearow", 
    "starly", "wingull"
}

function canBeatAnyPelipperMinigame()
    return hasAny(circle_pokemon_items) or has("latias")
end

function canBeatAllPelipperMinigame()
    return hasAll(circle_pokemon_items)
end

local slide_pokemon_items = {
    "snowboard","teddiursa", "magikarp", "empoleon", "glaceon", "blastoise", "glalie", 
    "lapras", "delibird", "piloswine", "prinplup", "squirtle", "piplup", 
    "quagsire", "spheal"
}

function canBeatAnyEmpoleonMinigame()
    return hasAny(slide_pokemon_items) or has("suicune")
end

function canBeatAllEmpoleonMinigame()
    return hasAll(slide_pokemon_items)
end

local panel_pokemon_items = {
    "sableye", "meowth", "torchic", "electivire", "magmortar", "hitmonlee", 
    "ursaring", "mr_mime", "raichu", "sudowoodo", "charmander", "gible", 
    "chimchar", "magby"
}

function canBeatAnyBastiodonMinigame()
    return hasAny(panel_pokemon_items) or has("metagross")
end

function canBeatAllBastiodonMinigame()
    return hasAll(panel_pokemon_items)
end

local bumper_pokemon_items = {
    "magnemite", "rhyperior", "tyranitar", "hitmontop", "flareon", "venusaur", 
    "snorlax", "torterra", "magnezone", "claydol", "quilava", "torkoal", 
    "baltoy", "bonsly"
}

function canBeatAnyRhyperiorMinigame()
    return hasAny(bumper_pokemon_items) or has ("heatran")
end

function canBeatAllRhyperiorMinigame()
    return hasAll(bumper_pokemon_items)
end

local boulder_pokemon_items = {
    "geodude", "phanpy", "blaziken", "garchomp", "scizor", "magmortar", 
    "hitmonchan", "machamp", "marowak", "farfetchd", "cranidos", "camerupt", 
    "bastiodon", "mawile"
}

function canBeatAnyBlazikenMinigame()
    return hasAny(boulder_pokemon_items) or has("groudon")
end

function canBeatAllBlazikenMinigame()
    return hasAll(boulder_pokemon_items)
end

local swing_pokemon_items = {
    "meowth", "pichu", "lucario", "infernape", "blaziken", "riolu", 
    "sneasel", "raichu", "ambipom", "primeape", "aipom", "electabuzz", 
    "chimchar", "croagunk"
}

function canBeatAnyTangrowthMinigame()
    return hasAny(swing_pokemon_items) or has("celebi")
end

function canBeatAllTangrowthMinigame()
    return hasAll(swing_pokemon_items)
end


local slam_pokemon_items = {
    "stunky", "gengar", "mismagius", "scizor", "espeon", "dusknoir", 
    "umbreon", "cranidos", "skuntank", "electrode", "gastly", "duskull", 
    "misdreavus", "krabby"
}

function canBeatAnyDusknoirMinigame()
    return hasAny(slam_pokemon_items) or has("darkrai")
end

function canBeatAllDusknoirMinigame()
    return hasAll(slam_pokemon_items)
end

local shoot_pokemon_items = {
    "magnemite", "porygonz", "magnezone", "gengar", "magmortar", "electivire", 
    "mismagius", "claydol", "electabuzz", "haunter", "abra", "elekid", 
    "mr_mime", "baltoy"
}

function canBeatAnyRotomMinigame()
    return hasAny(shoot_pokemon_items) or has("rotom")
end

function canBeatAllRotomMinigame()
    return hasAll(shoot_pokemon_items)
end

local hurdle_pokemon_items = {
    "chikorita", "absol", "lucario", "ponyta", "ninetales", "lopunny", 
    "espeon", "infernape", "breloom", "riolu", "furret", "mareep", 
    "eevee", "vulpix"
}
function canBeatAnyAbsolMinigame()
    return hasAny(hurdle_pokemon_items) or has("shaymin")
end

function canBeatAllAbsolMinigame()
    return hasAll(hurdle_pokemon_items)
end

local sky_pokemon_items = {
    "balloon","salamence", "charizard", "dragonite", "flygon", "aerodactyl", "staraptor", 
    "honchkrow", "gliscor", "pidgeotto", "togekiss", "golbat", "taillow", 
    "murkrow", "zubat"
}

function canBeatAnySalamenceMinigame()
    return hasAny(sky_pokemon_items) or has("latios")
end

function canBeatAllSalamenceMinigame()
    return hasAll(sky_pokemon_items)
end

local balloon_pokemon_items = {
    "lucario", "glaceon", "luxray", "mamoswine", "infernape", "floatzel", 
    "rhyperior", "absol", "breloom", "mareep", "cyndaquil", "totodile", 
    "chikorita", "mimejr"
}

function canBeatAnyRayquazaMinigame()
    return hasAny(sky_pokemon_items) or has("deoxys")
end

function canBeatAllRayquazaMinigame()
    return hasAll(sky_pokemon_items)
end