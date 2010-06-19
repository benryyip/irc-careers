#!/usr/bin/env ruby

# A daemon launcher for any IRC bots in ./bots.
# 
# Author::  Benry Y. (mailto:me@benryyip.com)
# License:: DWTFYWLALAYGCTTRP License
#           or as used in common speech, the "Do Whatever The F*** You Want
#           License As Long As You Give Credit To The Right People" License.

require 'daemons'
require 'rubygems'
require 'set'

def usage
    puts "launcher.rb - A daemon manager for your IRC bots."
    puts
    puts "Usage: ./launcher.rb [botname] [command]"
    puts
    puts "Available bots:"
    puts "Echo          A simple bot that just reads all server output."
    puts "Lumberjack    A bot that logs channel activity."
    puts
    puts "Commands:"
    puts "Start         Start a bot."
    puts "Stop          Stops a bot."
    puts "Restart       Stops, then starts a bot."
    puts "Run           Runs a bot as an application, instead of a daemon, duh."
    puts
    puts "Example: ./launcher.rb echo start"
end

if $0 == __FILE__
    # Make sure we can find IRCBot.
    $: << File.expand_path(File.dirname(__FILE__) + "/lib")
    
    # A list of all available commands.
    commands = Set.new ["start", "stop", "restart", "run"]

    # We need two arguments to be cool and hip, like a Mac user at Starbucks.
    unless ARGV.length == 2
        puts "ERROR: Uh, do you know how to count to 2? 2 arguments. 1, 2."
        puts
        usage
        exit
    end
    
    botname = ARGV.shift.downcase # Which bot to manage. We pop this off so that
                                  # daemons can use ARGV.
    command = ARGV[0].downcase    # Start, stop, run, etc.

    # Make sure we're not coming up with commands out of our butt.
    unless commands.include?(command)
        puts "ERROR: That's not a *real* command."
        puts
        usage
        exit
    end

    puts "Telling #{botname} to #{command}."

    # Check to make sure our transformers aren't robots in disguise.
    #
    # N.B. We don't need to define options, because by default, daemons uses
    #      the ARGV array.
    case botname
        when "echo"
        Daemons.run('bots/EchoBot.rb')
        
        else
        puts "ERROR: That bot is imaginary."
        puts
        usage
        exit
    end
end
