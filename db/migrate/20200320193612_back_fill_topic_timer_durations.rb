# frozen_string_literal: true

class BackFillTopicTimerDurations < ActiveRecord::Migration[6.0]
  def up
    DB.exec <<~SQL
      UPDATE topic_timers
      SET duration = 0
      WHERE duration IS NULL AND (execute_at IS NULL OR created_at IS NULL)
    SQL

    DB.exec <<~SQL
      UPDATE topic_timers
      SET duration = (UNIX_TIMESTAMP(execute_at) - UNIX_TIMESTAMP(created_at)) / 3600
      WHERE duration IS NULL AND execute_at IS NOT NULL AND created_at IS NOT NULL
    SQL
  end

  def down
  end
end
