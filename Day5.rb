require  File.expand_path('./Day0.rb', File.dirname(__FILE__))

# list VPCs
vpcs = AWS::EC2::VPCCollection.new
vpcs.each {|vpc|
    if vpc.cidr_block == $vpc_cidr_block
        # create Security Group
        sg = AWS::EC2::SecurityGroupCollection.new
        security_group = sg.create($security_gateway_name, :description => $security_gateway_description, :vpc => vpc.vpc_id)
        # Setting Inbound
        $authorize_ingress.each {|port| security_group.authorize_ingress(:tcp, port)}
        # Delete outbound for public
        security_group.revoke_egress($public_cidr_block)
        # Setting Outbound
        $authorize_egress.each {|port| security_group.authorize_egress($public_cidr_block,:protocol => :tcp, :ports => port)}
    end
}
p "You created Security Group to pass packets to the all human being... My load!"


