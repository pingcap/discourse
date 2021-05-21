class FakeEmailInterceptor
  def self.delivering_email(message)
    origin_to = message.to
    message.to = message.to.reject { |email| email.to_s =~ /fake.email/ }
    if message.to.blank?
      message.perform_deliveries = false
      Rails.logger.warn "rejected #{origin_to.to_s}"
    end
  end
end

ActionMailer::Base.register_interceptor(FakeEmailInterceptor)