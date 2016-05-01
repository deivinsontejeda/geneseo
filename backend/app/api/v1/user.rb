require 'geneseo'

module Geneseo
  module API
    module V1
      class User < Grape::API
        include API::V1::Defaults

        resources :users do
          get '/:id' do
            Model::User.find(params[:id])
          end
        end
      end
    end
  end
end
