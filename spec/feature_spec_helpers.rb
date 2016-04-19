module FeatureSpecHelpers
  def create_account_and_login!
    visit root_path
    click_link("Create a New Account")

    expect(page).to have_content("Create a new account")
    fill_in "Firstname", with: "Joe"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "123"
    fill_in "Confirm Password", with: "123"
    click_button("Create Account")
  end
end