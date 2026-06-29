When('I visit the legal advice board') do
  visit '/'
end

When('I enter valid query details') do
  fill_in 'question[title]', with: 'Freehold Fees'
  fill_in 'question[body]', with: "How can I redeem myself from a deed that demands hefty bills?"
  fill_in 'question[category]', with: 'Propery Law'
  click_button "Submit query"
end

Then('I should receive a notification of success') do
  expect(page).to have_content('Query successfully raised!')
end
