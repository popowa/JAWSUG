require  File.expand_path('./Day0.rb', File.dirname(__FILE__))


# create VPC
ec2 = AWS::EC2.new
vpc = ec2.vpcs.create('10.0.0.0/16')
p vpc.vpc_id
puts "Day 2. You created VPC, seperate from all AWS cloud...Amen"
