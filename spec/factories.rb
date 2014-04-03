FactoryGirl.define do
  factory :song do
    title 'Come Thou Fount'
    notes 'these are some miscellaneous notes about this song'
  end

  factory :user do
    email 'person@example.com'
    password '1234'
  end
end
