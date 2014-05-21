require 'spec_helper'

feature 'User signs in' do 
  scenario "with existing user" do
    john_doe = Fabricate(:user, full_name: "John Doe")
    user_signs_in(john_doe)
    expect(page).to have_content("John Doe")
  end

  scenario "with deactivated user" do
    john_doe = Fabricate(:user, full_name: "John Doe", active: false)
    user_signs_in(john_doe)
    expect(page).not_to have_content(john_doe.full_name)
    expect(page).to have_content("Your account has been suspended, please contact customer support.")
  end
end