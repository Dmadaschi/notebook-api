FactoryBot.define do
  factory :contact do
    name { 'Daniel' }
    email { 'daniel@test.com.br' }
    birthdate { '20/02/1970' }

    kind
  end
end
