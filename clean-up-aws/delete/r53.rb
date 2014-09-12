# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

r53 = AWS::Route53.new
r53.hosted_zones.each do | zone |
  puts "Delete Host zone: #{zone.name}"
  zone.resource_record_sets.each do | record |
    if !record.type.include?("NS") and !record.type.include?("SOA")
      puts "- Record: #{record.name} - #{record.type}"
      record.delete
    end
  end
  zone.delete
end


