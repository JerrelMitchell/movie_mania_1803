# as a visit
# when i submit a valid completed registration form
# then I have an account created

require 'rails_helper'

describe 'visitor' do
  context 'logs in' do
    it 'should log in user' do
      username = 'octocat'
      password = 'secret'
      user = User.create!(username: username, password: password)

      visit '/'
      click_on 'Log In'

      expect(current_path).to eq(login_path)

      fill_in :username, with: username
      fill_in :password, with: password
      click_on 'Log In'

      expect(current_path).to eq(user_path(user))
      expect(page).to have_link('Log Out')
    end
  end

  context 'fills out registration form' do
    it 'should make a user account successfully' do
      username = 'octocat'

      visit '/'

      click_on 'Sign up to be a Movie Watcher'

      expect(current_path).to eq(new_user_path)

      fill_in :user_username, with: username
      fill_in :user_password, with: 'supersecret'

      click_on 'Create User'

      expect(current_path).to eq(user_path(User.last))
      expect(page).to have_content("Welcome, #{username}!")
    end

    it 'should not allow duplicate user names' do
      username = 'octocat'
      user1 = User.create!(username: username, password: 'secret')

      visit new_user_path

      fill_in :user_username, with: username
      fill_in :user_password, with: 'supersecret'

      click_on 'Create User'

      expect(current_path).to eq(users_path)
    end
  end
end
