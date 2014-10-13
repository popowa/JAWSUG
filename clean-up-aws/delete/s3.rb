# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))


#S3 bucket delete
s3 = AWS::S3.new

buckets = s3.buckets

#versioning とMFA無効の機能がない


buckets.each do |bucket|
  puts "object from:#{bucket.name}"
  if bucket.acl
    bucket.acl = :bucket_owner_full_control
  end
  if bucket.policy
    bucket.policy.delete
  end
  if bucket.website?
     bucket.remove_website_configuration
  end
  if bucket.cors.count
    bucket.cors.clear
  end
  bucket.clear!
  bucket.delete()
end
