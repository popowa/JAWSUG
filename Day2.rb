require  File.expand_path('./Day0.rb', File.dirname(__FILE__))


# create VPC
ec2 = AWS::EC2.new
vpc = ec2.vpcs.create($vpc_cidr_block)
puts "Day 2. You created VPC #{vpc.vpc_id}, seperate from all AWS cloud...Amen"
