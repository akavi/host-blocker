#! /usr/bin/ruby

regex = /^\s*#\s*(\S*)\s*(\S*)/
hostfile_path = '/private/etc/hosts'


def block_line? line, doms
  www_doms = doms.map { |d| "wwww.#{d}" } 
  regex = /^\s*#\s*(\S*)\s*(\S*)/
  m = regex.match line
  found_dom = m ? m[2] : nil

  blockable_dom = doms.find { |dom| dom == found_dom }
  blockable_www_dom = www_doms.find { |dom| dom == found_dom }

  blockable_dom or blockable_www_dom
end

def block_dom dom
  "127.0.0.1  #{dom}\n"
end

raise "Need to specify an argument" if ARGV.empty?
flags, domains = ARGV.partition { |arg| arg.match("-.*") }
append_mode = flags.include? "-a"

f = File.open(hostfile_path, 'r')

blocked_lines = []
new_lines = f.lines.map do |line|
  if (found_dom = block_line? line, domains)
    puts "BLOCKING LINE: #{line}"
    line = block_dom found_dom
    blocked_lines << line
    domains.delete found_dom.gsub(/^www\./, "")
  end
  line
end

if append_mode
  domains.each do |domain|
    line = block_dom domain
    blocked_lines << line
    new_lines << line
  end
end

f.close

puts "Blocked #{blocked_lines.count} line(s)", blocked_lines

out = File.open('/private/etc/hosts', 'w')
new_lines.each do |line|
  out.write line
end
out.close
