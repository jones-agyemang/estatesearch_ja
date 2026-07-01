require 'rails_helper'

RSpec.describe "Payment Approval", type: :request do
  describe "PATCH /questions/:question_id/responses/:id/approve_payment" do
    let(:user) { create(:user) }
    let(:lawyer) { create(:lawyer) }
    let(:question) { create(:question, user:) }
    let(:question_response) { create(:response, question:, lawyer:) }

    before do
      create(:payment_request, response: question_response, lawyer:)
      sign_in user
    end

    it "marks the answer as paid and the question as answered" do
      patch approve_payment_question_response_path(question, question_response)

      expect(response).to redirect_to(users_dashboard_path)
      expect(question_response.reload).to be_paid
      expect(question.reload).to be_answered
    end
  end
end
