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

  client.save

  target_client = client.target_clients.build(
    name: Faker::Company.unique.name
  )

  target_client.save!

  3.times do
    target_client.addresses.build(
      first_line: Faker::Address.street_address,
      second_line: Faker::Address.community,
      city_town: Faker::Address.city,
      province: Faker::Address.state,
      country: Faker::Address.country,
      # zip_code: Faker::Address.zip_code.to_i
    ).save!
  end

  user = User.new(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    password: "123123",
    email: Faker::Internet.email,
    contact_number: Faker::PhoneNumber.unique.phone_number
  )
  user.save

  2.times do
    contact_person = target_client.contact_persons.build(
      first_name: Faker::Name.unique.first_name,
      last_name: Faker::Name.unique.last_name,
      contact_number: Faker::PhoneNumber.unique.phone_number
    )
    contact_person.save!

    Task.new(
      required_date: Faker::Date.forward(200),
      client_id: client.id,
      target_client_id: target_client.id,
      user_id: user.id,
      address_id: client.addresses.last.id,
      request_description: Faker::TheFreshPrinceOfBelAir.quote,
      contact_person_id: contact_person.id,
      notes_to_resource: Faker::StarWars.quote,
      resource_id: user.id,
      status_id: 1,
      request_type_id: 1,
      resource_notes: Faker::Seinfeld.quote
    ).save!
  end

  user = User.new(
    first_name: 'Miko',
    last_name: 'Dagatan',
    password: "123123",
    email: '1@miko.com',
    contact_number: '09176224604'
  ).save

end
