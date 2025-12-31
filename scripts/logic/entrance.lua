-- naming convention [LocationWhereExitIs]_[ExitType(e.g. Gate)]_Exit → @[LocationWhereEntranceIs]_[EntranceType(e.g. Gate)]_Entrance
-- entrance location needs always parent
local Entrances = {}

Entrances.vanilla_exit_to_entrance = {
    -- Pokepark Entrance leading
    ["PokeparkEntrance_MeadowGate_Exit"] = "@MeadowZoneMain_PokeparkGate_Entrance",

    -- Meadow Zone Main Area leading
    ["MeadowZoneMain_TreehouseGate_Exit"] = "@TreehouseMeadow_MeadowConnection_Entrance",
    ["MeadowZoneMain_PokeparkGate_Exit"] = "@PokeparkEntrance_MeadowGate_Entrance",
    ["MeadowZoneMain_VenusaurGate_Exit"] = "@MeadowZoneVenusaur_MainGate_Entrance",
    ["MeadowZoneMain_BulbasaurAttraction_Exit"] = "@BulbasaurAttraction_Bulbasaur_Entrance",
    -- Meadow Zone Fast Travel
    ["MeadowZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_MeadowDrifblim_Entrance",
    ["MeadowZoneMain_BeachDrifblim_Exit"] = "@BeachZoneMain_MeadowDrifblim_Entrance",
    ["MeadowZoneMain_IceDrifblim_Exit"] = "@IceZoneMain_MeadowDrifblim_Entrance",
    ["MeadowZoneMain_CavernDrifblim_Exit"] = "@CavernZoneMain_MeadowDrifblim_Entrance",
    ["MeadowZoneMain_MagmaDrifblim_Exit"] = "@MagmaZoneMain_MeadowDrifblim_Entrance",
    ["MeadowZoneMain_HauntedDrifblim_Exit"] = "@HauntedZoneMain_MeadowDrifblim_Entrance",
    ["MeadowZoneMain_GraniteDrifblim_Exit"] = "@GraniteZoneMain_MeadowDrifblim_Entrance",
    ["MeadowZoneMain_FlowerDrifblim_Exit"] = "@FlowerZoneMain_MeadowDrifblim_Entrance",

    -- Meadow Zone Venusaur Area Exits
    ["MeadowZoneVenusaur_MainGate_Exit"] = "@MeadowZoneMain_VenusaurGate_Entrance",
    ["MeadowZoneVenusaur_VenusaurAttraction_Exit"] = "@VenusaurAttraction_Venusaur_Entrance",

    -- Meadow Zone Attractions Exits
    ["BulbasaurAttraction_Bulbasaur_Exit"] = "@MeadowZoneMain_BulbasaurAttraction_Entrance",
    ["VenusaurAttraction_Venusaur_Exit"] = "@MeadowZoneVenusaur_VenusaurAttraction_Entrance",

    -- Treehouse leading
    ["TreehouseMeadow_MeadowConnection_Exit"] = "@MeadowZoneMain_TreehouseGate_Entrance",
    ["Treehouse_MeadowGate_Exit"] = "@TreehouseMeadow_MeadowGate_Entrance",
    ["TreehouseMeadow_MeadowGate_Exit"] = "@Treehouse_MeadowGate_Entrance",

    ["TreehouseBeach_BeachConnection_Exit"] = "@BeachZoneMain_TreehouseGate_Entrance",
    ["Treehouse_BeachGate_Exit"] = "@TreehouseBeach_BeachGate_Entrance",
    ["TreehouseBeach_BeachGate_Exit"] = "@Treehouse_BeachGate_Entrance",

    ["TreehouseCavern_CavernConnection_Exit"] = "@CavernZoneMain_TreehouseGate_Entrance",
    ["Treehouse_CavernGate_Exit"] = "@TreehouseCavern_CavernGate_Entrance",
    ["TreehouseCavern_CavernGate_Exit"] = "@Treehouse_CavernGate_Entrance",

    ["TreehouseHaunted_HauntedConnection_Exit"] = "@HauntedZoneMain_TreehouseGate_Entrance",
    ["Treehouse_HauntedGate_Exit"] = "@TreehouseHaunted_HauntedGate_Entrance",
    ["TreehouseHaunted_HauntedGate_Exit"] = "@Treehouse_HauntedGate_Entrance",

    ["TreehouseGranite_GraniteConnection_Exit"] = "@GraniteZoneMain_TreehouseGate_Entrance",
    ["Treehouse_GraniteGate_Exit"] = "@TreehouseGranite_GraniteGate_Entrance",
    ["TreehouseGranite_GraniteGate_Exit"] = "@Treehouse_GraniteGate_Entrance",

    ["Treehouse_MeadowDrifblim_Exit"] = "@MeadowZoneMain_TreehouseDrifblim_Entrance",
    ["Treehouse_BeachDrifblim_Exit"] = "@BeachZoneMain_TreehouseDrifblim_Entrance",
    ["Treehouse_IceDrifblim_Exit"] = "@IceZoneMain_TreehouseDrifblim_Entrance",
    ["Treehouse_CavernDrifblim_Exit"] = "@CavernZoneMain_TreehouseDrifblim_Entrance",
    ["Treehouse_MagmaDrifblim_Exit"] = "@MagmaZoneMain_TreehouseDrifblim_Entrance",
    ["Treehouse_HauntedDrifblim_Exit"] = "@HauntedZoneMain_TreehouseDrifblim_Entrance",
    ["Treehouse_GraniteDrifblim_Exit"] = "@GraniteZoneMain_TreehouseDrifblim_Entrance",
    ["Treehouse_FlowerDrifblim_Exit"] = "@FlowerZoneMain_TreehouseDrifblim_Entrance",

    -- Beach Zone Exits
    -- Treehouse Entrances
    ["BeachZoneMain_TreehouseGate_Exit"] = "@TreehouseBeach_BeachConnection_Entrance",

    -- Beach Zone Fast Travel Exits
    ["BeachZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_BeachDrifblim_Entrance",
    ["BeachZoneMain_MeadowDrifblim_Exit"] = "@MeadowZoneMain_BeachDrifblim_Entrance",
    ["BeachZoneMain_IceDrifblim_Exit"] = "@IceZoneMain_BeachDrifblim_Entrance",
    ["BeachZoneMain_CavernDrifblim_Exit"] = "@CavernZoneMain_BeachDrifblim_Entrance",
    ["BeachZoneMain_MagmaDrifblim_Exit"] = "@MagmaZoneMain_BeachDrifblim_Entrance",
    ["BeachZoneMain_HauntedDrifblim_Exit"] = "@HauntedZoneMain_BeachDrifblim_Entrance",
    ["BeachZoneMain_GraniteDrifblim_Exit"] = "@GraniteZoneMain_BeachDrifblim_Entrance",
    ["BeachZoneMain_FlowerDrifblim_Exit"] = "@FlowerZoneMain_BeachDrifblim_Entrance",

    -- Ice Zone Entrances
    ["BeachZoneLapras_BeachZoneLapras_Exit"] = "@IceZoneMain_IceLapras_Entrance",

    -- Inner Beach Zone Main Entrances
    ["BeachZoneMain_LaprasRock_Exit"] = "@BeachZoneLapras_MainRock_Entrance",
    ["BeachZoneLapras_MainRock_Exit"] = "@BeachZoneMain_LaprasRock_Entrance",

    ["BeachZoneMain_RecycleBridge_Exit"] = "@BeachZoneRecycle_MainBridge_Entrance",
    ["BeachZoneRecycle_MainBridge_Exit"] = "@BeachZoneMain_RecycleBridge_Entrance",

    ["BeachZoneMain_MiddleBridge_Exit"] = "@BeachZoneMiddle_MainBridge_Entrance",
    ["BeachZoneMiddle_MainBridge_Exit"] = "@BeachZoneMain_MiddleBridge_Entrance",

    -- Beach Zone attractions
    ["BeachZoneMain_PelipperAttraction_Exit"] = "@PelipperAttraction_Pelipper_Entrance",
    ["PelipperAttraction_Pelipper_Exit"] = "@BeachZoneMain_PelipperAttraction_Entrance",

    ["BeachZoneRecycle_GyaradosAttraction_Exit"] = "@GyaradosAttraction_Gyarados_Entrance",
    ["GyaradosAttraction_Gyarados_Exit"] = "@BeachZoneRecycle_GyaradosAttraction_Entrance",

    -- Ice Zone Exits
    ["IceZoneMain_IceLapras_Exit"] = "@BeachZoneLapras_BeachZoneLapras_Entrance",

    ["IceZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_IceDrifblim_Entrance",
    ["IceZoneMain_MeadowDrifblim_Exit"] = "@MeadowZoneMain_IceDrifblim_Entrance",
    ["IceZoneMain_BeachDrifblim_Exit"] = "@BeachZoneMain_IceDrifblim_Entrance",
    ["IceZoneMain_CavernDrifblim_Exit"] = "@CavernZoneMain_IceDrifblim_Entrance",
    ["IceZoneMain_MagmaDrifblim_Exit"] = "@MagmaZoneMain_IceDrifblim_Entrance",
    ["IceZoneMain_HauntedDrifblim_Exit"] = "@HauntedZoneMain_IceDrifblim_Entrance",
    ["IceZoneMain_GraniteDrifblim_Exit"] = "@GraniteZoneMain_IceDrifblim_Entrance",
    ["IceZoneMain_FlowerDrifblim_Exit"] = "@FlowerZoneMain_IceDrifblim_Entrance",

    -- Inner
    ["IceZoneMain_UpperLift_Exit"] = "@IceZoneLower_LowerLift_Entrance",
    ["IceZoneLower_LowerLift_Exit"] = "@IceZoneMain_UpperLift_Entrance",

    ["IceZoneMain_FrozenLake_Exit"] = "@IceZoneLake_MainLake_Entrance",
    ["IceZoneLake_MainLake_Exit"] = "@IceZoneMain_FrozenLake_Entrance",

    -- Empoleon Area
    ["IceZoneMain_EmpoleonGate_Exit"] = "@IceZoneEmpoleon_MainGate_Entrance",
    ["IceZoneEmpoleon_MainGate_Exit"] = "@IceZoneMain_EmpoleonGate_Entrance",

    -- Ice Zone attractions
    ["IceZoneEmpoleon_EmpoleonAttraction_Exit"] = "@EmpoleonAttraction_Empoleon_Entrance",
    ["EmpoleonAttraction_Empoleon_Exit"] = "@IceZoneEmpoleon_EmpoleonAttraction_Entrance",

    -- Cavern Zone
    ["CavernZoneMain_TreehouseGate_Exit"] = "@TreehouseCavern_CavernConnection_Entrance",
    ["CavernZoneMain_MagmaTruck_Exit"] = "@MagmaZoneMain_CavernTruck_Entrance",

    ["CavernZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_CavernDrifblim_Entrance",
    ["CavernZoneMain_MeadowDrifblim_Exit"] = "@MeadowZoneMain_CavernDrifblim_Entrance",
    ["CavernZoneMain_BeachDrifblim_Exit"] = "@BeachZoneMain_CavernDrifblim_Entrance",
    ["CavernZoneMain_IceDrifblim_Exit"] = "@IceZoneMain_CavernDrifblim_Entrance",
    ["CavernZoneMain_MagmaDrifblim_Exit"] = "@MagmaZoneMain_CavernDrifblim_Entrance",
    ["CavernZoneMain_HauntedDrifblim_Exit"] = "@HauntedZoneMain_CavernDrifblim_Entrance",
    ["CavernZoneMain_GraniteDrifblim_Exit"] = "@GraniteZoneMain_CavernDrifblim_Entrance",
    ["CavernZoneMain_FlowerDrifblim_Exit"] = "@FlowerZoneMain_CavernDrifblim_Entrance",

    -- Cavern Zone Attractions
    ["CavernZoneMain_BastiodonAttraction_Exit"] = "@BastiodonAttraction_Bastiodon_Entrance",
    ["BastiodonAttraction_Bastiodon_Exit"] = "@CavernZoneMain_BastiodonAttraction_Entrance",

    -- Magma Zone 
    ["MagmaZoneMain_CavernTruck_Exit"] = "@CavernZoneMain_MagmaTruck_Entrance",

    ["MagmaZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_MagmaDrifblim_Entrance",
    ["MagmaZoneMain_MeadowDrifblim_Exit"] = "@MeadowZoneMain_MagmaDrifblim_Entrance",
    ["MagmaZoneMain_BeachDrifblim_Exit"] = "@BeachZoneMain_MagmaDrifblim_Entrance",
    ["MagmaZoneMain_IceDrifblim_Exit"] = "@IceZoneMain_MagmaDrifblim_Entrance",
    ["MagmaZoneMain_CavernDrifblim_Exit"] = "@CavernZoneMain_MagmaDrifblim_Entrance",
    ["MagmaZoneMain_HauntedDrifblim_Exit"] = "@HauntedZoneMain_MagmaDrifblim_Entrance",
    ["MagmaZoneMain_GraniteDrifblim_Exit"] = "@GraniteZoneMain_MagmaDrifblim_Entrance",
    ["MagmaZoneMain_FlowerDrifblim_Exit"] = "@FlowerZoneMain_MagmaDrifblim_Entrance",

    -- Magma Zone Inner Entrances
    ["MagmaZoneMain_CircleFireWall_Exit"] = "@MagmaZoneCircle_MainFireWall_Entrance",
    ["MagmaZoneCircle_MainFireWall_Exit"] = "@MagmaZoneMain_CircleFireWall_Entrance",

    ["MagmaZoneMagcargo_BlazikenGate_Exit"] = "@MagmaZoneBlaziken_MainGate_Entrance",
    ["MagmaZoneBlaziken_MainGate_Exit"] = "@MagmaZoneMagcargo_BlazikenGate_Entrance",
    ["MagmaZoneCircle_BlazikenBridge_Exit"] = "@MagmaZoneMagcargo_BlazikenBridge_Entrance",
    ["MagmaZoneMagcargo_BlazikenBridge_Exit"] = "@MagmaZoneCircle_BlazikenBridge_Entrance",

    -- Magma Zone Attractions
    ["MagmaZoneCircle_RhyperiorAttraction_Exit"] = "@RhyperiorAttraction_Rhyperior_Entrance",
    ["RhyperiorAttraction_Rhyperior_Exit"] = "@MagmaZoneCircle_RhyperiorAttraction_Entrance",

    ["MagmaZoneBlaziken_BlazikenAttraction_Exit"] = "@BlazikenAttraction_Blaziken_Entrance",
    ["BlazikenAttraction_Blaziken_Exit"] = "@MagmaZoneBlaziken_BlazikenAttraction_Entrance",

    -- Haunted Zone
    ["HauntedZoneMain_TreehouseGate_Exit"] = "@TreehouseHaunted_HauntedConnection_Entrance",

    -- Haunted Zone Fast Travel
    ["HauntedZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_HauntedDrifblim_Entrance",
    ["HauntedZoneMain_MeadowDrifblim_Exit"] = "@MeadowZoneMain_HauntedDrifblim_Entrance",
    ["HauntedZoneMain_BeachDrifblim_Exit"] = "@BeachZoneMain_HauntedDrifblim_Entrance",
    ["HauntedZoneMain_IceDrifblim_Exit"] = "@IceZoneMain_HauntedDrifblim_Entrance",
    ["HauntedZoneMain_CavernDrifblim_Exit"] = "@CavernZoneMain_HauntedDrifblim_Entrance",
    ["HauntedZoneMain_MagmaDrifblim_Exit"] = "@MagmaZoneMain_HauntedDrifblim_Entrance",
    ["HauntedZoneMain_GraniteDrifblim_Exit"] = "@GraniteZoneMain_HauntedDrifblim_Entrance",
    ["HauntedZoneMain_FlowerDrifblim_Exit"] = "@FlowerZoneMain_HauntedDrifblim_Entrance",

    -- Haunted Zone Attractions
    ["HauntedZoneMain_TangrowthAttraction_Exit"] = "@TangrowthAttraction_Tangrowth_Entrance",
    ["TangrowthAttraction_Tangrowth_Exit"] = "@HauntedZoneMain_TangrowthAttraction_Entrance",

    ["HauntedZoneMansion_DusknoirAttraction_Exit"] = "@DusknoirAttraction_Dusknoir_Entrance",
    ["DusknoirAttraction_Dusknoir_Exit"] = "@HauntedZoneMansion_DusknoirAttraction_Entrance",

    ["HauntedZoneRotom_RotomAttraction_Exit"] = "@RotomAttraction_Rotom_Entrance",
    ["RotomAttraction_Rotom_Exit"] = "@HauntedZoneRotom_RotomAttraction_Entrance",

    -- Haunted Zone Mansion
    ["HauntedZoneMansion_MainGate_Exit"] = "@HauntedZoneMain_MansionGate_Entrance",
    ["HauntedZoneMain_MansionGate_Exit"] = "@HauntedZoneMansion_MainGate_Entrance",

    -- Inner Haunted Mansion Area
    ["HauntedZoneBallroom_WhiteGemDoor_Exit"] = "@HauntedZoneMansion_WhiteGemDoor_Entrance",
    ["HauntedZoneMansion_WhiteGemDoor_Exit"] = "@HauntedZoneBallroom_WhiteGemDoor_Entrance",

    ["HauntedZoneStudy_RedGemDoor_Exit"] = "@HauntedZoneMansion_RedGemDoor_Entrance",
    ["HauntedZoneMansion_RedGemDoor_Exit"] = "@HauntedZoneStudy_RedGemDoor_Entrance",

    ["HauntedZoneGengar_BlueGemDoor_Exit"] = "@HauntedZoneMansion_BlueGemDoor_Entrance",
    ["HauntedZoneMansion_BlueGemDoor_Exit"] = "@HauntedZoneGengar_BlueGemDoor_Entrance",

    ["HauntedZoneAntic_GreenGemDoor_Exit"] = "@HauntedZoneMansion_GreenGemDoor_Entrance",
    ["HauntedZoneMansion_GreenGemDoor_Exit"] = "@HauntedZoneAntic_GreenGemDoor_Entrance",

    -- Rotom Area connection
    ["HauntedZoneSecret_Bookshelf_Exit"] = "@HauntedZoneStudy_Bookshelf_Entrance",
    ["HauntedZoneRotom_SecretConnection_Exit"] = "@HauntedZoneSecret_RotomConnection_Entrance",
    ["HauntedZoneSecret_RotomConnection_Exit"] = "@HauntedZoneRotom_SecretConnection_Entrance",
    ["HauntedZoneStudy_Bookshelf_Exit"] = "@HauntedZoneSecret_Bookshelf_Entrance",

    -- Granite Zone
    ["GraniteZoneMain_TreehouseGate_Exit"] = "@TreehouseGranite_GraniteConnection_Entrance",
    ["GraniteZoneMain_FlowerGate_Exit"] = "@FlowerZoneMain_GraniteGate_Entrance",

    -- Fast Travel
    ["GraniteZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_GraniteDrifblim_Entrance",
    ["GraniteZoneMain_MeadowDrifblim_Exit"] = "@MeadowZoneMain_GraniteDrifblim_Entrance",
    ["GraniteZoneMain_BeachDrifblim_Exit"] = "@BeachZoneMain_GraniteDrifblim_Entrance",
    ["GraniteZoneMain_IceDrifblim_Exit"] = "@IceZoneMain_GraniteDrifblim_Entrance",
    ["GraniteZoneMain_CavernDrifblim_Exit"] = "@CavernZoneMain_GraniteDrifblim_Entrance",
    ["GraniteZoneMain_MagmaDrifblim_Exit"] = "@MagmaZoneMain_GraniteDrifblim_Entrance",
    ["GraniteZoneMain_HauntedDrifblim_Exit"] = "@HauntedZoneMain_GraniteDrifblim_Entrance",
    ["GraniteZoneMain_FlowerDrifblim_Exit"] = "@FlowerZoneMain_GraniteDrifblim_Entrance",

    -- Granite Zone Attractions
    ["GraniteZoneMain_AbsolAttraction_Exit"] = "@AbsolAttraction_Absol_Entrance",
    ["AbsolAttraction_Absol_Exit"] = "@GraniteZoneMain_AbsolAttraction_Entrance",

    ["GraniteZoneMain_SalamenceAttraction_Exit"] = "@SalamenceAttraction_Salamence_Entrance",
    ["SalamenceAttraction_Salamence_Exit"] = "@GraniteZoneMain_SalamenceAttraction_Entrance",

    -- Flower Zone
    ["FlowerZoneMain_GraniteGate_Exit"] = "@GraniteZoneMain_FlowerGate_Entrance",

    -- Fast Travel
    ["FlowerZoneMain_TreehouseDrifblim_Exit"] = "@Treehouse_FlowerDrifblim_Entrance",
    ["FlowerZoneMain_MeadowDrifblim_Exit"] = "@MeadowZoneMain_FlowerDrifblim_Entrance",
    ["FlowerZoneMain_BeachDrifblim_Exit"] = "@BeachZoneMain_FlowerDrifblim_Entrance",
    ["FlowerZoneMain_IceDrifblim_Exit"] = "@IceZoneMain_FlowerDrifblim_Entrance",
    ["FlowerZoneMain_CavernDrifblim_Exit"] = "@CavernZoneMain_FlowerDrifblim_Entrance",
    ["FlowerZoneMain_MagmaDrifblim_Exit"] = "@MagmaZoneMain_FlowerDrifblim_Entrance",
    ["FlowerZoneMain_HauntedDrifblim_Exit"] = "@HauntedZoneMain_FlowerDrifblim_Entrance",
    ["FlowerZoneMain_GraniteDrifblim_Exit"] = "@GraniteZoneMain_FlowerDrifblim_Entrance",

    -- Flower Zone Attractions
    ["FlowerZoneMain_RayquazaAttraction_Exit"] = "@RayquazaAttraction_Rayquaza_Entrance",
    ["RayquazaAttraction_Rayquaza_Exit"] = "@FlowerZoneMain_RayquazaAttraction_Entrance",

    -- Skygarden
    ["Skygarden_PiplupBalloon_Exit"] = "@Treehouse_PiplupBalloon_Entrance",
    ["Treehouse_PiplupBalloon_Exit"] = "@Skygarden_PiplupBalloon_Entrance"

}

Entrances.exit_to_entrance = Entrances.vanilla_exit_to_entrance

Entrances.slot_data_exit_to_entrance = {}

Entrances.slot_data_name_to_local = {
    -- Pokepark Entrance
    ["Pokepark Entrance - Meadow Zone Gate"] = "PokeparkEntrance_MeadowGate",
    ["Meadow Zone Main Area - Pokepark Entrance Gate"] = "MeadowZoneMain_PokeparkGate",

    -- Meadow Zone Main Area
    ["Meadow Zone Main Area - Treehouse Connection"] = "MeadowZoneMain_TreehouseGate",
    ["Meadow Zone Main Area - Venusaur Gate"] = "MeadowZoneMain_VenusaurGate",

    -- Meadow Zone Fast Travel
    ["Meadow Zone Main Area - Treehouse Drifblim Fast Travel"] = "MeadowZoneMain_TreehouseDrifblim",
    ["Meadow Zone Main Area - Beach Drifblim Fast Travel"] = "MeadowZoneMain_BeachDrifblim",
    ["Meadow Zone Main Area - Ice Drifblim Fast Travel"] = "MeadowZoneMain_IceDrifblim",
    ["Meadow Zone Main Area - Cavern Drifblim Fast Travel"] = "MeadowZoneMain_CavernDrifblim",
    ["Meadow Zone Main Area - Magma Drifblim Fast Travel"] = "MeadowZoneMain_MagmaDrifblim",
    ["Meadow Zone Main Area - Haunted Drifblim Fast Travel"] = "MeadowZoneMain_HauntedDrifblim",
    ["Meadow Zone Main Area - Granite Drifblim Fast Travel"] = "MeadowZoneMain_GraniteDrifblim",
    ["Meadow Zone Main Area - Flower Drifblim Fast Travel"] = "MeadowZoneMain_FlowerDrifblim",

    -- Meadow Zone Venusaur Area
    ["Meadow Zone Venusaur Area - Meadow Zone Main Gate"] = "MeadowZoneVenusaur_MainGate",

    -- Meadow Zone Attractions
    ["Meadow Zone Venusaur Area - Venusaur Attraction"] = "MeadowZoneVenusaur_VenusaurAttraction",
    ["Venusaur's Vine Swing Attraction - Attraction Menu"] = "VenusaurAttraction_Venusaur",
    ["Meadow Zone Main Area - Bulbasaur Attraction"] = "MeadowZoneMain_BulbasaurAttraction",
    ["Bulbasaur's Daring Dash Attraction - Attraction Menu"] = "BulbasaurAttraction_Bulbasaur",

    -- Treehouse Meadow Passage
    ["Treehouse Meadow Passage - Meadow Zone Connection"] = "TreehouseMeadow_MeadowConnection",
    ["Treehouse - Meadow Zone Gate"] = "Treehouse_MeadowGate",
    ["Treehouse Meadow Passage - Meadow Zone Gate"] = "TreehouseMeadow_MeadowGate",

    -- Treehouse Beach Passage
    ["Treehouse Beach Passage - Beach Zone Connection"] = "TreehouseBeach_BeachConnection",
    ["Treehouse - Beach Zone Gate"] = "Treehouse_BeachGate",
    ["Treehouse Beach Passage - Beach Zone Gate"] = "TreehouseBeach_BeachGate",

    -- Treehouse Cavern Passage
    ["Treehouse Cavern Passage - Cavern Zone Connection"] = "TreehouseCavern_CavernConnection",
    ["Treehouse - Cavern Zone Gate"] = "Treehouse_CavernGate",
    ["Treehouse Cavern Passage - Cavern Zone Gate"] = "TreehouseCavern_CavernGate",

    -- Treehouse Haunted Passage
    ["Treehouse Haunted Passage - Haunted Zone Connection"] = "TreehouseHaunted_HauntedConnection",
    ["Treehouse - Haunted Zone Gate"] = "Treehouse_HauntedGate",
    ["Treehouse Haunted Passage - Haunted Zone Gate"] = "TreehouseHaunted_HauntedGate",

    -- Treehouse Granite Passage
    ["Treehouse Granite Passage - Granite Zone Connection"] = "TreehouseGranite_GraniteConnection",
    ["Treehouse - Granite Zone Gate"] = "Treehouse_GraniteGate",
    ["Treehouse Granite Passage - Granite Zone Gate"] = "TreehouseGranite_GraniteGate",

    -- Treehouse Fast Travel
    ["Treehouse - Meadow Drifblim Fast Travel"] = "Treehouse_MeadowDrifblim",
    ["Treehouse - Beach Drifblim Fast Travel"] = "Treehouse_BeachDrifblim",
    ["Treehouse - Ice Drifblim Fast Travel"] = "Treehouse_IceDrifblim",
    ["Treehouse - Cavern Drifblim Fast Travel"] = "Treehouse_CavernDrifblim",
    ["Treehouse - Magma Drifblim Fast Travel"] = "Treehouse_MagmaDrifblim",
    ["Treehouse - Haunted Drifblim Fast Travel"] = "Treehouse_HauntedDrifblim",
    ["Treehouse - Granite Drifblim Fast Travel"] = "Treehouse_GraniteDrifblim",
    ["Treehouse - Flower Drifblim Fast Travel"] = "Treehouse_FlowerDrifblim",

    -- Beach Zone Main Area
    ["Beach Zone Main Area - Treehouse Connection"] = "BeachZoneMain_TreehouseGate",

    -- Beach Zone Fast Travel
    ["Beach Zone Main Area - Treehouse Drifblim Fast Travel"] = "BeachZoneMain_TreehouseDrifblim",
    ["Beach Zone Main Area - Meadow Drifblim Fast Travel"] = "BeachZoneMain_MeadowDrifblim",
    ["Beach Zone Main Area - Ice Drifblim Fast Travel"] = "BeachZoneMain_IceDrifblim",
    ["Beach Zone Main Area - Cavern Drifblim Fast Travel"] = "BeachZoneMain_CavernDrifblim",
    ["Beach Zone Main Area - Magma Drifblim Fast Travel"] = "BeachZoneMain_MagmaDrifblim",
    ["Beach Zone Main Area - Haunted Drifblim Fast Travel"] = "BeachZoneMain_HauntedDrifblim",
    ["Beach Zone Main Area - Granite Drifblim Fast Travel"] = "BeachZoneMain_GraniteDrifblim",
    ["Beach Zone Main Area - Flower Drifblim Fast Travel"] = "BeachZoneMain_FlowerDrifblim",

    -- Beach Zone Lapras Area
    ["Beach Zone Lapras Area - Beach Zone Lapras"] = "BeachZoneLapras_BeachZoneLapras",

    -- Beach Zone Inner Areas
    ["Beach Zone Main Area - Lapras Area Rock"] = "BeachZoneMain_LaprasRock",
    ["Beach Zone Lapras Area - Main Area Rock"] = "BeachZoneLapras_MainRock",
    ["Beach Zone Main Area - Recycle Bridge"] = "BeachZoneMain_RecycleBridge",
    ["Beach Zone Recycle Area - Main Bridge"] = "BeachZoneRecycle_MainBridge",
    ["Beach Zone Main Area - Middle Bridge"] = "BeachZoneMain_MiddleBridge",
    ["Beach Zone Middle Isle - Main Bridge"] = "BeachZoneMiddle_MainBridge",

    -- Beach Zone Attractions
    ["Beach Zone Main Area - Pelipper Attraction"] = "BeachZoneMain_PelipperAttraction",
    ["Pelipper's Circle Circuit Attraction - Attraction Menu"] = "PelipperAttraction_Pelipper",

    ["Beach Zone Recycle Area - Gyarados Attraction"] = "BeachZoneRecycle_GyaradosAttraction",
    ["Gyarados' Aqua Dash Attraction - Attraction Menu"] = "GyaradosAttraction_Gyarados",

    -- Ice Zone Main Area
    ["Ice Zone Main Area - Ice Zone Lapras"] = "IceZoneMain_IceLapras",

    -- Ice Zone Fast Travel
    ["Ice Zone Main Area - Treehouse Drifblim Fast Travel"] = "IceZoneMain_TreehouseDrifblim",
    ["Ice Zone Main Area - Meadow Drifblim Fast Travel"] = "IceZoneMain_MeadowDrifblim",
    ["Ice Zone Main Area - Beach Drifblim Fast Travel"] = "IceZoneMain_BeachDrifblim",
    ["Ice Zone Main Area - Cavern Drifblim Fast Travel"] = "IceZoneMain_CavernDrifblim",
    ["Ice Zone Main Area - Magma Drifblim Fast Travel"] = "IceZoneMain_MagmaDrifblim",
    ["Ice Zone Main Area - Haunted Drifblim Fast Travel"] = "IceZoneMain_HauntedDrifblim",
    ["Ice Zone Main Area - Granite Drifblim Fast Travel"] = "IceZoneMain_GraniteDrifblim",
    ["Ice Zone Main Area - Flower Drifblim Fast Travel"] = "IceZoneMain_FlowerDrifblim",

    -- Ice Zone Inner Areas
    ["Ice Zone Main Area - Upper Lift"] = "IceZoneMain_UpperLift",
    ["Ice Zone Lower Lift Area - Lower Lift"] = "IceZoneLower_LowerLift",
    ["Ice Zone Main Area - Frozen Lake"] = "IceZoneMain_FrozenLake",
    ["Ice Zone Frozen Lake Area - Frozen Lake"] = "IceZoneLake_MainLake",

    -- Ice Zone Empoleon Area
    ["Ice Zone Main Area - Empoleon Gate"] = "IceZoneMain_EmpoleonGate",
    ["Ice Zone Empoleon Area - Ice Zone Main Gate"] = "IceZoneEmpoleon_MainGate",

    -- Ice Zone Attractions
    ["Ice Zone Empoleon Area - Empoleon Attraction"] = "IceZoneEmpoleon_EmpoleonAttraction",
    ["Empoleon's Snow Slide Attraction - Attraction Menu"] = "EmpoleonAttraction_Empoleon",

    -- Cavern Zone Main Area
    ["Cavern Zone Main Area - Treehouse Connection"] = "CavernZoneMain_TreehouseGate",
    ["Cavern Zone Main Area - Magma Zone Truck"] = "CavernZoneMain_MagmaTruck",

    -- Cavern Zone Fast Travel
    ["Cavern Zone Main Area - Treehouse Drifblim Fast Travel"] = "CavernZoneMain_TreehouseDrifblim",
    ["Cavern Zone Main Area - Meadow Drifblim Fast Travel"] = "CavernZoneMain_MeadowDrifblim",
    ["Cavern Zone Main Area - Beach Drifblim Fast Travel"] = "CavernZoneMain_BeachDrifblim",
    ["Cavern Zone Main Area - Ice Drifblim Fast Travel"] = "CavernZoneMain_IceDrifblim",
    ["Cavern Zone Main Area - Magma Drifblim Fast Travel"] = "CavernZoneMain_MagmaDrifblim",
    ["Cavern Zone Main Area - Haunted Drifblim Fast Travel"] = "CavernZoneMain_HauntedDrifblim",
    ["Cavern Zone Main Area - Granite Drifblim Fast Travel"] = "CavernZoneMain_GraniteDrifblim",
    ["Cavern Zone Main Area - Flower Drifblim Fast Travel"] = "CavernZoneMain_FlowerDrifblim",

    -- Cavern Zone Attractions
    ["Cavern Zone Main Area - Bastiodon Attraction"] = "CavernZoneMain_BastiodonAttraction",
    ["Bastiodon's Panel Crush Attraction - Attraction Menu"] = "BastiodonAttraction_Bastiodon",

    -- Magma Zone Main Area
    ["Magma Zone Main Area - Cavern Zone Truck"] = "MagmaZoneMain_CavernTruck",

    -- Magma Zone Fast Travel
    ["Magma Zone Main Area - Treehouse Drifblim Fast Travel"] = "MagmaZoneMain_TreehouseDrifblim",
    ["Magma Zone Main Area - Meadow Drifblim Fast Travel"] = "MagmaZoneMain_MeadowDrifblim",
    ["Magma Zone Main Area - Beach Drifblim Fast Travel"] = "MagmaZoneMain_BeachDrifblim",
    ["Magma Zone Main Area - Ice Drifblim Fast Travel"] = "MagmaZoneMain_IceDrifblim",
    ["Magma Zone Main Area - Cavern Drifblim Fast Travel"] = "MagmaZoneMain_CavernDrifblim",
    ["Magma Zone Main Area - Haunted Drifblim Fast Travel"] = "MagmaZoneMain_HauntedDrifblim",
    ["Magma Zone Main Area - Granite Drifblim Fast Travel"] = "MagmaZoneMain_GraniteDrifblim",
    ["Magma Zone Main Area - Flower Drifblim Fast Travel"] = "MagmaZoneMain_FlowerDrifblim",

    -- Magma Zone Inner Areas
    ["Magma Zone Main Area - Circle Area Fire Wall"] = "MagmaZoneMain_CircleFireWall",
    ["Magma Zone Circle Area - Main Area Fire Wall"] = "MagmaZoneCircle_MainFireWall",
    ["Magma Zone Magcargo Area - Blaziken Gate"] = "MagmaZoneMagcargo_BlazikenGate",
    ["Magma Zone Blaziken Area - Main Area Gate"] = "MagmaZoneBlaziken_MainGate",
    ["Magma Zone Circle Area - Magcargo Area Bridge"] = "MagmaZoneCircle_BlazikenBridge",
    ["Magma Zone Magcargo Area - Main Area Bridge"] = "MagmaZoneMagcargo_BlazikenBridge",

    -- Magma Zone Attractions
    ["Magma Zone Circle Area - Rhyperior Attraction"] = "MagmaZoneCircle_RhyperiorAttraction",
    ["Rhyperior's Bumper Burn Attraction - Attraction Menu"] = "RhyperiorAttraction_Rhyperior",
    ["Magma Zone Blaziken Area - Blaziken Attraction"] = "MagmaZoneBlaziken_BlazikenAttraction",
    ["Blaziken's Boulder Bash Attraction - Attraction Menu"] = "BlazikenAttraction_Blaziken",

    -- Haunted Zone Main Area
    ["Haunted Zone Main Area - Treehouse Connection"] = "HauntedZoneMain_TreehouseGate",

    -- Haunted Zone Fast Travel
    ["Haunted Zone Main Area - Treehouse Drifblim Fast Travel"] = "HauntedZoneMain_TreehouseDrifblim",
    ["Haunted Zone Main Area - Meadow Drifblim Fast Travel"] = "HauntedZoneMain_MeadowDrifblim",
    ["Haunted Zone Main Area - Beach Drifblim Fast Travel"] = "HauntedZoneMain_BeachDrifblim",
    ["Haunted Zone Main Area - Ice Drifblim Fast Travel"] = "HauntedZoneMain_IceDrifblim",
    ["Haunted Zone Main Area - Cavern Drifblim Fast Travel"] = "HauntedZoneMain_CavernDrifblim",
    ["Haunted Zone Main Area - Magma Drifblim Fast Travel"] = "HauntedZoneMain_MagmaDrifblim",
    ["Haunted Zone Main Area - Granite Drifblim Fast Travel"] = "HauntedZoneMain_GraniteDrifblim",
    ["Haunted Zone Main Area - Flower Drifblim Fast Travel"] = "HauntedZoneMain_FlowerDrifblim",

    -- Haunted Zone Attractions
    ["Haunted Zone Main Area - Tangrowth Attraction"] = "HauntedZoneMain_TangrowthAttraction",
    ["Tangrowth's Swing-Along Attraction - Attraction Menu"] = "TangrowthAttraction_Tangrowth",
    ["Haunted Zone Mansion Area - Dusknoir Attraction"] = "HauntedZoneMansion_DusknoirAttraction",
    ["Dusknoir's Speed Slam Attraction - Attraction Menu"] = "DusknoirAttraction_Dusknoir",
    ["Haunted Zone Rotom Area - Rotom Attraction"] = "HauntedZoneRotom_RotomAttraction",
    ["Rotom's Spooky Shoot-'em-Up Attraction - Attraction Menu"] = "RotomAttraction_Rotom",

    -- Haunted Zone Mansion
    ["Haunted Zone Mansion Area - Main Area Gate"] = "HauntedZoneMansion_MainGate",
    ["Haunted Zone Main Area - Mansion Gate"] = "HauntedZoneMain_MansionGate",

    -- Haunted Zone Mansion Inner Areas
    ["Haunted Zone Mansion Ballroom Area - White Gem Door"] = "HauntedZoneBallroom_WhiteGemDoor",
    ["Haunted Zone Mansion Area - White Gem Door"] = "HauntedZoneMansion_WhiteGemDoor",
    ["Haunted Zone Mansion Study Area - Red Gem Door"] = "HauntedZoneStudy_RedGemDoor",
    ["Haunted Zone Mansion Area - Red Gem Door"] = "HauntedZoneMansion_RedGemDoor",
    ["Haunted Zone Mansion Gengar Area - Blue Gem Door"] = "HauntedZoneGengar_BlueGemDoor",
    ["Haunted Zone Mansion Area - Blue Gem Door"] = "HauntedZoneMansion_BlueGemDoor",
    ["Haunted Zone Mansion Antic Area - Green Gem Door"] = "HauntedZoneAntic_GreenGemDoor",
    ["Haunted Zone Mansion Area - Green Gem Door"] = "HauntedZoneMansion_GreenGemDoor",

    -- Haunted Zone Rotom Area Connection
    ["Haunted Zone Bookshelf Area - Hidden Bookshelf"] = "HauntedZoneSecret_Bookshelf",
    ["Haunted Zone Rotom Area - Bookshelf Area Connection"] = "HauntedZoneRotom_SecretConnection",
    ["Haunted Zone Bookshelf Area - Rotom Connection"] = "HauntedZoneSecret_RotomConnection",
    ["Haunted Zone Mansion Study Area - Hidden Bookshelf"] = "HauntedZoneStudy_Bookshelf",

    -- Granite Zone Main Area
    ["Granite Zone Main Area - Treehouse Connection"] = "GraniteZoneMain_TreehouseGate",
    ["Granite Zone Main Area - Flower Zone Gate"] = "GraniteZoneMain_FlowerGate",

    -- Granite Zone Fast Travel
    ["Granite Zone Main Area - Treehouse Drifblim Fast Travel"] = "GraniteZoneMain_TreehouseDrifblim",
    ["Granite Zone Main Area - Meadow Drifblim Fast Travel"] = "GraniteZoneMain_MeadowDrifblim",
    ["Granite Zone Main Area - Beach Drifblim Fast Travel"] = "GraniteZoneMain_BeachDrifblim",
    ["Granite Zone Main Area - Ice Drifblim Fast Travel"] = "GraniteZoneMain_IceDrifblim",
    ["Granite Zone Main Area - Cavern Drifblim Fast Travel"] = "GraniteZoneMain_CavernDrifblim",
    ["Granite Zone Main Area - Magma Drifblim Fast Travel"] = "GraniteZoneMain_MagmaDrifblim",
    ["Granite Zone Main Area - Haunted Drifblim Fast Travel"] = "GraniteZoneMain_HauntedDrifblim",
    ["Granite Zone Main Area - Flower Drifblim Fast Travel"] = "GraniteZoneMain_FlowerDrifblim",

    -- Granite Zone Attractions
    ["Granite Zone Main Area - Absol Attraction"] = "GraniteZoneMain_AbsolAttraction",
    ["Absol's Hurdle Bounce Attraction - Attraction Menu"] = "AbsolAttraction_Absol",
    ["Granite Zone Main Area - Salamence Attraction"] = "GraniteZoneMain_SalamenceAttraction",
    ["Salamence's Sky Race Attraction - Attraction Menu"] = "SalamenceAttraction_Salamence",

    -- Flower Zone Main Area
    ["Flower Zone Main Area - Granite Zone Gate"] = "FlowerZoneMain_GraniteGate",

    -- Flower Zone Fast Travel
    ["Flower Zone Main Area - Treehouse Drifblim Fast Travel"] = "FlowerZoneMain_TreehouseDrifblim",
    ["Flower Zone Main Area - Meadow Drifblim Fast Travel"] = "FlowerZoneMain_MeadowDrifblim",
    ["Flower Zone Main Area - Beach Drifblim Fast Travel"] = "FlowerZoneMain_BeachDrifblim",
    ["Flower Zone Main Area - Ice Drifblim Fast Travel"] = "FlowerZoneMain_IceDrifblim",
    ["Flower Zone Main Area - Cavern Drifblim Fast Travel"] = "FlowerZoneMain_CavernDrifblim",
    ["Flower Zone Main Area - Magma Drifblim Fast Travel"] = "FlowerZoneMain_MagmaDrifblim",
    ["Flower Zone Main Area - Haunted Drifblim Fast Travel"] = "FlowerZoneMain_HauntedDrifblim",
    ["Flower Zone Main Area - Granite Drifblim Fast Travel"] = "FlowerZoneMain_GraniteDrifblim",

    -- Flower Zone Attractions
    ["Flower Zone Main Area - Rayquaza Attraction"] = "FlowerZoneMain_RayquazaAttraction",
    ["Rayquaza's Balloon Panic Attraction - Attraction Menu"] = "RayquazaAttraction_Rayquaza",

    -- Skygarden
    ["Skygarden - Piplup Skyballoon"] = "Skygarden_PiplupBalloon",
    ["Treehouse - Piplup Skyballoon"] = "Treehouse_PiplupBalloon"
}

function Entrances.exit_accessibility(exit_name)
    local load_assignments_from_ap = Tracker:FindObjectForCode("setting_load_exit_assignments_from_ap")
    if load_assignments_from_ap.Active and Entrances.slot_data_exit_to_entrance and
        next(Entrances.slot_data_exit_to_entrance) then
        local entrance_name = Entrances.slot_data_exit_to_entrance[exit_name]
        local entrance = Tracker:FindObjectForCode(entrance_name)
        return entrance.AccessibilityLevel
    else
        local entrance_name = Entrances.exit_to_entrance[exit_name]
        local entrance = Tracker:FindObjectForCode(entrance_name)
        return entrance.AccessibilityLevel
    end
end

return Entrances
