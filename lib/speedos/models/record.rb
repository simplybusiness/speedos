module Speedos
  class Record
    include Mongoid::Document
    include Mongoid::Timestamps

    embeds_many :information

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

    def export_har filename
      File.open(filename, 'w') { |f| f.write({log: self.log}.to_json)}
    end

    def refresh_information
      information = self.information
      information.destroy_all
      self.pages.each do |page|
        information.create(
          :page_name      => page.name,
          :began_at       => page.earliest_start_time,
          :finished_at    => page.latest_end_time,
          :total_duration => page.total_load_time
        )
      end
    end
  end
end
