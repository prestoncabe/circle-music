require 'spec_helper'

feature 'View songs' do
  background do
    create_songs ['Come Thou Fount', 'Lord I Lift']
    @user = create(:user)
  end

  scenario 'guest can navigate to song list from the homepage' do
    visit root_path

    click_link 'Song list'

    guest_sees_list_of_songs
  end

  scenario 'guest can navigate back to song list from individual song' do
    visit songs_path

    click_song_title_link
    click_link 'Back to song list'

    guest_sees_list_of_songs
  end

  scenario 'guest can view individual song from song list' do
    visit songs_path

    click_song_title_link

    guest_sees_song_show_page
  end


  scenario 'user can navigate to song list from the homepage' do
    visit root_path as: @user

    click_link 'Song list'

    user_sees_list_of_songs
  end

  scenario 'user can navigate back to song list from individual song' do
    visit songs_path as: @user

    click_song_title_link
    click_link 'Back to song list'

    user_sees_list_of_songs
  end

  scenario 'user can view individual song from song list' do
    visit songs_path as: @user

    click_song_title_link

    user_sees_song_show_page
  end

  def create_songs(song_titles)
    song_titles.each do |song_title|
      create(:song, title: song_title)
    end
  end

  def user_sees_list_of_songs
    expect(page).to have_css 'li.song', text: 'Come Thou Fount'
    expect(page).to have_css 'li.song', text: 'Lord I Lift'
  end

  def guest_sees_list_of_songs
    user_sees_list_of_songs
  end

  def click_song_title_link
    click_link 'Come Thou Fount'
  end

  def guest_sees_song_show_page
    expect(page).to have_text 'Come Thou Fount'
    expect(page).to have_text 'these are some miscellaneous notes'
    expect(page).not_to have_text 'Lord I Lift'
  end

  def user_sees_song_show_page
    guest_sees_song_show_page
  end
end
