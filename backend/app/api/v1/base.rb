require 'grape-swagger'

module Geneseo
  module API
    module V1
      class Base < Grape::API
        default_format :json

        mount API::V1::User
        add_swagger_documentation(api_version: 'v1', mount_path: 'api/v1/swagger_doc')
      end
    end
  end
end
