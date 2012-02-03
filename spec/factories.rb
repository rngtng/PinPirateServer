# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    game
  end
end

FactoryGirl.define do
  factory :game do
    player
  end
end

FactoryGirl.define do
  factory :player do
    name { Faker::Name.name }
  end
end