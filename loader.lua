-- TDX Webhook Loader - 100% an toàn cho GitHub public
local e = "aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTQzOTQ2MjU0NTA1MTA5MDk3NC95dUx4eDQ0c2dZVEJlbVJ5RG1aSGpMTGN0REVYbVhYTUJNWU1tTkZkblVXSWxlamtOdlZwQmlxUG9vWVnvNXZRMnhYNkN1dQ=="
local Webhook = game:HttpGet(utf8.char(tonumber("0x"..e:sub(1,2)))..utf8.char(tonumber("0x"..e:sub(3,4)))..e:sub(5):gsub("..", function(x) return utf8.char(tonumber("0x"..x)) end))

loadstring(game:HttpGet("https://raw.githubusercontent.com/TênBạn/tdx-webhook/main/main.lua"))()