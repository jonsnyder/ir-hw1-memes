#!/usr/bin/ruby
puts ARGF.read.gsub!(/(<[^>]*>)/m) {" "}

