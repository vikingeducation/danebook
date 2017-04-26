require 'rails_helper'
require 'pry'

describe 'UsersRequests' do
  let(:user){ create(:profile).user }
  describe 'POST #create'
  describe 'PUT #update' do
    context 'logged out' do
      it 'cannot update' do
        patch user_path(user), params: {user: attributes_for(:user, profile_attributes: attributes_for(:profile, quote: 'This is a quote'))}
        user.reload
        expect(user.profile.quote).not_to eq('This is a quote')
      end
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end
      it 'can update' do
        user
        patch user_path(user), params: {
          user: attributes_for(
            :user,
            profile_attributes: attributes_for(
              :profile,
              id: user.profile.id,
        quote: 'This is a quote'))}
        user.reload
        expect(user.profile.quote).to eq('This is a quote')
      end
    end
  end
  describe 'GET #show' do
    it 'allows anyone to visit' do
      get user_about_path(user)
      expect(response).to be_success
    end
  end
end
