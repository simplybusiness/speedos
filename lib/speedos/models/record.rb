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

    def export_har filename
      File.open(filename, 'w') { |f| f.write({log: self.log}.to_json)}
    end
  end
end
