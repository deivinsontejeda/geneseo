$LOAD_PATH.unshift << File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift << File.expand_path('../../lib/', __FILE__)

require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'grape'
require 'pp'
require 'geneseo/exceptions'
require 'geneseo/logging'

module Geneseo
  def self.root
    File.expand_path('../../', __FILE__)
  end

  def self.env
    ENV.fetch('APP_ENV', 'development')
  end

  def self.logfile
    Geneseo.root + '/log/' + Geneseo.env + '.log'
  end

  def self.logger
    Geneseo::Logging.logger
  end

  def self.logger=(log)
    Geneseo::Logging.logger = log
  end

  def self.debugging?
    %w(development test).include?(Geneseo.env)
  end

  module Model
    autoload :Game, 'app/models/game'
    autoload :User, 'app/models/user'
  end

  module Service
  end

  module API
    autoload :Base,   'app/api/base'
    autoload :Status, 'app/api/status'

    module V1
      autoload :Defaults,             'app/api/v1/defaults'
      autoload :RescueExceptions,     'app/api/v1/rescue_exceptions'
      autoload :User,                 'app/api/v1/user'

      module Presenter
      end
    end
  end
end

# Initialize logger
# development log goes to STDOUT
if Geneseo.env == 'development' || ENV['LOGGER'] == 'debug'
  Geneseo.logger.level = Logger::DEBUG
elsif Geneseo.env != 'test'
  Geneseo::Logging.initialize_logger(Geneseo.logfile)
  loglevel = ENV.fetch('LOGGER', 'info')
  Geneseo.logger.level = loglevel == 'info' ? Logger::INFO : Logger::DEBUG
end

I18n.enforce_available_locales = true
I18n.load_path = Dir[File.expand_path('../../config/locales/**/*.yml', __FILE__)]
I18n.backend.load_translations

Dir[File.expand_path('lib/geneseo/*.rb')].each { |f| require f }
