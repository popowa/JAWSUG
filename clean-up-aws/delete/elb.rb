# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

elbs = AWS::ELB.new
elbs.load_balancers.each do | elb |
  if elb.instances
    elb.instances.each do | instance |
      puts "Deregister Instance #{instance.id} from ELB: #{elb.name}"
      instance.deregister
    end
  end
  if elb.exists?
    elb.delete
    puts "Delete ELB: #{elb.name}: DNS name: #{elb.dns_name}"
  end
end
