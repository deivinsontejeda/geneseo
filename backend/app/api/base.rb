require 'app/api/v1/base'

module Geneseo
  module API
    class Base < Grape::API
      mount API::V1::Base
      mount API::Status
    end
  end
end
