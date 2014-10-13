# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

cloudwatch = AWS::CloudWatch.new
cloudwatch.alarms.each do |alarm|
  puts "delete #{alarm.name}"
  alarm.delete
end
