require 'spec_helper'

feature 'Sign up' do
  scenario 'as a visitor' do
    visit root_path

    click_link 'Sign up'

    fill_in 'Email', with: 'person@example.com'
    fill_in 'Password', with: '1234'

    click_button 'Sign up'

    expect(page).to have_title 'CircleMusic'
    expect(page).to have_css '[data-role="description"]'
  end

end
