#!/usr/bin/env ruby

# An IRC bot that echos everything it gets.
# 
# Author::  Benry Y. (mailto:me@benryyip.com)
# License:: DWTFYWLALAYGCTTRP License
#           or as used in common speech, the "Do Whatever The F*** You Want
#           License As Long As You Give Credit To The Right People" License.

require 'IRCBot'

class EchoBot < IRCBot

    # Given a hash of settings, processes and connects to an IRC server.
    def initialize(settings)
        super(settings)
    end

    # Does the bulk of the work, processes messages that address #{@channel}.
    #
    # Should be overridden by subclasses.
    def bot_main(line)
        puts line
    end

end

settings = { "botname" => "Batman-bot",
             "server" =>  "irc.rizon.net",
             "port" =>    6667,
             "channel" => "#wontest"
}

echobot = EchoBot.new(settings)
trap("INT") { echobot.quit }
echobot.run
