# frozen_string_literal: true

class UpdateInvitesRedemptionCount < ActiveRecord::Migration[6.0]
  def change
    execute <<~SQL
      WITH invite_counts AS (
        SELECT invite_id, COUNT(*) count
        FROM invited_users
        GROUP BY invite_id
      )
      UPDATE invites
      INNER JOIN invite_counts ON invites.id = invite_counts.invite_id
      SET redemption_count = GREATEST(redemption_count, count)
      WHERE invites.id = invite_counts.invite_id
    SQL
  end
end
