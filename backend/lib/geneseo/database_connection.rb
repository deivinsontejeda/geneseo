require 'active_record'
require 'erb'

module Geneseo
  module DatabaseConnection
    class << self
      def connect(environment = 'development')
        dbconfig = load_config
        ActiveRecord::Base.establish_connection(dbconfig[environment])
      end

      def load_config
        file_path = File.expand_path('../../../../config/database.yml', __FILE__)
        YAML.load(ERB.new(File.read(file_path)).result)
      end
    end
  end
end

ENV['APP_ENV'] ||= Geneseo.env
Geneseo::DatabaseConnection.connect ENV['APP_ENV']
# ActiveRecord::Base.logger = Logger.new('tmp/active_record.log')
