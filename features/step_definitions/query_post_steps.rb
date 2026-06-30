When('I visit the legal advice board') do
  visit '/'
end

When('I enter valid query details') do
  fill_in 'question[title]', with: 'Freehold Fees'
  fill_in 'question[body]', with: "How can I redeem myself from a deed that demands hefty bills?"
  fill_in 'question[category]', with: 'Propery Law'
  click_button "Submit query"
end

When('I enter a question with title {string}, body {string} and category {string}') do |title, body, category|
  fill_in 'question[title]', with: title
  fill_in 'question[body]', with: body
  fill_in 'question[category]', with: category
  click_button "Submit query"
end

Then('I should see notification {string}') do |notification|
  expect(page).to have_content(notification)
end

Then('I should see status as {string}') do |status|
  expect(page).to have_content(status)
end
