desc "seeed"
task "seeed" => :environment do
  ActiveRecord::Base.connection.execute("truncate site_settings;")
  ActiveRecord::Base.connection.execute("SET GLOBAL max_allowed_packet=1073741824;")
  STDOUT.sync = true
  Rails.application.config.active_record.belongs_to_required_by_default = false
  load "db/seeed.rb"
end