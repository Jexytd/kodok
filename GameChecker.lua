local SIMP = loadstring(game:HttpGet('https://raw.githubusercontent.com/Jexytd/kodok/main/SimpleCode.lua'))()

local GameList = game:GetService('HttpService'):JSONDecode(SIMP:Get('https://raw.githubusercontent.com/Jexytd/kodok/main/Games/List.json'))

local INDEXs = 1;
function RightGame(p1)
	local set;
    repeat
        local cTable = GameList[INDEXs]
        local tGameId = table.concat(cTable.ID, ' ')
		if tGameId:find(tostring(p1)) then
			set = INDEXs;
		end
		INDEXs = INDEXs + 1
    until INDEXs == #GameList
	if INDEXs ~= #GameList then
		return 1;
	end

	if set then 
		INDEXs = set; 
		return GameList[INDEXs];
	else
		return 'UNIVERSAL';
	end
end

local ResponseCheck = RightGame(game.PlaceId);
if ResponseCheck == 1 then
	return 0;
elseif ResponseCheck == 'UNIVERSAL' then
	return 'UNIVERSAL';
end

local GameStatus = {
	Name = ResponseCheck.NAMA,
	Script = ResponseCheck.SOURCE;
}

coroutine.wrap(coroutine.create(function()
	local _str = '';
	for k,v in pairs(ResponseCheck.CREATOR) do
		if k == 'USERID' and type(v) == 'number' then
			local userid = tostring(v);
			local response = request({Url = 'https://users.roblox.com/v1/users/' .. userid; Method = 'GET', Header = { ["Content-Type"] = "application/json" } })

			if response then
				_str = response
			end
		end

		if k == 'GROUPID' and type(v) == 'number' then
			local groupid = v;
			local group = game:GetService("GroupService"):GetGroupInfoAsync(groupid);

			if type(group) == 'table' and group.Id == groupid then
				_str = group.Name
				break;
			end
		end
	end

	GameStatus.Creator = _str;
end))

for _,v in pairs(GameStatus) do
	if (not v or v == '') then return -1 end;
end

return GameStatus;