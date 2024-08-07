require 'rails_helper'

RSpec.describe "User Log In" do
  it 'can log in a user with correct credentials' do
    user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')

    visit "/"

    click_link "Log In"

    fill_in :email, with:'email@example.com'
    fill_in :password, with: 'password123'
    click_button 'Log In'

    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not log in user with incorrect credentials' do 
    user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')

    visit "/"

    click_link "Log In"

    fill_in :email, with:'email@example.com'
    fill_in :password, with: 'nottherightpassword'
    click_button 'Log In'


    expect(current_path).to eq("/login")
    expect(page).to have_content("Bad Credentials, try again.")
    
  end

  it "can set location with a cookie" do
    user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')

    visit "/"

    click_link "Log In"

    fill_in :email, with:'email@example.com'
    fill_in :password, with: 'password123'
    fill_in :location, with: "Denver"
    click_button 'Log In'

    expect(page).to have_content("Location: Denver")

    visit login_path
    expect(page).to have_field('Location', with: 'Denver')
  end
end
