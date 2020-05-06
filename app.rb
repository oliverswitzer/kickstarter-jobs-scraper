require 'rubygems'
require 'bundler/setup'
require 'dotenv'

Bundler.require(:default)
Dotenv.load! if ENV['RAILS_ENV'] != 'production'

require_relative 'core/use_cases/scrape_and_post_changes'

class App
  def self.run
    Core::UseCases::ScrapeAndPostChanges.new.execute
  end
end