# -*- encoding: utf-8 -*-

require 'aws-sdk'
require 'pp'
require 'uri'
require 'json'


region_id = ARGV[0].to_i
region = {
  1=>"us-east-1",
  2=>"us-east-2",
  3=>"us-west-1",
  4=>"eu-west-1",
  5=>"ap-southeast-1",
  6=>"ap-southeast-2",
  7=>"ap-northeast-1",
  8=>"sa-east-1"
}

AWS.config({
  :access_key_id => '',
  :secret_access_key => '',
  :region => region[region_id], #We love Japan!
 }
)

