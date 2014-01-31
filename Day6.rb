require  File.expand_path('./Day0.rb', File.dirname(__FILE__))

# create EC2 instance
instance_type = 't1.micro'

user_data = <<-eos
#cloud-config
repo_upgrade: all
packages:
- httpd
- php
runcmd:
- [sed, -i, 's/en_US/ja_JP/', /etc/sysconfig/i18n]
- [cp, /usr/share/zoneinfo/Asia/Tokyo, /etc/localtime]
- [sh, -xc, "echo '<html><head><title></title></head><body><h1>JAWS-UG Miyazaki 2014/2/1</h1></body></html>' > /var/www/html/index.html" ]
- [chkconfig, httpd, "on"]
- [service, httpd, start]
eos

ec2 = AWS::EC2::new
instance = ec2.instances.create(:image_id => $ami_id,
                               :instance_type => instance_type,
                               :count => 1,
                               :security_group_ids => ec2.security_groups.filter('group-name',$security_gateway_name).first.id,
                               :key_pair => ec2.key_pairs[$key_pairs],
                               :private_ip_address => $private_ip,
                               :subnet => ec2.subnets.first.id,
                               :user_data => user_data
                               )
ec2.tags.create(instance, 'Name', :value => 'WebServer')
p "Now you create Instance...! and Wait for EIP to attach..."
loop{
    sleep(30)
    if instance.status == :running
        # get EIP
        eip = AWS::EC2::ElasticIpCollection.new
        e = eip.create(:vpc => true)
        e.associate :instance => instance.id
        break
    end
}

p "Day 6. Increase and multiply, fill the earth and subdue it!"
