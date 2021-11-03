# frozen_string_literal: true

class AddUserApiKeyScopes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_api_key_scopes do |t|
      t.integer :user_api_key_id, null: false
      t.string :name, null: false
      t.timestamps
    end

    add_index :user_api_key_scopes, :user_api_key_id

    reversible do |dir|
      dir.up do
        execute <<~SQL
          INSERT INTO user_api_key_scopes
          (
            user_api_key_id,
            name,
            created_at,
            updated_at
          )
          SELECT 
            t.id,  
            json_unquote(json_extract(t.scopes, concat('$[', n.i, ']'))) scope,
            t.created_at,
            t.updated_at
          FROM user_api_keys t 
               INNER JOIN (
                 SELECT 0 i 
                 union all 
                 SELECT 1 
                 union all 
                 SELECT 2
                ) n on n.i < json_length(t.scopes);
        SQL

        change_column_null :user_api_keys, :scopes, true
        change_column_default :user_api_keys, :scopes, nil
      end

      dir.down do
        change_column_null :user_api_keys, :scopes, false
        change_column_default :user_api_keys, :scopes, []
      end
    end
  end
end