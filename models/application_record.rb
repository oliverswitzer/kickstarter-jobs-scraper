require 'active_record'

db_config_file = File.open('db_config.yml')
db_config = YAML::load(db_config_file)
puts db_config

ActiveRecord::Base.establish_connection(db_config)

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end