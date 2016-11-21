local ispwned = {}
local HTTPS = require('ssl.https')
local URL = require('socket.url')
local JSON = require('dkjson')
local mattata = require('mattata')

function ispwned:init(configuration)
	ispwned.arguments = 'ispwned <username/email>'
	ispwned.commands = mattata.commands(self.info.username, configuration.commandPrefix):c('ispwned').table
	ispwned.help = configuration.commandPrefix .. 'ispwned <username/email> - Tells you if the given username/email has been identified in any data leaks.'
end

function ispwned:onMessageReceive(message, configuration, language)
	local input = mattata.input(message.text)
	if not input then
		mattata.sendMessage(message.chat.id, ispwned.help, nil, true, false, message.message_id)
		return
	end
	local jstr, res = HTTPS.request(configuration.apis.ispwned .. URL.escape(input))
	if res ~= 200 then
		mattata.sendMessage(message.chat.id, language.errors.connection, nil, true, false, message.message_id)
		return
	end
	local jdat = JSON.decode(jstr)
	local output, summary
	for n in pairs(jdat) do
		if n == 1 then
			summary = '*' .. language.foundOnePwnedAccount .. ':*\n'
			output = mattata.markdownEscape(jdat[n].Title)
		else
			summary = '*' .. language.accountFoundMultipleLeaks:gsub('X', #jdat) .. ':*\n'
			output = output .. mattata.markdownEscape(jdat[n].Title)
		end
		if n < #jdat then
			output = output .. '\n'
		end
	end
	mattata.sendMessage(message.chat.id, summary .. '\n' .. output, 'Markdown', true, false, message.message_id)
end

return ispwned