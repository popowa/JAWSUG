# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

ec2 = AWS::EC2::new

#delete EIP
ec2.elastic_ips.each do |eip|
  if eip.associated?
    puts "Diassociate from #{eip.instance_id}"
    eip.disassociate
  end
  eip.delete
  puts "Release: #{eip}"
end

#delete AMIs

ec2.images.with_owner("self").each do |image|
  if image.exists?
    puts "Deregister: #{image.image_id}/#{image.description}"
    image.deregister
  end
end


#Terminate instances
ec2.instances.each do |instance|
  if instance.exists?
    puts "Terminate: #{instance.id}"
    instance.terminate
  end
end


#Delete Keypair

ec2.key_pairs.each do |keypair|
  if keypair.exists?
    puts "Delete: #{keypair.name}/fingerprint:#{keypair.fingerprint}"
    keypair.delete
  end
end


#delete Network Interfaces

ec2.network_interfaces.each do | eni |
  #以下見直す。trueになる理由を調べる
  if eni.status.equal? "in_use"
    puts "Delete ENI: #{eni.id}"
    eni.delete
  end
end


# delete ec2 security group。
# VPCのSGは後で削除する
ec2.security_groups.each do | sg |
   if sg.name != "default" and !sg.vpc
      puts "Delete Security Group: #{sg.id}"
      sg.delete
   end
end
