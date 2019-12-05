# frozen_string_literal: true

class UserAuthTokenLog < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: user_auth_token_logs
#
#  id                 :bigint           not null, primary key
#  action             :string(255)      not null
#  user_auth_token_id :integer
#  user_id            :integer
#  client_ip          :string(255)
#  user_agent         :string(255)
#  auth_token         :string(255)
#  created_at         :datetime
#  path               :string(255)
#
# Indexes
#
#  index_user_auth_token_logs_on_user_id  (user_id)
#
