# frozen_string_literal: true

class CategorySearchData < ActiveRecord::Base
  include HasSearchData
end

# == Schema Information
#
# Table name: category_search_data
#
#  category_id :integer          not null, primary key
#  search_data :text(65535)
#  raw_data    :text(65535)
#  locale      :text(65535)
#  version     :integer          default(0)
#
