# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

rds = AWS::RDS.new

def seperator(title)
  puts "=====#{title}====="
end


seperator("RDS v2")

#RDSが削除された事を確認すればParameterが消せる

seperator("RDS paramter")
rds.client.describe_db_parameter_groups.db_parameter_groups.each do | pg |
  #if !pg.db_parameter_group_name.include?("default.")
    puts "Delete RDS Parameter Group: #{pg.db_parameter_group_name}"
    rds.client.delete_db_parameter_group(:db_parameter_group_name => pg.db_parameter_group_name)
  #end
end

seperator("RDS Option Group")
rds.client.describe_option_groups.option_groups_list.each do | op |
  if !op.option_group_name.include?("default")
    puts op.option_group_name
    rds.client.delete_option_group(:option_group_name => op.option_group_name)
  end
end
=begin


seperator("RDS Security Group")
rds.client.describe_db_security_groups.db_security_groups.each do | sg |
  puts "Delete RDS Security Group: #{sg.db_security_group_name}"
  rds.client.delete_db_subnet_group(:db_subnet_group_name => sg.db_security_group_name)
end

#TODO: find which key is event_name. 
seperator("RDS Event Subscription")
rds.client.describe_event_subscriptions.event_subscriptions_list.each do |list|
  puts list.customer_aws_id
  rds.client.delete_event_subscription(:subscription_name => list.cust_subscription_id)
end
=end

