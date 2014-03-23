require 'spec_helper'

feature 'Manage songs' do
  background do
    @generic_user = create(:user)
  end

  scenario 'add new song from homepage' do
    visit root_path as: @generic_user

    add_song_with_title 'Come Thou Fount'

    user_sees_song_titled 'Come Thou Fount'
  end

  scenario 'add new song from songs index' do
    visit songs_path as: @generic_user

    add_song_with_title 'Come Thou Fount'

    user_sees_song_titled 'Come Thou Fount'
  end

  scenario 'guest cannot add song from homepage' do
    visit root_path

    expect(page).not_to have_link 'Add a song'
  end

  scenario 'guest cannot add song via new_song_path' do
    visit new_song_path

    expect(current_path).to eq sign_in_path
  end

  scenario 'delete song as admin from songs index page' do
    song_to_delete = create(:song, title: 'Come Thou Fount')
    song_to_keep = create(:song, title: 'Lord I Lift')
    admin_user = create(:user, email: 'admin@example.com', admin: true)

    visit songs_path as: admin_user
    click_delete_for_song(song_to_delete)

    user_does_not_see_song(song_to_delete)
    user_sees_song(song_to_keep)
  end

  scenario 'non-admins cannot delete songs' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')
    non_admin_user = create(:user, email: 'nonadmin@example.com')

    visit songs_path as: non_admin_user

    expect(page).not_to have_text 'delete'
  end

  def add_song_with_title(title)
    click_link 'Add a song'
    fill_in 'Title', with: title
    click_button 'Create Song'
  end

  def click_delete_for_song(song)
    within "li.song:contains('#{song.title}')" do
      click_link 'delete'
    end
  end
  def user_sees_song_titled(title)
    expect(page).to have_css 'li.song', text: title
  end

  def user_sees_song(song)
    expect(page).to have_css 'li.song', text: song.title
  end

  def user_does_not_see_song(song)
    expect(page).not_to have_css 'li.song', text: song.title
  end
end

