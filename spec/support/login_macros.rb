module LoginMacros
  def sign_in(user)
    visit new_user_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end
end