require "rails_helper"

RSpec.describe "Api::V1::Tenants", type: :request do
  describe "GET /api/v1/tenants" do
    subject { get(api_v1_tenants_path, headers: headers) }

    context "施設が存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      let!(:tenant1) { create(:tenant, company_id: current_user.company_id) }
      let!(:tenant2) { create(:tenant, company_id: current_user.company_id) }

      it "施設一覧が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 2
        expect(res[0].keys).to eq ["id", "name", "capacity", "target_number_of_residents", "tenant_group"]
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/v1/tenants/:id" do
    subject { get(api_v1_tenant_path(tenant_id), headers: headers) }

    context "指定したidの施設が存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      let(:tenant) { create(:tenant, company_id: current_user.company_id) }
      let(:tenant_id) { tenant.id }

      it "指定した施設が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq tenant.id
        expect(res["name"]).to eq tenant.name
        expect(res["target_number_of_residents"]).to eq tenant.target_number_of_residents
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /api/v1/tenants" do
    subject { post(api_v1_tenants_path, params: params, headers: headers) }

    let(:tenant_group) { create(:tenant_group) }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }
    let(:params) { { tenant: attributes_for(:tenant, company_id: current_user.company_id, tenant_group_id: tenant_group.id) } }

    it "current_userに紐付いた施設を作成できる" do
      expect { subject }.to change { current_user.company.tenants.count }.by(1)
      res = JSON.parse(response.body)
      expect(res.keys).to eq ["id", "name", "capacity", "target_number_of_residents", "tenant_group"]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PARCH/api/v1/tenants" do
    subject { patch(api_v1_tenant_path(tenant_id), params: params, headers: headers) }

    context "指定したidの施設が存在する場合" do
      let(:current_user) { create(:user) }
      let(:tenant) { create(:tenant, company_id: current_user.company_id) }
      let(:tenant_id) { tenant.id }
      let(:headers) { current_user.create_new_auth_token }
      let(:params) { { tenant: attributes_for(:tenant, company_id: current_user.company_id, tenant_group_id: tenant.tenant_group_id) } }
      it "施設情報の更新ができる" do
        expect { subject }.to change { tenant.reload.name }.from(tenant.name).to(params[:tenant][:name])
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE/api/v1/tenants" do
    subject { delete(api_v1_tenant_path(tenant_id), headers: headers) }

    let!(:tenant) { create(:tenant, company_id: current_user.company_id) }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "指定したidの施設が存在する場合" do
      let(:tenant_id) { tenant.id }
      it "施設情報を削除することができる" do
        expect { subject }.to change { Tenant.count }.by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidの施設が存在しない場合" do
      let(:tenant_id) { 9999 }
      it "削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
