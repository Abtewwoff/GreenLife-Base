local pma = exports["pma-voice"]
local currentChannel = 0
local haveRadio = false


local Radio = {
    TickRadio = false,
    InfosRadio = false,
    Bruitages = true,
    Statut = "~g~Allumé",
    VolumeRadio = 1,
    jobChannels = {
        {job = "police", min=1, max=15},
        {job = "bcso", min=1, max=15},
        {job = "fib", min=1, max=15},
        {job = "ambulance", min=1, max=15},
        {job = "gouv", min=1, max=15}
    },
}

RegisterNetEvent('radioGood')
AddEventHandler("radioGood", function(bool)
    haveRadio = bool
end)

function playRadioAnim()
    local playerPed = PlayerPedId()
    loadAnimDict("random@arrests")
    TaskPlayAnim(playerPed, "random@arrests", "generic_radio_chatter", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

-- Fonction pour arrêter l'animation de parole
function stopRadioAnim()
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
end

RegisterNetEvent("openRadio", function()
    TriggerServerEvent("tonio:haveRadio")
    Wait(500)
    if haveRadio then
        local radio = RageUI.CreateMenu("", "Menu radio")
        radio.EnableMouse = true
        RageUI.Visible(radio, not RageUI.Visible(radio))
        while radio do
            Wait(0)
            RageUI.IsVisible(radio, function()
                RageUI.Button("Allumer / Eteindre", "Vous permet d'allumer ou d'éteindre la radio", {RightLabel = "→→"}, true, {
                    onSelected = function()
                        if not Radio.TickRadio then 
                            Radio.TickRadio = true 
                            pma:setVoiceProperty("radioEnabled", true)
                            ESX.ShowNotification("Radio Allumé !")
                        else
                            Radio.TickRadio = false
                            pma:setRadioChannel(0)
                            pma:setVoiceProperty("radioEnabled", false)
                            ESX.ShowNotification("Radio Eteinte !")
                        end
                    end
                })
                if Radio.TickRadio then
                    if Radio.Bruitages then 
                        RageUI.Separator("Bruitages: ~g~Activés")
                    else
                        RageUI.Separator("Bruitages: ~r~Désactivés")
                    end
                    if Radio.VolumeRadio*100 <= 20 then 
                        ColorRadio = "~g~" 
                    elseif Radio.VolumeRadio*100 <= 45 then 
                        ColorRadio ="~g~" 
                    elseif Radio.VolumeRadio*100 <= 65 then 
                        ColorRadio ="~g~" 
                    elseif Radio.VolumeRadio*100 <= 100 then 
                        ColorRadio ="~g~" 
                    end 

                    RageUI.Separator("Volume: "..ColorRadio..ESX.Math.Round(Radio.VolumeRadio*100).."~s~ %")

                    RageUI.Line()

                    RageUI.Button("Se connecter à une fréquence ", "Choissisez votre fréquence", {RightLabel = Radio.Frequence}, true, {
                        onSelected = function()
                            local verif, Frequence = CheckQuantity(exports["cfx-target"]:ShowSync('Veuillez indiquer le numéro de la fréquence que vous souhaitez', true, 600, "small_text"))
                            local PlayerData = ESX.GetPlayerData(_source)
                            local restricted = {}

                            if (Frequence == nil) then return end
                            
                            if Frequence > 500 then
                                return
                            end
                            
                            for i,v in pairs(Radio.jobChannels) do
                                if Frequence >= v.min and Frequence <= v.max then
                                    table.insert(restricted, v)
                                end
                            end
                    
                            if #restricted > 0 then
                                for i,v in pairs(restricted) do
                                    if PlayerData.job.name == v.job and Frequence >= v.min and Frequence <= v.max then
                                        Radio.Frequence = tostring(Frequence)
                                        pma:setRadioChannel(Frequence)
                                        ESX.ShowNotification("Fréquence définie sur "..Frequence.." MHZ")
                                        currentChannel = Frequence
                                        break
                                    elseif i == #restricted then
                                        ESX.ShowNotification('Echec de la connexion a la fréquence')
                                        break
                                    end
                                end
                            else
                                Radio.Frequence = tostring(Frequence)
                                pma:setRadioChannel(Frequence)
                                ESX.ShowNotification("Fréquence définie sur "..Frequence.." MHZ")
                                TriggerServerEvent('GreenLifePass:taskCountAdd:premium', 4, 1)
                                currentChannel = Frequence
                            end
                        end
                    })
                    RageUI.Button("Se déconnecter de la fréquence", "Vous permet de déconnecter de votre fréquence actuelle", {RightLabel = "→→"}, true, {
                        onSelected = function()
                            pma:setRadioChannel(0)
                            Radio.Frequence = "0"
                            ESX.ShowNotification("Vous vous êtes déconnecter de la fréquence")
                        end
                    })
                    RageUI.Button("Activer les bruitages", "Vous permet d'activer les bruitages'", {RightLabel = "→→"}, true, {
                        onSelected = function()
                            if Radio.Bruitages then 
                                Radio.Bruitages = false
                                pma:setVoiceProperty("micClicks", false)
                                ESX.ShowNotification("Bruitages radio désactives")
                            else
                                Radio.Bruitages = true 
                                ESX.ShowNotification("Bruitages radio activés")
                                pma:setVoiceProperty("micClicks", true)
                            end
                        end
                    })
                else
                    RageUI.Separator("Radio: ~r~Eteinte")
                end
            end, function()
                RageUI.PercentagePanel(Radio.VolumeRadio, 'Volume', '0%', '100%', {
                    onProgressChange = function(Percentage)
                        Radio.VolumeRadio = Percentage
                        pma:setRadioVolume(Percentage)
                    end
                }, 5) 
            end)
            if not RageUI.Visible(radio) then
                radio = RMenu:DeleteType("radio")
            end
        end
    else
        ESX.ShowNotification("Vous n'avez pas de radio !")
    end
end)


function CheckQuantity(number)
    number = tonumber(number)

    if type(number) == "number" then
        number = ESX.Math.Round(number)

        if number > 0 then
            return true, number
        end
    end

    return false, number
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(1, 170) then  
            TriggerEvent('openRadio')
        end
    end
end)


AddEventHandler('pma-voice:radioActive', function(active)
    if active then
        playRadioAnim()
    else
        stopRadioAnim()
    end
end)