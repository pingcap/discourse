# https://github.com/rails/rails/blob/5-2-stable/activerecord/lib/active_record/connection_adapters/abstract/database_statements.rb

require 'active_record/connection_adapters/abstract/database_statements.rb'


ActiveRecord::ConnectionAdapters::DatabaseStatements.class_eval do 
  def transaction(requires_new: nil, isolation: nil, joinable: true)
    if requires_new
      Rails.logger.warn "savepoint statement was used, but your db not support, ignored savepoint."
      Rails.logger.warn caller
      requires_new = nil
    end
    if !requires_new && current_transaction.joinable?
      if isolation
        raise ActiveRecord::TransactionIsolationError, "cannot set isolation when joining a transaction"
      end
      yield
    else
      transaction_manager.within_new_transaction(isolation: isolation, joinable: joinable) { yield }
    end
  rescue ActiveRecord::Rollback
    # rollbacks are silently swallowed
  end
end