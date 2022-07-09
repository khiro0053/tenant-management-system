require "rails_helper"

RSpec.describe "Api::V1::Rooms", type: :request do
  describe "GET /api/v1/rooms" do
    subject { get(api_v1_rooms_path, headers: headers) }

    context "部屋が存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      #let(:params) { { room: attributes_for(:room, tenant_id: tenant.id ) } }
      let(:tenant) {create(:tenant, company_id: current_user.company_id)}
      let!(:room1) { create(:room, tenant_id: tenant.id) }
      let!(:room2) { create(:room, tenant_id: tenant.id) }

      it "部屋一覧が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 2
        expect(res[0].keys).to eq ["id", "name", "seating_capacity","tenant"]
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/v1/rooms/:id" do
    subject { get(api_v1_room_path(room_id), headers: headers) }

    context "指定したidの施設が存在する場合" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }
      let(:tenant) {create(:tenant, company_id: current_user.company_id)}
      let(:room) { create(:room, tenant_id: tenant.id) }
      let(:room_id) { room.id }

      it "指定した施設が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq room.id
        expect(res["name"]).to eq room.name
        expect(res["seating_capacity"]).to eq room.seating_capacity
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /api/v1/rooms" do
    subject { post(api_v1_rooms_path, params: params, headers: headers) }

    let(:room) { create(:room) }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }
    let(:tenant) {create(:tenant, company_id: current_user.company_id)}
    let(:params) { { room: attributes_for(:room, tenant_id: tenant.id ) } }

    it "current_userに紐付いた施設を作成できる" do
      expect { subject }.to change { tenant.rooms.count }.by(1)
      res = JSON.parse(response.body)
      expect(res.keys).to eq ["id", "name", "seating_capacity","tenant" ]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PARCH/api/v1/rooms" do
    subject { patch(api_v1_room_path(room_id), params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:room) { create(:room) }
    let(:room_id) { room.id }
    let(:tenant) {create(:tenant, company_id: current_user.company_id)}
    let(:headers) { current_user.create_new_auth_token }
    let(:params) { { room: attributes_for(:room, tenant_id: tenant.id) } }

    context "指定したidの施設が存在する場合" do
      it "施設情報の更新ができる" do
        expect { subject }.to change { room.reload.name }.from(room.name).to(params[:room][:name])
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE/api/v1/rooms" do
    subject { delete(api_v1_room_path(room_id), headers: headers) }

    let!(:room) { create(:room, tenant_id: tenant.id) }
    let(:tenant) {create(:tenant, company_id: current_user.company_id)}
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "指定したidの施設が存在する場合" do
      let(:room_id) { room.id }
      it "施設情報を削除することができる" do
        expect { subject }.to change { Room.count }.by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidの施設が存在しない場合" do
      let(:room_id) { 9999 }
      it "削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
