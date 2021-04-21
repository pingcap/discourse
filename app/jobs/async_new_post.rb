class AsyncNewPost
  include Sidekiq::Worker

  def perform(user_id, opts)
    user = User.find(user_id)
    Rails.logger.info "start async group msg"
    manager = NewPostManager.new(user, opts)
    manager.perform
    Rails.logger.info "finish async group msg"
  end
end