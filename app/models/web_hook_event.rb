# frozen_string_literal: true

class WebHookEvent < ActiveRecord::Base
  belongs_to :web_hook

  after_save :update_web_hook_delivery_status

  default_scope { order('created_at DESC') }

  def self.purge_old
    where(
      'created_at < ?', SiteSetting.retain_web_hook_events_period_days.days.ago
    ).delete_all
  end

  def update_web_hook_delivery_status
    web_hook.last_delivery_status =
      case status
      when 200..299
        WebHook.last_delivery_statuses[:successful]
      else
        WebHook.last_delivery_statuses[:failed]
      end
    web_hook.save!
  end
end

# == Schema Information
#
# Table name: web_hook_events
#
#  id               :bigint           not null, primary key
#  web_hook_id      :integer          not null
#  headers          :string(255)
#  payload          :text(65535)
#  status           :integer          default(0)
#  response_headers :string(255)
#  response_body    :text(65535)
#  duration         :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_web_hook_events_on_web_hook_id  (web_hook_id)
#
