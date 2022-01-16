require "rails_helper"

RSpec.describe "Api::V1::TenantGroups", type: :request do
  describe "GET /api/v1/tenant_group_groups" do
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
end
