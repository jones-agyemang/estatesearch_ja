Given('there are open questions') do
  user = User.create!(
    email: Faker::Internet.email,
    password: "s3cure_p455word",
    password_confirmation: "s3cure_p455word"
  )

  user.questions.create!(
    title: "Open Question#a89cvbx",
    body: Faker::Lorem.sentences.first,
    category: Faker::Lorem.sentence
  )
end

Then('I should be able to see the open questions') do
  expect(page).to have_content("Open Question#a89cvbx")
end

When('I provide a response to a question') do
  visit "/lawyers/dashboard"

  click_on "Respond"
  fill_in "response[body]", with: Faker::Lorem.sentence
  fill_in "response[fee]", with: "20.00"
  click_button "Submit response"
end
