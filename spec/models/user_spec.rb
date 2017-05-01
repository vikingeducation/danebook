require 'rails_helper'

describe User do
  let(:user){ build(:user)}
  let(:full_user){ build(:user, :with_profile)}
  it 'is valid with default attributes' do
    expect(user).to be_valid
  end
  it 'saves with default attributes' do
    expect{user.save}.not_to raise_error
  end
  it 'is invalid without email' do
    user.email = nil
    expect(user).to be_invalid
  end
  it 'is invalid without password' do
    user.password = nil
    expect(user).to be_invalid
  end
  it 'is invalid if email is fewer than 6 chars' do
    user.email = 'xxx'
    expect(user).to be_invalid
  end
  it 'is invalid if password password is fewer than 12 chars' do
    user.password = 'xxx'
    expect(user).to be_invalid
  end
  it 'does not allow duplicate emails' do
    u = create(:user, email: 'a@a.com')
    copycat = build(:user, email: 'a@a.com')
    expect(copycat).to be_invalid
  end
  context 'instance methods' do
    let(:user){ create(:user, :with_profile)}
    let(:friend){ create(:user, :with_profile)}
    def add_friend(user, friend)
      user.friendees << friend
    end
    def add_rejected_friend(user, friend)
      user.friendees << friend
      f = Friendship.last.update(rejected: true)
    end
    describe '#first_name' do
      it 'returns a User\'s first name' do
        expect(user.first_name).to eq(user.profile.first_name)
      end
    end

    describe '#friendship_status' do
      it 'returns "create" if user not logged in' do
        expect(friend.friendship_status(user)).to eq('create')
      end
      context 'logged in' do
        before do
          login_as(user, user: :user)
        end
        it 'returns nil if request not accepted' do
          create(:friendship, friender_id: user.id, friendee_id: friend.id, rejected: nil)
          expect(friend.friendship_status(user)).to be_nil
        end
        it 'returns true if request rejected' do
          create(:friendship, friender_id: user.id, friendee_id: friend.id, rejected: true)
          expect(friend.friendship_status(user)).to eq(true)
        end
        it 'returns friends if request accepted' do
          user = create(:user, :with_accepted_friend_request)
          friend = user.friendees.last
          expect(friend.friendship_status(user)).to eq(false)
        end
        it "returns 'create' if no friendship record" do
          expect(friend.friendship_status(user)).to eq('create')
        end
      end
    end
  end
  context 'associations' do
    it 'responds to posts associations' do
      expect(user).to respond_to(:posts)
    end
    it 'responses to likes associations' do
      expect(user).to respond_to(:likes)
    end
    it 'responeds to comments associations' do
      expect(user).to respond_to(:comments)
    end
    it 'responds to comment_likes associations' do
      expect(user).to respond_to (:comment_likes)
    end
    it 'responds to initiated_friendships' do
      expect(user).to respond_to (:initiated_friendships)
    end
  end





end
