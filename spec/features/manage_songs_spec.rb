require 'spec_helper'

feature 'Manage songs' do
  background do
    @generic_user = create(:user)
  end

  scenario 'add new song from homepage' do
    visit root_path as: @generic_user

    add_song(title: 'Come Thou Fount', notes: 'an oldie-but-goodie hymn')

    user_sees_song_titled 'Come Thou Fount'
  end

  scenario 'add new song from songs index' do
    visit songs_path as: @generic_user

    add_song title: 'Come Thou Fount'

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

  scenario 'add link as a user' do
    song = create(:song)
    visit song_path(song, as: @generic_user)

    click_link 'New Link'
    fill_in 'Name', with: 'Cool Video Performance'
    fill_in 'Url', with: 'http://www.youtube.com'
    click_button 'Add Link'

    expect(page).to have_text 'Cool Video Performance'
  end

  scenario 'guests do not see New Link option on song show page' do
    song = create(:song)
    visit song_path(song)

    expect(page).not_to have_text 'New Link'
  end

  scenario 'guests cannot add link via new_song_link path' do
    song = create(:song)
    visit new_song_link_path(song)

    expect(current_path).to eq sign_in_path
  end

  def add_song(options={})
    click_link 'Add a song'
    fill_in 'Title', with: options.fetch(:title, '')
    fill_in 'Notes', with: options.fetch(:notes, '')
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

