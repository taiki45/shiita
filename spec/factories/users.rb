FactoryGirl.define do
  factory :user do
    uid 1
    name "taiki"
    email "taiki@example.com"
    following_ids []
    follower_ids []
  end
end
