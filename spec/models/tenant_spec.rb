# == Schema Information
#
# Table name: tenants
#
#  id                         :bigint           not null, primary key
#  capacity                   :integer
#  name                       :string(255)
#  target_number_of_residents :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  area_id                    :bigint
#
# Indexes
#
#  index_tenants_on_area_id  (area_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
require "rails_helper"

RSpec.describe Tenant, type: :model do
  describe "正常系" do
    context "nameとcapacityが設定されている場合" do
      let(:tenant) { build(:tenant) }
      it "施設が作成できる" do
        expect(tenant).to be_valid
      end
    end
  end

  describe "エラーチェック" do
    context "施設名が存在しない場合" do
      let(:tenant) { build(:tenant, name: nil) }
      it "施設が作成できない" do
        expect(tenant).not_to be_valid
        expect(tenant.errors.messages[:name]).to include "can't be blank"
      end
    end

    context "施設名が51文字以上の場合" do
      let(:tenant) { build(:tenant, name: Faker::Lorem.characters(number: 51)) }
      it "施設が作成できない" do
        expect(tenant).not_to be_valid
        expect(tenant.errors.messages[:name]).to include "is too long (maximum is 50 characters)"
      end
    end

    context "定員が存在しない場合" do
      let(:tenant) { build(:tenant, capacity: nil) }
      it "施設が作成できない" do
        expect(tenant).not_to be_valid
        expect(tenant.errors.messages[:capacity]).to include "can't be blank"
      end
    end

    context "目標数が定員を上回った場合" do
      let(:tenant) { build(:tenant, capacity: 10, target_number_of_residents: 50) }

      it "施設が作成できない" do
        expect(tenant).not_to be_valid
        expect(tenant.errors.messages[:target_number_of_residents]).to include "定員数を上回る目標は設定できません"
      end
    end
  end
end
