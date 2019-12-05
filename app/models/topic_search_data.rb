# frozen_string_literal: true

class TopicSearchData < ActiveRecord::Base
  include HasSearchData
end

# == Schema Information
#
# Table name: topic_search_data
#
#  topic_id    :bigint           not null, primary key
#  raw_data    :text(65535)
#  locale      :string(255)      not null
#  search_data :text(65535)
#  version     :integer          default(0)
#
# Indexes
#
#  index_topic_search_data_on_topic_id_and_version_and_locale  (topic_id,version,locale)
#
