local LastPlayer, WantDM, WantSpy = {}, {}, {}

RegisterCommand('pm', function(source, args, user)
    if args[1] then
        if(tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
            local xTarget = tonumber(args[1])
            if xTarget == tonumber(source) then
                TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'You cant send message to yourself'}})
            else
                if WantDM[xTarget] == false or WantDM[source] == false then
                    TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'One of the players disabled his private messages.'}})
                else
                    local message = args
                    table.remove(message, 1)
                    if(#message == 0) then
                        TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'You must to type a message'}})
                    else
                        message = table.concat(message, " ")
                        TriggerClientEvent('chat:addMessage', source, {
                        template = "<div style='font-size: calc(2.1vw / 1.77777);display: inline-block;line-height: calc((2.7vw / 1.77777) * 1.2); background-color: rgba(127, 140, 114, 0.5); border-radius: 7px;'><la style='padding: 5px;'><a style='padding: 5px;'>{0}</a><img src='https://cdn0.iconfinder.com/data/icons/thin-communication-messaging/24/thin-0306_chat_message_discussion_bubble_conversation-512.png' style='width:19px;height:15px;'></img></la></div>",
                        args = { ( '^1' .. GetPlayerName(source) .. '(' .. tonumber(source) .. ')^0 to ^2' .. GetPlayerName(xTarget) .. '(' .. xTarget ..')^0 : ' .. message ) }
                        })
                        TriggerClientEvent('chat:addMessage', xTarget, {
                            template = "<div style='font-size: calc(2.1vw / 1.77777);display: inline-block;line-height: calc((2.7vw / 1.77777) * 1.2); background-color: rgba(127, 140, 114, 0.5); border-radius: 7px;'><la style='padding: 5px;'><a style='padding: 5px;'>{0}</a><img src='https://cdn0.iconfinder.com/data/icons/thin-communication-messaging/24/thin-0306_chat_message_discussion_bubble_conversation-512.png' style='width:19px;height:15px;'></img></la></div>",
                            args = { ( '^1' .. GetPlayerName(source) .. '(' .. tonumber(source) .. ')^0 to ^2' .. GetPlayerName(xTarget) .. '(' .. xTarget ..')^0 : ' .. message ) }
                        })
                        for a = 0, GetNumPlayerIndices()-1 do
                            local b = tonumber(GetPlayerFromIndex(a))
                            if WantSpy[b] == true then
                                TriggerClientEvent('chat:addMessage', b, {
                                    template = "<div style='font-size: calc(2.1vw / 1.77777);display: inline-block;line-height: calc((2.7vw / 1.77777) * 1.2); background-color: rgba(127, 140, 114, 0.5); border-radius: 7px;'><la style='padding: 5px;'><a style='padding: 5px;'>{0}</a><img src='https://cdn0.iconfinder.com/data/icons/thin-communication-messaging/24/thin-0306_chat_message_discussion_bubble_conversation-512.png' style='width:19px;height:15px;'></img></la></div>",
                                    args = { ( '^1' .. GetPlayerName(source) .. '(' .. tonumber(source) .. ')^0 to ^2' .. GetPlayerName(xTarget) .. '(' .. xTarget ..')^0 : ' .. message ) }
                                })
                            end
                        end
                        LastPlayer[source] = xTarget
                        LastPlayer[xTarget] =  tonumber(source)
                    end
                end
            end
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'There is no player with id ' .. tonumber(args[1])}})
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'You must to type a player id'}})
    end
end, false)

RegisterCommand('r', function(source, args, user)
    if args[1] then
        if WantDM[LastPlayer[source]] == false or WantDM[source] == false then
            TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'One of the players disabled his private messages.'}})
        else
            local message = args
            message = table.concat(message, " ")
            TriggerClientEvent('chat:addMessage', source, {
                template = "<div style='font-size: calc(2.1vw / 1.77777);display: inline-block;line-height: calc((2.7vw / 1.77777) * 1.2); background-color: rgba(127, 140, 114, 0.5); border-radius: 7px;'><la style='padding: 5px;'><a style='padding: 5px;'>{0}</a><img src='https://cdn0.iconfinder.com/data/icons/thin-communication-messaging/24/thin-0306_chat_message_discussion_bubble_conversation-512.png' style='width:19px;height:15px;'></img></la></div>",
                args = { ( '^1' .. GetPlayerName(source) .. '(' .. tonumber(source) .. ')^0 to ^2' .. GetPlayerName(LastPlayer[source]) .. '(' .. tonumber(LastPlayer[source]) ..')^0 : ' .. message ) }
            })
            TriggerClientEvent('chat:addMessage', LastPlayer[source], {
                    template = "<div style='font-size: calc(2.1vw / 1.77777);display: inline-block;line-height: calc((2.7vw / 1.77777) * 1.2); background-color: rgba(127, 140, 114, 0.5); border-radius: 7px;'><la style='padding: 5px;'><a style='padding: 5px;'>{0}</a><img src='https://cdn0.iconfinder.com/data/icons/thin-communication-messaging/24/thin-0306_chat_message_discussion_bubble_conversation-512.png' style='width:19px;height:15px;'></img></la></div>",
                    args = { ( '^1' .. GetPlayerName(source) .. '(' .. tonumber(source) .. ')^0 to ^2' .. GetPlayerName(LastPlayer[source]) .. '(' .. tonumber(LastPlayer[source]) ..')^0 : ' .. message ) }
            })
        end
    end
end)
RegisterCommand('block', function(source)
    TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'You now turned '.. (WantDM[source] and 'OFF' or 'ON')..' your private messages.'}})
    WantDM[source] = not WantDM[source]
end)

RegisterCommand('spy', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'You now '.. (WantSpy[source] and 'wont following' or 'following')..' the private messages.'}})
        WantSpy[source] = not WantSpy[source]
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^2Messaging System: ', 'You have no access to this command.'}})
    end
end)