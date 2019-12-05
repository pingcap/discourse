# frozen_string_literal: true

class QuotedPost < ActiveRecord::Base
  belongs_to :post
  belongs_to :quoted_post, class_name: 'Post'

  # NOTE we already have a path that does this for topic links,
  #  however topic links exclude quotes and links within a topic
  #  we are double parsing this fragment, this may be worth optimising later
  def self.extract_from(post)

    doc = Nokogiri::HTML.fragment(post.cooked)

    uniq = {}

    doc.css("aside.quote[data-topic]").each do |a|
      topic_id = a['data-topic'].to_i
      post_number = a['data-post'].to_i

      next if topic_id == 0 || post_number == 0
      next if uniq[[topic_id, post_number]]
      next if post.topic_id == topic_id && post.post_number == post_number

      uniq[[topic_id, post_number]] = true
    end

    if uniq.length == 0
      DB.exec("DELETE FROM quoted_posts WHERE post_id = :post_id", post_id: post.id)
    else

      args = {
        post_id: post.id,
        topic_ids: uniq.keys.map(&:first),
        post_numbers: uniq.keys.map(&:second)
      }

      unnest = uniq.keys.map do |topic_id, post_number|
        %Q{
          SELECT #{topic_id} AS topic_id, #{post_number} AS post_number
        }
      end.join(" UNION ALL ")

      DB.exec(<<~SQL, args)
        INSERT INTO quoted_posts (post_id, quoted_post_id, created_at, updated_at)
        SELECT :post_id, p.id, current_timestamp, current_timestamp
        FROM posts p
        JOIN (
          #{unnest}
        ) X ON X.topic_id = p.topic_id AND X.post_number = p.post_number
        LEFT JOIN quoted_posts q on q.post_id = :post_id AND q.quoted_post_id = p.id
        WHERE q.id IS NULL
      SQL

      DB.exec(<<~SQL, args)
        DELETE quoted_posts FROM quoted_posts
               LEFT JOIN posts p1 ON p1.id = quoted_posts.quoted_post_id
               LEFT JOIN (
                 #{unnest}
               ) X on X.topic_id = p1.topic_id AND X.post_number = p1.post_number
               AND quoted_posts.post_id = :post_id AND X.topic_id IS NULL
      SQL
    end

    # simplest place to add this code
    reply_quoted = false

    if post.reply_to_post_number
      reply_post_id = Post.where(topic_id: post.topic_id, post_number: post.reply_to_post_number).pluck(:id).first
      reply_quoted = reply_post_id.present? && QuotedPost.where(post_id: post.id, quoted_post_id: reply_post_id).count > 0
    end

    if reply_quoted != post.reply_quoted
      post.update_columns(reply_quoted: reply_quoted)
    end

  end
end

# == Schema Information
#
# Table name: quoted_posts
#
#  id             :bigint           not null, primary key
#  post_id        :integer          not null
#  quoted_post_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_quoted_posts_on_post_id_and_quoted_post_id  (post_id,quoted_post_id) UNIQUE
#  index_quoted_posts_on_quoted_post_id_and_post_id  (quoted_post_id,post_id) UNIQUE
#
