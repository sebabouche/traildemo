require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views

  describe "Sign Up, Sign In and Sign Out User" do
    it "signs up and signs in" do
      visit "sessions/sign_up_form"
      fill_in "user[email]", with: "fred@trb.org"
      fill_in "user[password]", with: "123"
      fill_in "user[confirm_password]", with: "123"
      click_button "Sign Up!"

      fill_in "session[email]", with: "fred@trb.org"
      fill_in "session[password]", with: "123"
      click_button "Créer un(e) User"

      expect(page).to have_content("Hi, fred@trb.org")

      visit "sessions/sign_in_form"

      expect(page).to have_content("Welcome to GemGem")

      click_link "Hi, fred@trb.org"
      click_link "Sign Out"

      expect(page.current_path).to eq "/"
      expect(page).not_to have_content("Hi, fred@trb.org")
    end
  end


  describe "Wake Up User" do
    it do
      user = Thing::Create.(thing: {
        name: "Taz",
        users: [
          {"email" => "fred@taz.de"}
        ]}).model.users[0]

      token = Tyrant::Authenticatable.new(user).confirmation_token

      visit "sessions/wake_up_form/#{user.id}/?confirmation_token=#{token}"

      expect(page).to have_content("account, fred@taz.de")
      expect(page).to have_selector("#user_password")
      expect(page).to have_selector("#user_confirm_password")

      fill_in "user[password]", with: "123"
      fill_in "user[confirm_password]", with: "123"
      click_button "Engage!"

      user = User.find(user.id) # why should I reload user to pass the test?

      expect(page).to have_content "Password saved."
      expect(Tyrant::Authenticatable.new(user).confirmed?).to be_truthy

      expect(page.current_path).to eq "/sessions/sign_in_form"
    end
  end
end
