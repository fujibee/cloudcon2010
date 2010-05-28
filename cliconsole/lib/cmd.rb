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
    ret = send(cmd, ssh)
  end
  ret
end

def add(ssh)
  ssh.exec!('hostname')
end

