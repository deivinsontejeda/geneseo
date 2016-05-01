require 'geneseo'

module Geneseo
  module API
    module V1
      module Defaults
        extend ActiveSupport::Concern
        include V1::RescueExceptions

        included do
          version 'v1', using: :path
          format :json
          prefix 'api'

          helpers do
            def logger
              Geneseo.logger
            end
          end

          before do
            ActiveRecord::Base.connection_pool.connections.map(&:verify!)
          end

          after do
            ActiveRecord::Base.clear_active_connections!
          end
        end
      end
    end
  end
end
