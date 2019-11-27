local MaxMagnitudeDifference = 100 -- This value represents the max value of the magnitude difference

local MaxCounterValue = 3 -- This value represents the max value how many times can script caught player as exploiting


--
--               _   _      _                      _   _     _______   _                       _   
--    /\        | | (_)    ( )         /\         | | (_)   |__   __| | |                     | |  
--   /  \   _ __| |_ _  ___|/ ___     /  \   _ __ | |_ _ ______| | ___| | ___ _ __   ___  _ __| |_ 
--  / /\ \ | '__| __| |/ __| / __|   / /\ \ | '_ \| __| |______| |/ _ \ |/ _ \ '_ \ / _ \| '__| __|
-- / ____ \| |  | |_| | (__  \__ \  / ____ \| | | | |_| |      | |  __/ |  __/ |_) | (_) | |  | |_ 
--/_/    \_\_|   \__|_|\___| |___/ /_/    \_\_| |_|\__|_|      |_|\___|_|\___| .__/ \___/|_|   \__|
--                                                                           | |                   
--                                                                           |_|                   
--

--  Artic's Anti-Teleport is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.

--  Artic's Anti-Teleport is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.

--  You should have received a copy of the GNU General Public License
--  along with Artic's Anti-Teleport. If not, see <https://www.gnu.org/licenses/>.

game:GetService("Players").PlayerAdded:Connect(function(player)
	local LocalPlayerPosition = Instance.new("IntValue") -- This is just a value without any special meaning
	LocalPlayerPosition.Parent = script
	LocalPlayerPosition.Name = player.Name.."Position"
	
	local Counter = Instance.new("IntValue") -- This Value represents caughts from server value
	Counter.Parent = script[player.Name.."Position"]
	Counter.Name = "Counter"
	
	
	local Timer = Instance.new("IntValue") -- This is a timer counter
	Timer.Parent = script[player.Name.."Position"]
	Timer.Name = "Time"
	
	player.CharacterAdded:Connect(function(character)
		
       local function WeldToHuman(A,B)  --Attach Part for some reasons of any HumanoidRootPart exploiting
        B.CFrame = A.CFrame
        local  Weld = Instance.new("Weld")
        Weld.Part0 = A
        Weld.C0 = A.CFrame:Inverse()
        Weld.Part1 = B
        Weld.C1 = B.CFrame:Inverse()
        Weld.Parent = A
        return Weld
       end

        WeldToHuman(character:FindFirstChild("HumanoidRootPart"),Instance.new("Part",character))
        character:WaitForChild("Part").Transparency = 1
        character:WaitForChild("Part").Locked = true
		
		while true do
		 Timer.Value = Timer.Value + 1
			local function YaxisExists()
               if (character:FindFirstChild('HumanoidRootPart')) ~= nil then --Check if HumanoidRootPart exists in player
                 return "HumanoidRootPartExists" -- Return string that HumanoidRootPart exists
              else
	           if (character:FindFirstChild("Part")) ~= nil then --Check if Part exists in player
	             return "PartExists" -- Return string that part exists
	           end
  	        end
           return false -- Return false which means no-one of those exists
          end

          local success, message = pcall(YaxisExists)
		
	if success ~= false then	-- If none of these is true then automatically kick him from game
		if message == "HumanoidRootPartExists" then	 --If HumanoidRootPart exists do
		  local LocalPositionBefore = character:FindFirstChild("HumanoidRootPart").Position --Get player position before
		  wait(5)
		  local LocalPositionAfter = character:FindFirstChild("HumanoidRootPart").Position -- Get player position after
		
		  local Mag = (LocalPositionBefore-LocalPositionAfter).Magnitude--Get the magnitude
	   	print(Mag)
		   if Mag >= MaxMagnitudeDifference then -- if magnitude is higher than our variable go next
			  Counter.Value = Counter.Value + 1
			 if Counter.Value >= MaxCounterValue then -- if server caughts are higher or equal to our variable go next
				if (Counter.Value/Timer.Value) <= 50 then -- if caughts devided by in game time is lower or equal to 50% go next
				   if character:FindFirstChild("Humanoid").FloorMaterial ~= Enum.Material.Air then -- Prevent roblox physics flungs
				 warn("Player: "..player.Name.."was caught teleporting")
				 script[player.Name.."Position"]:Destroy()
				 player:kick("Player: "..player.Name.. " was caught exploiting")
				 break
				else
					Counter.Value = 0 -- if caughts devided by in game time is not lower or equals to 50% set caughts to 0
				   end
				end
			 end     
		   end
		   if message == "PartExists" then	-- if Part exists
			local LocalPositionBefore = character:FindFirstChild("Part").Position --Get part position before
			wait(5)
            local LocalPositionAfter = character:FindFirstChild("Part").Position -- Get part position after
		
		    local Mag = (LocalPositionBefore-LocalPositionAfter).Magnitude --Calculate the magnitude
		    
		     if Mag >= MaxMagnitudeDifference then-- if magnitude is higher than our variable go next
			   Counter.Value = Counter.Value + 1
			  if Counter.Value >= MaxCounterValue then -- if server caughts are higher or equal to our variable go next
				 if (Counter.Value/Timer.Value) <= 50 then -- if caughts devided by in game time is lower or equal to 50% go next
				   if character:FindFirstChild("Humanoid").FloorMaterial ~= Enum.Material.Air then -- Prevent roblox physics flungs
				   warn("Player: "..player.Name.."was caught teleporting")
				   script[player.Name.."Position"]:Destroy()
				   player:kick("Player: "..player.Name.. " was caught exploiting")
				   break
				 else
					Counter.Value = 0 -- if caughts devided by in game time is not lower or equals to 50% set caughts to 0
				end
			   end
			  end     
		     end
		   end
		  end
	        else
	          warn("Player: "..player.Name.."was caught teleporting")
	          script[player.Name.."Position"]:Destroy()
	          player:kick("Player: "..player.Name.. " was caught exploiting")
	          break
	        end
		end
	end)
end)
