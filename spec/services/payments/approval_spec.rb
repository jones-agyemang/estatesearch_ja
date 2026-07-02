require "rails_helper"

RSpec.describe Payments::Approval, type: :service do
  describe ".call" do
    let(:user) { create(:user) }
    let(:question) { create(:question, user:) }
    let(:lawyer) { create(:lawyer) }
    let!(:response) { create(:response, question:, lawyer:) }
    let!(:payment_request) { create(:payment_request, lawyer:, response:) }

    subject(:invoke_payment_approval!) do
      described_class.call(user, question, response.id)
    end

    context "when payment request is unpaid" do
      # let(:paid) { false }

      context "when question is open" do
        it "approves payment and marks question as answered" do
          result = invoke_payment_approval!

          expect(response.reload).to be_paid
          expect(question.reload).to be_answered

          expect(result.success?).to eq(true)
          expect(result.message).to eq("Payment approved and question marked as answered.")
        end
      end

      context "when question is closed" do
        let(:question) { create(:question, :closed, user:) }

        it "declines payment and question should remain closed" do
          result = invoke_payment_approval!

          expect(question).to be_closed
          expect(response).not_to be_paid

          expect(result.success?).to eq(false)
          expect(result.message).to eq("Question has already been already answered or close.")
        end
      end
    end

    describe "non-owner cannot approve payment" do
      context "when user is not the owner of the question" do
        let(:other_user) { create(:user) }
        let(:question) { create(:question, user: other_user) }

        it "declines payment and question should remain closed" do
          result = invoke_payment_approval!

          expect(question).to be_open
          expect(response).not_to be_paid

          expect(result.success?).to eq(false)
          expect(result.message).to eq("Question belongs to another user.")
        end
      end
    end
  end
end
