# frozen_string_literal: true

module Jobs
  class RetroRecentTimeRead < Jobs::Onceoff
    def execute_onceoff(args)
      # update past records by evenly distributing total time reading among each post read
      sql = <<~SQL
        UPDATE user_visits uv 
               INNER JOIN user_stats us ON us.user_id = uv.user_id
               INNER JOIN (
                 SELECT user_id, 
                        SUM(posts_read) AS total_read 
                 FROM user_visits GROUP BY user_id
               ) AS sum_uv ON sum_uv.user_id = uv.user_id
        SET uv.time_read = (
          uv.posts_read 
          / cast(total_read AS decimal)
          * COALESCE(us.time_read, 0) 
        )
        WHERE us.posts_read_count > 0 AND uv.posts_read > 0
     SQL
      DB.exec(sql)
    end
  end
end
