require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

class KickstarterJobsScraper < Kimurai::Base
  @name = "KickstarterJobsScraper"
  @engine = :mechanize
  @start_urls = ["https://www.kickstarter.com/jobs"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36"
  }

  def parse(response, url:, data: {})
    jobs = response.xpath("//div[@class='job-block']").map do |job_div|
      job_div.inner_text
    end

    puts jobs
  end
end

KickstarterJobsScraper.crawl!