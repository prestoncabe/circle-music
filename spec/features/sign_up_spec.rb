require 'spec_helper'

feature 'Sign up' do
  scenario 'visitors can sign up from the homepage' do
    visit root_path

    click_link 'Sign up'

    fill_in 'Email', with: 'person@example.com'
    fill_in 'Password', with: '1234'

    click_button 'Sign up'

    expect(page).to have_title 'CircleMusic'
    expect(page).to have_css '[data-role="description"]'
  end

  scenario 'signed in users do not see sign up link' do
    visit root_path

    click_link 'Sign up'

    fill_in 'Email', with: 'person@example.com'
    fill_in 'Password', with: '1234'

    click_button 'Sign up'

    expect(page).to have_css '[data-role="description"]'
    expect(page).not_to have_link 'Sign up'
  end
end
