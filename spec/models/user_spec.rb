require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  describe 'initialization' do
    it 'should be valid' do
      expect(user).to be_valid
    end

    it 'should have a profile after initialization' do
      user.save
      expect(user.profile).to_not be_nil
    end
  end

  context 'email validations' do
    it 'should allow for a valid email' do
      user.email = "abc@123.com"
      expect(user).to be_valid
    end

    it 'should not allow for an invalid email (missing @)' do
      user.email = "abc123.com"
      expect(user).to be_invalid
    end

    it 'should not allow for an invalid email (missing .)' do
      user.email = "abc@123com"
      expect(user).to be_invalid
    end

    it 'should not allow for an invalid email (nothing before the @)' do
      user.email = "@123.com"
      expect(user).to be_invalid
    end

    it 'should not allow for an invalid email (nothing after the .)' do
      user.email = "abc@123."
      expect(user).to be_invalid
    end

    it 'should not allow an empty email' do
      user.email = ""
      expect(user).to be_invalid
    end

    context 'email uniqueness' do
      before do
        user.email = "duplicate@test.com"
        user.save
      end

      it 'should not allow duplicate emails.' do
        new_user = build(:user, email: "duplicate@test.com")
        expect(new_user).to be_invalid
      end

      it 'should allow re-using an email that is not currently in use' do
        user.email = "duplicate2@test.com"
        user.save
        new_user = build(:user, email: "duplicate@test.com")
        expect(new_user).to be_valid
      end
    end
  end

  context 'required field validations' do
    it 'should not validate without a first name' do
      user = build(:user, first_name: "")
      expect(user).to be_invalid
    end

    it 'should not validate without a last name' do
      user = build(:user, last_name: "")
      expect(user).to be_invalid
    end

    it 'should not validate without a date of birth' do
      user = build(:user, dob: nil)
      expect(user).to be_invalid
    end

    it 'should not validate without a gender' do
      user = build(:user, gender: nil)
      expect(user).to be_invalid
    end
  end

  context 'password validations' do
    it 'should require a password when signing up' do
      new_user = build(:user, password: nil)
      expect(new_user).to be_invalid
    end

    it 'should not validate without a password confirmation' do
      new_user = build(:user, password_confirmation: "12345")
      expect(new_user).to be_invalid
    end

    it 'should not validate with too short a password (< 7 chars)' do
      new_user = build(:user, password: "1234567", password_confirmation: "1234567")
      expect(new_user).to be_invalid
    end

    it 'should validate with a short password (8 char min)' do
      new_user = build(:user, password: "12345678", password_confirmation: "12345678")
      expect(new_user).to be_valid
    end

    it 'should not validate with a long password (24 char max)' do
      new_user = build(:user, password: "1" * 25, password_confirmation: "1" * 25)
      expect(new_user).to be_invalid
    end

    it 'should validate with a long password (24 char max)' do
      new_user = build(:user, password: "1" * 24, password_confirmation: "1" * 24)
      expect(new_user).to be_valid
    end

    it 'should not validate with mismatching password and confirmation' do
      new_user = build(:user, password: "1" * 24, password_confirmation: "2" * 24)
      expect(new_user).to be_invalid
    end
  end

  context 'written posts ordering' do
    it 'should return written posts in descending order' do
      posts = create_list(:post, 10)
      user.written_posts << posts
      user.save
      expect(user.written_posts.all).to eq(posts.reverse)
    end
  end

  describe '.search' do

    before do
      create_list(:user, 12)
    end

    it 'should find a user that exists' do
      expect(User.search('y')).to_not be_empty
    end

    it 'should find users by last name' do
      expect(User.search('1son')).to_not be_empty
    end

    it 'should not find users that do not exist' do
      expect(User.search('idonexist')).to be_empty
    end
  end

  describe '#full_name' do
    it 'should properly return the full name' do
      expect(user.full_name).to eq(user.first_name + " " + user.last_name)
    end
  end

  describe '#likes?' do
    let(:post){ create(:post) }
    it 'should return true if the user likes something' do
      new_like = create(:liked_post, likable: post, user: user)
      expect(user.likes?(post)).to be true
    end

    it 'should return false if the user does not like something' do
      expect(user.likes?(post)).to be false
    end
  end
end
