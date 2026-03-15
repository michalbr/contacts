# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

names = [
  { first_name: "Anna", last_name: "Smith" },
  { first_name: "John", last_name: "Johnson" },
  { first_name: "Maria", last_name: "Garcia" },
  { first_name: "Michael", last_name: "Brown" },
  { first_name: "Sarah", last_name: "Davis" }
]

names.each do |name|
  Contact.create!(
    first_name: name[:first_name],
    last_name: name[:last_name],
    email: "#{name[:first_name]}.#{name[:last_name]}@mailbox.com".downcase
  )
end

label_names = [ "Friends", "Family", "Gym" ]

label_names.each do |label_name|
  Label.create!(name: label_name)
end

labels = Label.all
contacts = Contact.all

labels[0].contacts << contacts[0]
labels[0].contacts << contacts[1]
labels[0].contacts << contacts[2]
labels[1].contacts << contacts[2]
