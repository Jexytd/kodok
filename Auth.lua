assert(getgenv().WL, 'Key aren\'t assigned properly. Please add key before executing!')

function CheckKey(str, total)
	assert(total, 'Can\'t continue the process')
	print('Starting decryption the key...')
	local alphabet = {}
	local numbers = {}

	local only_chars = str:gsub('%d+', ''):gsub('==', '');
	for I = 1, #only_chars do
		local c = only_chars:sub(I,I)
		table.insert(alphabet, c)
	end

	--/ Find single number /--
	for c in string.gmatch(str, '==%d') do
		table.insert(numbers, tonumber(c:match('%d')))
	end

	--/ Find number, except single /--
	local only_num = str:gsub('%a+', ''):gsub('==%d', '')
	repeat
		local Wanted = only_num:match('%d%d');
		local S,E = only_num:find('%d%d');
		table.insert(numbers, tonumber(Wanted))
		only_num = only_num:sub(0, S-1) .. only_num:sub(E+1, #only_num)
	until #only_num <= 0

	local sums = 0;
	for _,v in pairs(alphabet) do
		local byte_t = v:byte();
		sums = sums + byte_t;
	end

	for _,v in pairs(numbers) do
		sums = sums + v;
	end

	if sums == total then
		return sums
	else
		return -1
	end
	return
end

local SIMP = loadstring(game:HttpGet('https://raw.githubusercontent.com/Jexytd/kodok/main/SimpleCode.lua'))()

local KeyLength = game:GetService('HttpService'):JSONDecode(SIMP:Get('https://raw.githubusercontent.com/Jexytd/Oyen/main/setup.json'))['keyLength']
local b = CheckKey(getgenv().WL, KeyLength);

if KeyLength then
	if b == KeyLength then
		return 0;
	end
	if b == -1 then
		return 1;
	end
	if b == nil then
		return -1;
	end
end

return -1;