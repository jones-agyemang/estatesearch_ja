require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:category) }
  end

  it do
    is_expected.to define_enum_for(:status).with_values(%i[open answered closed])
                                           .with_default(:open)
  end
end
