# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)
#  password               :string(255)
#  provider               :string(255)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  tokens                 :text(65535)
#  uid                    :string(255)      default(""), not null
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: Random.new.rand(2..50)) }
    sequence(:email) {|n| "#{n}_#{Faker::Internet.email}" }
    # Fakerで生成したパスワードでは半角大文字、小文字、数字それぞれ一文字ずつの条件を満たせないことがあるため先頭に”Aa1”をつけた
    password { "Aa1" + Faker::Internet.password(min_length: 5, max_length: 29, mix_case: true, special_characters: true) }
  end
end
