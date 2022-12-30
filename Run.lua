repeat task.wait() until game:IsLoaded();

--/ Simple Code /--
local SIMP = loadstring(game:HttpGet('https://raw.githubusercontent.com/Jexytd/kodok/main/SimpleCode.lua'))()

--/ Authenticator /--
local ResponseKey = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/Auth.lua'))()
if ResponseKey == 1 then
    return 0;
elseif ResponseKey == -1 then
    return 1;
end

-- / Send discord webhook /--
getgenv().wSend = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/Webhook.lua'))()

--/ Getting Games /--
local ResponseGame = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/GameChecker.lua'))()
local UNIVERSAL = false;
if ResponseGame == 1 then
	return 0;
elseif ResponseGame == 'UNIVERSAL' then
	UNIVERSAL = true;
end

local UI = loadstring(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/UI.lua'))()

local kodok = UI:New('kodok')

local UIconfigs = {
    'Loading',

    Title = 'Oyen Penguasa Dunia'
}
local loader = kodok:Setup(UIconfigs)

if loader then
    loader:Open()

    wait(1)

    print('Ooo ma gaa, is mostly bugging')
    loader:setContent('Vroom...')
    wait(0.1)
    loader:setProgress(0.5)

    wait(1)
    loader:Close();

    kodok:Destroy()
end