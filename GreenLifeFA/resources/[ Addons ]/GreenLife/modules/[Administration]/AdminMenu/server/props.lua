local PropsListAdmin = {}

RegisterNetEvent('GreenLife:Props:AddProps')
AddEventHandler('GreenLife:Props:AddProps', function(netId)
    if (PropsListAdmin[source] == nil) then PropsListAdmin[source] = {} end

    table.insert(PropsListAdmin[source], netId)
end)


RegisterNetEvent('GreenLife:Props:RemoveAProps')
AddEventHandler('GreenLife:Props:RemoveAProps', function(netId)
    for src in pairs(PropsListAdmin) do
        for i=1, #PropsListAdmin[src] do
            if (PropsListAdmin[src][i] == netId) then
                table.remove(PropsListAdmin[src], i)
            end
        end
    end
end)


ESX.RegisterServerCallback('GetAllPropsAdmin', function(source, cb)
    local AllProps = {}
    for src in pairs(PropsListAdmin) do
        for i=1, #PropsListAdmin[src] do
            table.insert(AllProps, PropsListAdmin[src][i])
        end
    end

    cb(AllProps)
end)