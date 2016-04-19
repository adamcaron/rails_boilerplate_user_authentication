require 'rails_helper'

RSpec.feature "User logs in", type: :feature do
  scenario "Unauthenticated user forced to login." do
    visit root_path

    expect(current_path).to eq("/login")
    expect(page).to have_content("Please Log In")
  end

  describe "New user creates an account" do
    it "Submits valid form input" do
      visit root_path
      click_link("Create a New Account")

      expect(page).to have_content("Create a new account")
      fill_in "Firstname", with: "Joe"
      fill_in "Email", with: "joe@example.com"
      fill_in "Password", with: "123"
      fill_in "Confirm Password", with: "123"
      click_button("Create Account")

      expect(User.count).to eq(1)
      expect(User.last.email).to eq("joe@example.com")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, Joe!")
      expect(page).to have_link("Logout")
    end

    it "Submits invalid form input" do
      visit root_path
      click_link("Create a New Account")

      click_button("Create Account")

      expect(page).to have_content("Password can't be blank, Firstname can't be blank, Email can't be blank, Password confirmation doesn't match Password")
    end
  end

  describe "Existing user logs in" do
    it "Submits valid credentials & logs in successfully." do
      User.create(firstname: "Jane", email: "jane@example.com", password: "123")

      visit login_path
      fill_in "Email", with: "jane@example.com"
      fill_in "Password", with: "123"
      click_button "Login"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, Jane!")
    end

    it "Submits invalid login credentials & cannot login." do
      visit login_path

      click_button "Login"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Invalid login credentials")
    end
  end
end