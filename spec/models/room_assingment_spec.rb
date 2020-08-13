# == Schema Information
#
# Table name: room_assingments
#
#  id          :bigint           not null, primary key
#  date_from   :date
#  date_to     :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resident_id :bigint
#  room_id     :bigint
#
# Indexes
#
#  index_room_assingments_on_resident_id  (resident_id)
#  index_room_assingments_on_room_id      (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (resident_id => residents.id)
#  fk_rails_...  (room_id => rooms.id)
#
require "rails_helper"

RSpec.describe RoomAssingment, type: :model do
  describe "正常系" do
    context "契約開始日のみ入力されている場合" do
      let(:room_assingment) { build(:room_assingment) }
      it "登録ができる" do
        expect(room_assingment).to be_valid
      end
    end
    context "契約開始日・契約終了日が入力されている場合" do
      let(:room_assingment) { build(:room_assingment, date_to: "2020-07-19") }
      it "登録ができる" do
        expect(room_assingment).to be_valid
      end
    end
  end
  describe "エラーチェック" do
    context "契約開始日より前に契約終了日が入力されている場合" do
      let(:room_assingment) { build(:room_assingment, date_to: "1900-01-01") }
      it "登録ができない" do
        expect(room_assingment).not_to be_valid
        expect(room_assingment.errors.messages[:date_to]).to include "契約開始日より前の日付は入力できません。"
      end
    end
  end
end
