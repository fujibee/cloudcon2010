COMMANDS = [
  :launch,  # add + start
  :add,     # copy swarm jar
  :start,   # kick swarm
  :clear,   # stop + delete
  :stop,    # kill swarm process
  :delete,  # remove hadoop dir
  :test     # for test
]

def add(server)
  puts ">> add jar to #{server}"
  Net::SCP.start(server, USER, :password => PASS) do |scp|
    scp.upload!(SWARM_JAR, SWARM_JAR)
  end
end

def start(server)
  puts ">> start swarm jar to #{server}"
  this_host = `hostname`.chomp
  Thread.new do
    Net::SSH.start(server, USER, :password => PASS) do |ssh|
      ssh.exec!("nohup java -jar #{SWARM_JAR} -master #{this_host} &")
    end
  end
  sleep 1 # wait to send
end

def launch(server)
  puts ">> launch slave to #{server}"
  add(server)
  start(server)
end

def stop(server)
  puts ">> stop slave on #{server}"
  Net::SSH.start(server, USER, :password => PASS) do |ssh|
    ssh.exec!("ps aux|grep java|grep -v grep|xargs kill -9")
  end
end

def delete(server)
  puts ">> stop slave on #{server}"
  Net::SSH.start(server, USER, :password => PASS) do |ssh|
    ssh.exec!("rm -rf hadoop")
    ssh.exec!("rm -f #{SWARM_JAR}")
  end
end

def clear(server)
  puts ">> stop slave on #{server}"
  stop(server)
  delete(server)
end

def test(server)
  puts ">> test to #{server}"
  Net::SSH.start(server, USER, :password => PASS) do |ssh|
    p ret = ssh.exec!("hostname")
  end
end

def ssh(host, cmd)
  print <<-`EOC`
    expect -c "
    set timeout 5
    spawn ssh #{USER}:#{host}
    expect "password:"
    send "#{PASS}\r"
    expect "Last login"
    send "#{cmd}ls\r"
    interact"
  EOC
end

def scp(host, src, dest)
  `scp #{src} #{USER}@#{host}:#{dest}`
end
