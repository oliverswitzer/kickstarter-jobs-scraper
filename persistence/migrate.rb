require 'active_record'
require_relative 'db_connection'

class CreateJobPostingsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.string :location
      t.belongs_to :scrape_session

      t.index :title
    end
  end
end

class CreateScrapeSession < ActiveRecord::Migration[5.2]
  def change
    create_table :scrape_sessions do |t|
      t.timestamp :scraped_at

      t.index :scraped_at
    end
  end
end

#CreateScrapeSession.migrate(:up)