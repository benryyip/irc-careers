#!/usr/bin/env ruby

# An IRC bot that logs everything it sees.
# 
# Author::  Benry Y. (mailto:me@benryyip.com)
# License:: DWTFYWLALAYGCTTRP License
#           or as used in common speech, the "Do Whatever The F*** You Want
#           License As Long As You Give Credit To The Right People" License.

require 'IRCBot'

class LogFile
  attr_reader :date, :filename, :file, :logdir, :url

  def initialize(date)
    @logdir = "/home/benryyip/www/benryyip.com/lumberjack-test"

    @date = date
    @filename = "#{@logdir}/#{date}.html"
    @file = File.new(filename, "a")

    @url = "http://benryyip.com/lumberjack-test/#{date}.html"
  end

  def close
    @file.close
  end

  def log(line)
    @file.puts line
    @file.flush
  end
end

class LoggerBot < IRCBot

    attr_reader :logfile

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

settings = {
    "botname" => "Batman-bot",
    "server" =>  "irc.rizon.net",
    "port" =>    6667,
    "channel" => "#wontest"
}

log_settings = {
    "logdir" = "/home/benryyip/www/benryyip.com/lumberjack-logs/test"
    "urlbase" = "http://benryyip.com/lumberjack-logs/test"
}

loggerbot = LoggerBot.new(settings, log_settings)
trap("INT") { loggerbot.quit }
loggerbot.run
