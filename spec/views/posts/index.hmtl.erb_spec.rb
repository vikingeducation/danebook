require 'rails_helper'

describe 'posts/index.html.erb' do

  let(:user){ create(:user) }
  let(:user_profile){ create(:profile, user_id: user.id) }
  let(:post){ create(:post, user_id: user.id) }

  before do
    @user = user
    @user_profile = user_profile
    @post = post
    @current_user = user
    def view.find_current_page_user
      @user
    end
    def view.current_user
      @user
    end
    controller.request.path_parameters[:user_id] = @user.id

  end

  context 'user has posts' do

    it 'shows users name' do
      render template: 'posts/index.html.erb', locals: { user: @user }
      expect(rendered).to match(@user_profile.name)
    end

    it 'lists all users posts' do
      user_posts = create_list(:post, 5, user_id: @user.id)
      render template: 'posts/index.html.erb', locals: { user: @user }
      expect(rendered).to have_content(user_posts.first.body)
      expect(rendered).to have_content(user_posts.last.body)
    end

    it 'has like link' do
      post = Post.create(user_id: @user.id, body: "This is a really cool post")
      render template: 'posts/index.html.erb', locals: { user: @user }
      expect(rendered).to have_link('Like')
    end

    it 'has unlike link if post previously liked' do
      post = Post.create(user_id: @user.id, body: "This is a really cool post")
      like = Like.create(user_id: @user.id, likable_id: @post.id, likable_type: 'Post')
      render template: 'posts/index.html.erb', locals: { user: @user }
      expect(rendered).to have_link('Unlike')
    end

  end

end
