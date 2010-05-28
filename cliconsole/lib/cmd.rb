COMMANDS = [
  :launch,  # add + start
  :add,     # copy swarm jar
  :start,   # kick swarm
  :clear,   # stop + delete
  :stop,    # kill swarm process
  :delete,  # remove hadoop dir
  :test     # for test
]

# execute command on ssh
def add(servers)
  puts ">> add jar to #{servers}"
  Net::SCP.upload!(HOST, USER, SWARM_JAR, '~/', :password => PASS)
end

def test(servers)
  puts ">> test to #{servers}"
  ret = ''
  Net::SSH.start(HOST, USER, :password => PASS) do |ssh|
    ret = ssh.exec!('hostname')
  end
  ret
end

