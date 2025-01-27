---- IMPORTANT ! ALL ITEMS ARE EXAMPLE FOR YOU, YOU SHOULD SET THOSE, IF YOU DONT SET PROBABLY ITS GONNA BE BROKEN. ! IMPORTANT
---- IMPORTANT ! ALL ITEMS ARE EXAMPLE FOR YOU, YOU SHOULD SET THOSE, IF YOU DONT SET PROBABLY ITS GONNA BE BROKEN. ! IMPORTANT
---- IMPORTANT ! ALL ITEMS ARE EXAMPLE FOR YOU, YOU SHOULD SET THOSE, IF YOU DONT SET PROBABLY ITS GONNA BE BROKEN. ! IMPORTANT

-- ak4y dev.

-- IF YOU HAVE ANY PROBLEM OR DO YOU NEED HELP PLS COME TO MY DISCORD SERVER AND CREATE A TICKET
-- IF YOU DONT HAVE ANY PROBLEM YET AGAIN COME TO MY DISCORD :)
-- https://discord.gg/kWwM3Bx

AK4Y = {}

AK4Y.Framework = "esx" -- esx / newEsx | newEsx = export system | esx = triggerevent system
AK4Y.Mysql = "mysql-async" -- Check fxmanifest.lua when you change it! | ghmattimysql / oxmysql / mysql-async
AK4Y.OpenCommand = "caseOpening"

AK4Y.WeaponsAreItem = false -- If your weapons are item then you should set this TRUE.

AK4Y.NeededPlayTime = 60 -- MINUTES
AK4Y.PlayTimeRewardType = "GOLDCOIN" -- GOLDCOIN OR SILVERCOIN
AK4Y.PlayTimeRewardCoin = 10 

AK4Y.WebsiteLink = "https://greenlifefa.tebex.io"
AK4Y.DiscordLink = "https://discord.gg/greenlife"

-- ITEM TYPES : "common", "uncommon", "rare", "mythical", "legendary"
AK4Y.LastItemCategories = {"uncommon", "rare", "mythical", "legendary"} -- When items of the type written on the left are won, they appear in the recently won items tab
AK4Y.ServerNotifyCategories = {"uncommon", "mythical", "legendary"} -- When items of the type written on the left are won, a notification is sent to the entire server

AK4Y.Translate = {
    title1 = "Caisses",
    title2 = "Mystères",
    premium = "PREMIUM",
    standard = "STANDARD",
    cases = "CAISSES",
    website = "SITE",
    discord = "DISCORD",
    premiumCases = "CAISSES PREMIUM",
    standardCases = "CAISSES STANDARD",
    openCase = "OUVRIR LA CAISSE",
    openFast = "OUVERTURE RAPIDE",
    coinShopTitle = "Coins",
    new = "",
    goBack = "RETOUR",
    caseItems = "Gains",
    items = "Objets :",
    congratulations = "FÉLICITATION !",
    congDescription = "Merci pour votre achat !",
    collect = "PRENDRE",
    sell = "VENDRE",
    accept = "ACCEPTER",
    creditLoaded = "Coins chargé avec succès",
    failed = "ERREUR",
    youDntHaveEnoughCredit = "VOUS N'AVEZ PAS ASSEZ DE Coins !",
}



-- giveItemType's = "item", "vehicle", "money"
-- items in the case should have a chance total of 100 !! IMPORTANT !! IMPORTANT !! IMPORTANT !!
AK4Y.PremiumCases = {
    {
        uniqueId = 1, -- IDs must be different and sequential
        label = "Caisse Amateur",
        price = 1000, 
        priceType = "Coins", -- Coins OR SC
        caseTheme = "red", -- red, blue, orange, purple, green
        caseType = "premium", -- do not touch!
        isNew = true,
        items = { -- giveItemType's = "item", "vehicle", "money", "weapon"
                  -- items in the case should have a chance total of 100 !! IMPORTANT !! IMPORTANT !! IMPORTANT !!
            { itemName = "money_35000", label = "35.000$", chance = 5.5, sellCredit = 350, itemType = "common", itemCount = 35000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "a45amg", label = "A45 AMG", chance = 5.5, sellCredit = 350, itemType = "common", itemCount = 1, giveItemType = "vehicle", image = "./images/items/A45AMG1.png" },
            { itemName = "weapon_katana", label = "KATANA", chance = 7.5, sellCredit = 250, itemType = "common", itemCount = 1, giveItemType = "weapon", image = "./images/items/katana.png" },
            { itemName = "money_50000", label = "50.000$", chance = 7.5, sellCredit = 250, itemType = "common", itemCount = 50000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "weapon_snspistol_mk2", label = "SNS PISTOL MK2", chance = 1, sellCredit = 800, itemType = "legendary", itemCount = 1, giveItemType = "weapon", image = "./images/items/snsmk2.png" },
            { itemName = "money_130000", label = "130.000$", chance = 4, sellCredit = 750, itemType = "uncommon", itemCount = 130000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "mers63c", label = "Mercedes-Benz S 63 AMG", chance = 7.5, sellCredit = 250, itemType = "common", itemCount = 1, giveItemType = "vehicle", image = "./images/items/S63_AMG.png" },
            { itemName = "2020exc", label = "KTM 2020 EXC", chance = 7.5, sellCredit = 250, itemType = "common", itemCount = 1, giveItemType = "vehicle", image = "./images/items/ktm.png" },
            { itemName = "Coins_1500", label = "1.500 Coins", chance = 6, sellCredit = 1500, itemType = "uncommon", itemCount = 1500, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "money_150000", label = "150.000$", chance = 2, sellCredit = 950, itemType = "legendary", itemCount = 150000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "812mansory", label = "Ferrari 812 Superfast Mansory", chance = 2, sellCredit = 1500, itemType = "legendary", itemCount = 1, giveItemType = "vehicle", image = "./images/items/ferrari.png" },
            { itemName = "Coins_3000", label = "3.000 Coins", chance = 2, sellCredit = 3000, itemType = "legendary", itemCount = 3000, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "money_80000", label = "80.000$", chance = 6, sellCredit = 500, itemType = "uncommon", itemCount = 80000, giveItemType = "money", image = "./images/items/money.png" },
        },
    },
    {
        uniqueId = 2, -- IDs must be different and sequential
        label = "Caisse intermédiaire",
        price = 2000,
        priceType = "Coins", -- Coins OR SC
        caseTheme = "orange", -- red, blue, orange, purple, green
        caseType = "premium",
        isNew = false, -- If you set it true, the case will be labeled "new"
        items = {
            { itemName = "ksd", label = "KTM DUKE", chance = 10, sellCredit = 1000, itemType = "common", itemCount = 1, giveItemType = "vehicle", image = "./images/items/duke.png" },
            { itemName = "nh2r", label = "Ninja H2R", chance = 10, sellCredit = 1000, itemType = "common", itemCount = 1, giveItemType = "vehicle", image = "./images/items/h2r.png" },
            { itemName = "money_50000", label = "50.000$", chance = 10, sellCredit = 1000, itemType = "common", itemCount = 50000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "money_70000", label = "70.000$", chance = 7.5, sellCredit = 2000, itemType = "uncommon", itemCount = 70000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "money_100000", label = "100.000$", chance = 7.5, sellCredit = 2000, itemType = "uncommon", itemCount = 100000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "Coins_2500", label = "2.000 Coins", chance = 7.5, sellCredit = 2000, itemType = "uncommon", itemCount = 2000, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "gxgiulia", label = "GX GIULIA", chance = 5, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/alfaromeo.png" },
            { itemName = "s1000rr", label = "BMW S1000RR", chance = 5, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/S1000rr.png" },
            { itemName = "rmodm4gts", label = "BMW M4 GTS", chance = 2, sellCredit = 3000, itemType = "mythical", itemCount = 1, giveItemType = "vehicle", image = "./images/items/M4GTS.png" },
            { itemName = "mlmansory", label = "Levante Mansory", chance = 2, sellCredit = 3000, itemType = "mythical", itemCount = 1, giveItemType = "vehicle", image = "./images/items/Levantem.png" },
            { itemName = "money_150000", label = "150.000$", chance = 2, sellCredit = 3000, itemType = "mythical", itemCount = 150000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "Coins_4000", label = "4.000 Coins", chance = 1, sellCredit = 4000, itemType = "legendary", itemCount = 4000, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "weapon_pistol_mk2", label = "PISTOLET MK2", chance = 0.5, sellCredit = 4000, itemType = "legendary", itemCount = 1, giveItemType = "weapon", image = "./images/items/Pistolmk2.png" },
        },
    },
    {
        uniqueId = 3, -- IDs must be different and sequential
        label = "Caisse confirmé",
        price = 3000,
        priceType = "Coins", -- Coins OR SC
        caseTheme = "green", -- red, blue, orange, purple, green
        caseType = "premium",
        isNew = false, -- If you set it true, the case will be labeled "new"
        items = {
            { itemName = "money_70000", label = "70.000$", chance = 15, sellCredit = 1500, itemType = "common", itemCount = 70000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "money_90000", label = "90.000$", chance = 15, sellCredit = 1500, itemType = "common", itemCount = 90000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "money_120000", label = "120.000$", chance = 15, sellCredit = 1500, itemType = "common", itemCount = 120000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "Coins_2000", label = "2.000 Coins", chance = 15, sellCredit = 2000, itemType = "common", itemCount = 2000, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "Coins_3000", label = "3.000 Coins", chance = 10, sellCredit = 3000, itemType = "uncommon", itemCount = 3000, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "teslapd", label = "Tesla Prior design", chance = 10, sellCredit = 2500, itemType = "uncommon", itemCount = 1, giveItemType = "vehicle", image = "./images/items/teslapd.png" },
            { itemName = "rs6c8", label = "Audi RS6 C8", chance = 5, sellCredit = 3500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/rs6c8.png" },
            { itemName = "s65amg", label = "Mercedes S 65 AMG", chance = 5, sellCredit = 3500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/s65amg.png" },
            { itemName = "money_165000", label = "165.000$", chance = 5, sellCredit = 3500, itemType = "rare", itemCount = 165000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "weapon_snspistol_mk2", label = "SNS Pistol MK2", chance = 2, sellCredit = 4500, itemType = "mythical", itemCount = 1, giveItemType = "weapon", image = "./images/items/snsmk2.png" },
            { itemName = "weapon_appistol", label = "AP PISTOL", chance = 1, sellCredit = 5000, itemType = "legendary", itemCount = 1, giveItemType = "weapon", image = "./images/items/appistol.png" },
            { itemName = "Coins_5000", label = "5.000 Coins", chance = 1, sellCredit = 5000, itemType = "legendary", itemCount = 5000, giveItemType = "coins", image = "./images/items/coins.png" },
        },
    },
    {
        uniqueId = 4, -- IDs must be different and sequential
        label = "Caisse Expert",
        price = 4000,
        priceType = "Coins", -- Coins OR SC
        caseTheme = "blue", -- red, blue, orange, purple, green
        caseType = "premium",
        isNew = false, -- If you set it true, the case will be labeled "new"
        items = {
            { itemName = "money_100000", label = "100.000$", chance = 12, sellCredit = 3000, itemType = "common", itemCount = 100000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "money_120000", label = "120.000$", chance = 12, sellCredit = 3000, itemType = "common", itemCount = 120000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "money_150000", label = "150.000$", chance = 12, sellCredit = 3000, itemType = "common", itemCount = 150000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "money_170000", label = "170.000$", chance = 12, sellCredit = 3000, itemType = "common", itemCount = 170000, giveItemType = "money", image = "./images/items/money.png" },
            { itemName = "rrst", label = "Range Rover Vogue Startech", chance = 10, sellCredit = 3000, itemType = "uncommon", itemCount = 1, giveItemType = "vehicle", image = "./images/items/rrst.png" },
            { itemName = "bmci", label = "BMW M5 F90", chance = 10, sellCredit = 3000, itemType = "uncommon", itemCount = 1, giveItemType = "vehicle", image = "./images/items/m5f90.png" },
            { itemName = "Coins_2500", label = "2.500 Coins", chance = 7, sellCredit = 3000, itemType = "rare", itemCount = 2500, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "Coins_4000", label = "4.000 Coins", chance = 7, sellCredit = 3000, itemType = "rare", itemCount = 4000, giveItemType = "coins", image = "./images/items/coins.png" },
            { itemName = "weapon_snspistol_mk2", label = "SNS Pistol MK2", chance = 4, sellCredit = 3000, itemType = "mythical", itemCount = 1, giveItemType = "weapon", image = "./images/items/snsmk2.png" },
            { itemName = "weapon_appistol", label = "AP PISTOL", chance = 3, sellCredit = 3000, itemType = "legendary", itemCount = 1, giveItemType = "weapon", image = "./images/items/appistol.png" },
            { itemName = "weapon_machinepistol", label = "TEC 9", chance = 1, sellCredit = 3000, itemType = "legendary", itemCount = 1, giveItemType = "weapon", image = "./images/items/tec9.png" },
            { itemName = "Coins_6000", label = "6.000 Coins", chance = 2, sellCredit = 6000, itemType = "legendary", itemCount = 6000, giveItemType = "coins", image = "./images/items/coins.png" },
        },
    },
    {
        uniqueId = 7, -- IDs must be different and sequential
        label = "Caisse Véhicules",
        price = 3000,
        priceType = "Coins", -- Coins OR SC
        caseTheme = "purple", -- red, blue, orange, purple, green
        caseType = "premium",
        isNew = false, -- If you set it true, the case will be labeled "new" 
        items = {
            { itemName = "megrs18", label = "Renault Megane RS", chance = 10.0, sellCredit = 2500, itemType = "common", itemCount = 1, giveItemType = "vehicle", image = "./images/items/megrs18.png" },
            { itemName = "golf75r19", label = "Volkswagen Golf 7.5R", chance = 10.0, sellCredit = 2500, itemType = "common", itemCount = 1, giveItemType = "vehicle", image = "./images/items/golf75r19.png" },
            { itemName = "m5cs22", label = "BMW M5 CS", chance = 8.0, sellCredit = 2500, itemType = "uncommon", itemCount = 1, giveItemType = "vehicle", image = "./images/items/m5cs22.png" },
            { itemName = "cls63s", label = "Mercedes CLS 63", chance = 8.0, sellCredit = 2500, itemType = "uncommon", itemCount = 1, giveItemType = "vehicle", image = "./images/items/cls63s.png" },
            { itemName = "x6mf96", label = "BMW X6M F96", chance = 8.0, sellCredit = 2500, itemType = "uncommon", itemCount = 1, giveItemType = "vehicle", image = "./images/items/x6mf96.png" },
            { itemName = "gls63", label = "Mercedes GLS 63", chance = 7.5, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/gls63.png" },
            { itemName = "panamturs21", label = "Porsche Panamera Turismo", chance = 7.0, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/panamturs21.png" },
            { itemName = "m5tou", label = "BMW M5 Touring", chance = 7.0, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/m5tou.png" },
            { itemName = "gcmrs3sedan2022", label = "Audi RS3 Sedan", chance = 7.0, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/gcmrs3sedan2022.png" },
            { itemName = "vclass21", label = "Mercedes Classe V", chance = 7.0, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/vclass21.png" },
            { itemName = "gcm992gt3", label = "Porsche 911 GT3", chance = 6.0, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/gcm992gt3.png" },
            { itemName = "x7m60i", label = "BMW X7 M60i", chance = 5.0, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/x7m60i.png" },
            { itemName = "gcmrsq82022", label = "Audi RSQ8", chance = 5.0, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/gcmrsq82022.png" },
            { itemName = "golf8r", label = "Volkswagen Golf 8R", chance = 4.5, sellCredit = 2500, itemType = "rare", itemCount = 1, giveItemType = "vehicle", image = "./images/items/golf8r.png" },
            { itemName = "taycants21m", label = "Porsche Taycan Mansory", chance = 3.5, sellCredit = 2500, itemType = "mythical", itemCount = 1, giveItemType = "vehicle", image = "./images/items/taycants21m.png" },
            { itemName = "m3touring", label = "BMW M3 Touring", chance = 3.5, sellCredit = 2500, itemType = "mythical", itemCount = 1, giveItemType = "vehicle", image = "./images/items/m3touring.png" },
            { itemName = "glsbrabus800", label = "Brabus GLS 800", chance = 3.0, sellCredit = 2500, itemType = "mythical", itemCount = 1, giveItemType = "vehicle", image = "./images/items/glsbrabus800.png" },
            { itemName = "ikx3m2p23", label = "BMW M2 Performance 2023", chance = 2.5, sellCredit = 2500, itemType = "mythical", itemCount = 1, giveItemType = "vehicle", image = "./images/items/ikx3m2p23.png" },
            { itemName = "718gt4rs", label = "Porsche 718 GT4RS", chance = 2.0, sellCredit = 2500, itemType = "mythical", itemCount = 1, giveItemType = "vehicle", image = "./images/items/718gt4rs.png" },
            { itemName = "bshadow800", label = "Brabus Classe G 800", chance = 1.8, sellCredit = 2500, itemType = "legendary", itemCount = 1, giveItemType = "vehicle", image = "./images/items/bshadow800.png" },
            { itemName = "gcmferraripurosangue", label = "Ferrari Purosangue", chance = 1.6, sellCredit = 2500, itemType = "legendary", itemCount = 1, giveItemType = "vehicle", image = "./images/items/gcmferraripurosangue.png" },
            { itemName = "lp780r", label = "Lamborghini LP780 Ultimate", chance = 1.5, sellCredit = 2500, itemType = "legendary", itemCount = 1, giveItemType = "vehicle", image = "./images/items/lp780r.png" },
            { itemName = "sf90af", label = "Ferrari SF90", chance = 1.0, sellCredit = 2500, itemType = "legendary", itemCount = 1, giveItemType = "vehicle", image = "./images/items/sf90af.png" },
            { itemName = "x3utopia23", label = "Pagani Utopia", chance = 0.5, sellCredit = 2500, itemType = "legendary", itemCount = 1, giveItemType = "vehicle", image = "./images/items/x3utopia23.png" },
        },
    },
}

-- AK4Y.StandardCases = {
--     {
--         uniqueId = 1,
--         label = "Standard Case (1)",
--         price = 150,
--         priceType = "SC", -- Coins OR SC
--         caseTheme = "nude",
--         isNew = true, -- If you set it true, the case will be labeled "new"
--         items = {
--             { itemName = "weapon_pistol", label = "ITEM 1", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 2", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 3", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 4", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 5", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 6", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 7", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 8", chance = 0.5, sellCredit = 25, itemType = "legendary", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--         },
--     },
--     {
--         uniqueId = 2,
--         label = "Standard Case (2)",
--         price = 150,
--         priceType = "SC", -- Coins OR SC
--         caseTheme = "nude",
--         isNew = true, -- If you set it true, the case will be labeled "new"
--         items = {
--             { itemName = "weapon_pistol", label = "ITEM 1", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 2", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 3", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 4", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 5", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 6", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 7", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 8", chance = 0.5, sellCredit = 25, itemType = "legendary", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--         },
--     },
--     {
--         uniqueId = 3,
--         label = "Standard Case (3)",
--         price = 150,
--         priceType = "SC", -- Coins OR SC
--         caseTheme = "nude",
--         isNew = false, -- If you set it true, the case will be labeled "new"
--         items = {
--             { itemName = "weapon_pistol", label = "ITEM 1", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 2", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 3", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 4", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 5", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 6", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 7", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 8", chance = 0.5, sellCredit = 25, itemType = "legendary", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--         },
--     },
--     {
--         uniqueId = 4,
--         label = "Standard Case (4)",
--         price = 150,
--         priceType = "SC", -- Coins OR SC
--         caseTheme = "nude",
--         isNew = false, -- If you set it true, the case will be labeled "new"
--         items = {
--             { itemName = "weapon_pistol", label = "ITEM 1", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 2", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 3", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 4", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 5", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 6", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 7", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 8", chance = 0.5, sellCredit = 25, itemType = "legendary", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--         },
--     },
--     {
--         uniqueId = 5,
--         label = "Standard Case (5)",
--         price = 150,
--         priceType = "SC", -- Coins OR SC
--         caseTheme = "nude",
--         isNew = false, -- If you set it true, the case will be labeled "new"
--         items = {
--             { itemName = "weapon_pistol", label = "ITEM 1", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 2", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 3", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 4", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 5", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 6", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 7", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 8", chance = 0.5, sellCredit = 25, itemType = "legendary", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--         },
--     },
--     {
--         uniqueId = 6,
--         label = "Standard Case (6)",
--         price = 150,
--         priceType = "SC", -- Coins OR SC
--         caseTheme = "nude",
--         isNew = false, -- If you set it true, the case will be labeled "new"
--         items = {
--             { itemName = "weapon_pistol", label = "ITEM 1", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 2", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 3", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 4", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 5", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 6", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 7", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 8", chance = 0.5, sellCredit = 25, itemType = "legendary", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--         },
--     },
--     {
--         uniqueId = 7,
--         label = "Standard Case (7)",
--         price = 150,
--         priceType = "SC", -- Coins OR SC
--         caseTheme = "nude",
--         isNew = false, -- If you set it true, the case will be labeled "new"
--         items = {
--             { itemName = "weapon_pistol", label = "ITEM 1", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 2", chance = 30, sellCredit = 10, itemType = "common", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 3", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 4", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 5", chance = 10, sellCredit = 15, itemType = "rare", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 6", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 7", chance = 4.5, sellCredit = 20, itemType = "mythical", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--             { itemName = "weapon_pistol", label = "ITEM 8", chance = 0.5, sellCredit = 25, itemType = "legendary", itemCount = 1, giveItemType = "item", image = "./images/items/item.png" },
--         },
--     },
-- }

AK4Y.SellCoins = {
    {
        coinCount = 1000,
        realPrice = 12,
        directLink = "https://GreenLife.tebex.io/package/5631534",
    },
    {
        coinCount = 2000,
        realPrice = 24,
        directLink = "https://GreenLife.tebex.io/package/5631535",
    },
    {
        coinCount = 4000,
        realPrice = 48,
        directLink = "https://GreenLife.tebex.io/package/5631536",
    },
    {
        coinCount = 5500,
        realPrice = 60,
        directLink = "https://GreenLife.tebex.io/package/5631537",
    },
    {
        coinCount = 11500,
        realPrice = 120,
        directLink = "https://GreenLife.tebex.io/package/5631540",
    },
    {
        coinCount = 22500,
        realPrice = 240,
        directLink = "https://GreenLife.tebex.io/package/5631541",
    },
    {
        coinCount = 34400,
        realPrice = 360,
        directLink = "https://GreenLife.tebex.io/package/5631543",
    },
    
}
