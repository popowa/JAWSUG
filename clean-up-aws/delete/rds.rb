# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

rds = AWS::RDS.new

def seperator(title)
  puts "=====#{title}====="
end


seperator("RDS")
rds.db_instances.each do  | instance |
  if instance.exists? and instance.db_instance_status != "deleting"
    puts "Delete RDS: #{instance.db_instance_identifier}"
    instance.delete(:skip_final_snapshot => true)
  end
end

seperator("RDS snapshot")
rds.db_snapshots.each do | snapshot |
  if snapshot.exists? and snapshot.snapshot_type == "manual"
    puts "Delete RDS snapshot: #{snapshot.db_snapshot_identifier}/ #{snapshot.engine} / #{snapshot.instance_create_time}"
    snapshot.delete
  end
end

