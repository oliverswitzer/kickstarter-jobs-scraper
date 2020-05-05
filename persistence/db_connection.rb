require 'erb'

db_config_file = File.read('persistence/db_config.yml')
db_config = YAML.load(ERB.new(db_config_file).result)

ActiveRecord::Base.establish_connection(db_config)
