# frozen_string_literal: true

class TagSearchData < ActiveRecord::Base
  include HasSearchData
end

# == Schema Information
#
# Table name: tag_search_data
#
#  tag_id      :bigint           not null, primary key
#  search_data :text(65535)
#  raw_data    :text(65535)
#  locale      :text(65535)
#  version     :integer          default(0)
#
