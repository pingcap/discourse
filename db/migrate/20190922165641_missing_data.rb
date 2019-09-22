class MissingData < ActiveRecord::Migration[5.2]
  def change
    SiteSetting.create!([
      {name: "uncategorized_category_id", data_type: 3, value: "1"},
      {name: "content_security_policy", data_type: 5, value: "t"},
      {name: "push_api_secret_key", data_type: 1, value: "011230f7d001125a86e60aa79264c5f8"},
      {name: "global_notice", data_type: 1, value: "Congratulations, you installed Discourse! Unfortunately, no administrator emails were defined during setup, so finalizing the configuration <a href='https://meta.discourse.org/t/create-admin-account-from-console/17274'>may be difficult</a>."},
      {name: "has_login_hint", data_type: 5, value: "t"},
      {name: "vapid_public_key", data_type: 1, value: "BH_wLCdeHqrBafV_iZHoOlymohs7hFULkRxF_jtxC-0oSD-2QwNhWC94pAg-WyxRjPdQxxApjaVA7PRUQpARzHQ="},
      {name: "vapid_private_key", data_type: 1, value: "Fgu1f0LHfXV-Bumpz5ax_-c_bnqVKhZZWy1dlCGLytU="},
      {name: "vapid_public_key_bytes", data_type: 1, value: "4|127|240|44|39|94|30|170|193|105|245|127|137|145|232|58|92|166|162|27|59|132|85|11|145|28|69|254|59|113|11|237|40|72|63|182|67|3|97|88|47|120|164|8|62|91|44|81|140|247|80|199|16|41|141|165|64|236|244|84|66|144|17|204|116"}
    ])
    Category.create!([
      {name: "Uncategorized", color: "0088CC", topic_id: nil, topic_count: 0, user_id: -1, topics_year: nil, topics_month: nil, topics_week: nil, slug: "uncategorized", description: "", text_color: "FFFFFF", read_restricted: false, auto_close_hours: nil, post_count: 0, latest_post_id: nil, latest_topic_id: nil, position: 0, parent_category_id: nil, posts_year: nil, posts_month: nil, posts_week: nil, email_in: nil, email_in_allow_strangers: false, topics_day: 0, posts_day: 0, allow_badges: true, name_lower: "uncategorized", auto_close_based_on_last_post: false, topic_template: nil, contains_messages: nil, sort_order: nil, sort_ascending: nil, uploaded_logo_id: nil, uploaded_background_id: nil, topic_featured_link_allowed: true, all_topics_wiki: false, show_subcategory_list: false, num_featured_topics: 3, default_view: nil, subcategory_list_style: "rows_with_featured_topics", default_top_period: "all", mailinglist_mirror: false, suppress_from_latest: false, minimum_required_tags: 0, navigate_to_first_post_after_read: false, search_priority: 0, allow_global_tags: false, reviewable_by_group_id: nil}
    ])
  end
end
