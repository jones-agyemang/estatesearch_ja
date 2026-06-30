require 'rails_helper'

RSpec.describe Lawyer, type: :model do
  it { is_expected.to have_many(:responses) }
end
