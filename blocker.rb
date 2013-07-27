#! /usr/bin/ruby

regex = /^\s*#\s*(\S*)\s*(\S*)/
raise "Need to specify an argumnt" if ARGV.empty?
domain = ARGV.first
wwwdomain = "www.#{domain}"

def block_line line, ip, dom
  puts "BLOCKING LINE: #{line}"
  "127.0.0.1  #{dom}\n"
end


f = File.open('/private/etc/hosts', 'r')

blocked_lines = []
newlines = f.lines.map do |line|
  if (m = regex.match line)
    ip, dom = m.captures
    if [domain, wwwdomain].include? dom
      line = block_line line, ip, dom
      blocked_lines << line
    end
  end
  line
end
f.close

puts "Blocked #{blocked_lines.count} line(s)", blocked_lines

out = File.open('/private/etc/hosts', 'w')
newlines.each do |line|
  out.write line
end
out.close
