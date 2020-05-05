require 'active_record'
require_relative 'db_connection'

class CreateJobPostingsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.string :location
      t.timestamps
    end
  end
end

CreateJobPostingsTable.migrate(:up)