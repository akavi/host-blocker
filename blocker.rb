#! /usr/bin/ruby

regex = /^\s*#\s*(\S*)\s*(\S*)/
raise "Need to specify an argumnt" if ARGV.empty?
domain = ARGV.first
wwwdomain = "www.#{domain}"

def blockLine line, ip, dom
  puts "BLOCKING LINE: #{line}"
  "127.0.0.1  #{dom}\n"
end


f = File.open('/private/etc/hosts', 'r')

newlines = f.lines.map do |line|
  if (m = regex.match line)
    ip, dom = m.captures
    # p ip, dom
    if [domain, wwwdomain].include? dom
      line = blockLine line, ip, dom
    end
  end
  line
end
f.close
p newlines

out = File.open('/private/etc/hosts', 'w')
newlines.each do |line|
  out.write line
end
out.close
