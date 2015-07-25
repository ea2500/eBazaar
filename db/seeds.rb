# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "jim",
             email: "jim@jim.com",
             password:              "jimmish",
             password_confirmation: "jimmish",
             image_url: "JimsLabFace.jpg",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
User.create!(name:  "tim",
             email: "tim@tim.com",
             password:              "timmish",
             password_confirmation: "timmish",
             image_url: "ab.jpg",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# activated users
user_index=(1..13).to_a.shuffle
user_index.each do |n|
  name  = Faker::Name.name
  email = "xxx#{n+1}@xxx.xxx"
  user=User.create( name:  name ,
                    email: email ,
                    password:              'xxxxxx' ,
                    password_confirmation: 'xxxxxx' ,
                    activated: true,
                    activated_at: Time.zone.now,
                    # image_url: Faker::Avatar.image)
                    image_url: "face"+rand(1..10).to_s+".JPG")
  (rand(10)+0).times do
    user.products.create( name: Faker::Commerce.product_name ,
                          price: Faker::Commerce.price ,
                          image_url: "object"+rand(15).to_s+".JPG",
                          body: Faker::Lorem.paragraph(sentence_count=15))
  end
end

# non activated users
user_index=(14..17).to_a.shuffle
user_index.each do |n|
  name  = Faker::Name.name
  email = "xxx#{n+1}@xxx.xxx"
  user=User.create( name:  name ,
                    email: email ,
                    password:              'xxxxxx' ,
                    password_confirmation: 'xxxxxx' ,
                    # image_url: Faker::Avatar.image)
                    image_url: "face"+rand(1..10).to_s+".JPG")
end