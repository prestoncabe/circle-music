require 'spec_helper'

feature 'View the homepage' do
  scenario 'as a visitor' do
    visit root_path

    expect(page).to have_title 'CircleMusic'
    expect(page).to have_css '[data-role="description"]'
  end
end
