# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))


#S3 bucket delete
s3 = AWS::S3.new

buckets = s3.buckets

buckets.each do |bucket|
  if !bucket.name.include?("elasticbeanstalk")
    puts "delete object from:#{bucket.name}"
      bucket.objects.each do |obj|
        puts obj.key
      end
    bucket.clear!
    bucket.delete
  end
end
