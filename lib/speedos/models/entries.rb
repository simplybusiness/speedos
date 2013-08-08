module Speedos
  class Entries
    attr_reader :raw

    def initialize array
      @raw = array
    end

    def total_load_time
      earliest_start_time = nil
      latest_end_time     = nil
      @raw.each do |e|
        start_time = Time.parse(e["startedDateTime"]).to_f * 1000
        end_time   = start_time + e["time"]
        earliest_start_time = start_time if !earliest_start_time || earliest_start_time > start_time
        latest_end_time     = end_time   if !latest_end_time || latest_end_time < end_time
      end
      (latest_end_time && earliest_start_time) ? (latest_end_time - earliest_start_time) : 0
    end

    def name
      raw.map{|e| e['pageref']}.uniq.first
    end

    def inspect
      "Entries: #{name}"
    end
  end
end
