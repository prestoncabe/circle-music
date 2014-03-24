require 'spec_helper'

feature 'Sign up' do
  scenario 'guests can sign up from the homepage' do
    visit root_path

    sign_up_as 'person@example.com'

    expect(page).to have_title 'CircleMusic'
    expect(page).to have_css '[data-role="description"]'
    expect(page).to have_text 'Signed in as: person@example.com'
  end

  scenario 'signed in users do not see sign up link' do
    visit root_path

    sign_up

    expect(page).to have_css '[data-role="description"]'
    expect(page).not_to have_link 'Sign up'
  end
end
