require 'rails_helper'

describe Post do
  let(:post) { build(:post) }
  let(:user) { build(:user) }

  describe "body" do
    it "validates the presence of a body" do
      should validate_presence_of(:body)
    end

    it "accepts a body with at least 10 characters" do
      should validate_length_of(:body).is_at_least(10)
    end

    it "accepts a body with at most 20000 characters" do
      should validate_length_of(:body).is_at_most(20000)
    end

    it "accepts a title with at least 4 characters" do
      should validate_length_of(:title).is_at_least(4)
    end

    it "accepts a title with at most 60 characters" do
      should validate_length_of(:title).is_at_most(60)
    end

  end

  describe "associations" do
    it "has many comments" do
      expect(post).to have_many(:comments)
    end

    it "has many likes" do
      expect(post).to have_many(:likes)
    end

  end

  describe "#liked?" do

    context "when passed a user as an argument" do
      it "returns true when it has been liked by a specified user" do
        user.save
        post.save
        post.likes.create(user: user)
        expect(post.liked?(user)).to be(true)
      end

      it "returns false when it has not been liked by a specified user" do
        user.save
        post.save
        post.likes.create(user: user)
        other_user = create(:user)
        expect(post.liked?(other_user)).to be(false)
      end
    end

    it "returns true when the post has been liked at all" do
      liked_post = build(:post,:with_likes)
      expect(liked_post.liked?).to be(true)
    end

  end

  describe "#like" do

    context "when passed a user as an argument" do
      it "returns the last like that the user made on the post" do
        user.save
        post.save
        post.likes.create(user: user)
        user_like = post.likes.last
        2.times do
          other_user = create(:user)
          post.likes.create(user: other_user)
        end
        expect(post.like(user)).to eq(user_like)
      end
    end

    it "returns the last like made on the post" do
      liked_post = build(:post,:with_likes)
      last_like = liked_post.likes.last
      expect(liked_post.like).to eq(last_like)
    end

  end

  describe "scope :desc" do

    it "returns a relation containing the posts in descending order" do
      5.times do
        create(:post)
      end

      newest = Post.last

      expect(Post.desc.first).to eq(newest)
    end

  end

  describe "nested attributes" do

    it "accepts nested attributes for comments, with an allow_destroy option" do
      should accept_nested_attributes_for(:comments).allow_destroy(true)
    end
  end

end