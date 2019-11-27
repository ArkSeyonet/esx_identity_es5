ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetIdentity(source, callback)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1].firstname ~= nil then
			local data = {
				firstname	= result[1].firstname,
                lastname	= result[1].lastname,
                dateofbirth = result[1].dateofbirth,
                sex         = result[1].sex,
                height      = result[1].height

			}

			callback(data)
		else
			local data = {
				firstname	= '',
                lastname	= '',
                dateofbirth = '',
                sex         = '',
                height      = ''
			}

			callback(data)
		end
	end)
end

function SetFirstName(identifier, firstName)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= firstName
	})
end

function SetLastName(identifier, lastName)
	MySQL.Async.execute('UPDATE `users` SET `lastname` = @lastname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@lastname']		= lastName
	})
end

function SetDOB(identifier, dob, callback)
	MySQL.Async.execute('UPDATE `users` SET `dateofbirth` = @dateofbirth WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@dateofbirth']	= dob
	})
end

function SetSex(identifier, sexValue)
	MySQL.Async.execute('UPDATE `users` SET `sex` = @sex WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@sex']		    = sexValue
	})
end

function SetHeight(identifier, height)
	MySQL.Async.execute('UPDATE `users` SET `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@height']		    = height
	})
end

AddEventHandler('es:playerLoaded', function(source)
	Wait(2000)

	GetIdentity(source, function(data)
		if data.firstname == '' or data.firstname == nil then
            TriggerClientEvent('esx_identity:ShowFirstNameRegistration', source)
        elseif data.lastname == '' or data.lastname == nil then
			TriggerClientEvent('esx_identity:ShowLastNameRegistration', source) 
		elseif data.dateofbirth == '' or data.dateofbirth == nil then
			TriggerClientEvent('esx_identity:ShowDOBRegistration', source)     
		elseif data.sex == '' or data.sex == nil then
			TriggerClientEvent('esx_identity:ShowSexRegistration', source)
		elseif data.height == '' or data.height == nil then
			TriggerClientEvent('esx_identity:ShowHeightRegistration', source)
		else
			TriggerClientEvent('esx_identity:RegistrationSuccessful', source)                            
		end
	end)
end)

RegisterServerEvent('esx_identity:SetFirstName')
AddEventHandler('esx_identity:SetFirstName', function(ID, firstName)
    local identifier = ESX.GetPlayerFromId(ID).identifier

    SetFirstName(identifier, firstName)
end)

RegisterServerEvent('esx_identity:SetLastName')
AddEventHandler('esx_identity:SetLastName', function(ID, lastName)
    local identifier = ESX.GetPlayerFromId(ID).identifier

    SetLastName(identifier, lastName)
end)

RegisterServerEvent('esx_identity:SetDOB')
AddEventHandler('esx_identity:SetDOB', function(ID, dob)
    local identifier = ESX.GetPlayerFromId(ID).identifier

    SetDOB(identifier, dob)
end)

RegisterServerEvent('esx_identity:SetSex')
AddEventHandler('esx_identity:SetSex', function(ID, sexValue)
    local identifier = ESX.GetPlayerFromId(ID).identifier

    SetSex(identifier, sexValue)  
end)

RegisterServerEvent('esx_identity:SetHeight')
AddEventHandler('esx_identity:SetHeight', function(ID, height)
    local identifier = ESX.GetPlayerFromId(ID).identifier

    SetHeight(identifier, height)
end)