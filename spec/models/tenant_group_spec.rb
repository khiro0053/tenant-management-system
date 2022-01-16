# == Schema Information
#
# Table name: tenant_groups
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#
# Indexes
#
#  index_tenant_groups_on_company_id  (company_id)
#  index_tenant_groups_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
require "rails_helper"

RSpec.describe TenantGroup, type: :model do
  describe "正常系" do
    context "名前が入力されている場合" do
      let(:tenant_group) { build(:tenant_group) }
      it "登録できる" do
        expect(tenant_group).to be_valid
      end
    end
  end

  describe "エラーチェック" do
    context "名前が重複している場合" do
      before { create(:tenant_group, name: "群馬") }

      let(:tenant_group2) { build(:tenant_group, name: "群馬") }
      it "登録できない" do
        expect(tenant_group2).not_to be_valid
        expect(tenant_group2.errors.messages[:name]).to include(I18n.t("errors.messages.taken"))
      end
    end

    context "名前が３１文字以上の場合" do
      let(:tenant_group) { build(:tenant_group, name: "x" * 31) }
      it "登録できない" do
        expect(tenant_group).not_to be_valid
        expect(tenant_group.errors.messages[:name]).to include(I18n.t("errors.messages.too_long", count: 30))
      end
    end
  end
end
