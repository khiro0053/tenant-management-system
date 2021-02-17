# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  name                   :string(255)
#  password               :string(255)
#  provider               :string(255)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  tokens                 :text(65535)
#  uid                    :string(255)      default(""), not null
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: Random.new.rand(2..50)) }
    sequence(:email) {|n| "#{n}_#{Faker::Internet.email}" }
    # Fakerで生成したパスワードでは半角大文字、小文字、数字それぞれ一文字ずつの条件を満たせないことがあるため先頭に”Aa1”をつけた
    password { "Aa1" + Faker::Internet.password(min_length: 5, max_length: 29, mix_case: true, special_characters: true) }
    company
  end
end
