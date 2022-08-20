require "rails_helper"

RSpec.describe "Api::V1::Residents", type: :request do
  describe "GET /api/v1/residents" do
    subject { get(api_v1_residents_path, headers: headers) }

    context "入居者が存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      let(:tenant) {create(:tenant, company_id: current_user.company_id)}
      let!(:resident1) { create(:resident, tenant_id: tenant.id) }
      let!(:resident2) { create(:resident, tenant_id: tenant.id) }

      it "入居者一覧が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 2
        expect(res[0].keys).to eq ["id", "care_level", "full_name", "first_name", "last_name", "is_hospitalized","tenant"]
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/v1/residents/:id" do
    subject { get(api_v1_resident_path(resident_id), headers: headers) }

    context "指定したidの施設が存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      let(:tenant) {create(:tenant, company_id: current_user.company_id)}
      let(:resident) { create(:resident, tenant_id: tenant.id) }
      let(:resident_id) { resident.id }

      it "指定した施設が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq resident.id
        expect(res["care_level"]).to eq resident.care_level
        expect(res["full_name"]).to eq resident.last_name + " " + resident.first_name
        expect(res["first_name"]).to eq resident.first_name
        expect(res["last_name"]).to eq resident.last_name
        expect(res["is_hospitalized"]).to eq resident.is_hospitalized
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /api/v1/residents" do
    subject { post(api_v1_residents_path, params: params, headers: headers) }

    let(:resident) { create(:resident) }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }
    let(:tenant) {create(:tenant, company_id: current_user.company_id)}
    let(:params) { { resident: attributes_for(:resident, tenant_id: tenant.id ) } }

    it "current_userに紐付いたできる" do
      expect { subject }.to change { tenant.residents.count }.by(1)
      res = JSON.parse(response.body)
      expect(res.keys).to eq ["id", "care_level", "full_name", "first_name", "last_name", "is_hospitalized","tenant"]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PARCH/api/v1/residents" do
    subject { patch(api_v1_resident_path(resident_id), params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:resident) { create(:resident) }
    let(:resident_id) { resident.id }
    let(:tenant) {create(:tenant, company_id: current_user.company_id)}
    let(:headers) { current_user.create_new_auth_token }
    let(:params) { { resident: attributes_for(:resident, tenant_id: tenant.id) } }

    context "指定したidの施設が存在する場合" do
      it "施設情報の更新ができる" do
        expect { subject }.to change { resident.reload.first_name }.from(resident.first_name).to(params[:resident][:first_name])
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE/api/v1/residents" do
    subject { delete(api_v1_resident_path(resident_id), headers: headers) }

    let!(:resident) { create(:resident, tenant_id: tenant.id) }
    let(:tenant) {create(:tenant, company_id: current_user.company_id)}
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "指定したidの施設が存在する場合" do
      let(:resident_id) { resident.id }
      it "施設情報を削除することができる" do
        expect { subject }.to change { Resident.count }.by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidの施設が存在しない場合" do
      let(:resident_id) { 9999 }
      it "削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end