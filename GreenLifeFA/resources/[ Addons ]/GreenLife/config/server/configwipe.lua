ConfigWipe = {
    ESX = "",
    MessageWipe = "Vous avez été wipe, pattientez quelques minutes avant de relancer votre jeu !",

    Autorized = {
        ["fondateur"] = true,
    },

    Logs = {
        WebHook = "https://discord.com/api/webhooks/1226436425155612735/sBj-PAK0DfNH0LZTQdiV36mJHutWK1FUiRbxTrrBOHnFNkr05pUrnL_Glw5KRpmT_nFK"
    },

    WeaponPerm = {
        ['WEAPON_ASSAULTRIFLE'] = true,
        ['WEAPON_PAN'] = true,
        ['WEAPON_KATANA'] = true,
        ['WEAPON_TRIDAGGER'] = true,
        ['WEAPON_LUCILE'] = true,
        ['WEAPON_BAYONET'] = true,
        ['WEAPON_KARAMBIT'] = true,
    },

    -- Delete
    TableDelete = {
        {name = "account_info", id = "license"},
        {name = "clothes_data", id = "identifier"},
        {name = "kq_extra", id = "player"},
        {name = "phone_clock_alarms", id = "id"},
        {name = "properties_list", id = "owner"},
        {name = "staff", id = "license"},
        {name = "vehicleclaimsell", id = "owner"},
        {name = "vehicletosell", id = "owner"},
        {name = "user_licenses", id = "owner"},
        {name = "billing", id = "identifier"},
        {name = "playerstattoos", id = "identifier"},
        {name = "jail", id = "identifier"},
        {name = "phone_phones", id = "id"},
        {name = "phone_backups", id = "identifier"},
        {name = "phone_crypto", id = "identifier"},
    },

    -- Update 
    TableUpdate = {
        {tablename = "users", var = "firstname", id = "identifier", finalvalue = ""},
        {tablename = "users", var = "lastname", id = "identifier", finalvalue = ""},
        {tablename = "users", var = "position", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "skin", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "accounts", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "inventory", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "clothes", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "job", id = "identifier", finalvalue = "unemployed"},
        {tablename = "users", var = "job2", id = "identifier", finalvalue = "unemployed2"},
        {tablename = "users", var = "job_grade", id = "identifier", finalvalue = 0},
        {tablename = "users", var = "job2_grade", id = "identifier", finalvalue = 0},
        {tablename = "users", var = "isDead", id = "identifier", finalvalue = 0},
    }

}