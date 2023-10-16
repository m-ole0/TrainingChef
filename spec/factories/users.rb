FactoryBot.define do
  factory :user do
    name { "testuser" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end