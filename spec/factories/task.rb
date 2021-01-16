require 'securerandom'
FactoryBot.define do
  factory :task do
    content {SecureRandom.alphanumeric(50)}
    duration {15}
    comment {SecureRandom.alphanumeric(400)}
    completed {true}
    user_id {""}
  end
end