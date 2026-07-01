require "rails_helper"

RSpec.describe "Response", type: :request do
  let(:lawyer) { create(:lawyer) }
  let(:question_owner) { create(:user) }
  let(:question) { create(:question, user: question_owner) }

  before { sign_in lawyer }

  describe "GET /questions/:question_id/responses/new" do
    it "renders the new response form" do
      get new_question_response_path(question)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Respond to Question")
      expect(response.body).to include("Submit response")
    end
  end

  describe "POST /questions/:question_id/responses" do
    context "with valid parameters" do
      let(:response_params) do
        {
          response: {
            body: "I can help with this estate search.",
            fee: "125.50"
          }
        }
      end

      it "creates a response for the question and redirects to the lawyer dashboard" do
        expect do
          post question_responses_path(question), params: response_params
        end.to change(Response, :count).by(1)

        created_response = Response.last

        expect(created_response).to have_attributes(
          body: "I can help with this estate search.",
          fee: BigDecimal("125.50"),
          lawyer: lawyer,
          question: question
        )
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(lawyers_dashboard_path)

        follow_redirect!

        expect(response.body).to include("Successfully submitted response.")
      end

      it "sends a simulated payment request" do
        expect do
          post question_responses_path(question), params: response_params
        end.to change(PaymentRequest, :count).by(1)

        payment_request = PaymentRequest.last

        expect(payment_request).to have_attributes(
          lawyer: lawyer,
          response: Response.last
        )
      end
    end

    context "with invalid parameters" do
      let(:response_params) do
        {
          response: {
            body: "",
            fee: "125.50"
          }
        }
      end

      it "does not create a response and renders the form with errors" do
        expect do
          post question_responses_path(question), params: response_params
        end.not_to change(Response, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Response is invalid.")
        expect(CGI.unescapeHTML(response.body)).to include("Body can't be blank")
      end
    end
  end
end
