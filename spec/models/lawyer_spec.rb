require 'rails_helper'

RSpec.describe Lawyer, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:responses).dependent(:destroy) }
    it { is_expected.to have_many(:answered_questions).through(:responses).source(:question) }
    it { is_expected.to have_many(:payment_requests).through(:responses) }
  end
end
