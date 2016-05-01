module Geneseo
  module API
    module V1
      module RescueExceptions
        extend ActiveSupport::Concern

        included do
          rescue_from :all do |e|
            Geneseo.logger.error { "[INTERNAL] #{e.message}" }
            Geneseo.logger.debug { e.backtrace }
            response = {
              message: 'Internal Server Error',
              status: 500
            }
            Rack::Response.new(response.to_json, 500, 'Content-Type' => 'text/error').finish
          end

          rescue_from ActiveRecord::RecordNotFound do
            response = {
              message: 'Record not found',
              status: 404
            }
            Rack::Response.new(response.to_json, 404).finish
          end
        end
      end
    end
  end
end
