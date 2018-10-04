local patreonLevels =  {
	--["76561198054179075"] = 1, -- Darklord
	["76561198047011112"] = 1, -- https://www.patreon.com/user?u=13950990
	["76561197969637836"] = 1, -- https://www.patreon.com/user?u=13950995
	["76561198055263275"] = 1, -- https://www.patreon.com/user?u=4469824
}

function GetPlayerPatreonLevel(playerId)
	local steamId = tostring(PlayerResource:GetSteamID(playerId))
	return patreonLevels[steamId] or 0
end

CustomNetTables:SetTableValue("game_state", "patreons", patreonLevels)
