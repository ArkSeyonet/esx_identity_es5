ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function getIdentity(source, callback)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1].firstname ~= nil then
			local data = {
				identifier	= result[1].identifier,
				firstname	= result[1].firstname,
				lastname	= result[1].lastname,
				dateofbirth	= result[1].dateofbirth,
				sex			= result[1].sex,
				height		= result[1].height
			}

			callback(data)
		else
			local data = {
				identifier	= '',
				firstname	= '',
				lastname	= '',
				dateofbirth	= '',
				sex			= '',
				height		= ''
			}

			callback(data)
		end
	end)
end

function setIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function updateIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function deleteIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= '',
		['@lastname']		= '',
		['@dateofbirth']	= '',
		['@sex']			= '',
		['@height']			= ''
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

RegisterServerEvent('esx_identity:setIdentity')
AddEventHandler('esx_identity:setIdentity', function(data, myIdentifiers)
	setIdentity(myIdentifiers.steamid, data, function(callback)
		if callback then
			TriggerClientEvent('esx_identity:identityCheck', myIdentifiers.playerid, true)
			TriggerClientEvent('esx_identity:successfulSetIdentity', data)
		else
			TriggerClientEvent('esx_identity:failedSetIdentity', data)
		end
	end)
end)

AddEventHandler('es:playerLoaded', function(source)
	local myID = {
		steamid = GetPlayerIdentifiers(source)[1],
		playerid = source
	}

	TriggerClientEvent('esx_identity:saveID', source, myID)
	getIdentity(source, function(data)
		if data.firstname == '' then
			TriggerClientEvent('esx_identity:identityCheck', source, false)
			TriggerClientEvent('esx_identity:showRegisterIdentity', source)
		else
			TriggerClientEvent('esx_identity:identityCheck', source, true)
		end
	end)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(3000)

		local xPlayers, xPlayer = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			local myID = {
				steamid  = xPlayer.identifier,
				playerid = xPlayer.source
			}

			TriggerClientEvent('esx_identity:saveID', xPlayer.source, myID)

			getIdentity(xPlayer.source, function(data)
				if data.firstname == '' then
					TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, false)
					TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
				else
					TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, true)
				end
			end)
		end
	end
end)

TriggerEvent('es:addCommand', 'register', function(source, args, user)
	getIdentity(source, function(data)
		if data.firstname ~= '' then
			TriggerClientEvent('esx_identity:registrationBlocked', source, {})
		else
			TriggerClientEvent('esx_identity:showRegisterIdentity', source, {})
		end
	end)
end, {help = "Register a new character"})

TriggerEvent('es:addGroupCommand', 'char', 'user', function(source, args, user)
	getIdentity(source, function(result)
		if result then
			if result.firstname ~= '' then
				identity = {
					firstname = result.firstname,
					lastname  = result.lastname
				}
				TriggerClientEvent('esx_identity:showIdentity', source, identity)
			else
				TriggerClientEvent('esx_identity:noIdentity', source, {})
			end
		else
			TriggerClientEvent('esx_identity:noIdentity', source, {})
		end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient permissions!' } })
end, {help = "Display Your Character Information"})

TriggerEvent('es:addGroupCommand', 'chardel', 'user', function(source, args, user)
	getIdentity(source, function(data)
		if data.firstname ~= '' then
			local data = {
				identifier	= data.identifier,
				firstname	= data.firstname,
				lastname	= data.lastname,
				dateofbirth	= data.dateofbirth,
				sex			= data.sex,
				height		= data.height
			}
			
			deleteIdentity(GetPlayerIdentifiers(source)[1], data, function(callback)
				if callback then
					TriggerClientEvent('esx_identity:successfulDeleteIdentity', source, data)
				else
					TriggerClientEvent('esx_identity:failedDeleteIdentity', source, data)
				end
			end)
		else
			TriggerClientEvent('esx_identity:noIdentity', source, {})
		end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient permissions!' } })
end, {help = "Delete Your Character"})
