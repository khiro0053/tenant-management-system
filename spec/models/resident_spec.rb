# == Schema Information
#
# Table name: residents
#
#  id              :bigint           not null, primary key
#  care_level      :string(255)      default("jiritu")
#  first_name      :string(255)
#  is_hospitalized :boolean          default(FALSE), not null
#  last_name       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tenant_id       :bigint
#
# Indexes
#
#  index_residents_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
require "rails_helper"

RSpec.describe Resident, type: :model do
  describe "正常系" do
    context "名字と名前が設定されている場合" do
      let(:resident) { build(:resident) }
      it "登録ができる" do
        expect(resident).to be_valid
      end
    end
  end

  describe "エラーチェック" do
    context "名前が設定されていない場合" do
      let(:resident) { build(:resident, first_name: nil) }
      it "登録ができない" do
        expect(resident).not_to be_valid
        expect(resident.errors.messages[:first_name]).to include "can't be blank"
      end
    end

    context "名前が長すぎる場合" do
      let(:resident) { build(:resident, first_name: "x" * 21) }
      it "登録ができない" do
        expect(resident).not_to be_valid
        expect(resident.errors.messages[:first_name]).to include "is too long (maximum is 20 characters)"
      end
    end

    context "名字が設定されていない場合" do
      let(:resident) { build(:resident, last_name: nil) }
      it "登録ができない" do
        expect(resident).not_to be_valid
        expect(resident.errors.messages[:last_name]).to include "can't be blank"
      end
    end

    context "名字が長すぎる場合" do
      let(:resident) { build(:resident, last_name: "x" * 21) }
      it "登録ができない" do
        expect(resident).not_to be_valid
        expect(resident.errors.messages[:last_name]).to include "is too long (maximum is 20 characters)"
      end
    end
  end
end
