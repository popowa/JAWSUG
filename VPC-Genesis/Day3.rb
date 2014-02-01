require  File.expand_path('./Day0.rb', File.dirname(__FILE__))

# create Internet Gateway
ec2 = AWS::EC2::InternetGatewayCollection.new
gw = ec2.create()

# Get list of VPCs and find selected VPC
#
ec2 = AWS::EC2.new
ec2.vpcs.each {|vpc|
   if vpc.cidr_block == $vpc_cidr_block
       # attach GW to VPC
        igw = AWS::EC2::InternetGateway.new(gw.internet_gateway_id)
        igw.vpc = vpc.id
        break
   end
}

p "Day 3. You create Internet Gateway #{gw.internet_gateway_id} to the heavn and attach it to Mother Earth VPC...Jesus Christ Superstar!"
