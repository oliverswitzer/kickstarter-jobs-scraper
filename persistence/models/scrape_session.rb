require_relative './application_record'
require_relative '../../lib/differ'

class ScrapeSession < ApplicationRecord
  has_many :job_listings, autosave: true, dependent: :destroy

  def self.changes_since_last_scrape(current_scrape_session)
    return Changeset.new(added: current_scrape_session.job_listings.map(&:to_diffable), removed: []) if last.nil?

    Differ.find_difference(
      last.job_listings.map(&:to_diffable).to_set,
      current_scrape_session.job_listings.map(&:to_diffable).to_set
    )
  end
end