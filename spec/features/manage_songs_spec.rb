require 'spec_helper'

feature 'Add new song' do
  scenario 'from the homepage' do
    visit root_path

    sign_up_as 'person@example.com'

    click_link 'Add a song'
    fill_in 'Title', with: 'Come Thou Fount'
    click_button 'Create Song'

    expect(page).to have_css 'li.song', text: 'Come Thou Fount'
  end

  scenario 'visitors cannot add songs from homepage' do
    visit root_path

    expect(page).not_to have_link 'Add a song'
  end

  scenario 'visitors cannot add songs via new_song_path' do
    visit new_song_path

    expect(page).to have_content 'Sign up'
    expect(current_path).to eq sign_in_path
  end
end
