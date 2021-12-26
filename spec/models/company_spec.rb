# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Company, type: :model do
  describe "正常系" do
    context "会社名が入力されている場合" do
      let(:company) { build(:company) }
      it "登録できる" do
        expect(company).to be_valid
      end
    end

    context "名前が３１文字以上の場合" do
      let(:company) { build(:company, name: "x" * 31) }
      it "登録できない" do
        expect(company).not_to be_valid
        expect(company.errors.messages[:name]).to include(I18n.t('errors.messages.too_long', count: 30))
      end
    end
  end
end
