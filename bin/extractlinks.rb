#!/usr/bin/ruby

ARGF.read.scan( /<b><a href="\/wiki\/([^"]*)"/m) do |link|
  puts link.first
end

