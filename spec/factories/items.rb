FactoryGirl.define do
  factory :item do
    title "Ruby on Rails tips"
    source "Rails is cool"
    tags ["Ruby", "Rails"]
    association :user, factory: :user, strategy: :create
  end
end
