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

=begin
#create and upload object
if ARGV[0] == nil then
  puts "Please enter file to be uploaded!"
else
  file_path = ARGV[0]
  obj = bucket.objects[file_path]
  obj.write(Pathname.new(file_path))
  puts "Upload: #{obj.key}"
end

=end

#create and multipartupload object
if ARGV[0] == nil then
  puts "Please enter file to be uploaded!"
else
  file_path = ARGV[0]
  open(file_path) do |file|
    uploading_object = bucket.objects[File.basename(file.path)]
    start_time = DateTime.now
    puts "start: #{start_time}"

    uploading_object.multipart_upload do |upload|
      while !file.eof?
        upload.add_part(file.read) 
        p('Aborted') if upload.aborted?
      end
    end
    finish_time = DateTime.now
    puts "Uploaded: #{finish_time}"
    diff_time = ((start_time - finish_time) * 24 * 60 * 60).to_i
    puts "Upload time: #{diff_time} sec"
  end
end

