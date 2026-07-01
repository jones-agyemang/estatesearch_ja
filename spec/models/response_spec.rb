require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:lawyer).class_name("Lawyer") }
    it { is_expected.to have_one(:payment_request).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_numericality_of(:fee) }
  end
end
