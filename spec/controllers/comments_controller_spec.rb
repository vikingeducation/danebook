require 'rails_helper'

describe CommentsController do
  let (:user) { create(:user) }
  before do
    allow(controller).to receive(:store_referer) { session[:referer] = root_path }
    allow(controller).to receive(:current_user) { user }
  end

  it 'should make a new comment on creation' do

    new_comment = build(:commented_post, author: user)
    expect do
      post :create, comment: new_comment.attributes
    end.to change(Comment, :count).by (1)
    expect(response).to redirect_to(root_path)
  end

  it 'should not make a new comment without a user' do
    new_comment = build(:commented_post, author: nil)
    expect do
      post :create, comment: new_comment.attributes
    end.to change(Comment, :count).by (0)
    expect(response).to redirect_to(root_path)
  end

  context 'comment deletion' do

    it 'should let the user delete his/her comment' do
      comment = create(:commented_post, author: user)
      expect do
        delete :destroy, id: comment.id
      end.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end

    it 'should not let the user delete a different user comment' do
      comment = create(:commented_post)
      expect do
        delete :destroy, id: comment.id
      end.to change(Comment, :count).by(0)
      expect(response).to redirect_to(root_path)
    end

  end

end
