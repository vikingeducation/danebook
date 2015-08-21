FactoryGirl.define do

  factory :post, aliases: [:commentable] do
    sequence(:body) { |n| "Foo post #{n}." }
    author
  end

end