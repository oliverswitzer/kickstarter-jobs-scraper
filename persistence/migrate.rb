require 'active_record'
require_relative 'db_connection'

class CreateJobPostingsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.string :location
      t.timestamp :scraped_at
    end

    add_index :job_listings, :scraped_at
    add_index :job_listings, [:scraped_at, :title]
  end
end

def migrate
  CreateJobPostingsTable.check_pending!
rescue
  puts "Migrations are pending, running migrations"
  CreateJobPostingsTable.migrate(:up)
end

migrate
