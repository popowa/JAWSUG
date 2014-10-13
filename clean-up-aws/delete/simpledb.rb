# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

sdb = AWS::SimpleDB.new
sdb.domains.each do | domain |
  puts "Delete SimpleDB: #{domain.name}"
  domain.delete!
end
