# frozen_string_literal: true

class InstagramUserInfo < ActiveRecord::Base

  belongs_to :user

end

# == Schema Information
#
# Table name: instagram_user_infos
#
#  id                :bigint           not null, primary key
#  user_id           :integer
#  screen_name       :string(255)
#  instagram_user_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
