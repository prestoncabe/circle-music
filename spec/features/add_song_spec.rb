require 'spec_helper'

feature 'Add new song' do
  scenario 'from the homepage' do
    visit root_path

    sign_up

    add_song_with_title 'Come Thou Fount'

    user_sees_song_titled 'Come Thou Fount'
  end

  scenario 'from songs index' do
    visit root_path

    sign_up

    visit songs_path

    add_song_with_title 'Come Thou Fount'

    user_sees_song_titled 'Come Thou Fount'
  end

  scenario 'visitors cannot add songs from homepage' do
    visit root_path

    expect(page).not_to have_link 'Add a song'
  end

  scenario 'visitors cannot add songs via new_song_path' do
    visit new_song_path

    expect(current_path).to eq sign_in_path
  end

  def add_song_with_title(title)
    click_link 'Add a song'
    fill_in 'Title', with: title
    click_button 'Create Song'
  end

  def user_sees_song_titled(title)
    expect(page).to have_css 'li.song', text: 'Come Thou Fount'
  end
end

