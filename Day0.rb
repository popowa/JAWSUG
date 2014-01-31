require 'aws-sdk'
AWS.config({
  :access_key_id => 'Access Key with Full VPC and EC2 privilege',
  :secret_access_key => 'Secret Access Key with Full VPC and EC2 privilege',
  :region => 'ap-northeast-1', #We love Japan!
 }
)
$vpc_cidr_block = '192.168.3.0/24'
$subnet_cidr_block = '192.168.3.0/25'
$private_ip = '192.168.3.5'
$public_cidr_block = '0.0.0.0/0'
$security_gateway_name = 'WebServerSG'
$security_gateway_description = 'You are GOD now..!'
$authorize_ingress = [80, 22]
$authorize_egress = [80]

$key_pairs = "KomuroTest"
$ami_id = 'ami-3561fe34'


