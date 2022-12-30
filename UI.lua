local UI = {};
local SIMP = loadstring(game:HttpGet('https://raw.githubusercontent.com/Jexytd/kodok/main/SimpleCode.lua'))()

getgenv().GUI = GUI or {};

function UI:New(gName)
    local ScreenGui = SIMP:NewInstance('ScreenGui', {
        Name = gName,
        Parent = game:GetService('CoreGui'),
    })

    local Folder = SIMP:NewInstance('Folder', {
        Name = 'UI_Holder',
        Parent = ScreenGui
    })

    GUI[gName] = ScreenGui;

    return GUI;
end

function GUI:Destroy(index)
    
    local instance = GUI:Get(index);
    if instance then
        instance:Destroy();
        return true;
    end

    return false;
end

function GUI:Get(n)
    local idx = n or 1;
    local sum = 1;
    local instance;

    if n then
        for k,v in pairs(GUI) do
            if typeof(v) == 'Instance' and type(k) == 'string' then
                instance = v;
            end

            sum = sum + 1

            if idx < sum then
                break;
            end
        end
    else
        for k, v in pairs(GUI) do
            if typeof(v) == 'Instance' and type(k) == 'string' then
                instance = v;
                break;
            end
        end
    end
    return instance
end

function GUI:Setup(options)
    assert(options, 'Please select an option to continue the function.')

    local listOptions = {'loading', 'notification', 'ingame', 'universal', 'settings'}
    local start = (table.concat(listOptions, ' ')):find(options[1]:lower());

    assert(start, 'The options not matched as on list, please select option between on the list')

    --/ because if destroy old gui on setup, when creating notification will destroyed the main thing / like in-game ui

    local gui = GUI:Get();
    local holder_folder = gui:FindFirstChild('UI_Holder');

    tUI = {};
    
    bUI = SIMP:NewInstance('Frame', {
        Parent = holder_folder,
        Name = options[1]:lower(),
        Visible = false
    })

    if options[1]:lower() == 'loading' then
        bUI = SIMP:ChangeProperties(bUI, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BackgroundTransparency = 0.7,
            Size = UDim2.new(0, 300, 0, 250),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })

        table.insert(tUI, bUI)

        local header = SIMP:NewInstance('Frame', {
            Parent = bUI,
            Name = 'Headers',
            Size = UDim2.new(0.9, 0, 0, 30),
            Position = UDim2.new(0.5, 0, 0, 0),
            Draggable = true,
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            BackgroundTransparency = 1
        }, {
            SIMP:NewInstance('TextLabel', {
                Name = 'TitleUI',
                Text = options.Title or 'Untitled',
                TextColor3 = Color3.fromRGB(255, 255, 255),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Draggable = true
            }),
            SIMP:NewInstance('ImageLabel', {
                Name = 'LogoUI',
                Image = 'rbxassetid://7229442422',
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Draggable = true
            })
        })

        local body = SIMP:NewInstance('Frame', {
            Name = 'Body',
            Parent = bUI,
            Size = UDim2.new(0.9, 0, 0.9, 0),
            Position = UDim2.new(0.5, 0, 0.1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 0.8,
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            Draggable = true
        }, {
            SIMP:NewInstance('TextLabel', {
                Name = 'Content',
                Text = 'Please wait...',
                TextColor3 = Color3.fromRGB(255, 255, 255),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Draggable = true
            }),

            SIMP:NewInstance('Frame', {
                Name = 'ProgressBar',
                Size = UDim2.new(0,9, 0, 0, 20),
                Position = UDim2.new(0.9, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                Draggable = true
            }, {
                SIMP:NewInstance('Frame', {
                    Name = 'ProgressValue',
                    Size = UDim2.new(0.5, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(50, 90, 250),
                    Draggable = true
                })
            })
        })

        function tUI:Open()
            --/ Transparent all frames /--
            for _,v in pairs(bUI:GetChildren()) do
                if v:IsA('Frame') then
                    v.Transparency = 0
                end
            end

            --/ Starting opening /--
            bUI.Visible = true;
            wait(1)

            --/ Opening UI /--
            for _,v in pairs(bUI:GetChildren()) do
                if v:IsA('Frame') then
                    coroutine.wrap(coroutine.create(function()
                        game:GetService("TweenService"):Create(v, TweenInfo.new(1), {Transparency = 1}):Play()
                    end))
                end
            end
        end

        function tUI:Close()
            --/ Closing UI /--
            for _, v in pairs(bUI:GetChildren()) do
                if v:IsA('Frame') and v.Transparency == 1 then
                    coroutine.wrap(coroutine.create(function()
                        game:GetService("TweenService"):Create(v, TweenInfo.new(1), {
                            Transparency = 0
                        }):Play()
                    end))
                end
            end

            bUI.Visible = false;
        end

        function tUI:setContent(txt)
            local content = body:FindFirstChild('Content');
            assert(content, 'Unable to get label of Content');
            
            content.text = txt
        end

        function tUI:setProgress(val)
            local progressBar = body:FindFirstChild('ProgressBar')
            local value = progressBar:FindFirstChild('ProgressValue')

            local val = val or 1

            SIMP:ChangeProperties(value, {
                Size = UDim2.new(val, 0, 1, 0);
            })
        end
    end

    return tUI;
end

function UI:Uninstall()
    if #GUI > 0 then
        for k,v in pairs(GUI) do
            if type(v) ~= 'function' then
                if typeof(v) == 'Instance' then
                    local locationInstance = "game:GetService('CoreGui')[\'" .. tostring(k) ..  "\']"

                    --/ Executing from instance location /--
                    loadstring(locationInstance .. ':Destroy()')();

                    print('Destroying', locationInstance)
                else
                    GUI[k] = nil;
                    print('Remove an elements on index:', k)
                end
            end
        end
    else
        print('UI has been uninstalled recently or you never setup the UI?')
    end
end

return UI;