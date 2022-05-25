require "rails_helper"

RSpec.describe "Api::V1::TenantGroups", type: :request do
  describe "GET /api/v1/tenant_groups" do
    subject { get(api_v1_tenant_groups_path, headers: headers) }

    context "グループが存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      let!(:tenant_group1) { create(:tenant_group, company_id: current_user.company_id) }
      let!(:tenant_group2) { create(:tenant_group, company_id: current_user.company_id) }
      it "グループ一覧が作成できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 2
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/v1/tenant_groups/:id" do
    subject { get(api_v1_tenant_group_path(tenant_group_id), headers: headers) }

    context "指定したidのグループが存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      let(:tenant_group) { create(:tenant_group, company_id: current_user.company_id) }
      let(:tenant_group_id) { tenant_group.id }

      it "指定したグループが取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq tenant_group.id
        expect(res["name"]).to eq tenant_group.name
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /api/v1/tenant_groups" do
    subject { post(api_v1_tenant_groups_path, params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }
    let(:params) { { tenant_group: attributes_for(:tenant_group, company_id: current_user.company_id) } }

    it "current_userに紐付いたグループを作成できる" do
      expect { subject }.to change { current_user.company.tenant_groups.count }.by(1)
      res = JSON.parse(response.body)
      expect(res.keys).to eq ["id", "name"]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PARCH/api/v1/tenant_groups" do
    subject { patch(api_v1_tenant_group_path(tenant_group_id), params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:tenant_group) { create(:tenant_group, company_id: current_user.company_id) }
    let(:tenant_group_id) { tenant_group.id }
    let(:headers) { current_user.create_new_auth_token }
    let(:params) { { tenant_group: attributes_for(:tenant_group, company_id: current_user.company_id) } }

    context "指定したidのグループが存在する場合" do
      it "グループの更新ができる" do
        expect { subject }.to change { tenant_group.reload.name }.from(tenant_group.name).to(params[:tenant_group][:name])
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE/api/v1/tenant_groups" do
    subject { delete(api_v1_tenant_group_path(tenant_group_id), headers: headers) }

    let!(:tenant_group) { create(:tenant_group, company_id: current_user.company_id) }
    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    context "指定したidのグループが存在する場合" do
      let(:tenant_group_id) { tenant_group.id }
      it "グループを削除することができる" do
        expect { subject }.to change { TenantGroup.count }.by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidのグループが存在しない場合" do
      let(:tenant_group_id) { 9999 }
      it "削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
