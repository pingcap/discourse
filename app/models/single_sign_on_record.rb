# frozen_string_literal: true

class SingleSignOnRecord < ActiveRecord::Base
  belongs_to :user

  validates :external_id, uniqueness: true
end

# == Schema Information
#
# Table name: single_sign_on_records
#
#  id                              :bigint           not null, primary key
#  user_id                         :integer          not null
#  external_id                     :string(255)      not null
#  last_payload                    :text(65535)      not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  external_username               :string(255)
#  external_email                  :string(255)
#  external_name                   :string(255)
#  external_avatar_url             :string(1000)
#  external_profile_background_url :string(255)
#  external_card_background_url    :string(255)
#
# Indexes
#
#  index_single_sign_on_records_on_external_id  (external_id) UNIQUE
#  index_single_sign_on_records_on_user_id      (user_id)
#
