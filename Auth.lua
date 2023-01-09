local SIMP = loadstring(game:HttpGet('https://raw.githubusercontent.com/Jexytd/kodok/main/SimpleCode.lua'))()

return (function(str)

	local alphabet = {}
	local numbers = {}

	local only_chars = str:gsub('%d+', ''):gsub('==', '');
	if #only_chars > 0 then
		for I = 1, #only_chars do
			local c = only_chars:sub(I,I)
			table.insert(alphabet, c)
		end
	end

	--/ Find single number /--
	for c in string.gmatch(str, '==%d') do
		table.insert(numbers, tonumber(c:match('%d')))
	end

	--/ Find number, except single /--
	local only_num = str:gsub('%a+', ''):gsub('==%d', '')
	if type(tonumber(only_num)) == 'number' then
		repeat
			local Wanted = only_num:match('%d%d');
			local S,E = only_num:find('%d%d');
			table.insert(numbers, tonumber(Wanted))
			if S and E then
				only_num = only_num:sub(0, S-1) .. only_num:sub(E+1, #only_num)
			end
		until #only_num <= 0
	end

	local sums = 0;
	if #alphabet > 0 then
		for _,v in pairs(alphabet) do
			local byte_t = v:byte();
			sums = sums + byte_t;
		end
	end

	if #numbers > 0 then
		for _,v in pairs(numbers) do
			sums = sums + v;
		end
	end

	local length = game:GetService('HttpService'):JSONDecode(SIMP:Get('https://raw.githubusercontent.com/Jexytd/Oyen/main/setup.json'))['keyLength']
	if sums == length then
		print('Inputed key are correct!')
		return sums
	else
		print('Input key incorrect, please generate new key')
		return -1
	end
end)