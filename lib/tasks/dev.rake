namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    puts 'Cadastrando tipós de contato'
    %w[Amigo Comercial Conhecido].each do |kind|
      Kind.create!(description: kind)
    end
    puts 'Tipos de Contato Cadastrados com sucesso'

    puts 'Cadastrando contatos'
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts 'Contatos Cadastrados com sucesso'
  end
end
