require "rails_helper"

RSpec.describe DashboardPathResolver, type: :service do
  let(:routes) { double("routes") }

  subject(:resolved_path) { described_class.call(user, routes) }

  describe ".call" do
    context "when user type is 'user'" do
      let(:user) { create(:user) }

      it "sets to 'User' dashboard path" do
        dashboard_link = "/users/dashboard"
        allow(routes).to receive(:users_dashboard_path).and_return(dashboard_link)

        expect(resolved_path).to eq(dashboard_link)
      end
    end

    context "when user type is 'lawyer'" do
      let(:user) { create(:lawyer) }

      it "sets to 'Lawyer' dashboard path" do
        dashboard_link = "/lawyers/dashboard"
        allow(routes).to receive(:lawyers_dashboard_path).and_return(dashboard_link)

        expect(resolved_path).to eq(dashboard_link)
      end
    end
  end
end
