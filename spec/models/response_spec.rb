require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:lawyer).class_name("Lawyer") }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
  end
end
