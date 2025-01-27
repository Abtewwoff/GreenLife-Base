function MOD_Labos:AddLabos(laboId, owner, _type, enterCoords)
    if (MOD_Labos.list[laboId]) then print("Error: This labos already exists") return end

    MOD_Labos.list[laboId] = _GreenLifeLabos(laboId, owner, _type, enterCoords)

    return (MOD_Labos.list[laboId])
end