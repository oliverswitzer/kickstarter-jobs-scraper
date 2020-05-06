require_relative '../../clients/jobs_page_scraper'
require_relative '../../clients/slack'
require_relative '../../persistence/models/job_listing'

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

        data.each do |title, location|
          JobListing.create(title: title, location: location, scraped_at: Time.now)
        end

        changeset = JobListing.changes_since_last_scrape

        slack_client.notify_of_changes(changeset) if changeset.has_changes?
      end

      private

      attr_reader :job_page_scraper, :slack_client
    end
  end
end