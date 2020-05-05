require 'active_record'
require_relative '../db_connection'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end