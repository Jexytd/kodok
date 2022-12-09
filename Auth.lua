

local MyKey = math.floor(os.clock())
local sub = {}

local byte = {};
for i = ('a'):byte(), ('z'):byte() do
	table.insert(byte, i)
end
for i = ('A'):byte(), ('Z'):byte() do
	table.insert(byte, i)
end

table.sort(byte)

print('STARTED KEY:',MyKey, '\nLOWEST BYTE:', byte[1], '\nHIGHEST BYTE:', byte[#byte])

local n = MyKey
repeat task.wait() -- Avoid crash
	local max_byte = math.clamp(n, 1, 122)
	local rm = math.random(1, max_byte);
	table.insert(sub, rm);

	n = n - rm;
until n <= 0;

print('Subtraction are done!')
print('Found ', #sub, 'elements on the table!')

function EncryptToStr(tbl)
	local str_storage = '';
	for _,num in pairs(tbl) do
		if table.find(byte, num) then
			str_storage = str_storage .. string.char(num);
		else
			if num >= 10 then
				str_storage = str_storage .. tostring(num);
			else
				str_storage = str_storage .. '==' .. tostring(num)
			end
		end
	end
	return str_storage
end

function DecryptStrToNum(str, total)
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
	repeat task.wait()
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
        print('Found about ', #alphabet, 'characters on key')
        print('Found about ', #numbers, 'numbers on key')
		print('Decryption is succeeded!')
		return sums
	else
		print('Failed to process the encryption, the value not same as the key!')
		return -1
	end
	return
end

local result = EncryptToStr(sub)
print('Key generated:', result)

local decimal = DecryptStrToNum(result, MyKey)
print('TOTAL:', decimal)