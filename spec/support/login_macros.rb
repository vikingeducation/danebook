module LoginMacros
  def sign_in(user)
    visit root_url
    within "#navbar form" do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Enter the Danebook"
    end
  end

  def sign_out
    #
  end

  def create_account
    visit root_url
    within "form#new_user" do
      fill_in "Email", with: "ermusk@spacex.com"
      fill_in "Password", with: "asdfasdf"
      fill_in "Password confirmation", with: "asdfasdf"
      fill_in "First name", with: "Elon"
      fill_in "Last name", with: "Musk"
      select('January', from: 'Select month')
      select('1', from: 'Select day')
      select('1980', from: 'Select year')
      choose('Male')
      click_on "Create Account"
    end
  end


end
