FactoryBot.define do
  factory :user do
    name { "TEST_NAME"}
    email { "test@example.com"}
    provider {"email"}
    uid {"test@example.com"}
    password {"password"}
  end
end