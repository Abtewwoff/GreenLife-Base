function API_Logs:getSide()
    if (IsDuplicityVersion()) then
        return "~g~SERVER";
    else
        return "~g~CLIENT";
    end
end