# frozen_string_literal: true

module Jobs

  class EnqueueDigestEmails < ::Jobs::Scheduled
    every 30.minutes

    def execute(args)
      return if SiteSetting.disable_digest_emails? || SiteSetting.private_email? || SiteSetting.disable_emails == 'yes'
      users = target_user_ids

      users.each do |user_id|
        ::Jobs.enqueue(:user_email, type: :digest, user_id: user_id)
      end
    end

    def target_user_ids
      # Users who want to receive digest email within their chosen digest email frequency
      query = User
        .real
        .activated
        .not_suspended
        .where(staged: false)
        .joins(:user_option, :user_stat, :user_emails)
        .where("user_options.email_digests")
        .where("user_stats.bounce_score < #{SiteSetting.bounce_score_threshold}")
        .where("user_emails.`primary`")
        .where("COALESCE(last_emailed_at, '2010-01-01') <= CURRENT_TIMESTAMP - INTERVAL (1 * user_options.digest_after_minutes) MINUTE")
        .where("COALESCE(user_stats.digest_attempted_at, '2010-01-01') <= CURRENT_TIMESTAMP - INTERVAL (1 * user_options.digest_after_minutes) MINUTE")
        .where("COALESCE(last_seen_at, '2010-01-01') <= CURRENT_TIMESTAMP - INTERVAL (1 * user_options.digest_after_minutes) MINUTE")
        .where("COALESCE(last_seen_at, '2010-01-01') >= CURRENT_TIMESTAMP - INTERVAL (1 * #{SiteSetting.suppress_digest_email_after_days}) DAY")
        .order("user_stats.digest_attempted_at ASC")

      # If the site requires approval, make sure the user is approved
      query = query.where("approved OR moderator OR admin") if SiteSetting.must_approve_users?

      query = query.limit(GlobalSetting.max_digests_enqueued_per_30_mins_per_site)

      query.pluck(:id)
    end

  end

end
