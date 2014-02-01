require  File.expand_path('./Day0.rb', File.dirname(__FILE__))


# get AZ
#azs = AWS::EC2::AvailabilityZoneCollection.new
#p azs.first.to_str

# create subnet
ec2 = AWS::EC2.new
ec2.vpcs.each {|vpc|
   if vpc.cidr_block == $vpc_cidr_block
        # create Subnet
        subnet = vpc.subnets.create($subnet_cidr_block)
        p "You created Subnet #{subnet.id} on #{subnet.availability_zone_name} "
        # create Route table
        rt = AWS::EC2::RouteTableCollection.new
        routetable = rt.create(:vpc => vpc.id)
        p "And you created Route table #{routetable.id}...! "
        # get Internet Gateway
        igs = AWS::EC2::InternetGatewayCollection.new
        igs.each {|ig|
            if ig.vpc.id == vpc.id
                # create new route to routetable with IG
                routetable.create_route('0.0.0.0/0',  :internet_gateway => ig.id)
                p "Create new route to RT with IG..."
                #replace Subnet of Route Table to the newest one. 
                subnet.set_route_table(routetable.route_table_id)
                p "Replace route table to be public subnet..."
            end

        }      
      break
   end
}
p "We are now Public!\n"

