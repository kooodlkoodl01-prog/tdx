-- TDX Webhook Main Script - GitHub Safe Version
local HttpService = game:GetService("HttpService")
local Player = game.Players.LocalPlayer
local Interface = Player.PlayerGui:WaitForChild("Interface", 30)
local req = request or http_request or syn and syn.request
local sent = false

local function send(msg)
    if not req then return end
    pcall(function()
        req({
            Url = Webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(msg)
        })
    end)
end

local GameOver = Interface:WaitForChild("GameOverScreen", 60)
local Main = GameOver:WaitForChild("Main", 10)
local VictoryText = Main:WaitForChild("VictoryText", 5)
local InfoFrame = Main:WaitForChild("InfoFrame", 10)

GameOver:GetPropertyChangedSignal("Visible"):Connect(function()
    if GameOver.Visible and not sent then
        sent = true
        wait(3)

        local isWin = VictoryText.Visible
        local result = isWin and "VICTORY" or "DEFEATED"

        local xp, gold = "+0", "+0"
        local RewardsFrame = Main:FindFirstChild("RewardsFrame")
        if RewardsFrame then
            local Inner = RewardsFrame:FindFirstChild("InnerFrame")
            if Inner then
                local xpL = Inner:FindFirstChild("XP")
                if xpL and xpL:FindFirstChild("TextLabel") then xp = xpL.TextLabel.Text:gsub("^%s*(.-)%s*$", "%1") end
                local goldL = Inner:FindFirstChild("Gold")
                if goldL and goldL:FindFirstChild("TextLabel") then gold = goldL.TextLabel.Text:gsub("^%s*(.-)%s*$", "%1") end
            end
        end

        local mapName  = InfoFrame.Map.Text:match("^Map: (.*)") or InfoFrame.Map.Text
        local modeName = InfoFrame.Mode.Text:match("^Mode: (.*)") or InfoFrame.Mode.Text
        local timeText = InfoFrame.Time.Text

        local ping = math.round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        local start = tick()
        local frames = 0
        local conn = game:GetService("RunService").Heartbeat:Connect(function() frames += 1 end)
        wait(0.8)
        conn:Disconnect()
        local fps = math.round(frames / (tick() - start))

        local embed = {
            title = "Tower Defense X",
            description =
                ("||**%s**||\n\n"):format(Player.Name) ..
                ("**Result**\n"):format() ..
                ("%s - **%s**\n\n"):format(mapName, result) ..
                ("• Time: `%s`\n"):format(timeText) ..
                ("• Difficulty: `%s`\n\n"):format(modeName) ..
                ("**Reward**\n"):format() ..
                ("• %s Gold\n"):format(gold) ..
                ("• %s Exp\n\n"):format(xp) ..
                ("**Setting**\n"):format() ..
                ("• fps/ping: `%d/%dms`"):format(fps, ping),
            color = isWin and 5767168 or 15548928,
            footer = {text = "discord.gg/AnhEmToi"},
            timestamp = DateTime.now():ToIsoDate()
        }

        send({embeds = {embed}})
    elseif not GameOver.Visible then
        sent = false
    end
end)