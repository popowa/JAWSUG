require  File.expand_path('./Day0.rb', File.dirname(__FILE__))

vpcs = AWS::EC2::VPCCollection.new
vpcs.each {|vpc|
    if vpc.cidr_block == $vpc_cidr_block
        p "VPC ID: #{vpc.id}"
        p "  |__CIDR Block: #{vpc.cidr_block}"
        p "  |__DHCP Option ID: #{ vpc.dhcp_options_id}"
        p "  |__Instance Tenancy: #{vpc.instance_tenancy}" 
        p "  |__State: #{vpc.state}"
        p "  |__Internet Gateway: #{vpc.internet_gateway.id}"
        p "  |__Subnet"
        vpc.subnets.each {|subnet|
            p "    |__ID: #{subnet.id}"
            p "    |__Satte: #{subnet.state}"
            p "    |__AZ: #{subnet.availability_zone_name }"
            p "    |__Avaiable IP count: #{subnet.available_ip_address_count} "
            p "    |__CIDR Block: #{subnet.cidr_block}"
        }
        vpc.route_tables.each {|rt|
            if !rt.main?
                p "  |__Route Table:#{rt.id}"
                rt.routes.each {|rtt| p "    |__Routes #{rtt.destination_cidr_block}"}
            end
        }
        vpc.security_groups.each {|sg|
            p "  |__Security Group: #{sg.id}"
            p "    |__Description: #{sg.description}"
            sg.ip_permissions.each {|ipp|
                p "      |__Inbound:"
                p "        |__IP Range: #{ipp.ip_ranges}"
                p "        |__Port Range: #{ipp.port_range}"
                p "        |__Protocol: #{ipp.protocol.to_s}"
            }
            sg.egress_ip_permissions.each {|eipp|
                p "      |__Outbound:"
                p "        |___IP Range: #{eipp.ip_ranges}"
                p "        |__Port Range: #{eipp.port_range}"
                p "        |__Protocol: #{eipp.protocol.to_s}"
            
            }
        }
        p "  |__Instances:"
        vpc.instances.each {|instance|
            p "    |__ID: #{instance.id}"
            p "    |__AMI ID: #{instance.image_id}"
            p "    |__Type: #{instance.instance_type}"
            p "    |__Key Pair: #{instance.key_name}"
            p "    |__Launch Time: #{instance.launch_time.getlocal}"
            p "    |__Status : #{instance.status }"
            p "    |__IP Address: #{instance.ip_address}"
            p "    |__Private IP Address: #{instance.private_ip_address}"
            p "    |__Subnet ID: #{instance.subnet_id}"

        }
    end
}
