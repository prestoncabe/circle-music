require 'spec_helper'

feature 'Delete a song' do
  scenario 'as an admin user on songs index page' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')
    admin_user = create(:user, admin: true)

    visit songs_path as: admin_user
    within "li.song:contains('Lord I Lift')" do
      click_link 'delete'
    end

    expect(page).not_to have_content 'Lord I Lift'
  end

  scenario '(non-admin user does not see delete link on songs index page)' do
    create(:song, title: 'Come Thou Fount')
    create(:song, title: 'Lord I Lift')
    non_admin_user = create(:user)

    visit songs_path as: non_admin_user

    expect(page).not_to have_content 'delete'
  end
end
