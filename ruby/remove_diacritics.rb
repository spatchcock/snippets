#! /usr/bin/ruby

string = "Präg"
string.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
#=> Prag