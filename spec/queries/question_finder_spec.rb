# frozen_string_literal: true

require "rails_helper"

RSpec.describe QuestionFinder, type: :queries do
  describe '.call' do
    subject(:query_results) { described_class.call(owner_id:) }

    describe 'question retrieval' do
      describe 'ordering' do
        let(:user) { create(:user) }
        let(:owner_id) { user.id }

        it 'returns the latest questions' do
          older_question = create(:question, user:, updated_at: 7.days.ago)
          latest_question = create(:question, user:, updated_at: 1.day.ago)

          expect(query_results.first).to eq(latest_question)
          expect(query_results.last).to eq(older_question)
        end
      end

      context 'when owner does not exist' do
        let(:owner_id) { 'foo' }

        it 'yields no results' do
          expect(query_results).to eq([])
        end
      end

      context 'when owner-type is "User"' do
        let(:owner) { create(:user) }
        let(:owner_id) { owner.id }

        it 'returns only questions owned by the user' do
          other_user = create(:user)
          user_owned_questions = create_list(:question, 3, user: owner)
          questions_owned_by_other_user = create_list(:question, 3, user: other_user).pluck(:id)

          expect(query_results).to include(*user_owned_questions)
          expect(query_results).not_to include(*questions_owned_by_other_user)
        end
      end

      context 'when owner-type is "Lawyer"' do
        let(:owner) { create(:lawyer) }
        let(:owner_id) { owner.id }

        it "returns only 'open' questions from all users" do
          user_1 = create(:user)
          user_2 = create(:user)

          open_question_1     = create(:question, user: user_1)
          open_question_2     = create(:question, user: user_2)
          answered_question_1 = create(:question, :answered, user: user_1)
          answered_question_2 = create(:question, :answered, user: user_2)
          closed_question_1   = create(:question, :closed, user: user_1)
          closed_question_2   = create(:question, :closed, user: user_2)

          expected_questions = [
            open_question_1,
            open_question_2
          ]
          unexpected_questions = [
            answered_question_1,
            answered_question_2,
            closed_question_1,
            closed_question_2
          ]

          expect(query_results).to include(*expected_questions)
          expect(query_results).not_to include(*unexpected_questions)
        end
      end
    end
  end
end
