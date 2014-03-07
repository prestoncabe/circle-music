module SignUpHelpers
  def sign_up_as(email)
    visit root_path

    click_link 'Sign up'

    fill_in 'Email', with: email
    fill_in 'Password', with: '1234'

    click_button 'Sign up'
  end

  def sign_up
    sign_up_as 'person@example.com'
  end
end

RSpec.configure do |config|
  config.include SignUpHelpers
end
