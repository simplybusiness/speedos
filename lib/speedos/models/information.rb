module Speedos
  class Information
    include Mongoid::Document

    embedded_in :record

    field :page_name,      type: String
    field :began_at,       type: Time
    field :finished_at,    type: Time
    field :total_duration, type: Integer

  end
end
