require_relative '../../clients/jobs_page_scraper'
require_relative '../../clients/slack'
require_relative '../../persistence/models/job_listing'
require_relative '../../persistence/models/scrape_session'

module Core
  module UseCases
    class ScrapeAndPostChanges
      SCRAPE_INTERVAL = 24.hours

      def initialize(
        job_page_scraper: Clients::JobsPageScraper,
        slack_client: Clients::Slack.new
      )
        @job_page_scraper = job_page_scraper
        @slack_client = slack_client
      end

      def execute
        data = job_page_scraper.scrape

        scrape_session = ScrapeSession.new(scraped_at: Time.now)
        data.each do |title, location|
          scrape_session.job_listings << JobListing.new(title: title, location: location)
        end

        changeset = ScrapeSession.changes_since_last_scrape(scrape_session)

        slack_client.notify_of_changes(changeset) if changeset.has_changes?

        scrape_session.save
      end

      private

      attr_reader :job_page_scraper, :slack_client
    end
  end
end