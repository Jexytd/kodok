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

function SIMP:NewInstance(instance, properties, children)
    assert(instance, 'Please insert instance')
    local instances = Instance.new(instance);
    local properties = properties or {};

    for k,v in pairs(properties) do
        instances[k] = v;
    end

    local children = children or {}
    for k, v in pairs(children) do
        if typeof(v) == 'Instance' then
            v.Parent = instances
        end
    end

    return instances;
end

function SIMP:ChangeProperties(instance, newProperties, children)
    assert(instance, 'The instance are nil, not able to continue.')
    assert(newProperties, 'Please insert properties to changed, on table!')

    for k,v in pairs(newProperties) do
        instance[k] = v;
    end

    local children = children or {};
    for k,v in pairs(children) do
        if typeof(v) == 'Instance' then
            v.Parent = instance;
        end
    end

    return instance
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