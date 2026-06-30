SIGN_IN_PASSWORD = "s3cure_p455word"
SIGN_IN_USER_EMAIL = "john.pearson@example.com"
SIGN_IN_LAWYER_EMAIL = "lawyer.john.pearson@example.com"

def create_sign_in_account(user_class, email)
  user = user_class.find_or_initialize_by(email: email)
  user.password = SIGN_IN_PASSWORD
  user.password_confirmation = SIGN_IN_PASSWORD
  user.save!
end

def sign_in_with(email, password)
  visit "/users/sign_in"
  fill_in "user[email]", with: email
  fill_in "user[password]", with: password
  click_button "Log in"
end

Before('@sign_in_user') do
  create_sign_in_account(User, SIGN_IN_USER_EMAIL)
  sign_in_with(SIGN_IN_USER_EMAIL, SIGN_IN_PASSWORD)
end

Before('@sign_in_lawyer') do
  create_sign_in_account(Lawyer, SIGN_IN_LAWYER_EMAIL)
  sign_in_with(SIGN_IN_LAWYER_EMAIL, SIGN_IN_PASSWORD)
end

After('@sign_out') do
  click_button "Sign out" if page.has_button?("Sign out", wait: 0)
end
