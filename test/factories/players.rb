# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    name { Faker::Name.name }
  end
end

# == Schema Information
#
# Table name: players
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  twitter_handle :string(255)
#  rfid_id        :string(255)
#

