# frozen_string_literal: true
module Jobs

  class AsyncNewPostManager < Jobs::Base

    def execute(user, opts)
      Rails.logger.info "start async group msg"
      manager = NewPostManager.new(user, opts)
      manager.perform
      Rails.logger.info "finish async group msg"
    end
  end
end