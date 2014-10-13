# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

eb = AWS::ElasticBeanstalk.new

eb.client.describe_applications[:applications].each do | app |
  puts "Delete Elastic Beanstalk: #{app[:application_name]}"
  eb.client.delete_application(
      :application_name => app[:application_name],
      :terminate_env_by_force => true
  )
end
