# frozen_string_literal: true

class TopicCustomField < ActiveRecord::Base
  belongs_to :topic
end

# == Schema Information
#
# Table name: topic_custom_fields
#
#  id         :bigint           not null, primary key
#  topic_id   :integer          not null
#  name       :string(256)      not null
#  value      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topic_custom_fields_on_topic_id_and_name  (topic_id,name)
#
