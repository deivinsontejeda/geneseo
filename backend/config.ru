#!/usr/bin/ruby
require './lib/geneseo'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    # location of your API
    resource '/*', :headers => :any, :methods => [:get, :post, :options, :put]
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run Rack::URLMap.new('/' => Geneseo::API::Base)
