module AuthenticationFlowHelper
  def log_in(email:, password:)
    click_on 'Sign in'

    expect(page).to have_button('Login')

    fill_in 'Login', with: email
    fill_in 'Password', with: password

    click_on 'Login'

    expect(page).to have_content('You have been logged in')
  end

  def visit_and_login(url, email:, password:)
    visit url

    log_in(email:, password:)
  end
end

RSpec.configure { _1.include AuthenticationFlowHelper, type: :feature }
