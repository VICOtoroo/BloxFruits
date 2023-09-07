local Players = game:GetService("Players")
local lp = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
local mouse = lp:GetMouse()

local function gettarget(instance)
   for i,v in next, Players:GetPlayers() do
      if v.Character and (instance == v.Character or instance:IsDescendantOf(v.Character)) then
         return true
      end
   end
end

local triggerEnabled = false
local con

local function enableTrigger()
   con = game:GetService("RunService").Heartbeat:Connect(function()
      if triggerEnabled and gettarget(mouse.Target) then
         mouse1press()
         task.wait()
         mouse1release()
      end
   end)
end

local function disableTrigger()
   if con then
      con:Disconnect()
   end
end

-- Adicionar evento de escuta de tecla para "H"
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
   if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
      triggerEnabled = not triggerEnabled
      if triggerEnabled then
         print("TriggerBot ativado")
         game.StarterGui:SetCore("SendNotification", {
            Title = "Universe PVP",
            Text = "Trigger On",
            Icon = "http://www.roblox.com/asset/?id=",
            Duration = 2.5
         })
         enableTrigger()
      else
         print("TriggerBot desativado")
         game.StarterGui:SetCore("SendNotification", {
            Title = "Universe PVP",
            Text = "Trigger Off",
            Icon = "http://www.roblox.com/asset/?id=",
            Duration = 2.5
         })
         disableTrigger()
      end
   end
end)

getgenv().disable = function()
   getgenv().disable = nil
   warn("Disconnecting:",con)
   disableTrigger()
end
