module EscapeLike
  extend ActiveSupport::Concern

  module ClassMethods
    def escape_like(str)
      '%' + ActiveRecord::Base.send(:sanitize_sql_like, str) + '%'
    end
  end
  extend ClassMethods
end