repeat task.wait() until game:IsLoaded();

--/ Simple Code /--
local SIMP = loadstring(game:HttpGet('https://raw.githubusercontent.com/Jexytd/kodok/main/SimpleCode.lua'))()

--/ Authenticator /--
local Auth = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/Auth.lua'))()

--/ UI /--
local UI = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/UI.lua'))()
local kodok = UI:New(game:GetService('HttpService'):GenerateGUID(false))
local UISettings = {
    'keys',
    Title = 'Made by Oyen'
}
local KeyUI = kodok:Setup(UISettings)

if KeyUI then
    KeyUI:Open();

    local connection;
    connection = KeyUI:setFocusLost(function(enterPressed, input)
        if enterPressed then
            local guess = KeyUI:getText();
            if KeyUI.keys.TryAttempt <= 3 then
                if SIMP:isOwn(KeyUI.keys.WrongKeys, guess) then
                    print('You can\'t insert the wrong key twice!')
                    return;
                end

                local checker = Auth(guess);
                if checker ~= 0 then
                    KeyUI.keys.TryAttempt = KeyUI.keys.TryAttempt + 1;
                    table.insert(KeyUI.keys.WrongKeys, guess);
                else
                    KeyUI.keys.akses_granted = true; --/ Easy to bypass :|
                    connection:Disconnect();
                end
            else
                connection:Disconnect();
            end
        end
    end)

    local continue = false;
    local Fail = false;
    repeat task.wait()
        if KeyUI.keys.TryAttempt > 3 then Fail = true; end
        if typeof(KeyUI.keys.akses_granted) == 'boolean' and KeyUI.keys.akses_granted then
            continue = true;
        end
    until continue and KeyUI.keys.TryAttempt <= 3 or Fail;

    KeyUI:Close();

    if Fail then
        print('Unable to access the next step. Requirement not met')
        UI:Uninstall();
        return -1;
    end

    kodok:Destroy()
end

-- / Send discord webhook /--
getgenv().wSend = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/Webhook.lua'))()

--/ Getting Games /--
local ResponseGame = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/GameChecker.lua'))()
local UNIVERSAL = false;
if ResponseGame == 1 then
	return 0;
elseif ResponseGame == -1 then
    return 1;
elseif ResponseGame == 'UNIVERSAL' then
	UNIVERSAL = true;
end

if UNIVERSAL then
    print('You pass all the step!')
end