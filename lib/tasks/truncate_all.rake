desc "Truncate All Exist Data"
task "truncate_all" => :environment do
  ActiveRecord::Base.establish_connection
  ActiveRecord::Base.connection.tables.each do |table|
    next if table == 'one_row_table'
    next if table == 'schema_migration_details'
    next if table == 'schema_migrations'
    next if table == 'ar_internal_metadata'

    case ActiveRecord::Base.connection.adapter_name.downcase.to_sym
      when :mysql2 || :postgresql
        puts "truncate #{table} ..."
        ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
      when :sqlite
        ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
    end
  end
end
