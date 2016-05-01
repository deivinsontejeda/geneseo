module Geneseo
  module Model
    class User < ActiveRecord::Base
      has_many :games, foreign_key: 'player1_id'
      has_many :games, foreign_key: 'player2_id'
    end
  end
end
