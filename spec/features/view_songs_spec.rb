require 'spec_helper'

feature 'View songs' do
  scenario 'as a visitor to songs index page' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')

    visit songs_path

    expect(page).to have_css 'li.song', text: 'Come Thou Fount'
    expect(page).to have_css 'li.song', text: 'Lord I Lift'
  end
end
