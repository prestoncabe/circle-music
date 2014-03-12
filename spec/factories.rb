FactoryGirl.define do
  factory :song do
    title 'Come Thou Fount'
  end

  factory :user do
    email 'person@example.com'
    password '1234'
  end
end
