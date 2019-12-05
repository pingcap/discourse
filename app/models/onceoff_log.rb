# frozen_string_literal: true

class OnceoffLog < ActiveRecord::Base
end

# == Schema Information
#
# Table name: onceoff_logs
#
#  id         :bigint           not null, primary key
#  job_name   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_onceoff_logs_on_job_name  (job_name)
#
