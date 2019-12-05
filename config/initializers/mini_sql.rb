MiniSql.enable_log = true if Rails.env.development?
MiniSql.logger = Logger.new($stdout)
