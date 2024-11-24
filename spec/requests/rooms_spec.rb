require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /rooms" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "アクセスができていること" do
      get rooms_path
      expect(response).to have_http_status(:ok)
    end
  end
end
