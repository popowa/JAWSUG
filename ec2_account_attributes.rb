require 'aws-sdk'
AWS.config({
  :access_key_id => '',
  :secret_access_key => '',
  :region => 'ap-northeast-1', #We love Japan!
 }
)

ec2 = AWS::EC2.new
puts ec2.client.describe_account_attributes


