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
end
