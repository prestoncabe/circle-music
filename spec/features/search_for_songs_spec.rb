require 'spec_helper'

feature 'Search for songs' do
  scenario 'from the homepage' do
    song_not_searched_for = create(:song, title: 'Come Thou Fount')
    song_searched_for = create(:song, title: 'Lord I Lift')

    visit root_path

    fill_in 'Search songs', with: 'Lord'
    click_button 'Go'

    expect(page).to have_text song_searched_for.title
    expect(page).not_to have_text song_not_searched_for.title
  end
end
