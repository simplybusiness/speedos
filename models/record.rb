module Speedos
  class Record
    include Mongoid::Document
    include Mongoid::Timestamps

    field :success, type: Boolean
    field :log

    scope :successful, ->() { where(success: true) }

    def entries
      self.log['entries']
    end

    def pages
      self.log['pages'].reject{ |p| p['id'].empty? }.map{ |p| page(p['id']) }
    end

    def page name
      Entries.new(entries.select{ |p| p["pageref"] == name })
    end

    def self.report
      Record.successful.all.each do |record|
        puts record.id
        record.pages.each do |page|
          puts "  %-30s %ss" % [page.all_names.first, (page.total_load_time / 1000).round(5)]
        end
      end
    end
  end
end
