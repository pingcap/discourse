# frozen_string_literal: true

class PostCustomField < ActiveRecord::Base
  belongs_to :post
end

# == Schema Information
#
# Table name: post_custom_fields
#
#  id             :bigint           not null, primary key
#  post_id        :integer          not null
#  name           :string(256)      not null
#  value          :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  left_value_200 :string(255)
#
# Indexes
#
#  idx_post_custom_fields_akismet                (post_id)
#  index_post_custom_fields_on_name_and_value    (name,left_value_200)
#  index_post_custom_fields_on_notice_args       (post_id) UNIQUE
#  index_post_custom_fields_on_notice_type       (post_id) UNIQUE
#  index_post_custom_fields_on_post_id           (post_id) UNIQUE
#  index_post_custom_fields_on_post_id_and_name  (post_id,name)
#  index_post_id_where_missing_uploads_ignored   (post_id) UNIQUE
#  post_custom_field_broken_images_idx           (post_id) UNIQUE
#  post_custom_field_downloaded_images_idx       (post_id) UNIQUE
#  post_custom_field_large_images_idx            (post_id) UNIQUE
#
