require 'spec_helper'

feature 'Manage songs' do
  background do
    @user = create(:user)
  end

  scenario 'add new song from homepage' do
    visit root_path as: @user

    add_song_with_title 'Come Thou Fount'

    user_sees_song_titled 'Come Thou Fount'
  end

  scenario 'add new song from songs index' do
    visit songs_path as: @user

    add_song_with_title 'Come Thou Fount'

    user_sees_song_titled 'Come Thou Fount'
  end

  scenario 'guest cannot add songs from homepage' do
    visit root_path

    expect(page).not_to have_link 'Add a song'
  end

  scenario 'guest cannot add songs via new_song_path' do
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

