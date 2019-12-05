# frozen_string_literal: true

class UserFieldOption < ActiveRecord::Base
end

# == Schema Information
#
# Table name: user_field_options
#
#  id            :bigint           not null, primary key
#  user_field_id :integer          not null
#  value         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
