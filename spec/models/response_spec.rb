require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:lawyer) }
  end
end
