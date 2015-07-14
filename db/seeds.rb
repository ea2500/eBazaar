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
             admin: true)
User.create!(name:  "tim",
             email: "tim@tim.com",
             password:              "timmish",
             password_confirmation: "timmish",
             image_url: "ab.jpg",
             admin: true)

nnn=25
user_index=(1..nnn).to_a.shuffle
user_index.each do |n|
  name  = Faker::Name.name
  email = "xxx#{n+1}@xxx.xxx"
  password = "password"
  user=User.create( name:  name ,
                    email: email ,
                    password:              'xxxxxx' ,
                    password_confirmation: 'xxxxxx' ,
                    image_url: Faker::Avatar.image
                    # image_url: "face"+rand(1..10).to_s+".JPG")
  (rand(10)+0).times do
    user.products.create( name: Faker::Commerce.product_name ,
                          price: Faker::Commerce.price ,
                          image_url: "object"+rand(15).to_s+".JPG",
                          body: Faker::Lorem.paragraph(sentence_count=15))
  end
end