require 'rails_helper'

describe 'The authentication process', type: :feature do
  describe 'creating a new account' do
    it 'can create a new account' do
      visit '/'

      click_on 'Sign up'

      expect(page).to have_button('Create Account')

      fill_in 'Name', with: 'Yukihiro Matsumoto'
      fill_in 'login', with: 'matz@fakeemail.com' # Fix this
      fill_in 'Password', with: 'fake_password'
      fill_in 'Confirm Password', with: 'fake_password'

      click_on 'Create Account'

      expect(page).to have_content 'An email has been sent to you with a link to verify your account'
    end
  end

  describe 'signing in' do
    it 'can sign into an account' do
      account = create(:account, email: 'a@a.com', password: 'password')

      visit '/'

      click_on 'Sign in'

      expect(page).to have_button('Login')

      fill_in 'Login', with: account.email
      fill_in 'Password', with: 'password'

      click_on 'Login'

      expect(page).to have_content('You have been logged in')
    end
  end
end
