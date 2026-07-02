require "rails_helper"

RSpec.describe Payments::Approval, type: :service do
  describe ".call" do
    let(:user) { create(:user) }
    let(:question) { create(:question, user:) }
    let(:lawyer) { create(:lawyer) }
    let!(:response) { create(:response, paid:, question:, lawyer:) }
    let!(:payment_request) { create(:payment_request, lawyer:, response:) }

    subject(:invoke_payment_approval!) do
      described_class.call(user, question, response.id)
    end

    context "when payment request is unpaid" do
      let(:paid) { false }

      it "approves payment and marks question as answered" do
        result = invoke_payment_approval!

        expect(response.reload).to be_paid
        expect(question.reload).to be_answered

        expect(result.success?).to eq(true)
        expect(result.message).to eq("Payment approved and question marked as answered.")
      end
    end
  end
end
