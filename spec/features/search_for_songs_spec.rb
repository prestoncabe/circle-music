require 'spec_helper'

feature 'Search for songs' do
  scenario 'from the homepage' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')

    visit root_path

    fill_in 'Search songs', with: 'Lord'
    click_button 'Go'

    expect(page).to have_content 'Lord I Lift'
    expect(page).not_to have_content 'Come Thou Fount'
  end
end
