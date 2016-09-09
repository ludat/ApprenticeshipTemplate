require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe "GET #list" do
    it "returns http success" do
      get :list
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    skip "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end
end
