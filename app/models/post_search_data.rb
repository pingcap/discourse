# frozen_string_literal: true

class PostSearchData < ActiveRecord::Base
  include HasSearchData
end

# == Schema Information
#
# Table name: post_search_data
#
#  post_id     :integer          not null, primary key
#  search_data :text(65535)
#  raw_data    :text(65535)
#  locale      :string(255)
#  version     :integer          default(0)
#
# Indexes
#
#  index_post_search_data_on_post_id_and_version_and_locale  (post_id,version,locale)
#
