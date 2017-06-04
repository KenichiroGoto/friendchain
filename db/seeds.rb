# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  confirmed_at = Date.today
  uid = SecureRandom.uuid
  provider = "provider"
  image_url = Faker::Avatar.image

  title = "title test"
  content = "test"
  user_id = 1
  topic_id = 1

  User.create!(email: email,
          name: name,
          password: password,
          password_confirmation: password,
          confirmed_at: confirmed_at,
          uid: uid,
          provider: provider,
          image_url: image_url,
          )

  Topic.create!(
          title: title,
          content: content,
          user_id: user_id,
          )

  Comment.create!(
          user_id: user_id,
          topic_id: topic_id,
          content: content,
  )

end
