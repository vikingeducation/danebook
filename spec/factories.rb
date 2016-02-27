FactoryGirl.define do  factory :photo do
    
  end
  factory :friending do
    user_id 
    friend_id 
  end

  factory :user, aliases: [:author] do
    sequence(:email) do |n| 
      ("A".."z").to_a.sample+"#{n}@gmail.com" 
    end
    first_name  "Foo"
    last_name "Last F"
    birthday Time.now
    gender ["Female","Male"].sample
    password_digest "password"

  end

  factory :profile do
    user 
    college "MIT"
    phone "123456789"
    hometown "Smalltown"
    homecountry "USA"
    livesintown "Bigtown"
    livesincountry "USA"
    wordsby 'word'*10
    wordsabout "about"*10
    avatar_id 1
    cover_id 1
  end

  factory :post do
    body      "Stand alone Post"
    author 
  end

  factory :comment do
    body      "Stand alone Comment"
    author 
  end

  factory :post_like, class: "Like" do
    association :liking, :factory => :post
    user
  end

  factory :comment_like, class: "Like" do
    association :liking, :factory => :comment
    body      "Comment for like "
    author
  end


  factory :comments do
    user
    body "body"*10
    commenting_id :id
    commenting_type ["Post","Comment"].sample
  end
end