require 'rails_helper'

RSpec.describe PaymentRequest, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:lawyer).class_name("Lawyer") }
    it { is_expected.to belong_to(:response) }
  end
end
