require 'spec_helper'

feature 'View songs' do
  background do
    create_songs ['Come Thou Fount', 'Lord I Lift']
  end

  context 'visitors' do

    scenario 'can navigate to song list from the homepage' do
      visit root_path

      click_link 'Song list'

      visitor_sees_list_of_songs
    end

    scenario 'can navigate back to song list from individual song' do
      visit songs_path

      click_song_title_link
      click_link 'Back to song list'

      visitor_sees_list_of_songs
    end

    scenario 'can view song list' do
      visit songs_path

      visitor_sees_list_of_songs
    end

    scenario 'can view individual song' do
      visit songs_path

      click_song_title_link

      visitor_sees_song_show_page
    end

  end

  context 'users' do

    background do
      @user = create(:user)
    end

    scenario 'can navigate to song list from the homepage' do
      visit root_path as: @user

      click_link 'Song list'

      user_sees_list_of_songs
    end

    scenario 'can navigate back to song list from individual song' do
      visit songs_path as: @user

      click_song_title_link
      click_link 'Back to song list'

      user_sees_list_of_songs
    end

    scenario 'can view song list' do
      visit songs_path as: @user

      user_sees_list_of_songs
    end

    scenario 'can view individual song' do
      visit songs_path as: @user

      click_song_title_link

      user_sees_song_show_page
    end
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

  def visitor_sees_list_of_songs
    user_sees_list_of_songs
  end

  def click_song_title_link
    click_link 'Come Thou Fount'
  end

  def visitor_sees_song_show_page
    expect(page).to have_content 'Come Thou Fount'
    expect(page).not_to have_content 'Lord I Lift'
  end

  def user_sees_song_show_page
    visitor_sees_song_show_page
  end
end
