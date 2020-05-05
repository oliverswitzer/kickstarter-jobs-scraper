require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require_relative 'models/job_listing'

class KickstarterJobsScraper < Kimurai::Base
  @name = 'KickstarterJobsScraper'
  @engine = :mechanize
  @start_urls = ['https://www.kickstarter.com/jobs']
  @config = {
    user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36'
  }

  def parse(response, url:, data: {})
    response.css('.job-block').each do |job_listing|
      title = job_listing.css('.job-block__title').inner_text.strip
      location = job_listing.css('.job-block__location').inner_text.strip

      JobListing.create(title: title, location: location)
    end
  end
end