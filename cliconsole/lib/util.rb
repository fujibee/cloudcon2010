def usage(msg)
  puts "ERROR: #{msg}!" if msg
  puts "USAGE: #{$0} command {#{COMMANDS.join(', ')}} server(s)"
end
