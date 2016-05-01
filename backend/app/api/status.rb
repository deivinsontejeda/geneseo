module Geneseo
  module API
    class Status < Grape::API
      default_format :json
      format :json

      REVISION_FILE = Geneseo.root + '/REVISION'

      get :ping do
        time = Time.now.getutc.strftime('%Y-%m-%dT%H:%M:%S%z')
        json = { status: 'OK', time: time }

        if File.exist?(REVISION_FILE)
          json[:sha] = File.read(REVISION_FILE).strip
        end

        json
      end
    end
  end
end
