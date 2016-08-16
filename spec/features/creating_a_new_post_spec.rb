require 'rails_helper.rb'

feature "A user can create a new post" do
  let(:user) {create(:user)} 

  scenario "on their wall" do 
    login(user)
    click_on("Timeline")
    filled_in = "HELLLOO!!"
    fill_in('post[content]', with: filled_in)
    click_on("Post to the world!")
    expect(page).to have_content(filled_in)

  end

  scenario "A user can create a post on someone else's wall" do 
    login(user)
  end

end