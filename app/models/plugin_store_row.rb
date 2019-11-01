# frozen_string_literal: true

class PluginStoreRow < ActiveRecord::Base
end

# == Schema Information
#
# Table name: plugin_store_rows
#
#  id          :bigint           not null, primary key
#  plugin_name :string(255)      not null
#  key         :string(255)      not null
#  type_name   :string(255)      not null
#  value       :text(65535)
#
# Indexes
#
#  index_plugin_store_rows_on_plugin_name_and_key  (plugin_name,key) UNIQUE
#
