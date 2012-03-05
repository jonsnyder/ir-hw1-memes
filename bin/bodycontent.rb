#!/usr/bin/ruby

if ARGF.read =~ /<!-- bodycontent -->(.*)<!-- \/bodycontent -->/m
  content = $1
  content.each do |line|
    if line =~ /<span class="mw-headline"[^>]*>References/
      break
    end
    puts line
  end
end

