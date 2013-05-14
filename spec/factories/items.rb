FactoryGirl.define do
  factory :item do
    title "Ruby on Rails tips"
    source "Rails is cool"
    association :user, factory: :user
  end

  factory :item_no_user do
    title "Test"
    source "Test Source"
  end
end
