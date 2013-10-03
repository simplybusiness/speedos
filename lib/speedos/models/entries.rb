module Speedos
  class Entries
    attr_reader :raw

    def initialize array
      @raw = array
    end

    def total_load_time
      (latest_end_time && earliest_start_time) ? (latest_end_time - earliest_start_time) * 1000 : 0
    end

    def name
      raw.map{|e| e['pageref']}.uniq.first
    end

    def inspect
      "Entries: #{name}"
    end

    def earliest_start_time
      @earliest_start_time ||= begin
        get_earliest_start_time_latest_end_time
        earliest_start_time
      end
    end

    def latest_end_time
      @latest_end_time ||= begin
        get_earliest_start_time_latest_end_time
        latest_end_time
      end
    end

    private
    def get_earliest_start_time_latest_end_time
      raw.each do |e|
        start_time = Time.parse(e["startedDateTime"])
        end_time   = Time.at(start_time.to_f + (e["time"].to_f / 1000))
        @earliest_start_time = start_time if !@earliest_start_time || @earliest_start_time > start_time
        @latest_end_time     = end_time   if !@latest_end_time || @latest_end_time < end_time
      end
    end
  end
end
