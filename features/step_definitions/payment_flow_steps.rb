Given('I have a question with a response') do
  user = User.last

  lawyer = FactoryBot.create(:lawyer)
  question = FactoryBot.create(:question, user: user)
  response = FactoryBot.create(:response, lawyer: lawyer, question: question)
  FactoryBot.create(:payment_request, lawyer: lawyer, response: response)
end

When('I approve payment to unlock response') do
  visit('/users/dashboard')
  click_button "Approve payment"
end

Then('I should see response') do
  expect(page).to have_content("Payment approved and question marked as answered")
end
