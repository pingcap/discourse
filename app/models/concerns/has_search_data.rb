# frozen_string_literal: true

module HasSearchData
  extend ActiveSupport::Concern

  included do
    _associated_record_name = self.name.sub('SearchData', '').underscore
    self.primary_key = "#{_associated_record_name}_id"
    belongs_to _associated_record_name.to_sym
    validates_presence_of :search_data
    searchkick language: 'chinese'
    def search_data
      {
        search_data: read_attribute(:search_data)
      }
    end

    # The length of a single piece of data allowed by ElasticSearch is 32766 bytes
    # Just skip the big post
    def should_index?
      search_data.to_s.bytes.size < 32766
    end

  end
end
