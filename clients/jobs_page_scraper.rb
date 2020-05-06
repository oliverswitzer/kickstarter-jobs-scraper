require 'open-uri'

module Clients
  class JobsPageScraper
    JOBS_PAGE_URL = 'https://www.kickstarter.com/jobs'

    def self.scrape
      document = Nokogiri::HTML(open(JOBS_PAGE_URL))

      document.css('.job-block').map do |job_listing|
        title = job_listing.css('.job-block__title').inner_text.strip
        location = job_listing.css('.job-block__location').inner_text.strip

        [title, location]
      end
    end
  end
end