require 'rails_helper'

RSpec.feature "User logs out", type: :feature do
  scenario "Signed in user signs out." do
    create_account_and_login!

    click_link("Logout")

    expect(current_path).to eq("/login")
  end
end