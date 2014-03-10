require 'spec_helper'

feature 'View songs' do
  scenario 'as a visitor to songs index page' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')

    visit songs_path

    expect(page).to have_css 'li.song', text: 'Come Thou Fount'
    expect(page).to have_css 'li.song', text: 'Lord I Lift'
  end

  scenario 'as a user on songs index page' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')

    sign_up

    visit songs_path

    expect(page).to have_css 'li.song', text: 'Come Thou Fount'
    expect(page).to have_css 'li.song', text: 'Lord I Lift'
  end

  scenario 'as a visitor to songs show page' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')

    visit songs_path
    click_link 'Come Thou Fount'

    expect(page).to have_content 'Come Thou Fount'
    expect(page).not_to have_content 'Lord I Lift'
  end
end
