--[[
    Based on a plugin by topkecleon.
    Copyright 2017 wrxck <matthew@matthewhesketh.com>
    This code is licensed under the MIT. See LICENSE for details.
]]--

local slap = {}

local mattata = require('mattata')

function slap:init(configuration)
    slap.arguments = 'slap <target>'
    slap.commands = mattata.commands(
        self.info.username,
        configuration.command_prefix
    ):command('slap').table
    slap.help = '/slap <target> - Slap someone!'
    slap.slaps = {
        'VICTIM was shot by VICTOR.',
        'VICTIM was pricked to death.',
        'VICTIM walked into a cactus while trying to escape VICTOR.',
        'VICTIM drowned.',
        'VICTIM drowned whilst trying to escape VICTOR.',
        'VICTIM blew up.',
        'VICTIM was blown up by VICTOR.',
        'VICTIM hit the ground too hard.',
        'VICTIM fell from a high place.',
        'VICTIM fell off a ladder.',
        'VICTIM fell into a patch of cacti.',
        'VICTIM was doomed to fall by VICTOR.',
        'VICTIM was blown from a high place by VICTOR.',
        'VICTIM was squashed by a falling anvil.',
        'VICTIM went up in flames.',
        'VICTIM burned to death.',
        'VICTIM was burnt to a crisp whilst fighting VICTOR.',
        'VICTIM walked into a fire whilst fighting VICTOR.',
        'VICTIM tried to swim in lava.',
        'VICTIM tried to swim in lava whilst trying to escape VICTOR.',
        'VICTIM was struck by lightning.',
        'VICTIM was slain by VICTOR.',
        'VICTIM got finished off by VICTOR.',
        'VICTIM was killed by magic.',
        'VICTIM was killed by VICTOR using magic.',
        'VICTIM starved to death.',
        'VICTIM suffocated in a wall.',
        'VICTIM fell out of the world.',
        'VICTIM was knocked into the void by VICTOR.',
        'VICTIM withered away.',
        'VICTIM was pummeled by VICTOR.',
        'VICTIM was fragged by VICTOR.',
        'VICTIM was desynchronized.',
        'VICTIM was wasted.',
        'VICTIM was busted.',
        'VICTIM\'s bones are scraped clean by the desolate wind.',
        'VICTIM has died of dysentery.',
        'VICTIM fainted.',
        'VICTIM is out of usable Pokemon! VICTIM whited out!',
        'VICTIM is out of usable Pokemon! VICTIM blacked out!',
        'VICTIM whited out!',
        'VICTIM blacked out!',
        'VICTIM says goodbye to this cruel world.',
        'VICTIM got rekt.',
        'VICTIM was sawn in half by VICTOR.',
        'VICTIM died. I blame VICTOR.',
        'VICTIM was axe-murdered by VICTOR.',
        'VICTIM\'s melon was split by VICTOR.',
        'VICTIM was sliced and diced by VICTOR.',
        'VICTIM was split from crotch to sternum by VICTOR.',
        'VICTIM\'s death put another notch in VICTOR\'s axe.',
        'VICTIM died impossibly!',
        'VICTIM died from VICTOR\'s mysterious tropical disease.',
        'VICTIM escaped infection by dying.',
        'VICTIM played hot-potato with a grenade.',
        'VICTIM was knifed by VICTOR.',
        'VICTIM fell on his sword.',
        'VICTIM ate a grenade.',
        'VICTIM\'s parents got shot by VICTOR.',
        'VICTIM practiced being VICTOR\'s clay pigeon.',
        'VICTIM is what\'s for dinner!',
        'VICTIM was terminated by VICTOR.',
        'VICTIM was shot before being thrown out of a plane.',
        'VICTIM was not invincible.',
        'VICTIM has encountered an error.',
        'VICTIM died and reincarnated as a goat.',
        'VICTOR threw VICTIM off a building.',
        'VICTIM is sleeping with the fishes.',
        'VICTIM got a premature burial.',
        'VICTOR replaced all of VICTIM\'s music with Nickelback.',
        'VICTOR spammed VICTIM\'s email.',
        'VICTOR cut VICTIM\'s genitals off with a rusty pair of scissors!',
        'VICTOR made VICTIM a knuckle sandwich.',
        'VICTOR slapped VICTIM with pure nothing.',
        'VICTOR hit VICTIM with a small, interstellar spaceship.',
        'VICTIM was quickscoped by VICTOR.',
        'VICTOR put VICTIM in check-mate.',
        'VICTOR RSA-encrypted VICTIM and deleted the private key.',
        'VICTOR put VICTIM in the friendzone.',
        'VICTOR molested VICTIM in a shed.',
        'VICTOR slaps VICTIM with a DMCA takedown request!',
        'VICTIM became a corpse blanket for VICTOR.',
        'Death is when the monsters get you. Death comes for VICTIM.',
        'Cowards die many times before their death. VICTIM never tasted death but once.',
        'VICTIM died of hospital gangrene.',
        'VICTIM got a house call from Doctor VICTOR.',
        'VICTOR beheaded VICTIM.',
        'VICTIM got stoned...by an angry mob.',
        'VICTOR sued the pants off VICTIM.',
        'VICTIM was impeached.',
        'VICTIM was beaten to a pulp by VICTOR.',
        'VICTIM was forced to have cheeky bum sex with VICTOR!',
        'VICTIM was one-hit KO\'d by VICTOR.',
        'VICTOR sent VICTIM to /dev/null.',
        'VICTOR sent VICTIM down the memory hole.',
        'VICTIM was a mistake.',
        'VICTIM is a failed abortion.',
        'VICTIM\'s birth certificate is just an apology letter from their local condom dispensary.',
        '\'VICTIM was a mistake.\' - VICTOR',
        'VICTOR checkmated VICTIM in two moves.',
        'VICTIM was brutally raped by VICTOR.'
    }
end

function slap:on_message(message)
    local input = mattata.input(message.text)
    local victor = ''
    local victim = ''
    if not input then
        if message.reply_to_message then
            victor = message.from.first_name:gsub('%%', '%%%%')
            victim = message.reply_to_message.from.first_name:gsub('%%', '%%%%')
        else
            victor = self.info.first_name:gsub('%%', '%%%%')
            victim = message.from.first_name:gsub('%%', '%%%%')
        end
    else
        victor = message.from.first_name:gsub('%%', '%%%%')
        victim = input:gsub('%%', '%%%%')
        local success = mattata.get_chat_pwr(input)
        if success and success.result.type == 'private' then
            victim = success.result.first_name:gsub('%%', '%%%%')
        end
    end
    local output = slap.slaps[math.random(#slap.slaps)]
    output = output:gsub('VICTIM', victim):gsub('VICTOR', victor)
    return mattata.send_message(
        message.chat.id,
        output
    )
end

return slap