puts 'Cadastrando tipos de contato'
%w[Amigo Comercial Conhecido].each do |kind|
  Kind.create!(description: kind)
end
puts 'Tipos de Contato Cadastrados com sucesso'

puts 'Cadastrando contatos'
100.times do
  contact = Contact.create!(
    name: Faker::Name.name, email: Faker::Internet.email,
    birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
    kind: Kind.all.sample
  )
  contact.build_address(street: Faker::Address.street_name,
                        city: Faker::Address.city).save!
end
puts 'Contatos Cadastrados com sucesso'

puts 'Cadastrando telefones'
Contact.find_each do |c|
  rand(5).times do
    c.phones.build(number: Faker::PhoneNumber.cell_phone).save!
  end
end
puts 'Telefones Cadastrados com sucesso'
