require 'rails_helper'

RSpec.describe "Api::V1::Tenants", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/tenants/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/tenants/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/tenants/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/tenants/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/tenants/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
