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

function SIMP:NewInstance(instance, properties, ...)
    assert(instance, 'Please insert instance')
    local instances = Instance.new(instance);
    local properties = properties or {};

    for k,v in pairs(properties) do
        instances[k] = v;
    end

    local children = {...}
    if #children > 0 then
        for k, v in pairs(children) do
            if typeof(v) == 'Instance' then
                v.Parent = instances
            end
        end
    end

    return instances;
end

function SIMP:ChangeProperties(instance, newProperties)
    assert(instance, 'The instance are nil, not able to continue.')
    assert(newProperties, 'Please insert properties to changed, on table!')

    for k,v in pairs(newProperties) do
        instance[k] = v;
    end

    return instance
end

return SIMP;