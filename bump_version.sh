#!/usr/bin/env ruby
plists = Dir['**/*-Info.plist']

plist = nil
if plists.size > 1
  plists.each_index do |i|
    puts "[#{i+1}] #{plists[i]}"
  end

  print "Select a plist to use (enter a number): "
  plist_index = STDIN.readline.chomp.to_i - 1
  plist = plists[plist_index]
else
  plist = plists.first
end

puts "Using #{plist}"

new_contents = []
new_version = nil
is_version_key = false

File.readlines(plist).each do |line|
  if is_version_key
    is_version_key = false
    line =~ /(.*<string>)(.*)(<\/string>)/

    print "Enter new version (currently #{$2}): " unless ARGV[0]
    new_version = ARGV[0] || STDIN.readline.chomp

    new_contents << "#{$1}#{new_version}#{$3}\n"
  else
    new_contents << line
  end

  if line =~ /CFBundleShortVersionString/
    is_version_key = true
  end
end

if new_contents
  File.open(plist, 'w').print(new_contents.join)
  puts "Updated #{plist} to new version #{new_version}"
end
