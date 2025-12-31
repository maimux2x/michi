module LoginHelper
  def sign_in(user)
    visit new_session_path
    fill_in 'email_address', with: user.email_address
    fill_in 'password', with: 'password'
    click_button 'Sign in'
  end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :system
end
