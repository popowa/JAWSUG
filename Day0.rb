require 'aws-sdk'
AWS.config({
  :access_key_id => 'Access Key with Full VPC and EC2 privilege',
  :secret_access_key => 'Secret Access Key with Full VPC and EC2 privilege',
  :region => 'ap-northeast-1', #We love Japan!
 }
)
$vpc_cidr_block = '10.0.0.0/16'
