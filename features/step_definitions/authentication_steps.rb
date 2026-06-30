When('I visit the login page') do
  visit '/users/sign_up'
end

When('I enter my registration details') do
  fill_in "user[email]", with: "john.pearson@example.com"
  fill_in "user[password]", with: "s3cure_p455word"
  fill_in "user[password_confirmation]", with: "s3cure_p455word"
  click_button "Sign up"
end

Then('I should be granted access') do
  expect(page).to have_content("Logged in as")
end

Given('I registered with email {string} and password {string} as user of type {string}') do |email, password, user_type|
  user_type.camelcase.constantize.create!(
    email: email,
    password: password,
    password_confirmation: password
  )
end

Given('I am a registered user') do
  User.create!(
    email: "john.pearson@example.com",
    password: "s3cure_p455word",
    password_confirmation: "s3cure_p455word"
  )
end

When('I log in with valid credentials') do
  visit '/users/sign_in'
  fill_in "user[email]", with: "john.pearson@example.com"
  fill_in "user[password]", with: "s3cure_p455word"
  click_button "Log in"
end

When('I log in with email {string} and password {string}') do |email, password|
  visit '/users/sign_in'
  fill_in "user[email]", with: email
  fill_in "user[password]", with: password
  click_button "Log in"
end
