--/ End Goal: Support on Mobile or Compatible on android / mobile
--[[
    To-do:
        Auto-load / Manual load previous settings / Save ui setting's,
        Creating intro on loader
]]

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
        GUI[instance] = nil;
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

    local listOptions = {'loading', 'notification', 'ingame', 'universal', 'settings', 'keys'}
    local start = (table.concat(listOptions, ' ')):find(options[1]:lower());

    assert(start, 'The options not matched as on list, please select option between on the list')

    local gui = GUI:Get();
    local holder_folder = gui:FindFirstChild('UI_Holder');

    tUI = {
        CanDrag = {},
        FocusUI = false
    };

    function tUI:Get()
        for _,v in pairs(tUI) do
            if type(v) ~= 'function' then
                return v;
            end
        end
    end

    function tUI:OnMouse()
        local baseUI = tUI:Get();
        assert(baseUI, 'Couldn\'t find the base of it')

        local camera = workspace.CurrentCamera;
        local viewportSize = camera.ViewportSize;

        local xPersen = (baseUI.Position.X.Scale / 1) * 100;
        local yPersen = (baseUI.Position.Y.Scale / 1) * 100;

        local x = (xPersen / 100) * viewportSize.X;
        local y = (yPersen / 100) * viewportSize.Y;

        local OffsetX = baseUI.Size.X.Offset;
        local OffsetY = baseUI.Size.Y.Offset;

        local yY = game:GetService('GuiService'):GetGuiInset().Y

        local Point = {
            TL = Vector2.new(x - (OffsetX / 2), (y + (yY / 2)) - (OffsetY / 2)),
            BR = Vector2.new(x + (OffsetX / 2), (y + (yY / 2)) + (OffsetY / 2))
        };

        local RenderStepped;
        RenderStepped = game:GetService('RunService').RenderStepped:Connect(function()
            if baseUI.Parent == nil then
                RenderStepped:Disconnect();
                return;
            end

            local Mouse = game:GetService('Players').LocalPlayer:GetMouse();
            local mX,mY = Mouse.X, Mouse.Y + yY

            if (mX >= Point.TL.X and mX <= Point.BR.X) and (mY >= Point.TL.Y and mY <= Point.BR.Y) then
                tUI.FocusUI = true;
            else
                tUI.FocusUI = false;
            end
        end)
    end

    function tUI:onDrag(frame)
        local baseUI = tUI:Get();

        local dragging,dragInput,dragStart,startPos;
        local UserInputService = game:GetService("UserInputService")

        local function up(input)
            local delta = input.Position - dragStart;
            baseUI.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and tUI.FocusUI then
                dragging = true;
                dragStart = input.Position;
                startPos = frame.Position;

                if not SIMP:IsOwn(tUI.CanDrag, frame) then
                    table.insert(tUI.CanDrag, frame);
                end

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false;
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input;
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
        	if input == dragInput and dragging then
        		up(input)
        	end
        end)
    end
    
    bUI = SIMP:NewInstance('Frame', {
        Parent = holder_folder,
        Name = options[1]:lower(),
        Visible = false
    })

    if options[1]:lower() == 'keys' then
        tUI.keys = {
            TryAttempt = 1,
            WrongKeys = {}
        };

        bUI = SIMP:ChangeProperties(bUI, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 450, 0, 150),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })

        table.insert(tUI, bUI);

        local header = SIMP:NewInstance('Frame', {
            Parent = bUI,
            Name = 'Header',
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Size = UDim2.new(1, 0, 0, 25),
            Position = UDim2.new(0, 0, 0, 0),
            Visible = false
        }, {
            SIMP:NewInstance('TextLabel', {
                Name = 'Title',
                Text = options.Title or 'Made by Oyen',
                TextColor = Color3.fromRGB(255, 255, 255),
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = 0
            })
        })

        local textBox = SIMP:NewInstance('TextBox', {
            Parent = bUI,
            Text = '',
            TextColor = Color3.fromRGB(255, 255, 255),
            Name = 'Input',
            PlaceholderText = 'Insert your key here!',
            ClearTextOnFocus = true,
            Size = UDim2.new(0, 200, 0, 100),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        })

        --/ Frame that can be drag /--
        tUI:onDrag(header);
        tUI:onDrag(bUI);

        function tUI:getText()
            return textBox.Text;
        end

        function tUI:setFocusLost(func)
            if textBox.FocusLost.Connected  then
                textBox.FocusLost:Disconnect();
            end

            local connection;
            connection = textBox.FocusLost:Connect(func);

            return connection;
        end

        function tUI:Open()
            bUI.Transparency = 1;
            for _,v in pairs(bUI:GetChildren()) do
                if v:IsA('Frame') then
                    v.Transparency = 1;
                end
            end

            bUI.Visible = true;

            local ts = game:GetService("TweenService"):Create(bUI, TweenInfo.new(1), {Transparency = 0})
            ts:Play();
            ts.Completed:wait();

            for _,v in pairs(bUI:GetChildren()) do
                if v:IsA('Frame') and not v.Visible then
                    v.Visible = true
                    game:GetService("TweenService"):Create(v, TweenInfo.new(1), {Transparency = 0}):Play()
                end
            end
        end

        function tUI:Close()
            for _,v in pairs(bUI:GetChildren()) do
                if v:IsA('Frame') and v.Transparency == 0 and v.Visible then
                    game:GetService("TweenService"):Create(v, TweenInfo.new(1), {Transparency = 1}):Play()

                    v.Visible = false;
                end
            end

            local ts = game:GetService("TweenService"):Create(bUI, TweenInfo.new(1), {Transparency = 1})
            ts:Play()
            ts.Completed:wait()

            bUI.Visible = false;
        end
    end

    return tUI;
end

function UI:Uninstall()
    for k,v in pairs(GUI) do
        if type(v) ~= 'function' then
            if typeof(v) == 'Instance' then
                local locationInstance = "game:GetService('CoreGui')[\'" .. tostring(k) ..  "\']"

                --/ Executing from instance location /--
                loadstring(locationInstance .. ':Destroy()')();

                print('Remove instance on "', locationInstance, '"')
            else
                GUI[k] = nil;
                print('Remove an elements on index:', k)
            end
        end
    end
    print('UI has been uninstalled!')
end

return UI;