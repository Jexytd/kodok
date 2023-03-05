local SIMP = {};
--/ Currently version is just custom for kodok :>

function SIMP:Get(URL)
    local cache = cache or true;
    local state, response = pcall(function()
        return game:HttpGet(URL, cache)
    end)

    if state and (response ~= nil or #response > 0) then
        return response;
    end
    return state
end

function SIMP:New(object, properties, child)
    local newObject = Instance.new(object);
    local objSetting = properties or {};

    for k,v in pairs(objSetting) do
        if newObject[k] then
            newObject[k] = v;
        end
    end

    for k,v in pairs(child) do
        if v.Parent ~= newObject.Parent then
            v.Parent = newObject;
        end
    end

    return newObject
end

function SIMP:Change(instance, newProperties)
    assert(object, 'Cannot procceed an action, missing object!')
    
    local objSetting = newProperties or {};
    for k,v in pairs(objSetting) do
        if object[k] then
            object[k] = v;
        end
    end

    return object;
end

function SIMP:IsOwn(tab, value)
    for k,v in pairs(tab) do
        if k == value or v == value then
            return v;
        end
    end
    return;
end

return SIMP;