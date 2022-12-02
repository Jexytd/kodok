getgenv().CurrentGame = {
    ID = game.PlaceId,
    Config = {}
}

function GetList()
    local _,res = pcall(function()
        return game:HttpGet()
    end)
end