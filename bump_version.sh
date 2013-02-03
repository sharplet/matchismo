#!/usr/bin/env ruby
plist = 'Matchismo/Matchismo-Info.plist'
new_contents = []
new_version = nil
is_version_key = false

File.readlines(plist).each do |line|
  if is_version_key
    is_version_key = false
    line =~ /(.*<string>)(.*)(<\/string>)/

    print "Enter new version (currently #{$2}): "
    new_version = STDIN.readline.chomp
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
