require 'rails_helper'
require 'support/authentication_flow_helper'
require 'support/screenshot_helper'

describe 'The authentication process', type: :feature do
  describe 'creating a new account' do
    it 'can create a new account' do
      visit '/'

      potentially_screenshot 'rails_conf_2023/01/visit_root.png'

      click_on 'Sign up'

      expect(page).to have_button('Create Account')

      potentially_screenshot 'rails_conf_2023/01/pre_form_filled.png'

      fill_in 'Name', with: 'Yukihiro Matsumoto'
      potentially_screenshot 'rails_conf_2023/01/form_name_filled_email_error_upcoming.png'

      fill_in 'Email', with: 'matz@fakeemail.com'
      fill_in 'Password', with: 'fake_password'
      fill_in 'Confirm Password', with: 'fake_password'

      potentially_screenshot 'rails_conf_2023/01/post_form_filled.png'

      click_on 'Create Account'

      expect(page).to have_content 'An email has been sent to you with a link to verify your account'

      potentially_screenshot 'rails_conf_2023/01/post_flash_message.png'
    end
  end

  describe 'signing in' do
    it 'can sign into an account' do
      account = create(:account, email: 'a@a.com', password: 'password')

      visit_and_login('/',
        email: account.email,
        password: 'password'
      )
    end
  end
end
