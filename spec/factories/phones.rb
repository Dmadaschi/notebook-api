FactoryBot.define do
  factory :phone do
    sequence(:number) { |n| "(11) 97451-682#{n}" }
    contact
  end
end
