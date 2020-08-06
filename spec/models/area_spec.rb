# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Area, type: :model do
  describe "正常系" do
    context "名前が入力されている場合" do
      let(:area) { build(:area) }
      it "登録できる"do
        expect(area).to be_valid
      end
    end
  end

  describe "エラーチェック" do
    context "名前が重複している場合" do
      before { create(:area, name: "群馬") }
      let(:area2) { build(:area, name: "群馬") }
      it "登録できない"do
        expect(area2).not_to be_valid
        expect(area2.errors.messages[:name]).to include "has already been taken"
      end
    end

    context "名前が３１文字以上の場合" do
      let(:area) { build(:area, name: "x"*31 ) }
      it "登録できない"do
        expect(area).not_to be_valid
        expect(area.errors.messages[:name]).to include "is too long (maximum is 30 characters)"
      end
    end
  end

end
