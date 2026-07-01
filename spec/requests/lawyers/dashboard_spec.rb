require "rails_helper"

RSpec.describe "Lawyer dashboard", type: :request do
  describe "GET /lawyers/dashboard" do
    context "when the user is a lawyer" do
      let(:lawyer) { create(:lawyer) }
      let(:question_owner) { create(:user) }

      before { sign_in lawyer }

      it "shows the lawyer dashboard" do
        open_question = create(:question, user: question_owner)
        answered_question = create(:question, :answered, user: question_owner)

        get lawyers_dashboard_path

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Logged in as: #{lawyer.email}")
        expect(response.body).to include(open_question.title)
        expect(response.body).not_to include(answered_question.title)
      end
    end

    context "when the user is not a lawyer" do
      let(:user) { create(:user) }

      before { sign_in user }

      it "redirects to the user dashboard" do
        get lawyers_dashboard_path

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(users_dashboard_path)

        follow_redirect!

        expect(response.body).to include("You must be a lawyer to access the lawyer dashboard.")
      end
    end

    context "when the user is not signed in" do
      it "redirects to the sign in page" do
        get lawyers_dashboard_path

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
