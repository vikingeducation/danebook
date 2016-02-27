require 'rails_helper'

include UserAuth

describe FriendsController do
  describe 'friends access' do

    let(:user){ create(:user) }
    let(:friend) { create(:user) }
    let(:friending) { create( :friending,
                              friender: user,
                              target: friend)}

    before do
      sign_me_in(user)
    end


    describe 'GET #index' do
      it "collects friends into @friends" do
        friending #Loads the lazy let block
        another_friend = create(:user)
        create( :friending,
                friender: user,
                target: another_friend)
        get :index, user_id: user.id
        expect(assigns(:friends)).to match_array [friend, another_friend]
      end

      it "renders the :index template" do
        get :index, user_id: user.id
        expect(response).to render_template :index
      end

      it "doesn't show for users who are not logged in" do
        sign_me_out
        get :index, user_id: user.id
        expect(response).to redirect_to login_path
      end
    end

  end
end