function SendWH(URL, TT, DS, CLR)
    assert(URL, 'Unable to continue the function.')
    assert(TT and DS, 'Please insert this arguments, really important on function')
    local EMBED = {
        ['embeds'] = {
            {
                title = TT or '',
                description = DS or '',
                author = {
                    name = 'Sended by ' .. game:GetService("Players").LocalPlayer.Name,
                    icon_url = 'https://www.roblox.com/headshot-thumbnail/image?userId=' .. game:GetService("Players").LocalPlayer.UserId .. '&width=150&height=150&format=png'
                },
                footer = {
                    text = DateTime.now():FormatUniversalTime('LLL', 'en-us')
                },
                color = (type(CLR) == 'string' and ((CLR:match('0x') and tonumber(CLR)) or tonumber(CLR, 16)) ) or tonumber('7DE', 16)
            }
        }
    }
    return request({Url = URL, Method = 'POST', Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(EMBED)})
end

return SendWH