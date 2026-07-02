# frozen_string_literal: true

require "rails_helper"

RSpec.describe Devise::RegistrationsHelper, type: :helper do
  describe "#registration_path" do
    subject(:resolve_path) { registration_path(resource, routes) }

    let(:routes) { spy('routes') }

    context "when resource is 'undefined'" do
      let(:resource) { Class }

      it 'returns default registration path' do
        resolve_path
        expect(routes).to have_received(:user_registration_path)
      end
    end

    context "when resource is 'Lawyer'" do
      let(:resource) { create(:lawyer) }

      it 'returns registration path for lawyers' do
        resolve_path
        expect(routes).to have_received(:lawyer_registration_path)
      end
    end
  end
end
