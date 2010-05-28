#!/usr/bin/env ruby

$:.unshift('lib')
require 'hcc'

command = ARGV.shift
servers = ARGV.shift

unless command and COMMANDS.include? command.to_sym
  usage('not a command')
  exit 1
end

unless servers
  usage('no servers')
  exit 1
end

puts ssh_cmd command
