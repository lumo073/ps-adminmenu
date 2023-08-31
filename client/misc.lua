-- Change resource state
RegisterNUICallback("setResourceState", function(data, cb)
	local resources = lib.callback.await('ps-adminmenu:callback:ChangeResourceState', false, data)
	cb(resources)
end)

-- Get players
RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('ps-adminmenu:callback:GetPlayers', false)
	cb(players)
end)

-- Toggles Invincibility
local visible = true
RegisterNetEvent('ps-adminmenu:client:ToggleInvisible', function(data)
	if not CheckPerms(data.perms) then return end

	visible = not visible

	SetEntityVisible(cache.ped, visible, 0)
end)

-- Gode Mode
local godmode = false
RegisterNetEvent('ps-adminmenu:client:ToggleGodmode', function(data)
	if not CheckPerms(data.perms) then return end

	godmode = not godmode

	SetPlayerInvincible(cache.playerId, godmode)
end)

-- Toggle Handcuffs
RegisterNetEvent('ps-adminmenu:client:ToggleCuffs', function(data, selectedData)
	if not CheckPerms(data.perms) then return end
	local player = selectedData["Player"].value
	local playerId = GetPlayerServerId(player)

	TriggerEvent("police:client:GetCuffed", playerId)
end)

-- Copy Coordinates
local function CopyCoords(data)
    local coords = GetEntityCoords(cache.ped)
	local heading = GetEntityHeading(cache.ped)
    local formats = { vector2 = "%.2f, %.2f", vector3 = "%.2f, %.2f, %.2f", vector4 = "%.2f, %.2f, %.2f, %.2f", heading = "%.2f" }
    local format = formats[data]

	local values = {coords.x, coords.y, coords.z, heading}
	lib.setClipboard(string.format(format, table.unpack(values, 1, #format)))
end

RegisterCommand("vector2", function()
	CopyCoords("vector2")
end, false)

RegisterCommand("vector3", function()
	CopyCoords("vector3")
end, false)

RegisterCommand("vector4", function()
	CopyCoords("vector4")
end, false)

RegisterCommand("heading", function()
	CopyCoords("heading")
end, false)
