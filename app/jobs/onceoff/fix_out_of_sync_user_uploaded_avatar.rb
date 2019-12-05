# frozen_string_literal: true

module Jobs
  class FixOutOfSyncUserUploadedAvatar < Jobs::Onceoff
    def execute_onceoff(args)
      DB.exec(<<~SQL)
      UPDATE users
      INNER JOIN (
        SELECT
          u.id AS user_id,
          ua.gravatar_upload_id AS gravatar_upload_id
        FROM users u
        JOIN user_avatars ua ON ua.user_id = u.id
        LEFT JOIN uploads ON uploads.id = u.uploaded_avatar_id
        WHERE u.uploaded_avatar_id IS NOT NULL
        AND uploads.id IS NULL
      ) X ON users.id = X.user_id AND coalesce(uploaded_avatar_id,-1) <> coalesce(X.gravatar_upload_id,-1)
      SET uploaded_avatar_id = X.gravatar_upload_id
      SQL
    end
  end
end
