require 'rails_helper'

RSpec.describe "Api::V1::Tenants", type: :request do
  describe "GET /api/v1/tenants" do
    subject { get(api_v1_tenants_path)}
    before { create_list(:tenant, 3) }
    it "施設一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "name", "target_number_of_residents","capacity","area"]
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /api/v1/tenants/:id" do
    subject { get(api_v1_tenant_path(tenant_id))}
    context "指定したidの施設が存在する場合" do
      let(:tenant) {create(:tenant)}
      let(:tenant_id) {tenant.id}
      it "指定した施設が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq tenant.id
        expect(res["name"]).to eq tenant.name
        expect(res["target_number_of_residents"]).to eq tenant.target_number_of_residents
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "POST /api/v1/tenants" do
    subject { post(api_v1_tenants_path, params: params)}

    let(:params) {{tenant: create(:tenant).attributes}}
    let(:current_user) {create(:user)}
    before { allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user) }

    it "current_userに紐付いた施設を作成できる" do
      expect { subject }.to change {current_user.tenants.count }.by(1)
      res = JSON.parse(response.body)
      expect(res.keys).to eq ["id", "name", "target_number_of_residents","capacity","area"]
      expect(response).to have_http_status(200)
    end
  end

  describe "PARCH/api/v1/tenants" do
    subject { patch(api_v1_tenant_path(tenant_id), params: params)}

    let(:params) {{tenant: create(:tenant).attributes}}
    let(:tenant) {create(:tenant)}
    let(:tenant_id) {tenant.id}
    let(:current_user) {create(:user)}

    before { allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user) }
    context "指定したidの施設が存在する場合" do
      it "施設情報の更新ができる" do
        expect { subject }.to change {tenant.reload.name}.from(tenant.name).to(params[:tenant]["name"])
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE/api/v1/tenants" do
    subject { delete(api_v1_tenant_path(tenant_id))}
    let!(:tenant) {create(:tenant)}
    let(:current_user) {create(:user)}

    before { allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user) }
    context "指定したidの施設が存在する場合" do
      let(:tenant_id) {tenant.id}
      it "施設情報を削除することができる" do
        expect { subject }.to change {Tenant.count }.by(-1)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end
    end
    context "指定したidの施設が存在しない場合" do
      let(:tenant_id) {9999}
      it "削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
