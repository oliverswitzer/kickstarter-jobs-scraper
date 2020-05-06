require 'rubygems'
require 'bundler/setup'
require 'dotenv'

Bundler.require(:default)
Dotenv.load!

require_relative 'persistence/models/job_listing'

class KickstarterJobsScraper < Kimurai::Base
  SCRAPE_INTERVAL = 24.hours

  @name = 'KickstarterJobsScraper'
  @engine = :mechanize
  @start_urls = ['https://www.kickstarter.com/jobs']
  @config = {
    user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36'
  }

  def parse(response, url:, data: {})
    response.css('.job-block').map do |job_listing|
      title = job_listing.css('.job-block__title').inner_text.strip
      location = job_listing.css('.job-block__location').inner_text.strip

      JobListing.create(title: title, location: location, scraped_at: Time.now)
    end

    changeset = JobListing.changes_since_last_scrape
    puts changeset.to_s

    if changeset.has_changes?
      message = ""

      message << ":rolled_up_newspaper: Heads up, it looks like changes have been made to the Kickstarter jobs page\n"
      if changeset.added.present?
        message << "*New job listings:*\n"
        message << changeset.added.map(&:to_s).map { |listing| ":heavy_plus_sign: #{listing}"}.join("\n")
      end
      if changeset.removed.present?
        message << "*Removed job listings:*\n"

        message << changeset.removed.map(&:to_s).map { |listing| ":heavy_minus_sign: #{listing}"}.join("\n") if changeset.removed.present?
      end

      message << "\nAre any of these titles relevant to you? If so, you should reach out the the Kickstarter Union bargaining unit about utilizing your recall rights"

      slack_client.chat_postMessage(channel: '#balloon-bot-qa', text: message)
    end
  end

  def slack_client
    @slack_client ||= Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])
  end
end