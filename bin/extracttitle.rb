#!/usr/bin/ruby

if ARGF.read =~ /<title>(.*) - Wikipedia, the free encyclopedia<\/title>/m
  puts $1
end

