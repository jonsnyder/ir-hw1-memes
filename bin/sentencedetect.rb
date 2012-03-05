#!/usr/bin/ruby
doc = ARGF.read

doc.gsub!(/\[[^\]]*\]/m) {" "}
doc.gsub!(/((\.|;|!|\?)\s)/) { $1 + "\n"}
doc.gsub!(/  +/) {" "}
doc.gsub!(/^ /) {""}
doc.gsub!(/\s\s+/m) {"\n"}
doc.gsub!(/ \./) {"."}
doc.gsub!(/ ,/) {","}
doc.gsub!(/ '/) {"'"}
doc.gsub!(/ ;/) {";"}
puts doc



