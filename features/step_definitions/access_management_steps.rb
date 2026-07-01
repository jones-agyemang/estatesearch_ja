Given("I am signed in as a lawyer") do
  create_sign_in_account(Lawyer, SIGN_IN_LAWYER_EMAIL)
  sign_in_with(SIGN_IN_LAWYER_EMAIL, SIGN_IN_PASSWORD)
end

Given("I am signed in as a user") do
  create_sign_in_account(User, SIGN_IN_USER_EMAIL)
  sign_in_with(SIGN_IN_USER_EMAIL, SIGN_IN_PASSWORD)
end

When("I visit the lawyer dashboard") do
  visit lawyers_dashboard_path
end

Then("I should see the lawyer dashboard") do
  expect(page).to have_current_path(lawyers_dashboard_path)
  expect(page).to have_content("Questions")
  expect(page).to have_content("Logged in as")
end

Then("I should be redirected to my user dashboard") do
  expect(page).to have_current_path(users_dashboard_path)
end

Then("I should see that the lawyer dashboard is restricted to lawyers") do
  expect(page).to have_content("You must be a lawyer to access the lawyer dashboard.")
end
