# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Like.delete_all
Post.delete_all
Comment.delete_all
Profile.delete_all
Photo.delete_all
User.delete_all



# hacky way to create first photo
p = Photo.new
p.image = open(Faker::Avatar.image)
p.user_id = 1
p.save




puts "Creating users..."


def create_user
  new_user = User.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    email: Faker::Internet.email, 
    password_digest: "$2a$10$.MSTCUKj.7tpap8LswJXa.AeTlsa9Qmh0TWTcYJjqZd8bhMokgPbO", 
    birthday: Time.now, 
    gender: ["Male", "Female"].sample
  )
end

20.times do
  create_user
end

Profile.all.each do |p|
  p.about_me = Faker::Hipster.sentence
  p.words_to_live_by = Faker::Hipster.paragraph
  p.hometown = Faker::Address.city
  p.current_city = Faker::Address.city
  p.save
end


admin = User.create(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name, 
  email: "admin@admin.com", 
  password_digest: "$2a$10$.MSTCUKj.7tpap8LswJXa.AeTlsa9Qmh0TWTcYJjqZd8bhMokgPbO", 
  birthday: Time.now, 
  gender: "Female"
  )

admin_profile = Profile.find_by_user_id(admin.id)
admin_profile.about_me = Faker::Hipster.sentence
admin_profile.words_to_live_by = Faker::Hipster.paragraph
admin_profile.hometown = Faker::Address.city
admin_profile.current_city = Faker::Address.city
admin_profile.save


puts "Creating posts..."

def create_post
  Post.create(user_id: User.pluck(:id).sample, body: Faker::Hipster.sentence)
end

User.all.each do
  3.times { create_post }
end



puts "Creating comments on posts..."

50.times do
  Comment.create(body: Faker::Hipster.paragraph, user_id: User.pluck(:id).sample, commentable_type: "Post", commentable_id: Post.pluck(:id).sample)
end




puts "Assigning photos..."

User.all.each do |user|
  p = Photo.new
  p.image = open(Faker::Avatar.image)
  p.user_id = user.id
  p.save
end




puts "Creating comments on photos..."

50.times do
  Comment.create(body: Faker::Hipster.paragraph, user_id: User.pluck(:id).sample, commentable_type: "Photo", commentable_id: Photo.pluck(:id).sample)
end





puts "Creating likes on posts, comments, and photos..."

50.times do
  Like.create(user_id: User.pluck(:id).sample, likeable_id: Post.pluck(:id).sample, likeable_type: "Post")
end

50.times do
  Like.create(user_id: User.pluck(:id).sample, likeable_id: Comment.pluck(:id).sample, likeable_type: "Comment")
end

50.times do
  Like.create(user_id: User.pluck(:id).sample, likeable_id: Photo.pluck(:id).sample, likeable_type: "Photo")
end





puts "Creating friendships..."

def create_friendship
  friender = User.pluck(:id).sample
  friend = User.pluck(:id).sample

  Friending.create(friender_id: friender, friend_id: friend) unless friender == friend
end

200.times do
  create_friendship
end


puts "DONE!"