require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'GET /users/:user_id/questions' do
    context 'when user is not authenticated' do
      it 'returns user to login in page' do
        get users_dashboard_path

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      before { sign_in user }

      context "when this is a non-lawyer account" do
        it "returns only questions belonging to the user" do
          my_question = create(:question, user:, title: "My question")
          other_question = create(:question, user: other_user, title: "Not my question")

          get users_dashboard_path

          expect(response).to have_http_status(:ok)
          expect(response.body).to include(my_question.title)
          expect(response.body).not_to include(other_question.title)
        end
      end

      context "when this is a lawyer's account" do
        let!(:user) { create(:lawyer) }

        it "returns all 'open' questions" do
          open_question     = create(:question, user: other_user)
          answered_question = create(:question, :answered, user: other_user)
          closed_question   = create(:question, :closed, user: other_user)

          get lawyers_dashboard_path

          expect(response).to have_http_status(:ok)
          expect(response.body).to include(open_question.title)
          expect(response.body).not_to include(answered_question.title)
          expect(response.body).not_to include(closed_question.title)
        end
      end
    end
  end
end
