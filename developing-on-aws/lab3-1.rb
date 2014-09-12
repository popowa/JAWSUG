# -*- encoding: utf-8 -*-
require  File.expand_path('./config.rb', File.dirname(__FILE__))

queue_name = "Notification"
sns_topic = "ClassroomEvent"

sqs = AWS::SQS.new
#create queue
if !sqs.queues.map(&:arn).include?(queue_name)
  queue = sqs.queues.create(
    queue_name, 
    #:visibility_timeout => 30
    #:policy
    #:maximum_message_size
    #:delay_seconds
    #:message_retention_period
  )
else
  queue = sqs.queues.named(queue_name)
end

puts queue_url = queue.url
puts queue_arn = queue.arn

#create sns topics
sns = AWS::SNS.new

topic = sns.topics.create(sns_topic)

#get sns arn
topic_arn = topic.arn
puts topic_arn

#queue permisson change
policy = Policy.new
policy.allow(
  :actions => ["sqs:SendMessage"],
  :resources => queue_arn,
  :principals => :any
).conditions.add(:is_arn_like,sns_arn)
queue.policy = policy


#create subscription to sqs
topic.subscribe(queue_arn)

#sending a message to queue
topic.publish('a short message to queue1111')

#receiving message
queue.poll do | msg |
  puts "This is messag: #{msg.body}"
  puts "and delete message..."
  msg.delete
end

