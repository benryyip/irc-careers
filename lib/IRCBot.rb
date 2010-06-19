# An IRC bot class that handles the basic IRC commands necessary to build a bot.
# 
# Author::  Benry Y. (mailto:me@benryyip.com)
# License:: DWTFYWLALAYGCTTRP License
#           or as used in common speech, the "Do Whatever The F*** You Want
#           License As Long As You Give Credit To The Right People" License.
# 
# Class inspired (stolen) from http://github.com/kjg/simpleircbot.

require 'socket' # BECAUSE YOU NEED POWER!
require 'yaml'   # Nothing like a good sweet potato in logarithmic space.

# include ERB::Util

class IRCBot

    # USEFUL REGEXES
    CHAN_PRIV_MSG = /:(.*)!.*PRIVMSG #wonted :(.*)$/
    CHAN_MSG = /##{@channel}/
    PING_MSG = /^PING :(.*)$/

    # INSTANCE VARIABLES
    attr_reader :config, :socket
    attr_reader :botname, :channel, :port, :server

    # Given a YAML configuration file, processes and connects to an IRC server.
    def initialize(config_filename)
        unless File.exists?(config_filename)
            puts "ERROR: #{config_filename} isn't a real configuration file."
        end
        
        @config = YAML::load_file(config_filename)
        
        @botname = config['botname']
        @server =  config['server']
        @port =    config['port']
        @channel = config['channel']
        
        @socket = TCPSocket.open(@server, @port)

        connect # to IRC channel
    end

    # Does the bulk of the work, processes messages that address #{@channel}.
    #
    # Should be overridden by subclasses.
    def bot_main(line)
        puts "IRCBot::bot_main called."
    end

    # Connects to an IRC channel.
    def connect
        say "NICK #{@botname}"
        say "USER #{@botname} 0 * #{@botname}"
        say "JOIN ##{@channel}"
    end

    # The main loop.
    #
    # Reads every single message from the IRC server, passes relevant messages
    # along to the bot_main method, which can be overriden by subclasses.
    def run
        until @socket.eof? do
            line = @socket.gets

            # Makes sure your bot doesn't timeout!
            if line.match(PING_MSG)
                say "PONG #{ $~[1]}"
            else
                bot_main(line)
            end

            # Gathers everything that's been sent to #{@channel}
            # if line.match(CHAN_MSG)
            #     bot_main(line)
            # end
        end
    end

    # Says #{msg} to #{@server}.
    def say(msg)
        @socket.puts msg
    end

    # Says #{msg} to #{@channel}.
    def say_to_chan(msg)
        say "PRIVMSG ##{@channel} :#{message}"
    end
end

# Main "method."
if $0 == __FILE__
    puts "Please don't run this class!"
    puts
    puts "The tests aren't baked yet!"

    # TODO:
    # 6/18/10 - Write unit tests.
end
