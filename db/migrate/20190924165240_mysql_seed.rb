class MysqlSeed < ActiveRecord::Migration[5.2]
  def change
    return # tmp disable for import from pg
    execute(<<~SQL)
      INSERT INTO site_settings VALUES (1, 'uncategorized_category_id', 3, '1', '2019-09-24 13:50:22.550891', '2019-09-24 13:50:22.550891');
    SQL

    execute(<<~SQL)
      INSERT INTO site_settings VALUES (2, 'content_security_policy', 5, 't', '2019-09-24 13:50:34.957773', '2019-09-24 13:50:34.957773');
    SQL

    execute(<<~SQL)
      INSERT INTO site_settings VALUES (3, 'push_api_secret_key', 1, '034cbf5684ac2f4e77a61f4c92be1445', '2019-09-24 13:52:11.199873', '2019-09-24 13:52:11.199873');
    SQL

    execute(<<~SQL)
      INSERT INTO site_settings VALUES (4, 'global_notice', 1, 'Congratulations, you installed Discourse! Unfortunately, no administrator emails were defined during setup, so finalizing the configuration <a href=''https://meta.discourse.org/t/create-admin-account-from-console/17274''>may be difficult</a>.', '2019-09-24 13:52:12.081332', '2019-09-24 13:52:12.081332');
    SQL

    execute(<<~SQL)
      INSERT INTO site_settings VALUES (5, 'has_login_hint', 5, 't', '2019-09-24 13:52:12.109599', '2019-09-24 13:52:12.109599');
    SQL

    execute(<<~SQL)
      INSERT INTO site_settings VALUES (6, 'vapid_public_key', 1, 'BGC_LdZ-k_niJX2HoGDb8mF4hla5E8RFOd8RShwEhCYBzisWuwcISrbETU79j70dSdAX1eeyhARVVgcUsmfiCf8=', '2019-09-24 13:52:12.754333', '2019-09-24 13:52:12.754333');
    SQL

    execute(<<~SQL)
      INSERT INTO site_settings VALUES (7, 'vapid_private_key', 1, '8sdj9Uu9UP7n4e_2zkjWHM9dTrxAGf2zdq97xTCs_qM=', '2019-09-24 13:52:12.800699', '2019-09-24 13:52:12.800699');
    SQL

    execute(<<~SQL)
      INSERT INTO site_settings VALUES (8, 'vapid_public_key_bytes', 1, '4|96|191|45|214|126|147|249|226|37|125|135|160|96|219|242|97|120|134|86|185|19|196|69|57|223|17|74|28|4|132|38|1|206|43|22|187|7|8|74|182|196|77|78|253|143|189|29|73|208|23|213|231|178|132|4|85|86|7|20|178|103|226|9|255', '2019-09-24 13:52:12.821234', '2019-09-24 13:52:12.821234');
    SQL

    execute(<<~SQL)
      INSERT INTO categories(id,name,color,topic_id,topic_count,created_at,updated_at,user_id,topics_year,topics_month,topics_week,slug,description,text_color,read_restricted,auto_close_hours,post_count,latest_post_id,latest_topic_id,position,parent_category_id,posts_year,posts_month,posts_week,email_in,email_in_allow_strangers,topics_day,posts_day,allow_badges,name_lower,auto_close_based_on_last_post,topic_template,contains_messages,sort_order,sort_ascending,uploaded_logo_id,uploaded_background_id,topic_featured_link_allowed,all_topics_wiki,show_subcategory_list,num_featured_topics,default_view,subcategory_list_style,default_top_period,mailinglist_mirror,suppress_from_latest,minimum_required_tags,navigate_to_first_post_after_read,search_priority,allow_global_tags,reviewable_by_group_id) 
      VALUES (1, 'Uncategorized', '0088CC', NULL, 0, '2019-09-24 13:50:22.550891', '2019-09-24 13:50:22.550891', -1, NULL, NULL, NULL, 'uncategorized', '', 'FFFFFF', false, NULL, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, false, 0, 0, true, 'uncategorized', false, NULL, NULL, NULL, NULL, NULL, NULL, true, false, false, 3, NULL, 'rows_with_featured_topics', 'all', false, false, 0, false, 0, false, NULL);
    SQL
  end
end
