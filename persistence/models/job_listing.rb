require_relative './application_record'
require_relative '../../lib/differ'

class JobListing < ApplicationRecord
  JobListingData = Struct.new(:title, :location) do
    def to_s
      "#{title}, #{location}"
    end
  end

  scope :yesterdays_listings, -> do
    where('scraped_at > ?', (KickstarterJobsScraper::SCRAPE_INTERVAL + 1.hour).ago)
      .where('scraped_at < ?', (KickstarterJobsScraper::SCRAPE_INTERVAL - 1.hour).ago)
  end

  scope :todays_listings, -> do
    where('scraped_at > ?', (KickstarterJobsScraper::SCRAPE_INTERVAL - 1.hour).ago)
  end

  def to_diffable
    JobListingData.new(title, location)
  end

  def self.changes_since_last_scrape
    Differ.find_difference(
      yesterdays_listings.map(&:to_diffable).to_set,
      todays_listings.map(&:to_diffable).to_set
    )
  end
end