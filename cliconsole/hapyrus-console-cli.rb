#!/usr/bin/env ruby

require 'rubygems'
require 'net/ssh'

HOST='cl-stool.starbed.org'
USER='cloudcom008'
PASS=ENV['CLOUDCOM_PASS']

#if ARGV.size < 2
  puts "USAGE: #{$0} command args"
#  exit 1
#end
command = ARGV.shift

COMMANDS = [
  :launch,  # add + start
  :add,     # copy swarm jar
  :start,   # kick swarm
  :clear,   # stop + delete
  :stop,    # kill swarm process
  :delete   # remove hadoop dir
]

# execute command on ssh
def ssh_cmd(cmd)
  ret = ''
  Net::SSH.start(HOST, USER, :password => PASS) do |ssh|
    ret = ssh.exec! cmd
  end
  ret
end

