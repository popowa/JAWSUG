# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

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
  obj = bucket.objects[file_path]
  obj.write(Pathname.new(file_path))
  puts "Upload: #{obj.key}"

  dynamo_db = AWS::DynamoDB.new
  begin
    table = dynamo_db.tables['S3DynamoDB']
    table.hash_key 
  rescue
    table = dynamo_db.tables.create(
      'S3DynamoDB', 5, 5,
      :hash_key => { :path => :string },
      :range_key => {:bucket_name => :string }
    )
  end
    item = table.items.create(:path => obj.key, :bucket_name => bucket_name)
end


