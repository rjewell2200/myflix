require 'spec_helper'

feature 'User registers' do
  scenario "with valid input", {js: true, vcr: true} do
    visit register_path
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Smith"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
    click_on('Sign Up')
    expect(page).to have_text("Thank you for signing up")
  end
end
