# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))
dynamo_db = AWS::DynamoDB.new

begin
  table = dynamo_db.tables['Accounts']
rescue
  table = dynamo_db.tables.create(
    "Accounts", 5, 5,
    :hash_key => { :Company => :string },
    :range_key => {:Email => :string }
  )
end
table.hash_key
#add single row
item = table.items.create(:Company => 'Amazon.com', :Email => 'johndoe@amazon.com')
item.attributes.set(
  :First => "John",
  :Last => "Doe",
  :Age => 33
)

=begin

# add items as batch
put_items = [
  {
    :Company => 'Amazon.com', 
    :Email => 'RobertIkeda@amazon.com', 
    :First => "Robert",
    :Last => "Ikeda",
    :Age => 27
  },
  {
    :Company => 'Microsoft', 
    :Email => 'osama@microsoft.com', 
    :First => "Osama",
    :Last => "Wyne",
    :Age => 43
  },
  {
    :Company => 'Nifty', 
    :Email => 'ChinWin@nifty.com', 
    :First => "Chin",
    :Last => "Win",
    :Age => 77
  }
]

table.batch_put(put_items)

=end
