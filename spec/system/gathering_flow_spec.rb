require 'rails_helper'
require 'support/authentication_flow_helper'
require 'support/screenshot_helper'

describe 'The Gathering flow', type: :feature do
  let!(:account) { create(:account) }

  let!(:supper) do
    eastern_time = ActiveSupport::TimeZone["Eastern Time (US & Canada)"]

    build(:outing,
      name: 'Day One Supper',
      start_time: eastern_time.parse('2023-04-23 5:00pm'),
      end_time: eastern_time.parse('2023-04-23 7:00pm'),
      description: 'Folks gotta eat!'
    )
  end

  let!(:railsconf_2023) do
    create(:railsconf_2023, accounts: [account], outings: [supper])
  end

  it 'can be assigned to a group for an outing' do
    visit_and_login('/',
      email: account.email,
      password: 'password'
    )

    potentially_screenshot 'rails_conf_2023/02/logging_in.png'

    click_on railsconf_2023.name

    potentially_screenshot 'rails_conf_2023/02/clicked_rails_conf.png'

    click_on supper.name

    potentially_screenshot 'rails_conf_2023/02/clicked_supper.png'

    click_on 'Join Group'

    potentially_screenshot 'rails_conf_2023/02/clicked_join_group.png'

    # Redirected to the group's page
    expect(page).to have_content('Members')
    expect(page).to have_content(account.email)

    # Make this accessible later, as this feels structural
    group_name = page.find('h3').text

    # Let's go back up
    click_on 'Back to outing'

    potentially_screenshot 'rails_conf_2023/02/clicked_back_to_outing.png'

    # The join button should be gone and replaced with a
    # link to your group
    expect(page).to have_content("Your Group is: #{group_name}")
    expect(page).to_not have_button('Join Group')

    # Let's go back into it, just to be sure
    click_on group_name

    potentially_screenshot 'rails_conf_2023/02/clicked_back_to_group.png'

    expect(page).to have_content(group_name)
  end
end
