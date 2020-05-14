require_relative './application_record'

class JobListing < ApplicationRecord
  belongs_to :scrape_session

  def to_diffable
    JobListing::Data.new(title, location)
  end

  Data = Struct.new(:title, :location) do
    def to_s
      "#{title}, #{location}"
    end
  end
end