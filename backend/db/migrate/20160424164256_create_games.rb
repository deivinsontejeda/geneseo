class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer  'player1_id'
      t.string   'player1_name'
      t.integer  'player2_id'
      t.string   'player2_name'
      t.integer  'current_player'
      t.integer  'rows'
      t.integer  'columns'
      t.integer  'to_win'
      t.integer  'current_turn',   default: 1
      t.boolean  'game_started',   default: false
      t.boolean  'game_over',      default: false
      t.string   'board'
      t.timestamps null: false
    end
  end
end
