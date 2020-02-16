# frozen_string_literal: true

module Jobs

  class CleanUpCrawlerStats < Jobs::Scheduled
    every 1.day

    def execute(args)
      WebCrawlerRequest.where('date < ?', WebCrawlerRequest.max_record_age.ago).delete_all

      # keep count of only the top user agents
      DB.exec <<~SQL
        DELETE FROM web_crawler_requests
        WHERE id IN (
          SELECT ranked_requests.id
            FROM (
                  SELECT @r := @r + 1 as `row_number`, id
                    FROM web_crawler_requests, (SELECT @r := 0) t
                   WHERE date = '#{1.day.ago.strftime("%Y-%m-%d")}'
                ORDER BY count DESC
            ) ranked_requests
           WHERE `row_number` > #{WebCrawlerRequest.max_records_per_day}
        )
      SQL
    end
  end

end
