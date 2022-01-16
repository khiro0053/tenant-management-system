# == Schema Information
#
# Table name: rooms
#
#  id               :bigint           not null, primary key
#  name             :string(255)
#  seating_capacity :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tenant_id        :bigint
#
# Indexes
#
#  index_rooms_on_name       (name) UNIQUE
#  index_rooms_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
require "rails_helper"

RSpec.describe Room, type: :model do
  describe "正常系" do
    context "名前と部屋人数が設定されている場合" do
      let(:room) { build(:room) }
      it "部屋が作成できる" do
        expect(room).to be_valid
      end
    end
  end

  describe "エラーチェック" do
    context "名前がない場合" do
      let(:room) { build(:room, name: nil) }
      it "作成できない" do
        expect(room).not_to be_valid
        expect(room.errors.messages[:name][0]).to include(I18n.t("errors.messages.blank"))
      end
    end

    context "名前が21文字以上の場合" do
      let(:room) { build(:room, name: "x" * 21) }
      it "作成できない" do
        expect(room).not_to be_valid
        expect(room.errors.messages[:name][0]).to include(I18n.t("errors.messages.too_long", count: 20))
      end
    end

    context "部屋人数が設定せれていない場合" do
      let(:room) { build(:room, seating_capacity: nil) }
      it "作成できない" do
        expect(room).not_to be_valid
        expect(room.errors.messages[:seating_capacity]).to include(I18n.t("errors.messages.blank"))
      end
    end
  end
end
