# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  client = Client.new(
    name: Faker::Company.unique.name
  )
  3.times do
    client.addresses.build(
      first_line: Faker::Address.street_address,
      second_line: Faker::Address.community,
      city_town: Faker::Address.city,
      province: Faker::Address.state,
      country: Faker::Address.country,
      # zip_code: Faker::Address.zip_code.to_i
    ).save!
  end


  2.times do
    client.contact_persons.build(
      first_name: Faker::Name.unique.first_name,
      last_name: Faker::Name.unique.last_name
    ).save!

  end

  user = User.new(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    password: "123123",
    email: Faker::Internet.email
  )
  user.save
end
