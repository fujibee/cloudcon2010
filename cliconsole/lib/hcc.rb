require 'rubygems'
require 'net/ssh'
require 'net/scp'

require 'util'
require 'cmd'

HOST='cl-stool.starbed.org'
USER='cloudcom008'
PASS=ENV['CLOUDCOM_PASS']

SWARM_JAR='../../swarm-client-1.3-jar-with-dependencies.jar'
