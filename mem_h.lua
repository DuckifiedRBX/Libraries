-- Shortcut 
local Plr = game.Players.LocalPlayer
setmetatable(getrenv(),{

	__index = function(self,k)
		if k == "Char" then return game.Players.LocalPlayer.Character end
		if k == "Plr" then return game.Players.LocalPlayer end
		if k == "RepS" then return game.ReplicatedStorage end
		if k == "RepF" then return game.ReplicatedFirst end
		if k == "Plrs" then return game.Players end
		return rawget(getrenv(),k)
	end


})

getrenv().OnKick = function(AssignedF)
	repeat wait() until game.CoreGui and game.CoreGui:FindFirstChild("RobloxPromptGui") ~= nil
	game.CoreGui.RobloxPromptGui.DescendantAdded:Connect(function(descendant)
	wait(1)
		if descendant:IsA("TextLabel") and descendant.Text:find("You were kicked from this game:") then
			wait(1)
			AssignedF(descendant.Text)
		end
	end)
end


getrenv().trytoget = function(n,Contain,FindWithContainOnly,typeO)
    local ret
    for i,v in next, getgc() do
        if type(v) == "function" and not is_synapse_function(v) then
            local upvs = debug.getupvalues(v)
			if not FindWithContainOnly then
				if upvs[n] and ret == nil then
					if Contain ~= nil then
						if type(Contain) == "table" then
							local succ = 0
							for j,k in pairs(Contain) do
								if upvs[n][k] then
									succ =  succ + 1
								end
							end
							if succ == #Contain then
								ret = upvs[n]
							end
						else
							if upvs[n][Contain] then
								ret = upvs[n]
							end
						end
					else
						ret = upvs[n]
					end
				end
			else
				local succ = 0
				local upv
				for j,k in pairs(Contain) do
					for c,b in next, upvs do
						if type(b) == typeO and b[k] ~= nil then
							succ = succ + 1
							upv = b
						end
					end
				end
				if succ == #Contain and ret == nil then
					ret = upv
				end
			end
        end
    end
    return ret
end

--print(Plrs)
