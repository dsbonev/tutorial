include ApplicationHelper

def signin_user(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    find('div.alert.alert-error').text.should eq message
  end
end
