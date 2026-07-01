# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

dummy_user = User.find_or_create_by!(email: "john.doe@example.com") do |user|
  user.password = "t0ps3kr3t"
end
Lawyer.find_or_create_by!(email: "lawyer.jane.doe@example.com") do |lawyer|
  lawyer.password = "utm05ts3kr3t"
end

[
  {
    title: "My employer is refusing reasonable adjustments",
    body: "I have a disability and requested adjustments recommended by my occupational health assessment. My employer has refused to implement them. What are my rights?",
    category: "Employment"
  },
  {
    title: "Can my landlord evict me because they want to sell the property?",
    body: "My landlord has told me they want to sell the house and has asked me to leave within two weeks. Is this a lawful eviction?",
    category: "Housing"
  },
  {
    title: "Someone is posting false statements about me online",
    body: "An individual has been posting false allegations about me on social media which are affecting my reputation and business. What legal action can I take?",
    category: "Defamation"
  }
].each do |question_attributes|
  dummy_user.questions.create!(question_attributes)
end
