# frozen_string_literal: true

class UserSearchData < ActiveRecord::Base
  include HasSearchData
end

# == Schema Information
#
# Table name: user_search_data
#
#  user_id     :integer          not null, primary key
#  search_data :text(65535)
#  raw_data    :text(65535)
#  locale      :text(65535)
#  version     :integer          default(0)
#
