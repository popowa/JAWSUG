# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))
require 'date'

s3 = AWS::S3.new
#check bucket name
if ARGV[1] == nil then
  bucket_name = 'komuro-bucket-training01'
else
  bucket_name = ARGV[1]
end

# check bucket exists
if !s3.buckets["#{bucket_name}"].exists?
  bucket = s3.buckets.create("#{bucket_name}")
else
  bucket = s3.buckets["#{bucket_name}"] 
end

#create and upload object
if ARGV[0] == nil then
  puts "Please enter file to be uploaded!"
else
  file_path = ARGV[0]
  start_time = DateTime.now
  puts "start: #{start_time}"

  obj = bucket.objects[file_path]
  obj.write(Pathname.new(file_path))
  finish_time = DateTime.now
  puts "Uploaded: #{finish_time}"
  diff_time = ((start_time - finish_time) * 24 * 60 * 60).to_i
  puts "Upload time: #{diff_time} sec"
end

