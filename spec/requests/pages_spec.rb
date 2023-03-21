require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /event_sign_in" do
    it "returns http success" do
      get "/pages/event_sign_in"
      expect(response).to have_http_status(:success)
    end
  end

end
