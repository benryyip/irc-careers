#!/usr/bin/env ruby

# An IRC bot that echos everything it gets.
# 
# Author::  Benry Y. (mailto:me@benryyip.com)
# License:: DWTFYWLALAYGCTTRP License
#           or as used in common speech, the "Do Whatever The F*** You Want
#           License As Long As You Give Credit To The Right People" License.

require '../lib/IRCBot.rb'

class EchoBot < IRCBot

    # Given a YAML configuration file, processes and connects to an IRC server.
    def initialize(config_filename)
        super(config_filename)
    end

    # Does the bulk of the work, processes messages that address #{@channel}.
    #
    # Should be overridden by subclasses.
    def bot_main(line)
        puts line
    end

end

# Main "method."
if $0 == __FILE__
    echobot = EchoBot.new("../config/batman.yml")
    trap("INT") { bot.quit }
    echobot.run
end
