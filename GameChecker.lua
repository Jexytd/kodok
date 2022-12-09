getgenv().CurrentGame = {
    ID = game.PlaceId,
    Config = {}
}

function GetList()
    local _,res = pcall(function()
        return game:HttpGet('https://raw.githubusercontent.com/Jexytd/kodok/main/Games/List.json', true)
    end)
    if _ and #res > 0 then
        return game:GetService("HttpService"):JSONDecode(res)
    end
    return false
end

local List = GetList();

local function C(A,B)
    return A == B or false
end

local start = os.time();

for _,t in pairs(List) do
    if #t.ID > 0 then
        for _,id in pairs(t.ID) do
            if C(getgenv().CurrentGame, id) then
                print('==== GAME DITEMUKAN ====')
                print('NAMA:', t.NAMA)
                print('ID:', unpack(t.ID))
                print('CREATOR:', t.CREATOR)
                print('========================')

                getgenv().CurrentGame.Source = t.SOURCE
                break;
            end
        end
    end
end

local done = os.time();
print('GameChecker selesai! elama, ', done - start)